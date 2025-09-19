Return-Path: <linux-kernel+bounces-825333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B2CB8B95A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD698B66EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4542D7387;
	Fri, 19 Sep 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2eokLCV"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908320DD72
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322005; cv=none; b=OSMD3jrwYreUG8fnqKlNKTGcSY5QhZHt9abr3ybVfyBZUMQsZfu4tsWo6Wri0AwJ/PYtD+5R36eESsUayDnK3jlEehCy++GvKWD2YNit78XH+9oqN0wUdhsvpw06+a/DX1C8Kjh7tsAtl5sgJtHtRgDI2LfC5aJ8Fu+NkrR8Lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322005; c=relaxed/simple;
	bh=/0yTUQ6OsN2xzS+Pgvii5s7x3os1zEtvAWCswrn0kbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDY3d29v/m9VEHaYP6vYU50CtBtWni9hjhzM3zI+UNXxXb4J3qoMCgf9q/ktTnWCKCelE+i2itNk/ouRH7h9rMIhd5xlEIm8S7tL5YICQ9STc+irNL7naChkdxGO2PM0PEOMnOr7IlOfOASeljO2F2UVHCgRNvkgdCPyzuEDUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W2eokLCV; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88432e1af6dso210864639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758322003; x=1758926803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuH2MBotnVgm/KcFiuPMrEV+WdPjTxaJwI5CcIOrjDY=;
        b=W2eokLCVU2TqEkuiGjOr7j6J7r2FYmkpzjWQV4RzQmN32MYCpzzta5mfxCw8tOwNuo
         /hJzvFxyMwtQVFm8AlFOHIQfwBi5dYY7ctUUQa53Yhp8i9y4Tt8YF0ZL5H9pSTz9TAgs
         LBHNZ7HOSGD+bCvpE9H60qkovnDIAX3u/ThgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758322003; x=1758926803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuH2MBotnVgm/KcFiuPMrEV+WdPjTxaJwI5CcIOrjDY=;
        b=ZLE39866h4avx/VqEtcdlqTc3YJ1+rqfdWFPQUcVsEARCL1tqOyryCRVNeFyBqeF6S
         hbc+Ty9Ue6mdj8oV931hqyT1dVERU+MKnWNIkXlh3MkeEESgcxG13DlPq7CgOwz+e07F
         z6ic+jD9q4PoeE0L9clHSRzhGoS/xAun8tGbRVQiK5m9nRUNbwv2l60DFwqwM4uhnTOz
         s+VWCgkA0fVB4Dcm6jR2d5raBdDrOCbYJ5JjwvLp5lPwOmkww3MHDo51UeXKPaDOzjVx
         e33dwtVjo08Z9NorPSgne7TTwX5wvCPCr/AP09TTCl3KBW1Luw8Q589s6262ZPr9dIdD
         GaCA==
X-Forwarded-Encrypted: i=1; AJvYcCVDJey71hjfmL1Q7QXcohbVGLxRVBbxkAOH17rIXfa8ayw40tdBA3hZzBbXLvLee4dEnZT7wEC0ndOE8Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoZpHPnVS+T1oN92uhnQnDQSW8DB4zzw7wiSbACIzb5tuQ/be
	tpITcsdERmAG+7m8soNU8SRnp9FmYZvPQ+2cjkC1Cc85hCsw6r7Ys0ZJWuYhOFQ5mw==
X-Gm-Gg: ASbGnctq3B54HAmWTAoTnTUzQzCGYbZxOtwzfDZ2MxiHGhn58zkdNL+kEVSpIK+pfWF
	x/lALYrR7GUIE+3gD9bRMmFk3ae8KkAKLkyVM9V4BG9HKbXHWoxWYq8NaZWuRS2tlrwdYautnbV
	GcKTwR5gKaVOfo2RxuiX9CrwNJ0bNJyTlaj1ynF+VcuZGItfnpvbn4iXFYaOk3g55mLdqSfcJP6
	B7c2/q9gg6wHqhGmGrsxD3/HjP+KGaO70jZm2UuB4hAqCKYOGGAumCsXO5q4qQcvT6LLNL2Y5X2
	CnrXB5eyK1V8/SDm3+UP9pZ7LpnwQFpYFyXUMVgGx0hTvmLgDEQ8UxVgOSwUabJGMIosgBrAd6t
	x6OBWjkTq4qjYrz7V
X-Google-Smtp-Source: AGHT+IH1joaNFFBUlmJSRWwYgfP/Jl1wfWiGMU8D8ShdnjXorvf9uY1FmfBG1WmwA8Z3f8m8D9fxdg==
X-Received: by 2002:a05:6e02:1c21:b0:408:4492:c9c2 with SMTP id e9e14a558f8ab-424819115acmr78580765ab.10.1758322002709;
        Fri, 19 Sep 2025 15:46:42 -0700 (PDT)
