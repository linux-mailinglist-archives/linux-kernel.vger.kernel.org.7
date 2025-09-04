Return-Path: <linux-kernel+bounces-800761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665EB43BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4D07AF0FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D02F363C;
	Thu,  4 Sep 2025 12:35:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E672604
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989344; cv=none; b=LnlsJxvDFOhk8cFifztd0cYa9r47Kfa+8T0r0LDnRGhHtlnMG5cPjKxnTyOEfwRJOag/KxNDCTIzNi3wAcWIq4w7QH4m1cvaZRabpswxaza4ONL8b90f+wRPBBhsvWpZtreP/ZDI8YDPFTyYo+Kcr82TWysj4OKfWmDK9I39voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989344; c=relaxed/simple;
	bh=xEYHjIDxU9ShTgEP/zDlwqIhaC5HacxzmqSr4uVAnqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y96620n0T/Nno5inm9bVTJcwHdJqL9Et5K/pyo5dgHcmfWdUxZom/A6fS/FKI0WqPA5KDGxdrCYzE2QqoaOF0zjZOv+dcMRCH1zkS66vbyTZVzwN6+o3lZWme4kzzrljkrbXKBtYysNs12cELuibaby641f0ZAfBlX+diOwQO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8AxidGQh7loVakGAA--.13927S3;
	Thu, 04 Sep 2025 20:35:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJAxE+SJh7lot_99AA--.5542S2;
	Thu, 04 Sep 2025 20:35:24 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	wangyao@lemote.com,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
Date: Thu,  4 Sep 2025 20:35:04 +0800
Message-ID: <cover.1756987761.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+SJh7lot_99AA--.5542S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyxtFyxZF1fuF47Wr15Awc_yoW7Kry7pa
	15ursxCr1DKF1xJrZ3Aw1fuFyYga95Ja4SgF17A345uF4UC3WjyrWFka13XFy7AF4kKry2
	qrs3JF4Ska45u3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==

Hi all:

This patchset introduces the Loongson-2K BMC.

It is a PCIe device present on servers similar to the Loongson-3 CPUs.
And it is a multifunctional device (MFD), such as display as a sub-function
of it.

For IPMI, according to the existing design, we use software simulation to
implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.

Also since both host side and BMC side read and write kcs status, we use
fifo pointer to ensure data consistency.

For the display, based on simpledrm, the resolution is read from a fixed
position in the BMC since the hardware does not support auto-detection
of the resolution. Of course, we will try to support multiple
resolutions later, through a vbios-like approach.

Especially, for the BMC reset function, since the display will be
disconnected when BMC reset, we made a special treatment of re-push.

Based on this, I will present it in four patches:
patch-1: BMC device PCI resource allocation.
patch-2: BMC reset function support
patch-3: IPMI implementation

Thanks.

-------
V11:
- Rebase on for-mfd-next branch.
Patch (2/3):
  - Rename ls2k_bmc_pdata_initial() to ls2k_bmc_init();
  - Rename ls2k_bmc_pdata to ls2k_bmc_ddata;
  - Use macros to replace magic numbers;
  - Simplify the ls2k_bmc_init() code by removing unnecessary goto statements.

Link to V10:
https://lore.kernel.org/all/cover.1755853480.git.zhoubinbin@loongson.cn/

V10:
Patch (2/3):
 - The PTR_ERR(NULL) is success. It should be "ret = -ENOMEM;".
    - https://lore.kernel.org/all/202508191519.uT5io1jk-lkp@intel.com/

Link to V9:
https://lore.kernel.org/all/cover.1754999365.git.zhoubinbin@loongson.cn/

V9:
Patch (2/3):
 - PCIE -> PCI-E in dev_err();
 - Separate the read from the write;

Link to V8:
https://lore.kernel.org/all/cover.1752548073.git.zhoubinbin@loongson.cn/

V8:
Patch (1/3):
 - Similar to as3711_subdevs, identify elements in ls2k_bmc_cells.

Patch (2/3):
 - Rename variables using usual names, such as `priv` -> `ddata`;
 - Use if statements instead of #ifery;
 - Rewrite the error message to ensure it is easy to understand;
 - ls2k_bmc_pdata_initial(dev, priv); -> ls2k_bmc_pdata_initial(priv);

Link to V7:
https://lore.kernel.org/all/cover.1751617911.git.zhoubinbin@loongson.cn/

V7:
Patch (1/3):
  - Fix build warning by lkp: Add depend on ACPI_GENERIC_GSI
    - https://lore.kernel.org/all/202507021011.sDAHGinj-lkp@intel.com/

