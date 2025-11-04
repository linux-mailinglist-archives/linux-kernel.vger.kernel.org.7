Return-Path: <linux-kernel+bounces-884231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0026FC2FAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C0D188E9D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3D30C379;
	Tue,  4 Nov 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HYaozc/z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pjs6vCQQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7F30FF2A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241826; cv=none; b=ILj2V8mzLMTqtvBcrK0c7SuUgp6/hpzyZxny890C+wFl4oZuerutewTPWLie+HXMSSjP+C8XJ7Mwwx3GKwzKzoN0XJ3IM/7iULxwnyuMPsVjVmetZHEmDrJJyIIMY81l1LgcMJ75Wb7g1iqrhdjzM+0T1/uXWsvQT7xtr7bAF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241826; c=relaxed/simple;
	bh=uRDqwnYIZZpnXYckK3LJYkQkz8Z734oXrxzphtus+RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5453hzdwAeW0weJJ36qnzoJlUWJncHNGrOBI9l7yVCLq3Fp7UgL43/O2V8zZgML3OttObo+AyOUlDBgMEyn2NDRSaNPmJffExScM8rNlGYGU7yAfYyUTWyxGMRLff76CG8TwcwPcpyhczBjYDC091KJOhQl9RQ4lxTZRKYSIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HYaozc/z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pjs6vCQQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43PnYq906717
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IEpFo0lEJkHbippaH0NrsqLZL5lxGXEOzc/fjU/RBLU=; b=HYaozc/zkMn8F2eB
	OrGVRHENxoaWNrwfjb2Ls3ej8M9KzQ99ps9LIz2zDJGEy2HkRH0D0kQQuOi3m/6/
	wWQqKZmI93UBCaBa/KWJ4oHEScDBTbRdpnfKoTxWUVhV7qMmuolVy8UeiKQh9gb0
	Zb0NcqVMY3h18sqN78Q0Il6d6PZ0Xj4dv4mp3X/8HZcbheGLOZp4cmCv1xEoJwYI
	vC0wyUPFzPNJUuaW81Xt6MaWggtHrHzpPL509Qv6Sw/HTRcAQpxzedfiF86OSc1D
	5BM+WG6QpmZFF7FXPS2NL7y0NTYD73lbIflCE0DN6UZ0WfnPVn37NdqDO25/bSMj
	l1/Q2Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jjrks6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:37:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33da21394adso6326343a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241823; x=1762846623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEpFo0lEJkHbippaH0NrsqLZL5lxGXEOzc/fjU/RBLU=;
        b=Pjs6vCQQP2UAGi+JrSvCK3WgEyziLXNAqPXTVNBIiDQz0GI9KBduuVTGGyZ812Sejm
         KrBMv6pyGCBIpZiWyC4naM9NkVq9gE+D9nBtj119GuctMQ/ZBu+wzBREXED8o0OYIuMk
         NEE23w15f6agi+Z0s7m1yfYKNjlZj/ULVE1EfRRPNzd0cW8GPA0uF/4Pxn9KYFPUQIfe
         cSdGeyBwT54vJKsbq4ZecrSOV9zp6OosD/0peeB643oR/6zwAwUpdPlEokza8Y+FCV5x
         /bCcX6Y5CC7nv8IjNttFVf/XctkvaUubemN+v+KyW+S1ES4q9wKVFxdIyeeqS3zJWhAL
         ct+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241823; x=1762846623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEpFo0lEJkHbippaH0NrsqLZL5lxGXEOzc/fjU/RBLU=;
        b=mPTUrOg/2WGOW8E8dMxP/iX5v08yp5Hwdl8M3JuXFkdFdWR2ljK770HJhI+EJnY2We
         2AM/oUwa/Rc0pDdeUV67GKb/+Txwvt8O+A/J/YJKmknRgLMmfAqkBdGbbQAcNmBz2LX+
         F8p3SZQHPhnqeVys2N/a77gOv2fzOCxKrSF+goTPp3d+XTznFvFEmsOUqbQXgbC6+rP6
         GmAaGJm5f1DWJmkT7w+oaXYD4aOMlNwzx5sQv4f/zOP9RlGRE64+2aS6Vta1AFcRmit0
         QEF3mQyzA6LbkHoBgpYqF2fs4NiRfvnQal8NAuYGG+V70OuRo6mP27fXfHodJZ5NslKL
         XJBg==
X-Forwarded-Encrypted: i=1; AJvYcCXa/L/wGyiOrf1NxpJNQnzsif3PNOMuSGCz3MDilhKWDfCY8CEAU7WAIb+TFjOniepyg1dYfFge5UCEcAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9pVALJPRkRjp1xag2sFyN+VyAUwEgke+8H2qkxrKKdGEaXid6
	fNTRauujaB+zgRsZw4TOrte7vpWdP1cHt5j63W9jdbfOGddspwHgvuXOHpnhSFrPA63+1fvPaNz
	Miiae7nfpK4kEVFMCQ4hNGh6VQ19PWgESe1RVLgPy06bXaforwYqL40C3xZUDoyl+6GA=
