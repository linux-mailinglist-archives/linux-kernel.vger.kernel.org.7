Return-Path: <linux-kernel+bounces-743182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48144B0FB85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C798188C72F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB75235346;
	Wed, 23 Jul 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrIioJxd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D4153BE9;
	Wed, 23 Jul 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302784; cv=none; b=r/Z78fQizx9PRJ3nhYrtCiAK0GiaMRMGkJfrNXmAx52tpLbgJJb6Xye5F7vxDKAjzmMh1dLgh90U+TEJE3nlywiUh3AH8aEXTZBzNfNLiR9DSPKgiGWrqvasNQO3QtjMSk+kxvkCy+L6Cp4f2NMAo7qnNLqmI8yMj8e2LeWI184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302784; c=relaxed/simple;
	bh=dX81WRL5VzoRW4Y/3EZvEr7JmebK4Hk3RRDO0LKibZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeZPqVkCKwyHjwW/TkcIDr50PegE0SsjdB6DOaZ+BLggn+SN0B+jTtCiYSAMfjQ2rYp3gdkqJb3ewm/TpZS6ARTYSjVZ0wjj6cBB9j1phMJI9k1C6qYdlZrzto5CuHIFqDmSfp7vAYDBKscojRD920WE+CqfG/qQD4n8sV95KGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrIioJxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178F0C4CEE7;
	Wed, 23 Jul 2025 20:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302784;
	bh=dX81WRL5VzoRW4Y/3EZvEr7JmebK4Hk3RRDO0LKibZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrIioJxd9D4cyCchDfASpEK9V9D0kasf5PXWXw6rDeexNSIPuElzo/waq0yCmtBSm
	 Z+SOmZLDgj8CUse48jEseUu0UCoUyQZgX7goVnh9veHTYbcSPjwn1VG4QZO3DDuRJ5
	 3DlW35EU27qzX/882gjRDdQk4IagajLGbtRR6W2uHgwZ131v2k9tNvFjt4QzntiQMk
	 3Vo4pYEviJ9oQE8etmP5J/+TniQQASoFpyIx754APN/coIpgct7MQjTf+6AHzYBB4V
	 CQ7fjoSx6as3R0tO2cBnrDOCZWyEcg/yWcxvYPzYJJLSFqEFpIik87NvzOGrGrgJZ7
	 /9Ve7V1K1ec2A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] Documentation/ABI: Fix typos
Date: Wed, 23 Jul 2025 15:32:42 -0500
Message-ID: <20250723203250.2909894-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723203250.2909894-1-helgaas@kernel.org>
References: <20250723203250.2909894-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../ABI/obsolete/sysfs-driver-hid-roccat-isku       |  2 +-
 .../ABI/obsolete/sysfs-driver-hid-roccat-koneplus   |  4 ++--
 .../ABI/obsolete/sysfs-driver-hid-roccat-savu       |  2 +-
 Documentation/ABI/testing/debugfs-driver-dcc        |  2 +-
 Documentation/ABI/testing/debugfs-hyperv            |  4 ++--
 Documentation/ABI/testing/rtc-cdev                  |  2 +-
 Documentation/ABI/testing/sysfs-ata                 |  4 ++--
 .../testing/sysfs-bus-event_source-devices-hisi_ptt |  4 ++--
 Documentation/ABI/testing/sysfs-bus-iio             |  2 +-
 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer  |  8 ++++----
 Documentation/ABI/testing/sysfs-bus-rapidio         |  2 +-
 Documentation/ABI/testing/sysfs-class-fc            |  2 +-
 Documentation/ABI/testing/sysfs-class-power-rt9467  |  2 +-
 .../ABI/testing/sysfs-driver-input-exc3000          |  4 ++--
 Documentation/ABI/testing/sysfs-driver-ufs          |  2 +-
 Documentation/ABI/testing/sysfs-firmware-acpi       |  6 +++---
 Documentation/ABI/testing/sysfs-memory-page-offline | 13 ++++++-------
 17 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-isku b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-isku
index c601d0f2ac46..686997e9b535 100644
--- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-isku
+++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-isku
@@ -3,7 +3,7 @@ Date:		June 2011
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The integer value of this attribute ranges from 0-4.
 		When read, this attribute returns the number of the actual
