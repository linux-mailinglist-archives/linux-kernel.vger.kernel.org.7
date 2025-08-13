Return-Path: <linux-kernel+bounces-767442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE9DB2543F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F931C8448D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836802FD7A8;
	Wed, 13 Aug 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRTR6Vdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4A2D541B;
	Wed, 13 Aug 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115550; cv=none; b=GGd89Qau9gTTyu/u+2kWfjtevjK4HM9I7jCsYo4yhyEBM2d/kwzO+ornU8T6JGJYb3aUmBpwMTb5UhdUPUBs9636R5FUubM1WSFAXUXtuziRHRNfSLFNWYxBSUqnHXY6iTUAucWNINU7XZ3nFCuyrWinc7H06wWVjO9t1PhjvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115550; c=relaxed/simple;
	bh=Jg9Z7QAvjp/RAR3RPWLBE1YWB3y536M6igQ7Xbi8qlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPFxcmlkLbo/f7lzmGNxAo8Us/utna1/msc6CWom4/6V5e9bPNN/0RuuG4+lNOfJw3FFCWwovIb5GZjjrAFn/UALxF2LEwsyMAmMhFZhSfxtFQzX888OQZv4xnpb2Ve2sAR5moion1cUceFVLlEfJc3gfuCUSeR63CII/lsDnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRTR6Vdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE87C4CEF1;
	Wed, 13 Aug 2025 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115550;
	bh=Jg9Z7QAvjp/RAR3RPWLBE1YWB3y536M6igQ7Xbi8qlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRTR6VdvzU1erU9L1jZaGa8Y6v/qJGw836zjahFcO9R9c91DudPC0xt5Qg9HHipeh
	 kEBuVwqYaPKO/TvvegihTnKkM2Gj/Ps80qtdKfEfXq0LsJLZgj9ctrRQ+TD8lmfpEm
	 p70otd9dOTz/enMPI56sUxDmbdWXZui6s9M9/53orLPXtRDpLTpeqPUEZWkOtSQD+z
	 u/iXkzzJZwAvEmmvVBn38L0Irvubc0AQbuNXYk8d0JKfS3KEpDVzzRSIe38efpxp8z
	 Sg3VqQIoc4XyTHku1Af9RG70Wya68xS7zSuuu+bBSOzksjHQ2M8MpTiQ/g0+F7JT92
	 vPTdGVXhL9S9g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 9/9] Documentation: Fix misc typos
Date: Wed, 13 Aug 2025 15:05:05 -0500
Message-ID: <20250813200526.290420-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/accel/qaic/aic100.rst           |  4 ++--
 Documentation/accounting/taskstats.rst        |  2 +-
 Documentation/arch/arm/keystone/knav-qmss.rst |  2 +-
 Documentation/arch/x86/cpuinfo.rst            |  2 +-
 Documentation/devicetree/usage-model.rst      |  2 +-
 Documentation/driver-api/vfio.rst             |  2 +-
 Documentation/hwmon/f71805f.rst               |  2 +-
 Documentation/misc-devices/apds990x.rst       |  2 +-
 Documentation/mm/hwpoison.rst                 |  2 +-
 Documentation/sound/cards/emu-mixer.rst       |  2 +-
 .../translations/zh_TW/process/5.Posting.rst  |  2 +-
 .../userspace-api/media/rc/rc-protos.rst      | 20 +++++++++----------
 12 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/accel/qaic/aic100.rst b/Documentation/accel/qaic/aic100.rst
index 273da6192fb3..0b575f24eab5 100644
--- a/Documentation/accel/qaic/aic100.rst
+++ b/Documentation/accel/qaic/aic100.rst
@@ -455,7 +455,7 @@ deactivate
 	Deactivate an active workload and return the NSPs to idle.
 
 status
-	Query the QSM about it's NNC implementation. Returns the NNC version,
+	Query the QSM about its NNC implementation. Returns the NNC version,
 	and if CRC is used.
 
 terminate
@@ -487,7 +487,7 @@ one user crashes, the fallout of that should be limited to that workload and not
 impact other workloads. SSR accomplishes this.
 
 If a particular workload crashes, QSM notifies the host via the QAIC_SSR MHI
-channel. This notification identifies the workload by it's assigned DBC. A
+channel. This notification identifies the workload by its assigned DBC. A
 multi-stage recovery process is then used to cleanup both sides, and get the
 DBC/NSPs into a working state.
 
diff --git a/Documentation/accounting/taskstats.rst b/Documentation/accounting/taskstats.rst
index 2a28b7f55c10..af0519c58eb7 100644
--- a/Documentation/accounting/taskstats.rst
+++ b/Documentation/accounting/taskstats.rst
@@ -141,7 +141,7 @@ in future:
 1. Adding more fields to the end of the existing struct taskstats. Backward
    compatibility is ensured by the version number within the
    structure. Userspace will use only the fields of the struct that correspond
-   to the version its using.
+   to the version it's using.
 
 2. Defining separate statistic structs and using the netlink attributes
    interface to return them. Since userspace processes each netlink attribute
