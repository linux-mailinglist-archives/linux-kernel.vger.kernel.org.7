Return-Path: <linux-kernel+bounces-843569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB11BBFBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8113C5011
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAC2264C9;
	Mon,  6 Oct 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RDwkfA7k"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924822156C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791777; cv=none; b=q4oFey5NYx778cQF7QtuaHR0BH2QgHivHKgNUecrV0jxh//cPcdNVZP2+W3M6Ec3u+xZ7EdDZ9qNxR5O0CjVMilNJySoH6dZAgfPsqRrKSw0u3hXdsBJPhEKljKD5eAs9zpdqRcKZC38tSib76XaHTfy7X7bfN6881q0KzyfwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791777; c=relaxed/simple;
	bh=8ZGGs3PQhqVTmNk+d9LVkL248C8uJ8HMmqu52Ln87QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0CuOqCy7jeGJXGLGYyz7XmrCTAUg0/he0+N7rCGxz+gT5GejAnxMdAj5We3gzfDjDrqZ4XfLKjVTgStFNB2asxpNeeoFjOPCnhzDinj1NUrvA5KdBBJDjd26COGmGk5KWAENWQzNqau5Ggboogs2/A1DvlIMfiYorgG8Po/Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RDwkfA7k; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f67e91ae7so27959075ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791775; x=1760396575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuN93K9Dcy3JOdIK4h07lOL7a8R3BcxISOfJinfzFRA=;
        b=RDwkfA7kO8rkaJi4BCk8yLzklLnDQm7rs+mEHKUQ3oakCArL1+vkcukRpuuX5V8wWa
         UukqT06Tg3Q46lZGpfWRT5lSaL5+JR1/6DbLuw33t1eLO27WcF3OmEHPjZnIaqAl16fY
         oXjVF4HUYFiec4oVGN4chNqVHif+c6HEe4vrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791775; x=1760396575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuN93K9Dcy3JOdIK4h07lOL7a8R3BcxISOfJinfzFRA=;
        b=ngJEMWoqgYoq46AYJnb8VZTmYZxEt1EJeSbgWF8nCSzHgKUeSbhswDMkpA5RT4wxdI
         6O8hTD6CrpgDqqN9pANjiYIYiOk5U55FZzt5pOD4tBZNk36JrItYjTjAatO3ViWHFydr
         uDhKCDDyLFq9MZbIXBCq7A+pWesVH2gKqfyjmnk+VWtnSg/ghzqBzl5QRgaJaevug1mD
         AVA/LZpyueRRoGgzMUMz2IAmsKczZIHCoAB0coHMs0N2pCqi4hEdNEUC6pW0dZ+uAWIC
         +Oeso4330YHLYXJ7LZ78jz20/d4LbCsWC228KW0m74iWcIz4/1kujjYlrwL1eD3C1SHB
         9Eog==
X-Forwarded-Encrypted: i=1; AJvYcCWomF7hpGsxXNlemfqVIgDlaZMZ1/t2sZz/Sc/r0nc8InR9GFwLBNK2hsPFldzCqR/dGpFqtmKo6NqyMm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKUjWEF3EneGKqEOYontjgkvzmJ85OUNhuzeoFCMvduxWY9Vq
	dKoPl4OQokToqcx15Tm8o+FL8Ddm7KdkidLhfC8w3Dk7iHiMuVGekbZaEDIEX2sjfFOZUVhQ6Mw
	bKXktwA==
X-Gm-Gg: ASbGncuOu0GnIjgD3MAl055FGPpxvsKQIU/T9phGz5hV9/2EAv/4xAYSnvdSHCVPOpH
	9Z22VE06rQiFAh/baS4o7hiXqWRP/ZzG9Tk/XH0gnGbJZ5F7Z8XDA3aDwYYA3Nm0fxaL9BVWgpm
	bhPvieu3ZoedTRq5B7cY6XgKKHPiFJgQT8BflxiJPEr2ygKDXe12k0MDRGqPRchcaKrWEJOabmJ
	ikhvWju72BeZDnbUwYuXHIRrwZ4Dxy2Lnmgo1DeGSfN6agVZlm0pRtfrh0yHGihhtVpcb2MwKu3
	n1y3fkd7DP2kgMYaSxK1aZU07uJVnSe5akJVJvgvfdnSQd0IqoN0RRM7QEKD66krLWGRTo1c9bm
	aMoXX9f9ZkyV6OoBUKOJ9bTtc+rASBnjUgT0sbGJ5b5s=
X-Google-Smtp-Source: AGHT+IHSrmzWbWKM4UXhJ9zCemfI3AXTkSgm4z+CxyCTVL+PvyrUOX4Z4dhsZa1vuM2vjJ4J/tIMig==
X-Received: by 2002:a05:6e02:1fec:b0:42e:7598:73eb with SMTP id e9e14a558f8ab-42e7ad9cbc8mr205043605ab.23.1759791775171;
        Mon, 06 Oct 2025 16:02:55 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] scripts/make_fit: Support a few more parallel compressors
Date: Mon,  6 Oct 2025 17:01:57 -0600
Message-ID: <20251006230205.521341-7-sjg@chromium.org>
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

Add support for pbzip2 and plzip which can compress in parallel. This
speeds up the ramdisk compression.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/make_fit.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 3db129f40b20..10a040f4eb83 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -57,10 +57,10 @@ import libfdt
 CompTool = collections.namedtuple('CompTool', 'ext,tools')
 
 COMP_TOOLS = {
-    'bzip2': CompTool('.bz2', 'bzip2'),
+    'bzip2': CompTool('.bz2', 'pbzip2,bzip2'),
     'gzip': CompTool('.gz', 'pigz,gzip'),
     'lz4': CompTool('.lz4', 'lz4'),
-    'lzma': CompTool('.lzma', 'lzma'),
+    'lzma': CompTool('.lzma', 'plzip,lzma'),
     'lzo': CompTool('.lzo', 'lzop'),
     'zstd': CompTool('.zstd', 'zstd'),
 }
@@ -220,7 +220,12 @@ def compress_data(inf, compress):
             done = False
             for tool in comp.tools.split(','):
                 try:
-                    subprocess.call([tool, '-c'], stdin=inf, stdout=outf)
+                    # Add parallel flags for tools that support them
+                    cmd = [tool]
+                    if tool in ('zstd', 'xz'):
+                        cmd.extend(['-T0'])  # Use all available cores
+                    cmd.append('-c')
+                    subprocess.call(cmd, stdin=inf, stdout=outf)
                     done = True
                     break
                 except FileNotFoundError:
-- 
2.43.0


