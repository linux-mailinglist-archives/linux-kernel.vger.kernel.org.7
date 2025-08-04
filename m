Return-Path: <linux-kernel+bounces-755628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD103B1A97F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ED91818B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DF28B7DE;
	Mon,  4 Aug 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzD5lKCp"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607628B3F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335109; cv=none; b=knCG7ptRCqoocPkozfjAzN16sXD5casLt3udecxdZ77NA/4RCkmf0oURQglxRocz6cPLDX/iZ5GI+Z2n6QoGVQsB4j4f6rZJdleMgAokKW7lJ6ttyC//kvCW1SJrknHVJesW9jH7ylqD4EL8Thf5ZG5DSzgeYLpe4YNGuuahHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335109; c=relaxed/simple;
	bh=OF7LyNhIL1EOuOn5pfi758khliHdObXKjDRY6+iPVTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHWUHdlOze6KoBGzSo/oHSV+9DYNfvqE/f7GCK4qSP9QhGAc4zomHiPaFtiGavW0qkYr6NV32ddcJtfp/XMlH9COfjTkrh6VI7qImW6AyXKWP/6+IrYgsAPcC08FF6K0nYODvuIVCNxvrYfmczRdNCmwHEZQh3ffeOu075ICd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzD5lKCp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458bf57a4e7so135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754335106; x=1754939906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiTfAb9cnMOM27iD69XKZ3u4igfynQ6rP5nLGl75Z/s=;
        b=YzD5lKCp3Nc7LL+onR3iz9pARhaMIVkDuAPRgZwo+ncQd8SXrQa4jpe7z/nklub7EL
         8PJGaNPy9+4pkUSP9Msey/7o5bMmAiLz7Cxz+lx8kMt7/Mn2W+tazAx9sFfpgOO5tMSJ
         SbPbNbFlhLW8y2sLPzc+SNVUeNkjdND8RRrWbTG+RBZ4grqhaWIOrESc9ekAz+kMznri
         O2jv7fZpCr+jXh4t2BA7mbaGEeMpOq/Q51hThe4ue6BGC+eKME00qZm4zOIyC1+VvJFb
         a+lekUx8S4DAp75MXoxScbIWzSoG2meZh7qRq0QMT/nPfYPcAajDriqWcgTvGSjVzWmm
         lKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335106; x=1754939906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiTfAb9cnMOM27iD69XKZ3u4igfynQ6rP5nLGl75Z/s=;
        b=QWs21mPzAafrl1jQQJvQA1N2wGECWp2N+wqskEw4v0QD8XeGWvDTxodehNOC6XWplP
         nWQ4SEYAVThUJmFeYszx25ZOB9hGKs0p2WSxWipQ7hJKlGvUOoJc/l3yMYrwRGmcGa9I
         vKQDTh8xqc6IEFTlS+OKheIikuhSnxz6F8XePLh5bqhmYzwJfgtF611O/VHMd8BX8aWw
         THTqY96mIKb3gSJHMwbV15PPgUFDG723jXtjMUfaidFf3pU/U3D4rXiR+nSzQPLH+JT4
         M+dQP/TEEv9nBPZHuRDTKv0uw0nG8cJsHAMTD6EkVTIIZHRjw/IyTW+v+UyxGd4Si8O6
         B7tA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3l6KejyRUEx0qtguIUOpU+GTMqsfrxFPr71II0rEUo+UlFR/YrDlpq0c6nCP8mQRswpVNA8fMFdDcpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUavmtlkJ0fgZuCPDJ3OeGEmfTOfbJoIr0gf5Rd45rudtVNiM
	Qh2Sahb1bdjHE4U6ks+8GFLAY0Gi2RYwielYC03osDw/EwD6o1L33T8F9HaQCPDllQ==
