Return-Path: <linux-kernel+bounces-774510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A63B2B35B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13913189ACAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31312272E6E;
	Mon, 18 Aug 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+1S6S66"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B05212B31
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552586; cv=none; b=kKkC++YZm4R8c89pDsNutTUJFQxPCb5RI24AZ5FkWnBVz65T7zp16HKQGxOGxTb1OZtkjT2cdYjgEDNd1qDVji4bfewg/YfL8dvClOjTkRGoDERgbbJZSy9TQfBFsgWS9j0E4VeQhHwXXDcZ/bumGvA+2tr6sOx9zW9DojR+UNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552586; c=relaxed/simple;
	bh=sMjgUlT5byKgxkBAyS8SQAA/QGjk7FegBPjqmgUHwpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f6stRc+dtRx4rN7hO8JBjFttlJJ3NqvdyJ8xaswKzLESKj5LA6WYj5ZmaUqyQH5HmdUZxbx8A+MDSHgG1UAgKt0GA5AyWyhnW1M4L+snEz+aFgLnYcUhfmJCS5tAoDqM9TTjZIrbWptIC+mRm+ybmvsol81xjgC4w+CWgU1mOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+1S6S66; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4716f9dad2so8391378a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755552584; x=1756157384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDXIaKWk81ObDEtlEwv0PcTKST5fIOdwiVWZYaIVrII=;
        b=c+1S6S66HRg2azTQlob4leUdhv6PU7qN1Q8ewLK3/oi/6idbwq3ZiAmtyDNe2MrpHp
         54M0cWV/RKBcNj8vOnLnGoNwiDabWqo0ZwEE6GEa2pksdvQWZKCkjCzxHRNuNpLdGDVp
         PVSYBPeCARh2T+hbNv/6TSSY3VeFTT5xmaobJrx1DQXkiNcrAnyYMPUpokmw14JjhCcs
         msmKv8o3CcfXWIgY4bg9O0p6xKcI0loW28fkkEakv7e59JUghTpiy8OkwUiJekprRbh6
         2s4EmVFV0+dnZcQ4LgCQ3cjdQ7K+NWPt7Y8LdATRGBhWRszqkpGm+r7IwL+ADIw2+O+5
         k24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552584; x=1756157384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDXIaKWk81ObDEtlEwv0PcTKST5fIOdwiVWZYaIVrII=;
        b=wkL87/H5JNDiW5U+vT/nDPCWitiuUeO0/9pKukUXSfW3l5RmXICYawVZfDPu1QnE94
         +EsONviQ+HYlZ4oOlQV6KXhBv0s/0EdrFx3ckoPCm5MSkH5CBBghgizwIG8o9HlCd1ee
         g6MdTWeIqMOhpGkQ1XU4vShiESNLQDNV/eBTAq3Sk7r0st6SqFsI2mg4NEUYQc3WEAoF
         qCwkIrcLyVWe4TcbvXUZzxXUZsPAqzwNySOnPs7JwrN2Vo7x5ZTt71y6/wkqfkSmnd8y
         baiwmUvss6cOt6S0tOT4HtZIHcjn3hwQJkoP2jLaIPEgbI9HGKeUkJoSolSLTfQxRqah
         GCSw==
X-Forwarded-Encrypted: i=1; AJvYcCUm+IfoUSneLj6gv5NuFZf7o77S8O2CqmJUzyfWVQQYMuJryah1wNp+BHQBpNEre8sFWqO+VIs4nXxL3qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuiKLDB4quRUUJGmEARvbDUlL/+PYAxwvX6TPpD88wwQ9LiVv
	U5+6CoV/SuL/tbUGGb3KdfAP46xDRkf6bRNHJBWYJLHdIlC+UoQXdAgqlrYvWkhUflafBu4h58C
	KlmObow==
