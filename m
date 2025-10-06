Return-Path: <linux-kernel+bounces-843567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B6BBFBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 944784F2DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688AA20E00B;
	Mon,  6 Oct 2025 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rm94yIup"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31572153EA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791773; cv=none; b=f7b+u2cjsrhRgy4hZ+R1hwYaYiK10sbPlD5iQ+G4qnWEKQI6YnE8DtGg7MlXGkAC5+jNRg2IO3o9eH7JN/wV8qUe8ppDdswq1f/n96Y0VbqdF72l66tx920QxsDcnd5WmpQr5XZMbTO4rPjCivb/yMKdznf+Zk5kUnBSaaKeeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791773; c=relaxed/simple;
	bh=lHndcnCbZuEHl3jF9yXprme2yRHTjd0c8S9RLPZOZyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBh5WYalMJOxGeS56R+xlybaGaEj0pdpzO25kLTGKxVIBooXULeFcgaYAiJ314K9V/IdOqh7iWB8br8gPNedeSvhAZ6f2B4v7g029xnQkgsafDOmxZ6BlRGlEucn3LbBdy4/Fv/2tVMwqTmvV8AINECko64yfEN341qGSS+ZIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rm94yIup; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-92c4adc8bfeso430492839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791771; x=1760396571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReTIzD0lyRGNQa5K8IAUq+EP/qION+p7p5sDaqfXvB4=;
        b=Rm94yIupD2tBPaD7ML8D5YQLBCBktgXLMw+dvUFdrPNU7kYo/5Z+JJ205Rbc8uZNkT
         lzihs/YkvPIJdC3PvaorkyXvyanO5bCDfBPUlEUSxzyAZxdPOuoc2QCqvgUSFvoAw9Se
         EAW7VlWFRTbWfNY86hMuOlaeXk7X3YIydVz+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791771; x=1760396571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReTIzD0lyRGNQa5K8IAUq+EP/qION+p7p5sDaqfXvB4=;
        b=GtXOEPQPxkCEx7Ro9NlwrukftcGZC4mVN94i+c8Y/gXPGFrlI/yb8iC9qMrLWGx3La
         MR3RWlDqQCxZqELPQet+tKS153S2IWJfbfu19tKkBzEE7NJF3Qs1QtYVugd1HtLbixGM
         gOVHwr2UT7WQvbAYZxrQoYBgW6uXc5oP61lKlkL3eH9KoLpBz3MArFS/zEuPppqd9qFt
         dQP99A0WY1qA9cN/7hURbJ8rKqbsO3S/Zgdi2yvwkL1w2C4Mq9qyeM/FR6f6jDkyzqss
         JRJwWpdchatJ/T4VgA6fInajhnFh3PyIY6Kju7RT5/uAkbjA3Md1djkz2I/w3rHrgWtu
         pWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzFSWfS71PIrFF/F2wlOWe6WhFJ0Dq5mQ9T+R9mobFdUspHoWMOzdYruJUt0qvqNHfOH04VhIZLt0o5fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+2SrMK08zzK2QaCeq+BoYG17J+O4OLlje+uGuyqdy05KqNFo
	i4BhedKZHAo7/OQ/JEU4sNnN6LnDG0iWmZ42YGQjuckNQZuJODYTb/CcZmenLYW4EA==
X-Gm-Gg: ASbGncu2oBJMzUUx8/qLhxnWup1iXKbticFyjax+ulnxG75RMW7DIsjS0OHiAP+5rhg
	s9OkOdGZzIc+j52BDDWhhmAXnkG0JrSvEsP2etkGm0vDMdd+BwHg8q9QLkPYg9qJ80wBu4ltqgT
	OA1o5Wz80vQHqlMWOOD8McubeHpluT+k+fNapya+zGyn70H/GybMeN+AmusSiaGD22hzF9XBkHY
	vhG+Op5nsR2KwbdgVby48gQdRkSazmmns1KAkdYA7fm9UvPeDJgCzbm6VEAm+Y71TUlkc4PyuyA
	KkN/iZoWUxLIxI48PpF4Fblv3JRFj5TFRAfufhmqB5u6xntmwzI66lfkGEcdgugv7Ao1uTflAsX
	mJ9l6At8EKxPoc4JoHzHIzwZJoB/j0EnFtsGQ6T6OG1U+xlKSWku0iQ==