-		profile. This value is persistent, so its equivalent to the
+		profile. This value is persistent, so it's equivalent to the
 		profile that's active when the device is powered on next time.
 		When written, this file sets the number of the startup profile
 		and the device activates this profile immediately.
diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
index 545e69f43229..27495d8c0518 100644
--- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
+++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
@@ -3,7 +3,7 @@ Date:		October 2010
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The integer value of this attribute ranges from 0-4.
                 When read, this attribute returns the number of the actual
-                profile. This value is persistent, so its equivalent to the
+                profile. This value is persistent, so it's equivalent to the
                 profile that's active when the mouse is powered on next time.
 		When written, this file sets the number of the startup profile
 		and the mouse activates this profile immediately.
@@ -14,7 +14,7 @@ Date:		October 2010
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
 Description:	The integer value of this attribute ranges from 0-4.
                 When read, this attribute returns the number of the actual
-                profile. This value is persistent, so its equivalent to the
+                profile. This value is persistent, so it's equivalent to the
                 profile that's active when the mouse is powered on next time.
 		When written, this file sets the number of the startup profile
 		and the mouse activates this profile immediately.
diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-savu b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-savu
index 99fda67fce18..3141a6a63aa9 100644
--- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-savu
+++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-savu
@@ -71,7 +71,7 @@ Users:		http://roccat.sourceforge.net
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/savu/roccatsavu<minor>/sensor
 Date:		July 2012
 Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
-Description:	The mouse has a Avago ADNS-3090 sensor.
+Description:	The mouse has an Avago ADNS-3090 sensor.
 		This file allows reading and writing of the mouse sensors registers.
 		The data has to be 4 bytes long.
 Users:		http://roccat.sourceforge.net
diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
index 27ed5919d21b..97fc667e0e95 100644
--- a/Documentation/ABI/testing/debugfs-driver-dcc
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -33,7 +33,7 @@ Description:
 		software triggers. The input addresses type
 		can be one of following dcc instructions: read,
 		write, read-write, and loop type. The lists need to
-		be configured sequentially and not in a overlapping
+		be configured sequentially and not in an overlapping
 		manner; e.g. users can jump to list x only after
 		list y is configured and enabled. The input format for
 		each type is as follows:
diff --git a/Documentation/ABI/testing/debugfs-hyperv b/Documentation/ABI/testing/debugfs-hyperv
index 9185e1b06bba..e9a819c7924f 100644
--- a/Documentation/ABI/testing/debugfs-hyperv
+++ b/Documentation/ABI/testing/debugfs-hyperv
@@ -2,8 +2,8 @@ What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
 Date:           October 2019
 KernelVersion:  5.5
 Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
-Description:    Fuzz testing status of a vmbus device, whether its in an ON
-                state or a OFF state
+Description:    Fuzz testing status of a vmbus device, whether it's in an ON
+                state or an OFF state
 Users:          Debugging tools
 
 What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_interrupt_delay
diff --git a/Documentation/ABI/testing/rtc-cdev b/Documentation/ABI/testing/rtc-cdev
index 25910c3c3d7e..cec099a27c6d 100644
--- a/Documentation/ABI/testing/rtc-cdev
+++ b/Documentation/ABI/testing/rtc-cdev
@@ -14,7 +14,7 @@ Description:
 		  for RTCs that support alarms
 
 		* RTC_ALM_READ, RTC_ALM_SET: Read or set the alarm time for
-		  RTCs that support alarms. Can be set upto 24 hours in the
+		  RTCs that support alarms. Can be set up to 24 hours in the
 		  future. Requires a separate RTC_AIE_ON call to enable the
 		  alarm interrupt. (Prefer to use RTC_WKALM_*)
 
diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/testing/sysfs-ata
index 3daecac48964..090a35c052fa 100644
--- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -37,8 +37,8 @@ Description:
 Files under /sys/class/ata_link
 -------------------------------
 
-Behind each port, there is a ata_link. If there is a SATA PM in the topology, 15
-ata_link objects are created.
+Behind each port, there is an ata_link. If there is a SATA PM in the topology,
+15 ata_link objects are created.
 
 If a link is behind a port, the directory name is linkX, where X is ata_port_id
 of the port. If a link is behind a PM, its name is linkX.Y where X is
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
index 1119766564d7..6dccdf8f5372 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
@@ -76,7 +76,7 @@ Date:		May 2023
 KernelVersion:	6.5
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
 Description:	(Read) Indicates if this kind of filter can be selected at the same