diff --git a/Documentation/arch/arm/keystone/knav-qmss.rst b/Documentation/arch/arm/keystone/knav-qmss.rst
index 7f7638d80b42..f9a77eb462b2 100644
--- a/Documentation/arch/arm/keystone/knav-qmss.rst
+++ b/Documentation/arch/arm/keystone/knav-qmss.rst
@@ -39,7 +39,7 @@ CPPI/QMSS Low Level Driver document (docs/CPPI_QMSS_LLD_SDS.pdf) at
 
 	git://git.ti.com/keystone-rtos/qmss-lld.git
 
-k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports upto 48 accumulator
+k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports up to 48 accumulator
 channels. This firmware is available under ti-keystone folder of
 firmware.git at
 
diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index dd8b7806944e..4a2a4f2b5fb0 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -12,7 +12,7 @@ represents an ill-fated attempt from long time ago to put feature flags
 in an easy to find place for userspace.
 
 However, the amount of feature flags is growing by the CPU generation,
-leading to unparseable and unwieldy /proc/cpuinfo.
+leading to unparsable and unwieldy /proc/cpuinfo.
 
 What is more, those feature flags do not even need to be in that file
 because userspace doesn't care about them - glibc et al already use
diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index 0717426856b2..c89cc3cf817c 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -128,7 +128,7 @@ successor, the BeagleBoard xM board might look like, respectively::
 	compatible = "ti,omap3-beagleboard-xm", "ti,omap3450", "ti,omap3";
 
 Where "ti,omap3-beagleboard-xm" specifies the exact model, it also
-claims that it compatible with the OMAP 3450 SoC, and the omap3 family
+claims that it is compatible with the OMAP 3450 SoC, and the omap3 family
 of SoCs in general.  You'll notice that the list is sorted from most
 specific (exact board) to least specific (SoC family).
 
diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 2a21a42c9386..c358f6989c1c 100644
--- a/Documentation/driver-api/vfio.rst
+++ b/Documentation/driver-api/vfio.rst
@@ -124,7 +124,7 @@ Assume user wants to access PCI device 0000:06:0d.0::
 	../../../../kernel/iommu_groups/26
 
 This device is therefore in IOMMU group 26.  This device is on the
-pci bus, therefore the user will make use of vfio-pci to manage the
+PCI bus, therefore the user will make use of vfio-pci to manage the
 group::
 
 	# modprobe vfio-pci
diff --git a/Documentation/hwmon/f71805f.rst b/Documentation/hwmon/f71805f.rst
index 1efe5e5d337c..dea0364c2a6e 100644
--- a/Documentation/hwmon/f71805f.rst
+++ b/Documentation/hwmon/f71805f.rst
@@ -55,7 +55,7 @@ additional internal voltages monitored (VSB and battery). It also features
 6 VID inputs. The VID inputs are not yet supported by this driver.
 
 The Fintek F71806F/FG Super-I/O chip is essentially the same as the
-F71872F/FG, and is undistinguishable therefrom.
+F71872F/FG, and is indistinguishable from it.
 
 The driver assumes that no more than one chip is present, which seems
 reasonable.
diff --git a/Documentation/misc-devices/apds990x.rst b/Documentation/misc-devices/apds990x.rst
index e2f75577f731..afba68223a5e 100644
--- a/Documentation/misc-devices/apds990x.rst
+++ b/Documentation/misc-devices/apds990x.rst
@@ -26,7 +26,7 @@ using clear channel only. Lux value and the threshold level on the HW
 might vary quite much depending the spectrum of the light source.
 
 Driver makes necessary conversions to both directions so that user handles
-only lux values. Lux value is calculated using information from the both
+only lux values. Lux value is calculated using information from both
 channels. HW threshold level is calculated from the given lux value to match
 with current type of the lightning. Sometimes inaccuracy of the estimations
 lead to false interrupt, but that doesn't harm.
diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
index 483b72aa7c11..dd02fae484dc 100644
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -17,7 +17,7 @@ To quote the overview comment::
 	hardware as being corrupted usually due to a 2bit ECC memory or cache
 	failure.
 
-	This focusses on pages detected as corrupted in the background.
+	This focuses on pages detected as corrupted in the background.
 	When the current CPU tries to consume corruption the currently
 	running process can just be killed directly instead. This implies
 	that if the error cannot be handled for some reason it's safe to
diff --git a/Documentation/sound/cards/emu-mixer.rst b/Documentation/sound/cards/emu-mixer.rst
index d87a6338d3d8..edcedada4c96 100644
--- a/Documentation/sound/cards/emu-mixer.rst
+++ b/Documentation/sound/cards/emu-mixer.rst
@@ -66,7 +66,7 @@ FX-bus
 
 name='Clock Source',index=0
 ---------------------------
