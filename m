Return-Path: <linux-kernel+bounces-743181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0868B0FB86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497E318885C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6423507E;
	Wed, 23 Jul 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gybmTvJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F29231836;
	Wed, 23 Jul 2025 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302783; cv=none; b=e5ANlOdQiMffbZrjV2rfuwJ15wh/5MWNFFeAzbBtv+WSb8d7OUgJ9bLYxmrmxpOJFkg9sCtO/y2rQmPy1Od/x9oZqsVeoJEddQkcwsBxZ7JYorTm/FtpZC37c3bSiUibxvjIiLvlEcJn7+44+qkQ99LKAreVoZeOXTcPL2KALmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302783; c=relaxed/simple;
	bh=NBGGqw+PT+e4QfA8oxMjS1Bmuo53FyuUD2GnMG4I1ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fhq8eVEkuKE45zbOAspENqcphFd+UOXI+zzaVgMptkxoNgAv/5SXAwcqrVMS62Zh2Jng98/3ddngfGHbV8clLZ1R+x+SexkA97eGckrx5E93t5DDL4ooOUfje7DJBk9IqK31XsOPx3LfJAdLbUxNj5F/PdfWaC8LiScu5HLYgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gybmTvJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38BC4CEE7;
	Wed, 23 Jul 2025 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302782;
	bh=NBGGqw+PT+e4QfA8oxMjS1Bmuo53FyuUD2GnMG4I1ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gybmTvJcVdVkNyAcH31uqfgemDYow19b9iILIB41iJRPpfj34s5pTirvJ+EW254uG
	 adQ82ySzob+dgM6biztQHGRJCq83U30kvZJqm242ldAD9FckF0PWcmNZ5Qe+Ocd/4z
	 J3RtkWAMUYszyr1QdDfCZSI6kJ15JXjwmZnavc5DA3zw/AsOHPQwRBqT1U6ud2Hv5y
	 PjpCW4TEk/wP3o+2LlwPrtyn/SdilirSa6RyGvWtR38Y+0r4yPzm//ZRzWhuKjU2Lz
	 Ttx1B9kSO8DJr6xC/gG+imSVCmqeyzVIDy13ApSDRt7f8vIJeAYcyb3BA4OXt0R28W
	 RfjVEbLh/iETQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] Documentation: Fix typos
Date: Wed, 23 Jul 2025 15:32:41 -0500
Message-ID: <20250723203250.2909894-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723203250.2909894-1-helgaas@kernel.org>
References: <20250723203250.2909894-1-helgaas@kernel.org>
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
---
 .../PCI/endpoint/pci-endpoint-cfs.rst         |  4 +--
 Documentation/PCI/endpoint/pci-endpoint.rst   |  6 ++--
 Documentation/RCU/lockdep.rst                 |  2 +-
 Documentation/RCU/stallwarn.rst               |  2 +-
 Documentation/accel/qaic/aic100.rst           |  4 +--
 Documentation/accounting/taskstats.rst        |  2 +-
 Documentation/admin-guide/LSM/SafeSetID.rst   |  2 +-
 Documentation/admin-guide/RAS/main.rst        |  2 +-
 Documentation/admin-guide/blockdev/paride.rst |  2 +-
 .../admin-guide/device-mapper/vdo-design.rst  |  2 +-
 Documentation/admin-guide/hw-vuln/mds.rst     |  2 +-
 Documentation/admin-guide/kdump/kdump.rst     |  2 +-
 .../admin-guide/kernel-parameters.txt         | 10 +++---
 Documentation/admin-guide/laptops/sonypi.rst  |  2 +-
 Documentation/admin-guide/media/imx.rst       |  2 +-
 Documentation/admin-guide/media/si4713.rst    |  6 ++--
 Documentation/admin-guide/mm/damon/usage.rst  |  2 +-
 Documentation/admin-guide/perf/hisi-pmu.rst   |  4 +--
 .../quickly-build-trimmed-linux.rst           |  4 +--
 .../admin-guide/reporting-issues.rst          |  4 +--
 .../verify-bugs-and-bisect-regressions.rst    |  2 +-
 Documentation/arch/arm/keystone/knav-qmss.rst |  2 +-
 Documentation/arch/x86/cpuinfo.rst            |  2 +-
 Documentation/core-api/irq/irq-affinity.rst   |  6 ++--
 Documentation/core-api/irq/irq-domain.rst     | 36 +++++++++----------
 .../bindings/sound/davinci-evm-audio.txt      |  2 +-
 Documentation/devicetree/usage-model.rst      |  2 +-
 Documentation/driver-api/vfio.rst             |  2 +-
 Documentation/filesystems/erofs.rst           |  2 +-
 Documentation/filesystems/gfs2-glocks.rst     |  2 +-
 Documentation/filesystems/hpfs.rst            |  2 +-
 Documentation/filesystems/resctrl.rst         |  2 +-
 .../xfs/xfs-online-fsck-design.rst            |  4 +--
 .../firmware-guide/acpi/gpio-properties.rst   |  4 +--
 Documentation/hwmon/f71805f.rst               |  2 +-
 Documentation/misc-devices/apds990x.rst       |  2 +-
 Documentation/mm/hwpoison.rst                 |  2 +-
 Documentation/networking/can.rst              |  2 +-
 .../ethernet/ti/am65_nuss_cpsw_switchdev.rst  |  2 +-
 .../ethernet/ti/cpsw_switchdev.rst            |  2 +-
 Documentation/networking/rds.rst              |  2 +-
 Documentation/power/pci.rst                   |  4 +--
 .../power/suspend-and-cpuhotplug.rst          |  2 +-
 Documentation/sound/cards/emu-mixer.rst       |  2 +-
 Documentation/trace/fprobe.rst                |  2 +-
 Documentation/trace/ftrace-uses.rst           |  2 +-
 Documentation/trace/ftrace.rst                | 14 ++++----
 Documentation/trace/histogram.rst             |  2 +-
 .../translations/zh_TW/process/5.Posting.rst  |  2 +-
 .../userspace-api/media/rc/rc-protos.rst      | 20 +++++------
 50 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index fb73345cfb8a..e69c2872ce3b 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -86,7 +86,7 @@ The <EPF Device> directory can have a list of symbolic links
 be created by the user to represent the virtual functions that are bound to
 the physical function. In the above directory structure <EPF Device 11> is a
 physical function and <EPF Device 31> is a virtual function. An EPF device once