X-Google-Smtp-Source: AGHT+IGzPBkps6pgxo+xkRUOWRdcHJniXJOS0XDhoCKSiaRXOXMx/0guokH0JJv8zRRgcQP/nPr8eQ==
X-Received: by 2002:a05:6602:2c06:b0:93b:b891:fdb2 with SMTP id ca18e2360f4ac-93bb89203f5mr871324539f.11.1759791770626;
        Mon, 06 Oct 2025 16:02:50 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] scripts/make_fit: Provide a way to add built modules
Date: Mon,  6 Oct 2025 17:01:55 -0600
Message-ID: <20251006230205.521341-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251006230205.521341-1-sjg@chromium.org>
References: <20251006230205.521341-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide arguments to support building a ramdisk from a directory tree of
modules. This is a convenient way to try out a kernel with its modules.

This makes use of the cpio tool rather than attempting to use a python
module or our own code. The list of modules is provided in a file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---

Changes in v4:
- Provide the list of modules from the Makefile
- Reduce verbosity (don't print every module filename)

Changes in v3:
- Add a way to add built modules into the FIT

 scripts/make_fit.py | 98 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 8 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 1a74a9dcd85e..3db129f40b20 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -13,11 +13,17 @@ Usage:
         -r /boot/initrd.img-6.14.0-27-generic @arch/arm64/boot/dts/dtbs-list
         -E -c gzip
 
+    # Build with modules ramdisk instead of external ramdisk:
+    make_fit.py -A arm64 -n 'Linux-6.17' -O linux
+        -o arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
+        -m module1.ko module2.ko module3.ko @arch/arm64/boot/dts/dtbs-list
+
 Creates a FIT containing the supplied kernel, an optional ramdisk, and a set of
 devicetree files, either specified individually or listed in a file (with an
 '@' prefix).
 
 Use -r to specify an existing ramdisk/initrd file.
+Use -m to build a ramdisk from specified kernel module files.
 
 Use -E to generate an external FIT (where the data is placed after the
 FIT data structure). This allows parsing of the data without loading
@@ -38,6 +44,7 @@ as U-Boot, Linuxboot, Tianocore, etc.
 import argparse
 import collections
 import os
+import shutil
 import subprocess
 import sys
 import tempfile
@@ -83,8 +90,14 @@ def parse_args():
           help='Specifies the operating system')
     parser.add_argument('-k', '--kernel', type=str, required=True,
           help='Specifies the (uncompressed) kernel input file (.itk)')
