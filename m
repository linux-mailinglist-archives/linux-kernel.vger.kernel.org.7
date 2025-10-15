Return-Path: <linux-kernel+bounces-853751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D0BDC85F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A23A7DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7F2FF666;
	Wed, 15 Oct 2025 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JBW3ymbR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA932FF665
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503221; cv=none; b=WDrBAxoQ0TX4XpTtV/RUXpZ7RWktdClWJ0Bd7C7TMZWV1aCBusrgb7cxKjMUg8usq70iQOv0+Q04kbjCid0IJlkhGtehm5s5oW+AaOzBifKlE3CekmZpcIdXnZPSNmQXvxz25hcTED1v0NQJrxmxC5oB3tClqX/cjrRWvKeE/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503221; c=relaxed/simple;
	bh=1jBpq+iZuKpAQm2NP3JS82veq+AIv0X5C7ExNAj56cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBwftxEZ94warw3Q0hM8zIu2cCcj169tRBJ1Qll7glq2YGERNdiH8O3iYq6ux/i/toYjFfAskEObrlaqs0gBzZx9SSgOcOZbxL2nveEmPw4PCJ108C4mMcCvrju7qymxPnQFPfzTS2F+/BHx4xJV1nvPMk0i43EJ2CHa2O3otH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JBW3ymbR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s9Ck004010
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaEbjaznfRKEBXAo6DFolWZjwipbscJpuOwEOXljFb8=; b=JBW3ymbRgEgRQwk4
	9rv7Ah2KbwTKe8OLqPy27Cp0xo0puRSYiInyXzZRHgaQXIwUp4kZuFgOmmXSNQDv
	fgrdEYUug1DjCytm+MVRhv7IRAOgU80iQqLoc3MBz1hXUAKWjUJMJyjhhUgL7oXa
	d/4s0t87gs0lKiXZoEDXfcpBOSiAhcEaiUII15KRlE24WuqqiDlvUevOOZ/KToVn
	/p7HV9w9OjURqZxkSF6D3F+E+6s9ciJeoxgBAbe9zfd9vdx1WH1Kv5vaw8mYjIhk
	HHEecjNtC4zd08X0okkke8BMqS2xNBo7hqW/+9732xCMhSjptXSiyh31LKY2waQv
	PWBZfg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg2wka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78108268ea3so508994b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503218; x=1761108018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaEbjaznfRKEBXAo6DFolWZjwipbscJpuOwEOXljFb8=;
        b=VhBQWjY1nIc6WHusC9DRHtOO2dMDjSbAjFdV7qVNQTlS5slx2vwga6/jeDlwHBMzn8
         tBeVlCF6lf1a25c9LoG74NnThXAUvasL9ySxPUsYS9DdV/FhMK5/mVwzdFqJNfjFnn7v
         FFAHZ005GFK7zwsMofus1hJpZBHAOxGoXHGoAoLxmlHXmYuGrnDn6k949znMnvERktVk
         ytpKIZWLRDrjUXjlJMe5dUI2ZFcrUd94n3bAZtjlIQMm0Os+U3h7g4dwd2WW2d2kV3p7
         19ilcyytLKhpBkcO1gBxvuqakHPt/knzEcrNbD24FlmR3CeKjGrLEqBPoEZWwEgeVqx0
         Kb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3jsK+jGlxbrSfa9U2BsWN7E0subfr9cZ7NGU9FvFwhLD0bEdYOAhnuXE8WDrWw9BTxIjgv/eSj5zT9f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0xucsyLmuGMwPEZ2WHqypiIN0nk++lXBdMEMFljy1g6kL3NN
	p8FDQXfc2DInMn1WOz3SbeVNBxQ305Ta8WbNmA4PbIg8G48oCheilYN7jPmDBzYT7p5pJmsl4SO
	HBNKN2sdIoRH4QkNgShBGwdTU37JaLLxQO+ngjIVZ8BL45dJNFwGgu6qVY3YVY6aJq/M=
