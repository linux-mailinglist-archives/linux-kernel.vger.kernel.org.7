Return-Path: <linux-kernel+bounces-825213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04526B8B4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1BD5A8091
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96D2D23BC;
	Fri, 19 Sep 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYU5XjbK"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777FD2D191F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316218; cv=none; b=UE9q7lq/IRPCXudh8rp5uQurCswTXw4puJtiVhxz67ZbY/ELMwAobZmUDI5TTZage+JpUw1NUxsNH7zgoP/dioFCMWAwz3seyuJyBtQRpsXUw97yF9zNqsoqUpEEl7ViR6eC3p9yXt2wHR95Y7uFrR9YmzMV2JZFAIgzsalwAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316218; c=relaxed/simple;
	bh=ckoZEUCtUc917z7ardmEDn71011fO8GT3z03naDE85E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsoGNAsqtt2HIGsmf/Zq4rRZHzYLzC0p+M3AQgFisOiSezVUUB15G0Bs+9K5QQW9c9wXXJarUdcBkpdOqI2no9N9qzkSiKlXiCFlx8Mzm9BJk+pMOvCi95qkP/oJCJcRaNq1UYz8ZPYBQDUXYuKRwhLc7HZaq0ohrBNO4VmkAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JYU5XjbK; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88776dcac7aso88603239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758316215; x=1758921015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6kzpx7PuET5YG7VGCa/gaPyl4PFThzaxgxQk1CSqzg=;
        b=JYU5XjbKO9SL5CeXxd4Bt9rFV/AX79VocNGwDHXmcbBFGAbYr5qoDlKpXj63AXRo7c
         Gpg70dJXPR2MlkdVjdLmSS0SxyVZVJaW8sidSUQv357OTMEBgGfz4bWn2PST/EaLH8iG
         lsrXayFbdHqp/j0bGVB9SVJQbMLiCJ3KOXzB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316215; x=1758921015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6kzpx7PuET5YG7VGCa/gaPyl4PFThzaxgxQk1CSqzg=;
        b=Eg/ZtAffQBi4Pf1SDkRUtHKjmm8Jet2+CT3szCJ3WjIRj1ktfdtZireaJz2f7WFf/s
         RrAVXpGAte2iZDMMduASYdEb/EVqnhEFbC7XfVY+y9/vmYTxAzsRiRo2MZQ2ZYliTZN2
         K7rTCsdqdc8dzzyG6lRhP5vt5+1P04sf8hpZMH06cvzQVIt8RipDFchwCqvkROXuPZn7
         lWO99Gbs4+04qrJ/jqRQsosbw9wVRCfIwO4LcyavUoF655otJqeGbi2wqLnn2/qBo8it
         xkCcjvIidICGD4c0tdNrv7myaUXjQFF0m0oDTZrHbeXi4j8ay4FAJ9FuoQYv++aCY8gd
         oKhw==
X-Forwarded-Encrypted: i=1; AJvYcCWRapP3rUE9Z2k1Oe69ozgWlUWkI0TE1A7lDmifM7klEMu7pQCD7ADH+4XY6KkRCNqDG6UQlF/yyxxNNoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdqd9qnj/LfSvWwuGSZisQeBTlAV/gCvbBOGqjAn+j0CtTP4vb
	YSTkystcohH2K5DRiFu5akPQ8b/u64GSdCbqXoSuow4lfnUIVjcUg7dt89aiDanrJA==
X-Gm-Gg: ASbGncvKW7x//DfRXsviG21SUT2IR55zjH3VpCWLXGHPvYEkHtZMHd/48rx6g2rY4X/
	S0Cn08vLQh/kKFOHnJfkLpK7UdIWrMn8RpamEWVnsNI1YN1IKIPtDOKiC2Z9I3uTm17O9QnvKSC
	bRry5Yofh1x5SQYMYmFvyZ6bKw1flEUiOrIcJluJbd1YtERgOsmyZwzd4mH3Jm89niDimyUIr51
	rxt5la6AWuED+HRq4n9whpcRPJHOctbleqDDR6lmq9z+x7DJcw+10E3oQcQweo1GSinTagkeT6O
	/VzPcSFfrOSPxOQrMh0Sf1Zst1qlQx1wmnRjuB+yS8yA06A7K/2eXIPZUWgLlqnzZOY7SGP7iiE
	dmzrDjCTTaXLe8YgX/P8gScQsAm8=
X-Google-Smtp-Source: AGHT+IHKmT4xaJZbwqHmJdVZ0iaAsPxl4/+9IIfOk8OLoGXCmH5OmfwufWJ3RQfWwDFIzzKhhQ3Pog==
X-Received: by 2002:a05:6e02:17ca:b0:3f0:7ad2:2bf5 with SMTP id e9e14a558f8ab-42481924952mr86717955ab.12.1758316215285;
        Fri, 19 Sep 2025 14:10:15 -0700 (PDT)
Received: from chromium.org ([96.79.232.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56e41ec1sm2513604173.72.2025.09.19.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 14:10:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Tom Rini <trini@konsulko.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Simon Glass <sjg@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts/make_fit: Support an initial ramdisk
Date: Fri, 19 Sep 2025 15:09:57 -0600
Message-ID: <20250919211000.1045267-1-sjg@chromium.org>
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

 scripts/make_fit.py | 47 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 1683e5ec6e67..c43fd9d60809 100755
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
@@ -133,7 +135,30 @@ def write_kernel(fsw, data, args):
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
+            compress: Compression algorithm to use, e.g. 'gzip'
+    """
+    with fsw.add_node('ramdisk'):
+        fsw.property_string('description', 'Ramdisk')
+        fsw.property_string('type', 'ramdisk')
+        fsw.property_string('arch', args.arch)
+        fsw.property_string('os', args.os)
+        fsw.property_string('compression', args.compress)
+        fsw.property('data', data)
+        fsw.property_u32('load', 0)
+
+
+def finish_fit(fsw, entries, has_ramdisk=False):
     """Finish the FIT ready for use
 
     Writes the /configurations node and subnodes
@@ -143,6 +168,7 @@ def finish_fit(fsw, entries):
         entries (list of tuple): List of configurations:
             str: Description of model
             str: Compatible stringlist
+        has_ramdisk (bool): True if a ramdisk is included in the FIT
     """
     fsw.end_node()
     seq = 0
@@ -154,6 +180,8 @@ def finish_fit(fsw, entries):
                 fsw.property_string('description', model)
                 fsw.property('fdt', bytes(''.join(f'fdt-{x}\x00' for x in files), "ascii"))
                 fsw.property_string('kernel', 'kernel')
+                if has_ramdisk:
+                    fsw.property_string('ramdisk', 'ramdisk')
     fsw.end_node()
 
 
@@ -274,6 +302,13 @@ def build_fit(args):
     size += os.path.getsize(args.kernel)
     write_kernel(fsw, comp_data, args)
 
+    # Handle the ramdisk if provided
+    if args.ramdisk:
+        with open(args.ramdisk, 'rb') as inf:
+            comp_data = compress_data(inf, args.compress)
+        size += os.path.getsize(args.ramdisk)
+        write_ramdisk(fsw, comp_data, args)
+
     for fname in args.dtbs:
         # Ignore non-DTB (*.dtb) files
         if os.path.splitext(fname)[1] != '.dtb':
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fit

