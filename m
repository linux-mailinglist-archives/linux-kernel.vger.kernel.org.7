Return-Path: <linux-kernel+bounces-739758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3B0B0CA84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239FD4E36ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7A2E1757;
	Mon, 21 Jul 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKryXw8d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B12E1C44
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122583; cv=none; b=qXMb++gVzk7ryhYXJgkkMZDdSpAFtlFbh65aOJfFDC7U1rX2BnyqkEO52cf/tfToSZEc/tRN1VG19RlErXa04qI4pf7w6BJLuKc2nymNmMtKnYsmL/wTqGZGa2Ze/h6LQ0HvXQBK9MmVlx37XMUE0DpGI0RI1/h+YyVdc3ZihkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122583; c=relaxed/simple;
	bh=Y0M2kz4HUE94r4RXMotv0mkp+GddzwJz75VbdAmmA+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKJMbijHWEFAzu+WiU6RM4ICZSonJfwNEDZGiqDHyTztJNVlu2n66Eipo8jzFDTpEB2DNhAuhDhhAbhB5diptWfvjdjDu092opbadV7LSp9NmcU095254yTsjzBLs0xy9LUM3+89saf9SKVbhHZRn+takQakUZfB40S0pMG2aHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKryXw8d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGTu7Y029264
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yo29nftHFYZtObTkPZy6VDU45lEt8daBatpcCrb4rZc=; b=FKryXw8dHsDl15ze
	wx+X6SDNB8zT2RFjaAzNBF5YE4Jg/S7B8U6fGyliJ4Tpv5WbpizOn01d0fSEDCBx
	DHDTe8sSG7gmPSZZ+L3FxS0qb78t9vH5d4wpi59+Yydgiv5IY2OJJBaQ4PGS37lb
	vCwdLUEleI/ctq61GotOgBAdLwNrbvglRnz+wlXoQKb0k2xFq4iRDmSN76v15yE8
	zfOmjmD+ShX8grw6YuU2gqFRimpcVsqYisCYuaLgIeILZrK68BVt4tj1sTXDU2Rq
	WVzSiv3lgL8RMUDW/Vr+LMvuPBpz5gcjh8Pq+1yJEpFa2DF6RCCNe4S0HNuLW9X/
	ZmMbyw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048ter5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:29:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23536f7c2d7so76593835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122578; x=1753727378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo29nftHFYZtObTkPZy6VDU45lEt8daBatpcCrb4rZc=;
        b=nJx9SPsWkHh+CpZ9znOpLLBnSMJMmq5wsEvBzCZy28Qr9hMtek/A5zSipchOcIdSCu
         2ZQxs0OtpuuvZ73+isZ9OYKUFyImeffbEOFih8CKJwG9ZEHUn7zbffEVV58CTfyrlUAK
         HEjh+xKzD3K/kcMAxu485eXR6U0pkPzTj4hpvFuB8cIzFTCuQ2rkrFkae6JLgl7QABc9
         vWAOT8eKnyS/Vz/uPnUMQ/Cp5NSvTR3KE3ugNz9cawT8wi5ZWDIcKqR7bMqCRDpOHQDX
         WLO8QkW/C4mc5Gn3fQ5DQrm5x8MOtjaoNG+NJWsbwBV9Dw7o7+F+l4JOoxqed/H3/pyk
         xyoA==
X-Forwarded-Encrypted: i=1; AJvYcCUTKeEdOwEB3zjzj4NhjEZIy4EMgc8By32UhqiSV+d+hDCYeHpFpFRh84WTzvLrBdbeEzf5E5AsF9uPPY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkSt9L91BatHLs9NhXGJjxnSToGrT0K9qAxGM0J8c/JN+/L24
	IGc2UFp3wz3WBM+EdtWxtZwu9cp0DsEj4fosDdyztkZzrNfOEaHppAvn9d24m6fjw2Zqqohx9xA
	9lsZNopCzm2MgTUOoGeBKPJUnDWTDoido2m2a5TsmFYNuCblzAXPSwgGqs7xTNOj0MQM=
