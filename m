Return-Path: <linux-kernel+bounces-747167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA359B1309D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E3B3BC6F0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DF233145;
	Sun, 27 Jul 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fUDksuNJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9023184F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633583; cv=none; b=bIEXN2RaRAcWOwUo27dPiJeRI+Yw5KCIh64uewqyWNx6C5J5iUcEHTNdsaYIkKdAoRHXZEPcMLKF1Imcilx5tpX36kjzeqGhmOJQsCDrGANvTGvSbxNu/EFuKCRDhJAovzf+RgtBhoncqFKpUGY0VIeka+QH4BYOgYcaCrVM67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633583; c=relaxed/simple;
	bh=bDYj8SCrzcBMYL0De2l91EChlN4ZQ8qlnKnsadPkWH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qE54vjC/NyPoTgBIDw8iopkARMzyUHd9XakUc8SWPdbM1esVFS/08vCFWt5oT2Z/NT89q0M+qirUsDttzG048ZfqcWPBa3iq0gPEmnOtX/6mm8KlnBjAAHPeezNmNRrEBlJ6R/cRwgKoNdyuaa+7fola0B6CEJUMMB9uyP+FbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fUDksuNJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REb07r008554
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zO1m4Mu1s9USWMxZJk5OY8bYzy46q5JS7Is6cMJU9ok=; b=fUDksuNJD70l19bX
	6Bp4yt/V7G/bjPloVzd/OlS5eM0+YroiuqBGLwcrg9agTSJo5+F8RCQRj3CQb0Id
	iNaUwmG4q2Fbqkip3En/1HtzhZB9lV3f1P4Ia5tfnxiAlhk+VggNydXAt3i2gzOJ
	57zsbO569dh5mSwQ6bueeXl8U7s21JVaJmdfzHk3ipB7Ag9VB5YwbDmgSadrhUMD
	Sf+iTjmOctGTI5ilmWL9G8zC6taZRvRzMG87y5fsBUIRBS8Nnus47cysgZvjFKvg
	nkkn8saCL7hHEwffzjmuR3rApsCutOEIrpvXWfMcvxjHPNct+FcwhrTrwBhj7kKM
	IP3nbQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aacmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:26:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2356ce66d7cso60425505ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633580; x=1754238380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO1m4Mu1s9USWMxZJk5OY8bYzy46q5JS7Is6cMJU9ok=;
        b=eu0hyB98SLqt4TBLd81NUSdIFM5kRVSZqjuNo/1FsxTxfLjhHnd327vX1j16QGWvjy
         IVQBHuaRaWCzwkqfPJXZ+rD5saDRfLDWJtFMJ0LdbOquNPLAkqun8DqvcGbXsCboNMQL
         7t9zhNmg7n0QN+tZoB1TTo1cWBpjgCyZGxGkrhAAOXL6I9Sq2dkZglD2w32Tiebu2znf
         gJ/4KnR4iZn32LugntRaepw4HeXVpDZ3SAh10UfkWnHcbqVP6Wjh/G8usK3rH/djZpvW
         oz/q63fNeD6Ac6vhSHUWcGUOdOYkrnH4OxsXSHgJPi58CKm0TFzFyYpqP2YBdtBd5Y/K
         QJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVHbBoUw+AY0L7rN03ScJe0VnCvGo5LqRAGWNUZ1vp5t+qWWyZHFhMI04wsTJsscL6qGAErDALPX8lzF8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YysibuhbSfF2kZTXzsE6e7qOM6BZrhqGalofyrGU9rpPaZkWM9r
	Bu7eYhRw8ZGSz1TPPyYMKV0SfuCStAoqlV3VeZl1vNE6pCizlBL3MZ8QSBxNr9b9wVeyGlj67QM
	lGlAVrk8UnWHdFz9s/R2gqogVre8Y3stL3uA2RtRqexHNKP9V2e/dqM4ZUNv6ANvZSxk=