-it's linked to another EPF device, cannot be linked to a EPC device.
+it's linked to another EPF device, cannot be linked to an EPC device.
 
 EPC Device
 ==========
@@ -108,7 +108,7 @@ entries corresponding to EPC device will be created by the EPC core.
 The <EPC Device> directory will have a list of symbolic links to
 <EPF Device>. These symbolic links should be created by the user to
 represent the functions present in the endpoint device. Only <EPF Device>
-that represents a physical function can be linked to a EPC device.
+that represents a physical function can be linked to an EPC device.
 
 The <EPC Device> directory will also have a *start* field. Once
 "1" is written to this field, the endpoint device will be ready to
diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 599763aa01ca..0741c8cbd74e 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -197,8 +197,8 @@ by the PCI endpoint function driver.
 * pci_epf_register_driver()
 
    The PCI Endpoint Function driver should implement the following ops:
-	 * bind: ops to perform when a EPC device has been bound to EPF device
-	 * unbind: ops to perform when a binding has been lost between a EPC
+	 * bind: ops to perform when an EPC device has been bound to EPF device
+	 * unbind: ops to perform when a binding has been lost between an EPC
 	   device and EPF device
 	 * add_cfs: optional ops to create function specific configfs
 	   attributes
@@ -251,7 +251,7 @@ pci-ep-cfs.c can be used as reference for using these APIs.
 * pci_epf_bind()
 
    pci_epf_bind() should be invoked when the EPF device has been bound to
-   a EPC device.
+   an EPC device.
 
 * pci_epf_unbind()
 
diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
index 69e73a39bd11..741b157bbacb 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -106,7 +106,7 @@ or the RCU-protected data that it points to can change concurrently.
 Like rcu_dereference(), when lockdep is enabled, RCU list and hlist
 traversal primitives check for being called from within an RCU read-side
 critical section.  However, a lockdep expression can be passed to them
-as a additional optional argument.  With this lockdep expression, these
+as an additional optional argument.  With this lockdep expression, these
 traversal primitives will complain only if the lockdep expression is
 false and they are called from outside any RCU read-side critical section.
 
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index d1ccd6039a8c..d7c8eff63317 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -119,7 +119,7 @@ warnings:
 	uncommon in large datacenter.  In one memorable case some decades
 	back, a CPU failed in a running system, becoming unresponsive,
 	but not causing an immediate crash.  This resulted in a series
-	of RCU CPU stall warnings, eventually leading the realization
+	of RCU CPU stall warnings, eventually leading to the realization
 	that the CPU had failed.
 
 The RCU, RCU-sched, RCU-tasks, and RCU-tasks-trace implementations have
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
diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
index 0ec34863c674..6d439c987563 100644
--- a/Documentation/admin-guide/LSM/SafeSetID.rst
+++ b/Documentation/admin-guide/LSM/SafeSetID.rst
@@ -41,7 +41,7 @@ namespace). The higher level goal is to allow for uid-based sandboxing of system
 services without having to give out CAP_SETUID all over the place just so that
 non-root programs can drop to even-lesser-privileged uids. This is especially
 relevant when one non-root daemon on the system should be allowed to spawn other
-processes as different uids, but its undesirable to give the daemon a
+processes as different uids, but it's undesirable to give the daemon a
 basically-root-equivalent CAP_SETUID.
 
 
diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
index 7ac1d4ccc509..447bfde509fb 100644
--- a/Documentation/admin-guide/RAS/main.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -253,7 +253,7 @@ interface.
 Some architectures have ECC detectors for L1, L2 and L3 caches,
 along with DMA engines, fabric switches, main data path switches,
 interconnections, and various other hardware data paths. If the hardware
-reports it, then a edac_device device probably can be constructed to
+reports it, then an edac_device device probably can be constructed to
 harvest and present that to userspace.
 
 
diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
index e85ad37cc0e5..b2f627d4c2f8 100644
--- a/Documentation/admin-guide/blockdev/paride.rst
+++ b/Documentation/admin-guide/blockdev/paride.rst
@@ -118,7 +118,7 @@ and high-level drivers that you would use:
 	================	============	========
 
 All parports and all protocol drivers are probed automatically unless probe=0
-parameter is used. So just "modprobe epat" is enough for a Imation SuperDisk
+parameter is used. So just "modprobe epat" is enough for an Imation SuperDisk
 drive to work.
 
 Manual device creation::
diff --git a/Documentation/admin-guide/device-mapper/vdo-design.rst b/Documentation/admin-guide/device-mapper/vdo-design.rst
index 3cd59decbec0..faa0ecd4a5ae 100644
--- a/Documentation/admin-guide/device-mapper/vdo-design.rst
+++ b/Documentation/admin-guide/device-mapper/vdo-design.rst
@@ -600,7 +600,7 @@ lock and return itself to the pool.
 All storage within vdo is managed as 4KB blocks, but it can accept writes
 as small as 512 bytes. Processing a write that is smaller than 4K requires
 a read-modify-write operation that reads the relevant 4K block, copies the
-new data over the approriate sectors of the block, and then launches a
+new data over the appropriate sectors of the block, and then launches a
 write operation for the modified data block. The read and write stages of
 this operation are nearly identical to the normal read and write
 operations, and a single data_vio is used throughout this operation.
diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
index 48c7b0b72aed..754679db0ce8 100644
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -214,7 +214,7 @@ XEON PHI specific considerations
   command line with the 'ring3mwait=disable' command line option.
 
   XEON PHI is not affected by the other MDS variants and MSBDS is mitigated
-  before the CPU enters a idle state. As XEON PHI is not affected by L1TF
+  before the CPU enters an idle state. As XEON PHI is not affected by L1TF
   either disabling SMT is not required for full protection.
 
 .. _mds_smt_control:
diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 20fabdf6567e..3de0e6108c53 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -450,7 +450,7 @@ Notes on loading the dump-capture kernel:
   performance degradation. To enable multi-cpu support, you should bring up an
   SMP dump-capture kernel and specify maxcpus/nr_cpus options while loading it.
 
-* For s390x there are two kdump modes: If a ELF header is specified with
+* For s390x there are two kdump modes: If an ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
   is done on all other architectures. If no elfcorehdr= kernel parameter is
   specified, the s390x kdump kernel dynamically creates the header. The
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..09f319f8e8ce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3637,7 +3637,7 @@
 			looking for corruption.  Enabling this will
 			both detect corruption and prevent the kernel
 			from using the memory being corrupted.
-			However, its intended as a diagnostic tool; if
+			However, it's intended as a diagnostic tool; if
 			repeatable BIOS-originated corruption always
 			affects the same memory, you can use memmap=
 			to prevent the kernel from using that memory.
@@ -7270,7 +7270,7 @@
 				(converted into nanoseconds). Fast, but
 				depending on the architecture, may not be
 				in sync between CPUs.
-			global - Event time stamps are synchronize across
+			global - Event time stamps are synchronized across
 				CPUs. May be slower than the local clock,
 				but better for some race conditions.
 			counter - Simple counting of events (1, 2, ..)
@@ -7390,11 +7390,11 @@
 			section.
 
 	trace_trigger=[trigger-list]
-			[FTRACE] Add a event trigger on specific events.
+			[FTRACE] Add an event trigger on specific events.
 			Set a trigger on top of a specific event, with an optional
 			filter.
 
-			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
 			Where more than one trigger may be specified that are comma deliminated.
 
 			For example:
@@ -7403,7 +7403,7 @@
 
 			The above will enable the "stacktrace" trigger on the "sched_switch"
 			event but only trigger it if the "prev_state" of the "sched_switch"
-			event is "2" (TASK_UNINTERUPTIBLE).
+			event is "2" (TASK_UNINTERRUPTIBLE).
 
 			See also "Event triggers" in Documentation/trace/events.rst
 
diff --git a/Documentation/admin-guide/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
index 190da1234314..7541f56e0007 100644
--- a/Documentation/admin-guide/laptops/sonypi.rst
+++ b/Documentation/admin-guide/laptops/sonypi.rst
@@ -25,7 +25,7 @@ generate, like:
 	  (when available)
 
 Those events (see linux/sonypi.h) can be polled using the character device node
-/dev/sonypi (major 10, minor auto allocated or specified as a option).
+/dev/sonypi (major 10, minor auto allocated or specified as an option).
 A simple daemon which translates the jogdial movements into mouse wheel events
 can be downloaded at: <http://popies.net/sonypi/>
 
diff --git a/Documentation/admin-guide/media/imx.rst b/Documentation/admin-guide/media/imx.rst
index b8fa70f854fd..bb68100d8acb 100644
--- a/Documentation/admin-guide/media/imx.rst
+++ b/Documentation/admin-guide/media/imx.rst
@@ -96,7 +96,7 @@ Some of the features of this driver include:
   motion compensation modes: low, medium, and high motion. Pipelines are
   defined that allow sending frames to the VDIC subdev directly from the
   CSI. There is also support in the future for sending frames to the
