Return-Path: <linux-kernel+bounces-891999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F9C440D3
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB28034737F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1802FFFA8;
	Sun,  9 Nov 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qulzs5RI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZgiIy2o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13552FE048
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699167; cv=none; b=iawdIiHXso11mhnhHQokcpGqRGAxOZObPITytDm/Gf5DvpVJ8eJHDZKZHjCBb3Qptzao+l1H+EOxkZC+oE23uSEszWYUn1BmAhF/x+EydBtQzhZPkcP5Mspf+r++ZWiuvzK8zX6RreI0eu7158W+cnp3dgN+4m7hcpcDeVASTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699167; c=relaxed/simple;
	bh=L5z7An1rQfRgBI3aAbZ9RvjHkAJiYPaDq4L3GKStdk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1g61RODKECyqd67TdJ6ZF3FOEZ7dHWOqs9i+dME/hbiW/guHXJHPAKTfazK1d7/7v+Rw6LkfLnDJhSxba3DqaHKVDEGMLFjilMOVhI65UocA5vU3MbZrymQMQhG8RP3LUuFt3IG86vtSgBP3eg+lhR9N4qadx3yRh0HpA0TkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qulzs5RI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jZgiIy2o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9B2OLF557920
	for <linux-kernel@vger.kernel.org>; Sun, 9 Nov 2025 14:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kca6TC9CdzvVOcI/VsKM/bsiay1QMyWDYIKPAfu3ShE=; b=Qulzs5RIIcnCNQvw
	3YASa0XskvbnqqKy9Et5ewjLMICObYe5WyY4Dp9KLZDrt1fKTRPPJEVoF+hKdhnt
	1nVtb5sLIeeEsMQQs+OWfbBzB2L8tzmb9g3O+ega2uaFOsQq/GL0G0CrXp0NUdmE
	CU0hQj4rvUY69jpAJzSa14a5JbXYJt909h1ZPYHQTz0Lmb52KCiToZkj8gG/6ufp
	ueLmRn13RSa+g6vU/HD72oV0TCUjkXUWnjkwQPTU2PgtKwVJUKmTAGO7gVmtgkHe
	H0wZejM89vC7pojazs4Rq8swLhC/zCNkrxchus3j37ug7KIgNnp3YLDsW57qCyr+
	Ij4Iqw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xwfj87f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:39:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so5696701a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699163; x=1763303963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kca6TC9CdzvVOcI/VsKM/bsiay1QMyWDYIKPAfu3ShE=;
        b=jZgiIy2oAs2ilqRqsJYytbJsNvkw0Q9vCB+5tDijCJxacGoDk+8u2+mK6upMG1fXRv
         DUxLHp/iug9IihWlmd3dNMHVHHDd7XMVO+A1nEZ0Qd2Bahiutb2zQ4Fr/AkamhvyhCpa
         0r1Fv7P1P4UUwBoyhdp9YMrSH5TdiPCAvUl8l6ZgN/AVuVx9mt5ZURSnBkz/QKuqm8F5
         7M/9kryJsOej60g7FLDP91onY75cg4cSPLOYsBzYPxQK7XgP6X8INUWI5Wc7IVHGbrdd
         1dlV8yQVRt/NXW2iLVHIrj+U/u2G415OV0+gXdGKPoX6tpvbIh3O03CbWH8yxjGp2zNz
         W6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699163; x=1763303963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kca6TC9CdzvVOcI/VsKM/bsiay1QMyWDYIKPAfu3ShE=;
        b=Q9jmyRsk3+srpMDapiMWmTDm1C9w1wyraj8ZxIMukognpzMNf0n8owSytmEjfY+DDC
         CJM41liB5f7XerFqUH3spU+vGKCh4AczHmgtOWvQEZnNC42QPT39OvI5qhbvPj+aokEg
         e75HYqOCqkPNabyB8WbDAAgLc1A4dlkpbdiWu2MnZilEI2zDm8TY3AIik6/AIOBykHTe
         hoG64HTnXUO3rgb+v3pY0CJhsi1p+0c2zRJdTsEqZOebLmiW22hCfX5suCeWXBZ8y7D2
         W8N0MehkLEdFgvJeKcU2m0yTwCjf9/0Sa1uK3OV0HmTYpB1kCt+cXlplOX7Pr1wOKY10
         4Zyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfgrYJod1nbv+IoAIoby4YGbFEVdzwAbh+AuYCHYr9IcKHeHg/P2/3r3bEgmNsylfm5gZObumgClnjxZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yAs6EuwFCj0reQMHMyVcPOIyTs9rsZwzfBRsE9BNFYSzKaU1
	MfSX3hiDqb7OEeRNPIqx5aHDBHNEGy3pto2zw0uAwglNgVxijpBZUZjPRggk31GPonz9cGea1PE
	cTnJ0P+hzLHUQXfLCvNRBqpHcRvzdcL5obL6WD8wHPyA3iUp2U5ZBNteGy+RgqnFUHdw=
