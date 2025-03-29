Return-Path: <linux-kernel+bounces-580555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08CA75390
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 01:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE3188CA2F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CE2AE90;
	Sat, 29 Mar 2025 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqM6trdQ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CC29A1
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206634; cv=none; b=g8PifufrNiLKPf14y2ZDSdG61MRndKPhrAu1UoSh4zTWsIUApRHJ9MNW21apHjBWmlZqXeC+lDyo/wEvyd+QHdH/oil3glgktF0eCeMEgHW48aGtjwqS92O1SiI3TTHRXW8oXgiunYYyO8mS84XQbGYWO8Z/JVYKYWEAFYMWJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206634; c=relaxed/simple;
	bh=A4qOF8g/Lp0fNN70XKVNtD9pF/sKUksq0VFQkLxYtOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMUZyAVyaBhvuskJ6CjFwqu5SeACTrryykQVt3KXknO9acPf25JaHFl2bxrPaCG+BDjrebMu5dPtkYhLA7pcHeAjlSaOW8vgiP9d/K4YBuWbXJPFofu6gvqdkZObODJStxpn5tOS6Y6cl3YSo0ReESmkIB43ChUCqJMaDbjo4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqM6trdQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22410b910b0so39666675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743206631; x=1743811431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEgmoeCU7ZoBbD/6q07yzTwvuV9KDxvtvsClWJ9QuF8=;
        b=CqM6trdQnGyRuGojGezqW97vHKKPBba0YFXnxkJYUjR5WqFZ+srqQE/JxKuUcrK1zP
         epGyEB5E/IvmhgFwRBI2siYtJ+9TpAc0LvKD3TUdQMB1lsRs0o/H5vMU9RvMw05WVbFP
         PDBPYUTokovsDljKlToIbpQl5uCL/XAmwpkxibZ9JZi8Vristc4qGncD3ffkFnQt7/Gg
         6Gj/ge9MlbXnOw62liHAG6yavJcuJEQ8ek3eitT2Ym/4+fNkLctPutd3WvTpeGAZVmGX
         A/P++a8ym79yEDclEgWtyjaD7XOF84i3KRdjStdb21hrbdrD8gdxxxMnFwMG6UEiZ4Kh
         ucww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206631; x=1743811431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEgmoeCU7ZoBbD/6q07yzTwvuV9KDxvtvsClWJ9QuF8=;
        b=JcedzlF2UwNa+mPGArq0DJ3g8kQhJKblrChkw4ATcHQZTltyVIDr0xS53JWX5huLm0
         2zKBt5mggAzM03jY9KiAKHyLLkqe2ZHlfGmJ8YPmdCgep4ZAe6/DeLDfMck79k8TQjXS
         J+lO/pHrDRftuUxmDsIYauijuRf6lwGHqVKp0iVBNCnE55tv+cjBngtoSknj1vvKGz7f
         M3ez7oDXrouDgl3cOzIy8KS36eBh890rjLsThtEyVxj7THgP0yWt7bAAOjdBO/eqZVqg
         JZX4iIqbnjRcx/a70Z4vpEkAIOTIWNRaHDe8y2dl3MHccp4136UkFNHAmbbisPX4+DIZ
         zaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDmJduYOGVF/BDx5AVYL3yeNsSvymlf2JKlxMyVc02dKLNMzm3iRyMlPpJ1nvZICC0EYO9kErQjuYgSoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzb4LBl5KqIw8qWFD/o9+DNLfFfogDcTAkVWSmQ0CfNtLDgjDV
	eqOEUHzNT209vQ+hi16L0STcT2bCW8CR3uaqzpjhzQrTHOWI1XQT48LT8Ym9lH2UCw==
X-Google-Smtp-Source: AGHT+IHjR6hGtSOVpUkc0nyNRot3w3fhTtOD52YS62CSenulpOThQdeL5LjrShYtAkO27skye9Y/6dw=
X-Received: from pfbmd6.prod.google.com ([2002:a05:6a00:7706:b0:739:4935:6146])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e887:b0:223:f408:c3f8
 with SMTP id d9443c01a7336-2292f960348mr16354725ad.14.1743206631260; Fri, 28
 Mar 2025 17:03:51 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:03:36 -0700
In-Reply-To: <20250329000338.1031289-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250329000338.1031289-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250329000338.1031289-2-pcc@google.com>
Subject: [PATCH v4 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The call to read_word_at_a_time() in sized_strscpy() is problematic
with MTE because it may trigger a tag check fault when reading
across a tag granule (16 bytes) boundary. To make this code
MTE compatible, let's start using load_unaligned_zeropad()
on architectures where it is available (i.e. architectures that
define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
takes care of page boundaries as well as tag granule boundaries,
also disable the code preventing crossing page boundaries when using
load_unaligned_zeropad().

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: stable@vger.kernel.org
---
v2:
- new approach

 lib/string.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..b632c71df1a50 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
+#ifndef CONFIG_DCACHE_WORD_ACCESS
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	/*
 	 * If src is unaligned, don't cross a page boundary,
@@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	/* If src or dest is unaligned, don't do word-at-a-time. */
 	if (((long) dest | (long) src) & (sizeof(long) - 1))
 		max = 0;
+#endif
 #endif
 
 	/*
-	 * read_word_at_a_time() below may read uninitialized bytes after the
-	 * trailing zero and use them in comparisons. Disable this optimization
-	 * under KMSAN to prevent false positive reports.
+	 * load_unaligned_zeropad() or read_word_at_a_time() below may read
+	 * uninitialized bytes after the trailing zero and use them in
+	 * comparisons. Disable this optimization under KMSAN to prevent
+	 * false positive reports.
 	 */
 	if (IS_ENABLED(CONFIG_KMSAN))
 		max = 0;
@@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+		c = load_unaligned_zeropad(src+res);
+#else
 		c = read_word_at_a_time(src+res);
+#endif
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-- 
2.49.0.472.ge94155a9ec-goog