X-Gm-Gg: ASbGncsB4v5iFyBGYbYM/ZuTzaTwCl5Zvu7a0NsSd6OCyCAugCALIYUklRBQwiryov3
	LSXXuQAfqLApJ4wvZz0mTuJ1rJUqFmDU2whspgmgPaeTUtL9rmyV5WMornOPDnpKOXQQ0ZzCNWI
	bPIVIX2Bt8gNpC5Wh+5K2KG51pQsy0IvZppGc1Ho3lXxIVKNGa4BUuhxtDFcwAM3vGfaxO0HkmE
	02d/+RsXtn++x+q5xn3c4dn2RV4LZBgAuAM3rJI7D3Ivy2Vn/FIbXD/+banjrrGqrYZfiSuMHZa
	TF+D0/v0oKkT4oeLTmfpQIyptgP3cywVztCzraDuCu7UB0qP2CU86SHMveo54Xi84N5jaVtPaR2
	u
X-Received: by 2002:a05:6a21:33a8:b0:327:957:f915 with SMTP id adf61e73a8af0-32da8fcd0a3mr34162507637.24.1760503218184;
        Tue, 14 Oct 2025 21:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkvW707uWwbvXiG8keTQAlZReMI+HRsSwGyMxnWPsRVW43EYNt0vrSlWIfI3lMvZSsHDMDGw==
X-Received: by 2002:a05:6a21:33a8:b0:327:957:f915 with SMTP id adf61e73a8af0-32da8fcd0a3mr34162469637.24.1760503217682;
        Tue, 14 Oct 2025 21:40:17 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:40:17 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:26 +0530
Subject: [PATCH v16 11/14] arm64: dts: qcom: lemans-evk: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-11-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=994;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=1jBpq+iZuKpAQm2NP3JS82veq+AIv0X5C7ExNAj56cU=;
 b=lQ4o1jBsBU47/mjmjh1XOZfhtlXeUXvjB+DysCkst3CeU5k7XwEFoJFmc2egI0sxXbtLJW/nZ
 PsyQu7Lt+Y3BbUreCtFgJMXmjQg5IohsDBovTYY2Fnxpf8sWNtEl+X8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX3SSFIV9omFW1
 oxufkbE7h1T+V9tkeAfTASn3mB/7OQ5dylIOy74jrQiDG8Vi9No1qZCjaqAu/vVHx6cU8CxRMdU
 XSGkBz3gc/ny72SUuqCEh+lPhCkEf2NVoNqbjHMVbyGjFekdUQoSfM8pBmFo1HWNAQha6223ea8
 b/JrVyr2ArAK60s6h7rKKN0Mlo513RaYZRXeuSvwGzu8njjSHsgkyPZujCfxsAkXXuAN41DXwiz
 bp++dcQIbkL1XWW7XHdFVCd/WiXsgRXN21CwjYHr0SlIrRIUgvEMb3INQPpckVIv4KdXnNgG/Mz
 CTg2g6SLsFnZXd8/1FwE8yTY1aSDspxlmvwFQqrIEvQF434EZEdljaYbXbGaIoH7jd9lqecAvd/
 gRkQr/MiUTvCEslS+GabAavYLpvW4w==
X-Proofpoint-GUID: wt0kcmUM9aiCB2QvinnMRU7WaoZM6pZH
X-Proofpoint-ORIG-GUID: wt0kcmUM9aiCB2QvinnMRU7WaoZM6pZH
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef25b3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JGo1Z14By4IpQyqbhUIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

Add support for SYSTEM_RESET2 vendor-specific resets in
lemans-evk as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f445787a87ba4869bb426f70f14c1dc9f..09460441888a7011ff613c4fe9fa4b6872e12172 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -587,6 +587,13 @@ &pcie1_phy {
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

-- 
2.34.1


