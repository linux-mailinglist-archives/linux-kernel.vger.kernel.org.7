Return-Path: <linux-kernel+bounces-851766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92643BD733D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30B23B9302
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752E3074AF;
	Tue, 14 Oct 2025 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mmt9H3QY"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9F271446
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413426; cv=none; b=K13+r2cpFWwiQ0uOiDo6Gvc2fTouVIfGmAbLZkQDL5FPS10nAl5G2N4fH38dFaJS3lyBoVBPrgYaJEgLCQnc/lV2eHQT7zaTM4XrvZyZIzgTgTJPhD83BK+RypXcBgf8uTVuPjOoDzZlb/ySZXq//m5qGb2qndUqjedP5t7Gd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413426; c=relaxed/simple;
	bh=nApOhCO7oQRPks4dpZ9qh7dWVRKj2oPWM52yoAkdvkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqX7SYbiScqdWg1EiBM3HHXH61KL0PDJ69pshkddtqradAWelp/QoWF0mIakKFrrOvXO5YdzMzQZVbiGDuP8WxVwMMH/z/C9Kb1wkHvyRrN/9n9stDlco0H9Xv3s2P573S/U5cY0OW09xD1LpWfFnf1WH0sdhrQUhbmo78HSuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mmt9H3QY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-170.bstnma.fios.verizon.net [173.48.82.170])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59E3hNep023332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760413405; bh=mCLs0X9FabvyxovgaAaV7geh1Q95RpSMYCd1no+3Mw4=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=mmt9H3QYTcDl2VBxGgfiYVDiRnTt10DkFOXAgV8vCM0XnrlziRylMreJUme/wlwXj
	 W2mB5DG6jmkoXAuUp96Iri+37dDv/uO4hb/qKG6CoCcc6pLgWvJwm4nRjs+GKWnp6q
	 VR8crzF2HoO+7I9pKgERj9oFI7lRpdpkV/Mdj/pPFp3PfQramiGiFw2ovZ+8W6vjR0
	 zysfUrw+xzJghM6s+M60qMrqDkAneHQp6/4q4SUc+BJxhy7O4x2ceJBx71OPJMwBcn
	 YmRR4c6tBVZvVu4TdDp4MGkcCndRExWXSe1qLEFljDOAiEO2vhiuoXh9dtVtAnNR5J
	 0PlWydEihhHEg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 970E02E00D9; Mon, 13 Oct 2025 23:43:23 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Cc: linux@roeck-us.net, Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of the defconfigs
Date: Mon, 13 Oct 2025 23:43:07 -0400
Message-ID: <20251014034307.718357-1-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
removed the obsolete EXT3_CONFIG options, since it had been over a
decade since fs/ext3 had been removed.  Unfortunately, there were a
number of defconfigs that still used CONFIG_EXT3_FS which the cleanup
commit didn't fix up.  This led to a large number of defconfig test
builds to fail.  Oops.

