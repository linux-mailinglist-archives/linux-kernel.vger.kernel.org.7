Return-Path: <linux-kernel+bounces-846920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F60BC96D9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6084E6DD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAE2EA165;
	Thu,  9 Oct 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="OGTwqANv";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="yhI8MTGl"
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7771E47A3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=38.105.200.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018831; cv=none; b=kq9yelaV9Khjyxp5Fz0LJzvKHnIIq8LSq4an4jrU7RL4xBlVhIBzhrZyn76IWi8ETt4EqBm9VkKYrbBdxXO6SlROLXI7cZSA0nHr5dDgarS7xX0BeqagTbe3cTwTVJPZE2ko7MPT6TCOuzNPSRJHM4utZEr/wck6MLMwTkDB0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018831; c=relaxed/simple;
	bh=EgpiNH8L5mpdh+C9kOLKNToBoxv+cQJ6WxzQgR6UJA0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JszuRx0iB80iSnUTzdnyDKi0AaoQOEPHfBxaByXpBoJ/mLJPOTS7O82YhtOH0recpYz2smhVBDDG1TtauvW4HVomxB0gC7+GUI1omv2+xYIvVtl4vXINUJNkWssK3li+LUy4BqOrLMfmfWl0bb51HRsOD4ZsCrvldrVGWDjSVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=OGTwqANv; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=yhI8MTGl; arc=none smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Received: from mail-lj1-f197.google.com ([209.85.208.197])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.98.2)
 	id 1v6rDA-0000000CDpl-0e54
 	for linux-kernel@vger.kernel.org;
 	Thu, 09 Oct 2025 10:01:40 -0400
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-36d7405e232so5264981fa.1
         for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1760018498; x=1760623298; darn=vger.kernel.org;
         h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
          :date:message-id:reply-to;
         bh=KTlhOLFas3vctvLGlVubrBPkZKYx5FNcJX6a9XpkfBE=;
         b=OGTwqANvBMabcUna3ex4o6Nn+xGsQ/ZuEl9lRgi14T0g6u9pkDEmDPsrqnitGp3tce
          +xXyG9C0JulXQV1ggBNjA1lD6p+jbm3JKKaos2trQhrEsQIVoX2yGfOwxqu4b/9gLomu
          MILojXEExaWi0Qw8OF6SnsTgiFbS6Flyq2B6E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1760018500;
  bh=KTlhOLFas3vctvLGlVubrBPkZKYx5FNcJX6a9XpkfBE=;
  h=From:Date:Subject:To:Cc;
  b=yhI8MTGlNDBmCZ/kiyOlLNtT+wV5bqtcna2PpFUWI1ZmBz0O4lKhdX4aD07kL4p9X
  CwU0pI98F9tXknOCxAXdyJ3+MKs8YgLQUK3VyJaxijaR0noF4O6puSLjAdvqWuHlL3
  4h1oTXPIg0NGhAF+4XKrVpk4v8EhLzQyyr+d2bfVBHA9GP1aNSBNSiQy0C20GrFfx4
  dcMBqXTYYUd/MrfohroyUwvnQFgVNvj5nN+czc9RVnzw448eHcFZZeXCCZmM0x1z61
  jfMOWIWsNPJBDoYtBWC6x9ujD6rXMZLzNagcKF1hAqP/AXGxEhZEaKNAxMvGCZNbxH
  Crk/clZedO9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1760018498; x=1760623298;
         h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
          :from:to:cc:subject:date:message-id:reply-to;
         bh=KTlhOLFas3vctvLGlVubrBPkZKYx5FNcJX6a9XpkfBE=;
         b=Jxl22uI32bPGyVP1TC2Wf8mCvdxvzrXueX1zCxUP2yVvjCcm5DcY6pO70n6oOrvtu3
          9qLKFXcRMvFryqBb8bb+ym5+Ty/h8eGxFbewpJoz6KFtYcYXAbWawEY3w92CUd10saFv
          Lh3os6eq0UuwVJtWZ1FlXmaYPG+i/Vy7pn2HQb/gWsUnFRDL/6M0wwQJrh6zA1qTu3JE
          w1tpb672ICMHhaRnRZYnW5rve0+TmCVCKWeRRDxNvMEKI7Ib9QLTK1k9IODvd94XvyY8
          kAbNf53EWt+6HRustXPxYlbDPQv8YLwnTEXMDkbynhMR+JF9J9YvmM+eH17styEuZkd0
          +bqQ==
X-Gm-Message-State: AOJu0YwSShY4LpUUZsoZnY40DelpqxFdq331ttQZhX8ogYLYknifqNiN
 	OjW5HbE4Z2o9wSqWB56P/VJM0P43P3/fQ9PPqKMXDGI408DcDpLYeQD9zjuehhCxak/z6xoKopZ
 	gscfVkJ7wcbBdHTEQbgo+sEh5dPOERJgP10eCQk6+zeeY93ogvNOhGQpbUTPxtuLoxs734fMt4q
 	INa3U4tW2Gg8zjWXNugk5UpBJ1s2UKpWvI2WIb2V/adN4AF+WNfA==
