Return-Path: <linux-kernel+bounces-735294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83540B08D68
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A53A66098
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B82D63F4;
	Thu, 17 Jul 2025 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OleD3QDM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EA299AB3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756509; cv=none; b=UfBLqr8LaeL33RM/rbHCRnj0jzXHcj7yHCOL8c7pnBfE5ilePMTqj4E7+eG41uglLEZnDSMQN5mrCWpSIvmHGTxy24tSTy5DBRneBi4I2AF0R42qT3eagCkk5Hv3LmUBPRxWPSEP09/b3F2MvKlTBwuL0GPUp0GTxJEutxbKNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756509; c=relaxed/simple;
	bh=n0wa4AEusSMKTJa2REb6Zm/CPFmojeqETl81QHufxBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRxJBrYZ5C6D8uAXDUP6OOOFee9vNtMH746dVjAyKMpRUl1Ew5d2sfVXxC2Nb3JpymYcQhYvmhIzCZYyD/HwXd1ukdhN3XK+i4QvkqDLKAyFqpg9GWMP4ZD75p6qAZRDfLRMXEFW2LmUhxKAa/tDZraNxW+fvlu1iBLnfZG6aA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OleD3QDM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBvMqa030488
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IiMmHpQ1bB+met8QLJcdnw+SCuV4S6OJO6VsyYvdUS8=; b=OleD3QDMSnB0kFR5
	QbrMf4A0Nu6i+xPLTRqU5b5RmVXSxaZ9+rrFo7PY++s6xYefUKFJNwYxZU1AMc/q
	Wd5vTJnnNcoNSdYZLkFZOIEcSv4aeQ753yuY5XjXYfeX0va5UGRrafeSM6GD8wq1
	I/SM2QArHsHlDdIfEoBN/Cg9oKqf7L0FMqVWNhmwhmOfZXkitG4dH4zww7+I31Pw
	1yNtfQ1YzGutK2wNmkolBBbUat4okFLBOmmyHOAzuMQFFcixxjKQBaUmMMwLzx9w
	SZdngh9Ed5PULMd/8BHHum3RlagD27Z2ZXEc3vHxB6aKHSU5LVQ/nj3x4Xk/ix9M
	HgfE3A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7mgmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so885389a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756505; x=1753361305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiMmHpQ1bB+met8QLJcdnw+SCuV4S6OJO6VsyYvdUS8=;
        b=QDZ2jC/Bce5Xu7L5670NWAXHaoy0fZdqbKuuK1FLkftAN2/ENX+sleQh3B5A3xuUPK
         Bh1ovRgwkmoySbB8yHN9aBwIEQwg08IY6Nfzwv/vIEqvzeSIfj2KLay0tuAT3ss3SsD4
         LbnVgpkvqJw7rV3tXOXY8h/5JoVHkYhljhYtp3AA6MdSwemEaWjM3OYZdRMb5aZeDwYW
         7M4B9240dUmYKfCRIjMhPaZhtGybEIdAZAjHBIGSOxU8TJSl2p+v6U+bLQlSLhg7d8r5
         e+AjuEnRORow3rUGEgnT5qDbjlL/3ugnSiXuPAN9N0AwtcLLSgvNwZBp3Y3gG7+2w+mU
         Pz9g==
X-Forwarded-Encrypted: i=1; AJvYcCUjyTM8Sy0Hl5v01Cq70qaER/10qPXdgvWUKdnrues+uQ+Mi/Kd3Jk0bg92hFX7rJjewi+BmMl45th51Po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtc/cAiba0oE23nHSFnGxIdo+fw6yyMfb0K0T90dHWGwbfU7ns
	bjw67JKb6Fk2KhTnDNril9D4MQJKOFUt5J50V8bIz+QLDv8/Zu89VGAV642tg1npctDEhF/kd2s
	YfNf3kr746yZgN7B+FFEMVS3aGtdfN1blTJY1pkKFsvwxJflys2IDuFKGGuful6Ftn3Q=