Fixes: d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 arch/arc/configs/axs101_defconfig           | 2 +-
 arch/arc/configs/axs103_defconfig           | 2 +-
 arch/arc/configs/axs103_smp_defconfig       | 2 +-
 arch/arc/configs/hsdk_defconfig             | 2 +-
 arch/arc/configs/vdk_hs38_defconfig         | 2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig     | 2 +-
 arch/arm/configs/axm55xx_defconfig          | 2 +-
 arch/arm/configs/bcm2835_defconfig          | 4 ++--
 arch/arm/configs/davinci_all_defconfig      | 2 +-
 arch/arm/configs/dove_defconfig             | 4 ++--
 arch/arm/configs/ep93xx_defconfig           | 4 ++--
 arch/arm/configs/imx_v6_v7_defconfig        | 6 +++---
 arch/arm/configs/ixp4xx_defconfig           | 4 ++--
 arch/arm/configs/mmp2_defconfig             | 2 +-
 arch/arm/configs/moxart_defconfig           | 2 +-
 arch/arm/configs/multi_v5_defconfig         | 2 +-
 arch/arm/configs/mv78xx0_defconfig          | 4 ++--
 arch/arm/configs/mvebu_v5_defconfig         | 2 +-
 arch/arm/configs/nhk8815_defconfig          | 2 +-
 arch/arm/configs/omap1_defconfig            | 2 +-
 arch/arm/configs/omap2plus_defconfig        | 2 +-
 arch/arm/configs/orion5x_defconfig          | 4 ++--
 arch/arm/configs/pxa_defconfig              | 6 +++---
 arch/arm/configs/qcom_defconfig             | 2 +-
 arch/arm/configs/rpc_defconfig              | 2 +-
 arch/arm/configs/s3c6400_defconfig          | 6 +++---
 arch/arm/configs/sama7_defconfig            | 2 +-
 arch/arm/configs/socfpga_defconfig          | 2 +-
 arch/arm/configs/spear13xx_defconfig        | 4 ++--
 arch/arm/configs/spear3xx_defconfig         | 4 ++--
 arch/arm/configs/spear6xx_defconfig         | 4 ++--
 arch/arm/configs/spitz_defconfig            | 4 ++--
 arch/arm/configs/stm32_defconfig            | 2 +-
 arch/arm/configs/tegra_defconfig            | 6 +++---
 arch/arm/configs/u8500_defconfig            | 2 +-
 arch/arm/configs/vexpress_defconfig         | 2 +-
 arch/hexagon/configs/comet_defconfig        | 6 +++---
 arch/loongarch/configs/loongson3_defconfig  | 6 +++---
 arch/m68k/configs/stmark2_defconfig         | 6 +++---
 arch/microblaze/configs/mmu_defconfig       | 2 +-
 arch/mips/configs/bigsur_defconfig          | 6 +++---
 arch/mips/configs/cobalt_defconfig          | 6 +++---
 arch/mips/configs/decstation_64_defconfig   | 6 +++---
 arch/mips/configs/decstation_defconfig      | 6 +++---
 arch/mips/configs/decstation_r4k_defconfig  | 6 +++---
 arch/mips/configs/fuloong2e_defconfig       | 2 +-
 arch/mips/configs/ip22_defconfig            | 6 +++---
 arch/mips/configs/ip27_defconfig            | 6 +++---
 arch/mips/configs/ip28_defconfig            | 6 +++---
 arch/mips/configs/ip30_defconfig            | 6 +++---
 arch/mips/configs/ip32_defconfig            | 6 +++---
 arch/mips/configs/jazz_defconfig            | 2 +-
 arch/mips/configs/lemote2f_defconfig        | 6 +++---
 arch/mips/configs/loongson1b_defconfig      | 6 +++---
 arch/mips/configs/loongson1c_defconfig      | 6 +++---
 arch/mips/configs/loongson2k_defconfig      | 6 +++---
 arch/mips/configs/loongson3_defconfig       | 6 +++---
 arch/mips/configs/malta_defconfig           | 2 +-
 arch/mips/configs/malta_kvm_defconfig       | 2 +-
 arch/mips/configs/malta_qemu_32r6_defconfig | 2 +-
 arch/mips/configs/maltaaprp_defconfig       | 2 +-
 arch/mips/configs/maltasmvp_defconfig       | 6 +++---
 arch/mips/configs/maltasmvp_eva_defconfig   | 2 +-
 arch/mips/configs/maltaup_defconfig         | 2 +-
 arch/mips/configs/maltaup_xpa_defconfig     | 2 +-
 arch/mips/configs/mtx1_defconfig            | 6 +++---
 arch/mips/configs/rm200_defconfig           | 2 +-
 arch/openrisc/configs/or1klitex_defconfig   | 2 +-
 arch/openrisc/configs/virt_defconfig        | 4 ++--
 arch/parisc/configs/generic-32bit_defconfig | 4 ++--
 arch/parisc/configs/generic-64bit_defconfig | 4 ++--
 arch/sh/configs/ap325rxa_defconfig          | 6 +++---
 arch/sh/configs/apsh4a3a_defconfig          | 2 +-
 arch/sh/configs/apsh4ad0a_defconfig         | 2 +-
 arch/sh/configs/ecovec24_defconfig          | 6 +++---
 arch/sh/configs/edosk7760_defconfig         | 2 +-
 arch/sh/configs/espt_defconfig              | 2 +-
 arch/sh/configs/landisk_defconfig           | 2 +-
 arch/sh/configs/lboxre2_defconfig           | 2 +-
 arch/sh/configs/magicpanelr2_defconfig      | 4 ++--
 arch/sh/configs/r7780mp_defconfig           | 2 +-
 arch/sh/configs/r7785rp_defconfig           | 2 +-
 arch/sh/configs/rsk7264_defconfig           | 2 +-
 arch/sh/configs/rsk7269_defconfig           | 2 +-
 arch/sh/configs/sdk7780_defconfig           | 4 ++--
 arch/sh/configs/sdk7786_defconfig           | 2 +-
 arch/sh/configs/se7343_defconfig            | 2 +-
 arch/sh/configs/se7712_defconfig            | 2 +-
 arch/sh/configs/se7721_defconfig            | 2 +-
 arch/sh/configs/se7722_defconfig            | 2 +-
 arch/sh/configs/se7724_defconfig            | 6 +++---
 arch/sh/configs/sh03_defconfig              | 4 ++--
 arch/sh/configs/sh2007_defconfig            | 2 +-
 arch/sh/configs/sh7757lcr_defconfig         | 2 +-
 arch/sh/configs/sh7763rdp_defconfig         | 2 +-
 arch/sh/configs/sh7785lcr_32bit_defconfig   | 2 +-
 arch/sh/configs/sh7785lcr_defconfig         | 2 +-
 arch/sh/configs/shx3_defconfig              | 2 +-
 arch/sh/configs/titan_defconfig             | 4 ++--
 arch/sh/configs/ul2_defconfig               | 2 +-
 arch/sh/configs/urquell_defconfig           | 2 +-
 arch/sparc/configs/sparc64_defconfig        | 6 +++---
 arch/xtensa/configs/audio_kc705_defconfig   | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig   | 2 +-
 arch/xtensa/configs/generic_kc705_defconfig | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig   | 2 +-
 arch/xtensa/configs/smp_lx200_defconfig     | 2 +-
 arch/xtensa/configs/virt_defconfig          | 2 +-
 arch/xtensa/configs/xip_kc705_defconfig     | 2 +-
 109 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index a7cd526dd7ca..f930396d9dae 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -88,7 +88,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index afa6a348f444..6b779dee5ea0 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -86,7 +86,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 2bfa6371953c..a89b50d5369d 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -88,7 +88,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 1558e8e87767..1b8b2a098cda 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -77,7 +77,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DW_AXI_DMAC=y
 CONFIG_IIO=y
 CONFIG_TI_ADC108S102=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 03d9ac20baa9..b7120523e09a 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -74,7 +74,7 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_SERIAL=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index c09488992f13..4077abd5980c 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -81,7 +81,7 @@ CONFIG_MMC_DW=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 516689dc6cf1..9b263ea9a878 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -194,7 +194,7 @@ CONFIG_MAILBOX=y
 CONFIG_PL320_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS_FS=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 27dc3bf6b124..4a8ac09843d7 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -154,8 +154,8 @@ CONFIG_PWM_BCM2835=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index e2ddaca0f89d..673408a10888 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -228,7 +228,7 @@ CONFIG_PWM=y
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_XFS_FS=m
 CONFIG_AUTOFS_FS=m
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index d76eb12d29a7..bb6c4748bfc8 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -95,8 +95,8 @@ CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_XATTR is not set
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 2248afaf35b5..7f3756d8b086 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -103,8 +103,8 @@ CONFIG_RTC_DRV_EP93XX=y
 CONFIG_DMADEVICES=y
 CONFIG_EP93XX_DMA=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_XATTR is not set
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9a57763a8d38..0d55056c6f82 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -436,9 +436,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=y
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 3cb995b9616a..81199dddcde7 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -158,8 +158,8 @@ CONFIG_IXP4XX_NPE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_OVERLAY_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 842a989baa27..f67e9cda73e2 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -53,7 +53,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8925=y
 # CONFIG_RESET_CONTROLLER is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index fa06d98e43fc..e2d9f3610063 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -113,7 +113,7 @@ CONFIG_RTC_DRV_MOXART=y
 CONFIG_DMADEVICES=y
 CONFIG_MOXART_DMA=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index b523bc246c09..59b020e66a0b 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -268,7 +268,7 @@ CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_UDF_FS=m
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 3343f72de7ea..55f4ab67a306 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -91,8 +91,8 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_XATTR is not set
 CONFIG_EXT4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 23dbb80fcc2e..d1742a7cae6a 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -168,7 +168,7 @@ CONFIG_MV_XOR=y
 CONFIG_STAGING=y
 CONFIG_FB_XGI=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_UDF_FS=m
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index ea28ed8991b4..696b4fbc2412 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -116,7 +116,7 @@ CONFIG_IIO_ST_ACCEL_3AXIS=y
 CONFIG_PWM=y
 CONFIG_PWM_STMPE=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 661e5d6894bd..24c54bf1e243 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -184,7 +184,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_AUTOFS_FS=y
 CONFIG_ISO9660_FS=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 939913ed9a73..8f443c20872b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -679,7 +679,7 @@ CONFIG_TWL4030_USB=m
 CONFIG_COUNTER=m
 CONFIG_TI_EQEP=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 62b9c6102789..c28426250ec3 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -115,8 +115,8 @@ CONFIG_RTC_DRV_M48T86=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_XATTR is not set
 CONFIG_EXT4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 1a80602c1284..4b988a9e2768 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -580,9 +580,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index ec52ccece0ca..5a0513290547 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -295,7 +295,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8974=m
 CONFIG_INTERCONNECT_QCOM_SDX55=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FUSE_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 24f1fa868230..46df453e224e 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -77,7 +77,7 @@ CONFIG_SOUND_VIDC=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8583=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index a37e6ac40825..4c635818973c 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -53,9 +53,9 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_PWM=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index e14720a9a5ac..e2ad9a05566f 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -201,7 +201,7 @@ CONFIG_MCHP_EIC=y
 CONFIG_RESET_CONTROLLER=y
 CONFIG_NVMEM_MICROCHIP_OTPC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_VFAT_FS=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 294906c8f16e..f2e42846b116 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -136,7 +136,7 @@ CONFIG_FPGA_REGION=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_AUTOFS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index a8f992fdb30d..8b19af1ea67c 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -84,8 +84,8 @@ CONFIG_DMATEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=m
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 8dc5a388759c..b4e4b96a98af 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -67,8 +67,8 @@ CONFIG_DMATEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 4e9e1a6ff381..7083b1bd8573 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -53,8 +53,8 @@ CONFIG_DMATEST=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index ac2a0f998c73..395df2f9dc8e 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -193,8 +193,8 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_XATTR is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index dcd9c316072e..82190b155b14 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -69,7 +69,7 @@ CONFIG_STM32_MDMA=y
 CONFIG_IIO=y
 CONFIG_STM32_ADC_CORE=y
 CONFIG_STM32_ADC=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index ba863b445417..ab477ca13f89 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -319,9 +319,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 0f55815eecb3..f3bc967a0f25 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -175,7 +175,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index cdb6065e04fd..b9454f6954f8 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -120,7 +120,7 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index c6108f000288..b132752693a9 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -46,10 +46,10 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 34eaee0384c9..f3e2c588e5df 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -929,9 +929,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index 7787a4dd7c3c..f3268fed02fc 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -72,9 +72,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 176314f3c9aa..fbbdcb394ca2 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -73,7 +73,7 @@ CONFIG_FB_XILINX=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 CONFIG_UIO_DMEM_GENIRQ=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 97d2cd997285..349e9e0b4f54 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -144,9 +144,9 @@ CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=m
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=m
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index b0b551efac7c..6ee9ee391fdc 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -59,9 +59,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index 85a4472cb058..52a63dd7aac7 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -133,9 +133,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index a3b2c8da2dde..59fb7ee5eeb0 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -129,9 +129,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index a476717b8a6a..8be1cb433e95 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -129,9 +129,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index cdedbb8a8f53..b6fe3c962464 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -173,7 +173,7 @@ CONFIG_USB_ISIGHTFW=m
 CONFIG_UIO=m
 CONFIG_UIO_CIF=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_AUTOFS_FS=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 2decf8b98d31..e123848f94ab 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -232,9 +232,9 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1286=y
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_QUOTA=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 5d079941fd20..1c10242b148b 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -272,9 +272,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 6db21e498faa..755cbf20f5a5 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -49,9 +49,9 @@ CONFIG_WATCHDOG=y
 CONFIG_INDYDOG=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_PROC_KCORE=y
 # CONFIG_PROC_PAGE_MONITOR is not set
