Return-Path: <linux-kernel+bounces-803094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44AB45A73
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB73B729D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B14371EB8;
	Fri,  5 Sep 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyeF2zC8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA88371EBB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082439; cv=none; b=pqKYS9vQ4FRvWyY0vHhyCKn2m7SrM/qj1pB0vLGgYPZCdhqW/eV/ufOTpIajpzhx2NE8EI9rc2L8EhcOjDf04kN5qAtnBLVx7UHSSUjUeeiW223Hf4UC8a/7XXFg8UoFAQuLW6cTkrIFnh+SLM/Ui6Ezdu90UMcWyat1O20EALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082439; c=relaxed/simple;
	bh=myI5Xx16MOgCceElM32h+zW1zkonLymQ3Lqwqo8LTFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNN6C2AiUV/oQ2y+EdLeCfAvRsekPc14/0l2z4Hf9nTcJH97OxbiY4N94dWxELUdUeJuHpDRT5ewFA82+eGqsLL2/QtUX9fzFRu8Hv3DclwFNpxUhVr4Cyng3lZYeJ1R2/17zrTKZtZVN10ZYuHV2Jwf5e45YFtsoKAmphRIsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UyeF2zC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58572Ud7003019
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L2WVW1/64yq
	gVsyI6aD8hpTDnv6hYS9Gzwx/89WlPKE=; b=UyeF2zC8nNjEmZnV/toUDvdjPg6
	9eYYuSrrMTyNNVNieLf9TJOic7aAVkhAjTVz4P4LFO8V4aflG3Wtii/plCmdh1TI
	Q25fIH7AESltZYpgwDMfr67TlJp01S/UhDCr6VEIaw72YSTirEAhpPtH9hqZp0Tm
	fXxDqE9TCP/ud4ubd19hQlkuX1/vvncKX143pBPw4Da9Pfp3DmcNYQGtE3pD4HNW
	vy1YGGrvihH+Naj5t8gRK6peG3FSC8zBjpYeJnefrjOY60bLG+UnEjWmqVHkssQQ
	CY1kYwv7SHPx+JA9Fl10BoQRQMKHZqQajw09HnF0lTPNZcGz4ZTOQNd0j4g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3b9ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:27:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77267239591so3914024b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082436; x=1757687236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2WVW1/64yqgVsyI6aD8hpTDnv6hYS9Gzwx/89WlPKE=;
        b=puG9aSWxw4ZNvv/7I4iHL05q27x54E6zUj+/Jk8wqWPRBremVhuvLJD89WwhKNu8v2
         KH6L8HSUZ23eXL9sZZmkJ2XsoaoXvQbueBCBblcFMxqYp6IPnKEJykfoZWGKloHVrDJ7
         rFNHFuG+IWbYWMCksc3qNHX/DCC4ANXd+ikpWF368vHcPqKLqcDdo2t9Go2RvAvKzb3v
         RFjSDdsqxVtukwIpGtTzN+jCbWElvA6zlKsWCWElDfPNzViQBJsInM9s8zzJXvZrMjke
         RtfbgNjQP8pcGgx9YT49AyV0vNtH6RpekWqVxpmb1hO0yZAvOw1t2pBToaeYgb07Alp+
         OzcA==
X-Forwarded-Encrypted: i=1; AJvYcCXDTsMUq3DbSHKqL/jS7je8CfNjnilo1mvUky6Yxe7m9dP9k83q9KmYmLoqVxF6kTyR35S1DyrijsIktuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRv3wTbkNqNjRcrpWbsMKzA/kRDbRNGg9o7DPNrVZ55GxDGoM
	X1M+h1cUEBfs7+6qsbMg3lA8t4/wfzHD0SzJyOQdD37DPyS3/L1yjfyyG0Z7mHprmNcfoOMSxsq
	fojo04klZfMNEA/ZymdfVl+8DXBsTky0Zbr16X3s7PZ/kTweuaq+IDLJ4h0DfhpCHRTo=
X-Gm-Gg: ASbGncta9KA48HN/3b2sS/APFfZev+e8piE1rsDV2JUGZVHcuigtvkIsuLC1ybdfYz0
	jCf1cL+yjCNIznFRbxUCzBkDR3FVBHVZ+woT1zh6e+aaOwvULE0geBG/GikIojaYlyrhg24waVD
	FV9ARvZEU5lPwV6xCgHMnD9/guAAkH8W5qhiKYIsLXbkXUYSxTLOSmWDg4SmqtK6FYjvYeCcf8l
	as2UlBoJexYqoMvh6hJV3U22jrS/Ht1TVLU3QL5qTu7ERqyMBQepqKEhujlHp6ose0qtDFByeAu
	CgkjB6DyrsqUqnbbwfVCvGuTNdDRKpNOPoB5ZSSRhA3oENuVX9wefGuQNITnIwsF4mxQAoWr4Es
	l
X-Received: by 2002:a05:6a00:2e03:b0:772:5513:ba3b with SMTP id d2e1a72fcca58-7725513c157mr20774226b3a.5.1757082436363;
        Fri, 05 Sep 2025 07:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfXixP7tN6G9naFvmzc3C3KGXsyYCbKuPuFfp318P7SI1O8ATQxvm8o4EhuVbF0mF4hnJCOQ==
X-Received: by 2002:a05:6a00:2e03:b0:772:5513:ba3b with SMTP id d2e1a72fcca58-7725513c157mr20774188b3a.5.1757082435875;
        Fri, 05 Sep 2025 07:27:15 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a601sm21930824b3a.3.2025.09.05.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:27:15 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v1 2/2] ASoC: qcom: sc8280xp: Add support for QCS8300
Date: Fri,  5 Sep 2025 19:56:47 +0530
Message-Id: <20250905142647.2566951-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4EVYowGrZ3xF
 ZANq/nUKxkNX1SLbgPIodkrGSDEtV3ehehAesQAxJ+31Oxe6qg8Hlau8qWegQ9RPOtA3eKRm0pg
 yPAragGEfknjQ2atIb0VjrqkLfy8tABgM+o29B9Epi4QqqqeTMzmRZw51182xQ7t2Iq6YmrwSP8
 aVNLbnLPR0dnyAyZAH+SQ/pJMCFC46oNHbGJMXrN6l1+u/meE2AtS2QijEm1NNq/AGdZri8wm/O
 pW3ohFk6eSgHOZxe9oPMgCVpSuu76RMYCYkxUMHyda5/C966H6hvLC4doF0c4asJf4EzDrxauwC
 cqV+P+f4QJ/rI6coWfMhXt3A3mdooNyvrRhVhvP6/L/2eMjleDVQp03Kde23B2atBSGIGHRiafM
 wpSMA8Ix
X-Proofpoint-ORIG-GUID: G2iauGTWoppXLZ8eGmIuBVH7TZz-NvVH
X-Proofpoint-GUID: G2iauGTWoppXLZ8eGmIuBVH7TZz-NvVH
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68baf345 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qL_pmY0_dPgXwRjMV5wA:9 a=zgiPjhLxNE0A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

Add compatible for sound card on Qualcomm QCS8300 boards.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..c6aa62b1f66f 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -187,6 +187,7 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
 	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
 	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
+	{.compatible = "qcom,qcs8300-sndcard", "qcs8300"},
 	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
 	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
-- 
2.34.1