-  VDIC from memory buffers via a output/mem2mem devices.
+  VDIC from memory buffers via output/mem2mem devices.
 
 - Includes a Frame Interval Monitor (FIM) that can correct vertical sync
   problems with the ADV718x video decoders.
diff --git a/Documentation/admin-guide/media/si4713.rst b/Documentation/admin-guide/media/si4713.rst
index be8e6b49b7b4..01131c267287 100644
--- a/Documentation/admin-guide/media/si4713.rst
+++ b/Documentation/admin-guide/media/si4713.rst
@@ -13,7 +13,7 @@ Contact: Eduardo Valentin <eduardo.valentin@nokia.com>
 Information about the Device
 ----------------------------
 
-This chip is a Silicon Labs product. It is a I2C device, currently on 0x63 address.
+This chip is a Silicon Labs product. It is an I2C device, currently on 0x63 address.
 Basically, it has transmission and signal noise level measurement features.
 
 The Si4713 integrates transmit functions for FM broadcast stereo transmission.
@@ -28,7 +28,7 @@ Users must comply with local regulations on radio frequency (RF) transmission.
 Device driver description
 -------------------------
 
-There are two modules to handle this device. One is a I2C device driver
+There are two modules to handle this device. One is an I2C device driver
 and the other is a platform driver.
 
 The I2C device driver exports a v4l2-subdev interface to the kernel.
@@ -113,7 +113,7 @@ Here is a summary of them:
 - acomp_attack_time - Sets the attack time for audio dynamic range control.
 - acomp_release_time - Sets the release time for audio dynamic range control.
 
-* Limiter setups audio deviation limiter feature. Once a over deviation occurs,
+* Limiter setups audio deviation limiter feature. Once an over deviation occurs,
   it is possible to adjust the front-end gain of the audio input and always
   prevent over deviation.
 
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d960aba72b82..919f84d7724e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -348,7 +348,7 @@ The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
 DAMON-based operation scheme.
 
 Under ``quotas`` directory, four files (``ms``, ``bytes``,
-``reset_interval_ms``, ``effective_bytes``) and two directores (``weights`` and
+``reset_interval_ms``, ``effective_bytes``) and two directories (``weights`` and
 ``goals``) exist.
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index 48992a0b8e94..721eb1623ca7 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -109,8 +109,8 @@ uring channel. It is 2 bits. Some important codes are as follows:
 - 2'b11: count the events which sent to the uring_ext (MATA) channel;
 - 2'b01: is the same as 2'b11;
 - 2'b10: count the events which sent to the uring (non-MATA) channel;
-- 2'b00: default value, count the events which sent to the both uring and
-  uring_ext channel;
+- 2'b00: default value, count the events which sent to both uring and
+  uring_ext channels;
 
 Users could configure IDs to count data come from specific CCL/ICL, by setting
 srcid_cmd & srcid_msk, and data desitined for specific CCL/ICL by setting
diff --git a/Documentation/admin-guide/quickly-build-trimmed-linux.rst b/Documentation/admin-guide/quickly-build-trimmed-linux.rst
index 4a5ffb0996a3..cb4b78468a93 100644
--- a/Documentation/admin-guide/quickly-build-trimmed-linux.rst
+++ b/Documentation/admin-guide/quickly-build-trimmed-linux.rst
@@ -273,7 +273,7 @@ again.
    does nothing at all; in that case you have to manually install your kernel,
    as outlined in the reference section.
 
-   If you are running a immutable Linux distribution, check its documentation
+   If you are running an immutable Linux distribution, check its documentation
    and the web to find out how to install your own kernel there.
 
    [:ref:`details<install>`]
@@ -884,7 +884,7 @@ When a build error occurs, it might be caused by some aspect of your machine's
 setup that often can be fixed quickly; other times though the problem lies in
 the code and can only be fixed by a developer. A close examination of the
 failure messages coupled with some research on the internet will often tell you
-which of the two it is. To perform such a investigation, restart the build
+which of the two it is. To perform such an investigation, restart the build
 process like this::
 
     make V=1
diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 9a847506f6ec..a68e6d909274 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -611,7 +611,7 @@ better place.
 
 How to read the MAINTAINERS file
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-To illustrate how to use the :ref:`MAINTAINERS <maintainers>` file, lets assume
+To illustrate how to use the :ref:`MAINTAINERS <maintainers>` file, let's assume
 the WiFi in your Laptop suddenly misbehaves after updating the kernel. In that
 case it's likely an issue in the WiFi driver. Obviously it could also be some
 code it builds upon, but unless you suspect something like that stick to the
@@ -1543,7 +1543,7 @@ as well, because that will speed things up.
 
 And note, it helps developers a great deal if you can specify the exact version
 that introduced the problem. Hence if possible within a reasonable time frame,
-try to find that version using vanilla kernels. Lets assume something broke when
+try to find that version using vanilla kernels. Let's assume something broke when
 your distributor released a update from Linux kernel 5.10.5 to 5.10.8. Then as
 instructed above go and check the latest kernel from that version line, say
 5.10.9. If it shows the problem, try a vanilla 5.10.5 to ensure that no patches
diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index d8946b084b1e..d83601f2a459 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -1757,7 +1757,7 @@ or all of these tasks:
   to your bootloader's configuration.
 
 You have to take care of some or all of the tasks yourself, if your
-distribution lacks a installkernel script or does only handle part of them.
+distribution lacks an installkernel script or does only handle part of them.
 Consult the distribution's documentation for details. If in doubt, install the
 kernel manually::
 
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
diff --git a/Documentation/core-api/irq/irq-affinity.rst b/Documentation/core-api/irq/irq-affinity.rst
index 29da5000836a..9cb460cf60b6 100644
--- a/Documentation/core-api/irq/irq-affinity.rst
+++ b/Documentation/core-api/irq/irq-affinity.rst
@@ -9,9 +9,9 @@ ChangeLog:
 
 /proc/irq/IRQ#/smp_affinity and /proc/irq/IRQ#/smp_affinity_list specify
 which target CPUs are permitted for a given IRQ source.  It's a bitmask
-(smp_affinity) or cpu list (smp_affinity_list) of allowed CPUs.  It's not
+(smp_affinity) or CPU list (smp_affinity_list) of allowed CPUs.  It's not
 allowed to turn off all CPUs, and if an IRQ controller does not support
-IRQ affinity then the value will not change from the default of all cpus.
+IRQ affinity then the value will not change from the default of all CPUs.
 
 /proc/irq/default_smp_affinity specifies default affinity mask that applies
 to all non-active IRQs. Once IRQ is allocated/activated its affinity bitmask
@@ -60,7 +60,7 @@ Now lets restrict that IRQ to CPU(4-7).
 This time around IRQ44 was delivered only to the last four processors.
 i.e counters for the CPU0-3 did not change.
 
-Here is an example of limiting that same irq (44) to cpus 1024 to 1031::
+Here is an example of limiting that same IRQ (44) to CPUs 1024 to 1031::
 
 	[root@moon 44]# echo 1024-1031 > smp_affinity_list
 	[root@moon 44]# cat smp_affinity_list
diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index a01c6ead1bc0..f259042b12f9 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -18,8 +18,8 @@ handlers as irqchips. I.e. in effect cascading interrupt controllers.
 So in the past, IRQ numbers could be chosen so that they match the
 hardware IRQ line into the root interrupt controller (i.e. the
 component actually firing the interrupt line to the CPU). Nowadays,
-this number is just a number and the number loose all kind of
-correspondence to hardware interrupt numbers.
+this number is just a number and the number has no
+relationship to hardware interrupt numbers.
 
 For this reason, we need a mechanism to separate controller-local
 interrupt numbers, called hardware IRQs, from Linux IRQ numbers.
@@ -77,14 +77,14 @@ Once a mapping has been established, it can be retrieved or used via a
 variety of methods:
 
 - irq_resolve_mapping() returns a pointer to the irq_desc structure
-  for a given domain and hwirq number, and NULL if there was no
+  for a given domain and hwirq number, or NULL if there was no
   mapping.
 - irq_find_mapping() returns a Linux IRQ number for a given domain and
-  hwirq number, and 0 if there was no mapping
+  hwirq number, or 0 if there was no mapping
 - generic_handle_domain_irq() handles an interrupt described by a
   domain and a hwirq number
 
-Note that irq domain lookups must happen in contexts that are
+Note that irq_domain lookups must happen in contexts that are
 compatible with a RCU read-side critical section.
 
 The irq_create_mapping() function must be called *at least once*
@@ -100,7 +100,7 @@ Types of irq_domain Mappings
 ============================
 
 There are several mechanisms available for reverse mapping from hwirq
-to Linux irq, and each mechanism uses a different allocation function.
+to Linux IRQ, and each mechanism uses a different allocation function.
 Which reverse map type should be used depends on the use case.  Each
 of the reverse map types are described below:
 
@@ -111,13 +111,13 @@ Linear
 
 	irq_domain_create_linear()
 
-The linear reverse map maintains a fixed size table indexed by the
+The linear reverse map maintains a fixed-size table indexed by the
 hwirq number.  When a hwirq is mapped, an irq_desc is allocated for
 the hwirq, and the IRQ number is stored in the table.
 
 The Linear map is a good choice when the maximum number of hwirqs is
 fixed and a relatively small number (~ < 256).  The advantages of this
-map are fixed time lookup for IRQ numbers, and irq_descs are only
+map are fixed-time lookup for IRQ numbers, and irq_descs are only
 allocated for in-use IRQs.  The disadvantage is that the table must be
 as large as the largest possible hwirq number.
 
@@ -134,7 +134,7 @@ The irq_domain maintains a radix tree map from hwirq numbers to Linux
 IRQs.  When an hwirq is mapped, an irq_desc is allocated and the
 hwirq is used as the lookup key for the radix tree.
 
-The tree map is a good choice if the hwirq number can be very large
+The Tree map is a good choice if the hwirq number can be very large
 since it doesn't need to allocate a table as large as the largest
 hwirq number.  The disadvantage is that hwirq to IRQ number lookup is
 dependent on how many entries are in the table.
@@ -169,10 +169,10 @@ Legacy
 
 The Legacy mapping is a special case for drivers that already have a
 range of irq_descs allocated for the hwirqs.  It is used when the