Received: from chromium.org ([96.79.232.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d58bed61bsm2581743173.82.2025.09.19.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 15:46:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Tom Rini <trini@konsulko.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] scripts/make_fit: Support an initial ramdisk
Date: Fri, 19 Sep 2025 16:46:24 -0600
Message-ID: <20250919224639.1122848-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIT (Flat Image Tree) allows an ramdisk to be included in each
configuration. Add support for this to the script.

This feature is not available via 'make image.fit' since the ramdisk
likely needs to be built separately anyway, e.g. using modules from
the kernel build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Don't compress the ramdisk as it is already compressed

 scripts/make_fit.py | 46 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 1683e5ec6e67..b4caa127d2c3 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -10,10 +10,12 @@
 Usage:
     make_fit.py -A arm64 -n 'Linux-6.6' -O linux
         -o arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
-        @arch/arm64/boot/dts/dtbs-list -E -c gzip
+        -r /boot/initrd.img-6.14.0-27-generic @arch/arm64/boot/dts/dtbs-list
+        -E -c gzip
 
-Creates a FIT containing the supplied kernel and a set of devicetree files,
-either specified individually or listed in a file (with an '@' prefix).
+Creates a FIT containing the supplied kernel, an optional ramdisk, and a set of
+devicetree files, either specified individually or listed in a file (with an
+'@' prefix).
 
 Use -E to generate an external FIT (where the data is placed after the
 FIT data structure). This allows parsing of the data without loading
@@ -29,8 +31,6 @@ looks at the .cmd files produced by the kernel build.
 
 The resulting FIT can be booted by bootloaders which support FIT, such
 as U-Boot, Linuxboot, Tianocore, etc.
-
-Note that this tool does not yet support adding a ramdisk / initrd.
 """
 
 import argparse
@@ -81,6 +81,8 @@ def parse_args():
           help='Specifies the operating system')
     parser.add_argument('-k', '--kernel', type=str, required=True,
           help='Specifies the (uncompressed) kernel input file (.itk)')
+    parser.add_argument('-r', '--ramdisk', type=str,
+          help='Specifies the ramdisk/initrd input file')
     parser.add_argument('-v', '--verbose', action='store_true',
                         help='Enable verbose output')
     parser.add_argument('dtbs', type=str, nargs='*',
@@ -133,7 +135,28 @@ def write_kernel(fsw, data, args):
         fsw.property_u32('entry', 0)
 
 
-def finish_fit(fsw, entries):
+def write_ramdisk(fsw, data, args):
+    """Write out the ramdisk image
+
+    Writes a ramdisk node along with the required properties
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        data (bytes): Data to write (possibly compressed)
+        args (Namespace): Contains necessary strings:
+            arch: FIT architecture, e.g. 'arm64'
+            fit_os: Operating Systems, e.g. 'linux'
+    """
+    with fsw.add_node('ramdisk'):
+        fsw.property_string('description', 'Ramdisk')
+        fsw.property_string('type', 'ramdisk')
+        fsw.property_string('arch', args.arch)
+        fsw.property_string('os', args.os)
+        fsw.property('data', data)
+        fsw.property_u32('load', 0)
+
+
+def finish_fit(fsw, entries, has_ramdisk=False):
     """Finish the FIT ready for use
 
     Writes the /configurations node and subnodes
@@ -143,6 +166,7 @@ def finish_fit(fsw, entries):
         entries (list of tuple): List of configurations:
             str: Description of model
             str: Compatible stringlist
+        has_ramdisk (bool): True if a ramdisk is included in the FIT
     """
     fsw.end_node()
     seq = 0
@@ -154,6 +178,8 @@ def finish_fit(fsw, entries):
                 fsw.property_string('description', model)
                 fsw.property('fdt', bytes(''.join(f'fdt-{x}\x00' for x in files), "ascii"))
                 fsw.property_string('kernel', 'kernel')
+                if has_ramdisk:
+                    fsw.property_string('ramdisk', 'ramdisk')
     fsw.end_node()
 
 
@@ -274,6 +300,14 @@ def build_fit(args):
     size += os.path.getsize(args.kernel)
     write_kernel(fsw, comp_data, args)
 
+    # Handle the ramdisk if provided. Compression is not supported as it is
+    # already compressed.
+    if args.ramdisk:
+        with open(args.ramdisk, 'rb') as inf:
+            data = inf.read()
+        size += len(data)
+        write_ramdisk(fsw, data, args)
+
     for fname in args.dtbs:
         # Ignore non-DTB (*.dtb) files
         if os.path.splitext(fname)[1] != '.dtb':
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fit

