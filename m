Return-Path: <linux-kernel+bounces-792692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1EB3C7B0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7504F5A2843
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31D275AE9;
	Sat, 30 Aug 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD8yZ6Aq"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026D1F3B8A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526077; cv=none; b=VQlAxkJsBqNfR3dNim9i32OJsnYZOaq8d+ptizEO+p3xYcxHjK5b3JeF+dY/6YUl+8RhVnHWUUkrG2AOQhrvaRCRdTk/FbtaefR9kO0ilABlKu7S8sbkifiCFNCGqYv9shc/hvww7gULmJcKm7xaQErE6LMD6vaguJAeNJ5fEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526077; c=relaxed/simple;
	bh=m80PSSFoKL6ff0xviWVNqpPA5jXahAldB8L+an1FMc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjKgUN+I8t62CU7Qd8syd5+cSsNqq+RcAmUneq3e+3KPWjmyw2UN0NMKMfdhwSO7X966SiydXL18uuQQ0ApLISDJaN1gYWGJueVZ+AMc6Iz+Ue52he9GkGqXewyfeaRaK6+a+KqgyT/qvKakWEwGrrBWRg7K+Ths1pyZHIWca5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD8yZ6Aq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e67c95so3027643a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756526075; x=1757130875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHFGo9W7eW3FNHqfM+6lf2O3Swyw6p57AIvNgz1gl98=;
        b=LD8yZ6Aqv9FvR36igECFbzm/5sJgWJ8PtcqbqQYgwsJ+uzNE4XyvPX7DSE2QDSXvd6
         WxTMh4NrDomtOkNfjP5qVGV8IbQbRdi3aRjEdnxyPSiyRfOP+SNILnJf1JaH+jE4Xhta
         tXlbF5LxRh3V0qOlJ4Gq7IOmUS0OS85jAEKHIhEWWdyMECcOruZiPJV6AiM1EuwGV32t
         22H5YInZnNS91mcMHf1DnKazGCjyHh2o7AShdGWsD35ksvqzX8HXC8RpXmIMyGSDR+DU
         LzTGfOfKpaoQP00YKR0R/KZki2flXBZeD9LumHXjlUlUg/6Yk34PXlo/CEeKqOzz4p8D
         EOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756526075; x=1757130875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHFGo9W7eW3FNHqfM+6lf2O3Swyw6p57AIvNgz1gl98=;
        b=UiOn6FND/b5erkw8PjjRJa3GfNfhYFuVrDdC3jTVHaBUjluhvqfCHTczbcQodGt4wb
         5RGmXOahktcoV/PvgfAudgDWNZuM/rtE1ZSt06n6GQJhFcpxd8OOBDMSYP5gA0bFOBvt
         ZIDu9gvcgnSa4dXp4rHGcJa/+drCWb6HcF+yU5TOZF4bdhaknz62IXXgOblGll2zLzuO
         Phys2dYywCxznK/w0YEvKmOtXGjKRWUxYSOVL0Naud6fU2trxIoYZQWnKrF5gaadJ0pb
         1PWv6/DLkOraB7mskoOh7e49juRiasyYKILoZjXip75NIhN90AnBBQrefUPMYVRoL2J2
         Gi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjnWMdhzASs0aWTXAHq2i1knBm0MbOWX+sEq7n79z2rYCSOZHGTEmLlhiSDH64tHWUy0yBPO5W9+/ae0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ18eKBnEPaxGCRbAakhucH+Y8OrvjqwQnWQdZ72nyogOd9vg
	imbJz7zcWxgiSQZYS26uHkSDY47tL3575vd4NwTN51pRSr95paX8q3Sl
X-Gm-Gg: ASbGnctf2gXou7N91agau404Spa42yo+/Buf5HqjIy8KiIEe5jlF3wUQFfeW9YdbzmJ
	TVz93DzHgEM3r/LuUVztJefnsnTC2L7f4QtAos/rCbfuZlamvGgOgE/QZTluL4gO4xKax4jbjy3
	BC4SkMan5yTsvng90ZLaCGRt+TrzT2fvYIGZsJj9s7rL1aAC22FfgVZT3bsaWK7Av01TG7Ncg1w
	rPUoza/Kypp9VQTjDqUsJPHgdTTHxauFJMtnFL1RJ40lW6jnRh+pgtkG7pvkqQA5w8/bh0r1z/U
	QqMbo5UdZFu2tllrR1jXtu0bWwgaPPCyoLfm1u/POJUBMSj7v/8WFqOPnajkOrU7sR1akGtnhCu
	qrbinLiOL6u8emPsZw1nquCIKTg==
