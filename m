Return-Path: <linux-kernel+bounces-827340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9512B917C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA70319006ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607B30F556;
	Mon, 22 Sep 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OqFk9OyQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FF30FF29
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548546; cv=none; b=Ogb2bA9wgWlyGXXCE4qtrmiUP9RsI/+vF/C9IheY7ul01PD5JRcfbsS9VwH55qWdA89mO/6yZPDyeTQMo2zv7XINofD2DPcTnt/2ox3zzgvHDCq4snpEqpHcwJYM6pZgo+t19aS6No8unggMXAOfS60bvEePOnQwbepCzz9YoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548546; c=relaxed/simple;
	bh=1jBpq+iZuKpAQm2NP3JS82veq+AIv0X5C7ExNAj56cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tz5d81cvyJUyXARPwapM6w59PEwsmA4raGY7kxEOIRCC7jX3Q8/mve8125ozGIFKGja9O13L+HZY36lunM+H274ba3DUhnIsM/bYEfkCMRmZaKXyZRfIWA8brHDuIhaR8DJWGY6LLdsLz3bedKko66hAiHwC2U9VTkCvm65c/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OqFk9OyQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8ni2n032343
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaEbjaznfRKEBXAo6DFolWZjwipbscJpuOwEOXljFb8=; b=OqFk9OyQD0bojcrD
	6CGV3Hmzs4zqpcpHvCAhRiiLafSENQFuOxR+rV3JrKvWvMBzpauFacz9A1ZcXkSe
	qfknBiEnEzoc+4Uf40SCTH3QgfT1ytxDAuBiJaXIrzxlWpWVzEwVzfdf5J/A/86E
	I1jUbjUsuTbqAgDM+hFWa0r5+0cNwP+1IpFzNVqXfQyC2B9o/JLaRdLAhWaZ/v4+
	6SRAjGYgLuEh15shauDEKmNAdP87bvNxQvgIcEWLxks7+sWruwVpkcmyrugwg33L
	sHUgd6xxi2xv/S1WB3ZfY0y4aSND8+/uj6rUht5q6GGNI7AMAWkQaQas1bOQrV3x
	z83BRQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cwsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5531279991so3362023a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548542; x=1759153342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaEbjaznfRKEBXAo6DFolWZjwipbscJpuOwEOXljFb8=;
        b=cRKPfbX0LQFXtgZsgTCSALahnOq5FhXxP35K8uiO2uWGKEE5Ldo+CaabQVBfz1z3B7
         F6HuiPEVffTqRnT5Cfg8Z0X9v/4ZMkBQJmI6z+u08xBRh2rnEC2ST1iPa3mFSmbCsbbu
         ymWRbNDJG4vTD838ZgV8V47WB0rLl6c8KNDe1YjBY9whEhUk6S/baZ4EXvcY3nOuNa6y
         kmulOTLgZ70cH2RHYeqxiR7ezRyRupp3ZbxpCnXAemBWq00GZvL5tVKTttbgaJE3+ZWr
         xkufkVv6R4BynuNLmX/8fq/H3C8j00IS+Zrmz+dyWTtAYkjCiQAMjDlzXxjfKOjMYesd
         MxMA==
X-Forwarded-Encrypted: i=1; AJvYcCUyKtLnQ4hNQEpOkwWjIvYdXV7PVjA5N/Z+eqNpkfrskgoDnGU9/+7mvFcmbMx9bUrZLpHFb3lLc2AwBI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzyHnlR9eyCy6qX63KBW/ciLAWfiq7Le9lUoOicdpfDPAzUe9u
	lKzQX+0Vy+cXCy2u6YmdNTpRwd4iIRpYBehxi5zMUNC8UYX6dweaPySRvljr5robb03hOLVuw35
	FYuuKKJCP5PZ6W2+dcLCm/utIEqro/ArcVwrTplP8X62HuwxL3tfkEZtFm88jmIRqdbg=
X-Gm-Gg: ASbGnctHtJSRelhhgJjGt/YZWSfba8sEaNx/v2T3EvMgaoOTaDqHCoRLq1Gu/qqCp2h
	+7u3PlrP/sstV/EUFTvdJw5kxaEl3GF8nvdZMCgEMYNnaJEySy76gS4A3Ahk54qIDPYE/hvG02I
	sWCee1IIuKUhoq3KPtXDrXtsWjmDGO+JGNCa0R3mRo7crUbhNp0S0YO3ffRMn3y5MByc9UGgvHX
	RPykqimK7mj6yxHY3dUmM3DL7bxtuutIxN56Mfeh/GE5ECMny8f9GX6d4dSLy1tm/73HXqIldLR
	MNDHI5n++c8gTsR5lvVcow9KaevPuZvNAJBjN72SW7x8oHr9fprw6CqJERFnuc2MC/no80Of73A
	F
X-Received: by 2002:a17:903:40c5:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-269ba5892b3mr158901235ad.58.1758548542353;
        Mon, 22 Sep 2025 06:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYaq8oly26Ao9AwkHXBiB7SkRKPK/ArZ104vPbq6lanvIWpYVCmWpjrPeli8srR+MQ0I6aZg==
X-Received: by 2002:a17:903:40c5:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-269ba5892b3mr158900825ad.58.1758548541893;
        Mon, 22 Sep 2025 06:42:21 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:42:20 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:21 +0530
Subject: [PATCH v15 11/14] arm64: dts: qcom: lemans-evk: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-11-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=994;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=1jBpq+iZuKpAQm2NP3JS82veq+AIv0X5C7ExNAj56cU=;
 b=mqVVIESE4qG7LRS83vpCr3o4bWFn4SxgH4lxwuXGeOaww6B7yxmQGhmpCOj8eRJuKPkyfTyrK
 /NYlyvyI69bBCqQIJAx+wnZ+vdGIO/1FYRx9IKisQTRrT+MovMwe/xf
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfXx7NoP3COCobs
 m1u3OeCKzE57B4AgkXhqZd6wQ954mfPW8dBqoOrwQTMJqldCY4v4bjjruGl3lj3YlEC8KNA3suh
 qdJtdwlnLDz4Ha+VXfoLTeO/y8tvKDh2d0cImozxVhiVND+IoL5bS6MBtqvnSEY3J6ZoSqIc5bT
 qIOiHy1sNjig84hATXiC6QU0EexD+5r8+/SoD5qyNVgF8YkDYJGwmh2eAksVA1xisZFOf+rVt+/
 sAsQGwk44LOophaRTwLq3FyUBt0sgk6vUQIbaATVB2COeS08B8dgXylALFMTi/2WOBJLYGj13rN
 Q+i9Q20k7+ByCdcNLWApzKZQFMigFXALp/Tstc2mJy1GPNcoMlDJ4NpyZ61EgQdODLjn2DvGtRZ
 YXUEfXrJ
X-Proofpoint-GUID: esAz5h0r5L3N6LIFJ90xBaWHjgEzH111
X-Proofpoint-ORIG-GUID: esAz5h0r5L3N6LIFJ90xBaWHjgEzH111
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d1523f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JGo1Z14By4IpQyqbhUIA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

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


