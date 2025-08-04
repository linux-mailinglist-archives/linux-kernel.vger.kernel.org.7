Return-Path: <linux-kernel+bounces-755631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7DB1A984
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DF71892C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F882291C39;
	Mon,  4 Aug 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fj4bbU/Y"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C528B7EC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335112; cv=none; b=MO2Cl1Lpe2RgUzmx69iqAxeO+mzfLYHNDP9sjcWCwAyFftRCZUHCFKJL3N5W0tHQd2ke2/m7JWDe4H//bR+/lW7QvHELBZwqIHiiYnQDUo6LMprm6Sng//rwK+9Wea8yEda4/j9g8Ain2G7njH17t2k4J2yLmXhu340LqaRz4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335112; c=relaxed/simple;
	bh=rDvA4L4QbNOZZHJ9ypWKaY7n7K/aeq1dGeCN1JjgQg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=darxdbjaNTKpX2WYjstOdURv/cmKA3AEOflXIF9Po0IYfOY42e/Mvpl9AakWynspRTWKzKJ1e8sEVy20CgzpiebR7t7VJ0panBZ7pwIwzUdbNs27f45ywuylgNf0g4FMKGCSXTAXIzEJZg3qvNkqDefF8CwRsrf/P9Tz/9qdbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fj4bbU/Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b63bfa52so10665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754335109; x=1754939909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+ElZLVKoAO1zlP8cjrF+LYIULpb9l5O5jbMVWAEu58=;
        b=Fj4bbU/YrQ2Zm1E7EEN0ytfGJkkN15+XQjGKTuDDDZpbkaGqGRDPZuR4YrOfPGqzxp
         RPFqo35LVNSswPvFkIZ6z3nVuHh89hoBhCvOggZpUiBVBGOLQR6q24eYwCc54IUvD8+h
         yPA7KxJADY00XUacO5zDWuEfRkHkgA9tO/ToJlcXfJBGUS60UWgODizv1O4/vvK27dXL
         zkwT0mS8vREN2/RRGUGCSWXKtzipWfRdCgtSCgG3RwVOdJ0cYKK95M/AmiFahXyAyK9R
         wi0Bpqrs2eGs0r9DHRh4LXX+sBRBfLUARmX8sRqpXmYGu3F0VHqYSwsoDM11O2Q0gVL/
         6Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335109; x=1754939909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+ElZLVKoAO1zlP8cjrF+LYIULpb9l5O5jbMVWAEu58=;
        b=s6B2OVwMdibjRaW4/NiPP6IVLKXLVvp1LUvCj+pLb5aL4b+YYLwwMiID0ozvXuhOzK
         xQnCFhxcwS5EXB1CxnHY21qj/nEZZoqfWymyFOL/57V2C6XBgBjkAy2xiLQsmTIBRe5r
         kYTcGLq1Xa2bEqhArmyTWUWDkMMUAfu5rcB9DWMTe0nMyOCXvORkfKkTqqWh009uhRKw
         nAJgw/GYbiuxlaOpZX4pAtzFW4HYXD3Y39TyPAXl1pmInvGDLpnCMAGk8oJ4QCZqW8TH
         p19hQnbwA7iHntommsoU490sfSudu9qbrORBDz53PA48ebbn60PNVrYE75OAJQNl8alA
         p8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWipuPrZMzbjREGlgScuOh7S125os35WpjqXTkQctj3+25IFOya8rfZ1PfFIqyzteBCuMed2ChqgYU0BdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7gyxcgAuvPs8kxg08oCyyBsfKxZINqa6hvlECcRmZjY499Ed
	CRp/2gk80GlP4C1qVOK2NCnoWIs7dh7ZIsDR885ANZoMQ2kLLPK9LWKs9m0bDGLGYw==
