Return-Path: <linux-kernel+bounces-827948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26CB9382D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87041905579
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8042ECD15;
	Mon, 22 Sep 2025 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBlpV3Ez"
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B72246764
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581338; cv=none; b=joaQ2/cLL/A0ZHN+uAOGCtaDlqk7OH3hLhyUtDakEpR92Hc6wnkB9n+WgWYFS7LbFVKaRSaDN59iKA2/kcJMf3Vv94tDk5ZHozgwetiKtAHRDwAC10c6OrStMVxbQvzuiHLVUr8SPIqbyP7SxmLLPCMrp/hkhVMKAKFFbMdnf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581338; c=relaxed/simple;
	bh=+G0yMt7ZYHQ9CzcgiBAbIhWwTPIiIuTTWoTXPMzT7jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GE3Vb9S1irRCksd1RSGaWwYV46/DNzISyIVclB3KAhqslcJaq5ql5fT3fagH1wB6pRzzUwgXWBjlzeeUMTou2cUL8i/GfCrmmc1p3kdcCIK/3AlUvsndtGF5Q+HBU1oqdKBmwHyj1NWm2lDz6Mxm9Ih14zIL7Yj/kBl2pN4sGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mBlpV3Ez; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-30cce86052cso3851326fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581335; x=1759186135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWmEChdpxrErFjVsn3V3ZIGQaGqnJGr1o6tiOdOzI5s=;
        b=mBlpV3EztcoT1D0yN5ri+wZYgxraXvFxllqJ16lQZQBad4tCH4/a1RYsxD4P7Au24h
         SSNATjS7KCGbE0h/CXVp1mNCmxLYYvbFDInDn7he9WLvvllN/qx9J9hyWe0xzp6oOdPN
         MiQ4lgOL2POBrICa/AR81FefevwAwyYTQg5nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581335; x=1759186135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWmEChdpxrErFjVsn3V3ZIGQaGqnJGr1o6tiOdOzI5s=;
        b=ZcWtXDWzS4ErqtYjFGlYuSBVoT9n0spzYvrcTZfkhOOqf1RSIBckPEjfshTAkJgLc3
         FOv3GJvWoDYhmh8jLclOg8l8yTcWgOl0ksBxCrSTf65ibc+TdXMaPjZ03wVG9wxsiIcS
         /K5qogdZ8XxZop+b3+ie2YN3FNVG/q9G0htQQa+5Ng7DjeOkJAoIV3maWgkM/4kROKDa
         XKKcTztCsl/2M/aLfMsl9N3y5LOtG99XEuMxtQrs5fqydeSdbbRsZE8X96O/9ANw/EML
         3xw2VPN2q9ZTu83MMAGTr6f4cwCD3XW8ehXj9D8Irl/sAFR61fMumdAsI7JQHf6Zt5Ci
         CvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLD+Jphowm/8GTBwu7hP6AEGp/a55jOCIJ/qu/oFGLYSDIXqurAoYWyHKOF8UNW2Y0c6gT8bJ4sGXUsTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiZ3BNdVgT8JW/7GiiTVXK2fJyV7bYnS7mTp8bcDV66f/YpG2
	VIdqWcJ7PDtAxcIil+x7F8qE42wfu3w9JczcH0p6poNaDkrFrQFQx6QXm75zfs+3cQ==
X-Gm-Gg: ASbGncvIVrjYGutYWBPQ+/g02GHQAL3+vmFep4pk3i5qdUhX4DWcJnv7gsGihXHnQaI
	tpRjjI8XDhlFO6LGg2vTcvtmkYojm223Ds7rXwYM/L1ZswPjcKC0mnOX2rrvNsmKFHGo4VaTuoV
	HEE5OLn1Z/n5g1NsI5YTUlTE7nIlfJmtaoCQtAruPMfvbBatFZWu1gDjgVAIouToFV1vcLQr/lP
	1zLQtkzNq6CAxOOcYs2s9FPjuiXc+94FDt33xd1CRwMKTGWxvV7cQy1L5scXgIYNuIkZFaErAyC
	THm3ifNzYO7TyYdjbef3+XcuCZsJEFPgdjlsyJnzip5GVxqiBR40BKaDOSEqOv7BfIFjSTY68w9
	KvwcF1AprrCvUOlkVDRHVLi+RRpYNXg==
X-Google-Smtp-Source: AGHT+IHk03TiuVfvlVnwklNju8cnHVtFH0Gbcp+nf3/MfCBK3T7FJJbepFKpUdFIDYDjJpSQH8vCBA==
X-Received: by 2002:a05:6870:96a7:b0:319:c5ac:c375 with SMTP id 586e51a60fabf-34c73100e06mr307739fac.10.1758581335591;
        Mon, 22 Sep 2025 15:48:55 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-78780383017sm1167244a34.37.2025.09.22.15.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:48:54 -0700 (PDT)
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
Subject: [PATCH v3 1/5] scripts/make_fit: Speed up operation
Date: Mon, 22 Sep 2025 16:48:28 -0600
Message-ID: <20250922224835.1918759-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel is likely at least 16MB so we may as well use that as a step
size when reallocating space for the FIT in memory. Pack the FIT at the
end, so there is no wasted space.

This reduces the time to pack by an order of magnitude, or so.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Move the ramdisk chunk into the correct patch

 scripts/make_fit.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 1683e5ec6e67..0f5e7c4b8aed 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -98,7 +98,7 @@ def setup_fit(fsw, name):
         fsw (libfdt.FdtSw): Object to use for writing
         name (str): Name of kernel image
     """
-    fsw.INC_SIZE = 65536
+    fsw.INC_SIZE = 16 << 20
     fsw.finish_reservemap()
     fsw.begin_node('')
     fsw.property_string('description', f'{name} with devicetree set')
@@ -299,7 +299,9 @@ def build_fit(args):
     finish_fit(fsw, entries)
 
     # Include the kernel itself in the returned file count
-    return fsw.as_fdt().as_bytearray(), seq + 1, size
+    fdt = fsw.as_fdt()
+    fdt.pack()
+    return fdt.as_bytearray(), seq + 1, size
 
 
 def run_make_fit():
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fita3