X-Gm-Gg: ASbGnctbTjKpO1ksSm7M9wZWGD8M14+nmLoU0vOGpS7l84ttNPfS+PcAD95zWn8SA4Y
 	KdaMHLAgZMWOVoFSCgHkyS/NIoahyLJkDBuc6jW2Q1cF9jjDEcLjCKUvwBHZrZ3qkO69U4/LPn2
 	bhsg9OgoN1hyH8wtWetF143yYwsw==
X-Received: by 2002:a05:6512:1102:b0:57a:33ff:c7fc with SMTP id 2adb3069b0e04-5906dd73fc4mr2141675e87.48.1760018497685;
         Thu, 09 Oct 2025 07:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ+We7mHEqJW1qXo10QCoxwzq3GNdhewFYOggyMI0JXVRvuH8ABrzXV2Q6bkdzZay6xGkeQswzGp7f1bPepDY=
X-Received: by 2002:a05:6512:1102:b0:57a:33ff:c7fc with SMTP id
  2adb3069b0e04-5906dd73fc4mr2141608e87.48.1760018496526; Thu, 09 Oct 2025
  07:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Dolan <sdolan@janestreet.com>
Date: Thu, 9 Oct 2025 15:01:25 +0100
X-Gm-Features: AS18NWBcwYxLzXyDcosr2bF6UbsNzgs-wNv9W0RwhjKOPI91_tmWhgH6CtZF3Fg
Message-ID: <CAHDw0oGd0B4=uuv8NGqbUQ_ZVmSheU2bN70e4QhFXWvuAZdt2w@mail.gmail.com>
Subject: x86/mm: Finishing off the fix for a should_flush_tlb race
To: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, 
 	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Eric Hagberg <ehagberg@janestreet.com>, 
 	Nick Barnes <nbarnes@janestreet.com>
Content-Type: text/plain; charset="UTF-8"

Back in May, I reported a bug in x86 TLB management, where a race
between a shootdown and a context-switch could leave a process running
with a stale TLB.

This was reported off-list since it seemed like it might be
security-sensitive: in principle, the stale TLB could leak information
from another process. The details were disclosed in CVE-2025-37964. In
practice, the bug is hard to trigger, and when you hit it you generally
get your own stale state (e.g. from before a fork() or an mmap()) rather
than someone else's.

Dave Hansen wrote a fix in this commit:

    commit fea4e317f9e7e1f449ce90dedc27a2d2a95bee5a
    Author: Dave Hansen <dave.hansen@linux.intel.com>
    Date:   Thu May 8 15:41:32 2025 -0700

    x86/mm: Eliminate window where TLB flushes may be inadvertently skipped

which was backported to the 6.1, 6.6 and 6.12 stable trees.

However, there's a minor problem with the original fix and a major
problem with the backported versions, which means that the bug still
reproduces on 6.1, 6.6 and 6.12 stable kernels (as Eric Hagberg, cc'd,
has verified using the repro case at the end of this email), and
theoretically might on the latest tree.

The core of the fix is that:

  - during shootdown, should_flush_tlb checks for LOADED_MM_SWITCHING
    *after* updating tlb_gen

  - during context switch, switch_mm_irqs_off sets LOADED_MM_SWITCHING
    *before* reading tlb_gen

That way, either shootdown sees LOADED_MM_SWITCHING and sends an IPI, or
switch_mm_irqs_off sees the updated tlb_gen. The problem in both cases
is about the *before*-ness in switch_mm_irqs_off:

  - in the latest tree, there isn't enough fencing to enforce this
    ordering.

  - in the stable kernel trees (6.1, 6.6, 6.12), the code is in the
    wrong order.

I've reposted below a patch by Peter Zijlstra and Ingo Molnar for the
first issue, and written a small patch for the stable trees to move the
code into the right place. Both patches and a repro case for the bug are
below.

Thanks,
Stephen



========================>
Subject: x86/mm: Fix SMP ordering in switch_mm_irqs_off()
From:  Peter Zijlstra <peterz@infradead.org>
Date: Mon, 12 May 2025 11:11:34 +0200

Stephen noted that it is possible to not have an smp_mb() between
the loaded_mm store and the tlb_gen load in switch_mm(), meaning the
ordering against flush_tlb_mm_range() goes out the window, and it
becomes possible for switch_mm() to not observe a recent tlb_gen
update and fail to flush the TLBs.

Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
Reported-by: Stephen Dolan <sdolan@janestreet.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Eric Hagberg <ehagberg@janestreet.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Barnes <nbarnes@janestreet.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

