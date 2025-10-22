Return-Path: <linux-kernel+bounces-864342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22BBFA8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC1BC34E27F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637712FB63A;
	Wed, 22 Oct 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbmhU2yt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2F2F9984
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118146; cv=none; b=hIDlq9gcK9W5dpzWcyKAuy8MC9v+9IG4Ts0WuBnCBWvXQqa8QB4ieKHrF8Nx4Y+SQhAsSblQ5yrdl3uX30Ru4sv5WY6/b/CwG5Ecjjma2+feyW+9q5mMDEyAA80DkgRyAbYs570AwELscDg4v1jRK0opnSSYCKn9vcxZ27tAfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118146; c=relaxed/simple;
	bh=GvkHRIdYVLe77R0ZY9NDb/kKn2TWXxRRo7L7n8igm6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJMSVg3VGtSuwShqOtZXnDSSG2xA0B+QclQJLb1aqQRLmdbNXtz56p5IyLeOKXc/gEl3sTF5L3gxZBUFO5y1U6sGUIYmOERtiaPpzzFLVRzOdFjZQuHPzjTLPug0fqkdZSIBwJ94ypwzEKbbvg5qeCWXBljq4psSTuAUwyDSqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbmhU2yt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2tDol004440
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8pAfJ4YrVrXXN0p5roas6qTfq3KICUipgTwtkvr89nQ=; b=nbmhU2yt5d7Gdy2J
	w/CfvZTdagQddRBtD0pS/j/BljwZuqTZYvCqhJ8g22FZu0px1QMKNF6HO0nX7nhY
	NA3bKWI80yjIi4fB2zpZqpeiNXjxloHaoc0YfcRC0lzRWh0qGiEzYOn7GhoB06+U
	z3Hw/LMuosMSVCHbry1IdWT4bNzogkya50+CtjCYqHtxD9OC8WX5qDn+VPGduslF
	VYVFzTrH2yy5ouZhSeJsLKmynvuZPVp6U6i5jEYde+i83YtVns746Zc2XB1OBqhe
	G6b8P4hfXXup7IkU2F3oBy9umyAQ7oua1kno+7koH9plkSGNv/pMd6PorsaWNhcO
	0YCl7w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfkms1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befbbaso7488033a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118143; x=1761722943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pAfJ4YrVrXXN0p5roas6qTfq3KICUipgTwtkvr89nQ=;
        b=ZkPzZ+5oIAgSG9IIipMMHrBceuLmmc3xsEKXORyXjNs/acmOZ3ve9mDQMfcDCA8t5V
         r0aX3rwzV3danrnmO30tEvVeON/Ni4gCSuqcS3rEYtqG67ld2zeyaWc8q/PJeUcy4avd
         yqD+YhSCvN31QE99AzN2VLGh/A7b+iU/n+HPXBnDhOKA1iZhq42r5aLaSB/X8dbQmyMj
         fbuK728LV5Pf2YSMPt8avjfy6m5gzp/QdG93BV1aSf6DCjRaCWg4EwkS5Af79BW3w7m2
         0l5L+SaB3ZRNtHstLnZsp7Zz/0a6s6jFZBwMgynzUDGj94G0b8pFABZNTUMHpO1ZVMZn
         zZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUmeNi7+csDgQakLeRdUE8f0WyLGiOi2e7Ih6pscYh4UNFhViPe2lRrUSCs3EwSzvhDcygV6vW0EJn2hSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ObnciAWBNn7eWDiHS8DVKpK+AEAH/HiRLX4OtlzKTetXIwEW
	AhVCLfa+cEJ0yQTLe8FMNwMCCYrFw/v00zQ2/0NgZEnis193CqlMKrQseclerBJhLO9nGMw53Yb
	mVpWxpAqSZ7godi3OnCtykC3as5nCFKWS8WIIPKWn7UTqeVgFINE9hddy9uJs1VTPPDc=
