Return-Path: <linux-kernel+bounces-827950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE60B93836
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AEB19084DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF773128C4;
	Mon, 22 Sep 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOSHkyp0"
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3163126D3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581343; cv=none; b=lyhLwEt3dyCypl6PB+YcaE8GvzpyQhFw/ypNYl97YULTUWJunYunyYtzEOR4XJqjn1+ywuD1SqhAdL5HVaWIL+v6Vb0rBq/e56FIje8XsDBXAoHeVxw3F+t+2Tm+pxs8JPxmUQ/CZQ68zUo2W4bfpbHgT5su99DiRB3IwlOgy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581343; c=relaxed/simple;
	bh=2bP2bmIa/38woZ4z5iaHmvubt9T0ANJaeBITzlz1IeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibFRzH792rjudKIUx5AFWspBqTQirGnFlCWCkDchjxagucCxbfVeXTKVRcOGOmWH/osok10px3rrqpZjSjNGulEk6dfmBz11wJUhF6AQoAi9jgx8yOB+5yGNb80BJYhyHIB+SjmKqaz7ieg2Hh03zC6g/lK6tOPHxNc0z5o0PLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YOSHkyp0; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-78807cd2236so738945a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581341; x=1759186141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOXwCCejcKBrIfA4NCnEQXNnW7uiwgmDLBOmUw1NLdk=;
        b=YOSHkyp0MkFLWuE0vPI+u2n2koSEsooMXYiwlVNE4fQknu9aDk1qV6xwyBRGKnr6P4
         uddXZxQM85O24rT/ALVJqImeNJoSEtUJ0EusShQLx5yk4OrfwDG6tSCKOgLf1Lfx13DW
         A/wGLAn7qKnmb5OyoLn89x0jj4ay7ddbBhly0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581341; x=1759186141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOXwCCejcKBrIfA4NCnEQXNnW7uiwgmDLBOmUw1NLdk=;
        b=S8ZD3OHKSXamRVCTIS8JPMTMx/eQGZlTKiUw3D303dY9TRIibLgq2BztxKCURe8IK8
         jpfka3U1Hmgddyte71D7qFZ9DmxuMTxdAuSnax4PQ0aUHeGoji1j5XGL0vN8LKQkG3F7
         9LQvC79EJYA079qMXmcelQ8bOKzwA5dROMpVTX0f0ZUOANOW0fYdMrIx6x8b9wIQ9kbq
         lkax2mEH6fuhiMwMn6swaA+fAqiqQTwnZWruswX5KRxMj/4te1EeI4+wnikQJex06Sz5
         IPheegHOI+y/Hgjx1dTBUG5B0O8tkrOTdRIGENbKv/3g5PIaRG9U0Us3ufiUJnh9/4I5
         t5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC1v8LmW6Cduo8rVRPTEhoYSaUnYegmlboe1uZ4qAoMnFSFdzsH4BHDICbAYkxrOTm84aYlSUZhdIB/+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YznStt0XMmgpFfx7mQmr7kyADkGnCiLzi73V0t4C4qs16WZUOFW
	zFM6Kue/KotH8tb5vNRU9pbffdLNrUHYWz4Y78pymemYploVKFUrkAm9tFp356+XWg==
X-Gm-Gg: ASbGncs+19z/oKHXiNpVKm/F7FfT2kHYYgTuRIwSmKrcwTml+l6Q9U9bs5VOhHNNOMF
	ID+fRHdhVd9kVVh/RXrGtGZn8Ag1IrCrC5tXRSBwpyS1AAQudFu4PhbESbL8Et93BdAJHQfZ97m
	wQOpUcHZC9MjiLu+lltesQxAej4X1pQtyj2H7hX9BUw4c8HyQsUuQdHrOJG/qu/Jthw31n13Awy
	C70Pma1278TnGHKHaokylq3NT3pXYzMx4pBOI+4VQ06YXMKNmVEu+D4452+9vesTyKHlNffluPC
	neOJ/U07ltgxjrwOnuPlBYVgQj4yqb8EK4/7+ORrvsOr2btXP3LsPAJFtn16vs6wzckydgqmJwV
	bW/yut8T7QNvOQdncq3c1faedX0218Q==
