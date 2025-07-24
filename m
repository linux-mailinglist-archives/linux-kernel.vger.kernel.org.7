Return-Path: <linux-kernel+bounces-744244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3FB10A07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF05A585988
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364F2D12F6;
	Thu, 24 Jul 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nj2cDDvR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629C272E66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359830; cv=none; b=F661hCS04GU2mxGJQBYkTs9AhklKgmDeihIZVl2IqJvHom3RDAG2M8sHMkxG7vx8MdE3cmflZAtudJ1PISHQW/DtwSKXSzRsZ4Wt5ary3aZTXmWko8DGN1EYfBKxfcbwVg7wRitXub06Nj6CPFtL8HjYZGfxQk4oDOhCyWuRd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359830; c=relaxed/simple;
	bh=9UZAF+VjyntapLkvzyxf7dSdNiZLx+dA1nAB7juaalg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z7RYdIM+3/JowMFNQpvJ0ubkXdp3GHaurdKrPi0SPhVezLmVAJ5cp5ZKxnqDv3m2DJaQT5xSpJVgHBjIaRCeEbagFEtcxsuLFrk8nzIaNGe5Gj4eWnPk8gPgrnvzpSwz+wXK8lQsaByOB5taE6FVnaGI1toCjb5t2UixmkeA6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nj2cDDvR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OA2kK2001517
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=b4iOzUz2/tX9kzCgb+rby2
	EwINJ3HgWXsX897B2Yu3g=; b=nj2cDDvRAR4Bj/fL+/gzuXvMonHZdWmbChRwEd
	C7e8Qagmvhx6bivXy8fUeDx09ukctOf38TK3arotrJO1rPXtAWhkW5JUNYSR42mQ
	tT+Ms5AhkQirFIUsrNnG1es6kHOVpowQndMfEN7wNvnkcWqYQWyYyixxKhASOXl6
	qVjPw0k81BZk+8DlCQoAE76ZH4xDoS+POv25+NkF90bslubi9EdeBZAahKv7LWTs
	gySLpAFDOuZsJUya0pCfHLSD6QGEbgMoue9d8iE7AvarqExTvYmeyQw3eCTZI4MA
	cerkFobDBUIMF1g/j0K3ISwR03mO4t8D3FxCOt8AyzXXOVQg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uf8x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6facf4cf5e1so17315626d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359827; x=1753964627;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4iOzUz2/tX9kzCgb+rby2EwINJ3HgWXsX897B2Yu3g=;
        b=TLWM/Y4J3YxMSzpYsXm54gS4tG8ni7zXOb3bBDQ0R2x7XjOGtA6nSZHW10TdZvapRF
         QjLlZdQiMVETI2i/BqgPC/PRk1FiQa4P1POVAjtNN5oQ7SYfQipD8Y8AL3iq3WaLlPR0
         rqMfqNFdguQO4w+jCJsWEE0/hr81Kl6OEQb3zOEjVq7R8b5JlOgOpihT5E2+XE7ISJJo
         V7d1PqI7LrivEGNFYSzHc1QrfvuSXgfws/MqwEwk4vitR4wIvTAWgoi9ZXvDPDPap0Dh
         3WfG+cYnqRJMtVh3+3R3iSKR1tHg5x82RzACYHX0vYLqQWWynRMEHlslkCnW3gWqU7cG
         Tjyw==
X-Forwarded-Encrypted: i=1; AJvYcCVngErV0z4ktneSXO5ywj5R80A8aV1lAf7c0QoVbDCNIxfddO2JnCtMqwrH9/SX14f8NJP/pySnqufLIa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5Q3VHtly3Sf2vg5x64so0u0D4eXvJaHnrJ6cOGzdaSFNJwf7
	4OaS5rtEEysLK1DOL+4Ts4Yt2yMIN1zWMLsoEVpLwnZPktG0qF8xMZ2Yn0f1VKKOg0ouNbOYyj+
	MqjmXbqTLWo8aze0aOmjIC4/8c4tz38zzKGub2gWecu6LQHeKhL5F5EPUGrStO85B4w4yHQI6xS
	o=
X-Gm-Gg: ASbGncu4G0xsf1XibzaOyOQFhanBN+hw2kOdRH3S2vk4WWz2ODZPmWl/MMgmdsCVjtd
	1zWrsdl0NsH59NaNFjFUeLCnc5rD5wRgEhdNVsfqsrqmZ1mau6VfUOMtBuMKOGRteva1hX7+EMs
	n2DHAuvPPRARbYn0fEvth2q/h0dyTYGMDiSji1v/ircvY/a44X2rMXcRJvh8+0do6iTYR85aUk/
	MZVpyRxp9b1m9ewY01KRm+CKLxj/c6uomG2ApuMK4H3xlzkrHfK1FZ8FA1rVw75eVkRC7Jle/s4
	e3JM6CqK+j9HZoW4jwMxAD6m6MGxwSMcku8bjMv4yZug88rrKb3JSTxIn9JvLVHqJVp9SSFLbld
	RrxB89C2QmN+MH7jr54eBf/4bO/y+b+ETXFZaNnyfkZUcxCjE6yAi
