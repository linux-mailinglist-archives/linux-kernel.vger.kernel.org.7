Return-Path: <linux-kernel+bounces-843845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB9BC068C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B75A4F3BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905D22B8B0;
	Tue,  7 Oct 2025 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iejNTuY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB13215767
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819946; cv=none; b=T9t7PUT7Jt7k/hfkWZDMwT+WIcCLIz9/CqlpU9Wmv7FjvYsT8GfuUcZJKFFnaWPlO36K1GtqNTepSdLcWczfEeDezDlr5D4Dq7X6uhHvckz+2DWypgf7tp9tEQ1MRuY/o+Qzzm4JoUBA/30Clu4tkcwT6Sllop/SWUKAUrZcWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819946; c=relaxed/simple;
	bh=ljRIZcXVDsulZu38rOR6Abg5SbUHTniYuTY+SzLZI8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDJZWoxoH9krRoJmZhqROiSxJIyzGLs+EPDn/IfQcC86YbJBzNEwhjNwjL4c//3Fn5jnkN+41H3d034FHYK/tbMHhCWn7sO9YS2PZx/FcZCmzVcTsM52RSZz/WNodyRQOxs26kHZpb4O673OXdFNH3vI4MHJ71Z7M4tWDgubELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iejNTuY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EBBC4CEF7;
	Tue,  7 Oct 2025 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759819945;
	bh=ljRIZcXVDsulZu38rOR6Abg5SbUHTniYuTY+SzLZI8g=;
	h=From:To:Cc:Subject:Date:From;
	b=iejNTuY4GggfYpfh21eBR5X5L1Qy0kK8hjhzrUyo7ePAhd0zZd7hC0GrwC2dG//Id
	 GYQGREtX+98qKZbJROSjIRJ33PwVZIF56/5k0uGgjCDs7rAWBXziMrIvO5vwntJ8Qf
	 dqX+/D/7WNHepyBxPSp0UnfU9zd6nec9FFdzDM+63gMq17pt51ovC/hS63I/0Lpmz/
	 cHYBLjxL1/Ipkg5LVjVeAef0fRjE2VzT7M33pPCJY43OnK6iBUSkNNvp4pSQ86EH9P
	 aLTvZzKA7UEQg4n0yIu7paPpLxNoHtkzXQR2lS5EM8riDVw/65NTp6mUw3Kcy6XLy+
	 cg3d9Kx7pfCQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v61Yd-0000000H0MH-2HA0;
	Tue, 07 Oct 2025 08:52:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/ghes_inject.py: avoid long lines inside the script
Date: Tue,  7 Oct 2025 08:52:11 +0200
Message-ID: <5d75e5f2a9584d4c9235d5111b6402291ec8f616.1759819931.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are some lines that are too long, mostly at argparse,
causing checkpatch warnings, plus a couple pylint disable
lines.

Make them honor 80 columns limit.

No functional changes.

While here, add a space after comma on help lines displaying
possible alternatives.

Requested-by: "Michael S. Tsirkin" <mst@redhat.com>
Closes: https://lore.kernel.org/qemu-devel/20251005082027-mutt-send-email-mst@kernel.org/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/arm_processor_error.py | 35 +++++++++++++++++++++-------------
 scripts/ghes_inject.py         |  8 ++++----
 scripts/qmp_helper.py          | 23 +++++++++++++---------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 73d069f070d4..e4b6e11822af 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -80,12 +80,14 @@
 [Hardware Error]:    error_type: 0x08: bus error
 [Hardware Error]:    error_info: 0x00000080d6460fff
 [Hardware Error]:     transaction type: Generic
-[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)
+[Hardware Error]:     bus error, operation type: Generic read
+                      (type of instruction or data request cannot be determined)
 [Hardware Error]:     affinity level at which the bus error occurred: 1
 [Hardware Error]:     processor context corrupted
 [Hardware Error]:     the error has been corrected
 [Hardware Error]:     PC is imprecise
