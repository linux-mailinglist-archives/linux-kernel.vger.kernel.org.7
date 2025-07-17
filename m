Return-Path: <linux-kernel+bounces-735296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749DB08D71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF0A66091
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D48292B53;
	Thu, 17 Jul 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2M0ijgj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027292900AA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756523; cv=none; b=fG8EZsXKT2HoXnVHhfQnRgWKbsRlJPhFJO4oEhSVX7YCKlaDX1tm1UvpNxHBgpqL93E9UPTrU6YnjZ69mtYFxWaLVh8AWVMX7IrCrmrcydKucjUh9DSbXw5z/Rq5lHoV8cOLPDbuZsKtgsUGLNGL8qu+B6D/4aRFot/TBokVp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756523; c=relaxed/simple;
	bh=bDYj8SCrzcBMYL0De2l91EChlN4ZQ8qlnKnsadPkWH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7W702eMw73m1k6QIs0PQpN2tYQjHzagXapi2fOah3On9oIZIuDvCdwfTUAnBAXfQ4sjXM5ueetBWmlyvtj8MbxVZQ8FhSxUYsek6rHZB3KQTgrEaLFFt2fLqe/YhYMHlImwJoImiL/72sq1OR+iXxBYb3JK1ROd5dwYlRn83qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2M0ijgj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBuXDn003003
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zO1m4Mu1s9USWMxZJk5OY8bYzy46q5JS7Is6cMJU9ok=; b=m2M0ijgjpDIH5XHA
	kGFkVZjyT6ODkzEFE2I1liMEz3vA3GDuXvCBxEgLJtZdApP1Qg+z2SZMZj6wKL6j
	XllhprhyvzeaG0nhtCMjqWRvzuLB5j3y+9Oa/BcD6h/y0//Gu5gTwqZ4pszCaII1
	MBoSuWqsnfewV7WPdP8SSvZ12YipgaAjBZEAgr4JAOpHFR33VQ+Sj+oUu7TedBsE
	1vi+rwPcxKZrDeVE4M5zy2//hAucayaoY18XKg6Z8F4s+m3Ghd8CVBv20fwvCqfj
	PutqdmNycq53BGQ3T7EvXT/vF1I4NuMaECqvpJpSqNIpK5A4P25iRmpa3qLC0j+0
	CksERg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsuksfs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b391a561225so746872a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756520; x=1753361320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO1m4Mu1s9USWMxZJk5OY8bYzy46q5JS7Is6cMJU9ok=;
        b=fXKMPz5RERkljLgv5piUq7ubbEH77i6KKvt+JHy6o9wcfgldbpfXNFQuqMR5I6kurd
         JpTOwALxbrcX7bjmtnivAuzoxJWws3ynNnBByNbLwLI6rXRJSoejJcgoXf0eAjHE8rzp
         l7B/GSGMfnU5LIFT7CF5fHgPttuJwFXfvv2tsZ0mZX+R0nxRZwSNsoGnWsUkEQLEIIkB
         Yiq1+hIbHEcoBTar23EdHCxyawPRggKGP0ELv2m2/xTmVSd8FBXeB6SX2iaiU+m4RIOh
         Ugub8jdPK/7A3K76+05aDNZSb+6xtMAOksreKnm/HBRLLPkcAapaOlQr+nmKNw4uPKGg
         VvVg==
X-Forwarded-Encrypted: i=1; AJvYcCV/v2V4vK9hlK2dtbGAjDC6pH5ot04qY7gH31JJWDVSyzADYdiwXGyEt8AUVvkZmzcmpymCfVNu5j4EGUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjIYN7OG+OLSp40Vg/+PQZI4B31awLgnTPuAV1NOAxh66Cpwv
	m78/cx29Y/o4mT0aRUwUL8bE7mPZ6IMepNIlqOmWzlC47hoKwsQFbBe0ldMxYoFBHxKl8s+XtrW
	vvFuwTRp2R8mBUXOh5uL5XV5sjc0eCKs5re12TwAQNMtbrZgwr1H1Uv7gvd+ztO7gnbw=
X-Gm-Gg: ASbGncsCIjxr2HxXuapsHdy3tnLRHI6zWHEEOaa4yELnxJpW8FElyIzuwEWSKKBhIK3
	pxoTulvIutzuwzKAtjhknHXC/hItf8YQ6jiU2Don69QheIP87yYV8RG3f2XMLiCGZ+j42m6MIRx
	mWk0GFpEzE/oNZRV361FQvJsfPY8TXQ/ZPwyYOYPXKLaFhGdOGnUckYUaID6xnvKWyza/kGJr9J
	n6LWAf+VBtPR7uYxYyEU+JTyPMIwvKxoqLp7LGaSQPKFfa8z3kZ7jHGIrn/IC5HWHjzpvehvicW
	1RWx0UWL1dgcxv+kXn7kLXSAuDD4IZf0HZ7vLESecAZVtLyTsWjjLKpUhNg1KHAfUbQIur6qf30
	O
X-Received: by 2002:a17:90b:1806:b0:311:f30b:c21 with SMTP id 98e67ed59e1d1-31c9f4b40a8mr8772549a91.26.1752756520543;
        Thu, 17 Jul 2025 05:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXMBxI6IZLFJW1s6JPc9VrE1ngxmouoIjEDFAd9i20pNgJNbkO88UCtpZcIP58Sg3KuJiB5g==
X-Received: by 2002:a17:90b:1806:b0:311:f30b:c21 with SMTP id 98e67ed59e1d1-31c9f4b40a8mr8772503a91.26.1752756520031;
        Thu, 17 Jul 2025 05:48:40 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:48:39 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:53 +0530
Subject: [PATCH v11 7/8] arm64: dts: qcom: sa8775p-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-7-df3e2b2183c3@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=1668;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=nykICX8hQVOI73Pb+LH6QfNsfIbx6Lek13GmZ+0SmB4=;
 b=EiF8IZxooW3vYhvtPrDfdjqeu8GiMcEGqyXXqmthd53rwasr7uw84mgWXdkL1gvuf8BBZ0DON
 MDQxMZOV0SIDfo+q4a1SmrjVCc+0M5DF4A+sIyRvJ9Q6hTTHal1B6cE
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: A93c_99gQ9QS0HZCcF9OU_0il4JDPj_K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMSBTYWx0ZWRfX9HjmfR8AuLbf
 ROSoVdUtBJoCIZtKxCwTFuRs9ytI57EQvJlObCCPVTv3LZSWjnFScuk1iC/q5tFb8Kq1NaxC/dF
 D1UjEqCgFdid6L8008vk4CT3Dj89x/0wVkV5lS0W90MRfb5tCE1QgfXZcPBAeFZOp40Xn+9v/1m
 kU3Jm108X+2S2Mv3L2DARIUcIMIbQP5YetKeqojtmrPsbAmNYh/1KtL0FtC71kPUb86QWaTp+eD
 SOrZoHbQWpZP7o8n3qb7Sq+2Er/tGzcS361rHnmKPKI2KHvt/eFhmiM1+DF7dwlSSyl14TjHqS7
 AqQ6JOsiFUK17Tqd5oSwh+cdR8EaJqw7IyAvIpL7DYy4FQeKhL0QPXdeJKbH+D/LeAGYJPCo7aS
 TQL0QhKRIG4HlOl+zUXeJxuKP5y6aD6XaT2l+Ton0DJuG3lgwmVH8ru4nKws9UKTBrHF66GD
X-Proofpoint-GUID: A93c_99gQ9QS0HZCcF9OU_0il4JDPj_K
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=6878f129 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170111

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