-    parser.add_argument('-r', '--ramdisk', type=str,
+
+    # Create mutually exclusive group for ramdisk options
+    rd_group = parser.add_mutually_exclusive_group()
+    rd_group.add_argument('-r', '--ramdisk', type=str,
           help='Specifies the ramdisk/initrd input file')
+    rd_group.add_argument('-m', '--modules', type=str, nargs='+',
+          help='List of module filenames to include in ramdisk')
+
     parser.add_argument('-v', '--verbose', action='store_true',
                         help='Enable verbose output')
     parser.add_argument('dtbs', type=str, nargs='*',
@@ -240,6 +253,60 @@ def output_dtb(fsw, seq, fname, arch, compress):
         fsw.property('data', compressed)
 
 
+def build_ramdisk(args, tmpdir):
+    """Build a cpio ramdisk containing kernel modules
+
+    Similar to mkinitramfs, this creates a compressed cpio-archive containing
+    the kernel modules for the current kernel version.
+
+    Args:
+        args (Namespace): Program arguments
+        tmpdir (str): Temporary directory to use for modules installation
+
+    Returns:
+        tuple:
+            bytes: Compressed cpio data containing modules
+            int: total uncompressed size
+    """
+    suppress = None if args.verbose else subprocess.DEVNULL
+
+    if args.verbose:
+        print(f'Copying {len(args.modules)} modules to ramdisk')
+
+    # Create output-directory structure
+    outdir = os.path.join(tmpdir, 'initramfs')
+    modules_dir = os.path.join(outdir, 'usr', 'lib', 'modules')
+    os.makedirs(modules_dir, exist_ok=True)
+
+    # Copy in the specified modules
+    for module in args.modules:
+        dest_path = os.path.join(modules_dir, os.path.basename(module))
+        shutil.copy2(module, dest_path)
+
+    if args.verbose:
+        print(f'Creating cpio archive from {outdir}')
+
+    with tempfile.NamedTemporaryFile() as cpio_file:
+        # Change to initramfs directory and create cpio archive
+        with subprocess.Popen(['find', '.', '-print0'], cwd=outdir,
+                              stdout=subprocess.PIPE) as find:
+            with subprocess.Popen(['cpio', '-o', '-0', '-H', 'newc'],
+                                  stdin=find.stdout, stdout=cpio_file,
+                                  stderr=suppress, cwd=outdir) as cpio:
+                find.stdout.close()
+                cpio.wait()
+                find.wait()
+
+                if cpio.returncode != 0:
+                    raise RuntimeError('Failed to create cpio archive')
+
+        cpio_file.seek(0)  # Reset to beginning for reading
+        if args.verbose:
+            print('Reading ramdisk...' if args.compress == 'none' else
+                  f'Compressing ramdisk with {args.compress}...')
+        return compress_data(cpio_file, args.compress), cpio_file.tell()
+
+
 def process_dtb(fname, args):
     """Process an input DTB, decomposing it if requested and is possible
 
@@ -318,11 +385,12 @@ def _process_dtbs(args, fsw, entries, fdts):
     return seq, size
 
 
-def build_fit(args):
+def build_fit(args, tmpdir):
     """Build the FIT from the provided files and arguments
 
     Args:
         args (Namespace): Program arguments
+        tmpdir (str): Temporary directory for any temporary files
 
     Returns:
         tuple:
@@ -344,20 +412,29 @@ def build_fit(args):
 
     # Handle the ramdisk if provided. Compression is not supported as it is
     # already compressed.
+    ramdisk_data = None
     if args.ramdisk:
         with open(args.ramdisk, 'rb') as inf:
-            data = inf.read()
-        size += len(data)
-        write_ramdisk(fsw, data, args)
+            ramdisk_data = inf.read()
+        size += len(ramdisk_data)
+    elif args.modules:
+        if args.verbose:
+            print('Building modules ramdisk...')
+        ramdisk_data, uncomp_size = build_ramdisk(args, tmpdir)
+        size += uncomp_size
+
+    if ramdisk_data:
+        write_ramdisk(fsw, ramdisk_data, args)
 
     count, fdt_size = _process_dtbs(args, fsw, entries, fdts)
     size += fdt_size
 
-    finish_fit(fsw, entries, bool(args.ramdisk))
+    finish_fit(fsw, entries, has_ramdisk=bool(ramdisk_data))
 
-    # Include the kernel itself in the returned file count
     fdt = fsw.as_fdt()
     fdt.pack()
+
+    # Count FDT files, kernel, plus ramdisk if present
     return fdt.as_bytearray(), count + 1 + bool(args.ramdisk), size
 
 
@@ -365,7 +442,12 @@ def run_make_fit():
     """Run the tool's main logic"""
     args = parse_args()
 
-    out_data, count, size = build_fit(args)
+    tmpdir = tempfile.mkdtemp(prefix='make_fit_')
+    try:
+        out_data, count, size = build_fit(args, tmpdir)
+    finally:
+        shutil.rmtree(tmpdir)
+
     with open(args.output, 'wb') as outf:
         outf.write(out_data)
 
-- 
2.43.0