X-Gm-Gg: ASbGncuc73G1CXNmYYtho313EQxcXJIbwCga9TzIcLSK+Kw2rmZgdu8Ltp2jgm3GrVj
	CPWtrXKtqt1GI82A63qFnAS5MLCVwPj9Lj0MpH7PkqcC7CwODtdxQth5wMbeaKPYwxwlcn+RFl/
	XKBEF/DpQyaWMqlaT8y362qjrdJmjvw+DSe6v41hqF82vmppM4qlhmTnEa1r6tQvX0IWGqfb59m
	Snc9tG1HLvdCiHMB2IhCnG31RNT93F0kcZa0tOx1tczDn6k+xt2Kq9vgcvfMOft0xjGu5iRiYu5
	L1+m7ZctQ5b/s1J7RfzZR0AN0YXdds2wK/rXESmgulW/HXa6i26C0IU2TV20q8s5yMjlQKySteL
	Z89Gkd0ipfjdMod9WTAAjQcfnbvfhaGnR/xM=
X-Received: by 2002:a17:90a:e7ca:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-3436ccfa18amr6671639a91.24.1762699163436;
        Sun, 09 Nov 2025 06:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVvyQ7Ie5qv51GMyMWvjT+5IIfkhTgU5ORFWh8Z2JxruCZKThIUurXvRJ2KKFN2TNS6U0/pA==
X-Received: by 2002:a17:90a:e7ca:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-3436ccfa18amr6671612a91.24.1762699162859;
        Sun, 09 Nov 2025 06:39:22 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:39:22 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:22 +0530
Subject: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=aXB/ZtnzKwJgS2fh5ZS7UmEMWdC2tYWUu81bgPi7sZA=;
 b=cGRfGGTemz5mYMnHzcIsN7x+3Xmr9GhPgiiKRvGsHEkgcZwXovPN8MabUz5/JPID3VZvw/NR1
 ZRO8BE+Wor7ATT2oXZpYWQAGPs+8aDB6Tz4FhHXDk06RqE5h7lgvJnC
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: 5b3LiIuQm-ndp8K-J2zrPUJP93hNSP9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX7yTPyIsQbxan
 zYaQqrtGD/R8PNI3vkUFzVWC+Kisj27pBqvsUiyIDpfSPB59E3PbU3gHEiWiDhIyQ4pE8IYcJv/
 Qaw4sMUZXOLfXn+IO1BiS2HHojW2ZlIkMhh0F5ca8WAXNNdcx5/LCuRCZLQl0hO+R6xscbHh8ai
 1mJM6RMZ+Q6bMJ3ox1sNX3MWYBESJ7fgFjlMQ6ErIgZrVDmGQ1BXdMlI+HCbUOKfDFyoFKF4YO4
 KHD1QeuCXHw/jOduJOF0XNRDyl86gCKRrNRENfFEt+XRIzB8RNyEnTzatvRDmS5BAODy99HlVnQ
 wEP2yK8lGo2lw2A03rQzKZT8NVi/wYt4d3tNsOL/Zm+qhv3Ytdnn/emB8X3LJRKQ5YGlSkW109w
 kJG5jhGaFiqOMMghUxyKRx6xMAu2Ww==
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=6910a79c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 5b3LiIuQm-ndp8K-J2zrPUJP93hNSP9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090129

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode. "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -935,6 +935,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


