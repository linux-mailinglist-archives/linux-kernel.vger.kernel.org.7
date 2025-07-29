Return-Path: <linux-kernel+bounces-749846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF84B153A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931675406DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8434292B2E;
	Tue, 29 Jul 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAc5T0eM"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F7270EA3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817847; cv=none; b=X27sussz6/1NmgWwN2icROZbf/7RdSi3aaL8ye7Ue9ctccQK/FbONUTkyrxQAgKmXK9MZ+bD7Op0gvB30V95QEuyNbyQWWyhI63J4RJbuDAudRa90a1nSodFgF7vmeX5xFrBjn6DIBrN0sSW/+LbFD5RFrKnYgQlPpzM/KpwSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817847; c=relaxed/simple;
	bh=jhX5eow0ZtrlUzapU7IL/Q6GhPDQ4CJV2SBxgI99tOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lblZAcq2HYKgcirEmJTzE6dxrPjdOoeOg969V7EbcBiSx8/AImaoSL9ujmu2Q8ufPP3qBEZ+AEimAkpvx5Fkm3Dpzl8/9s1jJU4d7GePQB63Kl4L/cIlMUPzx80bCdAM/UcCqXaP/EFdpgpH3i4hgpJ61SiEwuliwttyaKnv86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAc5T0eM; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fe182a48acso2637356d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817845; x=1754422645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1I9IAjE7arvoHRD2CPgQ4vbTvzkjQYYPvGX27voj8U=;
        b=gAc5T0eMo3+8i6dkIpuMTfZyNniZqgYZ0ivaAQyV7XVOjPfUCvWMGH60i87AW//Szv
         iGA7SJ3NTAT4kNAhod/4m0K5GV9ojtp9R90P7YLUQRWaIuRBf8b5S/lJIxuVenNzsKAX
         B+teXX/eNbcw6JYFUiiei90zfetGB7sEWOMB/VY60qnBIITcwfFRsTx4qblkt65EZ/fi
         7aSyuQiLXaUKSz0+/Hra+02hHkeUwAwXiG4MeuujnpV7FAQWZ8p5hmdsy2fBJwoXyAct
         7ZCQLIzANppygwASX1EJhBKL1qRZS/gFTqmXDEVdKNJ7SdT7h0MjQGSBtY6KdaqMuzs3
         7gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817845; x=1754422645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1I9IAjE7arvoHRD2CPgQ4vbTvzkjQYYPvGX27voj8U=;
        b=uaDw+OOfqoVWLevgUgMdmvx+2aUvhCO7qH0vfIV80eY2COFRhc7Xm0fVkZE32CHzU1
         Q8mPQ3GexvoXKZ+rtUwWpJYIfkziJMPziUuWAaqc/EQ1I4cGd+hrHDkMW9b/G+35oIkU
         THT4j2/gZhMIY3Xug0vk/2QuZZxRM4bS6KWzfjAePqduFvY+T1Y7TL9wOs+hjA/55Oty
         f4FCLez8Wy0SYyBQZh5NGJ/NvyX5/BP1j8FpGOnqWlP4AgyuymGXcgWC7WsrseEwrGmd
         1zvaJ7S0kNw65MPa+oKbx0tH6o4hRV9nkPJA/hjjC0Z3tuIL3lR6Zp+c8tEol3/ag3nk
         s6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwBdfJ0hpyWOowJEL5Cl2TAkjHcn/0ZuEq3/qQ0Qfm/32SiIPqd7dDyR/f+z81i7Nz7/kuyEk1ASxPyQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8d2e3xiycdCK81BvZ2FyC5Z+spA7hI8adhTQTV/yXtIQGVvbK
	s7dzenqMvZMV8s+r7lv1nk/SBN0c8mDddhuFkKlD8gLw2VpbWIWbQJQgKw7U/mFcPyNnShJepNS
	GUIm7t6jEdomRmQ==
X-Google-Smtp-Source: AGHT+IHjdJ+C/GyichRcZO1+NLmayjPtkidhop6VuzgTrGXPN/gGzMzcDS6aLlPktjDxkrir6Ko3AJkF/wLcQQ==
X-Received: from qvsw1.prod.google.com ([2002:a05:6214:121:b0:6fd:5e45:e693])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ecc:0:b0:707:5046:6a1e with SMTP id 6a1803df08f44-70766139e40mr11981946d6.10.1753817844434;
 Tue, 29 Jul 2025 12:37:24 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:42 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-5-marievic@google.com>
Subject: [PATCH 4/9] kcsan: test: Update parameter generator to new signature
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch modifies `nthreads_gen_params` in kcsan_test.c
to accept an additional `struct kunit *test` argument.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index c2871180edcc..fc76648525ac 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
  * The thread counts are chosen to cover potentially interesting boundaries and
  * corner cases (2 to 5), and then stress the system with larger counts.
  */
-static const void *nthreads_gen_params(const void *prev, char *desc)
+static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
 {
 	long nthreads = (long)prev;
 
-- 
2.50.1.552.g942d659e1b-goog


