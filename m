Return-Path: <linux-kernel+bounces-843570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B422DBBFBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4743C1B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B99227EA4;
	Mon,  6 Oct 2025 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N0a+XvsU"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593182153EA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791780; cv=none; b=Pfvdv9kUfbxXS9pmjmPQTS8jf7GFVZfDfZJjfsApRL0q1pYf6CFRBBYmA6KVLcQOaiBgs+IB4FRvdNIyJj9FWnCXDBRwTQV4ZmBORd+LvmZmdlFblC2g3Y9TEl5kquakgP2K8U42ZaTjQ8s4rfCjveH6HvYPp/NFXab6Q+T9ai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791780; c=relaxed/simple;
	bh=iRwr4aWqYl4kIwimtlljRUSeu5ezG3oP5PG69wjW44g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDFP2whg1XhHzjTUiqotT0slT183Y0wgMtR4CBmsV7AvxPOmti4vr+4BBF4QV4UR3wsF2S0NaALqzH65o6L2ypeGSul3eae36fBjZNOeFXcQqvAJAVoeUqIIHjC8CYSXoSoiCOBd2dCZaUgGlbFRtKMmFnNQEDCmzyLKaTJrJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N0a+XvsU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42f05cbc3d1so17609485ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791777; x=1760396577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b318BeGWA3r29XTQ0vNTU6rijD9/dIK2iMOcNHHPjBE=;
        b=N0a+XvsUkqx7r+lxqvMehweZPQ02EQGTxsWU9qLOUyhvvIfDAwJQwQwo7xDPODHels
         GFB5e/Amr8+JkETntJ6MK0Y3IeFJpYkmcc8I5l3vvv9Z7HpuVKe1quXgzbLNfbyuo/bJ
         LQET3qr/PfskCg5hIUhFUtB3C8t/P8RjTlSXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791777; x=1760396577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b318BeGWA3r29XTQ0vNTU6rijD9/dIK2iMOcNHHPjBE=;
        b=YwjCgb5bCBfoSwVnOGgg2R3XU4sQYIDXyuvWxnAyhFeGpK5u8GhLmF9k0uXTCkP58r
         LDarytLrXYJ6ytzdIz/p0aJC0pZqt/5qHLPDAhbdTq6VK5NMqw/y/k16DRjPS3GjrVCV
         ldAunOS7pWxKmw9WRnYmD3MCXuHn5GTaRLy84bNZoAGHANZdLiCIueX9QFihrdMurjl6
         cV3yDzkZ2ScaKFh+EOuqi9itTiv83yislJ4Wf2h6Ca7Gk/1+hRgJ6+cWoFHUjOGTsPar
         HFFvwxa1P4pJmYtJmimaakcIKLK5y3FQtgSEEQo5arnULN1T8mlkssz+YHrwR4H8pYGi
         +nYw==
X-Forwarded-Encrypted: i=1; AJvYcCUFl0BS7bSvD5re2KaLkpfw5Zwbb7MUZBqw78XXkj/TIbVBOlJGcpSRHKvesdNqCSqIq7l4NZPL72pra7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6aY1W79ZFyxsjf577X55uc/Bag96LRkLAT6nvE/ABd4RyI0r
	wLZ5xIHyfz5Uyx3q02tN/UjuwvLZoqvUgw6mo6db2DSB1IpFlSxJFTmI167/kObPyQ==
X-Gm-Gg: ASbGnct4YEBbegmoKuogyx6bOjXGxh+kXR6MxF5enEDVTPI00WU1j5u4S0EGI7W+gqs
	EbWjsNEMmVN6yg6q/BxXDvNLTyoUjRaMBumZq+c6QU9xiwlqhlZ4KNbuerKcoTLPKG66e8SvMca
	Kdw+3zPsGcog2KsFX2nCunqNUqASUXQHUKgHgfgM8F1V8gYBNj0byOeLVPXqG7fpSmf4zVeeoUN
	kzHGdJAa6T3wKVMgx1sU65zKlinJjArPPsuSf52vbm1J6FQncquiDnZK/KuO/uUSOd3jKEs+wBb
	1YTewmMz1i6iXgTTT/mpPsEFgr9Z3qBHOJ9m0vSo9FqDbuSB1RYMqhoV3UbX8hO3FofgHszj8zG
	HqAue3YLqNTho6Bq1cvEiohzT37yLcJHRcTxTsQ4q1ew=
