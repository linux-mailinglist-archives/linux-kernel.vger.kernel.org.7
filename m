Return-Path: <linux-kernel+bounces-825334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339BBB8B95D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D4FB66F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80642DA768;
	Fri, 19 Sep 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eVEnIs3v"
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD762D6604
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322007; cv=none; b=EZbWWQfnZrcweqw60EZAAYVEFsb2oOTcsWw2D4XBJYUFHPWV0OKzvUQOgz/oUrd9Re+tR296S/py0lJzE7YGOpu5mGLRMsIov8PpdmfXbuKdSgFLaBq6hyO1xMhtUMAEEhDBCmbJSjSxOhq5IndmBtwUa5fBbN1e0UCDd6TLMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322007; c=relaxed/simple;
	bh=8Ac2KmiUNTVfgYQTullv9rQGbDIW4BgZgrv3Ix5AEIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lx7G1lt/LwLJD+RIIZiZ1J+muUV/ZJA+JJbG75EgCjThF4GIQuGyTXbA+X9R9JLnYQEdVTVJHlal1lcJBpNGXQV3Oy86SxkyLzgma1W6fJNrWKvIeVuCB83ctS1AUCJC4SGEtun5WE+kuPtKaD6rpspP6ZUy1XABQTavCkqoICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eVEnIs3v; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-42403719c73so26011665ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758322004; x=1758926804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOUTRe08GDoIq/W1AquA3toZQUYbeBtoJXoaHUUU0Oo=;
        b=eVEnIs3vmFp9blFvJ9tvPVyL+jGdNDI0OCYuMvgD3BayRJVN8T4yHv5/ZyWVrjzU1D
         ZP0Dc7dzA7CviErrXuSZ8d/ke8uTFPrF3wVVpmt82gEmFfUG72cIh6j3DQo4mz9w9xsr
         hLCzpb52kXgDE5uMqZ1GuY8abwj2M48+ympdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758322004; x=1758926804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOUTRe08GDoIq/W1AquA3toZQUYbeBtoJXoaHUUU0Oo=;
        b=a3XFeZhBNjoZzlyN24aruu+g12d9ZWSHhQOxCVAFMKQ2Tw12xocgF6US6r/zZLov77
         lzeeNvhuenA+b2IvXYjsmf60b6aW30RbetlmFawlswY9G2+sjuPIb+BK+HABDa0JSe2z
         F4/8giAhLFUgfze2cBmR5XlucK/vciDlPyhkyd0eH3Gy30zIcKkrpUCTxa4fcmbU9Z5I
         7A22Q3DSwOQ6X8vN1ggxWhELN6aKD66Q116p1x7cV07bZD1JZiXnM/TXJKg8f5gOiYq3
         x6W8seNq2o+COp1piD+GCytbk71fadwhTob3IwMhvQz4EjtxdbolxX058uUk6L84o7Wn
         MIgw==
X-Forwarded-Encrypted: i=1; AJvYcCWYuCK0VtAUUy5Ns+bGntw44RlqaeKEgG4nW96h+Yi9LwUTvbfs5UfmwWmr3ZL+AJn0t/nluu8VDaygccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9isAYdNSXmDUjjuF0Xcca/PA8Lv0+T+vrjs5+LJDloAvQNI26
	Ub8dHo9PsSle+Tj9wyoNrYQJMfx6z5BRXp8/G4JKKEo6tr8IGcixsrKpbULOoRu78w==
X-Gm-Gg: ASbGnctq4LN6ENwZI3Xz/UwHvja6Lf1wdZSIWux/PPD4BBzRIxjRVt0InnO9SEFXcNr
	aj/5rg49IJeZdLnJinyPVXzFrJdXO7d6ZdA5OwUoahX/U5lKC5hq8d5+ROzPVcv61uUe9gu8izd
	SPiFEmhtTV3eqNTHqezk3kLjA7nPqjyBnQzdVhnzwhZSdPHi1YQLBRFmodTTWKEU3LoRlbie8cz
	Jv6E3W7HRiEMkndZ8aR/lLJSDVVHkm1h9z7vVvogRtfAhXy2ycT6Veu4HsOLcMiQGbpxGSg1VRY
	alM0ljpzqV6mMIXkIO1fYTNeb/gsea2DCa0ywLtaUH9zoFE8anweZJW1m1oNXFru5jXaxRfS/Le
	kIcEhBTPrSSRKRxCG
X-Google-Smtp-Source: AGHT+IEdXiCfv9Gs62VtANBDE7YU4iNvacYa+DhnJGh2pRYvP680kqKeF9WUwtFdyjIgW7k2Eg5j8Q==
X-Received: by 2002:a05:6e02:380b:b0:409:5da6:c72b with SMTP id e9e14a558f8ab-424818fc559mr88377195ab.4.1758322004376;
        Fri, 19 Sep 2025 15:46:44 -0700 (PDT)
Received: from chromium.org ([96.79.232.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d58bed61bsm2581743173.82.2025.09.19.15.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 15:46:43 -0700 (PDT)
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
Subject: [PATCH v2 2/2] scripts/make_fit: Speed up operation
Date: Fri, 19 Sep 2025 16:46:25 -0600
Message-ID: <20250919224639.1122848-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919224639.1122848-1-sjg@chromium.org>
References: <20250919224639.1122848-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel is likely at least 16MB so we may as well use that as a step
size when reallocating space for the FIT in memory. Pack the FIT at the
end, so there is no wasted space.

This reduces the time to pack by an order of magnitude, or so.

Signed-off-by: Simon Glass <sjg@chromium.org>

---

(no changes since v1)

 scripts/make_fit.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index b4caa127d2c3..904f45088978 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -100,7 +100,7 @@ def setup_fit(fsw, name):
         fsw (libfdt.FdtSw): Object to use for writing
         name (str): Name of kernel image
     """
-    fsw.INC_SIZE = 65536
+    fsw.INC_SIZE = 16 << 20
     fsw.finish_reservemap()
     fsw.begin_node('')
     fsw.property_string('description', f'{name} with devicetree set')
@@ -330,10 +330,12 @@ def build_fit(args):
 
         entries.append([model, compat, files_seq])
 
-    finish_fit(fsw, entries)
+    finish_fit(fsw, entries, bool(args.ramdisk))
 
     # Include the kernel itself in the returned file count
-    return fsw.as_fdt().as_bytearray(), seq + 1, size
+    fdt = fsw.as_fdt()
+    fdt.pack()
+    return fdt.as_bytearray(), seq + 1, size
 
 
 def run_make_fit():
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fit