diff --git a/arch/mips/configs/ip30_defconfig b/arch/mips/configs/ip30_defconfig
index a4524e785469..718f3060d9fa 100644
--- a/arch/mips/configs/ip30_defconfig
+++ b/arch/mips/configs/ip30_defconfig
@@ -143,9 +143,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index d8ac11427f69..7568838eb08b 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -89,9 +89,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V1=m
 CONFIG_QFMT_V2=m
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 65adb538030d..a790c2610fd3 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -69,7 +69,7 @@ CONFIG_FB_G364=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_AUTOFS_FS=m
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 5038a27d035f..8d3f20ed19b5 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -226,9 +226,9 @@ CONFIG_MMC=m
 CONFIG_LEDS_CLASS=y
 CONFIG_STAGING=y
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_XFS_FS=m
diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index 68207b31dc20..a64a39447963 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -94,9 +94,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
index c3910a9dee9e..86d7f64a164a 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -95,9 +95,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 0cc665d3ea34..aec1fd1902eb 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -298,9 +298,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 240efff37d98..575aaf242361 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -348,9 +348,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_QUOTA=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 9fcbac829920..81704ec67f09 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -313,7 +313,7 @@ CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=m
 CONFIG_UIO_CIF=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 19102386a81c..82a97f58bce1 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -319,7 +319,7 @@ CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=m
 CONFIG_UIO_CIF=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 1b98f6945c2d..accb471a1d93 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -148,7 +148,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 7b8905cb3400..6bda67c5f68f 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -149,7 +149,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 8249f6a51895..e4082537f80f 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -148,9 +148,9 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 21cb37668763..58f5af45fa98 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -152,7 +152,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 3df9cd669683..9bfef7de0d1c 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -148,7 +148,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 1dd07c9d1812..0f9ef20744f9 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -319,7 +319,7 @@ CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=m
 CONFIG_UIO_CIF=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index e4bcdb64df6c..b4dc2255a81c 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -594,9 +594,9 @@ CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=m
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=m
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_AUTOFS_FS=y
 CONFIG_FUSE_FS=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 39a2419e1f3e..b507dc4dddd4 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -307,7 +307,7 @@ CONFIG_USB_SISUSBVGA=m
 CONFIG_USB_LD=m
 CONFIG_USB_TEST=m
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_AUTOFS_FS=m
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index 3e849d25838a..fb1eb9a68bd6 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -38,7 +38,7 @@ CONFIG_MMC_LITEX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_LITEX_SOC_CONTROLLER=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_EXFAT_FS=y
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index c1b69166c500..01d685f3fb17 100644
--- a/arch/openrisc/configs/virt_defconfig
+++ b/arch/openrisc/configs/virt_defconfig
@@ -94,8 +94,8 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 94928d114d4c..52031bde9f17 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -232,8 +232,8 @@ CONFIG_AUXDISPLAY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_QFMT_V2=y
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index d8cd7f858b2a..1aec04c09d0b 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -251,8 +251,8 @@ CONFIG_STAGING=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_QUOTA=y
diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index b6f36c938f1d..336dbacd89bd 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -81,10 +81,10 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index 9c2644443c4d..59daf99ea745 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -60,7 +60,7 @@ CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 137573610ec4..df2a669ea9d8 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -88,7 +88,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index e76694aace25..dd7e54c451d6 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -109,10 +109,10 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index f427a95bcd21..711db47b65ba 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -87,7 +87,7 @@ CONFIG_SND_SOC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_XIP=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
index da176f100e00..f8cad1e7a333 100644
--- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -59,7 +59,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_AUTOFS_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 924bb3233b0b..08342ceee32e 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -93,7 +93,7 @@ CONFIG_USB_EMI62=m
 CONFIG_USB_EMI26=m
 CONFIG_USB_SISUSBVGA=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_ISO9660_FS=m
 CONFIG_MSDOS_FS=y