-driver cannot be immediately converted to use the linear mapping.  For
+driver cannot be immediately converted to use the Linear mapping.  For
 example, many embedded system board support files use a set of #defines
 for IRQ numbers that are passed to struct device registrations.  In that
-case the Linux IRQ numbers cannot be dynamically assigned and the legacy
+case the Linux IRQ numbers cannot be dynamically assigned and the Legacy
 mapping should be used.
 
 As the name implies, the \*_legacy() functions are deprecated and only
@@ -180,15 +180,15 @@ exist to ease the support of ancient platforms. No new users should be
 added. Same goes for the \*_simple() functions when their use results
 in the legacy behaviour.
 
-The legacy map assumes a contiguous range of IRQ numbers has already
+The Legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be
 calculated by adding a fixed offset to the hwirq number, and
 visa-versa.  The disadvantage is that it requires the interrupt
 controller to manage IRQ allocations and it requires an irq_desc to be
 allocated for every hwirq, even if it is unused.
 
-The legacy map should only be used if fixed IRQ mappings must be
-supported.  For example, ISA controllers would use the legacy map for
+The Legacy map should only be used if fixed IRQ mappings must be
+supported.  For example, ISA controllers would use the Legacy map for
 mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
 numbers.
 
@@ -197,7 +197,7 @@ which will use a legacy domain only if an IRQ range is supplied by the
 system and will otherwise use a linear domain mapping. The semantics of
 this call are such that if an IRQ range is specified then descriptors
 will be allocated on-the-fly for it, and if no range is specified it
-will fall through to irq_domain_create_linear() which means *no* irq
+will fall through to irq_domain_create_linear() which means *no* IRQ
 descriptors will be allocated.
 
 A typical use case for simple domains is where an irqchip provider
@@ -214,7 +214,7 @@ Hierarchy IRQ Domain
 
 On some architectures, there may be multiple interrupt controllers
 involved in delivering an interrupt from the device to the target CPU.
-Let's look at a typical interrupt delivering path on x86 platforms::
+Let's look at a typical interrupt delivery path on x86 platforms::
 
   Device --> IOAPIC -> Interrupt remapping Controller -> Local APIC -> CPU
 
@@ -227,8 +227,8 @@ There are three interrupt controllers involved:
 To support such a hardware topology and make software architecture match
 hardware architecture, an irq_domain data structure is built for each
 interrupt controller and those irq_domains are organized into hierarchy.
-When building irq_domain hierarchy, the irq_domain near to the device is
-child and the irq_domain near to CPU is parent. So a hierarchy structure
+When building irq_domain hierarchy, the irq_domain nearest the device is
+child and the irq_domain nearest the CPU is parent. So a hierarchy structure
 as below will be built for the example above::
 
 	CPU Vector irq_domain (root irq_domain to manage CPU vectors)
diff --git a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
index 963e100514c2..fdec6f740995 100644
--- a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
@@ -15,7 +15,7 @@ Optional properties:
 - clocks : Reference to the master clock
 - clock-names : The clock should be named "mclk"
 - Either codec-clock-rate or the codec-clock reference has to be defined. If
-  the both are defined the driver attempts to set referenced clock to the
+  both are defined the driver attempts to set referenced clock to the
   defined rate and takes the rate from the clock reference.
 
   Board connectors:
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
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 7ddb235aee9d..08194f194b94 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -116,7 +116,7 @@ cache_strategy=%s      Select a strategy for cached decompression from now on:
                                    cluster for further reading. It still does
                                    in-place I/O decompression for the rest
                                    compressed physical clusters;
-                       readaround  Cache the both ends of incomplete compressed
+                       readaround  Cache both ends of incomplete compressed
                                    physical clusters for further reading.
                                    It still does in-place I/O decompression
                                    for the rest compressed physical clusters.
diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2-glocks.rst
index adc0d4c4d979..ce5ff08cbd59 100644
--- a/Documentation/filesystems/gfs2-glocks.rst
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -105,7 +105,7 @@ go_unlocked           Yes                       No
    Operations must not drop either the bit lock or the spinlock
    if its held on entry. go_dump and do_demote_ok must never block.
    Note that go_dump will only be called if the glock's state
-   indicates that it is caching uptodate data.
+   indicates that it is caching up-to-date data.
 
 Glock locking order within GFS2:
 
diff --git a/Documentation/filesystems/hpfs.rst b/Documentation/filesystems/hpfs.rst
index 7e0dd2f4373e..0f9516b5eb07 100644
--- a/Documentation/filesystems/hpfs.rst
+++ b/Documentation/filesystems/hpfs.rst
@@ -65,7 +65,7 @@ are case sensitive, so for example when you create a file FOO, you can use
 'cat FOO', 'cat Foo', 'cat foo' or 'cat F*' but not 'cat f*'. Note, that you
 also won't be able to compile linux kernel (and maybe other things) on HPFS
 because kernel creates different files with names like bootsect.S and
