Return-Path: <linux-kernel+bounces-843564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349FBBFBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEFFC4E85AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1996921257E;
	Mon,  6 Oct 2025 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bosDa8xB"
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2A1DBB13
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791768; cv=none; b=O5mf9dgJP2UmDodsBFPe4xLD7M37b3PQL+OC4L1CQlc0qXsC5SlS6QlO4+CkCGnaebN7iVY/sCOuGC7k+ASWIMbVUyq4HGiq4Y1YZP8SVcey7RGAgF6rqF/8QAe9BBxOGUKHuQfrM3kEjdcRYaX7lyhRF+8EKbiErqU9eV1pvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791768; c=relaxed/simple;
	bh=v1IOMxuClhNtVj5VjeVsxIX0foETUgX8qoVEvIYumzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpHm6kOPS5gM7kX1leJhGkpVoSeHYCtLHAXnRrIfCEDO9RZWNbCgAlKaaKk+zMCoXz046nb8YH/Iz1/60ibDtbfOlfIuwJenm5rgdWJO6Hfq+cRImXYAdA9vqukA1yRfB6BhBxS7menhAom/USLoR/HnA+j2MhHvnhpic9KYmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bosDa8xB; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-91122373653so233701839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791765; x=1760396565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/GhgyUTJVSqf6jn50N7qbJFCmaZJonK+/mIvqtdKlw=;
        b=bosDa8xBRm5I87c7h+Jc+AuJDXOMR1yfg2vIGZp+axmNLBz4XMiMzeqjnIjQ9HWAPs
         ms2l5K1W1PVXoebKxUPo1SrdRt5f6tBcbV6vZgj26qi1wYjmO1AZgPOkCrXA9eYGEdkt
         YXLhrmhKJ2y7eATtfiep/OV4rwmzIHwqobGgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791765; x=1760396565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/GhgyUTJVSqf6jn50N7qbJFCmaZJonK+/mIvqtdKlw=;
        b=i4hXHZyyEEBjoFBJYBaaHCGCfLvkI04dNmQ5AYTnDYAfdW2qNSib82nTA1xZ7wsnyr
         2lZuQd2fxdCbVAv7y2+BjTyQbAEsm9xJEX1r7Dwn9R0BySoTJVxtnShhE47IWG5Ix6l9
         tWuLOrb23vr141axdFtlDQMi3pPP8pqzHJeOs+TUpbyi+cCcuR3rqYsX7HaSfTfglyx8
         RLRMOAbdEe3ULDAcCyy1H862VntE5dXXNAY25SBTb5+YL604whBNN5+99cQJggr9yLrd
         EBaq/9uuzPgjl+Lxv9dVasNNIt84Po17ef2gi0B0lz/Nh0fbceCUhx+EkeEbZFCx9nkd
         UuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQRHNY+yvx5mmZeq5z/Rk+NmaGYVIp0kW7n2BDI1cdMMdW8HhVfDSl6t+CpW7YUooZbWJy668+94MuK68=@vger.kernel.org
X-Gm-Message-State: AOJu0YybtYSZSxruCR7d7S+RwdkP93/i7202ifkMQ5yF8F9KonOcRley
	hvk9Ee9umX03kldooTs1nTKqCca4wKkvv+EIx7poesHc9aLkDcCpnUOtA6tAfQcDLg==
X-Gm-Gg: ASbGncu8xf0Pws8Qx9QaHPnNGb9PAkFHJat4AzGMePgYYFG01lvRoBzo543iUIRyvOo
	3Gx7BgrVO+K2QHOFj5/s4nitjvK8DWi0pjv8i8SIRi14nY8+uThMe7/KLn8q/5WxnztjIw43yhK
	lh96je4SwDjqnx8ztYPR1Uu7w2IFUT2pRH2ULB+5MgYSCdbUUUUsWXLl4ggy8PjQPUZfTi94qTL
	076GnoT4E25DhpXv7qHp7JKScTKAS4f73V6prPsxt4eReIFBWcXRwPs9h8HjukQIZYhRdC1AFh1
	3Bc7jJBQAH2WkZT2a/y7jakGGZS2LVjsXUHdUaog1a4VURSoiDT84LuHLLnja6DGef4UGrvXheh
	LXE5BE5jIAx3F6iY7YYy3Ob8UwQmWKMmEHZfY0MtdZIyxjZi360MlGg==
X-Google-Smtp-Source: AGHT+IEbnOK5MEZLn3qI/u/o7BEClgUIMh+Q50zXFLmPT5dUkz6tZ9h7Rqa5VCJPtPqD4jFv0BZZjg==
X-Received: by 2002:a05:6e02:2581:b0:425:6f0b:a1db with SMTP id e9e14a558f8ab-42e7ad16a3emr170806305ab.9.1759791765261;
        Mon, 06 Oct 2025 16:02:45 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:44 -0700 (PDT)
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
Subject: [PATCH v4 2/7] scripts/make_fit: Support an initial ramdisk
Date: Mon,  6 Oct 2025 17:01:53 -0600
Message-ID: <20251006230205.521341-3-sjg@chromium.org>
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

FIT (Flat Image Tree) allows a ramdisk to be included in each
configuration. Add support for this to the script.

This feature is not available via 'make image.fit' since the ramdisk
likely needs to be built separately anyway, e.g. using modules from
the kernel build. A later patch in this series provides support for
doing that.

Note that the uncompressed size is not correct when a ramdisk is use,
since it is too expensive to decompress the ramdisk.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add a comment at the top of the file about the -r option
- Count the ramdisk in the total files
- Update the commit message
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


