Return-Path: <linux-kernel+bounces-844547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3FBC230D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 731794F7CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4302EB5A3;
	Tue,  7 Oct 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5G9uckc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD42EAB83
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855803; cv=none; b=d0IhUjhBe256WAhZLHQRhAWlIbHlHr8Pa+zTnnN3jZ6FKz4xsdP+djjrwL44hbN04bQCZTXnSNGjvCcKZUxoJaRx3eonYzsFi23ZhtsMfnM8LJU21APOOwHQkP6EDTcXrHdJP5/qarYD6Bp4cZzz0SHAyOHEXE7PXUNffGIgODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855803; c=relaxed/simple;
	bh=F3NWSBYzpCkjgyaRvqE1+rv4nyzrirHjZJXt87AtH/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StK+EI18p5wumzSquP0AjV1AD6hTBSA5jnVeEduta6/2eji4OMv8zFSHZ1uYtGRTAmN039O7sv5jrkVoVDP4YafFn2RoDAX8yC/JttH1otdosBVrYFhxcRGX7F+0OH64fvgZxhbpfbbJiNZPpSTC5WBcPDYlapKuT5QwvtX4kHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5G9uckc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597Ek60F011256
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25H4FuSYBPF18o2Cn+NmxkJ4j3R4BT0xsk49N2ga+sM=; b=R5G9uckcBRl0Byi3
	ZF60r4LPFlKZWB6RDtH+YZ2sftEXqkeEFhXAL58MVS6MRoI7N4e45lajsgmwvdqd
	y0SZqlwLNEIjSGK1wGP4Hkhhl2UB9oDcfLyODNg7DAYJOYIWSiI1Uwy0ubZ17Wlh
	1hJ5cVILmiz1gx4KvhZBStpMaSWm9PS+AqoX61V+r10cpPke6blU5en4RfRz8wKa
	D4hLUL8OZTyoKRQzNE8ckDZ0w/xzhXxThvpV05ovmlaTr9CkHfL7oBn6jH0P+CTi
	cMR2H60tfaIrPBVgA10fH/0PKRfeKIGNB+ttC7k7A5DMj0LjGH0rfOsT50bylOvN
	Kne1BA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wkrcu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:50:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2681642efd9so63172425ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855800; x=1760460600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25H4FuSYBPF18o2Cn+NmxkJ4j3R4BT0xsk49N2ga+sM=;
        b=Lcg6kSTh99r3P5XJDf9nXWkeUWzr50AYBhMHDDaIJL8Vf+4dTBNgt5UUQfrZPuVn7r
         yk0SWwTLdM1g3yHh6Br/b0xYyq80eMOeCnNqiwqJ3D51uSBdMFZU5Apo3N5ePMrkKWjH
         IrI+ILwhR1aRNcNq0oeMeebD3Az5M41TyWChOaPG2EMDLdKhvmFCNC9dFcclJna5D9RD
         RXJ0fxL35O1CrUAP4hJJy5EjJRv5zEWp9AyDbY0BKdfw6KCG4PrEyQb+pcueoPjUfuLF
         NvwW9dEYKaDLI6NiMzsx1hPOeRBMNSi2MYTJuCDz6zuJhWqwyR1w1iNjnjqu68rGzw0l
         r4HA==
X-Forwarded-Encrypted: i=1; AJvYcCX3sddfYzNWHdKrrXCtErEb2y5czplI9WPCMjMzM5dn98U3WbrnpaT+O/cLzXSw3ND9Xkb5DeYbaRQ9yKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGwc87CXxNrwuEamGhspWcwywTvKk9D4oeDBrV8ESQctwXRL9
	AeM8j4GWJKBXKsPRUFkNLYWu+pD5MMrIOI3L5kW+wrgGhPZKR4i6rcAv0I8HotZkQ5SAS3CXUW+
	nAPOcaXcx5LrjAUfV0UIRoEaXe1x4ZL6o51XHA08os0jNeZgCRwOJeIv6QSCB5cb+8ss=