X-Gm-Gg: ASbGncvSUU4U4R8E9pnLyMnq7S5Ol+Nmz557WG3VrcC8X5xKtcmxxUc9vP/4HPaX/bF
	ET/9wIUQ4k4/6D+56+F6U8Bod+FulX0c6wRc0y/58dTHzDnFuLVNjW0UgTRUY1OG1fmcMCceQdv
	B6zVkCFTOgevCe1gVml8Vj6LHyn0I5UrKAXn96L12MKo12zAgy6fFL7lJN0mVfD7iJPvNunyoCc
	mCViv4eSDnezvFPHLpUz8xq1hLFIehcEqXri9YYOqkrmbgaF6pxPaZPF5TaeoK1I34DEsKgr7Bp
	EuQ4fhLx0bRAb1dXS/hElVvskkRbFiuHmQLYCNtG7cBAOFcsWt6C73d08BcoL5W5eaiTyqWEhQo
	96lz3/Y9OLGdVytT8gCvIBOiarA==
X-Received: by 2002:a17:90b:1804:b0:341:124f:4746 with SMTP id 98e67ed59e1d1-341124f5655mr7592850a91.31.1762241822402;
        Mon, 03 Nov 2025 23:37:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKUZYkJDI1dLf0j5qnVJIPisBR1j8rmg9RpXmafX6fRnKyEMx1Js5oZiQ88R0lDTd2L+Qg3w==
X-Received: by 2002:a17:90b:1804:b0:341:124f:4746 with SMTP id 98e67ed59e1d1-341124f5655mr7592791a91.31.1762241821692;
        Mon, 03 Nov 2025 23:37:01 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:37:01 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:54 +0530
Subject: [PATCH v6 14/14] arm64: dts: qcom: Add EL2 overlay for Lemans
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-14-7017b0adc24e@oss.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=3311;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=uRDqwnYIZZpnXYckK3LJYkQkz8Z734oXrxzphtus+RQ=;
 b=70EsHNzLm0gWjM3OspS2EzG7Y816+qEMPjBVEodfRcAwLpAteTX2HBDS13lkYDcOZVel3JWlp
 +tg0Rk14Cq+DnCJq4mSm6xQlp41z3+YBqUUxTsoEi3IO9wlEctdszYg
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: wbA1teiWV3ghNrNWUDWW7_kzpsnqIYje
X-Proofpoint-ORIG-GUID: wbA1teiWV3ghNrNWUDWW7_kzpsnqIYje
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=6909ad1f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OUqdy03oI2q1KQI58CwA:9
 a=QEXdDO2ut3YA:10 a=eSe6kog-UzkA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfX/sneEW6QRs+t
 1bpTf8rkmoqOQzc3oAUxfkMr7uVLAJfhFase93Rqhgu7WIHYX1WavqQsJXsodlaBoKKsQaQPGWm
 Gy+/GUcDkme0Fk48zoHTXBB0/qcVt77Yu+h4befPMr0fcKwEv37Reih9+i3ezsw+O6aTIQVt03n
 fr7p/IEW8RWNG0uvaRjQRpg0R2zmoYmqKFAAKd1JbuSyBOkEz++TQde5u+bBA2YJEY4Y6XFt3K9
 d0vprOaWENOrwopCwk515nMxaMQhJRTOiRZFt1E407lhmHaovR8fPutJRFUpzdmH7sv3HkOnzD2
 Uf6+O7zrn2oWkWqWkb6O8fR1tWVCJYy/Hg2qaFo9oOOp7bskpQdavRo1iStd7aQ27fzT7z7FRbf
 Bp6Ojwnlr+pBVnQ/uy5DoIlS8ycwcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040061

All the Lemans IOT variants boards are using Gunyah hypervisor which
means that, so far, Linux-based OS could only boot in EL1 on those
devices.  However, it is possible for us to boot Linux at EL2 on these
devices [1].

When running under Gunyah, remote processor firmware IOMMU streams is
controlled by the Gunyah however when Linux take ownership of it in EL2,
It need to configure it properly to use remote processor.

Add a EL2-specific DT overlay and apply it to Lemans IOT variant
devices to create -el2.dtb for each of them alongside "normal" dtb.

[1]
https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile        | 10 ++++++++
 arch/arm64/boot/dts/qcom/lemans-el2.dtso | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6f34d5ed331c..56efd90b7a5e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -37,6 +37,10 @@ lemans-evk-camera-dtbs	:= lemans-evk.dtb lemans-evk-camera.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera.dtb
+
+lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
@@ -142,6 +146,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
+
+qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
+qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-el2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3-el2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
new file mode 100644
index 000000000000..af35039946e3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Lemans specific modifications required to boot in EL2.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&iris {
+	/* More driver work is needed */
+	status = "disabled";
+};
+
+/*
+ * When running under Gunyah, remote processor firmware IOMMU streams is
+ * controlled by the Gunyah however when we take ownership of it in EL2,
+ * we need to configure it properly to use remote processor.
+ */
+&remoteproc_adsp {
+	iommus = <&apps_smmu 0x3000 0x0>;
+};
+
+&remoteproc_cdsp0 {
+	iommus = <&apps_smmu 0x21c0 0x0400>;
+};
+
+&remoteproc_cdsp1 {
+	iommus = <&apps_smmu 0x29c0 0x0400>;
+};
+
+&remoteproc_gpdsp0 {
+       iommus = <&apps_smmu 0x38a0 0x0>;
+};
+
+&remoteproc_gpdsp1 {
+       iommus = <&apps_smmu 0x38c0 0x0>;
+};

-- 
2.50.1


