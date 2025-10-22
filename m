Return-Path: <linux-kernel+bounces-864265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF9BFA54B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171A73AFF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2B2F39A3;
	Wed, 22 Oct 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g87rnSle"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48832F2606
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115837; cv=none; b=XEL1tyFAWYcoQEliu+2i1/qBKs3+NMNFAbq4tTx9V+TH3l8KOVV+53K+a5o47PTn8NTrvkAvLTGdu0b6evL/UGrhI3zDbWVpYBIBinlp/rSo8tX54ttPZITeikGJrZVdHWhW0si3Gyy6cK1S3o0FHHY1FlZ9EMDWEG4jaPHPaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115837; c=relaxed/simple;
	bh=AK+eOpCifQrdqxAyerpg5zHdAyrQIsKrccy3rba6YEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fw2O1CF8FlETbCAJJOhTRFgM3Wqsw5fUiA3D5Sxx7Pve0zdqqiLSiq6OPzyaz/+Y5PiPk2tCrfybIPuGpbCRR1aoUtRiuGXPL+T4XsPyPJv4i01wDKA8mQVL+ZOe4C/77hpaz7R2+L6dsIhp+L2k2aA1NjzKYphB3cOvruszXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g87rnSle; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2Lsk5019914
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9mJDCjcSwaN3f8D9wmyTS2crTbn+Fud3WxhiyTqBBw=; b=g87rnSleme87DTFb
	geVCR+lQP/mNH88MTyd/aBd4uMbk5j2naRA7/AHcN/gFhYj8CvUeWPNxIj+UJaYG
	qJN4Wk9OP7DQxlpI+PCr6DYvhwDqTUgaYLERpwpdAEQe3z7PXiphytKvM7FtkG3f
	jZIZshFoT3pmAb2NiaLkTJVs3ttaFqSYT1FWH2LYiiM1pvZCstqL9WrJY8DCNu33
	LTJVmIlNvFNQx/zoJeMeLhxqe6oRLSTTFWf8H8h22wVFNtyFlMVBNHnrSQwriVyC
	6d/eNvNKwSAzKouFAQVDViZyqJBwuy6SL0edPnGArLgYoqa44cj9KP25WTltt1Ea
	s2m/RA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469kgmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33baef12edaso6006655a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115834; x=1761720634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9mJDCjcSwaN3f8D9wmyTS2crTbn+Fud3WxhiyTqBBw=;
        b=IHpB//NKKw3wBCuTYaFxqsPq5/XwMIpaUmY83C6Gdg18ELgRjmlEoP6SmorRQ5jjAu
         AiV/pp7OImGiBaAzXEBbwkEsXTAKsUFivOMGelUu+Akc8WJv01kXO5pfjiVj/UaC4nQn
         J0x02HgEXyYlOq1JFDWdGf25ftcMt6mDNjYdubkbD4ZrU30bhru7g4UlRRDeGm/5p3y3
         Cyb1sSFtZvAsvjawYBS6F0cr6o8NQRMGby2J3cnEUnSjr7LgwhMwdKdJN54f6CdLG/BE
         skiDm98y48BMDfT5bpSiihpoluOHgr5D+qDXyfoYL0Tctvj6/WxprtqjTXk7RUjtEvtO
         W/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXSIek73iPFJYVSTPFHnjei2hOQ6qiy2XlWbU5VQ2KLD8F93I0nJe0MkRM1rDOhHOaoMrBENJSTyg41BQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACrYGpP4qgINMncaIBSbZGIfQpM6MJcM/nsOOcMHgnjve71VX
	Lnq9gQB97VvAFARe9K9/L7whng0GT/aLTiL9TdNtkEPsRAjtRHTYmHdI+cyLkS/imv3Tl16tu+T
	hI7UNMtV1Rw2772of4ehfYSB7EzQ1DNnBIKo4rnv7ofW1XHkCLCV22wX4OI9+534YZIk=
