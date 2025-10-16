Return-Path: <linux-kernel+bounces-856922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C7BE576B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57816544C95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87972E4266;
	Thu, 16 Oct 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgAgpFsr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D032E22AB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647906; cv=none; b=Bh0XJWiuBCpqSgBicQ3MEMTnVBK3UyeqzINYHuAbunvlV5E82WTYRM97ycPiApvLXVcvKr10uHZQHmzrC4eg/ZabxIkCRK6Ehc3dYZn3hOHyF/cdGCWoDSvri8fcAwJnrW3kGVZfqMHvrPXMsuhcw3omOav9rRiX2qvzOUlx6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647906; c=relaxed/simple;
	bh=nVrSvzPztuXGClDcdMqXs9xM3Seb6JCG22hS9qvNjdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Qlryeu8mGjRd1BDTALXuN/aD0Y07NT/uaKpHFZb1a2QwQaHROE5IsGfC3MkT1c+8bpGcPe4gG7XAsA0r7MXn8Q+xLIEtuB5mPXD56rqxCa0FBG8etG5aG+5Ht4PCdqyKwzkCNG5fkP2M55kl3BQFKjKawGXen9A3l+MoppsFLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgAgpFsr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee41e062cso17333775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760647904; x=1761252704; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAIMGYoqbISny2vRErUw0qxGyMwV616xJj8ghqmGSR0=;
        b=YgAgpFsr7DuYTEPj1mC2sURger/hsf+DwRhYAci96wvFfCM/eDp31lTwSYdlSmbVZv
         8JYtZylr/du8IH6rU9Ek9etUZMTlzeaHVFqRC3HII/sHcksXVaWQCk2MIyik2ZHJ5K1t
         z1RoazTT6M4C6qFrrs0lvso/3LrmRkSE9HAk7q2L0CQvye4RPF66wqsom9bGEYlQtxkD
         XFJGZlgtDxXCLIuMBTcL7u2W+pF29SpPUOfcp9vkTbM0oCvySonVNjq0CQIxclCq5UKQ
         2Jb3cXdBfam5HXeDyn7jNXS4xTFVtyKiJyXW5YqOELpQ1hB6bgtOwxx9BniCU3ApgI65
         uvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647904; x=1761252704;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAIMGYoqbISny2vRErUw0qxGyMwV616xJj8ghqmGSR0=;
        b=HDN2gwNozEkPAwJ38c9xrNgOf9QJOhjSR55DJ8qbkr6dKqdGrI80HgpkJ8X+eppPjr
         DKOjlTVM98Thzwe+g2phRnz+wSuqTvXZzXUQvFzFFcJ20h4am+0xjm/3nSYVtQrJ3kql
         H6BU9AhGydHRFg3YUQQHR4mrqvVw37hWhjempM/mltk/hw42z37Mootjm2UrGNghL9bM
         X45ETWHwmI0l22AfDMsQgJCM65pc4gkZrtdOLYSmUbJH27hb47p2mm1Oos3Vnk9yYEFy
         NmulD1HGUGcZhpGrHnNiQMMGH9Um3jfRr3c3yxA4tGJGJX8k4Bb+e/59zbMDS3btlX9B
         qOyw==
X-Forwarded-Encrypted: i=1; AJvYcCVVMHHuYP2aqY6BTe1Kdk9zqixE0d4clMXMKgXK2B20jr+GybXejjz3QXof1rTH7Qx6+SaMjoSrAnaZsU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRdBV1t+KeQlT+smwCzmaMdHhl6GV9JvqPAcdipB/zD3nDZHg
	xE4yYNZvxcHZkRCZKsoLN1loryzLk3JCKAobp0nVYe5RfqMZsE6i/S4gWxgHRsMT6KuX7X5AMve
	BMJUFh4OM9A==
X-Google-Smtp-Source: AGHT+IG5RzQebXrGDbWsNPzFtRR2+5yK+xcRDPhguIs/MdSqdZRddPVVMtrRDsP/hpqzUccoN4arVYWrJvpY
X-Received: from plko5.prod.google.com ([2002:a17:902:6b05:b0:25c:22e5:1a27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b06:b0:272:f9c3:31fb
 with SMTP id d9443c01a7336-290cba4dbb5mr14771145ad.58.1760647903824; Thu, 16
 Oct 2025 13:51:43 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:51:24 -0700
In-Reply-To: <20251016205126.2882625-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016205126.2882625-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016205126.2882625-3-irogers@google.com>
Subject: [PATCH v5 2/4] vdso: Switch get/put unaligned from packed struct to memcpy
From: Ian Rogers <irogers@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

Type punning is necessary for get/put unaligned but the use of a
packed struct violates strict aliasing rules, requiring
-fno-strict-aliasing to be passed to the C compiler. Switch to using
memcpy so that -fno-strict-aliasing isn't necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/vdso/unaligned.h | 41 ++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index ff0c06b6513e..9076483c9fbb 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -2,14 +2,43 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({							\
-	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
-	__get_pptr->x;									\
+#include <linux/compiler_types.h>
+
+/**
+ * __get_unaligned_t - read an unaligned value from memory.
+ * @type:	the type to load from the pointer.
+ * @ptr:	the pointer to load from.
+ *
+ * Use memcpy to affect an unaligned type sized load avoiding undefined behavior
+ * from approaches like type punning that require -fno-strict-aliasing in order
+ * to be correct. As type may be const, use __unqual_scalar_typeof to map to a
+ * non-const type - you can't memcpy into a const type. The
+ * __get_unaligned_ctrl_type gives __unqual_scalar_typeof its required
+ * expression rather than type, a pointer is used to avoid warnings about mixing
+ * the use of 0 and NULL. The void* cast silences ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type *__get_unaligned_ctrl_type __always_unused = NULL;		\
+	__unqual_scalar_typeof(*__get_unaligned_ctrl_type) __get_unaligned_val; \
+	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
+			 sizeof(__get_unaligned_val));			\
+	__get_unaligned_val;						\
 })
 
-#define __put_unaligned_t(type, val, ptr) do {						\
-	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
-	__put_pptr->x = (val);								\
+/**
+ * __put_unaligned_t - write an unaligned value to memory.
+ * @type:	the type of the value to store.
+ * @val:	the value to store.
+ * @ptr:	the pointer to store to.
+ *
+ * Use memcpy to affect an unaligned type sized store avoiding undefined
+ * behavior from approaches like type punning that require -fno-strict-aliasing
+ * in order to be correct. The void* cast silences ubsan warnings.
+ */
+#define __put_unaligned_t(type, val, ptr) do {				\
+	type __put_unaligned_val = (val);				\
+	__builtin_memcpy((void *)(ptr), &__put_unaligned_val,		\
+			 sizeof(__put_unaligned_val));			\
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */
-- 
2.51.0.858.gf9c4a03a3a-goog


