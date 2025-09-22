Return-Path: <linux-kernel+bounces-827341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA58B917C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84731900AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E3311971;
	Mon, 22 Sep 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbgjbRoI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFC30EF83
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548558; cv=none; b=jJnAsEcFll0fJ6E3zy7PwtgcyAtac+TSKlKxLQZPiVd+uytyK8jCoFudxoahMrWOz6R/ZObsfBXTIa4XgPfEJMS1z7jnFH+u7vr9plYe7Lg3+aKLQ2xBgAYta8zJbRrKSXNJ8IDB1X9tGPmVOthmLqN+3VGNyDqe3IU7dTk7TFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548558; c=relaxed/simple;
	bh=wHkUdDS5bnjeIQ7bWY0wwHjrewyVMryPfMFT2XspY7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQ6gMTSO7ffpqJvp2fOtO4ZskeCop1dpqS9nCL3XWN54rlo9x9UuumUhK7KDTVXmE0HtdOJkMooyQqFkCGDxPQ99epLNbnIJ1cA+MGAtQLQDp1mg4RFqMmoeoOslXl9yrv1M2OylUmrg382yLm+SSKZjjfiobPqlrFsHGXM43gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbgjbRoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M9FiiS005264
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FYXv947f4qPhFNPoWzY/DvCzODELrD0LuRjCAh5+0k=; b=YbgjbRoIqEyI/mOL
	GKrXdXBOINtnbNJ7xeXsPg3gIBkGvUlHOisSX/O5d6fp7ZePBEsDCsOIw4iG6cFC
	ZbDHhf8QHmqPhbY0H0xetHBF5czMShLIZX3vG8r42vYjC2obgE9Ta71+vXZ0d87E
	wQHb2rbW+1am0fDiVH8tVJ8h76ljLtnYnZPNnXsH529fpgqRK8M612u8xIaYjiuh
	6ujhciW4MFKFxhbj36H6t8xPLB6wCkrya9a+NIW6DYCPsFssiThER/ySCXrFFJ9T
	FIxh8WVhcxJCUpQF1CuCZVVyeOeL0C2PhBzVSbD8abjTq94aJGJqZ5Re0Q86++7k
	I3Q2wA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnn6fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54a30515cfso4076386a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548554; x=1759153354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FYXv947f4qPhFNPoWzY/DvCzODELrD0LuRjCAh5+0k=;
        b=K7p8kf4A1/y6Rgf7BprQTYLCJvQ0feAcUH/COonWGRk1foh9J99JmfEQoDrA9AziP1
         /cvzsTtzo3Tq0QZyAknatf6ZKs08wQXOhd8lx6N+/9VsZxjL/5tTXyHATZwbbFtWhz1D
         eaav6RHTggI7ZT72JFE0jWCgSxx+28wWndCPeBr7gdeuX8rW63L3Cp6mMR1X59SxkHRK
         0qMqLH7jUWTMoI5RAatFrIJ1hPrgOBN8bkbTj6jmSlJs8BXoo11qQk8o7cAeV+3wMmGC
         /nIx+uQkJk0pe0D3LJ504wvlb2IBdPnO0Ps5qfG3q0leeC5XrEVPNTPqH+mrauXiqwG0
         aWhw==
X-Forwarded-Encrypted: i=1; AJvYcCU7HPd8pT7UFXom73EGQVs0fCY1Q2l2HbZ3bSKEJwIVOKSe+UGXkZGTAhAVdkMXn4wAdYAHmn9Fc0X93Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgAjr+LRvxVTMObpxFrfZ0GU0VcRE8T1jFHGlKTKI2habHWn8
	0wbOJJ1RqID5zOf/9ww0i/4qpedzWqDPgZyvt08vSQTyEIRkckBiwjUaiZ/MEO3eQJPNp96WfJb
	IVXj70AXeMvjSnIEwga23vQRmkzzqzaasSnNDtoJKAPWzHjG478SWSUZR6Z6WxqAOMh4=
