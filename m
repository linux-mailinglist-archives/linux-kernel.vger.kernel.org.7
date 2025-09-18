Return-Path: <linux-kernel+bounces-747163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C80B13092
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2403B5EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49CD22173A;
	Sun, 27 Jul 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpdS1mly"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22322156C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633560; cv=none; b=VCF3Hedf7z3USbSTo/xIXZqQNwqOQU6XewQO1QOEoqsPvyXAs1nMbO6xf5g9fcUnVJrf/33Gj3AknomdgWb3NWpPPJEWoyDhvHuE/iknGTSQJ4c6mO+RrF87lItVSOBOBJe+Vg2Dtx/7JC67KSo2uUu69IbeyVPgmcIqnA4bJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633560; c=relaxed/simple;
	bh=+KHfR7YYD+HrcoWjVGljO4mWJmBVgezl4q//08Hz/cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moSa7LyIICWOqtUgrp2XvRJMcmkiIVxqOv01asHgf1KyfMGNFaN1/wd8ZwoPz/4ocuUwoa0PIXwbSXt5U1OcFk2Fx4GttKbWlbPLbATKoW1RRoIA8H9By4d2Ox/zp6gm6rPOrup14mz3RxZ3ryxGvneNo7chSynUe9CDIe0ChyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpdS1mly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REFjPY022873
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gc7Yk0tdJEh2i043+CGDqIsAu2bVqNeh81O1rVbonp4=; b=RpdS1mlymp2idYha
	E4d1zbOJta6tFlbE8A8sQAawxgBHCK+MwVNgjnmz8MTi3R64v3Z8Eohnd5L89uzB
	lw5oHluHZNb+MhkKzhr9rCu/qtt0hPnnwaBXL27nPN/BFSvk3TXEEV2A3+/PI/zo
	pdPgTSYhVqMCsd804qXnWEtp740OjV++9ThLfjzESs8M9DY+eyZ71TYDo7g5Y126
	46qpSum4HdetuQJzKcj1gCU40rPyqIwXqQMP3FHTa0PmcamafDdtthfXnIMxDpvp
	1e2iyHU4ql8emTyU6y0yMORGJv3WH9prDkIoCP49DBBjRTRJb1DyULRv8Leu2/9w
	miSV6w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2ab11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23fed1492f6so12245455ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633557; x=1754238357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc7Yk0tdJEh2i043+CGDqIsAu2bVqNeh81O1rVbonp4=;
        b=N21a3aDKV7DsNxYlvOynL2HLhqIomVaLrMOU9drC5n8xvb13s4er1nlENCRhTAvhhs
         6VR6F96arbGNvgHok4x9llQGzxAP5ZalmyIKZxJcfEeiKn2OXlHQHa9+gZWpxFQUQuJ3
         D3dIZVi1G1YtoXZ6ma6i5RWPX5OPf+piO5TQg9O5G0nCfsQjM9C/feR/1DWMkdsaJnJG
         t7wWdgp4Zf2P/ebzZxh81Rm8zXxhoa3V17l/2H72aHdwq6fJphjmSopsXZYi4YcwCRMN
         P4BXpfKkmAV6j8f9gjuC3wmyqGUqVwLsuQQLqMacMwXn6foSdiab8bwx2hBD3CmYhltk
         XUuw==
X-Forwarded-Encrypted: i=1; AJvYcCWjIHMXUq+o8KmVrm6TYP1TJqdb1ie5EDDh8zImyt6kyg+W4w7ucrHKpeYo+iiQFtL2DACf2OQQSAYmRg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmTECHuRS+YoeUMkuPujg7Ai4ZnipAr9DxK3WxlH2WOEUtldk
	3I/Qd4Y/jSK/NAtEfBcYuK+CyJBcc58fr3eno/xGKIrzmvMWrAoSCuW90/qTHFG4yCtWBohKT4R
	ngDA+PFtbrDg0HBNUv5io7o11WE1mG7lpHLwHwS6gdqSrSJ0nRhELSWPZUuZdCx+ww48=
X-Gm-Gg: ASbGncvm0VhNbRAPf1antfTe04LPyRW7lh5xWvhtq69uchMb0WzzaxmwNCNxfPMV4zz
	LQaYRNuFzCg8MrujBUB4D2omU3ISJ7cPcnsALbngwrOEThJnWPJobEVAdbZS9rXNe6JboHqO0wH
	gllxnChjpjFNfqBpn9/JUUw2fU7vzOLM+6XldnODRRIMNCa1Wgqm/WqbtnqvShpB0WCUPWGaKx+
	SWrErRP0OeVNJ6Tpu1gM3u/HqVphz3Tpo3ZP6d/3z+9JMjYh2/rVhEJd7zqy8wZz1u1aV3m4wLg
	2Smz7gpp3//QBmjc9pL5w8N4Fkqzl+XMfwxXhSik+ri0UCLelUWDr4agIJ1qhCLgUwefSKEgdje
	g
X-Received: by 2002:a17:902:db12:b0:240:1441:1263 with SMTP id d9443c01a7336-240144115f8mr27743685ad.50.1753633556662;
        Sun, 27 Jul 2025 09:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn1iTzmUSFNFbd3ipwa4rZSJcimOt/VUock6+Z1tVlZwgy+X3u+ZNaz/MM8wr2kq1viBngjg==