-[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.
+[Hardware Error]:     Program execution can be restarted reliably at the PC
+                      associated with the error.
 [Hardware Error]:     participation type: Local processor observed
 [Hardware Error]:     request timed out
 [Hardware Error]:     address space: External Memory Access
@@ -102,12 +104,14 @@
 [Hardware Error]:    register context type: AArch64 EL1 context registers
 [Hardware Error]:    00000000: 00000000 00000000
 [Hardware Error]:   Vendor specific error info has 5 bytes:
-[Hardware Error]:    00000000: 13 7b 04 05 01                                   .{...
+[Hardware Error]:    00000000: 13 7b 04 05 01                             .{...
 [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
 [Firmware Warn]: GHES: Unhandled processor error type 0x04: TLB error
 [Firmware Warn]: GHES: Unhandled processor error type 0x08: bus error
-[Firmware Warn]: GHES: Unhandled processor error type 0x10: micro-architectural error
-[Firmware Warn]: GHES: Unhandled processor error type 0x14: TLB error|micro-architectural error
+[Firmware Warn]: GHES: Unhandled processor error type 0x10:
+                 micro-architectural error
+[Firmware Warn]: GHES: Unhandled processor error type 0x14:
+                 TLB error|micro-architectural error
 """
 
 import argparse
@@ -171,10 +175,10 @@ def __init__(self, subparsers):
 
         parser = subparsers.add_parser("arm", description=self.DESC)
 
-        arm_valid_bits = ",".join(self.arm_valid_bits.keys())
-        flags = ",".join(self.pei_flags.keys())
-        error_types = ",".join(self.pei_error_types.keys())
-        pei_valid_bits = ",".join(self.pei_valid_bits.keys())
+        arm_valid_bits = ", ".join(self.arm_valid_bits.keys())
+        flags = ", ".join(self.pei_flags.keys())
+        error_types = ", ".join(self.pei_error_types.keys())
+        pei_valid_bits = ", ".join(self.pei_valid_bits.keys())
 
         # UEFI N.16 ARM Validation bits
         g_arm = parser.add_argument_group("ARM processor")
@@ -193,7 +197,7 @@ def __init__(self, subparsers):
                            help="Indicates if the processor is running or not")
         g_arm.add_argument("--psci", "--psci-state",
                            type=lambda x: int(x, 0),
-                           help="Power State Coordination Interface - PSCI state")
+                           help="Power State Coordination Interface state")
 
         # TODO: Add vendor-specific support
 
@@ -208,9 +212,12 @@ def __init__(self, subparsers):
 
         # UEFI N.17 Integer values
         g_pei.add_argument("-m", "--multiple-error", nargs="+",
-                        help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")
+                        help="Number of errors: "
+                             "0: Single error, 1: Multiple errors, "
+                             "2-65535: Error count if known")
         g_pei.add_argument("-e", "--error-info", nargs="+",
-                        help="Error information (UEFI 2.10 tables N.18 to N.20)")
+                        help="Error information "
+                             "(UEFI 2.10 tables N.18 to N.20)")
         g_pei.add_argument("-p", "--physical-address",  nargs="+",
                         help="Physical address")
         g_pei.add_argument("-v", "--virtual-address",  nargs="+",
@@ -219,7 +226,9 @@ def __init__(self, subparsers):
         # UEFI N.21 Context
         g_ctx = parser.add_argument_group("Processor Context")
         g_ctx.add_argument("--ctx-type", "--context-type", nargs="*",
-                        help="Type of the context (0=ARM32 GPR, 5=ARM64 EL1, other values supported)")
+                        help="Type of the context "
+                             "(0=ARM32 GPR, 5=ARM64 EL1, "
+                             "other values supported)")
         g_ctx.add_argument("--ctx-size", "--context-size", nargs="*",
                         help="Minimal size of the context")
         g_ctx.add_argument("--ctx-array", "--context-array", nargs="*",
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
index 9a235201418b..1a2d60e9e16f 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -8,7 +8,7 @@
 Handle ACPI GHESv2 error injection logic QEMU QMP interface.
 """
 
-import argparse
+from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter
 import sys
 
 from arm_processor_error import ArmProcessorEinj
@@ -26,9 +26,9 @@ def main():
     """Main program"""
 
     # Main parser - handle generic args like QEMU QMP TCP socket options
-    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter,
-                                     usage="%(prog)s [options]",
-                                     description=EINJ_DESC)
+    parser = ArgumentParser(formatter_class=ArgumentDefaultsHelpFormatter,
+                            usage="%(prog)s [options]",
+                            description=EINJ_DESC)
 
     g_options = parser.add_argument_group("QEMU QMP socket options")
     g_options.add_argument("-H", "--host", default="localhost", type=str,
diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index c1e7e0fd80ce..18b99c01cd79 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -198,7 +198,8 @@ def bit(b):
     def data_add(data, value, num_bytes):
         """Adds bytes from value inside a bitarray"""
 
-        data.extend(value.to_bytes(num_bytes, byteorder="little"))  # pylint: disable=E1101
+        # pylint: disable=E1101
+        data.extend(value.to_bytes(num_bytes, byteorder="little"))
 
     def dump_bytearray(name, data):
         """Does an hexdump of a byte array, grouping in bytes"""
@@ -416,12 +417,14 @@ def _connect(self):
     def argparse(parser):
         """Prepare a parser group to query generic error data"""
 
-        block_status_bits = ",".join(qmp.BLOCK_STATUS_BITS.keys())
-        error_severity_enum = ",".join(qmp.ERROR_SEVERITY.keys())
-        validation_bits = ",".join(qmp.VALIDATION_BITS.keys())
-        gedb_flags_bits = ",".join(qmp.GEDB_FLAGS_BITS.keys())
+        block_status_bits = ", ".join(qmp.BLOCK_STATUS_BITS.keys())
+        error_severity_enum = ", ".join(qmp.ERROR_SEVERITY.keys())
+        validation_bits = ", ".join(qmp.VALIDATION_BITS.keys())
+        gedb_flags_bits = ", ".join(qmp.GEDB_FLAGS_BITS.keys())
+
+        # pylint: disable=E1101
+        g_gen = parser.add_argument_group("Generic Error Data")
 
-        g_gen = parser.add_argument_group("Generic Error Data")  # pylint: disable=E1101
         g_gen.add_argument("--block-status",
                            help=f"block status bits: {block_status_bits}")
         g_gen.add_argument("--raw-data", nargs="+",
@@ -439,9 +442,10 @@ def argparse(parser):
                            help="Time when the error info was collected")
         g_gen.add_argument("--precise", "--precise-timestamp",
                            action='store_true',
-                           help="Marks the timestamp as precise if --timestamp is used")
+                           help="if --timestamp is used, timestamp is precise")
         g_gen.add_argument("--gedb-flags",
-                           help=f"General Error Data Block flags: {gedb_flags_bits}")
+                           help="General Error Data Block flags: "
+                                f"{gedb_flags_bits}")
 
     def set_args(self, args):
         """Set the arguments optionally defined via self.argparse()"""
@@ -501,8 +505,9 @@ def set_args(self, args):
                 self.validation_bits |= self.VALIDATION_BITS["timestamp"]
 
         if args.gen_err_valid_bits:
+            gen_err_valid_bits = args.gen_err_valid_bits
             self.validation_bits = util.get_choice(name="validation",
-                                                   value=args.gen_err_valid_bits,
+                                                   value=gen_err_valid_bits,
                                                    choices=self.VALIDATION_BITS)
 
     def __init__(self, host, port, debug=False):
-- 
2.51.0


