Return-Path: <linux-kernel+bounces-771045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9C9B28207
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83065C134E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831323D7F8;
	Fri, 15 Aug 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prI6JzXP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C023D7EF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268648; cv=none; b=W8iuA8Ca/bBNBsqqgGhe+OCCfUT6mHiZO0LFqF2Ff+qjEmuS8USHxntIOK7huhafg9q2WybptgV3/mqJORqX4WuSluDKpjWZR2gOuDHTITmW54DmJVGAbwJUB0CbXdjHFnIrl3Cw+MtIVVdDXegylKPQ1bFLBM4OmvXyl1QTSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268648; c=relaxed/simple;
	bh=og8XnRqKfVb51an5IrfBWkxse/KEsB2Ct6wg9UArW14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piXrorPGpTTl/mFwFdJ5IYZxLdud5NdRdQApONs8HC9ivTnDEsApzbU8zm8qSrE/3MtEB1DGFT7j/zVIuIzWoWflXBfOprX1Gj7KYd7TdFBLVTFrySH1/seqruqknN6wlPx5cbd26El/1gNbZIlph3rk1SwzF5Bdnx2uYwVrZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prI6JzXP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJGv5008943
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eryQnSzToMXu2NfIgCMW4EZtH1S08RlhZnH4d4Tc+IE=; b=prI6JzXPMsCUeTaY
	Am3qa3JVxjxoIWp1Tsaum36GyqO8Dmp/fAQ2DQENE59Qgj8XHs9zGFjN6f+pkO0F
	hImIKiwsvor2Fgj3cV8Go83bVJPBNXfn6ITeIbJvQICAaQPaV98lR3lEv1qrfTfB
	iMl0JJCaTGGNkTfUMAuRbeyCRhqM1PrfgnyAoK/vHe7Rzyl6gGEKancFXprsck7G
	3CdOQD28CGAct4bqVAqCcjLeq0+1gipQecH+SQPf46xz/TTNAZDrmKHWXdwRhz2I
	fju032U2g6IltkHwhlsE0fA2dNULxGmPO0eMj5UCdWkJulqZ23ri7AH2TnkXqYWS
	aQJYXQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6y6b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e614c60so1722323b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268645; x=1755873445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eryQnSzToMXu2NfIgCMW4EZtH1S08RlhZnH4d4Tc+IE=;
        b=CUVaqH4ju8Hyz0TsGRAxBy2BbqebLY+Yzz+l7OP5WTRbhua6fz6zUV4iUAhadRneOS
         r+b7e/i16MLHXaKZBW3+yysRgjnvKX8A+JTYhe4PJ2wADbtofynNsUUzDo+B6T1awjFq
         qJmdnKtC3yL9l4WD1aP0HfBXirWg74LSQych0ThUFWf3kV0dq+pRWNGc3q+jaDRKTq0y
         dyDUU8y7ujw5QptiMO07jkgC+hZeHdNbzzH3y2NIpG0o8/W6pcvbK6NW7EhlRRysuP2o
         47l9LLNHkKkzp3nw9TEaHB+TgCEY2A38k4PyyBE6G7vD1ZfdplT79Mank4pqa+4REcjr
         gepQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTOuYRO/f8lHLEUqroaxLXVTKScnZpD0/Xc9z0ofA1idXgt7qUNGYiqfnmEKW/bnOqnF+hxBZTp7+5ABw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVbY3QHQLt8f8g73pu6LtoO8EmGWs9LShUPXkRoxRSfpZMvIN
	LHFFjFqY6vXeZVDPnDtrOHe0T8I5iaZ2qRPK4PTEE494DrKq9aexc1xoBTAn6biUdEITXFqhp2X
	yFXKWpWxFzA1Byeq75yVMZ4u46MZG7A1OsbYRzweoPebE9IVZYp+PzgHJoAifMrNdZ08=
X-Gm-Gg: ASbGncvs8fHHV+XhrGf81/YItRidyj6IwxVbJlKj6Uxx49wZuniaqk/bcLhs4wMt5RM
	R29W5xFDubnC760PV0sXN9/8hBye1Orenhn3cj84bXsXrNtmCPeD/UnCwgIveAlTbQlXVm/7mWT
	+Arx6MNBhSG4D8+miApGld8RWfhzS2EoNbLEXM7Hj3BU3RdAg2rUJfS+xE/vz/uMat/53sEnfAm
	/ubAESvXs7zB1IakUC8dJyv7hdRSCpy8zQT6HfRQ1TLq0vgeXurX3M8FZ2ei++7HjPpR8oYU4e2
	SZWbljJVebS8eDvomMw24JkXrprBq0ABJLeZY4n/zB0GFi6BKrjD6neKVzLdVqeBDeNag+aLIvw
	q
X-Received: by 2002:aa7:8881:0:b0:76b:ed13:40c4 with SMTP id d2e1a72fcca58-76e447b9b8bmr3092653b3a.13.1755268645308;
        Fri, 15 Aug 2025 07:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjwXYQ6zanSH7puhitmJD8oHNe5fi85xTYBsR8TwQxzGrZOZWUsgrQ8UEiFxyMbRHqeD2fJA==