X-Received: by 2002:a17:902:db12:b0:240:1441:1263 with SMTP id d9443c01a7336-240144115f8mr27743135ad.50.1753633556115;
        Sun, 27 Jul 2025 09:25:56 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:55 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:50 +0530
Subject: [PATCH v13 07/10] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=4777;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=+KHfR7YYD+HrcoWjVGljO4mWJmBVgezl4q//08Hz/cA=;
 b=dlmeEc85Tf8+gvzUvKK1aMpV+xuClWa/Th4ihsRT8Ezne4CvP1qA7JZdX5O1gHgnHKHU7hkOo
 zgSfl1Qjv44C6njn1gnhNTZqnu2HRx/cdPpRXp3S6baG3nW52Dqo4nU
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: grhR7mwtzMKSj5ayomHC8wsowkvB-oSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0MSBTYWx0ZWRfX6bjRmgkrzb8Y
 68f2rOgXKNcCh+3l19o9opoqGkIODKk7+58UTPQ3pKQOfPbImEehDEQMPOc46Uq9vPmoBPxrAnY
 q8pCnjPeJFoYai6JdvkfBk3U+zmWjkVRvTgRtyUAiZ/k2WlH1twMLZs03krr1yGxkMUK5F/yvKW
 AkdIIEXts/oR/nYoEg2NhO7fAN+fzWyo+odOXHMVTuQrB5LvVwkmBsM410wrpZ5Uuw6jQxRqeLo
 m701aHc+ScY4H1z1mnLtJodH8mM+IWZ67fgmpOz1nAnowurh2HKxckSeQH6NVCFlihSvQqCICv6
 dUlx6pYAAZO7AJZQ2qT0cVVLXAvFWxe2w1C1/MRwSQ+rU3NpFGcng5vewFKGQcDGiskdLRd2Xsy
 XcbpIo59CY7q7gRoz4DNMvIJJlloyf8e9+/3cfkMgQuJDSohVgOumZ+X1x5I3/pjMnn/HWbt
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=68865316 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EdS2NIbk_1D2FrBATFAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: grhR7mwtzMKSj5ayomHC8wsowkvB-oSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270141

SoC vendors have different types of resets which are controlled
through various hardware registers. For instance, Qualcomm SoC
may have a requirement that reboot with “bootloader” command
should reboot the device to bootloader flashing mode and reboot
with “edl” should reboot the device into Emergency flashing mode.
Setting up such reboots on Qualcomm devices can be inconsistent
across SoC platforms and may require setting different HW
registers, where some of these registers may not be accessible to
HLOS. These knobs evolve over product generations and require
more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
reset which can help align this requirement. Add support for PSCI
SYSTEM_RESET2, vendor-specific resets and align the implementation
to allow user-space initiated reboots to trigger these resets.

Introduce a late_initcall to register PSCI vendor-specific resets
as reboot modes. Implement a reboot-mode write function that sets
reset_type and cookie values during the reboot notifier callback.
Introduce a firmware-based call for SYSTEM_RESET2 vendor-specific
reset in the psci_sys_reset path, using reset_type and cookie if
supported by secure firmware.

By using the above implementation, userspace will be able to issue
such resets using the reboot() system call with the "*arg"
parameter as a string based command. The commands can be defined
in PSCI device tree node as “reset-types” and are based on the
reboot-mode based commands.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/Kconfig |  2 ++
 drivers/firmware/psci/psci.c  | 57 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
--- a/drivers/firmware/psci/Kconfig
+++ b/drivers/firmware/psci/Kconfig
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM_PSCI_FW
 	bool
+	select POWER_RESET
+	select REBOOT_MODE
 
 config ARM_PSCI_CHECKER
 	bool "ARM PSCI checker"
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..e14bcdbec1750db8aa9297c8bcdb242f58cc420e 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -17,6 +17,7 @@
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/reboot-mode.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -51,6 +52,14 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+struct psci_vendor_sysreset2 {
+	u32 reset_type;
+	u32 cookie;
+	bool valid;
+};
+
+static struct psci_vendor_sysreset2 vendor_reset;
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -309,7 +318,10 @@ static int get_set_conduit_method(const struct device_node *np)
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
-	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	if (vendor_reset.valid && psci_system_reset2_supported) {
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
+			       vendor_reset.cookie, 0);
+	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
 		 * reset_type[31] = 0 (architectural)
@@ -547,6 +559,49 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };
 
+static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
+{
+	u32 magic_32;
+
+	if (psci_system_reset2_supported) {
+		magic_32 = magic & 0xFFFFFFFF;
+		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
+		vendor_reset.cookie = (magic >> 32) & 0xFFFFFFFF;
+		vendor_reset.valid = true;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init psci_init_vendor_reset(void)
+{
+	struct reboot_mode_driver *reboot;
+	struct device_node *np;
+	int ret;
+
+	np = of_find_node_by_path("/psci/reboot-mode");
+	if (!np)
+		return -ENODEV;
+
+	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
+	if (!reboot) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	reboot->write = psci_set_vendor_sys_reset2;
+
+	ret = reboot_mode_register(reboot, np, "psci");
+	if (ret) {
+		of_node_put(np);
+		kfree(reboot);
+		return ret;
+	}
+
+	return 0;
+}
+late_initcall(psci_init_vendor_reset)
+
 static void __init psci_init_system_reset2(void)
 {
 	int ret;

-- 
2.34.1