X-Gm-Gg: ASbGnctBams3nfM09f7e3Pp4Ww7FZM1/V/f7bvzw8TUX7fy9cmYjOkTwzHJ6vvrnXmE
	efCMCabvox/IC7XHI4mrEs6FIek5fdtLG/JIvZaGQsBZQpqUkcRPj/ji/mot05ecojAzxEpoUpz
	HGpcbaUWyj3D5u8V1ihUtkW4DPd6mEALYG1eB3ht6IZal8e3gIbTM4RtJWRbfop9HTXaQHxAolD
	MUVrcN5JPzc5BeiG+m/yZT5VjTTKlhQULYKV2X3O9A7nKqyYcsxjniIhek5zI1+LN87aOa7je+F
	LyTIF2SzUiG0tb91ToLyq9I7/0B8AkNQQDgYAxPL31x8cvaZItR0yUeg3163uEHEVxtvMkhjApv
	l
X-Received: by 2002:a17:90b:3d8c:b0:316:3972:b9d0 with SMTP id 98e67ed59e1d1-31c9e5fcacfmr10321289a91.0.1752756504217;
        Thu, 17 Jul 2025 05:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVfbBlxohsXCc2xaE5I67a16rXLDbWY2pLu/jks1PnLsDto+TVjiDWxjRUtHLmCkYlmqeVog==
X-Received: by 2002:a17:90b:3d8c:b0:316:3972:b9d0 with SMTP id 98e67ed59e1d1-31c9e5fcacfmr10321217a91.0.1752756503454;
        Thu, 17 Jul 2025 05:48:23 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:48:23 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:51 +0530
Subject: [PATCH v11 5/8] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-5-df3e2b2183c3@oss.qualcomm.com>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
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
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/OISjQAhUBAIE37ASE5b1kssDpdL8gfQSFob68FR4qs=;
 b=XSN/9ti8C5qipL44dj5FAZ2QRrNwANKVYhyqlCyp9SwpFFRbw/wawFmv17T5pBXhvUzvKxmxu
 NFzHvaaVO1rBYtjuTYcep97ASAoayTlgr9TSXw6xEqBBou95yYoBpy3
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMSBTYWx0ZWRfXw8uXuYrRYaKK
 mX9ST6x5bmRMnSAaeWeHK+EDGZs3l4muHCHkXtOI5lTsXefSi53iobfFbUXAT4AFqaYealP9NbU
 vNRXKIlaz5VSX+Psobb5EyJr7hpPHwXXmFXrUGjPVoEci8U7HVzWRcqkpqLL5YV1ra32jJS5Tbh
 KGoVkeejLacHsSkRNoozFq99wiKHmH5mhUiaE+Lt6+A9/fZBeyXpw0/dJLOIU6tAwSJCKOEGvrT
 /uTudvgyc1N5E+688sup4OmTRM4Mf5IrDvhpF7bT0h1LWSHLWtwxJwMb2fdZBS1CySXxh8G0WMG
 DM8NRJOeiYAh31Ag88yPhZ5ROKUJo0qr2BBkW/DlIzj5YrPExGcznccCGDxJEBbZN1s+ucBIyt0
 lScrJrMitncWn1OSDB50YJ9jtOrewdAUJEyjPdQuFd4lMQdqe1hbZ4AvC11DwTjx052IPju1
X-Proofpoint-GUID: G7wC6EExYBGoPaMutgpL5zPdow99eGxn
X-Proofpoint-ORIG-GUID: G7wC6EExYBGoPaMutgpL5zPdow99eGxn
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6878f11a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=957 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170111

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcm6490-idp as reboot-modes.  Describe the resets: "bootloader"
will cause device to reboot and stop in the bootloader's fastboot
mode. "edl" will cause device to reboot into "emergency download
mode", which permits loading images via the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 7a155ef6492e176390faa3f2dbe419f5cfa62f0d..d25dbdde7dcee9fa3f1bd48a38baeae0f063023c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -654,6 +654,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..e6a99ef50b9b9ade9d2a71a14fcde429f8076dd5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -857,7 +857,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