X-Gm-Gg: ASbGnctuYLfW4xqlcnjJmTO+arfu7+S9DBcFK0MNACT0GBcgIpymzma9Mp7JYwJL3Bs
	l1NtGpo4PcvhoSjJHD/qrTMFKXd+btOTEVxwVe71/qXW27kI9l+SLxQFwmBHIsrD68sbtRstOYI
	g0ahjNkuUrl6tIRSDyOgRkDtR2p2XSmUqJbLmecPeGIHRtMamH4j7mQFPC/If3IW1vCszxNYYya
	5RExRyvLp4/jJwx4XNtp9ont5F3mUqFwP4kECyj32k7dX1/WM1G/jgrXKL2Uq8f1z/S7fE3Dx4q
	BNJjgX+rlYMrUtBC1E8ytmVxJILurvwed10uVQPvJq2piG5yr18cVisYEB1+d2Wdul+LswF+8u+
	TBmtrVVI50KSGETWlqng1q378VnZEfjbXe6AH+BOOElVvR0DTBw==
X-Received: by 2002:a17:90b:17cb:b0:335:2823:3689 with SMTP id 98e67ed59e1d1-33bcf85ac3dmr26314868a91.4.1761115833567;
        Tue, 21 Oct 2025 23:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDVc9txyy/LodTPX6Zl2bPT4KMUb2rb4Djs4TPJs7eGzSz76XX2iUq94kalMFF9cqfDmnbwA==
X-Received: by 2002:a17:90b:17cb:b0:335:2823:3689 with SMTP id 98e67ed59e1d1-33bcf85ac3dmr26314829a91.4.1761115833124;
        Tue, 21 Oct 2025 23:50:33 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e334fsm1560285a91.8.2025.10.21.23.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:50:32 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:50:28 -0700
Subject: [PATCH v2 2/4] dt-bindings: phy: qcom,m31-eusb2-phy: Document M31
 eUSB2 PHY for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-knp-usb-v2-2-a2809fffcfab@oss.qualcomm.com>
References: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
In-Reply-To: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761115829; l=1105;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=C2z1zpD5/k7zrrU1kiIxZnHAMyo8I2Wxj97A71MaKoE=;
 b=5R7Gn1k7ZEznAPlNPCPEnEY/Fe8DQaxDCQiOfn18V0Fa1yb9LsL9ao3QQcpKdWqRNYLa6+zJ3
 wsCMPTFtscwBx0YY5AvrZzEOyAmExpV3sXTe7M0fV2akCXWU3vhE5hT
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: faI7E3rSc5F_csmDYtl2fj8SpJs9FV0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX45Ecb1WeUm5+
 /B7R2fYYcfbWbthZQ7mPOcDQSzBrcoOWVs5RO4S0gNho9SDvMpJSbSeqClJJXcxNBQw/gorRVQf
 negcrq5S0gIT0vvpb6DRtLk5hus0ODrsJWqXjSDZtXqhaNWCzKjbNVFB07W6sCrTeEikKQsyNKd
 +INwgd6iiHCfsv+FtgBjh7Z087O0MQgKbuVnHG/wNkcbIZhywzljAUWtgcJZGvj+BMtyGhg5yUX
 W4e+EG+HkjLnvP/+fLd1tCmDNG7J6Z6oXzmEBnbFe/Zv0qAq7Jd9G7aBVc4cA0S7yrcepFf+KnL
 KvfpjOdn0yHHDgO+zILnPjdUwYj1xB6TUgeDITWE5rWZ9wK/lIl0UHENmowwWvAVqFW0R5Bn2F3
 g7Q1iFx03SjwPzCxWWFusDQ3YC8PKw==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f87eba cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JlprKJ-Wy1uuo2cOBb8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: faI7E3rSc5F_csmDYtl2fj8SpJs9FV0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Document M31 eUSB2 PHY for Kaanapali which handles the USB2 path. Use
fallback to indicate the compatibility of the M31 eUSB2 PHY on the
Kaanapali with that on the SM8750.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
index c84c62d0e8cb..ab1cdedac05c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
@@ -15,7 +15,11 @@ description:
 
 properties:
   compatible:
-    items:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,kaanapali-m31-eusb2-phy
+          - const: qcom,sm8750-m31-eusb2-phy
       - enum:
           - qcom,sm8750-m31-eusb2-phy
 

-- 
2.25.1