Index: tip/arch/x86/mm/tlb.c
===================================================================
--- tip.orig/arch/x86/mm/tlb.c
+++ tip/arch/x86/mm/tlb.c
@@ -911,11 +911,31 @@ void switch_mm_irqs_off(struct mm_struct
                 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
                 */
                this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-               barrier();

-               /* Start receiving IPIs and then read tlb_gen (and LAM below) */
+               /*
+                * Make sure this CPU is set in mm_cpumask() such that we'll
+                * receive invalidation IPIs.
+                *
+                * Rely on the smp_mb() implied by cpumask_set_cpu()'s atomic
+                * operation, or explicitly provide one. Such that:
+                *
+                * switch_mm_irqs_off()
flush_tlb_mm_range()
+                *   smp_store_release(loaded_mm, SWITCHING);
atomic64_inc_return(tlb_gen)
+                *   smp_mb(); // here                            //
smp_mb() implied
+                *   atomic64_read(tlb_gen);
this_cpu_read(loaded_mm);
+                *
+                * we properly order against flush_tlb_mm_range(), where the
+                * loaded_mm load can happen in mative_flush_tlb_multi() ->
+                * should_flush_tlb().
+                *
+                * This way switch_mm() must see the new tlb_gen or
+                * flush_tlb_mm_range() must see the new loaded_mm, or both.
+                */
                if (next != &init_mm && !cpumask_test_cpu(cpu,
mm_cpumask(next)))
                        cpumask_set_cpu(cpu, mm_cpumask(next));
+               else
+                       smp_mb();
+
                next_tlb_gen = atomic64_read(&next->context.tlb_gen);

                ns = choose_new_asid(next, next_tlb_gen);




========================>

Proposed patch for stable kernel trees below.

The issue here is simpler: two code blocks are in the wrong order due to
rebasing across some refactoring.Patch below against 6.12.49, but the
change is the same on 6.1 and 6.6 trees. (In these kernels the
cpumask_test_cpu change wasn't backported, so I don't think the extra
smp_mb check is needed)


From: Stephen Dolan <sdolan@janestreet.com>
Date: Thu, 9 Oct 2025 14:46:47 +0100
Subject: [PATCH] x86/mm: Fix check/use ordering in switch_mm_irqs_off()

To avoid racing with should_flush_tlb, setting loaded_mm to LOADED_MM_SWITCHING
must happen before reading tlb_gen.
---
 arch/x86/mm/tlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8629d90fdcd9..e87ef47cfb09 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -606,6 +606,14 @@ void switch_mm_irqs_off(struct mm_struct *unused,
struct mm_struct *next,
  */
  cond_mitigation(tsk);

+ /*
+ * Indicate that CR3 is about to change. nmi_uaccess_okay()
+ * and others are sensitive to the window where mm_cpumask(),
+ * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
+ */
+ this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+ barrier();
+
  /*
  * Stop remote flushes for the previous mm.
  * Skip kernel threads; we never send init_mm TLB flushing IPIs,
@@ -623,14 +631,6 @@ void switch_mm_irqs_off(struct mm_struct *unused,
struct mm_struct *next,
  next_tlb_gen = atomic64_read(&next->context.tlb_gen);

  choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
- /*
- * Indicate that CR3 is about to change. nmi_uaccess_okay()
- * and others are sensitive to the window where mm_cpumask(),
- * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
- */
- this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
- barrier();
  }

  new_lam = mm_lam_cr3_mask(next);

========================>

/* Reproduction case for the bug */

#include <stdint.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>

_Atomic uint64_t *A, *B;

static void writer()
{
  (*A)++;
  (*B)++;
}

static void reader()
{
  uint64_t b = *B;
  uint64_t a = *A;
  /* Since A is always incremented before B, and we read B first,
     this should never trap */
  if (a < b) __builtin_trap();
}

static void* reader_thread(void* unused)
{
  /* This thread calls reader() repeatedly, but does a context-switch
     to another process after every call */
  int p[2], q[2];
  char buf[1] = "!";
  pipe(p);
  pipe(q);
  pid_t pid = fork();
  if (pid != 0) {
    while (1) {
      reader();
      write(p[1], buf, 1);
      read(q[0], buf, 1);
    }
  } else {
    while (1) {
      read(p[0], buf, 1);
      write(q[1], buf, 1);
    }
  }
}

int main() {
  enum {PAGE = 4096};
  A = mmap(NULL, PAGE, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
  B = mmap(NULL, PAGE, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);

  pthread_t pth;
  pthread_create(&pth, NULL, &reader_thread, NULL);

  /* This calls writer() repeatedly, but before every call it forks.
     This causes *A to be mapped to a COW page and so the write faults to
     allocate a fresh page for *A. (*B is MAP_SHARED, so it does not
become COW).
     The bug is that the reader may fail to see the copied A, and still
     use the old A page while seeing the new B value. */
  while (1) {
    pid_t pid = fork();
    if (pid == 0) {
      _exit(0);
    } else {
      writer();
      wait(NULL);
    }
  }
}

