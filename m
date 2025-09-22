Return-Path: <linux-kernel+bounces-827951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D8B93839
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6707AC5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA6319865;
	Mon, 22 Sep 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f7PM4XS8"
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351C315D32
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581346; cv=none; b=ml/N+XCNd5c4j6yqSkkM7iGMm7nOwoMHngI6eGW3RQIruluNGPg9McV14NWuGhXOmkVdC9SBrOTn//ic8fnKh+1x1N32SrGv1crkmzNpRJK9oTXooI/q/ngOEZxNA/5G+CBkd+Nh9ayHMY0KuhMQPVzhnvjyZUNS2ZxqvvmoPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581346; c=relaxed/simple;
	bh=Pf/bg0GhQICjy+wcBRQOvUaCBYseACFvNQaE6uplhMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wrka5DEsgJzGlo43RnP5+G/qgakeEEn/L0Xnl9YFduxc99YOKnVNPd7YuW0qhKX6bNAG13V/x7cWnb9piZ9ZOuLFaWaapdRpPx+Trwgncy3jwFJh9QIXfwZrPcI1CYNtPwp964wGDxQrnkCEw6FVqO0JLerFMsxBp3oEcmIKxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f7PM4XS8; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-74381e2079fso4989785a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581342; x=1759186142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMiDIY52UoB4SEHrqIHAI8W0lIFp4W3Ju4asakLGWk4=;
        b=f7PM4XS8A43M7pyEdoklgTOLWYQETtnZPfDM9TJq3X1oQD5zavBKpjZ+WdRobhIAJz
         85O65KTyl9ZMKr9vI/qcGXQ8wSxaRbux9M6ji6e9FaVREgVtppTaEuX9woN46D/65ZKk
         rZV70TXljXALrFtpmArfWKhfyIe4ZQykKNOqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581342; x=1759186142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMiDIY52UoB4SEHrqIHAI8W0lIFp4W3Ju4asakLGWk4=;
        b=EzI4Cmms8jYBjnSq4gL1Hfz+mZDluImxnl30LzxDqQPZHuo9EkBd2L7qNa5+3mGSkh
         +CgNTFEmpF3JkSIYlt4Y1BXYnTLQ86L6R9Qr9NP2/p5c75/1f9CTgik18sp2N/BvnSLt
         9VF7sz294TnqK7xzdS0sE0VDiIGwpDbQr+c89etHcgTJW15C3ZYIbLzXYvFoeLk2K4Mu
         NMBMiN0EwjWSgVIpn6Hkw4lFVi/VZRb/3QAXg5ocJgVE9LMhuuF1Zu0lS7CW+16ie/i8
         I22pWeqwj/GTaySdguWDGtIz3Omexv/PsrOix80Z4bagSBGcKoSqDld5u2zp3L9AlGzC
         F8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVyoLw5wqhjVlrYvakAgWDd7YSduPieADEeogLTQlm4QHi16bX0BFn+oUV6xgpu2toIr6yQYX7hPvDswgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99aqk28ut9JJqkRLLe7Ewo+3JXkw0vPUmiVAv6KHBBtPC1rkS
	ktXU3UYLvAAINnQxrwnxAiulyCqbCtYCm4VUK9KBQW9dzAbO8v4/qjy7aEx7xgEtCg==
X-Gm-Gg: ASbGncsq5yXqk1LIhm8JCx8SBmKq2CvAn6idy1tckq0HmD+cItqFteut+29ix180obF
	DOI2DrQKcaiE/oZhVvxj1S39afESSohS8Ru7GoGvLi8FfvXJOjakmMmpql1YvRqR9/thkE+bRnf
	eCzcGSn3Ppp0Q3E4s4qRJHus94DWfb7MSa4k5DdWpuDewl5wU5eLwk7+vbXYZV+A3+J5c6TpBiJ
	ngTfOYiIAeASqe6N2yUQst2tT24czG3r2+2cDDg6z25vXOZ9I03ga/H9QZwK4rWQ8PXuX1i1gVQ
	DFR0eo0jMZXMeyrUUVDUKy/wxEoalj/ua4CQTKWOQh3ogF9nBd7dXfgI9OpkdTCykX6wPqQgyWR
	sCrbo3KQ0LaqnSH/Fs7Q=
X-Google-Smtp-Source: AGHT+IELkYRIiEfD82xOSZSrywDsY6Xir8/x0TZEJvnVleHUVMeFwuyt2iM9byrl8oeZdRzuuOxJtw==
X-Received: by 2002:a05:6830:6086:b0:745:a2e5:6c9e with SMTP id 46e09a7af769-79154b2625dmr239987a34.18.1758581342572;
        Mon, 22 Sep 2025 15:49:02 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-78780383017sm1167244a34.37.2025.09.22.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:49:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] scripts/make_fit: Provide a way to add built modules
Date: Mon, 22 Sep 2025 16:48:31 -0600
Message-ID: <20250922224835.1918759-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922224835.1918759-1-sjg@chromium.org>
References: <20250922224835.1918759-1-sjg@chromium.org>
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
module or our own code. It also uses 'find' since os.walk() was found to
be quite cumbersome.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---