X-Received: by 2002:ad4:5f06:0:b0:704:f7cb:dd25 with SMTP id 6a1803df08f44-7070057ba17mr109236266d6.21.1753359826542;
        Thu, 24 Jul 2025 05:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/XcSHqN/o0Ithkvxygetwn6YY6eoeEZiW7raINoXA4AhP4DqSY8tP24TXWSS6o0cReAw6gQ==
X-Received: by 2002:ad4:5f06:0:b0:704:f7cb:dd25 with SMTP id 6a1803df08f44-7070057ba17mr109235506d6.21.1753359825861;
        Thu, 24 Jul 2025 05:23:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c83978sm327389e87.126.2025.07.24.05.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:23:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/5] arm64: dts: qcom: add empty eDP endpoints to the SoC
 DTSI files
Date: Thu, 24 Jul 2025 15:23:38 +0300
Message-Id: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMslgmgC/x3MMQqAMAxG4atIZgNaFMGriEMwv5rBtrQignh3i
 +M3vPdQRjJkGquHEi7LFnxBW1e07OI3sGkxucb1zeA6PsIFhkaG1xjMn5lXUSwqoiotlTAmrHb
 /02l+3w+orxYKZAAAAA==
X-Change-ID: 20250724-move-edp-endpoints-fadecdaadda1
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9UZAF+VjyntapLkvzyxf7dSdNiZLx+dA1nAB7juaalg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogiXOJK3WuSemBhJl8dxqP228S31Vu9YuVz7Qv
 bw6L+4zgXuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIIlzgAKCRCLPIo+Aiko
 1RNPCACCgdwWbeUlKjDs2S6eBZ/vvFVMZUek7iXOPpL81le1Qdohbug4ztVL73O9jGSLjPgHSWc
 0cU3Zs7zKeD8JvjaDc/EGdqUYBIzLBgo9Za+sUUbEu5wV/GMhZD4/tZcU+f8tPAOxBSCHy+mPy4
 sTNrmlwj8I+hoAGffn5ivbtbIpBTdr2sG8J7xWWfXHmt6sFI3FtZ8rVt3XqXg45aMOq4y58D8ca
 9JqPqYO9tF3Wo9UUCZnb5VGwv4C45dyz83rGizQN7+dmYiXIi9KPnnbdF5llSgoK6LK4RdLoJe5
 N6J7raC3mzP5bDjIH6FDSebO7BGCXKg9yZaX76/5KY010EyD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688225d4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=D2Q8LXYmFiaJ4L2kWqsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfX+NIoPAHuiQKl
 9QBH/ltLMBxFtTgKUoimAqMAOfeoGgiiOj0mVe6ld8b5ldHCl4+CsQ68QZi0YQZIhWFPyTK0FYO
 rsS/Cu8UyqXrzjaCfjdij4pHv+hHtuh2CO5yfRVpOMx/GHm4JLZ/yZwGztEx1EMj+WHmnNl2lkL
 FOeX39nqv70bzi+jV7Oece76q05LxxcJpc/2hf1baRR5/2pBvq/CRnj8YkUEs2vdJSxvBjaI09y
 Xd9N7CzZvPWK2K05Hqc3PDWqFIkynLeH2pE73EgolFI/HlwLsrRhKPqLTFBdNda5zBMx8zCMoKF
 tWy/MDUktvk95ERzzwxFmwYMs26b89S22lNAvKoogMOnn6Aixg3YkJLPltR3SGMz6m8onxT1ZDU
 pxVEVEKtO9ck0EuvpTmWpr8kRMCRYFmLFiCMa9Tju9/TjgLGxfU4uy69mOllAYb3eAj/bK5l
X-Proofpoint-ORIG-GUID: tfgroGGi1sk2wPMnlsmm1yex_J-DoDmN
X-Proofpoint-GUID: tfgroGGi1sk2wPMnlsmm1yex_J-DoDmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

Follow the example of other DP controllers and also eDP controller on
SC7280 and add missing mdss*_dp*_out endpoint declaration to the SoC
DTSI. This slightly reduces the boilerplate in the platform DT files and
also reduces the difference between DP and eDP controllers.

While we are at it, also clean up remaining data-lanes and supplies
leftovers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (5):
      arm64: dts: qcom: sc8180x: add empty mdss_edp_out endpoint
      arm64: dts: qcom: sc8280xp: add empty mdss*_dp*_out endpoints
      arm64: dts: qcom: x1e80100: add empty mdss_dp3_out endpoint
      arm64: dts: qcom: move data-lanes to the DP-out endpoint
      arm64: dts: qcom: sc7180-acer-aspire1: drop deprecated DP supplies

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 96 +++++++---------------
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  6 +-
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 14 +---
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        | 14 +---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  7 ++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          | 11 +--
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 11 +--
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts | 13 +--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 18 ++++
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi  | 16 ++--
 arch/arm64/boot/dts/qcom/x1-crd.dtsi               | 15 ++--
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 16 ++--
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   | 16 ++--
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 16 ++--
 .../boot/dts/qcom/x1e80100-hp-omnibook-x14.dts     | 16 ++--
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 16 ++--
 .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  | 16 ++--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          | 15 ++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |  3 +
 19 files changed, 122 insertions(+), 213 deletions(-)
---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250724-move-edp-endpoints-fadecdaadda1

Best regards,
-- 
With best wishes
Dmitry


