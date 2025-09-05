Return-Path: <linux-kernel+bounces-803092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA80B45A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BE7177F12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F953705BA;
	Fri,  5 Sep 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="apFBEYuI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEE36CE04
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082430; cv=none; b=mq116xYn0Ul2GLCZDBCqtJIZW6oxdEc7Tw1ss5OJW6p4AeJNhRMeiP4KKm9yqEzMtyvPV9zVxV8zyHyttdsiM0HimgAEM9LnhJ/Z5GVk2Hoh8bpaWyjApcC4jNNaQqblDYVHCw7h7Dik9XTYjXkLuABTKl78PYxAPLDU0EJslmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082430; c=relaxed/simple;
	bh=COONmJayji3/apDDC0fohQM7ae7ePr8nTLeg4wuARHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GKkxfUYGBKHK/3WrzkYiE7MqCylW9/ebOe1MHqaeVezQ573mF5cP8kbYpj5jA0Qpl8PZ94KY0ptHIr2ss/rR/Y0chAfgAVeNcmKBNujY7YtakYSvzTSfxrifYpf0ptq0p3oYGGJb9OViLObksEQA00JFvuMn3lDr3faPR7C86hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=apFBEYuI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Ciub003296
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 14:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/ckEIR0Lh7M8rafeQHMKQZUw5tTBw3CzxgX
	B0MrQTyo=; b=apFBEYuIMu3qKJ9pwCYwLKJU9N3n78Q0fuP+40Kq72lbEnFygN2
	mf2OrCFIzhd8jM/vlSurLDJJyEOvrGxp0ft8ztrAO5v0a9OJnzGdMzsEHpMu5Rd3
	frvg4pG9bYIGiSpPRoSJmPtPQ6OAXGR6UKyIQ4k6hCFOa9S9z+bz9nu2wkeEFN7b
	dGthv6sK3rbJKqs3yz8DLZ8xCAOMuBt8OS3Rvrmp/7UKGTsjCh40D3ye98PoT6iw
	ZajIi9hdSvyRZbqEtXJBVxQfj7r/baum0lHQqnMYdX85MWCVV8oUU3cNYD7WaEow
	C8MGF0SoCxaUHcJ316YwxO3u39Qkhhuk2RQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3b9dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:27:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724ff1200eso1938287b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082428; x=1757687228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ckEIR0Lh7M8rafeQHMKQZUw5tTBw3CzxgXB0MrQTyo=;
        b=NiBzo4st0u+PCfARse8zrKUa6/2fP7f/Tko29V562WgBrHvMvU99HEPHpnqXENxLhn
         wYYwjmV75VMrUPt2TdnwzhE0Rs5iexDLJr7sqmA+DrV2jnL3abqpNxocD0rAM/ldTIBC
         mO6efgk0Cz+7Ba8WOtq7ke8I21kUiQk6NcBgKX/ILUhJH6vMCGKP9xCVhNC8alyHbmco
         keF3D/y78Rh8VyZmR20FkSZqapQ/66IkDPebWMRtJW06WFeO0k/0oxEYk5DMFKPzYRsR
         dUbKZUfqcoIrp8KypN9RyMRa+LzdqfW53FVSIG8loEeU1CAEeYClGQI20s4fy9puBlg9
         KBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUedCXUIZwNS+X6tCW6gny2woVNrKDrc7coct5HFr0CsZ1mjubqySwUYJGU0u6iGIjWz6p50aqLHdJJpiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznzGDkol1ckJ5lL9nvcTbkbsRchhKywe/JTyF4ym3PwZOSqoLf
	nsCtdVFO/p1b5fT3wbw0hbcP+EtxFyPUbxbgSg8xrZ2mf5GvzMatiA/kztyd7ZOoyZeqkKRnG2+
	vMQ4FgDE6NcoVrA1mJJckMJWjZUk3W33nmfM8sV208VQohTan/vijhrxJPav807O7nhE=
X-Gm-Gg: ASbGncsLFIu9NsmZo7ISfrIHhtNPE6lFGkHOXh5z92LBAsyj08F99uOYAjYGBXpnPyw
	FTz34sqS7rhXxf3xXJNmRV3XVnFTLKFK+98cftWDBSBCjCxzrEznbCKzhs5CVcMe8MS+0AJfyyz
	z0PVp7Uh5WUmY7nxPBo+zrwphEk++xENNGDrjiJ1uA9EWpZvM3+BN7yfUN8Xe5CxscO6AaJ6ccm
	bIkQMW0e7y1/3cWQNMtg4uJQ1KJj2AtmQRnlbZfJs9AeOz4mq7EnDxKaXZ0uCu6fvKBQBTdTx62
	LLRFrdxYX3eNZWay9Y7NB7I5CgA8s44oVI+1C6dFqRFrrmRsOwjEtwH75s6hT/tCX0mKbb8URwL
	k
X-Received: by 2002:a05:6a00:4b56:b0:772:2c15:230e with SMTP id d2e1a72fcca58-7723e21e99fmr30451159b3a.6.1757082427519;
        Fri, 05 Sep 2025 07:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMpYEFhjfDJgMkmgqtvzTOSg19rOBoG+ruM9W/bufKK65tLBiqApGfqLO9jTLPptM39ajKow==
X-Received: by 2002:a05:6a00:4b56:b0:772:2c15:230e with SMTP id d2e1a72fcca58-7723e21e99fmr30451120b3a.6.1757082427002;
        Fri, 05 Sep 2025 07:27:07 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a601sm21930824b3a.3.2025.09.05.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:27:06 -0700 (PDT)
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
Subject: [PATCH v1 0/2] Add sound card support for QCS8300
Date: Fri,  5 Sep 2025 19:56:45 +0530
Message-Id: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXwvOlDpe1F/QQ
 nN2VPtbSRyY7+A5LzGFG+0Vja2m8DIO0HPy+XAzvgKO1RWvU2MRT1CAWVDTqzCty2BWkco2gXma
 4PkUcLDcnFhm2U+RxwXAwWqWvb5N0W69foSjURKJwASjo3T/u93AtyF6K8bIc/siA2ncRFECsAq
 psvqKmb/G84YIaSYj7KIsU1uoEH0hQJZCJm2shV7KUTUIhGnolttwcgb1Rf13YqpCAoxJMdNVsa
 gLrJ09zjjJFrhBgS+be8h6S0KezImGL3sXO/HDVcw5q4mLbE/2R/zAjcarZIM0tW02NQ48Upikd
 FXMYhk85IEm66g/mLDIHbQEEzt2kVssM28KpeFV8C2kdDyhYgTXIFxpxyFWW3cNUY2jyBOnVgpA
 Tl2TTK5v
X-Proofpoint-ORIG-GUID: CEu5WPmk_ngrwiLD_7qOVw1iIpM_-xQb
X-Proofpoint-GUID: CEu5WPmk_ngrwiLD_7qOVw1iIpM_-xQb
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68baf33c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=3So_8DPhrXatR6NxOeYA:9 a=zgiPjhLxNE0A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

This patchset adds support for sound card on Qualcomm QCS8300 boards.

Mohammad Rafi Shaik (2):
  ASoC: dt-bindings: qcom,sm8250: Add QCS8300 sound card
  ASoC: qcom: sc8280xp: Add support for QCS8300

 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 sound/soc/qcom/sc8280xp.c                                | 1 +
 2 files changed, 2 insertions(+)


base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
-- 
2.34.1