-		time as others filters, or must be used on it's own. 1 indicates
+		time as others filters, or must be used on its own. 1 indicates
 		the former case and 0 indicates the latter.
 
 What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters/<bdf>
@@ -102,7 +102,7 @@ Date:		May 2023
 KernelVersion:	6.5
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
 Description:	(Read) Indicates if this kind of filter can be selected at the same
-		time as others filters, or must be used on it's own. 1 indicates
+		time as others filters, or must be used on its own. 1 indicates
 		the former case and 0 indicates the latter.
 
 What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters/<bdf>
diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 190bfcc1e836..60e14211c2ce 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -206,7 +206,7 @@ Description:
 		reading by userspace (unlike _offset) and unlike calibbias
 		it does not affect the differential value measured because
 		the effect of _zeropoint cancels out across the two inputs
-		that make up the differential pair. It's purpose is to bring
+		that make up the differential pair. Its purpose is to bring
 		the individual signals, before the differential is measured,
 		within the measurement range of the device. The naming is
 		chosen because if the separate inputs that make the
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
index d526e6571001..06313befdfaa 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
@@ -2,15 +2,15 @@ What:		/sys/bus/iio/devices/iio:deviceX/buffer/length_align_bytes
 KernelVersion:	5.4
 Contact:	linux-iio@vger.kernel.org
 Description:
-		DMA buffers tend to have a alignment requirement for the
+		DMA buffers tend to have an alignment requirement for the
 		buffers. If this alignment requirement is not met samples might
 		be dropped from the buffer.
 
-		This property reports the alignment requirements in bytes.
-		This means that the buffer size in bytes needs to be a integer
+		This property reports the alignment requirement in bytes.
+		This means that the buffer size in bytes needs to be an integer
 		multiple of the number reported by this file.
 
-		The alignment requirements in number of sample sets will depend
+		The alignment requirement in number of sample sets will depend
 		on the enabled channels and the bytes per channel. This means
 		that the alignment requirement in samples sets might change
 		depending on which and how many channels are enabled. Whereas
diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio b/Documentation/ABI/testing/sysfs-bus-rapidio
index f8b6728dac10..9e8fbff99b75 100644
--- a/Documentation/ABI/testing/sysfs-bus-rapidio
+++ b/Documentation/ABI/testing/sysfs-bus-rapidio
@@ -95,7 +95,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 		Alexandre Bounine <alexandre.bounine@idt.com>
 Description:
 		(RO) returns name of previous device (switch) on the path to the
-		device that that owns this attribute
+		device that owns this attribute
 
 What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/modalias
 Date:		Jul, 2013
diff --git a/Documentation/ABI/testing/sysfs-class-fc b/Documentation/ABI/testing/sysfs-class-fc
index 3057a6d3b8cf..786296aeca32 100644
--- a/Documentation/ABI/testing/sysfs-class-fc
+++ b/Documentation/ABI/testing/sysfs-class-fc
@@ -15,7 +15,7 @@ Description:
 
 		The interface expects a string "<cgroupid>:<appid>" where:
 		<cgroupid> is inode of the cgroup in hexadecimal
-		<appid> is user provided string upto 128 characters
+		<appid> is user provided string up to 128 characters
 		in length.
 
 		If an appid_store is done for a cgroup id that already
diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index 619b7c45d145..038335ecc3c6 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -10,7 +10,7 @@ Description:
 		device datasheet for details. It's commonly used when the
 		product enter shipping stage. After entering shipping mode,
 		only 'VBUS' or 'Power key" pressed can make it leave this mode.
-		'Disable' also can help to leave it, but it's more like to
+		'Disable' also can help to leave it, but it's more likely to
 		abort the action before the device really enter shipping mode.
 
 		Access: Read, Write