X-Received: by 2002:aa7:8881:0:b0:76b:ed13:40c4 with SMTP id d2e1a72fcca58-76e447b9b8bmr3092594b3a.13.1755268644768;
        Fri, 15 Aug 2025 07:37:24 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:24 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:12 +0530
Subject: [PATCH v14 07/10] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-7-37d29f59ac9a@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=6176;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=og8XnRqKfVb51an5IrfBWkxse/KEsB2Ct6wg9UArW14=;
 b=4WNyXqesgIx7FKl6l+NReXTBEJXlBlrW/RTfkV6O6RK2/9teXBUqOPbrPjX+x98uakLoBhySi
 NwpNFUPgl2WBZdfE2T4tTXdOXj8gER+5RztwJZzPJjfIVSkGXDt2drO
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX4GphtyTHyjhD
 EABLaMtfpoPjWqpnro926FRDW91YJXHMtvS0MPsQHK6hnF8OKMSPYYkiGyvmzKgNrExcY02koH3
 NDye3rvTBXw6Awl3akakjM3CoH6PJlmCztH3GkrB5uCijWGFYSj0ndOSUXRTw7teqkz2wpO/CrW
 P70uEkCYuStW75X+S+kJwciW8O02L6khYiuXzrAptp3mCVhhp7dvQnEVfIs+Y6JoToxRVKaAavz
 lDtGnxqJ9DhHYbEh3HUoV30xtEt5j8CEAkjxZlH/EdpQI3YARg57ZPnRukOMhvrktCw4JgTIH0Z
 y/KDM+AkY+A55vNqAlLdJavNNDpjw4WYLdFK+FzX23hxFxbxE/9JCjjxYP9VXUgmf/p0g9hVzF+
 kydgw3Go
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689f4626 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=TMn5MJ8t-PDmeowdJScA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: XJTt8miDStnJGSG_pwtaliGuYKvThkoZ
X-Proofpoint-ORIG-GUID: XJTt8miDStnJGSG_pwtaliGuYKvThkoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

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

Implement the PSCI vendor-specific resets by registering to the
reboot-mode framework. As psci init is done at early kernel init,
reboot-mode registration cannot be done at the time of psci init.
This is because reboot-mode creates a “reboot-mode” class for
exposing sysfs, which can fail at early kernel init. To overcome
this, introduce a late_initcall to register PSCI vendor-specific
resets as reboot modes. Implement a reboot-mode write function
that sets reset_type and cookie values during the reboot notifier
callback.  Introduce a firmware-based call for SYSTEM_RESET2
vendor-specific reset in the psci_sys_reset path, using
reset_type and cookie if supported by secure firmware. Register a
panic notifier and clear vendor_reset valid status during panic.
This is needed for any kernel panic that occurs post
reboot_notifiers.

By using the above implementation, userspace will be able to issue
such resets using the reboot() system call with the "*arg"
parameter as a string based command. The commands can be defined
in PSCI device tree node under “reboot-mode” and are based on the
reboot-mode based commands.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/Kconfig |  2 +
 drivers/firmware/psci/psci.c  | 88 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

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
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..58fa5fae40f6643e46a1efa5f3b2f5d1d101a1b9 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -13,10 +13,12 @@
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
+#include <linux/panic_notifier.h>
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/reboot-mode.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -51,6 +53,24 @@ static int resident_cpu = -1;
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
+static int psci_panic_event(struct notifier_block *nb, unsigned long v, void *p)
+{
+	vendor_reset.valid = false;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psci_panic_block = {
+	.notifier_call = psci_panic_event
+};
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -309,7 +329,10 @@ static int get_set_conduit_method(const struct device_node *np)
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
@@ -547,6 +570,69 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };
 
+static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
+{
+	u32 magic_32;
+
+	if (psci_system_reset2_supported) {
+		magic_32 = magic & 0xffffffff;
+		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
+		vendor_reset.cookie = (magic >> 32) & 0xffffffff;
+		vendor_reset.valid = true;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init psci_init_vendor_reset(void)
+{
+	struct reboot_mode_driver *reboot;
+	struct device_node *psci_np;
+	struct device_node *np;
+	int ret;
+
+	if (!psci_system_reset2_supported)
+		return -EINVAL;
+
+	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
+	if (!psci_np)
+		return -ENODEV;
+
+	np = of_find_node_by_name(psci_np, "reboot-mode");
+	if (!np) {
+		of_node_put(psci_np);
+		return -ENODEV;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
+	if (ret)
+		goto err_notifier;
+
+	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
+	if (!reboot) {
+		ret = -ENOMEM;
+		goto err_kzalloc;
+	}
+
+	reboot->write = psci_set_vendor_sys_reset2;
+
+	ret = reboot_mode_register(reboot, np, "psci");
+	if (ret)
+		goto err_register;
+
+	return 0;
+
+err_register:
+	kfree(reboot);
+err_kzalloc:
+	atomic_notifier_chain_unregister(&panic_notifier_list, &psci_panic_block);
+err_notifier:
+	of_node_put(psci_np);
+	of_node_put(np);
+	return ret;
+}
+late_initcall(psci_init_vendor_reset)
+
 static void __init psci_init_system_reset2(void)
 {
 	int ret;

-- 
2.34.1