(no changes since v1)

 scripts/make_fit.py | 127 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 8 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 1a74a9dcd85e..57667ac9ca3b 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -13,11 +13,17 @@ Usage:
         -r /boot/initrd.img-6.14.0-27-generic @arch/arm64/boot/dts/dtbs-list
         -E -c gzip
 
+    # Build with modules ramdisk instead of external ramdisk:
+    make_fit.py -A arm64 -n 'Linux-6.17' -O linux
+        -o arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
+        -m -B /path/to/build/dir @arch/arm64/boot/dts/dtbs-list
+
 Creates a FIT containing the supplied kernel, an optional ramdisk, and a set of
 devicetree files, either specified individually or listed in a file (with an
 '@' prefix).
 
 Use -r to specify an existing ramdisk/initrd file.
+Use -m to build a ramdisk from kernel modules (similar to mkinitramfs).
 
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
@@ -83,8 +90,18 @@ def parse_args():
           help='Specifies the operating system')
     parser.add_argument('-k', '--kernel', type=str, required=True,
           help='Specifies the (uncompressed) kernel input file (.itk)')
-    parser.add_argument('-r', '--ramdisk', type=str,
+
+    # Create mutually exclusive group for ramdisk options
+    rd_group = parser.add_mutually_exclusive_group()
+    rd_group.add_argument('-r', '--ramdisk', type=str,
           help='Specifies the ramdisk/initrd input file')
+    rd_group.add_argument('-m', '--modules-ramdisk', action='store_true',
+          help='Build ramdisk from kernel modules (like mkinitramfs)')
+
+    parser.add_argument('-p', '--path', type=str,
+          help='Path where modules are installed (default: temp directory)')
+    parser.add_argument('-B', '--build-dir', type=str,
+          help='Build directory for out-of-tree builds (O= parameter to make)')
     parser.add_argument('-v', '--verbose', action='store_true',
                         help='Enable verbose output')
     parser.add_argument('dtbs', type=str, nargs='*',
@@ -240,6 +257,85 @@ def output_dtb(fsw, seq, fname, arch, compress):
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
+    # Use provided tmpdir or custom install path
+    if args.path:
+        mod_path = args.path
+    else:
+        mod_path = os.path.join(tmpdir, 'modules_install')
+        os.makedirs(mod_path, exist_ok=True)
+
+    if args.verbose:
+        print(f'Installing modules to {mod_path}')
+
+    cmd = ['make', '-s', '-j']
+
+    # It seems that the only way to prevent a 'jobserver unavailable' warning
+    # is to remove it from the makeflags
+    env = os.environ.copy()
+    makeflags = env.get('MAKEFLAGS', '')
+    env['MAKEFLAGS'] = ' '.join(f for f in makeflags.split()
+                                if not f.startswith('--jobserver-auth'))
+
+    if args.build_dir:
+        cmd.append(f'O={args.build_dir}')
+    cmd.extend(['INSTALL_MOD_PATH=' + mod_path, 'modules_install'])
+    subprocess.check_call(cmd, cwd=os.getcwd(), stdout=suppress, env=env)
+
+    # Find the modules directory that was created (e.g. due to dirty tree)
+    base_dir = os.path.join(mod_path, 'lib', 'modules')
+    if not os.path.exists(base_dir):
+        raise ValueError(f'Modules base directory {base_dir} not found')
+    dirs = [d for d in os.listdir(base_dir)
+            if os.path.isdir(os.path.join(base_dir, d))]
+    if not dirs:
+        raise ValueError(f'No module directories found in {base_dir}')
+    if len(dirs) > 1:
+        raise ValueError(f'Must have only one module directory in {base_dir}')
+
+    # Create initramfs-style directory structure (usr/lib/modules instead of
+    # lib/modules) and move modules into it
+    outdir = os.path.join(tmpdir, 'initramfs')
+    new_dir = os.path.join(outdir, 'usr', 'lib', 'modules')
+    os.makedirs(new_dir, exist_ok=True)
+    shutil.move(os.path.join(base_dir, dirs[0]), os.path.join(new_dir, dirs[0]))
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
+        return compress_data(cpio_file, args.compress), cpio_file.tell()
+
+
 def process_dtb(fname, args):
     """Process an input DTB, decomposing it if requested and is possible
 
@@ -318,11 +414,12 @@ def _process_dtbs(args, fsw, entries, fdts):
     return seq, size
 
 
-def build_fit(args):
+def build_fit(args, tmpdir):
     """Build the FIT from the provided files and arguments
 
     Args:
         args (Namespace): Program arguments
+        tmpdir (str): Temporary directory for any temporary files
 
     Returns:
         tuple:
@@ -344,20 +441,29 @@ def build_fit(args):
 
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
+    elif args.modules_ramdisk:
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
 
 
@@ -365,7 +471,12 @@ def run_make_fit():
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

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fita3