X-Gm-Gg: ASbGncvBlPMOQ/FyaEKN2TdfLNwqXoCDpD9GHiLpCsGADkp0eDk5jjt3VZ6SPWDNDTn
	b0DgSWKH3FIW3qYXxGG0ftXfIYT2Ji37UwR6E6JnYedQv8ldi7aBwvm9we9ZJZUHU1UC2g/Fpy7
	JNf+8CX0G+00zz8BAuOSKHF+n13rLYMTRF3ktb9R4cUAraGtF0BY7KJzB2YrD/abkRfxcNhO69k
	LOXFgBxWNNVXjQsLepTVE0s+zZHt5oAlnRLjPSh5PUfzT/ORynyCF33tQa0re+GYK7JJZHbI2fH
	dsN8e8bfPqn1crZ3B+pV3xydAOQRWJ7SB36E/wvSjZTlCMqw6wnU8NVefoE/ZVCyv9xmzhQIB6U
	ca4yyuo8wlY8OinQ373wj1w==
X-Google-Smtp-Source: AGHT+IFXIw0hETMOIcFdZZPj95d4g3PWYz9SZjzY0rqj09Zgdh9l/ptS5MqTJPdGntxa1C5rvhU2+w==
X-Received: by 2002:a05:600c:4f0c:b0:456:e94:466c with SMTP id 5b1f17b1804b1-459e162c21bmr99265e9.3.1754335109094;
        Mon, 04 Aug 2025 12:18:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:2069:2f99:1a0c:3fdd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e0bfc79fsm6386856f8f.56.2025.08.04.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:18:28 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 04 Aug 2025 21:17:08 +0200
Subject: [PATCH early RFC 4/4] mm/slub: Defer KCSAN hook on free to KASAN
 if available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-kasan-via-kcsan-v1-4-823a6d5b5f84@google.com>
References: <20250804-kasan-via-kcsan-v1-0-823a6d5b5f84@google.com>
In-Reply-To: <20250804-kasan-via-kcsan-v1-0-823a6d5b5f84@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754335100; l=2111;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=rDvA4L4QbNOZZHJ9ypWKaY7n7K/aeq1dGeCN1JjgQg4=;
 b=BNMFpmS4euz1y5tN47fZ/MPB/oBGEwflQjmjyeX1N1RVfc1GB9ZCh7BojwIDDdkpsHaV00kuS
 UgRf/ZcDTKmDULwqSbKBaJxSEXdp2iwg5oMuT9N60I9e/Fr6RrmgtHO
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

SLUB calls __kcsan_check_access() in slab_free_hook() so that KCSAN has
an opportunity to detect racy use-after-free bugs, for example by
delaying the freeing a bit and watching for any other accesses to the
allocation.

When KASAN and KCSAN are active at the same time, and such a racy
use-after-free occurs that KCSAN can detect, it would be nice to also
get a full KASAN report. To make that possible, move the KCSAN hook
invocation after the point where KASAN has marked the object as freed in
KASAN builds.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/kasan/common.c | 5 +++++
 mm/slub.c         | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c75..3492a6db191e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -263,6 +263,11 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 	poison_slab_object(cache, object, init, still_accessible);
 
+	if (!still_accessible) {
+		__kcsan_check_access(object, cache->object_size,
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
+	}
+
 	/*
 	 * If the object is put into quarantine, do not let slab put the object
 	 * onto the freelist for now. The object's metadata is kept until the
diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..144399aebdc6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2311,8 +2311,13 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 	if (!(s->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(x, s->object_size);
 
-	/* Use KCSAN to help debug racy use-after-free. */
-	if (!still_accessible)
+	/*
+	 * Use KCSAN to help debug racy use-after-free.
+	 * If KASAN is also enabled, this is instead done from KASAN when the
+	 * object has already been marked as free, so that KCSAN's race-window
+	 * widening can trigger a KASAN splat.
+	 */
+	if (!IS_ENABLED(CONFIG_KASAN) && !still_accessible)
 		__kcsan_check_access(x, s->object_size,
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 

-- 
2.50.1.565.gc32cd1483b-goog


