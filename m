Return-Path: <linux-kernel+bounces-853754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08925BDC85C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792741892908
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1C301495;
	Wed, 15 Oct 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxs2r+8S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D12F7AB0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503249; cv=none; b=cXH3MM12XqriUxLGDlCl0YKQUcvVhd64QfrStuoRhoG8UzIbKUSkNdglGdABz/ArpOWO/3IOpqF3zsGx50R0VyfdDLP9fiF4VuxdBY51+hm/UpeMmlhcZJCcleEf0sPiXCg1VULBmPDlPz5ckkmw5IXxWIEr52rukXijbXpV9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503249; c=relaxed/simple;
	bh=q1pRzkuBh9GAg1JcwXGzO3FL3XRWgrlscAgQj90ENvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGivungA1x+uumJ5BBzcsRPWIAWkUR1IB9cuEQnxNcwct6CLHMkA0FtnkjMDfgn0WfNwC+4yS5FmShpItunpS1Wk67LbuPqhGdA0PglOJltJ7rePwccgraXNAGJONhjdCsaCm7JnCpBM4qRkTbsbFN/f9rne2BGEtnTzmKPNxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxs2r+8S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s7TF003411
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBo9gZrkew51yYf4IHpWDN66o41yYqQF87bJGWuNb/k=; b=hxs2r+8SAYSKqgeT
	uAZNpqBlEcK6bBPzYZ5zcv8abNZFHrNMkkFFCSPx8K8IIyRARkIGLrTOPXAqDF/n
	qZp5bk41wfi2JAhOAerQ/gzaNeZKOMKe0+ao48SwoB8F0jVO8VGz2suDEWTaKeDP
	J83RV++aCKvWtMtJEjQgMIZcXWIZi7gOz8MkBDDA9j3XCIKlaf11bs8U3BZx49x7
	pN05oHm3WL4XOd+RN9kp3jgnEWfzcVTmVkCM8pRMt6XCy40+rjLbyh1LsBkT7xCn
	Ybb/QhPBDJIGuzlRTMgSDqZ9T2FUOMOYfSLD20UkNWEcVKsrZ3zH2EvD+AEnbMYL
	OI9xXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8hmne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:40:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso15950104a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503246; x=1761108046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBo9gZrkew51yYf4IHpWDN66o41yYqQF87bJGWuNb/k=;
        b=qLNhlmxG8ETs47iG0JXhaaW/vdb4ZX3QzbWzf4felqJU9SPTymz/BzyISCpqf8mKUc
         qSIlyTd5Vpj+bIvRWMesXG3xDrygDeBCoQq5XjSKe35IFPeE9/1VUe3lpgG10Oxo97nP
         t4wEbLOSsD1oMGP3q9W3vJL5r6itRuaj1fhFy/f+15ZJ3q+XDto1ljxrUMPXrHo+bRwd
         +oeaUGvfM5LPr2ZM3XO4ZuPILxxV02sCASJAaplPqQ7fuax9juVZuugRjt7MBEi/ejxl
         WnTSH10nVwKG5H+KrrZZxuYvxfrzcIqRT8FzcI63XOa2M/hk3yHTIAd/NthdDUzBNEhE
         45KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgm566RlFHzJQKAKf9fr8JkSwykDpDiQsryqvYnayF/X+UH+k4Zu/Ec+ffWPdAQ8mo0gxft6ikrHO4Qw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWJMNwSx3xSWsxp6Be9jedn/cXdNeFrK1g55WyZpDcPVzfK6H
	dCwTjiSj5P7S8FyNbMFXNy398653I0KnOUJW3iODiu8c6uqMRUWGLPkBSvuUfmjtNSC5nb7YWl6
	6BI6bPQaRrAiyAh92zkqMf/vEGgxQvUXxg46WQ0TSTbgSWSi0TWhPVdiPP9ntLj5vLDI=
X-Gm-Gg: ASbGncuYGYXILTC3yiAlw9UkAD4yMQY8A1HUI7GCtwzzPcrZE1x4RfgqWW2ob3oKnQ2
	eOYoVdLdv8PnVH2SQ5AyQtYuoj1pHSftDgBHkbUZbqVv8byxHo/jBsr81Uw2LymzPLCDi8AWno5
	+hel/uzF6A2MzGe6usfXmk7tJMjDb7veY4EXYCA3QIZt98cfAW2cV5Y3p+alRh/Yb/rSg072jGC
	T36il2hNxyx/N8Wm6d/njasS5puuZxLo8he3MmSmbUfZap7vgTz0I5dQLGe9ougQ7rR+9NMb7hK
	rCZnAFArHM+asZ/LXakAN0zP/IWmI9oM2qCJkeehSV6wsd1YVmEAKdjDQWck3cO9hTqc5SEqdHd
	B
X-Received: by 2002:a17:90b:1c88:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-33b51386573mr36050520a91.32.1760503245555;
        Tue, 14 Oct 2025 21:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl45T5gEGBYaChkWOQqwIOqGUS/zz2WbvtwiMkJgYFYDoxb2M6+A0u7nW/BBPu6hBROJZsvA==
X-Received: by 2002:a17:90b:1c88:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-33b51386573mr36050499a91.32.1760503245015;
        Tue, 14 Oct 2025 21:40:45 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:40:44 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:29 +0530
Subject: [PATCH v16 14/14] arm64: dts: qcom: qcs615-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-14-b98aedaa23ee@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1528;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=st897fJ7jTPYQ5eppZ6+OrlCOSPDdAnpzJ0eoXTLNbM=;
 b=gWz6wC5KS4Z9D59qmU8+oPQ+ydpoZURhG6YTecv1VL1HdeQY4r8X5AuEshLZFDnnQNu2P7OnP
 ETCaaC08bcmCbxRY4EyrQJoana5MwZKnS0RbAX/G9ftaPPfaG17phQc
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: a08EcfAYT9PSy-pjJLdzr97IaC-cpcqQ
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68ef25cf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pkXgoPqwvIc8jTsVjBcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX217VfSajMVgS
 qYhTDwjnpSa6vy9QQj6L5ZuHde5Em3DLtNV5CWjr8309Natxze9DDCCWS/WfM2R2979ZcMK+2rf
 RrUa7ojg7jBhu/n6+lInC50cZtIoDjL0GtQvAVneIoAk/1PJVXMq1i7e+MnyTeoDe3hUACJlY9v
 jp9Nd4nGd5wWAHR9kiso7EsfJWZI700OVv/jiwmJYkc0tehErRVzLy4m3FuyJwTK2vKE6XDnGUg
 iDIhLI3VWIblJ+wPcWc4Uzjzj8oiwTg1nnDm4M18vACMjIQJKENfxbYwtpaNCw0z/5etOhrQ8O2
 UaWqNUTiMSv+bw/Hm81i8p8DZBCVZIgjGv6DLlUm9s0jfm6uNc5S+U+SI8TqL/+Yxf8OLI2JW6v
 l7BbOgtfH9jhll4rHJGh7HeXOcKlPg==
X-Proofpoint-ORIG-GUID: a08EcfAYT9PSy-pjJLdzr97IaC-cpcqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

From: Song Xue <quic_songxue@quicinc.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs615-ride as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 705ea71b07a10aea82b5789e8ab9f757683f678a..bfb504db43368fe73ff200476ff5220334872c8a 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -343,6 +343,13 @@ &pon_resin {
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
diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 3d2a1cb02b628a5db7ca14bea784429be5a020f9..9df5e94069f604e5393350f5d8906097d6d01209 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -416,7 +416,7 @@ opp-128000000 {
 		};
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