X-Google-Smtp-Source: AGHT+IG7h6VEIrYxcywgIQo3xi3mnzcDBjSio3qPq2k9Vpojaaa/mhuStt80mORSz4TB5A7diQ4H6A==
X-Received: by 2002:a05:6e02:12c1:b0:427:215a:93fa with SMTP id e9e14a558f8ab-42f7c349cd6mr17245875ab.2.1759791777236;
        Mon, 06 Oct 2025 16:02:57 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:55 -0700 (PDT)
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
Subject: [PATCH v4 7/7] scripts/make_fit: Compress dtbs in parallel
Date: Mon,  6 Oct 2025 17:01:58 -0600
Message-ID: <20251006230205.521341-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251006230205.521341-1-sjg@chromium.org>
References: <20251006230205.521341-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When there are 1500 device tree files it takes quite a while to compress
them. Do it in parallel.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/make_fit.py | 56 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 10a040f4eb83..d1af496f3a57 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -43,6 +43,7 @@ as U-Boot, Linuxboot, Tianocore, etc.
 
 import argparse
 import collections
+import multiprocessing
 import os
 import shutil
 import subprocess
@@ -237,15 +238,31 @@ def compress_data(inf, compress):
     return comp_data
 
 
-def output_dtb(fsw, seq, fname, arch, compress):
+def compress_dtb(fname, compress):
+    """Compress a single DTB file
+
+    Args:
+        fname (str): Filename containing the DTB
+        compress (str): Compression algorithm, e.g. 'gzip'
+
+    Returns:
+        tuple: (str: fname, bytes: compressed_data)
+    """
+    with open(fname, 'rb') as inf:
+        compressed = compress_data(inf, compress)
+    return fname, compressed
+
+
+def output_dtb(fsw, seq, fname, arch, compress, data=None):
     """Write out a single devicetree to the FIT
 
     Args:
         fsw (libfdt.FdtSw): Object to use for writing
         seq (int): Sequence number (1 for first)
         fname (str): Filename containing the DTB
-        arch: FIT architecture, e.g. 'arm64'
+        arch (str): FIT architecture, e.g. 'arm64'
         compress (str): Compressed algorithm, e.g. 'gzip'
+        data (bytes): Pre-compressed data (optional)
     """
     with fsw.add_node(f'fdt-{seq}'):
         fsw.property_string('description', os.path.basename(fname))
@@ -253,9 +270,10 @@ def output_dtb(fsw, seq, fname, arch, compress):
         fsw.property_string('arch', arch)
         fsw.property_string('compression', compress)
 
-        with open(fname, 'rb') as inf:
-            compressed = compress_data(inf, compress)
-        fsw.property('data', compressed)
+        if data is None:
+            with open(fname, 'rb') as inf:
+                data = compress_data(inf, compress)
+        fsw.property('data', data)
 
 
 def build_ramdisk(args, tmpdir):
@@ -366,6 +384,11 @@ def _process_dtbs(args, fsw, entries, fdts):
     """
     seq = 0
     size = 0
+
+    # First figure out the unique DTB files that need compression
+    todo = []
+    file_info = []  # List of (fname, model, compat, files) tuples
+
     for fname in args.dtbs:
         # Ignore non-DTB (*.dtb) files
         if os.path.splitext(fname)[1] != '.dtb':
@@ -377,11 +400,32 @@ def _process_dtbs(args, fsw, entries, fdts):
             sys.stderr.write(f'Error processing {fname}:\n')
             raise e
 
+        file_info.append((fname, model, compat, files))
+        for fn in files:
+            if fn not in fdts and fn not in todo:
+                todo.append(fn)
+
+    # Compress all DTBs in parallel
+    cache = {}
+    if todo and args.compress != 'none':
+        if args.verbose:
+            print(f'Compressing {len(todo)} DTBs...')
+
+        with multiprocessing.Pool() as pool:
+            compress_args = [(fn, args.compress) for fn in todo]
+            # unpacks each tuple, calls compress_dtb(fn, compress) in parallel
+            results = pool.starmap(compress_dtb, compress_args)
+
+        cache = dict(results)
+
+    # Now write all DTBs to the FIT using pre-compressed data
+    for fname, model, compat, files in file_info:
         for fn in files:
             if fn not in fdts:
                 seq += 1
                 size += os.path.getsize(fn)
-                output_dtb(fsw, seq, fn, args.arch, args.compress)
+                output_dtb(fsw, seq, fn, args.arch, args.compress,
+                           cache.get(fn))
                 fdts[fn] = seq
 
         files_seq = [fdts[fn] for fn in files]
-- 
2.43.0


