Return-Path: <linux-kernel+bounces-843566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F6BBFBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904AD3C3A33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBB1A9F82;
	Mon,  6 Oct 2025 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n+hJKmd/"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0F1FFC48
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791771; cv=none; b=rHT+AxLNV3sonkJbCoiAGz57M2nB6sIEVhYCmBaoQqAfYwa0BWoq9mplkGW07xsNJXHkVqasepEX8l18Zn/8lzXbbSBpPbfDa4I2aRkAmFLvT8gchZpys3mvlxlj1ZWlwfgnjuwqNnWHTIkFVVzF3gcSE7oj7D87xWcaJ/o9SII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791771; c=relaxed/simple;
	bh=s4qO35QXAyXHS7iu4deoUTEjbP+L9WOhAVecOqeS5go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y64LKWnVN2gYowbpDUcDJ0UmTXgVzg6z3JKwZMrHZPYIw+tLc527zxKoYP9ak0GRRJNc+4NxHwpcwLEbGG+kPd8J55tfeZjCSpllw7eSwhSgt+WDD5ROSg8ba1LfnvYJfDhvYdMgk8enT+1nDHgDP3rKI19BWNDl894qSS1xi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n+hJKmd/; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-93607aec358so131916739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791769; x=1760396569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebeC0cVyiB9zakr1pU6jmsWgTyhsnBRYHpTkJMDPkjw=;
        b=n+hJKmd/mQcXvX/TLw6KjnFj2VDlajHtsxvKIPDJEJzK7eat9qP3Tc3DqPxkKOd68I
         DEijL88H/cfv+9/lMah43o4DKJ0/6Thyv0E2KB2/nG19cEPJRM3Hm5ESJiGfvMwlATqr
         Lf9NSc9kmHFdERMEy5ApWmemHreYwoMSZgr1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791769; x=1760396569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebeC0cVyiB9zakr1pU6jmsWgTyhsnBRYHpTkJMDPkjw=;
        b=o5KgsUHsKFb24tnGc6pIw/nvLi+lE/+bzpT1GTMCVmfWmRhJessPmPpBZ2J5t3Yi00
         fCcrA0vxINYnzY/GBvM1yyhQsQMjLMmr/lG5Rqpai2RYrec8Cuwu7uoCYee8qCnNJ6PC
         2oRB9NmrHCO+3A+uqAmtUQaZaWc488E1CVIErCjLfTFSajiDmo7Cf3WD9Ly0G5KwCCwn
         hmYOuWrHY/O7e8F7M/1VQrIpqeFsW+S5EnVYrFKBKB3HPlpxA2MS4T3ofrnQT1nRWV9E
         hdZ/S36mXsZkNizE9Itv/9J+TU9Rcfg5fgNYXUEP1lQ5IYBH0i6H13JbzWBDugmbdyRQ
         GGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNj8dZ8/6THSWkCPXDBnoj2gTzPes1eU9WgSMeO/TiX355ND9UnXqWkZKZTkPKwcpb6olxCBwTfUjmNE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVdCHpagNMMAMIpO0Yroe1DNRfHY1DZYtWwTR4mZ1RLwcPfUy
	+nHtWNXNhRE3BK6UuBl6neggSNnUqpro/Zl0QKBeH9O+ODk2R8UzAdfsLOzAKetkNA==
X-Gm-Gg: ASbGncvt1bwv0LjR10pYYIQl9h6jGM8YKDKR5ltiyVHkw28IXt2PGEByQEo195bV7Me
	CCSKj5roXJui8XQy4Iy+XHVJhmOL3ItNaWp7U5M53qYAe5pnzGDZuDoHyMX/wNzVn/ooB8qsmPj
	rGKtRTeflQkkJ65cAfEcRBVff5FXGoY64zzstXSclDlFLFsrGgsN82G57QpA89J/+Ver1d8Ds0M
	lQ8ppHNAiJ517r/fluIR0TvEjZ12J8YZN32ZDHJ6lnOh7F47+KU3CyujqbU/GR6V6BuIad/iiHw
	SGp7DaYpFXGgX6nIGVtjtNHaqY7aY1xzGZ1CrIgn9+QyMa/vnniN4ryJmTXTg1fO54IrmrFDBbq
	h95eF3RBekhOFRHPVKN/lPRRoNOL8dw6C8bfrABdmmPdWdlmVpcp2aA==
X-Google-Smtp-Source: AGHT+IE9mdrAm5cg7BGAOe6wYDIg3l4Up+MccpLj79jTe3IHNt2jz5i4agbBHCXH73i/NIp8NWNZ1A==
X-Received: by 2002:a05:6602:15c5:b0:93b:ba4a:3b64 with SMTP id ca18e2360f4ac-93bba4a441fmr740270939f.17.1759791768428;
        Mon, 06 Oct 2025 16:02:48 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:46 -0700 (PDT)
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
Subject: [PATCH v4 3/7] scripts/make_fit: Move dtb processing into a function
Date: Mon,  6 Oct 2025 17:01:54 -0600
Message-ID: <20251006230205.521341-4-sjg@chromium.org>
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