-This control allows switching the word clock between interally generated
+This control allows switching the word clock between internally generated
 44.1 or 48 kHz, or a number of external sources.
 
 Note: the sources for the 1616 CardBus card are unclear. Please report your
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index 38f3a6d618eb..eb41ae82d0da 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -88,7 +88,7 @@
 
  - 每個補丁都應該能創建一個可以正確地構建和運行的內核；如果補丁系列在中間被
    斷開，那麼結果仍應是一個正常工作的內核。部分應用一系列補丁是使用
-   “git bisct”工具查找回歸的一個常見場景；如果結果是一個損壞的內核，那麼將使
+   “git bisect”工具查找回歸的一個常見場景；如果結果是一個損壞的內核，那麼將使
    那些從事追蹤問題的高尚工作的開發人員和用戶的生活更加艱難。
 
  - 不要過分分割。一位開發人員曾經將一組針對單個文件的編輯分成500個單獨的補丁
diff --git a/Documentation/userspace-api/media/rc/rc-protos.rst b/Documentation/userspace-api/media/rc/rc-protos.rst
index ec706290c921..a3a9f46b2b9a 100644
--- a/Documentation/userspace-api/media/rc/rc-protos.rst
+++ b/Documentation/userspace-api/media/rc/rc-protos.rst
@@ -11,7 +11,7 @@ protocols can encode e.g. an address (which device should respond) and a
 command: what it should do. The values for these are not always consistent
 across different devices for a given protocol.
 
-Therefore out the output of the IR decoder is a scancode; a single u32
+Therefore the output of the IR decoder is a scancode; a single u32
 value. Using keymap tables this can be mapped to linux key codes.
 
 Other things can be encoded too. Some IR protocols encode a toggle bit; this
@@ -19,7 +19,7 @@ is to distinguish whether the same button is being held down, or has been
 released and pressed again. If has been released and pressed again, the
 toggle bit will invert from one IR message to the next.
 
-Some remotes have a pointer-type device which can used to control the
+Some remotes have a pointer-type device which can be used to control the
 mouse; some air conditioning systems can have their target temperature
 target set in IR.
 
@@ -75,8 +75,8 @@ protocol, or the manchester BPF decoder.
      - Command
 
 There is a variant of rc5 called either rc5x or extended rc5
-where there the second stop bit is the 6th command bit, but inverted.
-This is done so it the scancodes and encoding is compatible with existing
+where the second stop bit is the 6th command bit, but inverted.
+This is done so the scancodes and encoding are compatible with existing
 schemes. This bit is stored in bit 6 of the scancode, inverted. This is
 done to keep it compatible with plain rc-5 where there are two start bits.
 
@@ -127,7 +127,7 @@ differently.
 rc-5x-20 (RC_PROTO_RC5X_20)
 ---------------------------
 
-This rc-5 extended to encoded 20 bits. The is a 3555 microseconds space
+This rc-5 extended to encoded 20 bits. There is a 3555 microsecond space
 after the 8th bit.
 
 .. flat-table:: rc-5x-20 bits scancode mapping
@@ -182,7 +182,7 @@ jvc (RC_PROTO_JVC)
 The jvc protocol is much like nec, without the inverted values. It is
 described here https://www.sbprojects.net/knowledge/ir/jvc.php.
 
-The scancode is a 16 bits value, where the address is the lower 8 bits
+The scancode is a 16 bit value, where the address is the lower 8 bits
 and the command the higher 8 bits; this is reversed from IR order.
 
 sony-12 (RC_PROTO_SONY12)
@@ -329,11 +329,11 @@ The scancode has a somewhat unusual encoding.
 sanyo (RC_PROTO_SANYO)
 ----------------------
 
-The sanyo protocol is like the nec protocol, but with 13 bits address
+The sanyo protocol is like the nec protocol, but with 13 bit address
 rather than 8 bits. Both the address and the command are followed by
 their inverted versions, but these are not present in the scancodes.
 
-Bis 8 to 20 of the scancode is the 13 bits address, and the lower 8
+Bis 8 to 20 of the scancode is the 13 bit address, and the lower 8
 bits are the command.
 
 mcir2-kbd (RC_PROTO_MCIR2_KBD)
@@ -388,7 +388,7 @@ rc-6-mce (RC_PROTO_RC6_MCE)
 This is the rc-6 in mode 6a, 32 bits. The upper 16 bits are the vendor,
 and the lower 16 bits are the vendor-specific bits. This protocol is
 for the Microsoft MCE variant (vendor = 0x800f). The toggle bit in the
-protocol itself is ignored, and the 16th bit should be takes as the toggle
+protocol itself is ignored, and the 16th bit should be taken as the toggle
 bit.
 
 sharp (RC_PROTO_SHARP)
@@ -399,7 +399,7 @@ https://www.sbprojects.net/knowledge/ir/sharp.php. There is a very long
 (40ms) space between the normal and inverted values, and some IR receivers
 cannot decode this.
 
-There is a 5 bit address and a 8 bit command. In the scancode the address is
+There is a 5 bit address and an 8 bit command. In the scancode the address is
 in bits 8 to 12, and the command in bits 0 to 7.
 
 xmp (RC_PROTO_XMP)
-- 
2.43.0


