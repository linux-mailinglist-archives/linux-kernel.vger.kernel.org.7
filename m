Return-Path: <linux-kernel+bounces-827949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77DB93830
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272E02E16FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A5330DED7;
	Mon, 22 Sep 2025 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iaYL93dm"
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0D2EC0B7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581340; cv=none; b=ixzmOQpGYHmCBTkbYe38pYjr3Fn0ecV80kLzf77N9lktc4NhEcNSPw3xyuofA81KtcYdjvRhT9oogcMEOGf0OGu3bGchGq/khIOwNAK2dccQcIDgwpQl08tu/KvHYX1TavOfK86ZDimuiEJho8ksCkyhfCaxxzBkUJFsmsDs3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581340; c=relaxed/simple;
	bh=dc886TGwt3MMWo+e2MvQWkVviRKpXxiawe8F2jNdU9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+epntXA02HgmdT6WDWPLHN3iFJqzc5jK0EYJOMk2D4MTw3BK4XsoBeXyfbSHF+PEiZpgZGx4DyUcuhJ5KHdKY8jACYSF2skpMCNspaF5jui6IOXLclVEB7S9jPOUVK6myAcLgA//jre4p5iEk0bq2+d9xKIUu8YKDng2NdXE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iaYL93dm; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-746d7c469a8so4183299a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581338; x=1759186138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55OixrJ4Uv6119FapcKr6hiNiDYkKOQ8qqvXfI5KLxU=;
        b=iaYL93dm7DwFuv2TWL2BMi43OGmVFvy6S9eQtMOHjzqac/K7v5G7JQTvOdaFlkfqMg
         j4+YsCgzaGz4uJu9icCu3+2I6R0K0UfIyEyskBGiuZH3s0jofqLrUXz6BcVfO1lDPs79
         6Sn6mVDZHtr4/wp1q55q+7T6/wSKTRr3jPraA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581338; x=1759186138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55OixrJ4Uv6119FapcKr6hiNiDYkKOQ8qqvXfI5KLxU=;
        b=T6723EznCiCdtLAW9ujgIOPNuk1Fx+Bp3fh+1xEaLfKu4bBbrgi2NRuEaWcOp7h2h4
         piyAlmYvei2IHjWzJyo6cYexMwHAjiZ6SEczFVgYWZelfQ5wfon1vmsLPKlVz9O9ekcH
         WSr7QQqDItso4Cj5AXrJH+GQ7kM94UiDCxvpTR4/J13cXsY6I+j2T9OgVHal/polLhuY
         wFu+FepK22CYrz4aq2SnfQEq4ilvfAYFplQb5Yq5LeLtScY4SUuF/5zK6AGnyDyb15/G
         qspgsrOENGANrfZNV3V3n2IBd2GxDfifWydq/8PsugbUPlrNxT4+y4gH8L2NXvaZyliA
         8uqg==
X-Forwarded-Encrypted: i=1; AJvYcCW5zIgeXr9tPNNHSxEtj+5Z2gncY5UKT4VIj0Rpukmb3CA1bLW1WLvuAoCkP85VD2tmAsyAPHS3uDBmn2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9GoXyka8f0ksv6j0Hv5cgsfcnFrJlcfHcSZSSAKG0qbCkqSq
	UBvh+tUWbSGDwG2uoru7uaXJDqxUtyVLYIkZ9ZInqlLp3aPCPJUCpDzP2jmmOlV4NlTSPe06jo1
	J0B5uRzZZ
X-Gm-Gg: ASbGncvViX/ZpZxNsEcTEvXHp6i7kmnrPugw/yjkStvk0YcgejcCZRgG2MIaJBO2gK/
	BPFXywEKqoqQGifFNAeJ6nuUAlez0AeriPTIq6FierZXKgtrvLyOBbQSWd/ZzS6tib1ifygE/qN
	6dX2+u616RjmdATo9hiUc3xoZM1XEF7pQQkcETDt0fLjYTAQMm5CI/wSBe3llxe2ol/IIoyjLJj
	LdyGLnYhMAkt2apmXfKKZhU44eNqgQgCqTFfScH5SDUI/CgZ9A69zUo2AFF4LhMrN7Vw5zPCB98
	EDfHbI/YgjF4geOuXhosAnlnfwWGvFEhuylnfP5XFUwIOncPxgLulbyFRxBLE5bEyK+LGBpjfZl
	Y8T2pcWYwpl01QifC/Ig=
X-Google-Smtp-Source: AGHT+IHvVi81p/Rk/iKsuI4Sf5ylhTMG/fpIOEuvDqD2PYyARqT+UX/5mT4PVlT7wJ/l1iR0NOi6EA==
X-Received: by 2002:a05:6830:2a90:b0:745:5450:b4b1 with SMTP id 46e09a7af769-79151de5e62mr240399a34.19.1758581337997;
        Mon, 22 Sep 2025 15:48:57 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-78780383017sm1167244a34.37.2025.09.22.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:48:57 -0700 (PDT)
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
Subject: [PATCH v3 2/5] scripts/make_fit: Support an initial ramdisk
Date: Mon, 22 Sep 2025 16:48:29 -0600
Message-ID: <20250922224835.1918759-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922224835.1918759-1-sjg@chromium.org>
References: <20250922224835.1918759-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FIT (Flat Image Tree) allows an ramdisk to be included in each
configuration. Add support for this to the script.

This feature is not available via 'make image.fit' since the ramdisk
likely needs to be built separately anyway, e.g. using modules from
the kernel build.

Note that the uncompressed size is not correct when a ramdisk is use,
since it is too expensive to decompress the ramdisk.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add a comment at the top of the file about the -r option
- Count the ramdisk in the total files
- Update the commit message

Changes in v2:
- Don't compress the ramdisk as it is already compressed

 scripts/make_fit.py | 52 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 0f5e7c4b8aed..984371f505bc 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -10,10 +10,14 @@
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
+
+Use -r to specify an existing ramdisk/initrd file.
 
 Use -E to generate an external FIT (where the data is placed after the
 FIT data structure). This allows parsing of the data without loading
@@ -29,8 +33,6 @@ looks at the .cmd files produced by the kernel build.
 
 The resulting FIT can be booted by bootloaders which support FIT, such
 as U-Boot, Linuxboot, Tianocore, etc.
-
-Note that this tool does not yet support adding a ramdisk / initrd.
 """
 
 import argparse
@@ -81,6 +83,8 @@ def parse_args():
           help='Specifies the operating system')
     parser.add_argument('-k', '--kernel', type=str, required=True,
           help='Specifies the (uncompressed) kernel input file (.itk)')
+    parser.add_argument('-r', '--ramdisk', type=str,
+          help='Specifies the ramdisk/initrd input file')
     parser.add_argument('-v', '--verbose', action='store_true',
                         help='Enable verbose output')
     parser.add_argument('dtbs', type=str, nargs='*',
@@ -133,7 +137,28 @@ def write_kernel(fsw, data, args):
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
 
 
@@ -274,6 +302,14 @@ def build_fit(args):
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
@@ -296,12 +332,12 @@ def build_fit(args):
 
         entries.append([model, compat, files_seq])
 
-    finish_fit(fsw, entries)
+    finish_fit(fsw, entries, bool(args.ramdisk))
 
     # Include the kernel itself in the returned file count
     fdt = fsw.as_fdt()
     fdt.pack()
-    return fdt.as_bytearray(), seq + 1, size
+    return fdt.as_bytearray(), seq + 1 + bool(args.ramdisk), size
 
 
 def run_make_fit():
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fita3