X-Gm-Gg: ASbGncvuSI8p9NNRFNPC5Y2mvc8Gpoz8pjU3eDTItd4O/qbPthPSfRswudwM/F3Iyeg
	SpKCgWjdacQwAjy7vGHQMl9eq1yL/ufsCNLYJCSAtpohe6sOb75FNSMp3VCPgPFf93heKSX7KFO
	jxLs0hnsiCorAXn8nRiQJukclXWZ45frODp4fWsb71xDL1dkcTNsKQMAOgCQCj8KOjUGHmbjT4G
	7O6k6h4TLBtKwmf0Yep5itSDCkUNTuJP+jo3u+aSVSqcz4C91ZSfuDZ+MHzjIDjONyEz5ZstPep
	PFJ+sDL8sc+1nJSOeDNl0dP4RC5hcHMbKAIOPk7orhqZ8jBJSQTov0SuEOqw9IvgTFL7HukY/rn
	E
X-Received: by 2002:a17:902:db10:b0:235:c781:c305 with SMTP id d9443c01a7336-23e25736446mr391994645ad.24.1753122578022;
        Mon, 21 Jul 2025 11:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVFiP0ZX25Wepgp00xsVzQMu1ttAcrm238d8ApOC/0i6QmxfogZvMit+aR3PD49+4LfMgmeg==
X-Received: by 2002:a17:902:db10:b0:235:c781:c305 with SMTP id d9443c01a7336-23e25736446mr391994015ad.24.1753122577582;
        Mon, 21 Jul 2025 11:29:37 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:29:37 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:51 +0530
Subject: [PATCH v12 4/8] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-4-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=4746;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Y0M2kz4HUE94r4RXMotv0mkp+GddzwJz75VbdAmmA+I=;
 b=1zZTSkjZE49wnh2ayD0kNDf089z+CGlweQ3Ax9ee6BChYKeop9Wpk7WDnIs1YYeHNn4XHGcIz
 SabAsKzD/FQC0owBzriskkYT144jfdAlHzU7O87sNm14fMkH6dnqI6/
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX1JlwwA5V0a+8
 YiZjUrriyXUfmtxLe8PZy+Y5UjnEfso4maUtCy5gZoN8qGu80nslF4nYxDa+IS6XZ58KMN/FSk8
 gcrXP/vpDVTIZ6BVWChq4nLlrEfcEBkP8IVnG2AEFSF6p5uDgmZaDRr7HwSQruUGwRzjryk9yKx
 AO18e+aCRigcpqEPTiLYMNIBmFaBI+BXAvxCcjl95483u4ulv3JhCvPcIFrFJf1s5EUOg7x4SHK
 aH4T47tdubmMY7RyXiyUK0N91rzr0/9pjLjai9AzM+DeCJPQHRHMb9KHPCsqa3cxYjkkL3vV4n4
 e0MPiOk+MdTIu6y+ccrI7Zuhje7sR7Q3OxodbSI3D83VRK+6krWzvZ3o2FK1RQSFlHU+cFfPbUz
 PoDXU9SuuWPyknRXBrderNaZ8a/wrijgK4mfiQurukU2SXxgO1zGzvxhKtJ+0V9/by8nz4HR
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687e8713 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EdS2NIbk_1D2FrBATFAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: WboF2V3dQL705xH5-oCun60zCF_vZbUG
X-Proofpoint-ORIG-GUID: WboF2V3dQL705xH5-oCun60zCF_vZbUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

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
 drivers/firmware/psci/Kconfig |  1 +
 drivers/firmware/psci/psci.c  | 57 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..9d65fe7b06a6429de8a26d06f9384e5c93f36e5f 100644
--- a/drivers/firmware/psci/Kconfig
+++ b/drivers/firmware/psci/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM_PSCI_FW
 	bool
+	select REBOOT_MODE
 
 config ARM_PSCI_CHECKER
 	bool "ARM PSCI checker"
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..8ce23fb931c71357899a942796d85ab8e37c2f62 100644
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
+	ret = reboot_mode_register(reboot, np);
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