X-Gm-Gg: ASbGncvtg7Z6spk8XNljGIbsAznHf4441CgZKUvmi27V9gbT9Yf7IoDlfjyIi9NR2OE
	qqCF+hqPOdwJYSSTaaqCeZcxXBMKLVMws4T4jSXPRlkMffHc1zX56amxkxqPQEwGfyyAV1AZS4H
	B7QNVcPT0DWs2swDZ4uRLOtScvVdTTWgtwRu3TUKDeEIukpuOjfVK+JFVcliNZfdedW4dFqX7Bq
	nqw4SznlRnkfp5QbdPvWZoTlpJY6Y47iiLOusbXQVU6zt57EPmj3Flb99+P6nTPs+bpEMH5LU12
	qgZt7WaHAE4JF1O68ENFm/O5wYftc6Vv45fvjbvuIsfw1Uw0JZddYf+4x4qKDM0ShTRaVgI34Bi
	F
X-Received: by 2002:a17:902:74cc:b0:265:62b6:c51a with SMTP id d9443c01a7336-2697d795331mr139723415ad.23.1758548553896;
        Mon, 22 Sep 2025 06:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETbdwlhVXEjM7yM22/JEEvIiUoy202zLd+b4eWbRtUU2DHlwKHc8Op5CjIiXXHqrVv39UJmQ==
X-Received: by 2002:a17:902:74cc:b0:265:62b6:c51a with SMTP id d9443c01a7336-2697d795331mr139723005ad.23.1758548553434;
        Mon, 22 Sep 2025 06:42:33 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:42:33 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:22 +0530
Subject: [PATCH v15 12/14] arm64: dts: qcom: qcs8300-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-12-7ce3a08878f1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=1518;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=wHkUdDS5bnjeIQ7bWY0wwHjrewyVMryPfMFT2XspY7w=;
 b=TCxpE50gt1pXJWJLnvp2Xo5vGtRfCb5g6AIRIIKP0dcKGqc/CJoCvd8l4Qh1JixBDFnugZCHt
 zRlWDkiodHmCXFvnxFbQqcB6EyEzV5K9RPrJ6BsZ68yVSoue50/SEZK
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d1524b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tC4jzodRyx6YAeo6W6AA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: iPNcl02PE6y1Si4wLuF1VTACABUA_iaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX6qA3rIOEJBHw
 qUm3OlFLlzl0SM3VeXUUao/QWsW+w4qts6KkBKuz3sXbUwMcPvdJImybNbhgdID1yjeXhoXER+6
 Pbt9OtVkxt6g6sdmMShKAiU1v28d79N6QxcburbhRURGe2Sf+XXdb0Ok4QOvvYAJcWvu/LWTZZH
 D9UmSAtX/k9WjA9CjiEIhqq5ZB9lZlfeu5tqIrTHgGWgWCwJy0bPgeoQMHt4u09mCFIr/45cZmf
 XZcuaJyeZEEfA8R1reWa87AYJDzgfBG3K++94890if+u3EU7m/KDamSlTnNA8gGLcP31Moe1AHI
 AJSTBsiYRM7CkebrgxyvTUb6zXNZ6Ze54B9ojyf5s/U54m8CC7Mc9t8PplX0VniDJRrzYGsEr/H
 0AbHLtEj
X-Proofpoint-GUID: iPNcl02PE6y1Si4wLuF1VTACABUA_iaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs8300-ride as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index f8ed510477cf2d23c6bd1bb042abe46b45ad35e4..dc36296d2c1ac7731d9e741099a2cc0115f584f0 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -309,6 +309,13 @@ &iris {
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
diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index d35bfece60d1afa5205d71c3b1b621dce49c805e..7d256c2f9a9a430d076000ddf22f8a56f074071e 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -663,7 +663,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


