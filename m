Return-Path: <linux-kernel+bounces-866030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69FBFEAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B6418948F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE11EA84;
	Thu, 23 Oct 2025 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBduTit1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EDC1862
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177941; cv=none; b=r35YxBA9qW2GKYU4B+G2sOjA95m74K9+z2vxYTMIvPBZUOT/OMYPIx7M+gHHVgaHWsK/jS9jdasDZDcgDoUwEMJSyLIiRBh0+wkmjIftvg3A3lca8FT07kxgKA6dDMgHgEZaqoR9xpuqtj3ekwiG6k6Imfw/pu1P3s8VF9bdgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177941; c=relaxed/simple;
	bh=E7Ry0cXCsJ0OGXzsXLyPowVXmDu3+RjSRthyEbISNRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s+0l9V93l8wcKsHWldCPqSxxrQIM/+P9g+P0X6LQ9+TQBZwCcERTlI8yWZl9JEYt0jSZoJod1gYE5uyVGi2qYN6PDUu3CS6rGhDgakuUxPVYPsfBXibW8Fx/4Of4DYHpTl2YhcY7O1LOsGtvUdmZi6v9dLJEna0NMNdh+fCFc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBduTit1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5533921eb2so86299a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761177939; x=1761782739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/MB8s8c3Ez/o0yr7eHWLvYpTDaL3lC15NeH1OZAOxs=;
        b=HBduTit1hgqupDTajVCARx3zbeNROvVhXAZgFtwRywUMIoQUamrMzKsyPIX5ot0ypT
         Z/LiGV12Mon2LqOraKz7yHaAM08KKHjPSr9oHQRkYFRFCup3kBF6GBIfgMzzePdcDont
         pg8H03fsVwZX7bZydJzfJUpRpuWmaTlLKbUvU8J0rClGMQ3yoSxDFjW96ZzyvErp5kdt
         y8QhJO04HDWwAkblYWDArd5F7rY5F8wm1so5EfXoPykuf/ecTghJGFzsSoW/NPySZyxo
         x9r85pCcoEmSd98ONEkuj9Lww2JsutR8DVSVFYTXVQofD57MnkATfvq/DIZF3CYLjcWC
         w/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177939; x=1761782739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/MB8s8c3Ez/o0yr7eHWLvYpTDaL3lC15NeH1OZAOxs=;
        b=px7GwBxKu6GyKNNA3LrTDd9A5kRaN1th1uBwVoKbrlBbE6gkIHO79Wa+NwU6p4i8rL
         MunIdzLqvPwR3SPMKFSqvnuGgu8X5ZJGIYkm5ptDgaqEciCFzqWIC2ZRFHC7izlNpw9f
         y/K5bSxMrTeVNdK2ZWlfIkG7Wk5H5oAs/Rq88/V4xtR/Dgny3qfAp8sORgiiqSAOVQ4p
         fozQ7w/erDTvHCQG6/H5DOBIF/jPwPjKmEY20iAVzyO7sK6xY9lVE0sTKBFGiCfWaaqe
         2oXdKeVtqjWbcLHxJy8Cs++wCxeMZ4EjQ5sU5H8iyYIcF5JWKhup7D8oaC0uXWFocIXM
         oLjw==
X-Forwarded-Encrypted: i=1; AJvYcCXWuIDrklXWTxlK1UQFqIFaWag7fCY6/ZHnZsoxnat9SdCfOdNlY+1P2aTL+zrkLMe6kg3pRDjDynzthoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0IZqYP61g4m19rZeJxb/I+dtjvuVJc6d8UgNNsk5CodzpzPJc
	HBIhM+9mqrWNOo37ufOTI03hjbxLCezOgUxVRR1OsSIaPZMPQ0pZ7GfBWOqQ1z1o6U0mDH05F1L
	BBJjVyw==
X-Google-Smtp-Source: AGHT+IHd943MEU/q3sfmeNkNkm5n04WovhTQk4e5Fqu5kHZgqjXBaWuFFpabxZxMuUt+TzoW6CCUrGaxrt8=
X-Received: from pjbgk8.prod.google.com ([2002:a17:90b:1188:b0:32e:a549:83e3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b0d:b0:250:643e:c947
 with SMTP id d9443c01a7336-290ca30e401mr284211495ad.28.1761177939351; Wed, 22
 Oct 2025 17:05:39 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:04:43 +0000
In-Reply-To: <20251023000535.2897002-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023000535.2897002-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251023000535.2897002-2-kuniyu@google.com>
Subject: [PATCH v1 1/2] uaccess: Add __user_write_access_begin().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In epoll_wait(2), ep_check_params() performs a bulk check for
the passed user address:

  if (!access_ok(evs, maxevents * sizeof(struct epoll_event)))

And later, epoll_put_uevent() uses __put_user() twice to copy
2 data into the region.

unsafe_put_user() can be used to save a stac/clac pair, but
masked_user_access_begin() or user_access_begin() introduces
an unnecessary address masking or access_ok().

Add a low-level helper for such a use case.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 arch/arm64/include/asm/uaccess.h   |  1 +
 arch/powerpc/include/asm/uaccess.h | 13 ++++++++++---
 arch/riscv/include/asm/uaccess.h   |  1 +
 arch/x86/include/asm/uaccess.h     |  1 +
 include/linux/uaccess.h            |  1 +
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 1aa4ecb73429..30726ce182cb 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -422,6 +422,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	uaccess_ttbr0_disable()
+#define __user_write_access_begin(a,b)	uaccess_ttbr0_enable()
 #define unsafe_put_user(x, ptr, label) \
 	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), label, U)
 #define unsafe_get_user(x, ptr, label) \
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4f5a46a77fa2..910bf469128d 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -437,15 +437,22 @@ user_read_access_begin(const void __user *ptr, size_t len)
 #define user_read_access_begin	user_read_access_begin
 #define user_read_access_end		prevent_current_read_from_user
 
+static __always_inline void
+__user_write_access_begin(const void __user *ptr, size_t len)
+{
+	might_fault();
+
+	allow_write_to_user((void __user *)ptr, len);
+}
+#define __user_write_access_begin	__user_write_access_begin
+
 static __must_check __always_inline bool
 user_write_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr, len)))
 		return false;
 
-	might_fault();
-
-	allow_write_to_user((void __user *)ptr, len);
+	__user_write_access_begin(ptr, len);
 	return true;
 }
 #define user_write_access_begin	user_write_access_begin
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index f5f4f7f85543..9adc8f0dd1c8 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -452,6 +452,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 }
 #define user_access_begin user_access_begin
 #define user_access_end __disable_user_access
+#define __user_write_access_begin(a,b) __enable_user_access()
 
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long enabled) { }
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 91a3fb8ae7ff..23edbaef9f71 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -524,6 +524,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	__uaccess_end()
+#define __user_write_access_begin(a,b)	__uaccess_begin()
 
 #define user_access_save()	smap_save()
 #define user_access_restore(x)	smap_restore(x)
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1beb5b395d81..a6e32784e6cd 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -552,6 +552,7 @@ do {							\
 #ifndef user_access_begin
 #define user_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
+#define __user_write_access_begin(ptr,len) do { } while (0)
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
 #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
-- 
2.51.1.814.gb8fa24458f-goog


