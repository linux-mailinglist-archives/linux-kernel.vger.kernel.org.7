Return-Path: <linux-kernel+bounces-771048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F589B28224
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ABE1D05F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24459242D7B;
	Fri, 15 Aug 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmiFe25X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4E253F2A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268674; cv=none; b=r8uPbiQF6Z/0mQx1MFPMg1OfB062BJZt+ZEGS5G94zMUv+gioHmYvCr1aFU4FyeAMGtSneIN8ZRTzgCPqIN0hSpF7+3xuRb0LFKm8IJDKc/LIJpDUuGmvC/H5IB+FJAXTU5HJvmIkBz70MypeYBdhBru031RMTKccmJN6cZYAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268674; c=relaxed/simple;
	bh=aVjEWL7maG/antUwRZHya+dEaFWljgNsHEfhHp0HFy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kphrXkEfaHIZINBr0jep+8L3M9DpCTBDJ5JxTL8D+GIXNK27407K2u+PIK4qU6AJg5ofPDYhUdwDzsiPFh/8l/iXWTEjAoClpfbMDbdR89OhAlnFCOw3MMGAI92D8BFQh5U0sjXqzG1G7XRWDoDBB51DTMkacuvj7tQFj+LaF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmiFe25X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIw0l022082
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i5lrrc2avf/a05fFSkE1yarwBF8oN7CO+XYLX3+cBU0=; b=nmiFe25XvVMso1Gn
	lLZBRnJ8G4H+V4CN7xAbTqbzeI1DmCo6p726nc1gFoxpqMkHSm5pl2FNhP4Q4Zxs
	S6f0MKxXXxf4dE6a2wOQJ+aYlOhRqEU8z+bFNEn9NkVDLAmGW6U0iFd+Gxykh6xx
	ke0oGTrB7MqSXt1ez9Mfjq/uf92PSMC2jN5dpuF+p4TLtzmH9Dg8aMr7tx/CkBuT
	Xp6+yAyEfdr5oczi8tABkaqyJkFodahG9SQ/Bdkj7mQy8AFfpI4+mK+e09gW8WD3
	6Jaatv/Pm1OSKqQtNt7WEQo+jvU14+Ru0KBkJIOa3nOw7HIAKV9DPx94nPl8c1A2
	F5cYRQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmk7t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e8908fdso1689023b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268670; x=1755873470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5lrrc2avf/a05fFSkE1yarwBF8oN7CO+XYLX3+cBU0=;
        b=RfRhjnyQH3NfEsNreMZwHPcg6KTrXu0U5cWiWFYYLy6pYEtEAV4xC3nZsFovw2uR55
         RNLm1v5teRAeojuHCgW5AFXgZnmHn9zJw64NDd4cQDXM21aH/wMt/XEEO6RfgqaS5JJX
         HQoo+50J1C9TBjvdomj2krQuabFgyRs/Cdzuyq+s5TMi9kkxAuukVRTjCMist8vivPEQ
         dxCG69uVo5AWr7sgW0AwRImw0gnMStNC4i9TjiK4Yy8pEJfagEa6pRlyMxn8z+72RByL
         ly9LttTrBJZufPKMynhye3ixJ4qSgn7m8DDuTnvStzm3qfe7h/tvEtpB36nSHd4zMPqz
         8WYA==
X-Forwarded-Encrypted: i=1; AJvYcCX1cKCnHFGPgsuLQtMeAbjQ/dKr4RbzJJy03o9dd90t7VnLaxHQSA/JqgU0lr9/9eTC5CLFDY783tQ5aBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Rd9XGNk5Hc7YBE4ZZENwmV2jWOZ+b8isMN8yEJm2klN1pTGu
	FqgjtvAz0dLFYXs/n6rPQossD4php84WWoNo3K8zd4RBVR7+ZFJNG8yq6udoN0TSxIBSANPaScZ
	hnyyVkROSM8jnjsqiif8Il4AelO9unCWnjfdeW69n1e0EYe6gmEfD3x0Fi3L37oZdUpo=
X-Gm-Gg: ASbGncvnO6T6SJdRg4FoZNuyME7exT4oJlEdG/qIQAk3XxLf5if95LEUaUWKTRXXwmN
	LPlw2GprHBFWi9+aHdDTIQJizZlghJr1Vir9LU2QT/OgEJp8/+amU88pZjlhVailoem+O4IJpj/
	+/jRPsNAOJuxOOq5FS85D3uv/Z7JZocPtnDK9ioYvPAuXCZZbmi2pMxjyPxJdUaspn68VwwflXC
	nyKTZ2NXl+9lVZlLCx8IcyVlSD2XCyh/CxJumkXWP4e9VnfRkno1Geup4IvHTgBtCYsVsQwjwIc
	nIa4frC+iZxXyNZ60dtlgQzeXc0pOYwFpDOZO0lRF9LtSrz3v/tp3nph7JKpIRh55FpOMSnlLUV
	C
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr4146108637.30.1755268670029;
        Fri, 15 Aug 2025 07:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgzJYKQGF6HZbbUlkil5MvM89MNKhgpQynDfRIXAkhE45tUGeJKiRVkBH5qpZTooaymsp6Tw==
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr4146065637.30.1755268669594;
        Fri, 15 Aug 2025 07:37:49 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:49 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:15 +0530
Subject: [PATCH v14 10/10] arm64: dts: qcom: lemans-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-10-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=1694;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/6iy73dToa0i0suzb1dVfuaLnEqyIE2pxMqX2jMdr0k=;
 b=GVK2pWwSQM7mtpgjB6rhLQwgDjqbyLzua5XFkOc/igbeTVSvy58+vU14vmU0QTk6gS8dAb2Ji
 c0DpCdq3PJFBnBgg7nhR6dYlM97gnoUxLnYhZvf4MXEdg7rrxKGCddi
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX4Fxm+aQsUxvH
 G2MTdZcDCpFJ1//XXkTdcp3nFE62GbBgfNejoI0EA9++Kn8ccWIqo9+IHeMVs1/9ic38LC9UxGK
 KpaaOEjxMdqjfLujEdmVNcFXhTCnmdWpagoP6WjMSIAnSbUYkYWSZMiM/UIC/VRpdgZhgLjkAsH
 RWy0UOHN3uaEhTAnoPAINVwWY7h4sSjlsTFnA6ckLnMHPSKOsz9Gl7uaAqCoLvbtQLvFLMgGmJR
 9JtQTEWTpfHS4qeHXzFDJ5JWpE31ynEM/u48DH5eoe27PAdP/WHUzINIYPBsZeOcJNGuj5ghV01
 ag59Q+I4SPKqfwgVQmmglZfGiRPYt2Krfj79jgaMJbDDNSXiNSOm4+uyi88D6y0y4zGC8rBKdSG
 5gwxdwkQ
X-Proofpoint-GUID: 0t1OGjdvg_idZuRqvQvWOYK7hUcHE78F
X-Proofpoint-ORIG-GUID: 0t1OGjdvg_idZuRqvQvWOYK7hUcHE78F
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689f463f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
lemans-ride as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi             | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index 25e756c141606fbe0876ed48a54809b372650903..016f0a93a432b5e3f5b095b428e0c3de026edd45 100644
--- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
@@ -722,6 +722,13 @@ &pmm8654au_3_gpios {
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
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a4770cee2c7d76cde1098d7df17a24a..dbcda335fe117e608950c20de9a87c7eeb6b5475 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -620,7 +620,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