X-Gm-Gg: ASbGncsxqRUMYGcaA5G3gNgln0Gi+h04NqK15UFvMqkvbftUNna9YqaEwIGGkNLhevd
	/D+Me9Bb61xynIf/lWnPJUBxhY4BUy/oYnfLSxprRszHas/WRrfMcALQ8/ramHUggrQEdt8dEDi
	CRriAzqkFbzrcE+0Iu0z3yIqtev9npX1ljrV8yRD+g7uL0r8+tUOUG/pWu6wJ4kWPVkedrZo9Wd
	7WAqpkW5HpOmveF41pNuAbz7gUG3LVtWHMSysAqKEDbNWpJU8Ca2gRl7Cy1MRjmvFYmJ2tkUHnT
	b7fprwYsAu+T+CZamykQl0iNXOaTomyTj/L+GqI+u2BppqJRE2h7slzTRny7D6+jyzksK9WO
X-Received: by 2002:a17:902:ea0d:b0:267:44e6:11b3 with SMTP id d9443c01a7336-2902737494amr5222755ad.45.1759855799549;
        Tue, 07 Oct 2025 09:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIi1+jMvYM3hfkSwfZPoQPAWtPLhTQvtT8StZu5DngvXCi1e8+FlEYG1a5D0B5GmJw7emrfw==
X-Received: by 2002:a17:902:ea0d:b0:267:44e6:11b3 with SMTP id d9443c01a7336-2902737494amr5222335ad.45.1759855798963;
        Tue, 07 Oct 2025 09:49:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:57 +0530
Subject: [PATCH v4 12/12] arm64: dts: qcom: Add EL2 overlay for Lemans
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-12-de841623af3c@oss.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855751; l=3459;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=F3NWSBYzpCkjgyaRvqE1+rv4nyzrirHjZJXt87AtH/U=;
 b=uwqnx7wZmY7J482R8H4+UHEnKcuS9Z5RTeTM7ihPD4/cn8vP1pcCis9ZCl7y7vpeHg8IHiOY0
 tLrdJv2T62uBOHMcq8DBGoR0DJpNfp5EUkG0GCA+NMoccnyGWRVKyiK
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX47rBhRjNyc7V
 sHssz3k9QuKD08Y8uW9xnxXDffV4EjWCk1hhHlznKawl3P8aB9yPSSoEdLtk3LSX4Ob8evZRj8L
 +m+aGi7ejQVCvbwIrImrX0yxVcSQ84U1AWhj+sngLEPURG8bwAzyugbYQYD5RY8XxMJeq6YPgED
 UP5o0oZstg9zbFqO4dz2sHxjBtdeQJttEYAqhmJegcMlP3L86d1GG8Bd0chDDjzKQrjRbAzDniP
 567u3YaCrpxS8hHH0eXAAcxcTnd4+8Z1KAA76/MYMyQy7R0U7CTUMU7YsgwiQzo3nlSpWidMs+m
 96XWeeCWSlJttoO7TLnKGf509i0ABMesMM/RMJ+jQ3A3qizfC84xYlmkIYc1XsCuHzNXTZ+Pk+9
 WHc8OocNy2b3v9WY/dfwnpZ/KOooLg==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e544b8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=YVouBxmdtFDgX_swM-UA:9
 a=QEXdDO2ut3YA:10 a=eSe6kog-UzkA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: NPDp9yiCo8P9nxRfRjkHvsDw3bujykHY
X-Proofpoint-ORIG-GUID: NPDp9yiCo8P9nxRfRjkHvsDw3bujykHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

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
 arch/arm64/boot/dts/qcom/Makefile        |  7 +++++-
 arch/arm64/boot/dts/qcom/lemans-el2.dtso | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 296688f7cb26..e2eb6c4f8e25 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -35,6 +35,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
 lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
+lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
@@ -136,7 +138,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
+qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb qcs9100-ride-el2.dtb
+qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb qcs9100-ride-r3-el2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
new file mode 100644
index 000000000000..582b0a3a291a
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
+	/* TODO: Add video-firmware iommus to start IRIS from EL2 */
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