diff --git a/Documentation/ABI/testing/sysfs-driver-input-exc3000 b/Documentation/ABI/testing/sysfs-driver-input-exc3000
index 704434b277b0..ea39c383854b 100644
--- a/Documentation/ABI/testing/sysfs-driver-input-exc3000
+++ b/Documentation/ABI/testing/sysfs-driver-input-exc3000
@@ -1,7 +1,7 @@
 What:		/sys/bus/i2c/devices/xxx/fw_version
 Date:		Aug 2020
 Contact:	linux-input@vger.kernel.org
-Description:    Reports the firmware version provided by the touchscreen, for example "00_T6" on a EXC80H60
+Description:    Reports the firmware version provided by the touchscreen, for example "00_T6" on an EXC80H60
 
 		Access: Read
 
@@ -10,7 +10,7 @@ Description:    Reports the firmware version provided by the touchscreen, for ex
 What:		/sys/bus/i2c/devices/xxx/model
 Date:		Aug 2020
 Contact:	linux-input@vger.kernel.org
-Description:    Reports the model identification provided by the touchscreen, for example "Orion_1320" on a EXC80H60
+Description:    Reports the model identification provided by the touchscreen, for example "Orion_1320" on an EXC80H60
 
 		Access: Read
 
diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index d4140dc6c5ba..9ff4a20f9dd4 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -592,7 +592,7 @@ What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/oem_id
 What:		/sys/bus/platform/devices/*.ufs/string_descriptors/oem_id
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
-Description:	This file contains a OEM ID string. The full information
+Description:	This file contains an OEM ID string. The full information
 		about the descriptor could be found at UFS specifications 2.1.
 
 		The file is read only.
diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index f4de60c4134d..72e7c9161ce7 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -108,15 +108,15 @@ Description:
 		number of a "General Purpose Events" (GPE).
 
 		A GPE vectors to a specified handler in AML, which
-		can do a anything the BIOS writer wants from
+		can do anything the BIOS writer wants from
 		OS context.  GPE 0x12, for example, would vector
 		to a level or edge handler called _L12 or _E12.
 		The handler may do its business and return.
-		Or the handler may send send a Notify event
+		Or the handler may send a Notify event
 		to a Linux device driver registered on an ACPI device,
 		such as a battery, or a processor.
 
-		To figure out where all the SCI's are coming from,
+		To figure out where all the SCIs are coming from,
 		/sys/firmware/acpi/interrupts contains a file listing
 		every possible source, and the count of how many
 		times it has triggered::
diff --git a/Documentation/ABI/testing/sysfs-memory-page-offline b/Documentation/ABI/testing/sysfs-memory-page-offline
index 00f4e35f916f..256fe7a6f106 100644
--- a/Documentation/ABI/testing/sysfs-memory-page-offline
+++ b/Documentation/ABI/testing/sysfs-memory-page-offline
@@ -7,7 +7,7 @@ Description:
 		written into this file. Input is a hex number specifying the
 		physical address of the page. The kernel will then attempt
 		to soft-offline it, by moving the contents elsewhere or
-		dropping it if possible. The kernel will then be placed
+		dropping it if possible. The page will then be placed
 		on the bad page list and never be reused.
 
 		The offlining is done in kernel specific granularity.
@@ -17,7 +17,7 @@ Description:
 		The page must be still accessible, not poisoned. The
 		kernel will never kill anything for this, but rather
 		fail the offline.  Return value is the size of the
-		number, or a error when the offlining failed.  Reading
+		number, or an error when the offlining failed.  Reading
 		the file is not allowed.
 
 What:		/sys/devices/system/memory/hard_offline_page
@@ -28,17 +28,16 @@ Description:
 		Hard-offline the memory page containing the physical
 		address written into this file. Input is a hex number
 		specifying the physical address of the page. The
-		kernel will then attempt to hard-offline the page, by
+		kernel will then attempt to hard-offline the page by
 		trying to drop the page or killing any owner or
 		triggering IO errors if needed.  Note this may kill
 		any processes owning the page. The kernel will avoid
-		to access this page assuming it's poisoned by the
+		accessing this page, assuming it's poisoned by the
 		hardware.
 
 		The offlining is done in kernel specific granularity.
 		Normally it's the base page size of the kernel, but
 		this might change.
 
-		Return value is the size of the number, or a error when
-		the offlining failed.
-		Reading the file is not allowed.
+		Return value is the size of the number, or an error when
+		the offlining failed.  Reading the file is not allowed.
-- 
2.43.0