X-Gm-Gg: ASbGncvkPa1pg87dKQaFlvhG5rBOKg22HYa40GVNMI5jO63zmia8++gCSkLpTz1Jmnj
	DSaASM182mrrZjwnv+7C7sU1LGzm2CW4ouOW1IhlQbnyMZRcWlrWFKGqOPvvIVoftwDOUeBIBdD
	WLnzPl3QsOt14xghZndy9ApuKBfUHITb5XO6CBxHWGvSWHHmBxb2mh8gTQ1TJVB1YYmpijPhsJe
	gVZPKsVajtFm975kZ3egAbuVLLaWBOjswsKwyU1+p1vcVadzLyxxmtrkTJXdQ0Z6mnEojDpP2G8
	YYEW9xxx65wyVTyjkaCty3nOL6RIWK3ncjZ8Etc8FzKtXy1GeKLDAHav5gfRHi4KYX0A4zNncDL
	y
X-Received: by 2002:a17:902:e807:b0:235:1b91:9079 with SMTP id d9443c01a7336-23fb31795bfmr154382685ad.32.1753633579809;
        Sun, 27 Jul 2025 09:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwc00XkR+di84taiD/OffOGEpCSV4NomuISb8nymc7JO+HaEUAMVPaylTxckUGH7O8K1y1Vw==
X-Received: by 2002:a17:902:e807:b0:235:1b91:9079 with SMTP id d9443c01a7336-23fb31795bfmr154382295ad.32.1753633579320;
        Sun, 27 Jul 2025 09:26:19 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:26:19 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:53 +0530
Subject: [PATCH v13 10/10] arm64: dts: qcom: sa8775p-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-10-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=1668;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=nykICX8hQVOI73Pb+LH6QfNsfIbx6Lek13GmZ+0SmB4=;
 b=qv8WQ4rhMzRIfBTQPcknLWKzfFESP1pOGTqD92zp0OFhxDqrgJbvV6E1LADfVHcHGcJQzUbqr
 o9Pw1v/PWgrBJiJ8iJ/4KEdXWIzCIiK4N7VGCBXkE8I4eFNERL87qYr
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 3ttbrmb8lbxEkOBWq4A81Wxg7QbdJofD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NiBTYWx0ZWRfXwzZ9Gdwr1mOe
 abWzhKRpiiLIKNQp94FG5ZYngLEAtd4cGrIv0H/CfQH4DGnLXQGZcjuHWpx57IbbbSrBCWXmyOr
 2u6DMDlU/OYKgDYCgUoLzBJJ/yXi1zXwT+xoF2IGTRCOkpuKCGsGyHkaHalCZh9OBsXsrjKrs8L
 n66TbQ0Ssycf2FJkyqBP9Q//Bt7+iRkIIDa4j4obQPnmxsfqwJRsXMzlkm3NQUPC2bG6C1G6JKV
 lqid3nZK/MsJVv79hA/l+FhoBugUULvO+MGKqSq3SIO4YIUY+f/Q+Mi+AsJAjmK6JBm/t4/Fyph
 X6t9w4dyUtZ+EITeJugCgPYetHbvWbwWXguO2AW+tEEDb1fTgCqZPf4XhanL88L5O6cEbWcVGoX
 HWFnA1s3zPrD+Vxf3B8umZXWAIhdE/ARJigPPyrYpJUahcljSEODevNEy8y0dSTdUg4PfE8n
X-Proofpoint-GUID: 3ttbrmb8lbxEkOBWq4A81Wxg7QbdJofD
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6886532d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270146

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
sa8775p-ride as reboot-modes.  Describe the reset types:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 63b3031cfcc15fe2cce58c0fb7502b19f058b80c..b1bbd3270afc65e9e036e8098ae7cec3d3363a32 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -874,6 +874,13 @@ &pmm8654au_3_gpios {
 			  "GNSS_BOOT_MODE";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f57d7894dc1eacb6a809caa427c6c4..52466607035e663f4dc6e5c97223d5c0404650e2 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -622,7 +622,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


