Return-Path: <linux-kernel+bounces-767436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00806B25434
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8771C849C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2F30AAB7;
	Wed, 13 Aug 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNAChL/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2F303CBD;
	Wed, 13 Aug 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115541; cv=none; b=Uvu8j/xN5uIzIUyEq9nRBSWASLotRJNNtd2vhX80fH8TD/waUyCNelw/vM5obncnKqqBXK4Le4d9MngBYgeKzYvtA6of3mF77DqP/iAnhZXg1xG4ko41mA8gP9j52B097I+qOlH1z1aBMrOW3E8V5L3eDn2bQiAInzFD+omRtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115541; c=relaxed/simple;
	bh=UtXtqsV7yy9RZvZK6gJ9GFr0A5C3WyJeuo6UmPO0CBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkAuof1zPQCORQLJ3FMfcCIYe72oqpAePp5JWaCoFERfUmDzLNIK7qq1RNycjMdytYXmtWvfsONjG+d4VsuyazatC8an2sC0oQ1Yu5Y0+Jgny7u1CxYMPS3+qEBvR8K3xRCLfGxO1nfc2F4MgiYVKEztloJi9oZTLfRfVTxv5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNAChL/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4EAC4CEEF;
	Wed, 13 Aug 2025 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115540;
	bh=UtXtqsV7yy9RZvZK6gJ9GFr0A5C3WyJeuo6UmPO0CBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNAChL/PQ3X7JpTzvjYHqcmUpgAcv/UcNDqOx30B4+4GzQf7jaNczAaQvoDYltliW
	 bSJJLc3d/l2rvVlPhVy5gcLBi9Gt4uAi3XaAleTorfAykSl8p2XwgvJE4NBoRO2SgU
	 egEHwpOPtNtiKnSRzgKZYjAUu7IZ66b6yUMiTJx5YUYcxsaze1F4q2RndYuvjKmfqf
	 wsap99mMkSDIXEkgt1lQ1gUQpRpD1PrFPjAZ/qq83VVNET6fJm8OazOyM5jaKl2O6M
	 hG1WLZROvytkIlvhq0JMqnWlgafh7fekhprwFjV9P8grNL0DCdmwEQABQUd53CZ3s9
	 UbH36W0aUMaBw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/9] Documentation: Fix admin-guide typos
Date: Wed, 13 Aug 2025 15:04:59 -0500
Message-ID: <20250813200526.290420-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
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
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/LSM/SafeSetID.rst          |  2 +-
 Documentation/admin-guide/RAS/main.rst               |  2 +-
 Documentation/admin-guide/blockdev/paride.rst        |  2 +-
 .../admin-guide/device-mapper/vdo-design.rst         |  2 +-
 Documentation/admin-guide/hw-vuln/mds.rst            |  2 +-
 Documentation/admin-guide/kdump/kdump.rst            |  2 +-
 Documentation/admin-guide/kernel-parameters.txt      | 12 ++++++------
 Documentation/admin-guide/laptops/sonypi.rst         |  2 +-
 Documentation/admin-guide/media/imx.rst              |  2 +-
 Documentation/admin-guide/media/si4713.rst           |  6 +++---
 Documentation/admin-guide/mm/damon/usage.rst         |  2 +-
 Documentation/admin-guide/perf/hisi-pmu.rst          |  4 ++--
 .../admin-guide/quickly-build-trimmed-linux.rst      |  4 ++--
 Documentation/admin-guide/reporting-issues.rst       |  4 ++--
 .../verify-bugs-and-bisect-regressions.rst           |  2 +-
 15 files changed, 25 insertions(+), 25 deletions(-)

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
index 9c6cd52f69cf..7b011eb116a7 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -471,7 +471,7 @@ Notes on loading the dump-capture kernel:
   performance degradation. To enable multi-cpu support, you should bring up an
   SMP dump-capture kernel and specify maxcpus/nr_cpus options while loading it.
 
-* For s390x there are two kdump modes: If a ELF header is specified with
+* For s390x there are two kdump modes: If an ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
   is done on all other architectures. If no elfcorehdr= kernel parameter is
   specified, the s390x kdump kernel dynamically creates the header. The
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..d4a91dec20b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3700,7 +3700,7 @@
 			looking for corruption.  Enabling this will
 			both detect corruption and prevent the kernel
 			from using the memory being corrupted.
-			However, its intended as a diagnostic tool; if
+			However, it's intended as a diagnostic tool; if
 			repeatable BIOS-originated corruption always
 			affects the same memory, you can use memmap=
 			to prevent the kernel from using that memory.
@@ -7382,7 +7382,7 @@
 				(converted into nanoseconds). Fast, but
 				depending on the architecture, may not be
 				in sync between CPUs.
-			global - Event time stamps are synchronize across
+			global - Event time stamps are synchronized across
 				CPUs. May be slower than the local clock,
 				but better for some race conditions.
 			counter - Simple counting of events (1, 2, ..)
@@ -7502,12 +7502,12 @@
 			section.
 
 	trace_trigger=[trigger-list]
-			[FTRACE] Add a event trigger on specific events.
+			[FTRACE] Add an event trigger on specific events.
 			Set a trigger on top of a specific event, with an optional
 			filter.
 
-			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
-			Where more than one trigger may be specified that are comma deliminated.
+			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			Where more than one trigger may be specified that are comma delimited.
 
 			For example:
 
@@ -7515,7 +7515,7 @@
 
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
index be8e6b49b7b4..85dcf1cd2df8 100644
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
+* Limiter sets up the audio deviation limiter feature. Once an over deviation occurs,
   it is possible to adjust the front-end gain of the audio input and always
   prevent over deviation.
 
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ff3a2dda1f02..5cd42d428c89 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -357,7 +357,7 @@ The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
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
 
-- 
2.43.0