X-Google-Smtp-Source: AGHT+IFj6MhFtjo/07xux15sdZuniVtAPgBbeLwFhyL5pTG4o1erzuz5gmZuj/A7LntvBRobeg1BCoUWB1s=
X-Received: from pgls25.prod.google.com ([2002:a63:5259:0:b0:b47:75d:de68])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9147:b0:240:1119:d725
 with SMTP id adf61e73a8af0-2430d4a6d9dmr113868637.34.1755552583960; Mon, 18
 Aug 2025 14:29:43 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:29:42 -0700
In-Reply-To: <aKOE-FzHy0JatC8I@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815070227.19981-1-darwi@linutronix.de> <20250815070227.19981-8-darwi@linutronix.de>
 <aJ9TbaNMgaplKSbH@google.com> <aKMvTrrKYgJNWX8L@lx-t490> <aKN0debsio7ocitW@google.com>
 <aKOE-FzHy0JatC8I@lx-t490>
Message-ID: <aKObRk0Ze1_LVqWj@google.com>
Subject: Re: [PATCH v4 07/34] x86/cpuid: Introduce a centralized CPUID data model
From: Sean Christopherson <seanjc@google.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	David Woodhouse <dwmw2@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sohil Mehta <sohil.mehta@intel.com>, John Ogness <john.ogness@linutronix.de>, x86@kernel.org, 
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 18, 2025, Ahmed S. Darwish wrote:
> Hi,
> 
> On Mon, 18 Aug 2025, Sean Christopherson wrote:
> >
> > Why not?  Like C structs, there can only be one variable sized array, i.e. there
> > can't be multiple "n" subleafs.  If the concern is calling __cpuid_subleaf_n()
> > with i < start, then I don't see how embedding start in the structure name helps
> > in any way, since 'i' isn't a compile-time constant and so needs to be checked at
> > runtime no matter what.
> >
> 
> Hmmm...
> 
> I can indeed find the offset of the dynamic 'leaf_0x.._n' subleaf storage
> by CPP tokenization, since the CPUID table will be in the form:
> 
>     struct leaf_0x0_0           leaf_0x0_0[1];
>     struct leaf_0x1_0           leaf_0x1_0[1];
>     struct leaf_0x2_0           leaf_0x2_0[1];
>     struct leaf_0x4_0           leaf_0x4_0[8];
>     struct leaf_0xd_0		leaf_0xd_0[1];
>     struct leaf_0xd_1		leaf_0xd_1[1];
>     struct leaf_0xd_n		leaf_0xd_n[62];
>     struct leaf_0x16_0          leaf_0x16_0[1];
>     struct leaf_0x80000000_0    leaf_0x80000000_0[1];
>     struct leaf_0x80000005_0    leaf_0x80000005_0[1];
>     struct leaf_0x80000006_0    leaf_0x80000006_0[1];
>     struct leaf_0x8000001d_0    leaf_0x8000001d_0[8];
> 
> I was also kinda worried about the different subleaf semantics:
> 
>     struct leaf_0x4_n		=> starts from subleaf 0
>     struct leaf_0xd_n		=> starts from subleaf 2
> 
> But, hopefully it would be clear when looking at the generated header in
> total.
> 
> Still: for the API you're proposing, I'll need to generate an error for
> things like:
> 
>     cpuid_subleaf_n(c, 0xd, 0);
>     cpuid_subleaf_n(c, 0xd, 1);
> 
> which could not have happened in the API I proposed earlier.  But... I
> can let the XML files generate some symbols in the form:
> 
>     LEAF_0x4_n_MIN_SUBLEAF	0
>     LEAF_0xd_n_MIN_SUBLEAF	2
> 
> and generate an error (once) if the passed subleaf is less than the
> minimum.  I can also generate that error (once) at compile-time if the
> given subleaf was a compile-time constant.

Eh, if the kernel can flag "cpuid_subleaf_n(c, 0xd, 1)" at compile time, then yay.
But I don't think it's worth going too far out of the way to detect, and it's most
definitely not worth bleeding the lower bound into the APIs.

