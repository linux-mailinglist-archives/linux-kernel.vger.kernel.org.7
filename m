Return-Path: <linux-kernel+bounces-784469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C21EB33C48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4893AEC39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2852D9EC9;
	Mon, 25 Aug 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyE9hXPD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47312221726
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116780; cv=none; b=i4vE8cBHATB19FeTPHOo1mVqupd73FNK9Uxl6MmT9IXTFcb2buChTXzDMv6Lhv0TfWzpguP0cMpgh7XKuQQIYKmALPk8iht64jYu2RcRDBQHjmQerONP6FlP9I1sCupJlnw/3MbQtFK9EijjBAXRV/mPdfrlkmXPoebpcwjApDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116780; c=relaxed/simple;
	bh=wv/ZVC0xhYK+uN9b1nZrElPQ9dihsNWNmCovyBsdd1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRDMeiYYjhd4m32ywNcqYQsyWXClvAWsqwgtvcS7PsUBGttNfilrUStPRTrnPFJEmNqJxjUIlJnHXD5r3e7mDwGzVQ7ygejQRDU6TRvfZm4rFgsV30NiWi/MZeMSdmDhX1knCDmExBQ2k4njTQxGhMPXt2cgvl9KxLLfAWal1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyE9hXPD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8W7sq025970
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=moxinys5s3N9BtVwh8XnRm+TEdKWfPUaqsg
	2wBZXC6A=; b=lyE9hXPDjc4qHB3aMZwvc4HZ8x7qYKETV2V9MUdWE/Z3U3VfsEr
	MYmc4j0uusTWqNCCGyc8jq/Xr6y1g/13w9tiJ2sIU//fGAdVh90YO6jmfbinmBlG
	tGzWApQo2u4c04Xt8r5wPAwrQzJu7XFpDFabnVQ1yge9wforC7PhCKknzCljUb58
	Qur2bjJUQhZDPp6cpuFFgK5qn4UEcH8SY96Ye/b9DEy7SWpJOzby61Sa5oSrfonO
	f+MVuN/EkSH+wmQmlHuHIp0UKW2W+6cBA6kWOFfOBRGYfWngWUz/kSyv5nnMGUoo
	4ysqlTbxUJleTukdsj+S7RB/q5ajFKwbAWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unmng3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:12:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704c5867so1649505285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116777; x=1756721577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moxinys5s3N9BtVwh8XnRm+TEdKWfPUaqsg2wBZXC6A=;
        b=KcHT3S55zLXeHsdQCiK2D6HyXCyKLH+bKHfsABnhJDUWEH4o45B8GQV4iXwO6Afzrx
         zWOhPL5oy3/8vRBUmAqfgW/hx61PsbQYaCRtRilLMrrkjD3Rqp7GLrYO60Xke1YK5DeX
         o63oyYlmZSXDyOuxqlrhbf2namFsZrg0sJ4O/NHHmw7iy2ktKkFUga04kPX6Y+ZUDVyp
         CPjXqH/ifKT8bbAQMPOJnllcK0zUV56tUX8nn9R/TjwvyBPVpLyKypFifN6opuBjibTw
         clZaleZfUmi4TkmuqFvcqPjXgR+ZZiA2uWetBLlWzOnAb9P/dPxm26O4ARa/GZrPRtfr
         BHzA==
X-Forwarded-Encrypted: i=1; AJvYcCUJUpRLLr+dkrpYkiDOKLrZyIbWcZHdFCoO+iK5fIsWUHcYxBrM/6ukOgJOdXHSkaUeSJodFUBiVD8NldA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1n9EgDdZFRweriq93SLB4WXFSTa+hKCppjqcTwZM39GjdMx4o
	9v6zqZwYtP2cFbt09XvRBBKV+wCXpbUiCvz68LaU/F6ZZjYbBVJSh04mMQ3SENA8DE1lDNiWmJB
	eNViZDkEvxaMY1FWQ326u/fS4Fz/n6r3amWnIHaQrlsfr787F5mrWxiHIvnrqjx7xuLM=
X-Gm-Gg: ASbGncvWpZlBoHGeWQQgeJ5Re2FMeQJyAGyc5yC8G9ZpJgugobM9E56V/KL0P/7HJYb
	q8GW3rXnREXUp9qq3nc1jqbPq6PP003LTnH8LL/LvChcCIAIIj2hJHuBzq56++ijNyTqxhfxT5U
	j98aDHOwSZUnqNXBlYKbE/7oqzB2Nbha39XCiWL8Ye7RJmgaK4Yzl8nmIkmnDjl4eabBSDJm4T2
	Nk/QiMGkqtHxNiM2lJX8fSbhuJmZdbWDmyszIh7DaL+odRIUvIpuWEcAtco+nOnP4Ip5I4t49Z7
	kS6yqKBRzaR/ES5TmqxmHQzbQoWQGCnCarn4gEtoOq8Hbfgsu00tDg==
X-Received: by 2002:a05:6214:4687:b0:70d:7e5a:2284 with SMTP id 6a1803df08f44-70d99bcbf8fmr120045016d6.5.1756116777332;
        Mon, 25 Aug 2025 03:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqBcBMlB2LMK2Ok/clzAec5tF74m7gHksFUm2BryOa8nhn1/DbX2Xv3WeEJ9ZiCW9dNVd7yg==
X-Received: by 2002:a05:6214:4687:b0:70d:7e5a:2284 with SMTP id 6a1803df08f44-70d99bcbf8fmr120044796d6.5.1756116776808;
        Mon, 25 Aug 2025 03:12:56 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6359b8d6sm5798645e9.4.2025.08.25.03.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:12:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/3] ASoC: qcom: audioreach: fix sparse warnings
Date: Mon, 25 Aug 2025 11:12:44 +0100
Message-ID: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: noHRwGniONclqTLVUKaT8LpOSKjDAimH
X-Proofpoint-ORIG-GUID: noHRwGniONclqTLVUKaT8LpOSKjDAimH
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ac372a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=bgWwhrO3JQob-SLVGtYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX559EDgbN3Dwr
 ex9Ohb+HdAzybtjXmtEm/OlkAJFIXsSfUPqR9gtBbF/s/EZmx7zqA7/d6vvJrTW90SAq8C6VQPl
 JWyr/Up6Feh62uMV69qaIp4yGBzXow6SzeKPuJcSpz4RPBCCOw1txaFpx+kqIB2TUMWfY+eNEQi
 wSlz5z7F9lOpGDMQ4EgcZIo8nhj+cyXyqHdrfC7inL5VNcfZhsgMYaVrfC+jmGeb1ohVFiHtcnH
 NGtVMOEruATWG5FXg44vDagjAKwYY5QgVc9kvvPMoinU0I7GiZtPZX8pkfenJACeAx+BqkT/psE
 j4H478XHVCLJYJ22fjukBUmGPpfLwB9rywoBTIs4EJwApdfhTS9H4fayekXu1wiEKXFWz7W7q07
 mJ6Z/YdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Recent static calibration support patches have excersised new code path
exposing some missing checks and also accessing some variables which are 
of LE type that are accessed directly without converting it to CPU type.

Thanks to Dan Carpenter and kernel test robot for reporting this.

--srini

Srinivas Kandagatla (3):
  ASoC: qcom: audioreach: fix potential null pointer dereference
  ASoC: qcom: topology: convert to cpu endainess type before accessing
  ASoC: qcom: audioreach: convert to cpu endainess type before accessing

 sound/soc/qcom/qdsp6/audioreach.c | 2 +-
 sound/soc/qcom/qdsp6/topology.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.50.0