X-Google-Smtp-Source: AGHT+IH7aeCy7V7yxeefrZ+BQ98k0yxMlTaw4kBkTCoAqDx66tU/rITeRorM6VHTncpvp1L7tlw3iw==
X-Received: by 2002:a05:6830:25d6:b0:753:7bce:64f0 with SMTP id 46e09a7af769-791472f7aeemr292744a34.3.1758581341059;
        Mon, 22 Sep 2025 15:49:01 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-78780383017sm1167244a34.37.2025.09.22.15.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:48:59 -0700 (PDT)
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
Subject: [PATCH v3 3/5] scripts/make_fit: Move dtb processing into a function
Date: Mon, 22 Sep 2025 16:48:30 -0600
Message-ID: <20250922224835.1918759-3-sjg@chromium.org>
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

Since build_fit() is getting quite long, move the dtb processing into a
separate function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/make_fit.py | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 984371f505bc..1a74a9dcd85e 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -277,6 +277,47 @@ def process_dtb(fname, args):
 
     return (model, compat, files)
 
+
+def _process_dtbs(args, fsw, entries, fdts):
+    """Process all DTB files and add them to the FIT
+
+    Args:
+        args: Program arguments
+        fsw: FIT writer object
+        entries: List to append entries to
+        fdts: Dictionary of processed DTBs
+
+    Returns:
+        tuple:
+            Number of files processed
+            Total size of files processed
+    """
+    seq = 0
+    size = 0
+    for fname in args.dtbs:
+        # Ignore non-DTB (*.dtb) files
+        if os.path.splitext(fname)[1] != '.dtb':
+            continue
+
+        try:
+            (model, compat, files) = process_dtb(fname, args)
+        except Exception as e:
+            sys.stderr.write(f'Error processing {fname}:\n')
+            raise e
+
+        for fn in files:
+            if fn not in fdts:
+                seq += 1
+                size += os.path.getsize(fn)
+                output_dtb(fsw, seq, fn, args.arch, args.compress)
+                fdts[fn] = seq
+
+        files_seq = [fdts[fn] for fn in files]
+        entries.append([model, compat, files_seq])
+
+    return seq, size
+
+
 def build_fit(args):
     """Build the FIT from the provided files and arguments
 
@@ -289,7 +330,6 @@ def build_fit(args):
             int: Number of configurations generated
             size: Total uncompressed size of data
     """
-    seq = 0
     size = 0
     fsw = libfdt.FdtSw()
     setup_fit(fsw, args.name)
@@ -310,34 +350,15 @@ def build_fit(args):
         size += len(data)
         write_ramdisk(fsw, data, args)
 
-    for fname in args.dtbs:
-        # Ignore non-DTB (*.dtb) files
-        if os.path.splitext(fname)[1] != '.dtb':
-            continue
-
-        try:
-            (model, compat, files) = process_dtb(fname, args)
-        except Exception as e:
-            sys.stderr.write(f"Error processing {fname}:\n")
-            raise e
-
-        for fn in files:
-            if fn not in fdts:
-                seq += 1
-                size += os.path.getsize(fn)
-                output_dtb(fsw, seq, fn, args.arch, args.compress)
-                fdts[fn] = seq
-
-        files_seq = [fdts[fn] for fn in files]
-
-        entries.append([model, compat, files_seq])
+    count, fdt_size = _process_dtbs(args, fsw, entries, fdts)
+    size += fdt_size
 
     finish_fit(fsw, entries, bool(args.ramdisk))
 
     # Include the kernel itself in the returned file count
     fdt = fsw.as_fdt()
     fdt.pack()
-    return fdt.as_bytearray(), seq + 1 + bool(args.ramdisk), size
+    return fdt.as_bytearray(), count + 1 + bool(args.ramdisk), size
 
 
 def run_make_fit():
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fita3