Link to V6:
https://lore.kernel.org/all/cover.1750939357.git.zhoubinbin@loongson.cn/

V6:
- Add Acked-by tag from Corey, thanks;
Patch (1/3):
  - Fix build warning by lkp: Add depend on PCI
    - https://lore.kernel.org/all/202506210204.LVZc2VG2-lkp@intel.com/
    - https://lore.kernel.org/all/202506210231.ZWWNhofU-lkp@intel.com/
    - https://lore.kernel.org/all/202506210652.ipUFDU5B-lkp@intel.com/
    - https://lore.kernel.org/all/202506210343.XCHkzorp-lkp@intel.com/

Link to V5:
https://lore.kernel.org/all/cover.1750301674.git.zhoubinbin@loongson.cn/

V5:
Patch (1/3):
 - Rename ls2kbmc-mfd.c to ls2k-bmc-core.c;
 - Rename MFD_LS2K_BMC to MFD_LS2K_BMC_CORE and update its help text.
Patch (3/3):
 - Add an IPMI_LS2K config in the IPMI section that enables the IPMI
   interface and selects MFD_LS2K_BMC_CORE.

Link to V4:
https://lore.kernel.org/all/cover.1749731531.git.zhoubinbin@loongson.cn/

V4:
- Add Reviewed-by tag;
- Change the order of the patches.
Patch (1/3):
  - Fix build warning by lkp: Kconfig tristate -> bool
    - https://lore.kernel.org/all/202505312022.QmFmGE1F-lkp@intel.com/
 - Update commit message;
 - Move MFD_LS2K_BMC after MFD_INTEL_M10_BMC_PMCI in Kconfig and
   Makefile.
Patch (2/3):
  - Remove unnecessary newlines;
  - Rename ls2k_bmc_check_pcie_connected() to
    ls2k_bmc_pcie_is_connected();
  - Update comment message.
Patch (3/3):
  - Remove unnecessary newlines.

Link to V3:
https://lore.kernel.org/all/cover.1748505446.git.zhoubinbin@loongson.cn/

V3:
Patch (1/3):
 - Drop "MFD" in title and comment;
 - Fromatting code;
 - Add clearer comments.
Patch (2/3):
 - Rebase linux-ipmi/next tree;
 - Use readx()/writex() to read and write IPMI data instead of structure
   pointer references;
 - CONFIG_LOONGARCH -> MFD_LS2K_BMC;
 - Drop unused output.
Patch (3/3):
 - Inline the ls2k_bmc_gpio_reset_handler() function to ls2k_bmc_pdata_initial();
 - Add clearer comments.
 - Use proper multi-line commentary as per the Coding Style documentation;
 - Define all magic numbers.

Link to V2:
https://lore.kernel.org/all/cover.1747276047.git.zhoubinbin@loongson.cn/

V2:
- Drop ls2kdrm, use simpledrm instead.
Patch (1/3):
 - Use DEFINE_RES_MEM_NAMED/MFD_CELL_RES simplified code;
 - Add resolution fetching due to replacing the original display
   solution with simpledrm; 
 - Add aperture_remove_conflicting_devices() to avoid efifb
   conflict with simpledrm.
Patch (3/3):
 - This part of the function, moved from the original ls2kdrm to mfd;
 - Use set_console to implement the Re-push display function.

Link to V1:
https://lore.kernel.org/all/cover.1735550269.git.zhoubinbin@loongson.cn/

Binbin Zhou (3):
  mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
  mfd: ls2kbmc: Add Loongson-2K BMC reset function support
  ipmi: Add Loongson-2K BMC support

 MAINTAINERS                      |   7 +
 drivers/char/ipmi/Kconfig        |   7 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmi_si.h      |   7 +
 drivers/char/ipmi/ipmi_si_intf.c |   4 +
 drivers/char/ipmi/ipmi_si_ls2k.c | 189 +++++++++++
 drivers/mfd/Kconfig              |  13 +
 drivers/mfd/Makefile             |   2 +
 drivers/mfd/ls2k-bmc-core.c      | 528 +++++++++++++++++++++++++++++++
 9 files changed, 758 insertions(+)
 create mode 100644 drivers/char/ipmi/ipmi_si_ls2k.c
 create mode 100644 drivers/mfd/ls2k-bmc-core.c


base-commit: a4eb677652a5da4d8e7271c0c0c8719c39f10e36
-- 
2.47.3