X-Gm-Gg: ASbGncvYVJZuvLMFYR2N2cFemQNDFqqXMnbtmewIwgjDT6N/U1BtnYi6aE/Bh2BnYQz
	1OVgaqGxbQwIxF7alqobFclRrHYtYrYgtYA5YKEFJ4uI1vIOZdxF4NCCGzsW1wJtb0cmeEl6Cyd
	TW+xP+FzOxCgqPB2Da1EnPrpGjc7+t0k6A/jiDTvNbPs80y6I7lrYt6LymrtKzGEMvIxhF4u3+B
	U4TlA6I+6p6hpZSe93uxCNQI/VwyTnwh86QTHd2M86aMDtNL/XRUbRvpvVVjmbWG51SXYOqgTRc
	c0c7dShd9Gf/kpAV9qZRxdtXRLR0On0Ia3MHFszcjW2IEMGmHO7hdAStry/akWeLDD5sg4PWvW1
	0QEEpy1otwA==
X-Google-Smtp-Source: AGHT+IGv48sGeD5VUgCauZAiE/92kma0rYRuzmY0NHuib68VVw0+Cdvc44IEf/hoe+8yq75/M+2y6A==
X-Received: by 2002:a05:600c:444e:b0:442:feea:622d with SMTP id 5b1f17b1804b1-459e14ef635mr140015e9.1.1754335106255;
        Mon, 04 Aug 2025 12:18:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:2069:2f99:1a0c:3fdd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3b9386sm16502103f8f.18.2025.08.04.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:18:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 04 Aug 2025 21:17:05 +0200
Subject: [PATCH early RFC 1/4] kbuild: kasan,kcsan: refactor out enablement
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-kasan-via-kcsan-v1-1-823a6d5b5f84@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754335100; l=2094;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=OF7LyNhIL1EOuOn5pfi758khliHdObXKjDRY6+iPVTk=;
 b=Nj7lWb06h7SXCifoXeKMs0DUlOqOdP4H8VnS8Otq1aKjtHh/Kl7wkBiRiTwimSc9Mb/vQL3wz
 G/GTNIUIiYQAgciu1KMGaY+kSTClICVFU5L25WqzmjcvA+7+WE4fbAH
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

In preparation for making the logic for enabling KASAN/KCSAN compiler
instrumentation more complicated, refactor the existing logic to be more
readable and (for KASAN) less repetitive.

Signed-off-by: Jann Horn <jannh@google.com>
---
 scripts/Makefile.lib | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1d581ba5df66..017c9801b6bb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -52,14 +52,12 @@ endif
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
 #
+is-kasan-compatible = $(patsubst n%,, \
+	$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)$(is-kernel-object))
 ifeq ($(CONFIG_KASAN),y)
 ifneq ($(CONFIG_KASAN_HW_TAGS),y)
-_c_flags += $(if $(patsubst n%,, \
-		$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)$(is-kernel-object)), \
-		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
-_rust_flags += $(if $(patsubst n%,, \
-		$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)$(is-kernel-object)), \
-		$(RUSTFLAGS_KASAN))
+_c_flags += $(if $(is-kasan-compatible), $(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
+_rust_flags += $(if $(is-kasan-compatible), $(RUSTFLAGS_KASAN))
 endif
 endif
 
@@ -94,10 +92,10 @@ endif
 # Enable KCSAN flags except some files or directories we don't want to check
 # (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
 #
+is-kcsan-compatible = $(patsubst n%,, \
+	$(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)$(is-kernel-object))
 ifeq ($(CONFIG_KCSAN),y)
-_c_flags += $(if $(patsubst n%,, \
-	$(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)$(is-kernel-object)), \
-	$(CFLAGS_KCSAN))
+_c_flags += $(if $(is-kcsan-compatible), $(CFLAGS_KCSAN))
 # Some uninstrumented files provide implied barriers required to avoid false
 # positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
 _c_flags += $(if $(patsubst n%,, \

-- 
2.50.1.565.gc32cd1483b-goog