E.g. it's not really any different than doing:

   cpuid_subleaf_n(c, 0xd, 2, 64);

and AFAIT the original code wouldn't flag that at compile time.

> Maybe there's a cleaner way for detecting this subleaf lower-bound error,

Not sure "cleaner" is the right word, but if you really want to add compile-time
sanity checks, you could put the actual definitions in a dedicated header file
that's included multiple times without any #ifdef guards.  Once to define
"struct cpuid_leaves", and a second time to define global metadata for each leaf,
e.g. the first/last subleaf in a dynamic range.

---
 arch/x86/include/asm/cpuid/api.h       | 11 ++++---
 arch/x86/include/asm/cpuid/leaf_defs.h | 12 +++++++
 arch/x86/include/asm/cpuid/types.h     | 43 +++++++++++++++-----------
 3 files changed, 44 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/leaf_defs.h

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index d4e50e394e0b..3be741b9b461 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -393,7 +393,7 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 	((struct cpuid_regs *)(cpuid_leaf(_cpuinfo, _leaf)))
 
 #define __cpuid_assert_leaf_has_dynamic_subleaves(_cpuinfo, _leaf)	\
-	static_assert(ARRAY_SIZE((_cpuinfo)->cpuid.leaves.leaf_ ## _leaf ## _0) > 1);
+	static_assert(ARRAY_SIZE((_cpuinfo)->cpuid.leaves.leaf_ ## _leaf ## _n) > 1);
 
 /**
  * cpuid_subleaf_index() - Access parsed CPUID data at runtime subleaf index
@@ -415,7 +415,7 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
  *
  * Example usage::
  *
- *	const struct leaf_0x4_0 *l4;
+ *	const struct leaf_0x4_n *l4;
  *
  *	for (int i = 0; i < cpuid_subleaf_count(c, 0x4); i++) {
  *		l4 = cpuid_subleaf_index(c, 0x4, i);
@@ -432,7 +432,10 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 #define cpuid_subleaf_index(_cpuinfo, _leaf, _idx)			\
 ({									\
 	__cpuid_assert_leaf_has_dynamic_subleaves(_cpuinfo, _leaf);	\
-	__cpuid_table_subleaf_idx(&(_cpuinfo)->cpuid, _leaf, 0, _idx);	\
+	BUILD_BUG_ON(__builtin_constant_p(_idx) &&			\
+		     ((_idx) < CPUID_LEAF_ ## _leaf ## _N_FIRST ||	\
+		      (_idx) > CPUID_LEAF_ ## _leaf ## _N_LAST));	\
+	__cpuid_table_subleaf_idx(&(_cpuinfo)->cpuid, _leaf, n, _idx);	\
 })
 
 /**
@@ -464,7 +467,7 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
 #define cpuid_subleaf_count(_cpuinfo, _leaf)				\
 ({									\
 	__cpuid_assert_leaf_has_dynamic_subleaves(_cpuinfo, _leaf);	\
-	__cpuid_leaves_subleaf_info(&(_cpuinfo)->cpuid.leaves, _leaf, 0).nr_entries; \
+	__cpuid_leaves_subleaf_info(&(_cpuinfo)->cpuid.leaves, _leaf, n).nr_entries; \
 })
 
 /*
diff --git a/arch/x86/include/asm/cpuid/leaf_defs.h b/arch/x86/include/asm/cpuid/leaf_defs.h
new file mode 100644
index 000000000000..bb3d744939c2
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/leaf_defs.h
@@ -0,0 +1,12 @@
+CPUID_LEAF(0x0,                 0)
+CPUID_LEAF(0x1,                 0)
+CPUID_LEAF(0x2,                 0)
+CPUID_LEAF_N(0x4,               0,      7)
+CPUID_LEAF(0xd,                 0)
+CPUID_LEAF(0xd,                 1)
+CPUID_LEAF_N(0xd,               2,      63)
+CPUID_LEAF(0x16,                0)
+CPUID_LEAF(0x80000000,          0)
+CPUID_LEAF(0x80000005,          0)
+CPUID_LEAF(0x80000006,          0)
+CPUID_LEAF_N(0x8000001d,        0,      7)
\ No newline at end of file
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index c044f7bc7137..2a0d30e13b71 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -153,7 +153,7 @@ struct leaf_query_info {
 
 /**
  * __CPUID_LEAF() - Define CPUID output storage and query info entry
- * @_name:	Struct type name of the CPUID leaf/subleaf (e.g. 'leaf_0x4_0').
+ * @_name:	Struct type name of the CPUID leaf/subleaf (e.g. 'leaf_0x4_n').
  *		Such types are defined at <cpuid/leaf_types.h>, and follow the
  *		format 'struct leaf_0xN_M', where 0xN is the leaf and M is the
  *		subleaf.
@@ -183,19 +183,19 @@ struct leaf_query_info {
  *
  * The example invocation for CPUID(0x4) storage::
  *
- *	__CPUID_LEAF(leaf_0x4_0, 8);
+ *	__CPUID_LEAF(leaf_0x4_n, 8);
  *
  * generates storage entries in the form:
  *
- *	struct leaf_0x4_0		leaf_0x4_0[8];
- *	struct leaf_query_info		leaf_0x4_0_info;
+ *	struct leaf_0x4_n		leaf_0x4_n[8];
+ *	struct leaf_query_info		leaf_0x4_n_info;
  *
- * where the 'leaf_0x4_0[8]' storage array can accommodate the output of
+ * where the 'leaf_0x4_n[8]' storage array can accommodate the output of
  * CPUID(0x4) subleaves 0->7, since they all have the same output format.
  */
 #define __CPUID_LEAF(_name, _count)				\
 	struct _name		_name[_count];			\
-	struct leaf_query_info	_name##_info
+	struct leaf_query_info	_name##_info;
 
 /**
  * CPUID_LEAF() - Define a CPUID storage entry in 'struct cpuid_leaves'
@@ -205,23 +205,30 @@ struct leaf_query_info {
  *
  * Convenience wrapper around __CPUID_LEAF().
  */
-#define CPUID_LEAF(_leaf, _subleaf, _count)			\
-	__CPUID_LEAF(leaf_ ## _leaf ## _ ## _subleaf, _count)
+#define CPUID_LEAF(_leaf, _subleaf)			\
+	__CPUID_LEAF(leaf_ ## _leaf ## _ ## _subleaf, 1)
+
+#define CPUID_LEAF_N(_leaf, _first, _last)		\
+	__CPUID_LEAF(leaf_ ## _leaf ## _n, _last - _first + 1)
+
+
 
 /*
  * struct cpuid_leaves - Structured CPUID data repository
  */
 struct cpuid_leaves {
-	/*         leaf		subleaf		count */
-	CPUID_LEAF(0x0,		0,		1);
-	CPUID_LEAF(0x1,		0,		1);
-	CPUID_LEAF(0x2,		0,		1);
-	CPUID_LEAF(0x4,		0,		8);
-	CPUID_LEAF(0x16,	0,		1);
-	CPUID_LEAF(0x80000000,	0,		1);
-	CPUID_LEAF(0x80000005,	0,		1);
-	CPUID_LEAF(0x80000006,	0,		1);
-	CPUID_LEAF(0x8000001d,	0,		8);
+#include "leaf_defs.h"
+};
+
+#undef CPUID_LEAF
+#undef CPUID_LEAF_N
+#define CPUID_LEAF(_leaf, _subleaf)
+#define CPUID_LEAF_N(_leaf, _first, _last)		\
+	CPUID_LEAF_ ## _leaf ## _N_FIRST = _first,	\
+	CPUID_LEAF_ ## _leaf ## _N_LAST  = _last,
+
+enum cpuid_dynamic_leaf_ranges {
+#include "leaf_defs.h"
 };
 
 /*

base-commit: 2f267fb52973ddf5949127628a4338d4d976ff11
--

