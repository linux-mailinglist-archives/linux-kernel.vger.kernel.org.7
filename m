Return-Path: <linux-kernel+bounces-879980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D4C248BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCA4F191A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D8346FAC;
	Fri, 31 Oct 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNGIc+RJ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B134678E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907202; cv=none; b=bxM/FBAUO79MhEkvBkMvtoIbalBSBTLT32GsZCQjb4MQwj5MWH08i5iUbncA3V6nIQvZbblzzwn2X96FNV6+OlxBQSxocMk9YZ3K3yMx8qY9WXxQTltOgMeySQba5C2wfEvJI9KuSsWJ+noiTSg7gi4xcnMwwyXor4NY4WzhGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907202; c=relaxed/simple;
	bh=THSYwS2QbD5A2iM+nFKxv+UIHkNNGdsVXqfTT1Y2lNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=df3x0qwFQLfO2P9SkRnRh7NTxYyPlxoy4++YWiFdrRAQAXfKpm6kg23+sdC5vV5mwQLjh6IOFak5A7bG4jetbQVJobbgxUqAOxR5wKPj2Nhm5ax26ADL+MWadaIRStv/SxHnmK+afBCis7nXwVH6wJchx2GDgOkHTosJ5unZwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNGIc+RJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so15270305e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907199; x=1762511999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4s6P+Feh6QTHXx+j4+pZbRiwHHcjHTLEIbaDo5nXNow=;
        b=oNGIc+RJeI3rTUXbpxF3Xvix2wKvdyhFE0OHbhRhD+kgyAhdl7xVW9xaGjRQnXdV69
         clMpHi/i6EJxJQDLKJwqTgrEiSnEGX+iBlIWKxbB0cHwruqGUSV/Rm41zGpgTiqlqKBH
         LzHbJP/qa+gXJ1iR/AFgDvucspQXCCbvrMuYUreuWzE+3rpKss34rSxzq4yXOHhuVgT8
         jZOE09zlpZW4n8+3jP8duyvJ6CzmDXscGTu/3lMskuDKCdpp+K24ZpQUsvkgR8LsCgd0
         JkDHJuiPaNEQ4NOzgbHzDfK5oApTbpQgx/91joQTK+jEh1/wFDPn0sUPKiVHpfrAre7r
         Mb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907199; x=1762511999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s6P+Feh6QTHXx+j4+pZbRiwHHcjHTLEIbaDo5nXNow=;
        b=l412cbgEWhKsETvB9s85cpb8NbEwLQRmsTF0OGCQTtbaApvyUrtVgdjw45Hn3dkgxI
         y9DHXwFJkR5Z2jI8TvmaJhcZswB93k8I5o0ZTbPyiRcF0MLWksl8Uc6/1XhPvTm5FzSw
         GcLp2dBP6Y81T2JbCC2pGLR5XeMuLMrdJk9UAYSIGNpjBLSAFLxflWGm1OZtFtRQHKnk
         Bzrc7jqGpU2EZiRO4y2YABdBiYpLr9fYCFnR2C88fdK89DyVRKpVqZAkDypdkGyFhqO6
         82N0Uq4P/N5gmV35n8PpNJKmzyaPkXJY6fwBIykZRz7HZ7TG6sMjwn44kPouyebCw8zZ
         vyfw==
X-Gm-Message-State: AOJu0Ywne8GzsRTb3Qn2Dd7UVHU3vM9pf5UJ7vZpQP+sALkcgu91Qe1K
	WMEC7jBwyNeyVITaiMFMYG9VbHS9fR17qG5Zi7at2fJToTuFwU50FkXGoZqOEEYeYsInj3f1Ew=
	=
X-Google-Smtp-Source: AGHT+IEfIHxmt0Akn8ZOdGgYUmWAojffoRFxXG63QnY50c3838BNl1o+lCSGk7AdLGAKU776OVcmZYAl
X-Received: from wmbf23.prod.google.com ([2002:a05:600c:5957:b0:475:d8ac:bbb0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:190e:b0:46e:3cd9:e56f
 with SMTP id 5b1f17b1804b1-47730802ca0mr29236185e9.6.1761907198711; Fri, 31
 Oct 2025 03:39:58 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:12 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=ardb@kernel.org;
 h=from:subject; bh=gI3hKx/eLJBwHcKg2Z09pXqMlir5s87xW/Yb/W5o4zk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4jWpy2tS+Bo75wd5RN++5pC6flaDZOhdjaXyL29rv
 ptye2tARykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI7DtGho6N39KFNuivY32j
 GDljvd68v90bNjKtOyAX6WXkfGla2RxGhlksDTN+Lky+f+d0gcYX0Ud7VrsIxVS0X5aRuJh5ySK YgQ8A
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-36-ardb+git@google.com>
Subject: [PATCH v4 13/21] crypto/arm64: nhpoly1305 - Switch to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to the more abstract 'scoped_ksimd()' API, which will be modified
in a future patch to transparently allocate a kernel mode FP/SIMD state
buffer on the stack, so that kernel mode FP/SIMD code remains
preemptible in principe, but without the memory overhead that adds 528
bytes to the size of struct task_struct.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/nhpoly1305-neon-glue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/nhpoly1305-neon-glue.c b/arch/arm64/crypto/nhpoly1305-neon-glue.c
index e4a0b463f080..013de6ac569a 100644
--- a/arch/arm64/crypto/nhpoly1305-neon-glue.c
+++ b/arch/arm64/crypto/nhpoly1305-neon-glue.c
@@ -25,9 +25,8 @@ static int nhpoly1305_neon_update(struct shash_desc *desc,
 	do {
 		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
 
-		kernel_neon_begin();
-		crypto_nhpoly1305_update_helper(desc, src, n, nh_neon);
-		kernel_neon_end();
+		scoped_ksimd()
+			crypto_nhpoly1305_update_helper(desc, src, n, nh_neon);
 		src += n;
 		srclen -= n;
 	} while (srclen);
-- 
2.51.1.930.gacf6e81ea2-goog