X-Gm-Gg: ASbGncvIq1j/lhpz817vSS8ZTA5Oeott5eftSak+B5ZzCneYz/YZPtgEZSTF4tXyzok
	Vbaan70tG97SCZRTOsf2H2MkIlw8oyEjGt58RUsIZrXkmynwL2BjhKxs4BG+/GUkxJ+qr76/bKR
	IiD0ABA2TrxSrxob81/AE2PZRw3BmYfZf8x1i9osfEGsjwErRYFTYoVCEyarJQRm+gUqkvz/Iyl
	/39KofdGaYr8f4Qv78qAjLcOn+gc5QadSjs1UdDyIU+U9D4KVU79H4R2oVS410MIYcQ2R6QoR6R
	jwGtsuLwacPDRx9O8R7Be/kA3UzgZBw8YdK/Nssvc9T6p2x5cUlOWVzVHuPOibBH10pC8RgZV4u
	Uvof+1gZsirJDkeUZtb3C7vd9HmUh75XAfzGtXjFaXSyG/srT9Q==
X-Received: by 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-33bcf90e86cmr26048957a91.34.1761118142604;
        Wed, 22 Oct 2025 00:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIMO6d7zAOPgfCMZwZKqFbhQZ1V3768KfUIrEE5Dg9T9Yv30w2Pj+u0Fx38etiZsyYsQlxOA==
X-Received: by 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-33bcf90e86cmr26048920a91.34.1761118142167;
        Wed, 22 Oct 2025 00:29:02 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff4498d0sm1687342a91.11.2025.10.22.00.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:29:01 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 00:28:44 -0700
Subject: [PATCH v2 4/4] dt-bindings: soc: qcom,aoss-qmp: Document the
 Glymur AOSS side channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-knp-soc-binding-v2-4-3cd3f390f3e2@oss.qualcomm.com>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
In-Reply-To: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761118135; l=848;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=QlU4swPOtMyVnMly1EPGcYn4f1CqtJk6gC1HvBg/Spg=;
 b=uDXfTnComZRzOmtSJSvtsrOS4zxYWzyuufJG9+frDHW/icoJKt1XneC/Cqsa15kiaVvUByhug
 VX4tFJqzxkwBMvCqvI0vbCOvkn7jsa7d/icywcNoEO2CpO4deDp1sGz
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: WyjSkhMr-dRx0HeFX0_ztJUHdp1FjHAX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXxnwv/SDkJZT7
 xuS8S5/hudRNTh0KGfU2+dKwqqOIzV23CE26Kgjnv9iU0X2aodUNVIPRtymNNLHgSloqFOItHEz
 Kh/9TGWSFJKYK9hmlF75oSZK6hb0NYuDg13NMQNG9CBL4b22+bsccFESsmM1sAMeZWk5cDU8qa0
 dJaOBX4VkjArf11L5My3tTN6MmmgmEdHqHtwq3b5dCixisxympqnla3WaLVbUq2e7lrbYD7McuP
 CVaEewU0vAMn76BjfFvK5WmOldEv1Ph49x7SaGwdwRKJ6HKyw/Xpu34BuLkq8Wvs5gvu7whYFaD
 8JlDRfsjlSdtEzHiLyvcAVKgds+QNLeVp1O3kXRZ5dkJ4ncj3iRl130Qq+Pzl7sDM1+iwsjGqHK
 r6qpw5C6d76xC5HV4jCPijJqBCEPnw==
X-Proofpoint-GUID: WyjSkhMr-dRx0HeFX0_ztJUHdp1FjHAX
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f887bf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3zIzYcw04eZ5cjS3wW4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Document the Always-on Subsystem side channel on the Glymur SoC.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 57aa819939f0..c5c1bac2db01 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-aoss-qmp
           - qcom,kaanapali-aoss-qmp
           - qcom,milos-aoss-qmp
           - qcom,qcs615-aoss-qmp

-- 
2.25.1