-bootsect.s. When searching for file thats name has characters >= 128, codepages
+bootsect.s. When searching for file whose name has characters >= 128, codepages
 are used - see below.
 OS/2 ignores dots and spaces at the end of file name, so this driver does as
 well. If you create 'a. ...', the file 'a' will be created, but you can still
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..4db3b07c16c5 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -563,7 +563,7 @@ this would be dependent on number of cores the benchmark is run on.
    depending on # of threads:
 
 For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
-thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
+thread, with 10% bandwidth' can consume up to 10GBps and 40GBps although
 they have same percentage bandwidth of 10%. This is simply because as
 threads start using more cores in an rdtgroup, the actual bandwidth may
 increase or vary although user specified bandwidth percentage is same.
diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index e231d127cd40..9fe994353395 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -454,7 +454,7 @@ filesystem so that it can apply pending filesystem updates to the staging
 information.
 Once the scan is done, the owning object is re-locked, the live data is used to
 write a new ondisk structure, and the repairs are committed atomically.
-The hooks are disabled and the staging staging area is freed.
+The hooks are disabled and the staging area is freed.
 Finally, the storage from the old data structure are carefully reaped.
 
 Introducing concurrency helps online repair avoid various locking problems, but
@@ -2185,7 +2185,7 @@ The chapter about :ref:`secondary metadata<secondary_metadata>` mentioned that
 checking and repairing of secondary metadata commonly requires coordination
 between a live metadata scan of the filesystem and writer threads that are
 updating that metadata.
-Keeping the scan data up to date requires requires the ability to propagate
+Keeping the scan data up to date requires the ability to propagate
 metadata updates from the filesystem into the data being collected by the scan.
 This *can* be done by appending concurrent updates into a separate log file and
 applying them before writing the new metadata to disk, but this leads to
diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index db0c0b1f3700..1e603189b5b1 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -92,8 +92,8 @@ and polarity settings. The table below shows the expectations:
 |             | Low         | as low, assuming active                       |
 +-------------+-------------+-----------------------------------------------+
 
-That said, for our above example the both GPIOs, since the bias setting
-is explicit and _DSD is present, will be treated as active with a high
+That said, for our above example, since the bias setting is explicit and
+_DSD is present, both GPIOs will be treated as active with a high
 polarity and Linux will configure the pins in this state until a driver
 reprograms them differently.
 
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
diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index b018ce346392..688537b225f5 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -539,7 +539,7 @@ CAN Filter Usage Optimisation
 The CAN filters are processed in per-device filter lists at CAN frame
 reception time. To reduce the number of checks that need to be performed
 while walking through the filter lists the CAN core provides an optimized
-filter handling when the filter subscription focusses on a single CAN ID.
+filter handling when the filter subscription focuses on a single CAN ID.
 
 For the possible 2048 SFF CAN identifiers the identifier is used as an index
 to access the corresponding subscription list without any further checks.
diff --git a/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst b/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst
index 25fd9aa284e2..f0424597aac1 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst
@@ -42,7 +42,7 @@ Port's netdev devices have to be in UP before joining to the bridge to avoid
 overwriting of bridge configuration as CPSW switch driver completely reloads its
 configuration when first port changes its state to UP.
 
-When the both interfaces joined the bridge - CPSW switch driver will enable
+When both interfaces have joined the bridge - CPSW switch driver will enable
 marking packets with offload_fwd_mark flag.
 
 All configuration is implemented via switchdev API.
diff --git a/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst b/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst
index 464dce938ed1..2f3c43a32bfc 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst
@@ -92,7 +92,7 @@ Port's netdev devices have to be in UP before joining to the bridge to avoid
 overwriting of bridge configuration as CPSW switch driver copletly reloads its
 configuration when first Port changes its state to UP.
 
-When the both interfaces joined the bridge - CPSW switch driver will enable
+When both interfaces have joined the bridge - CPSW switch driver will enable
 marking packets with offload_fwd_mark flag unless "ale_bypass=0"
 
 All configuration is implemented via switchdev API.
diff --git a/Documentation/networking/rds.rst b/Documentation/networking/rds.rst
index 41b0a6182fe4..4261146e9d92 100644
--- a/Documentation/networking/rds.rst
+++ b/Documentation/networking/rds.rst
@@ -339,7 +339,7 @@ The send path
   rds_sendmsg()
     - struct rds_message built from incoming data
     - CMSGs parsed (e.g. RDMA ops)
-    - transport connection alloced and connected if not already
+    - transport connection allocated and connected if not already
     - rds_message placed on send queue
     - send worker awoken
 
diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 9ebecb7b00b2..38e614d92a4a 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -472,7 +472,7 @@ in the device tree from the root bridge to a leaf device contains both of them).
 The pci_pm_suspend_noirq() routine is executed after suspend_device_irqs() has
 been called, which means that the device driver's interrupt handler won't be
 invoked while this routine is running.  It first checks if the device's driver
-implements legacy PCI suspends routines (Section 3), in which case the legacy
+implements legacy PCI suspend routines (Section 3), in which case the legacy
 late suspend routine is called and its result is returned (the standard
 configuration registers of the device are saved if the driver's callback hasn't
 done that).  Second, if the device driver's struct dev_pm_ops object is not