diff --git a/arch/sh/configs/lboxre2_defconfig b/arch/sh/configs/lboxre2_defconfig
index 0307bb2be79f..96a21173522d 100644
--- a/arch/sh/configs/lboxre2_defconfig
+++ b/arch/sh/configs/lboxre2_defconfig
@@ -49,7 +49,7 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_RTC_CLASS=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 93b9aa32dc7c..af7f777b20be 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -64,9 +64,9 @@ CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index f28b8c4181c2..11f210517f76 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -74,7 +74,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_FUSE_FS=m
 CONFIG_MSDOS_FS=y
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index 3a4239f20ff1..ae367d7a14a8 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -69,7 +69,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_FUSE_FS=m
 CONFIG_MSDOS_FS=y
diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
index e4ef259425c4..3aba0102304f 100644
--- a/arch/sh/configs/rsk7264_defconfig
+++ b/arch/sh/configs/rsk7264_defconfig
@@ -59,7 +59,7 @@ CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_NFS_FS=y
diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
index e0d1560b2bfd..f82f280fc55a 100644
--- a/arch/sh/configs/rsk7269_defconfig
+++ b/arch/sh/configs/rsk7269_defconfig
@@ -43,7 +43,7 @@ CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_NFS_FS=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index 9870d16d9711..3b51195bf1b5 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -102,9 +102,9 @@ CONFIG_LEDS_CLASS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_MSDOS_FS=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 07894f13441e..ebb3f4420ae8 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -161,7 +161,7 @@ CONFIG_STAGING=y
 # CONFIG_STAGING_EXCLUDE_BUILD is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=y
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 75db12fb9ad1..6ef546ee8a32 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -84,7 +84,7 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_ISP116X_HCD=y
 CONFIG_UIO=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_JFFS2_FS=y
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index 8770a72e6a63..4cecf9c06a65 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -83,7 +83,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_JFFS2_FS=y
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index b15c6406a0e8..c28057b70ad7 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -107,7 +107,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 5327a2f70980..88bfd953ef89 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -44,7 +44,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index 9501e69eb886..e1b2616ef921 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -110,10 +110,10 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 4d75c92cac10..306e1661fbf5 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -57,9 +57,9 @@ CONFIG_WATCHDOG=y
 CONFIG_SH_WDT=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS_FS=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index cc6292b3235a..889daa5d2faa 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -95,7 +95,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_DMADEVICES=y
 CONFIG_TIMB_DMA=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 48a0f9beb116..25e9d22779b3 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -64,7 +64,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index b77b3313157e..85ec00b7dbd2 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -61,7 +61,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_AUTOFS_FS=y
 CONFIG_MSDOS_FS=y
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 44f9b2317f09..e860a20d3f0f 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -113,7 +113,7 @@ CONFIG_RTC_DRV_RS5C372=y
 CONFIG_DMADEVICES=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index aec74b0e7003..33c98b4a2adb 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -90,7 +90,7 @@ CONFIG_USB_TEST=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index 9a0df5ea3866..3169e4dc7004 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -84,7 +84,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 8ef72b8dbcd3..6bff00038072 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -215,9 +215,9 @@ CONFIG_USB_SERIAL_PL2303=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4_FS_XATTR is not set
 CONFIG_XFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 103b81ec1ffb..b89eb8f5cc5c 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -66,7 +66,7 @@ CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 00ef62133b04..60cb716ef195 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -114,7 +114,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_BTRFS_FS=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 7a7c4dec2925..200640b93e05 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -187,10 +187,10 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index f2af1a32c9c7..dc942bbac69f 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -103,7 +103,7 @@ CONFIG_SND_SIMPLE_CARD=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_COMMON_CLK_CDCE706=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 88ed5284e21c..81a057f25f21 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -80,7 +80,7 @@ CONFIG_SOFT_WATCHDOG=y
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index 4427907becca..3ee7e1c56556 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -90,7 +90,7 @@ CONFIG_SOFT_WATCHDOG=y
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 5828228522ba..c6e96f0aa700 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -91,7 +91,7 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_SOFT_WATCHDOG=y
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 326966ca7831..373d42b9e510 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -94,7 +94,7 @@ CONFIG_SOFT_WATCHDOG=y
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
diff --git a/arch/xtensa/configs/virt_defconfig b/arch/xtensa/configs/virt_defconfig
index e37048985b47..72628d31e87a 100644
--- a/arch/xtensa/configs/virt_defconfig
+++ b/arch/xtensa/configs/virt_defconfig
@@ -76,7 +76,7 @@ CONFIG_LOGO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_INPUT=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index ee47438f9b51..5d6013ea70fc 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -82,7 +82,7 @@ CONFIG_SOFT_WATCHDOG=y
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
-- 
2.51.0