X-Google-Smtp-Source: AGHT+IHGvPGfY1Eh9xgyGS4B/7DmMYIqJ7fgl+mSwic2lFnNCUiCLH7BqElvIv4cVFuD8lOlXnBNQg==
X-Received: by 2002:a17:90b:4f8c:b0:327:fd72:bd6a with SMTP id 98e67ed59e1d1-328156e2dd2mr1232775a91.29.1756526075521;
        Fri, 29 Aug 2025 20:54:35 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90ee17sm4279879a91.24.2025.08.29.20.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 20:54:34 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC 8/8] powerpc/book3s64/slb: Add slb faults to vmstat
Date: Sat, 30 Aug 2025 09:21:47 +0530
Message-ID: <e05ac86618d8a52feccf5bac99da44b11871382c.1756522067.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756522067.git.ritesh.list@gmail.com>
References: <cover.1756522067.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were good optimization written in past which reduces the number of
slb faults e.g. during context switches [1]. However if one wants to
measure total number of slb faults then there is no easy way of
measuring one e.g. number of slb faults during bootup.

This adds slb faults as part of vmstat counter to easily measure total
number of slb faults for book3s64.

Note: slb fault handling is defined as raw interrupt handler which says:
 * raw interrupt handlers must not enable or disable interrupts, or
 * schedule, tracing and instrumentation (ftrace, lockdep, etc) would
 * not be advisable either, although may be possible in a pinch, the
 * trace will look odd at least.

Hence adding a vmstat counter looks a plausible and safe option, to at-
least measure the number of slb kernel & user faults in the system.

[1]: https://lore.kernel.org/all/20181013131836.26764-4-mpe@ellerman.id.au/


Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/slb.c | 3 +++
 include/linux/vm_event_item.h  | 4 ++++
 mm/vmstat.c                    | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index 297ab0e93c1e..064427af63f7 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -22,6 +22,7 @@
 #include <linux/context_tracking.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
+#include <linux/vmstat.h>

 #include <asm/udbg.h>
 #include <asm/text-patching.h>
@@ -780,6 +781,7 @@ DEFINE_INTERRUPT_HANDLER_RAW(do_slb_fault)
 #ifdef CONFIG_DEBUG_VM
 		local_paca->in_kernel_slb_handler = 0;
 #endif
+		count_vm_event(SLB_KERNEL_FAULTS);
 		return err;
 	} else {
 		struct mm_struct *mm = current->mm;
@@ -792,6 +794,7 @@ DEFINE_INTERRUPT_HANDLER_RAW(do_slb_fault)
 		if (!err)
 			preload_add(current_thread_info(), ea);

+		count_vm_event(SLB_USER_FAULTS);
 		return err;
 	}
 }
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 9e15a088ba38..8aa34d0eee3b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -156,6 +156,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		DIRECT_MAP_LEVEL2_COLLAPSE,
 		DIRECT_MAP_LEVEL3_COLLAPSE,
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+		SLB_KERNEL_FAULTS,
+		SLB_USER_FAULTS,
+#endif
 #ifdef CONFIG_PER_VMA_LOCK_STATS
 		VMA_LOCK_SUCCESS,
 		VMA_LOCK_ABORT,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..8cd17a5fc72b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1464,6 +1464,11 @@ const char * const vmstat_text[] = {
 	[I(DIRECT_MAP_LEVEL2_COLLAPSE)]		= "direct_map_level2_collapses",
 	[I(DIRECT_MAP_LEVEL3_COLLAPSE)]		= "direct_map_level3_collapses",
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	"slb_kernel_faults",
+	"slb_user_faults",
+#endif
+
 #ifdef CONFIG_PER_VMA_LOCK_STATS
 	[I(VMA_LOCK_SUCCESS)]			= "vma_lock_success",
 	[I(VMA_LOCK_ABORT)]			= "vma_lock_abort",
--
2.50.1


