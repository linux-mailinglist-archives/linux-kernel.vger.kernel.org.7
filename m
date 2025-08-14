Return-Path: <linux-kernel+bounces-768312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02934B25FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD169E77BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C52EF644;
	Thu, 14 Aug 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkBQet9E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9E2EBB95
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161584; cv=none; b=NBpZRSqkL97LN0ZQDlw+hvW6SJcyUcd60z+hNs96Y6hwRaSCBnxQhq4oUposxUtHmZZ0lJDV2zgdD4rJwaoWJZvs5Oyt3+icFkDtQrrZH8+vwxKG9XzaPoUl6B1ZHIkmlwrTZb51sLNIujA9cLYgLTiHgoQzx8dEOuuSpnQ6Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161584; c=relaxed/simple;
	bh=ER5Kb+8tz4fNvLOOzVyZpGvtPZZSeu4NJ+lkYxElmDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DH2cIH+zPTUXTgK/rHXPbVSmtRG/H2FxmBtOva86gRQyRmxx8dYnvV8HCH6lB8QdVsa5mIkTS051B+5Uxd/tO5vZtsCpmsosYyTDwVa/RyAoT1AFfluWGnJ/63RVsBjwnczLkzY+ou4+nG/JqYZYxA10cBnLpDyP+6oi66wUf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LkBQet9E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMe1PS011059
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nflzV9qq/tL
	/glhk9JNHKNEsSBm8wEvnbzo5OybERr4=; b=LkBQet9Ej4FDnCKsD53bZnxHWcU
	uylpFNxuMuaed+fineZtXzzM/85HyZaqJ/Lxp31l7bqdf519h9VfIY+6jshSesWU
	XRPa7pbcYrjgdFuqDYh5pw1I4robU7LtcNW9I8z5uvK9lSMNxwsEX0RuWNIlqSP2
	+9cq4CPTkw9ZFHtZuSiti9FPcwEALBg/49xM5iPkunvVZcRsRSJtx8PV+tFsEDHM
	j58mTc8KTr/Jw/jUc6bu5OG/v+Q0LAeyLrsmUZyTdUDft+IETJB1ZB9OgNg4MLRm
	nebMLsv6Njx196Eliwg9pQFiS68Y7WO6h9XeefXHv7nz33BMqQY0sCKcOdw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbj69f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a92827a70so17141286d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161581; x=1755766381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nflzV9qq/tL/glhk9JNHKNEsSBm8wEvnbzo5OybERr4=;
        b=VwDeRzLEHKaQhv9imcVJG84c28l+J1h0O7CR2EopA4pLC0Q6WoIy1f35ktOJginB/b
         zjw2zxqhoQqxoEOdXbleSGQQTuxIq5oo2Dyeu6ig+JC+dNR8OHTQiqyDwQKAIIdiGJsY
         XLUkm6XcvYAckWH+GRMMIfHVjezs/obZ7Ory58XBbuUUkJ/x9ojQzr6qHXYl5DS4vc7o
         YAkWjBvIQq2X3BXUoTkwzOIMBIdoKWop3zudcWfo3noUzexwkptDZNWWk1RXBtFJToXQ
         IEEUH2CgPdWdLM3smobMYXqVvqTJ6cO1V5IbkY338IxegDkne1Lvp84UsUjmHe5nNQkX
         y/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXFwEXFbbF30Q3RbgbhLAieVqn7IUamRt3+h/OuIB0d/iwoiImXGtV0Ya25L/C9OOrbBKYDeqUJRXngRbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQw+TNLYfzg1LGGUH/gMNVE/1dJjXVK5osDSWMDGIiKnOWBEvr
	SK5wYX/G5rAdDIGsr+/0BUOi3qfgH1bsQ7fjznVy/u3yy72vxiMrzI73xjZ06MyJwrvptXtfjXD
	HfxL4pbrE1NGFJCOzL8Ed2O8x04RzVPM+Koyl3+WesRDzMIQ0qpTnPRmC1rojP1OHtRI=
X-Gm-Gg: ASbGnctAXE8PlFkjeUJL3iXOEWaRMJMJ+DZU0TAeMMwt+Efh3EQoOIIAVgAiz1HUtHN
	/F8W7eyPBa7EcY9Lci45ykNxHHAINtVy9wi7kGTvI06jRl+aNwEcW3MnnTI+9O7+yUauJR6C5Sy
	rH4+h6d/DHDaOV7xmrG+f8PKqXLI8BFthcThQAp2J8I59WDdY52EBD5P6nLgeVmcRjM42Pvc3v6
	IdIuQdD7sN0PJYoMjIU0nhTXhzUI2w0EEVBnsmvwB0Wd0zyzEL1Jmo4sG8qCXy6jcy/xsm7h8oU
	GqIOL960hqnzfngXNFZNvQFHoObMMtSiaITXU4UlFd5DoRj8xWMcnCJUljaeu0+8xjSh/4gpKpN
	E1YTiwul3PIbp
X-Received: by 2002:a05:622a:551a:b0:4b0:6d53:a0fc with SMTP id d75a77b69052e-4b10a958407mr32313691cf.7.1755161580769;
        Thu, 14 Aug 2025 01:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7VBqCxB491bsqiTl2g2jB8aaqDVL3tegvRTBxyZwdhXGP6AmLmu9SM3LrDj9T0Zv7gbkXyQ==
X-Received: by 2002:a05:622a:551a:b0:4b0:6d53:a0fc with SMTP id d75a77b69052e-4b10a958407mr32313361cf.7.1755161580281;
        Thu, 14 Aug 2025 01:53:00 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc93fsm13155895e9.2.2025.08.14.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:52:59 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/8] media: venus: core: Sort dt_match alphabetically.
Date: Thu, 14 Aug 2025 10:52:45 +0200
Message-Id: <20250814085248.2371130-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
References: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689da3ee cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=tkZEzfabOtbtaFzRxSIA:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX4ck4T2A13+eL
 XQt8yfNbCv+5ET1nNG5xhDdE5sWT4FTrwU/e+ouXTrgp58ovPuUfKziImPLmqFU5SVm26rmhS1u
 rFOyGm8PGfvKk8WPE5J1SyboBf1FN0gnNIQFM1hJMtbxobfAtV5Jz/xDukvYt0D7c55EaOeUbMu
 +NkvvMll8Jk4Z/0pNB6GgtndjoU3TyyxEiCiYTYx2+FbU/Z3vHbCiLFZ2E+A5VPq8CyRwE2aTrx
 QElYOe2n2/sxEHGphiY/VvWkF97DUlJLIEPRtddzzFV5nqrR6i5ScuMWQY5QLZ+thVLNfpTbeFi
 c2E34AhRmccSC2+JKnQS4sWvZF3JaafamQneFwexnXWxHPw1JqCLZ2CJV9664ZcF4ye/e53lg2o
 15sCDTrI
X-Proofpoint-ORIG-GUID: E9-HaQ38z4H90M5nhRnL37WK4q5CZJLU
X-Proofpoint-GUID: E9-HaQ38z4H90M5nhRnL37WK4q5CZJLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

From: Jorge Ramirez-Ortiz <jorge@foundries.io>

Correctly sort the array of venus_dt_match entries.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index bc7b255357cf..0ff48c92749c 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -1074,11 +1074,11 @@ static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
 	{ .compatible = "qcom,msm8998-venus", .data = &msm8998_res, },
+	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
+	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sdm660-venus", .data = &sdm660_res, },
 	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
 	{ .compatible = "qcom,sdm845-venus-v2", .data = &sdm845_res_v2, },
-	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
-	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
 	{ }
 };
-- 
2.34.1