@@ -544,7 +544,7 @@ result is then returned).
 The resume phase is carried out asynchronously for PCI devices, like the
 suspend phase described above, which means that if two PCI devices don't depend
 on each other in a known way, the pci_pm_resume() routine may be executed for
-the both of them in parallel.
+both of them in parallel.
 
 The pci_pm_complete() routine only executes the device driver's pm->complete()
 callback, if defined.
diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index ebedb6c75db9..641d09a6546b 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -13,7 +13,7 @@ infrastructure uses it internally? And where do they share common code?
 
 Well, a picture is worth a thousand words... So ASCII art follows :-)
 
-[This depicts the current design in the kernel, and focusses only on the
+[This depicts the current design in the kernel, and focuses only on the
 interactions involving the freezer and CPU hotplug and also tries to explain
 the locking involved. It outlines the notifications involved as well.
 But please note that here, only the call paths are illustrated, with the aim
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
diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 71cd40472d36..06b0edad0179 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -81,7 +81,7 @@ Same as ftrace, the registered callbacks will start being called some time
 after the register_fprobe() is called and before it returns. See
 :file:`Documentation/trace/ftrace.rst`.
 
-Also, the unregister_fprobe() will guarantee that the both enter and exit
+Also, the unregister_fprobe() will guarantee that both enter and exit
 handlers are no longer being called by functions after unregister_fprobe()
 returns as same as unregister_ftrace_function().
 
diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index e198854ace79..e225cc46b71e 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -193,7 +193,7 @@ FTRACE_OPS_FL_RECURSION
 	Note, if this flag is set, then the callback will always be called
 	with preemption disabled. If it is not set, then it is possible
 	(but not guaranteed) that the callback will be called in
-	preemptable context.
+	preemptible context.
 
 FTRACE_OPS_FL_IPMODIFY
 	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index af66a05e18cc..aef674df3afd 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -30,7 +30,7 @@ disabled and enabled, as well as for preemption and from a time
 a task is woken to the task is actually scheduled in.
 
 One of the most common uses of ftrace is the event tracing.
-Throughout the kernel is hundreds of static event points that
+Throughout the kernel are hundreds of static event points that
 can be enabled via the tracefs file system to see what is
 going on in certain parts of the kernel.
 
@@ -383,7 +383,7 @@ of ftrace. Here is a list of some of the key files:
 	not be listed in this count.
 
 	If the callback registered to be traced by a function with
-	the "save regs" attribute (thus even more overhead), a 'R'
+	the "save regs" attribute (thus even more overhead), an 'R'
 	will be displayed on the same line as the function that
 	is returning registers.
 
@@ -392,7 +392,7 @@ of ftrace. Here is a list of some of the key files:
 	an 'I' will be displayed on the same line as the function that
 	can be overridden.
 
-	If a non ftrace trampoline is attached (BPF) a 'D' will be displayed.
+	If a non-ftrace trampoline is attached (BPF) a 'D' will be displayed.
 	Note, normal ftrace trampolines can also be attached, but only one
 	"direct" trampoline can be attached to a given function at a time.
 
@@ -402,7 +402,7 @@ of ftrace. Here is a list of some of the key files:
 
 	If a function had either the "ip modify" or a "direct" call attached to
 	it in the past, a 'M' will be shown. This flag is never cleared. It is
-	used to know if a function was every modified by the ftrace infrastructure,
+	used to know if a function was ever modified by the ftrace infrastructure,
 	and can be used for debugging.
 
 	If the architecture supports it, it will also show what callback
@@ -418,7 +418,7 @@ of ftrace. Here is a list of some of the key files:
 
 	This file contains all the functions that ever had a function callback
 	to it via the ftrace infrastructure. It has the same format as
-	enabled_functions but shows all functions that have every been
+	enabled_functions but shows all functions that have ever been
 	traced.
 
 	To see any function that has every been modified by "ip modify" or a
@@ -517,7 +517,7 @@ of ftrace. Here is a list of some of the key files:
 	Whenever an event is recorded into the ring buffer, a
 	"timestamp" is added. This stamp comes from a specified
 	clock. By default, ftrace uses the "local" clock. This
-	clock is very fast and strictly per cpu, but on some
+	clock is very fast and strictly per CPU, but on some
 	systems it may not be monotonic with respect to other
 	CPUs. In other words, the local clocks may not be in sync
 	with local clocks on other CPUs.
@@ -868,7 +868,7 @@ Here is the list of current tracers that may be configured.
 
   "mmiotrace"
 
-	A special tracer that is used to trace binary module.
+	A special tracer that is used to trace binary modules.
 	It will trace all the calls that a module makes to the
 	hardware. Everything it writes and reads from the I/O
 	as well.
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 0aada18c38c6..a6068e0305fd 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -840,7 +840,7 @@ Extended error information
 
   The compound key examples used a key and a sum value (hitcount) to
   sort the output, but we can just as easily use two keys instead.
-  Here's an example where we use a compound key composed of the the
+  Here's an example where we use a compound key composed of the
   common_pid and size event fields.  Sorting with pid as the primary
   key and 'size' as the secondary key allows us to display an
   ordered summary of the recvfrom sizes, with counts, received by
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
index 2a888ff5829f..c4675a2098ad 100644
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


