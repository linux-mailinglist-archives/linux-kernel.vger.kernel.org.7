Return-Path: <linux-kernel+bounces-770929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E1B28097
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D381CE170A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B983301499;
	Fri, 15 Aug 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT9eQDhw"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40082737FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264296; cv=none; b=Ievht3beHQ4ubFZFMfoo6gY2wZNpcefO1NDpLtm8/ryj9OzQPBDoJUj9yeKWRIaMDZ9UzRPTJy7m+iyP8LdCC0Anb58JRCZV1EReMsOAaAZVFB3BOm9GzXlamobkWgyLlLaVJttLvatIwXYwbItUdkgD5Dv4yOBJSuvtIG+lA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264296; c=relaxed/simple;
	bh=5MKujOgrsE23pPkE2WzrI3n9pk6SP573zVk7ftIM3ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XP96s4WWDeLWdGCmo3sqbOrvU+xsWYn3sA3IQPuW/62lEWs94R4w+/2HfHDyeoTZJGQRd0p/AsLAnwHWXAZnKSxEovcIDl/qqxlvkCqjaGRzor7VSjx0bO2t/4k4JxgL9Cbb8TZ/Gf+NsE72sOWH7PQAj4cE0tdiESMP8KfMuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT9eQDhw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so2190020b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755264287; x=1755869087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrrlVCiUPViOjhRDC49It9FKkop6kc78/puZXhBH1m8=;
        b=aT9eQDhwJg6JOeHtMcG4ciCfzl6aJURcS4mEkzjZqDZmY+AyNlsEpdUwL0T4WggKIT
         ytn610HG+tNiiJSQFJSanDaczW9ccbm068g/4j66uCNz+2qQ7wFTJZJuswiLYK3KpWlh
         Px4JAtVo3KOmVOobkVpytE8njWCdkCePZUc+PstVABCN5zYTC7jskX4kohwwveTyn1Gf
         caQtA3gXiXKg5ckuxQ+DB8AM4dL8zwSFb2/IGOnapHxTE9h1J8bCMM66RtNJ1dxxkM5i
         cmUUNQvF8UamaCjP+vg/suH833Jz3uY4jBFLmgRIRSmH63M5y2sbJW157WXFoqB9IKNH
         E7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755264287; x=1755869087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrrlVCiUPViOjhRDC49It9FKkop6kc78/puZXhBH1m8=;
        b=AI7DfUS6jUgs4YHtwl2U+tYKfusl5ViVwJwreDXF2jVqYT5BBjt2VpCSbHV16vut/o
         MLRZhYFGKhko1/VZkCpDOiwYHebsJfcWVA4MirC0hgdQmt4w/KqzPWZMK8eDq3jGcWyh
         zf/OHmoUb8F4Df0x2i4bMfaBvfnRFzU4oW4yHjsuAtGvQ+B3tiPSmzScv6iiDfUuv7Pc
         jaWq4V7HEs3BhWG/FRor+TrlG8Aw/gn9+MNSblxtv8YPgmeJ3JOEFLp4skGEP3JKDKIe
         R8LB6UWwJD/VpYrZl6hpJ64a4WjfMuv20pcezNu4WLMZ5J8sIjACPMT42L8pxGb/wvB7
         o1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgse71l9K+QArDFaU5oP3GEEUdWt4Me+qJNos6nmKDHnb/pxx4i0Z+wutmGMcfjx8ir3iJCDmP8t5qBLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxYvWch/RRKWoDCtljQ/mXmPIuvzcETyrXw2e/nUCyxWEiyJ4
	Kkq/el3MoxXDPLeghsZFxS1cXkwD2Itpm9bRvcnc604uf429lR62/MFB
X-Gm-Gg: ASbGncthQA0NsQQtL0L8OvwobiVPaE7cS4Px4NyADbcpiLkLfhkuC4YJZPNZZ9r6e5M
	ynAeVi/Bi4sdg4YB1RO7jHg5t//j+/yuyOCd0sKwO3rpiEVCKCzwtDSo20RF3MRdPg7/KzER81b
	qvg1K0/a8TcafnhIhpxuIKmzlPNFKmj5cHQZv32t/4X9qQN6QrJ9aaUrqTcFPFa/FlVTfiqO16o
	/VkMfs3i3cpA1IZCfi6n5cEbpwEx1Gc5Yue6mq9jpus6jWY7PyKmUSMHQL/ulBrB9OvxAe3ew4p
	syao8aHkdlDAhwwbh/MrFvzm/2o8of4chSdm+VOpx91ZtvW0cUtb0wfBSBGsg2YrXif+tRcGN0V
	EqPUKl83RDEK5ggOUkd/CamGZatJJnsmV
X-Google-Smtp-Source: AGHT+IGVPBpnpRTd4VSCvcnzNHCHxJS3ESS4hLs+FLjFrQ2t8qU+5xBRiS0p1N5a4yycSf9o86jUPw==
X-Received: by 2002:a05:6a21:9986:b0:233:f0c6:a8a4 with SMTP id adf61e73a8af0-240d2f066a4mr4057573637.31.1755264285165;
        Fri, 15 Aug 2025 06:24:45 -0700 (PDT)
Received: from DESKTOP-TMVN3TV ([124.123.162.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5d4929sm1288516a12.13.2025.08.15.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:24:44 -0700 (PDT)
From: shiva teja sathi <shivateja769@gmail.com>
To: paulmck@kernel.org
Cc: akiyks@gmail.com,
	parri.andrea@gmail.com,
	haakon.bugge@oracle.com,
	linux-kernel@vger.kernel.org,
	shiva teja <shivateja769@gmail.com>
Subject: [PATCH] docs: clarify and improve wording in memory-barriers.txt
Date: Fri, 15 Aug 2025 18:54:34 +0530
Message-ID: <20250815132434.1445-1-shivateja769@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: shiva teja <shivateja769@gmail.com>

Signed-off-by: shiva teja <shivateja769@gmail.com>
---
 Documentation/memory-barriers.txt | 6032 ++++++++++++++---------------
 1 file changed, 3016 insertions(+), 3016 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barri=
ers.txt
index 1d164e005776..16b68caf2370 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1,3016 +1,3016 @@
-			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-			 LINUX KERNEL MEMORY BARRIERS
-			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-
-By: David Howells <dhowells@redhat.com>
-    Paul E. McKenney <paulmck@linux.ibm.com>
-    Will Deacon <will.deacon@arm.com>
-    Peter Zijlstra <peterz@infradead.org>
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-DISCLAIMER
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-This document is not a specification; it is intentionally (for the sake of
-brevity) and unintentionally (due to being human) incomplete. This documen=
t is
-meant as a guide to using the various memory barriers provided by Linux, b=
ut
-in case of any doubt (and there are many) please ask.  Some doubts may be
-resolved by referring to the formal memory consistency model and related
-documentation at tools/memory-model/.  Nevertheless, even this memory
-model should be viewed as the collective opinion of its maintainers rather
-than as an infallible oracle.
-
-To repeat, this document is not a specification of what Linux expects from
-hardware.
-
-The purpose of this document is twofold:
-
- (1) to specify the minimum functionality that one can rely on for any
-     particular barrier, and
-
- (2) to provide a guide as to how to use the barriers that are available.
-
-Note that an architecture can provide more than the minimum requirement
-for any particular barrier, but if the architecture provides less than
-that, that architecture is incorrect.
-
-Note also that it is possible that a barrier may be a no-op for an
-architecture because the way that arch works renders an explicit barrier
-unnecessary in that case.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D
-CONTENTS
-=3D=3D=3D=3D=3D=3D=3D=3D
-
- (*) Abstract memory access model.
-
-     - Device operations.
-     - Guarantees.
-
- (*) What are memory barriers?
-
-     - Varieties of memory barrier.
-     - What may not be assumed about memory barriers?
-     - Address-dependency barriers (historical).
-     - Control dependencies.
-     - SMP barrier pairing.
-     - Examples of memory barrier sequences.
-     - Read memory barriers vs load speculation.
-     - Multicopy atomicity.
-
- (*) Explicit kernel barriers.
-
-     - Compiler barrier.
-     - CPU memory barriers.
-
- (*) Implicit kernel memory barriers.
-
-     - Lock acquisition functions.
-     - Interrupt disabling functions.
-     - Sleep and wake-up functions.
-     - Miscellaneous functions.
-
- (*) Inter-CPU acquiring barrier effects.
-
-     - Acquires vs memory accesses.
-
- (*) Where are memory barriers needed?
-
-     - Interprocessor interaction.
-     - Atomic operations.
-     - Accessing devices.
-     - Interrupts.
-
- (*) Kernel I/O barrier effects.
-
- (*) Assumed minimum execution ordering model.
-
- (*) The effects of the cpu cache.
-
-     - Cache coherency vs DMA.
-     - Cache coherency vs MMIO.
-
- (*) The things CPUs get up to.
-
-     - And then there's the Alpha.
-     - Virtual Machine Guests.
-
- (*) Example uses.
-
-     - Circular buffers.
-
- (*) References.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-ABSTRACT MEMORY ACCESS MODEL
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-Consider the following abstract model of the system:
-
-		            :                :
-		            :                :
-		            :                :
-		+-------+   :   +--------+   :   +-------+
-		|       |   :   |        |   :   |       |
-		|       |   :   |        |   :   |       |
-		| CPU 1 |<----->| Memory |<----->| CPU 2 |
-		|       |   :   |        |   :   |       |
-		|       |   :   |        |   :   |       |
-		+-------+   :   +--------+   :   +-------+
-		    ^       :       ^        :       ^
-		    |       :       |        :       |
-		    |       :       |        :       |
-		    |       :       v        :       |
-		    |       :   +--------+   :       |
-		    |       :   |        |   :       |
-		    |       :   |        |   :       |
-		    +---------->| Device |<----------+
-		            :   |        |   :
-		            :   |        |   :
-		            :   +--------+   :
-		            :                :
-
-Each CPU executes a program that generates memory access operations.  In t=
he
-abstract CPU, memory operation ordering is very relaxed, and a CPU may act=
ually
-perform the memory operations in any order it likes, provided program caus=
ality
-appears to be maintained.  Similarly, the compiler may also arrange the
-instructions it emits in any order it likes, provided it doesn't affect the
-apparent operation of the program.
-
-So in the above diagram, the effects of the memory operations performed by=
 a
-CPU are perceived by the rest of the system as the operations cross the
-interface between the CPU and rest of the system (the dotted lines).
-
-
-For example, consider the following sequence of events:
-
-	CPU 1		CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-	{ A =3D=3D 1; B =3D=3D 2 }
-	A =3D 3;		x =3D B;
-	B =3D 4;		y =3D A;
-
-The set of accesses as seen by the memory system in the middle can be arra=
nged
-in 24 different combinations:
-
-	STORE A=3D3,	STORE B=3D4,	y=3DLOAD A->3,	x=3DLOAD B->4
-	STORE A=3D3,	STORE B=3D4,	x=3DLOAD B->4,	y=3DLOAD A->3
-	STORE A=3D3,	y=3DLOAD A->3,	STORE B=3D4,	x=3DLOAD B->4
-	STORE A=3D3,	y=3DLOAD A->3,	x=3DLOAD B->2,	STORE B=3D4
-	STORE A=3D3,	x=3DLOAD B->2,	STORE B=3D4,	y=3DLOAD A->3
-	STORE A=3D3,	x=3DLOAD B->2,	y=3DLOAD A->3,	STORE B=3D4
-	STORE B=3D4,	STORE A=3D3,	y=3DLOAD A->3,	x=3DLOAD B->4
-	STORE B=3D4, ...
-	...
-
-and can thus result in four different combinations of values:
-
-	x =3D=3D 2, y =3D=3D 1
-	x =3D=3D 2, y =3D=3D 3
-	x =3D=3D 4, y =3D=3D 1
-	x =3D=3D 4, y =3D=3D 3
-
-
-Furthermore, the stores committed by a CPU to the memory system may not be
-perceived by the loads made by another CPU in the same order as the stores=
 were
-committed.
-
-
-As a further example, consider this sequence of events:
-
-	CPU 1		CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-	{ A =3D=3D 1, B =3D=3D 2, C =3D=3D 3, P =3D=3D &A, Q =3D=3D &C }
-	B =3D 4;		Q =3D P;
-	P =3D &B;		D =3D *Q;
-
-There is an obvious address dependency here, as the value loaded into D de=
pends
-on the address retrieved from P by CPU 2.  At the end of the sequence, any=
 of
-the following results are possible:
-
-	(Q =3D=3D &A) and (D =3D=3D 1)
-	(Q =3D=3D &B) and (D =3D=3D 2)
-	(Q =3D=3D &B) and (D =3D=3D 4)
-
-Note that CPU 2 will never try and load C into D because the CPU will load=
 P
-into Q before issuing the load of *Q.
-
-
-DEVICE OPERATIONS
------------------
-
-Some devices present their control interfaces as collections of memory
-locations, but the order in which the control registers are accessed is ve=
ry
-important.  For instance, imagine an ethernet card with a set of internal
-registers that are accessed through an address port register (A) and a data
-port register (D).  To read internal register 5, the following code might =
then
-be used:
-
-	*A =3D 5;
-	x =3D *D;
-
-but this might show up as either of the following two sequences:
-
-	STORE *A =3D 5, x =3D LOAD *D
-	x =3D LOAD *D, STORE *A =3D 5
-
-the second of which will almost certainly result in a malfunction, since i=
t set
-the address _after_ attempting to read the register.
-
-
-GUARANTEES
-----------
-
-There are some minimal guarantees that may be expected of a CPU:
-
- (*) On any given CPU, dependent memory accesses will be issued in order, =
with
-     respect to itself.  This means that for:
-
-	Q =3D READ_ONCE(P); D =3D READ_ONCE(*Q);
-
-     the CPU will issue the following memory operations:
-
-	Q =3D LOAD P, D =3D LOAD *Q
-
-     and always in that order.  However, on DEC Alpha, READ_ONCE() also
-     emits a memory-barrier instruction, so that a DEC Alpha CPU will
-     instead issue the following memory operations:
-
-	Q =3D LOAD P, MEMORY_BARRIER, D =3D LOAD *Q, MEMORY_BARRIER
-
-     Whether on DEC Alpha or not, the READ_ONCE() also prevents compiler
-     mischief.
-
- (*) Overlapping loads and stores within a particular CPU will appear to be
-     ordered within that CPU.  This means that for:
-
-	a =3D READ_ONCE(*X); WRITE_ONCE(*X, b);
-
-     the CPU will only issue the following sequence of memory operations:
-
-	a =3D LOAD *X, STORE *X =3D b
-
-     And for:
-
-	WRITE_ONCE(*X, c); d =3D READ_ONCE(*X);
-
-     the CPU will only issue:
-
-	STORE *X =3D c, d =3D LOAD *X
-
-     (Loads and stores overlap if they are targeted at overlapping pieces =
of
-     memory).
-
-And there are a number of things that _must_ or _must_not_ be assumed:
-
- (*) It _must_not_ be assumed that the compiler will do what you want
-     with memory references that are not protected by READ_ONCE() and
-     WRITE_ONCE().  Without them, the compiler is within its rights to
-     do all sorts of "creative" transformations, which are covered in
-     the COMPILER BARRIER section.
-
- (*) It _must_not_ be assumed that independent loads and stores will be is=
sued
-     in the order given.  This means that for:
-
-	X =3D *A; Y =3D *B; *D =3D Z;
-
-     we may get any of the following sequences:
-
-	X =3D LOAD *A,  Y =3D LOAD *B,  STORE *D =3D Z
-	X =3D LOAD *A,  STORE *D =3D Z, Y =3D LOAD *B
-	Y =3D LOAD *B,  X =3D LOAD *A,  STORE *D =3D Z
-	Y =3D LOAD *B,  STORE *D =3D Z, X =3D LOAD *A
-	STORE *D =3D Z, X =3D LOAD *A,  Y =3D LOAD *B
-	STORE *D =3D Z, Y =3D LOAD *B,  X =3D LOAD *A
-
- (*) It _must_ be assumed that overlapping memory accesses may be merged or
-     discarded.  This means that for:
-
-	X =3D *A; Y =3D *(A + 4);
-
-     we may get any one of the following sequences:
-
-	X =3D LOAD *A; Y =3D LOAD *(A + 4);
-	Y =3D LOAD *(A + 4); X =3D LOAD *A;
-	{X, Y} =3D LOAD {*A, *(A + 4) };
-
-     And for:
-
-	*A =3D X; *(A + 4) =3D Y;
-
-     we may get any of:
-
-	STORE *A =3D X; STORE *(A + 4) =3D Y;
-	STORE *(A + 4) =3D Y; STORE *A =3D X;
-	STORE {*A, *(A + 4) } =3D {X, Y};
-
-And there are anti-guarantees:
-
- (*) These guarantees do not apply to bitfields, because compilers often
-     generate code to modify these using non-atomic read-modify-write
-     sequences.  Do not attempt to use bitfields to synchronize parallel
-     algorithms.
-
- (*) Even in cases where bitfields are protected by locks, all fields
-     in a given bitfield must be protected by one lock.  If two fields
-     in a given bitfield are protected by different locks, the compiler's
-     non-atomic read-modify-write sequences can cause an update to one
-     field to corrupt the value of an adjacent field.
-
- (*) These guarantees apply only to properly aligned and sized scalar
-     variables.  "Properly sized" currently means variables that are
-     the same size as "char", "short", "int" and "long".  "Properly
-     aligned" means the natural alignment, thus no constraints for
-     "char", two-byte alignment for "short", four-byte alignment for
-     "int", and either four-byte or eight-byte alignment for "long",
-     on 32-bit and 64-bit systems, respectively.  Note that these
-     guarantees were introduced into the C11 standard, so beware when
-     using older pre-C11 compilers (for example, gcc 4.6).  The portion
-     of the standard containing this guarantee is Section 3.14, which
-     defines "memory location" as follows:
-
-     	memory location
-		either an object of scalar type, or a maximal sequence
-		of adjacent bit-fields all having nonzero width
-
-		NOTE 1: Two threads of execution can update and access
-		separate memory locations without interfering with
-		each other.
-
-		NOTE 2: A bit-field and an adjacent non-bit-field member
-		are in separate memory locations. The same applies
-		to two bit-fields, if one is declared inside a nested
-		structure declaration and the other is not, or if the two
-		are separated by a zero-length bit-field declaration,
-		or if they are separated by a non-bit-field member
-		declaration. It is not safe to concurrently update two
-		bit-fields in the same structure if all members declared
-		between them are also bit-fields, no matter what the
-		sizes of those intervening bit-fields happen to be.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-WHAT ARE MEMORY BARRIERS?
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-As can be seen above, independent memory operations are effectively perfor=
med
-in random order, but this can be a problem for CPU-CPU interaction and for=
 I/O.
-What is required is some way of intervening to instruct the compiler and t=
he
-CPU to restrict the order.
-
-Memory barriers are such interventions.  They impose a perceived partial
-ordering over the memory operations on either side of the barrier.
-
-Such enforcement is important because the CPUs and other devices in a syst=
em
-can use a variety of tricks to improve performance, including reordering,
-deferral and combination of memory operations; speculative loads; speculat=
ive
-branch prediction and various types of caching.  Memory barriers are used =
to
-override or suppress these tricks, allowing the code to sanely control the
-interaction of multiple CPUs and/or devices.
-
-
-VARIETIES OF MEMORY BARRIER
----------------------------
-
-Memory barriers come in four basic varieties:
-
- (1) Write (or store) memory barriers.
-
-     A write memory barrier gives a guarantee that all the STORE operations
-     specified before the barrier will appear to happen before all the STO=
RE
-     operations specified after the barrier with respect to the other
-     components of the system.
-
-     A write barrier is a partial ordering on stores only; it is not requi=
red
-     to have any effect on loads.
-
-     A CPU can be viewed as committing a sequence of store operations to t=
he
-     memory system as time progresses.  All stores _before_ a write barrier
-     will occur _before_ all the stores after the write barrier.
-
-     [!] Note that write barriers should normally be paired with read or
-     address-dependency barriers; see the "SMP barrier pairing" subsection.
-
-
- (2) Address-dependency barriers (historical).
-     [!] This section is marked as HISTORICAL: it covers the long-obsolete
-     smp_read_barrier_depends() macro, the semantics of which are now
-     implicit in all marked accesses.  For more up-to-date information,
-     including how compiler transformations can sometimes break address
-     dependencies, see Documentation/RCU/rcu_dereference.rst.
-
-     An address-dependency barrier is a weaker form of read barrier.  In t=
he
-     case where two loads are performed such that the second depends on the
-     result of the first (eg: the first load retrieves the address to which
-     the second load will be directed), an address-dependency barrier would
-     be required to make sure that the target of the second load is updated
-     after the address obtained by the first load is accessed.
-
-     An address-dependency barrier is a partial ordering on interdependent
-     loads only; it is not required to have any effect on stores, independ=
ent
-     loads or overlapping loads.
-
-     As mentioned in (1), the other CPUs in the system can be viewed as
-     committing sequences of stores to the memory system that the CPU being
-     considered can then perceive.  An address-dependency barrier issued by
-     the CPU under consideration guarantees that for any load preceding it,
-     if that load touches one of a sequence of stores from another CPU, th=
en
-     by the time the barrier completes, the effects of all the stores prio=
r to
-     that touched by the load will be perceptible to any loads issued after
-     the address-dependency barrier.
-
-     See the "Examples of memory barrier sequences" subsection for diagrams
-     showing the ordering constraints.
-
-     [!] Note that the first load really has to have an _address_ dependen=
cy and
-     not a control dependency.  If the address for the second load is depe=
ndent
-     on the first load, but the dependency is through a conditional rather=
 than
-     actually loading the address itself, then it's a _control_ dependency=
 and
-     a full read barrier or better is required.  See the "Control dependen=
cies"
-     subsection for more information.
-
-     [!] Note that address-dependency barriers should normally be paired w=
ith
-     write barriers; see the "SMP barrier pairing" subsection.
-
-     [!] Kernel release v5.9 removed kernel APIs for explicit address-
-     dependency barriers.  Nowadays, APIs for marking loads from shared
-     variables such as READ_ONCE() and rcu_dereference() provide implicit
-     address-dependency barriers.
-
- (3) Read (or load) memory barriers.
-
-     A read barrier is an address-dependency barrier plus a guarantee that=
 all
-     the LOAD operations specified before the barrier will appear to happen
-     before all the LOAD operations specified after the barrier with respe=
ct to
-     the other components of the system.
-
-     A read barrier is a partial ordering on loads only; it is not require=
d to
-     have any effect on stores.
-
-     Read memory barriers imply address-dependency barriers, and so can
-     substitute for them.
-
-     [!] Note that read barriers should normally be paired with write barr=
iers;
-     see the "SMP barrier pairing" subsection.
-
-
- (4) General memory barriers.
-
-     A general memory barrier gives a guarantee that all the LOAD and STORE
-     operations specified before the barrier will appear to happen before =
all
-     the LOAD and STORE operations specified after the barrier with respec=
t to
-     the other components of the system.
-
-     A general memory barrier is a partial ordering over both loads and st=
ores.
-
-     General memory barriers imply both read and write memory barriers, an=
d so
-     can substitute for either.
-
-
-And a couple of implicit varieties:
-
- (5) ACQUIRE operations.
-
-     This acts as a one-way permeable barrier.  It guarantees that all mem=
ory
-     operations after the ACQUIRE operation will appear to happen after the
-     ACQUIRE operation with respect to the other components of the system.
-     ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_load_acquire() operations.
-
-     Memory operations that occur before an ACQUIRE operation may appear to
-     happen after it completes.
-
-     An ACQUIRE operation should almost always be paired with a RELEASE
-     operation.
-
-
- (6) RELEASE operations.
-
-     This also acts as a one-way permeable barrier.  It guarantees that all
-     memory operations before the RELEASE operation will appear to happen
-     before the RELEASE operation with respect to the other components of =
the
-     system. RELEASE operations include UNLOCK operations and
-     smp_store_release() operations.
-
-     Memory operations that occur after a RELEASE operation may appear to
-     happen before it completes.
-
-     The use of ACQUIRE and RELEASE operations generally precludes the need
-     for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE pa=
ir is
-     -not- guaranteed to act as a full memory barrier.  However, after an
-     ACQUIRE on a given variable, all memory accesses preceding any prior
-     RELEASE on that same variable are guaranteed to be visible.  In other
-     words, within a given variable's critical section, all accesses of all
-     previous critical sections for that variable are guaranteed to have
-     completed.
-
-     This means that ACQUIRE acts as a minimal "acquire" operation and
-     RELEASE acts as a minimal "release" operation.
-
-A subset of the atomic operations described in atomic_t.txt have ACQUIRE a=
nd
-RELEASE variants in addition to fully-ordered and relaxed (no barrier
-semantics) definitions.  For compound atomics performing both a load and a
-store, ACQUIRE semantics apply only to the load and RELEASE semantics apply
-only to the store portion of the operation.
-
-Memory barriers are only required where there's a possibility of interacti=
on
-between two CPUs or between a CPU and a device.  If it can be guaranteed t=
hat
-there won't be any such interaction in any particular piece of code, then
-memory barriers are unnecessary in that piece of code.
-
-
-Note that these are the _minimum_ guarantees.  Different architectures may=
 give
-more substantial guarantees, but they may _not_ be relied upon outside of =
arch
-specific code.
-
-
-WHAT MAY NOT BE ASSUMED ABOUT MEMORY BARRIERS?
-----------------------------------------------
-
-There are certain things that the Linux kernel memory barriers do not guar=
antee:
-
- (*) There is no guarantee that any of the memory accesses specified befor=
e a
-     memory barrier will be _complete_ by the completion of a memory barri=
er
-     instruction; the barrier can be considered to draw a line in that CPU=
's
-     access queue that accesses of the appropriate type may not cross.
-
- (*) There is no guarantee that issuing a memory barrier on one CPU will h=
ave
-     any direct effect on another CPU or any other hardware in the system.=
  The
-     indirect effect will be the order in which the second CPU sees the ef=
fects
-     of the first CPU's accesses occur, but see the next point:
-
- (*) There is no guarantee that a CPU will see the correct order of effects
-     from a second CPU's accesses, even _if_ the second CPU uses a memory
-     barrier, unless the first CPU _also_ uses a matching memory barrier (=
see
-     the subsection on "SMP Barrier Pairing").
-
- (*) There is no guarantee that some intervening piece of off-the-CPU
-     hardware[*] will not reorder the memory accesses.  CPU cache coherency
-     mechanisms should propagate the indirect effects of a memory barrier
-     between CPUs, but might not do so in order.
-
-	[*] For information on bus mastering DMA and coherency please read:
-
-	    Documentation/driver-api/pci/pci.rst
-	    Documentation/core-api/dma-api-howto.rst
-	    Documentation/core-api/dma-api.rst
-
-
-ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
-----------------------------------------
-[!] This section is marked as HISTORICAL: it covers the long-obsolete
-smp_read_barrier_depends() macro, the semantics of which are now implicit
-in all marked accesses.  For more up-to-date information, including
-how compiler transformations can sometimes break address dependencies,
-see Documentation/RCU/rcu_dereference.rst.
-
-As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
-DEC Alpha, which means that about the only people who need to pay attention
-to this section are those working on DEC Alpha architecture-specific code
-and those working on READ_ONCE() itself.  For those who need it, and for
-those who are interested in the history, here is the story of
-address-dependency barriers.
-
-[!] While address dependencies are observed in both load-to-load and
-load-to-store relations, address-dependency barriers are not necessary
-for load-to-store situations.
-
-The requirement of address-dependency barriers is a little subtle, and
-it's not always obvious that they're needed.  To illustrate, consider the
-following sequence of events:
-
-	CPU 1		      CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-	{ A =3D=3D 1, B =3D=3D 2, C =3D=3D 3, P =3D=3D &A, Q =3D=3D &C }
-	B =3D 4;
-	<write barrier>
-	WRITE_ONCE(P, &B);
-			      Q =3D READ_ONCE_OLD(P);
-			      D =3D *Q;
-
-[!] READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which
-doesn't imply an address-dependency barrier.
-
-There's a clear address dependency here, and it would seem that by the end=
 of
-the sequence, Q must be either &A or &B, and that:
-
-	(Q =3D=3D &A) implies (D =3D=3D 1)
-	(Q =3D=3D &B) implies (D =3D=3D 4)
-
-But!  CPU 2's perception of P may be updated _before_ its perception of B,=
 thus
-leading to the following situation:
-
-	(Q =3D=3D &B) and (D =3D=3D 2) ????
-
-While this may seem like a failure of coherency or causality maintenance, =
it
-isn't, and this behaviour can be observed on certain real CPUs (such as th=
e DEC
-Alpha).
-
-To deal with this, READ_ONCE() provides an implicit address-dependency bar=
rier
-since kernel release v4.15:
-
-	CPU 1		      CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-	{ A =3D=3D 1, B =3D=3D 2, C =3D=3D 3, P =3D=3D &A, Q =3D=3D &C }
-	B =3D 4;
-	<write barrier>
-	WRITE_ONCE(P, &B);
-			      Q =3D READ_ONCE(P);
-			      <implicit address-dependency barrier>
-			      D =3D *Q;
-
-This enforces the occurrence of one of the two implications, and prevents =
the
-third possibility from arising.
-
-
-[!] Note that this extremely counterintuitive situation arises most easily=
 on
-machines with split caches, so that, for example, one cache bank processes
-even-numbered cache lines and the other bank processes odd-numbered cache
-lines.  The pointer P might be stored in an odd-numbered cache line, and t=
he
-variable B might be stored in an even-numbered cache line.  Then, if the
-even-numbered bank of the reading CPU's cache is extremely busy while the
-odd-numbered bank is idle, one can see the new value of the pointer P (&B),
-but the old value of the variable B (2).
-
-
-An address-dependency barrier is not required to order dependent writes
-because the CPUs that the Linux kernel supports don't do writes until they
-are certain (1) that the write will actually happen, (2) of the location of
-the write, and (3) of the value to be written.
-But please carefully read the "CONTROL DEPENDENCIES" section and the
-Documentation/RCU/rcu_dereference.rst file:  The compiler can and does bre=
ak
-dependencies in a great many highly creative ways.
-
-	CPU 1		      CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-	{ A =3D=3D 1, B =3D=3D 2, C =3D 3, P =3D=3D &A, Q =3D=3D &C }
-	B =3D 4;
-	<write barrier>
-	WRITE_ONCE(P, &B);
-			      Q =3D READ_ONCE_OLD(P);
-			      WRITE_ONCE(*Q, 5);
-
-Therefore, no address-dependency barrier is required to order the read into
-Q with the store into *Q.  In other words, this outcome is prohibited,
-even without an implicit address-dependency barrier of modern READ_ONCE():
-
-	(Q =3D=3D &B) && (B =3D=3D 4)
-
-Please note that this pattern should be rare.  After all, the whole point
-of dependency ordering is to -prevent- writes to the data structure, along
-with the expensive cache misses associated with those writes.  This pattern
-can be used to record rare error conditions and the like, and the CPUs'
-naturally occurring ordering prevents such records from being lost.
-
-
-Note well that the ordering provided by an address dependency is local to
-the CPU containing it.  See the section on "Multicopy atomicity" for
-more information.
-
-
-The address-dependency barrier is very important to the RCU system,
-for example.  See rcu_assign_pointer() and rcu_dereference() in
-include/linux/rcupdate.h.  This permits the current target of an RCU'd
-pointer to be replaced with a new modified target, without the replacement
-target appearing to be incompletely initialised.
-
-
-CONTROL DEPENDENCIES
---------------------
-
-Control dependencies can be a bit tricky because current compilers do
-not understand them.  The purpose of this section is to help you prevent
-the compiler's ignorance from breaking your code.
-
-A load-load control dependency requires a full read memory barrier, not
-simply an (implicit) address-dependency barrier to make it work correctly.
-Consider the following bit of code:
-
-	q =3D READ_ONCE(a);
-	<implicit address-dependency barrier>
-	if (q) {
-		/* BUG: No address dependency!!! */
-		p =3D READ_ONCE(b);
-	}
-
-This will not have the desired effect because there is no actual address
-dependency, but rather a control dependency that the CPU may short-circuit
-by attempting to predict the outcome in advance, so that other CPUs see
-the load from b as having happened before the load from a.  In such a case
-what's actually required is:
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		<read barrier>
-		p =3D READ_ONCE(b);
-	}
-
-However, stores are not speculated.  This means that ordering -is- provided
-for load-store control dependencies, as in the following example:
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		WRITE_ONCE(b, 1);
-	}
-
-Control dependencies pair normally with other types of barriers.
-That said, please note that neither READ_ONCE() nor WRITE_ONCE()
-are optional! Without the READ_ONCE(), the compiler might combine the
-load from 'a' with other loads from 'a'.  Without the WRITE_ONCE(),
-the compiler might combine the store to 'b' with other stores to 'b'.
-Either can result in highly counterintuitive effects on ordering.
-
-Worse yet, if the compiler is able to prove (say) that the value of
-variable 'a' is always non-zero, it would be well within its rights
-to optimize the original example by eliminating the "if" statement
-as follows:
-
-	q =3D a;
-	b =3D 1;  /* BUG: Compiler and CPU can both reorder!!! */
-
-So don't leave out the READ_ONCE().
-
-It is tempting to try to enforce ordering on identical stores on both
-branches of the "if" statement as follows:
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		barrier();
-		WRITE_ONCE(b, 1);
-		do_something();
-	} else {
-		barrier();
-		WRITE_ONCE(b, 1);
-		do_something_else();
-	}
-
-Unfortunately, current compilers will transform this as follows at high
-optimization levels:
-
-	q =3D READ_ONCE(a);
-	barrier();
-	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */
-	if (q) {
-		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
-		do_something();
-	} else {
-		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
-		do_something_else();
-	}
-
-Now there is no conditional between the load from 'a' and the store to
-'b', which means that the CPU is within its rights to reorder them:
-The conditional is absolutely required, and must be present in the
-assembly code even after all compiler optimizations have been applied.
-Therefore, if you need ordering in this example, you need explicit
-memory barriers, for example, smp_store_release():
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		smp_store_release(&b, 1);
-		do_something();
-	} else {
-		smp_store_release(&b, 1);
-		do_something_else();
-	}
-
-In contrast, without explicit memory barriers, two-legged-if control
-ordering is guaranteed only when the stores differ, for example:
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		WRITE_ONCE(b, 1);
-		do_something();
-	} else {
-		WRITE_ONCE(b, 2);
-		do_something_else();
-	}
-
-The initial READ_ONCE() is still required to prevent the compiler from
-proving the value of 'a'.
-
-In addition, you need to be careful what you do with the local variable 'q=
',
-otherwise the compiler might be able to guess the value and again remove
-the needed conditional.  For example:
-
-	q =3D READ_ONCE(a);
-	if (q % MAX) {
-		WRITE_ONCE(b, 1);
-		do_something();
-	} else {
-		WRITE_ONCE(b, 2);
-		do_something_else();
-	}
-
-If MAX is defined to be 1, then the compiler knows that (q % MAX) is
-equal to zero, in which case the compiler is within its rights to
-transform the above code into the following:
-
-	q =3D READ_ONCE(a);
-	WRITE_ONCE(b, 2);
-	do_something_else();
-
-Given this transformation, the CPU is not required to respect the ordering
-between the load from variable 'a' and the store to variable 'b'.  It is
-tempting to add a barrier(), but this does not help.  The conditional
-is gone, and the barrier won't bring it back.  Therefore, if you are
-relying on this ordering, you should make sure that MAX is greater than
-one, perhaps as follows:
-
-	q =3D READ_ONCE(a);
-	BUILD_BUG_ON(MAX <=3D 1); /* Order load from a with store to b. */
-	if (q % MAX) {
-		WRITE_ONCE(b, 1);
-		do_something();
-	} else {
-		WRITE_ONCE(b, 2);
-		do_something_else();
-	}
-
-Please note once again that the stores to 'b' differ.  If they were
-identical, as noted earlier, the compiler could pull this store outside
-of the 'if' statement.
-
-You must also be careful not to rely too much on boolean short-circuit
-evaluation.  Consider this example:
-
-	q =3D READ_ONCE(a);
-	if (q || 1 > 0)
-		WRITE_ONCE(b, 1);
-
-Because the first condition cannot fault and the second condition is
-always true, the compiler can transform this example as following,
-defeating control dependency:
-
-	q =3D READ_ONCE(a);
-	WRITE_ONCE(b, 1);
-
-This example underscores the need to ensure that the compiler cannot
-out-guess your code.  More generally, although READ_ONCE() does force
-the compiler to actually emit code for a given load, it does not force
-the compiler to use the results.
-
-In addition, control dependencies apply only to the then-clause and
-else-clause of the if-statement in question.  In particular, it does
-not necessarily apply to code following the if-statement:
-
-	q =3D READ_ONCE(a);
-	if (q) {
-		WRITE_ONCE(b, 1);
-	} else {
-		WRITE_ONCE(b, 2);
-	}
-	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */
-
-It is tempting to argue that there in fact is ordering because the
-compiler cannot reorder volatile accesses and also cannot reorder
-the writes to 'b' with the condition.  Unfortunately for this line
-of reasoning, the compiler might compile the two writes to 'b' as
-conditional-move instructions, as in this fanciful pseudo-assembly
-language:
-
-	ld r1,a
-	cmp r1,$0
-	cmov,ne r4,$1
-	cmov,eq r4,$2
-	st r4,b
-	st $1,c
-
-A weakly ordered CPU would have no dependency of any sort between the load
-from 'a' and the store to 'c'.  The control dependencies would extend
-only to the pair of cmov instructions and the store depending on them.
-In short, control dependencies apply only to the stores in the then-clause
-and else-clause of the if-statement in question (including functions
-invoked by those two clauses), not to code following that if-statement.
-
-
-Note well that the ordering provided by a control dependency is local
-to the CPU containing it.  See the section on "Multicopy atomicity"
-for more information.
-
-
-In summary:
-
-  (*) Control dependencies can order prior loads against later stores.
-      However, they do -not- guarantee any other sort of ordering:
-      Not prior loads against later loads, nor prior stores against
-      later anything.  If you need these other forms of ordering,
-      use smp_rmb(), smp_wmb(), or, in the case of prior stores and
-      later loads, smp_mb().
-
-  (*) If both legs of the "if" statement begin with identical stores to
-      the same variable, then those stores must be ordered, either by
-      preceding both of them with smp_mb() or by using smp_store_release()
-      to carry out the stores.  Please note that it is -not- sufficient
-      to use barrier() at beginning of each leg of the "if" statement
-      because, as shown by the example above, optimizing compilers can
-      destroy the control dependency while respecting the letter of the
-      barrier() law.
-
-  (*) Control dependencies require at least one run-time conditional
-      between the prior load and the subsequent store, and this
-      conditional must involve the prior load.  If the compiler is able
-      to optimize the conditional away, it will have also optimized
-      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
-      can help to preserve the needed conditional.
-
-  (*) Control dependencies require that the compiler avoid reordering the
-      dependency into nonexistence.  Careful use of READ_ONCE() or
-      atomic{,64}_read() can help to preserve your control dependency.
-      Please see the COMPILER BARRIER section for more information.
-
-  (*) Control dependencies apply only to the then-clause and else-clause
-      of the if-statement containing the control dependency, including
-      any functions that these two clauses call.  Control dependencies
-      do -not- apply to code following the if-statement containing the
-      control dependency.
-
-  (*) Control dependencies pair normally with other types of barriers.
-
-  (*) Control dependencies do -not- provide multicopy atomicity.  If you
-      need all the CPUs to see a given store at the same time, use smp_mb(=
).
-
-  (*) Compilers do not understand control dependencies.  It is therefore
-      your job to ensure that they do not break your code.
-
-
-SMP BARRIER PAIRING
--------------------
-
-When dealing with CPU-CPU interactions, certain types of memory barrier sh=
ould
-always be paired.  A lack of appropriate pairing is almost certainly an er=
ror.
-
-General barriers pair with each other, though they also pair with most
-other types of barriers, albeit without multicopy atomicity.  An acquire
-barrier pairs with a release barrier, but both may also pair with other
-barriers, including of course general barriers.  A write barrier pairs
-with an address-dependency barrier, a control dependency, an acquire barri=
er,
-a release barrier, a read barrier, or a general barrier.  Similarly a
-read barrier, control dependency, or an address-dependency barrier pairs
-with a write barrier, an acquire barrier, a release barrier, or a
-general barrier:
-
-	CPU 1		      CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-	WRITE_ONCE(a, 1);
-	<write barrier>
-	WRITE_ONCE(b, 2);     x =3D READ_ONCE(b);
-			      <read barrier>
-			      y =3D READ_ONCE(a);
-
-Or:
-
-	CPU 1		      CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	a =3D 1;
-	<write barrier>
-	WRITE_ONCE(b, &a);    x =3D READ_ONCE(b);
-			      <implicit address-dependency barrier>
-			      y =3D *x;
-
-Or even:
-
-	CPU 1		      CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	r1 =3D READ_ONCE(y);
-	<general barrier>
-	WRITE_ONCE(x, 1);     if (r2 =3D READ_ONCE(x)) {
-			         <implicit control dependency>
-			         WRITE_ONCE(y, 1);
-			      }
-
-	assert(r1 =3D=3D 0 || r2 =3D=3D 0);
-
-Basically, the read barrier always has to be there, even though it can be =
of
-the "weaker" type.
-
-[!] Note that the stores before the write barrier would normally be expect=
ed to
-match the loads after the read barrier or the address-dependency barrier, =
and
-vice versa:
-
-	CPU 1                               CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                =
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	WRITE_ONCE(a, 1);    }----   --->{  v =3D READ_ONCE(c);
-	WRITE_ONCE(b, 2);    }    \ /    {  w =3D READ_ONCE(d);
-	<write barrier>            \        <read barrier>
-	WRITE_ONCE(c, 3);    }    / \    {  x =3D READ_ONCE(a);
-	WRITE_ONCE(d, 4);    }----   --->{  y =3D READ_ONCE(b);
-
-
-EXAMPLES OF MEMORY BARRIER SEQUENCES
-------------------------------------
-
-Firstly, write barriers act as partial orderings on store operations.
-Consider the following sequence of events:
-
-	CPU 1
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	STORE A =3D 1
-	STORE B =3D 2
-	STORE C =3D 3
-	<write barrier>
-	STORE D =3D 4
-	STORE E =3D 5
-
-This sequence of events is committed to the memory coherence system in an =
order
-that the rest of the system might perceive as the unordered set of { STORE=
 A,
-STORE B, STORE C } all occurring before the unordered set of { STORE D, ST=
ORE E
-}:
-
-	+-------+       :      :
-	|       |       +------+
-	|       |------>| C=3D3  |     }     /\
-	|       |  :    +------+     }-----  \  -----> Events perceptible to
-	|       |  :    | A=3D1  |     }        \/       the rest of the system
-	|       |  :    +------+     }
-	| CPU 1 |  :    | B=3D2  |     }
-	|       |       +------+     }
-	|       |   wwwwwwwwwwwwwwww }   <--- At this point the write barrier
-	|       |       +------+     }        requires all stores prior to the
-	|       |  :    | E=3D5  |     }        barrier to be committed before
-	|       |  :    +------+     }        further stores may take place
-	|       |------>| D=3D4  |     }
-	|       |       +------+
-	+-------+       :      :
-	                   |
-	                   | Sequence in which stores are committed to the
-	                   | memory system by CPU 1
-	                   V
-
-
-Secondly, address-dependency barriers act as partial orderings on address-
-dependent loads.  Consider the following sequence of events:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ B =3D 7; X =3D 9; Y =3D 8; C =3D &Y }
-	STORE A =3D 1
-	STORE B =3D 2
-	<write barrier>
-	STORE C =3D &B		LOAD X
-	STORE D =3D 4		LOAD C (gets &B)
-				LOAD *C (reads B)
-
-Without intervention, CPU 2 may perceive the events on CPU 1 in some
-effectively random order, despite the write barrier issued by CPU 1:
-
-	+-------+       :      :                :       :
-	|       |       +------+                +-------+  | Sequence of update
-	|       |------>| B=3D2  |-----       --->| Y->8  |  | of perception on
-	|       |  :    +------+     \          +-------+  | CPU 2
-	| CPU 1 |  :    | A=3D1  |      \     --->| C->&Y |  V
-	|       |       +------+       |        +-------+
-	|       |   wwwwwwwwwwwwwwww   |        :       :
-	|       |       +------+       |        :       :
-	|       |  :    | C=3D&B |---    |        :       :       +-------+
-	|       |  :    +------+   \   |        +-------+       |       |
-	|       |------>| D=3D4  |    ----------->| C->&B |------>|       |
-	|       |       +------+       |        +-------+       |       |
-	+-------+       :      :       |        :       :       |       |
-	                               |        :       :       |       |
-	                               |        :       :       | CPU 2 |
-	                               |        +-------+       |       |
-	    Apparently incorrect --->  |        | B->7  |------>|       |
-	    perception of B (!)        |        +-------+       |       |
-	                               |        :       :       |       |
-	                               |        +-------+       |       |
-	    The load of X holds --->    \       | X->9  |------>|       |
-	    up the maintenance           \      +-------+       |       |
-	    of coherence of B             ----->| B->2  |       +-------+
-	                                        +-------+
-	                                        :       :
-
-
-In the above example, CPU 2 perceives that B is 7, despite the load of *C
-(which would be B) coming after the LOAD of C.
-
-If, however, an address-dependency barrier were to be placed between the l=
oad
-of C and the load of *C (ie: B) on CPU 2:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ B =3D 7; X =3D 9; Y =3D 8; C =3D &Y }
-	STORE A =3D 1
-	STORE B =3D 2
-	<write barrier>
-	STORE C =3D &B		LOAD X
-	STORE D =3D 4		LOAD C (gets &B)
-				<address-dependency barrier>
-				LOAD *C (reads B)
-
-then the following will occur:
-
-	+-------+       :      :                :       :
-	|       |       +------+                +-------+
-	|       |------>| B=3D2  |-----       --->| Y->8  |
-	|       |  :    +------+     \          +-------+
-	| CPU 1 |  :    | A=3D1  |      \     --->| C->&Y |
-	|       |       +------+       |        +-------+
-	|       |   wwwwwwwwwwwwwwww   |        :       :
-	|       |       +------+       |        :       :
-	|       |  :    | C=3D&B |---    |        :       :       +-------+
-	|       |  :    +------+   \   |        +-------+       |       |
-	|       |------>| D=3D4  |    ----------->| C->&B |------>|       |
-	|       |       +------+       |        +-------+       |       |
-	+-------+       :      :       |        :       :       |       |
-	                               |        :       :       |       |
-	                               |        :       :       | CPU 2 |
-	                               |        +-------+       |       |
-	                               |        | X->9  |------>|       |
-	                               |        +-------+       |       |
-	  Makes sure all effects --->   \   aaaaaaaaaaaaaaaaa   |       |
-	  prior to the store of C        \      +-------+       |       |
-	  are perceptible to              ----->| B->2  |------>|       |
-	  subsequent loads                      +-------+       |       |
-	                                        :       :       +-------+
-
-
-And thirdly, a read barrier acts as a partial order on loads.  Consider the
-following sequence of events:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ A =3D 0, B =3D 9 }
-	STORE A=3D1
-	<write barrier>
-	STORE B=3D2
-				LOAD B
-				LOAD A
-
-Without intervention, CPU 2 may then choose to perceive the events on CPU =
1 in
-some effectively random order, despite the write barrier issued by CPU 1:
-
-	+-------+       :      :                :       :
-	|       |       +------+                +-------+
-	|       |------>| A=3D1  |------      --->| A->0  |
-	|       |       +------+      \         +-------+
-	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
-	|       |       +------+        |       +-------+
-	|       |------>| B=3D2  |---     |       :       :
-	|       |       +------+   \    |       :       :       +-------+
-	+-------+       :      :    \   |       +-------+       |       |
-	                             ---------->| B->2  |------>|       |
-	                                |       +-------+       | CPU 2 |
-	                                |       | A->0  |------>|       |
-	                                |       +-------+       |       |
-	                                |       :       :       +-------+
-	                                 \      :       :
-	                                  \     +-------+
-	                                   ---->| A->1  |
-	                                        +-------+
-	                                        :       :
-
-
-If, however, a read barrier were to be placed between the load of B and the
-load of A on CPU 2:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ A =3D 0, B =3D 9 }
-	STORE A=3D1
-	<write barrier>
-	STORE B=3D2
-				LOAD B
-				<read barrier>
-				LOAD A
-
-then the partial ordering imposed by CPU 1 will be perceived correctly by =
CPU
-2:
-
-	+-------+       :      :                :       :
-	|       |       +------+                +-------+
-	|       |------>| A=3D1  |------      --->| A->0  |
-	|       |       +------+      \         +-------+
-	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
-	|       |       +------+        |       +-------+
-	|       |------>| B=3D2  |---     |       :       :
-	|       |       +------+   \    |       :       :       +-------+
-	+-------+       :      :    \   |       +-------+       |       |
-	                             ---------->| B->2  |------>|       |
-	                                |       +-------+       | CPU 2 |
-	                                |       :       :       |       |
-	                                |       :       :       |       |
-	  At this point the read ---->   \  rrrrrrrrrrrrrrrrr   |       |
-	  barrier causes all effects      \     +-------+       |       |
-	  prior to the storage of B        ---->| A->1  |------>|       |
-	  to be perceptible to CPU 2            +-------+       |       |
-	                                        :       :       +-------+
-
-
-To illustrate this more completely, consider what could happen if the code
-contained a load of A either side of the read barrier:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ A =3D 0, B =3D 9 }
-	STORE A=3D1
-	<write barrier>
-	STORE B=3D2
-				LOAD B
-				LOAD A [first load of A]
-				<read barrier>
-				LOAD A [second load of A]
-
-Even though the two loads of A both occur after the load of B, they may bo=
th
-come up with different values:
-
-	+-------+       :      :                :       :
-	|       |       +------+                +-------+
-	|       |------>| A=3D1  |------      --->| A->0  |
-	|       |       +------+      \         +-------+
-	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
-	|       |       +------+        |       +-------+
-	|       |------>| B=3D2  |---     |       :       :
-	|       |       +------+   \    |       :       :       +-------+
-	+-------+       :      :    \   |       +-------+       |       |
-	                             ---------->| B->2  |------>|       |
-	                                |       +-------+       | CPU 2 |
-	                                |       :       :       |       |
-	                                |       :       :       |       |
-	                                |       +-------+       |       |
-	                                |       | A->0  |------>| 1st   |
-	                                |       +-------+       |       |
-	  At this point the read ---->   \  rrrrrrrrrrrrrrrrr   |       |
-	  barrier causes all effects      \     +-------+       |       |
-	  prior to the storage of B        ---->| A->1  |------>| 2nd   |
-	  to be perceptible to CPU 2            +-------+       |       |
-	                                        :       :       +-------+
-
-
-But it may be that the update to A from CPU 1 becomes perceptible to CPU 2
-before the read barrier completes anyway:
-
-	+-------+       :      :                :       :
-	|       |       +------+                +-------+
-	|       |------>| A=3D1  |------      --->| A->0  |
-	|       |       +------+      \         +-------+
-	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
-	|       |       +------+        |       +-------+
-	|       |------>| B=3D2  |---     |       :       :
-	|       |       +------+   \    |       :       :       +-------+
-	+-------+       :      :    \   |       +-------+       |       |
-	                             ---------->| B->2  |------>|       |
-	                                |       +-------+       | CPU 2 |
-	                                |       :       :       |       |
-	                                 \      :       :       |       |
-	                                  \     +-------+       |       |
-	                                   ---->| A->1  |------>| 1st   |
-	                                        +-------+       |       |
-	                                    rrrrrrrrrrrrrrrrr   |       |
-	                                        +-------+       |       |
-	                                        | A->1  |------>| 2nd   |
-	                                        +-------+       |       |
-	                                        :       :       +-------+
-
-
-The guarantee is that the second load will always come up with A =3D=3D 1 =
if the
-load of B came up with B =3D=3D 2.  No such guarantee exists for the first=
 load of
-A; that may come up with either A =3D=3D 0 or A =3D=3D 1.
-
-
-READ MEMORY BARRIERS VS LOAD SPECULATION
-----------------------------------------
-
-Many CPUs speculate with loads: that is they see that they will need to lo=
ad an
-item from memory, and they find a time where they're not using the bus for=
 any
-other loads, and so do the load in advance - even though they haven't actu=
ally
-got to that point in the instruction execution flow yet.  This permits the
-actual load instruction to potentially complete immediately because the CPU
-already has the value to hand.
-
-It may turn out that the CPU didn't actually need the value - perhaps beca=
use a
-branch circumvented the load - in which case it can discard the value or j=
ust
-cache it for later use.
-
-Consider:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-				LOAD B
-				DIVIDE		} Divide instructions generally
-				DIVIDE		} take a long time to perform
-				LOAD A
-
-Which might appear as this:
-
-	                                        :       :       +-------+
-	                                        +-------+       |       |
-	                                    --->| B->2  |------>|       |
-	                                        +-------+       | CPU 2 |
-	                                        :       :DIVIDE |       |
-	                                        +-------+       |       |
-	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |
-	division speculates on the              +-------+   ~   |       |
-	LOAD of A                               :       :   ~   |       |
-	                                        :       :DIVIDE |       |
-	                                        :       :   ~   |       |
-	Once the divisions are complete -->     :       :   ~-->|       |
-	the CPU can then perform the            :       :       |       |
-	LOAD with immediate effect              :       :       +-------+
-
-
-Placing a read barrier or an address-dependency barrier just before the se=
cond
-load:
-
-	CPU 1			CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-				LOAD B
-				DIVIDE
-				DIVIDE
-				<read barrier>
-				LOAD A
-
-will force any value speculatively obtained to be reconsidered to an extent
-dependent on the type of barrier used.  If there was no change made to the
-speculated memory location, then the speculated value will just be used:
-
-	                                        :       :       +-------+
-	                                        +-------+       |       |
-	                                    --->| B->2  |------>|       |
-	                                        +-------+       | CPU 2 |
-	                                        :       :DIVIDE |       |
-	                                        +-------+       |       |
-	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |
-	division speculates on the              +-------+   ~   |       |
-	LOAD of A                               :       :   ~   |       |
-	                                        :       :DIVIDE |       |
-	                                        :       :   ~   |       |
-	                                        :       :   ~   |       |
-	                                    rrrrrrrrrrrrrrrr~   |       |
-	                                        :       :   ~   |       |
-	                                        :       :   ~-->|       |
-	                                        :       :       |       |
-	                                        :       :       +-------+
-
-
-but if there was an update or an invalidation from another CPU pending, th=
en
-the speculation will be cancelled and the value reloaded:
-
-	                                        :       :       +-------+
-	                                        +-------+       |       |
-	                                    --->| B->2  |------>|       |
-	                                        +-------+       | CPU 2 |
-	                                        :       :DIVIDE |       |
-	                                        +-------+       |       |
-	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |
-	division speculates on the              +-------+   ~   |       |
-	LOAD of A                               :       :   ~   |       |
-	                                        :       :DIVIDE |       |
-	                                        :       :   ~   |       |
-	                                        :       :   ~   |       |
-	                                    rrrrrrrrrrrrrrrrr   |       |
-	                                        +-------+       |       |
-	The speculation is discarded --->   --->| A->1  |------>|       |
-	and an updated value is                 +-------+       |       |
-	retrieved                               :       :       +-------+
-
-
-MULTICOPY ATOMICITY
---------------------
-
-Multicopy atomicity is a deeply intuitive notion about ordering that is
-not always provided by real computer systems, namely that a given store
-becomes visible at the same time to all CPUs, or, alternatively, that all
-CPUs agree on the order in which all stores become visible.  However,
-support of full multicopy atomicity would rule out valuable hardware
-optimizations, so a weaker form called ``other multicopy atomicity''
-instead guarantees only that a given store becomes visible at the same
-time to all -other- CPUs.  The remainder of this document discusses this
-weaker form, but for brevity will call it simply ``multicopy atomicity''.
-
-The following example demonstrates multicopy atomicity:
-
-	CPU 1			CPU 2			CPU 3
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ X =3D 0, Y =3D 0 }
-	STORE X=3D1		r1=3DLOAD X (reads 1)	LOAD Y (reads 1)
-				<general barrier>	<read barrier>
-				STORE Y=3Dr1		LOAD X
-
-Suppose that CPU 2's load from X returns 1, which it then stores to Y,
-and CPU 3's load from Y returns 1.  This indicates that CPU 1's store
-to X precedes CPU 2's load from X and that CPU 2's store to Y precedes
-CPU 3's load from Y.  In addition, the memory barriers guarantee that
-CPU 2 executes its load before its store, and CPU 3 loads from Y before
-it loads from X.  The question is then "Can CPU 3's load from X return 0?"
-
-Because CPU 3's load from X in some sense comes after CPU 2's load, it
-is natural to expect that CPU 3's load from X must therefore return 1.
-This expectation follows from multicopy atomicity: if a load executing
-on CPU B follows a load from the same variable executing on CPU A (and
-CPU A did not originally store the value which it read), then on
-multicopy-atomic systems, CPU B's load must return either the same value
-that CPU A's load did or some later value.  However, the Linux kernel
-does not require systems to be multicopy atomic.
-
-The use of a general memory barrier in the example above compensates
-for any lack of multicopy atomicity.  In the example, if CPU 2's load
-from X returns 1 and CPU 3's load from Y returns 1, then CPU 3's load
-from X must indeed also return 1.
-
-However, dependencies, read barriers, and write barriers are not always
-able to compensate for non-multicopy atomicity.  For example, suppose
-that CPU 2's general barrier is removed from the above example, leaving
-only the data dependency shown below:
-
-	CPU 1			CPU 2			CPU 3
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-		{ X =3D 0, Y =3D 0 }
-	STORE X=3D1		r1=3DLOAD X (reads 1)	LOAD Y (reads 1)
-				<data dependency>	<read barrier>
-				STORE Y=3Dr1		LOAD X (reads 0)
-
-This substitution allows non-multicopy atomicity to run rampant: in
-this example, it is perfectly legal for CPU 2's load from X to return 1,
-CPU 3's load from Y to return 1, and its load from X to return 0.
-
-The key point is that although CPU 2's data dependency orders its load
-and store, it does not guarantee to order CPU 1's store.  Thus, if this
-example runs on a non-multicopy-atomic system where CPUs 1 and 2 share a
-store buffer or a level of cache, CPU 2 might have early access to CPU 1's
-writes.  General barriers are therefore required to ensure that all CPUs
-agree on the combined order of multiple accesses.
-
-General barriers can compensate not only for non-multicopy atomicity,
-but can also generate additional ordering that can ensure that -all-
-CPUs will perceive the same order of -all- operations.  In contrast, a
-chain of release-acquire pairs do not provide this additional ordering,
-which means that only those CPUs on the chain are guaranteed to agree
-on the combined order of the accesses.  For example, switching to C code
-in deference to the ghost of Herman Hollerith:
-
-	int u, v, x, y, z;
-
-	void cpu0(void)
-	{
-		r0 =3D smp_load_acquire(&x);
-		WRITE_ONCE(u, 1);
-		smp_store_release(&y, 1);
-	}
-
-	void cpu1(void)
-	{
-		r1 =3D smp_load_acquire(&y);
-		r4 =3D READ_ONCE(v);
-		r5 =3D READ_ONCE(u);
-		smp_store_release(&z, 1);
-	}
-
-	void cpu2(void)
-	{
-		r2 =3D smp_load_acquire(&z);
-		smp_store_release(&x, 1);
-	}
-
-	void cpu3(void)
-	{
-		WRITE_ONCE(v, 1);
-		smp_mb();
-		r3 =3D READ_ONCE(u);
-	}
-
-Because cpu0(), cpu1(), and cpu2() participate in a chain of
-smp_store_release()/smp_load_acquire() pairs, the following outcome
-is prohibited:
-
-	r0 =3D=3D 1 && r1 =3D=3D 1 && r2 =3D=3D 1
-
-Furthermore, because of the release-acquire relationship between cpu0()
-and cpu1(), cpu1() must see cpu0()'s writes, so that the following
-outcome is prohibited:
-
-	r1 =3D=3D 1 && r5 =3D=3D 0
-
-However, the ordering provided by a release-acquire chain is local
-to the CPUs participating in that chain and does not apply to cpu3(),
-at least aside from stores.  Therefore, the following outcome is possible:
-
-	r0 =3D=3D 0 && r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 && r4 =3D=3D 0
-
-As an aside, the following outcome is also possible:
-
-	r0 =3D=3D 0 && r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 && r4 =3D=3D 0 &=
& r5 =3D=3D 1
-
-Although cpu0(), cpu1(), and cpu2() will see their respective reads and
-writes in order, CPUs not involved in the release-acquire chain might
-well disagree on the order.  This disagreement stems from the fact that
-the weak memory-barrier instructions used to implement smp_load_acquire()
-and smp_store_release() are not required to order prior stores against
-subsequent loads in all cases.  This means that cpu3() can see cpu0()'s
-store to u as happening -after- cpu1()'s load from v, even though
-both cpu0() and cpu1() agree that these two operations occurred in the
-intended order.
-
-However, please keep in mind that smp_load_acquire() is not magic.
-In particular, it simply reads from its argument with ordering.  It does
--not- ensure that any particular value will be read.  Therefore, the
-following outcome is possible:
-
-	r0 =3D=3D 0 && r1 =3D=3D 0 && r2 =3D=3D 0 && r5 =3D=3D 0
-
-Note that this outcome can happen even on a mythical sequentially
-consistent system where nothing is ever reordered.
-
-To reiterate, if your code requires full ordering of all operations,
-use general barriers throughout.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-EXPLICIT KERNEL BARRIERS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-The Linux kernel has a variety of different barriers that act at different
-levels:
-
-  (*) Compiler barrier.
-
-  (*) CPU memory barriers.
-
-
-COMPILER BARRIER
-----------------
-
-The Linux kernel has an explicit compiler barrier function that prevents t=
he
-compiler from moving the memory accesses either side of it to the other si=
de:
-
-	barrier();
-
-This is a general barrier -- there are no read-read or write-write
-variants of barrier().  However, READ_ONCE() and WRITE_ONCE() can be
-thought of as weak forms of barrier() that affect only the specific
-accesses flagged by the READ_ONCE() or WRITE_ONCE().
-
-The barrier() function has the following effects:
-
- (*) Prevents the compiler from reordering accesses following the
-     barrier() to precede any accesses preceding the barrier().
-     One example use for this property is to ease communication between
-     interrupt-handler code and the code that was interrupted.
-
- (*) Within a loop, forces the compiler to load the variables used
-     in that loop's conditional on each pass through that loop.
-
-The READ_ONCE() and WRITE_ONCE() functions can prevent any number of
-optimizations that, while perfectly safe in single-threaded code, can
-be fatal in concurrent code.  Here are some examples of these sorts
-of optimizations:
-
- (*) The compiler is within its rights to reorder loads and stores
-     to the same variable, and in some cases, the CPU is within its
-     rights to reorder loads to the same variable.  This means that
-     the following code:
-
-	a[0] =3D x;
-	a[1] =3D x;
-
-     Might result in an older value of x stored in a[1] than in a[0].
-     Prevent both the compiler and the CPU from doing this as follows:
-
-	a[0] =3D READ_ONCE(x);
-	a[1] =3D READ_ONCE(x);
-
-     In short, READ_ONCE() and WRITE_ONCE() provide cache coherence for
-     accesses from multiple CPUs to a single variable.
-
- (*) The compiler is within its rights to merge successive loads from
-     the same variable.  Such merging can cause the compiler to "optimize"
-     the following code:
-
-	while (tmp =3D a)
-		do_something_with(tmp);
-
-     into the following code, which, although in some sense legitimate
-     for single-threaded code, is almost certainly not what the developer
-     intended:
-
-	if (tmp =3D a)
-		for (;;)
-			do_something_with(tmp);
-
-     Use READ_ONCE() to prevent the compiler from doing this to you:
-
-	while (tmp =3D READ_ONCE(a))
-		do_something_with(tmp);
-
- (*) The compiler is within its rights to reload a variable, for example,
-     in cases where high register pressure prevents the compiler from
-     keeping all data of interest in registers.  The compiler might
-     therefore optimize the variable 'tmp' out of our previous example:
-
-	while (tmp =3D a)
-		do_something_with(tmp);
-
-     This could result in the following code, which is perfectly safe in
-     single-threaded code, but can be fatal in concurrent code:
-
-	while (a)
-		do_something_with(a);
-
-     For example, the optimized version of this code could result in
-     passing a zero to do_something_with() in the case where the variable
-     a was modified by some other CPU between the "while" statement and
-     the call to do_something_with().
-
-     Again, use READ_ONCE() to prevent the compiler from doing this:
-
-	while (tmp =3D READ_ONCE(a))
-		do_something_with(tmp);
-
-     Note that if the compiler runs short of registers, it might save
-     tmp onto the stack.  The overhead of this saving and later restoring
-     is why compilers reload variables.  Doing so is perfectly safe for
-     single-threaded code, so you need to tell the compiler about cases
-     where it is not safe.
-
- (*) The compiler is within its rights to omit a load entirely if it knows
-     what the value will be.  For example, if the compiler can prove that
-     the value of variable 'a' is always zero, it can optimize this code:
-
-	while (tmp =3D a)
-		do_something_with(tmp);
-
-     Into this:
-
-	do { } while (0);
-
-     This transformation is a win for single-threaded code because it
-     gets rid of a load and a branch.  The problem is that the compiler
-     will carry out its proof assuming that the current CPU is the only
-     one updating variable 'a'.  If variable 'a' is shared, then the
-     compiler's proof will be erroneous.  Use READ_ONCE() to tell the
-     compiler that it doesn't know as much as it thinks it does:
-
-	while (tmp =3D READ_ONCE(a))
-		do_something_with(tmp);
-
-     But please note that the compiler is also closely watching what you
-     do with the value after the READ_ONCE().  For example, suppose you
-     do the following and MAX is a preprocessor macro with the value 1:
-
-	while ((tmp =3D READ_ONCE(a)) % MAX)
-		do_something_with(tmp);
-
-     Then the compiler knows that the result of the "%" operator applied
-     to MAX will always be zero, again allowing the compiler to optimize
-     the code into near-nonexistence.  (It will still load from the
-     variable 'a'.)
-
- (*) Similarly, the compiler is within its rights to omit a store entirely
-     if it knows that the variable already has the value being stored.
-     Again, the compiler assumes that the current CPU is the only one
-     storing into the variable, which can cause the compiler to do the
-     wrong thing for shared variables.  For example, suppose you have
-     the following:
-
-	a =3D 0;
-	... Code that does not store to variable a ...
-	a =3D 0;
-
-     The compiler sees that the value of variable 'a' is already zero, so
-     it might well omit the second store.  This would come as a fatal
-     surprise if some other CPU might have stored to variable 'a' in the
-     meantime.
-
-     Use WRITE_ONCE() to prevent the compiler from making this sort of
-     wrong guess:
-
-	WRITE_ONCE(a, 0);
-	... Code that does not store to variable a ...
-	WRITE_ONCE(a, 0);
-
- (*) The compiler is within its rights to reorder memory accesses unless
-     you tell it not to.  For example, consider the following interaction
-     between process-level code and an interrupt handler:
-
-	void process_level(void)
-	{
-		msg =3D get_message();
-		flag =3D true;
-	}
-
-	void interrupt_handler(void)
-	{
-		if (flag)
-			process_message(msg);
-	}
-
-     There is nothing to prevent the compiler from transforming
-     process_level() to the following, in fact, this might well be a
-     win for single-threaded code:
-
-	void process_level(void)
-	{
-		flag =3D true;
-		msg =3D get_message();
-	}
-
-     If the interrupt occurs between these two statement, then
-     interrupt_handler() might be passed a garbled msg.  Use WRITE_ONCE()
-     to prevent this as follows:
-
-	void process_level(void)
-	{
-		WRITE_ONCE(msg, get_message());
-		WRITE_ONCE(flag, true);
-	}
-
-	void interrupt_handler(void)
-	{
-		if (READ_ONCE(flag))
-			process_message(READ_ONCE(msg));
-	}
-
-     Note that the READ_ONCE() and WRITE_ONCE() wrappers in
-     interrupt_handler() are needed if this interrupt handler can itself
-     be interrupted by something that also accesses 'flag' and 'msg',
-     for example, a nested interrupt or an NMI.  Otherwise, READ_ONCE()
-     and WRITE_ONCE() are not needed in interrupt_handler() other than
-     for documentation purposes.  (Note also that nested interrupts
-     do not typically occur in modern Linux kernels, in fact, if an
-     interrupt handler returns with interrupts enabled, you will get a
-     WARN_ONCE() splat.)
-
-     You should assume that the compiler can move READ_ONCE() and
-     WRITE_ONCE() past code not containing READ_ONCE(), WRITE_ONCE(),
-     barrier(), or similar primitives.
-
-     This effect could also be achieved using barrier(), but READ_ONCE()
-     and WRITE_ONCE() are more selective:  With READ_ONCE() and
-     WRITE_ONCE(), the compiler need only forget the contents of the
-     indicated memory locations, while with barrier() the compiler must
-     discard the value of all memory locations that it has currently
-     cached in any machine registers.  Of course, the compiler must also
-     respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
-     though the CPU of course need not do so.
-
- (*) The compiler is within its rights to invent stores to a variable,
-     as in the following example:
-
-	if (a)
-		b =3D a;
-	else
-		b =3D 42;
-
-     The compiler might save a branch by optimizing this as follows:
-
-	b =3D 42;
-	if (a)
-		b =3D a;
-
-     In single-threaded code, this is not only safe, but also saves
-     a branch.  Unfortunately, in concurrent code, this optimization
-     could cause some other CPU to see a spurious value of 42 -- even
-     if variable 'a' was never zero -- when loading variable 'b'.
-     Use WRITE_ONCE() to prevent this as follows:
-
-	if (a)
-		WRITE_ONCE(b, a);
-	else
-		WRITE_ONCE(b, 42);
-
-     The compiler can also invent loads.  These are usually less
-     damaging, but they can result in cache-line bouncing and thus in
-     poor performance and scalability.  Use READ_ONCE() to prevent
-     invented loads.
-
- (*) For aligned memory locations whose size allows them to be accessed
-     with a single memory-reference instruction, prevents "load tearing"
-     and "store tearing," in which a single large access is replaced by
-     multiple smaller accesses.  For example, given an architecture having
-     16-bit store instructions with 7-bit immediate fields, the compiler
-     might be tempted to use two 16-bit store-immediate instructions to
-     implement the following 32-bit store:
-
-	p =3D 0x00010002;
-
-     Please note that GCC really does use this sort of optimization,
-     which is not surprising given that it would likely take more
-     than two instructions to build the constant and then store it.
-     This optimization can therefore be a win in single-threaded code.
-     In fact, a recent bug (since fixed) caused GCC to incorrectly use
-     this optimization in a volatile store.  In the absence of such bugs,
-     use of WRITE_ONCE() prevents store tearing in the following example:
-
-	WRITE_ONCE(p, 0x00010002);
-
-     Use of packed structures can also result in load and store tearing,
-     as in this example:
-
-	struct __attribute__((__packed__)) foo {
-		short a;
-		int b;
-		short c;
-	};
-	struct foo foo1, foo2;
-	...
-
-	foo2.a =3D foo1.a;
-	foo2.b =3D foo1.b;
-	foo2.c =3D foo1.c;
-
-     Because there are no READ_ONCE() or WRITE_ONCE() wrappers and no
-     volatile markings, the compiler would be well within its rights to
-     implement these three assignment statements as a pair of 32-bit
-     loads followed by a pair of 32-bit stores.  This would result in
-     load tearing on 'foo1.b' and store tearing on 'foo2.b'.  READ_ONCE()
-     and WRITE_ONCE() again prevent tearing in this example:
-
-	foo2.a =3D foo1.a;
-	WRITE_ONCE(foo2.b, READ_ONCE(foo1.b));
-	foo2.c =3D foo1.c;
-
-All that aside, it is never necessary to use READ_ONCE() and
-WRITE_ONCE() on a variable that has been marked volatile.  For example,
-because 'jiffies' is marked volatile, it is never necessary to
-say READ_ONCE(jiffies).  The reason for this is that READ_ONCE() and
-WRITE_ONCE() are implemented as volatile casts, which has no effect when
-its argument is already marked volatile.
-
-Please note that these compiler barriers have no direct effect on the CPU,
-which may then reorder things however it wishes.
-
-
-CPU MEMORY BARRIERS
--------------------
-
-The Linux kernel has seven basic CPU memory barriers:
-
-	TYPE			MANDATORY	SMP CONDITIONAL
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-	GENERAL			mb()		smp_mb()
-	WRITE			wmb()		smp_wmb()
-	READ			rmb()		smp_rmb()
-	ADDRESS DEPENDENCY			READ_ONCE()
-
-
-All memory barriers except the address-dependency barriers imply a compiler
-barrier.  Address dependencies do not impose any additional compiler order=
ing.
-
-Aside: In the case of address dependencies, the compiler would be expected
-to issue the loads in the correct order (eg. `a[b]` would have to load
-the value of b before loading a[b]), however there is no guarantee in
-the C specification that the compiler may not speculate the value of b
-(eg. is equal to 1) and load a[b] before b (eg. tmp =3D a[1]; if (b !=3D 1)
-tmp =3D a[b]; ).  There is also the problem of a compiler reloading b after
-having loaded a[b], thus having a newer copy of b than a[b].  A consensus
-has not yet been reached about these problems, however the READ_ONCE()
-macro is a good place to start looking.
-
-SMP memory barriers are reduced to compiler barriers on uniprocessor compi=
led
-systems because it is assumed that a CPU will appear to be self-consistent,
-and will order overlapping accesses correctly with respect to itself.
-However, see the subsection on "Virtual Machine Guests" below.
-
-[!] Note that SMP memory barriers _must_ be used to control the ordering of
-references to shared memory on SMP systems, though the use of locking inst=
ead
-is sufficient.
-
-Mandatory barriers should not be used to control SMP effects, since mandat=
ory
-barriers impose unnecessary overhead on both SMP and UP systems. They may,
-however, be used to control MMIO effects on accesses through relaxed memor=
y I/O
-windows.  These barriers are required even on non-SMP systems as they affe=
ct
-the order in which memory operations appear to a device by prohibiting bot=
h the
-compiler and the CPU from reordering them.
-
-
-There are some more advanced barrier functions:
-
- (*) smp_store_mb(var, value)
-
-     This assigns the value to the variable and then inserts a full memory
-     barrier after it.  It isn't guaranteed to insert anything more than a
-     compiler barrier in a UP compilation.
-
-
- (*) smp_mb__before_atomic();
- (*) smp_mb__after_atomic();
-
-     These are for use with atomic RMW functions that do not imply memory
-     barriers, but where the code needs a memory barrier. Examples for ato=
mic
-     RMW functions that do not imply a memory barrier are e.g. add,
-     subtract, (failed) conditional operations, _relaxed functions,
-     but not atomic_read or atomic_set. A common example where a memory
-     barrier may be required is when atomic ops are used for reference
-     counting.
-
-     These are also used for atomic RMW bitop functions that do not imply a
-     memory barrier (such as set_bit and clear_bit).
-
-     As an example, consider a piece of code that marks an object as being=
 dead
-     and then decrements the object's reference count:
-
-	obj->dead =3D 1;
-	smp_mb__before_atomic();
-	atomic_dec(&obj->ref_count);
-
-     This makes sure that the death mark on the object is perceived to be =
set
-     *before* the reference counter is decremented.
-
-     See Documentation/atomic_{t,bitops}.txt for more information.
-
-
- (*) dma_wmb();
- (*) dma_rmb();
- (*) dma_mb();
-
-     These are for use with consistent memory to guarantee the ordering
-     of writes or reads of shared memory accessible to both the CPU and a
-     DMA capable device. See Documentation/core-api/dma-api.rst file for m=
ore
-     information about consistent memory.
-
-     For example, consider a device driver that shares memory with a device
-     and uses a descriptor status value to indicate if the descriptor belo=
ngs
-     to the device or the CPU, and a doorbell to notify it when new
-     descriptors are available:
-
-	if (desc->status !=3D DEVICE_OWN) {
-		/* do not read data until we own descriptor */
-		dma_rmb();
-
-		/* read/modify data */
-		read_data =3D desc->data;
-		desc->data =3D write_data;
-
-		/* flush modifications before status update */
-		dma_wmb();
-
-		/* assign ownership */
-		desc->status =3D DEVICE_OWN;
-
-		/* Make descriptor status visible to the device followed by
-		 * notify device of new descriptor
-		 */
-		writel(DESC_NOTIFY, doorbell);
-	}
-
-     The dma_rmb() allows us to guarantee that the device has released own=
ership
-     before we read the data from the descriptor, and the dma_wmb() allows
-     us to guarantee the data is written to the descriptor before the devi=
ce
-     can see it now has ownership.  The dma_mb() implies both a dma_rmb() =
and
-     a dma_wmb().
-
-     Note that the dma_*() barriers do not provide any ordering guarantees=
 for
-     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
-     subsection for more information about I/O accessors and MMIO ordering.
-
- (*) pmem_wmb();
-
-     This is for use with persistent memory to ensure that stores for which
-     modifications are written to persistent storage reached a platform
-     durability domain.
-
-     For example, after a non-temporal write to pmem region, we use pmem_w=
mb()
-     to ensure that stores have reached a platform durability domain. This=
 ensures
-     that stores have updated persistent storage before any data access or
-     data transfer caused by subsequent instructions is initiated. This is
-     in addition to the ordering done by wmb().
-
-     For load from persistent memory, existing read memory barriers are su=
fficient
-     to ensure read ordering.
-
- (*) io_stop_wc();
-
-     For memory accesses with write-combining attributes (e.g. those retur=
ned
-     by ioremap_wc()), the CPU may wait for prior accesses to be merged wi=
th
-     subsequent ones. io_stop_wc() can be used to prevent the merging of
-     write-combining memory accesses before this macro with those after it=
 when
-     such wait has performance implications.
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-IMPLICIT KERNEL MEMORY BARRIERS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-
-Some of the other functions in the linux kernel imply memory barriers, amo=
ngst
-which are locking and scheduling functions.
-
-This specification is a _minimum_ guarantee; any particular architecture m=
ay
-provide more substantial guarantees, but these may not be relied upon outs=
ide
-of arch specific code.
-
-
-LOCK ACQUISITION FUNCTIONS
---------------------------
-
-The Linux kernel has a number of locking constructs:
-
- (*) spin locks
- (*) R/W spin locks
- (*) mutexes
- (*) semaphores
- (*) R/W semaphores
-
-In all cases there are variants on "ACQUIRE" operations and "RELEASE" oper=
ations
-for each construct.  These operations all imply certain barriers:
-
- (1) ACQUIRE operation implication:
-
-     Memory operations issued after the ACQUIRE will be completed after the
-     ACQUIRE operation has completed.
-
-     Memory operations issued before the ACQUIRE may be completed after
-     the ACQUIRE operation has completed.
-
- (2) RELEASE operation implication:
-
-     Memory operations issued before the RELEASE will be completed before =
the
-     RELEASE operation has completed.
-
-     Memory operations issued after the RELEASE may be completed before the
-     RELEASE operation has completed.
-
- (3) ACQUIRE vs ACQUIRE implication:
-
-     All ACQUIRE operations issued before another ACQUIRE operation will be
-     completed before that ACQUIRE operation.
-
- (4) ACQUIRE vs RELEASE implication:
-
-     All ACQUIRE operations issued before a RELEASE operation will be
-     completed before the RELEASE operation.
-
- (5) Failed conditional ACQUIRE implication:
-
-     Certain locking variants of the ACQUIRE operation may fail, either du=
e to
-     being unable to get the lock immediately, or due to receiving an unbl=
ocked
-     signal while asleep waiting for the lock to become available.  Failed
-     locks do not imply any sort of barrier.
-
-[!] Note: one of the consequences of lock ACQUIREs and RELEASEs being only
-one-way barriers is that the effects of instructions outside of a critical
-section may seep into the inside of the critical section.
-
-An ACQUIRE followed by a RELEASE may not be assumed to be full memory barr=
ier
-because it is possible for an access preceding the ACQUIRE to happen after=
 the
-ACQUIRE, and an access following the RELEASE to happen before the RELEASE,=
 and
-the two accesses can themselves then cross:
-
-	*A =3D a;
-	ACQUIRE M
-	RELEASE M
-	*B =3D b;
-
-may occur as:
-
-	ACQUIRE M, STORE *B, STORE *A, RELEASE M
-
-When the ACQUIRE and RELEASE are a lock acquisition and release,
-respectively, this same reordering can occur if the lock's ACQUIRE and
-RELEASE are to the same lock variable, but only from the perspective of
-another CPU not holding that lock.  In short, a ACQUIRE followed by an
-RELEASE may -not- be assumed to be a full memory barrier.
-
-Similarly, the reverse case of a RELEASE followed by an ACQUIRE does
-not imply a full memory barrier.  Therefore, the CPU's execution of the
-critical sections corresponding to the RELEASE and the ACQUIRE can cross,
-so that:
-
-	*A =3D a;
-	RELEASE M
-	ACQUIRE N
-	*B =3D b;
-
-could occur as:
-
-	ACQUIRE N, STORE *B, STORE *A, RELEASE M
-
-It might appear that this reordering could introduce a deadlock.
-However, this cannot happen because if such a deadlock threatened,
-the RELEASE would simply complete, thereby avoiding the deadlock.
-
-	Why does this work?
-
-	One key point is that we are only talking about the CPU doing
-	the reordering, not the compiler.  If the compiler (or, for
-	that matter, the developer) switched the operations, deadlock
-	-could- occur.
-
-	But suppose the CPU reordered the operations.  In this case,
-	the unlock precedes the lock in the assembly code.  The CPU
-	simply elected to try executing the later lock operation first.
-	If there is a deadlock, this lock operation will simply spin (or
-	try to sleep, but more on that later).	The CPU will eventually
-	execute the unlock operation (which preceded the lock operation
-	in the assembly code), which will unravel the potential deadlock,
-	allowing the lock operation to succeed.
-
-	But what if the lock is a sleeplock?  In that case, the code will
-	try to enter the scheduler, where it will eventually encounter
-	a memory barrier, which will force the earlier unlock operation
-	to complete, again unraveling the deadlock.  There might be
-	a sleep-unlock race, but the locking primitive needs to resolve
-	such races properly in any case.
-
-Locks and semaphores may not provide any guarantee of ordering on UP compi=
led
-systems, and so cannot be counted on in such a situation to actually achie=
ve
-anything at all - especially with respect to I/O accesses - unless combined
-with interrupt disabling operations.
-
-See also the section on "Inter-CPU acquiring barrier effects".
-
-
-As an example, consider the following:
-
-	*A =3D a;
-	*B =3D b;
-	ACQUIRE
-	*C =3D c;
-	*D =3D d;
-	RELEASE
-	*E =3D e;
-	*F =3D f;
-
-The following sequence of events is acceptable:
-
-	ACQUIRE, {*F,*A}, *E, {*C,*D}, *B, RELEASE
-
-	[+] Note that {*F,*A} indicates a combined access.
-
-But none of the following are:
-
-	{*F,*A}, *B,	ACQUIRE, *C, *D,	RELEASE, *E
-	*A, *B, *C,	ACQUIRE, *D,		RELEASE, *E, *F
-	*A, *B,		ACQUIRE, *C,		RELEASE, *D, *E, *F
-	*B,		ACQUIRE, *C, *D,	RELEASE, {*F,*A}, *E
-
-
-
-INTERRUPT DISABLING FUNCTIONS
------------------------------
-
-Functions that disable interrupts (ACQUIRE equivalent) and enable interrup=
ts
-(RELEASE equivalent) will act as compiler barriers only.  So if memory or =
I/O
-barriers are required in such a situation, they must be provided from some
-other means.
-
-
-SLEEP AND WAKE-UP FUNCTIONS
----------------------------
-
-Sleeping and waking on an event flagged in global data can be viewed as an
-interaction between two pieces of data: the task state of the task waiting=
 for
-the event and the global data used to indicate the event.  To make sure th=
at
-these appear to happen in the right order, the primitives to begin the pro=
cess
-of going to sleep, and the primitives to initiate a wake up imply certain
-barriers.
-
-Firstly, the sleeper normally follows something like this sequence of even=
ts:
-
-	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (event_indicated)
-			break;
-		schedule();
-	}
-
-A general memory barrier is interpolated automatically by set_current_stat=
e()
-after it has altered the task state:
-
-	CPU 1
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-	set_current_state();
-	  smp_store_mb();
-	    STORE current->state
-	    <general barrier>
-	LOAD event_indicated
-
-set_current_state() may be wrapped by:
-
-	prepare_to_wait();
-	prepare_to_wait_exclusive();
-
-which therefore also imply a general memory barrier after setting the stat=
e.
-The whole sequence above is available in various canned forms, all of which
-interpolate the memory barrier in the right place:
-
-	wait_event();
-	wait_event_interruptible();
-	wait_event_interruptible_exclusive();
-	wait_event_interruptible_timeout();
-	wait_event_killable();
-	wait_event_timeout();
-	wait_on_bit();
-	wait_on_bit_lock();
-	wait_event_cmd();
-	wait_event_exclusive_cmd();
-
-
-Secondly, code that performs a wake up normally follows something like thi=
s:
-
-	event_indicated =3D 1;
-	wake_up(&event_wait_queue);
-
-or:
-
-	event_indicated =3D 1;
-	wake_up_process(event_daemon);
-
-A general memory barrier is executed by wake_up() if it wakes something up.
-If it doesn't wake anything up then a memory barrier may or may not be
-executed; you must not rely on it.  The barrier occurs before the task sta=
te
-is accessed, in particular, it sits between the STORE to indicate the event
-and the STORE to set TASK_RUNNING:
-
-	CPU 1 (Sleeper)			CPU 2 (Waker)
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	set_current_state();		STORE event_indicated
-	  smp_store_mb();		wake_up();
-	    STORE current->state	  ...
-	    <general barrier>		  <general barrier>
-	LOAD event_indicated		  if ((LOAD task->state) & TASK_NORMAL)
-					    STORE task->state
-
-where "task" is the thread being woken up and it equals CPU 1's "current".
-
-To repeat, a general memory barrier is guaranteed to be executed by wake_u=
p()
-if something is actually awakened, but otherwise there is no such guarante=
e.
-To see this, consider the following sequence of events, where X and Y are =
both
-initially zero:
-
-	CPU 1				CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	X =3D 1;				Y =3D 1;
-	smp_mb();			wake_up();
-	LOAD Y				LOAD X
-
-If a wakeup does occur, one (at least) of the two loads must see 1.  If, on
-the other hand, a wakeup does not occur, both loads might see 0.
-
-wake_up_process() always executes a general memory barrier.  The barrier a=
gain
-occurs before the task state is accessed.  In particular, if the wake_up()=
 in
-the previous snippet were replaced by a call to wake_up_process() then one=
 of
-the two loads would be guaranteed to see 1.
-
-The available waker functions include:
-
-	complete();
-	wake_up();
-	wake_up_all();
-	wake_up_bit();
-	wake_up_interruptible();
-	wake_up_interruptible_all();
-	wake_up_interruptible_nr();
-	wake_up_interruptible_poll();
-	wake_up_interruptible_sync();
-	wake_up_interruptible_sync_poll();
-	wake_up_locked();
-	wake_up_locked_poll();
-	wake_up_nr();
-	wake_up_poll();
-	wake_up_process();
-
-In terms of memory ordering, these functions all provide the same guarante=
es of
-a wake_up() (or stronger).
-
-[!] Note that the memory barriers implied by the sleeper and the waker do =
_not_
-order multiple stores before the wake-up with respect to loads of those st=
ored
-values after the sleeper has called set_current_state().  For instance, if=
 the
-sleeper does:
-
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (event_indicated)
-		break;
-	__set_current_state(TASK_RUNNING);
-	do_something(my_data);
-
-and the waker does:
-
-	my_data =3D value;
-	event_indicated =3D 1;
-	wake_up(&event_wait_queue);
-
-there's no guarantee that the change to event_indicated will be perceived =
by
-the sleeper as coming after the change to my_data.  In such a circumstance=
, the
-code on both sides must interpolate its own memory barriers between the
-separate data accesses.  Thus the above sleeper ought to do:
-
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (event_indicated) {
-		smp_rmb();
-		do_something(my_data);
-	}
-
-and the waker should do:
-
-	my_data =3D value;
-	smp_wmb();
-	event_indicated =3D 1;
-	wake_up(&event_wait_queue);
-
-
-MISCELLANEOUS FUNCTIONS
------------------------
-
-Other functions that imply barriers:
-
- (*) schedule() and similar imply full memory barriers.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-INTER-CPU ACQUIRING BARRIER EFFECTS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-On SMP systems locking primitives give a more substantial form of barrier:=
 one
-that does affect memory access ordering on other CPUs, within the context =
of
-conflict on any particular lock.
-
-
-ACQUIRES VS MEMORY ACCESSES
----------------------------
-
-Consider the following: the system has a pair of spinlocks (M) and (Q), and
-three CPUs; then should the following sequence of events occur:
-
-	CPU 1				CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	WRITE_ONCE(*A, a);		WRITE_ONCE(*E, e);
-	ACQUIRE M			ACQUIRE Q
-	WRITE_ONCE(*B, b);		WRITE_ONCE(*F, f);
-	WRITE_ONCE(*C, c);		WRITE_ONCE(*G, g);
-	RELEASE M			RELEASE Q
-	WRITE_ONCE(*D, d);		WRITE_ONCE(*H, h);
-
-Then there is no guarantee as to what order CPU 3 will see the accesses to=
 *A
-through *H occur in, other than the constraints imposed by the separate lo=
cks
-on the separate CPUs.  It might, for example, see:
-
-	*E, ACQUIRE M, ACQUIRE Q, *G, *C, *F, *A, *B, RELEASE Q, *D, *H, RELEASE M
-
-But it won't see any of:
-
-	*B, *C or *D preceding ACQUIRE M
-	*A, *B or *C following RELEASE M
-	*F, *G or *H preceding ACQUIRE Q
-	*E, *F or *G following RELEASE Q
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-WHERE ARE MEMORY BARRIERS NEEDED?
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Under normal operation, memory operation reordering is generally not going=
 to
-be a problem as a single-threaded linear piece of code will still appear to
-work correctly, even if it's in an SMP kernel.  There are, however, four
-circumstances in which reordering definitely _could_ be a problem:
-
- (*) Interprocessor interaction.
-
- (*) Atomic operations.
-
- (*) Accessing devices.
-
- (*) Interrupts.
-
-
-INTERPROCESSOR INTERACTION
---------------------------
-
-When there's a system with more than one processor, more than one CPU in t=
he
-system may be working on the same data set at the same time.  This can cau=
se
-synchronisation problems, and the usual way of dealing with them is to use
-locks.  Locks, however, are quite expensive, and so it may be preferable to
-operate without the use of a lock if at all possible.  In such a case
-operations that affect both CPUs may have to be carefully ordered to preve=
nt
-a malfunction.
-
-Consider, for example, the R/W semaphore slow path.  Here a waiting proces=
s is
-queued on the semaphore, by virtue of it having a piece of its stack linke=
d to
-the semaphore's list of waiting processes:
-
-	struct rw_semaphore {
-		...
-		spinlock_t lock;
-		struct list_head waiters;
-	};
-
-	struct rwsem_waiter {
-		struct list_head list;
-		struct task_struct *task;
-	};
-
-To wake up a particular waiter, the up_read() or up_write() functions have=
 to:
-
- (1) read the next pointer from this waiter's record to know as to where t=
he
-     next waiter record is;
-
- (2) read the pointer to the waiter's task structure;
-
- (3) clear the task pointer to tell the waiter it has been given the semap=
hore;
-
- (4) call wake_up_process() on the task; and
-
- (5) release the reference held on the waiter's task struct.
-
-In other words, it has to perform this sequence of events:
-
-	LOAD waiter->list.next;
-	LOAD waiter->task;
-	STORE waiter->task;
-	CALL wakeup
-	RELEASE task
-
-and if any of these steps occur out of order, then the whole thing may
-malfunction.
-
-Once it has queued itself and dropped the semaphore lock, the waiter does =
not
-get the lock again; it instead just waits for its task pointer to be clear=
ed
-before proceeding.  Since the record is on the waiter's stack, this means =
that
-if the task pointer is cleared _before_ the next pointer in the list is re=
ad,
-another CPU might start processing the waiter and might clobber the waiter=
's
-stack before the up*() function has a chance to read the next pointer.
-
-Consider then what might happen to the above sequence of events:
-
-	CPU 1				CPU 2
-	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-					down_xxx()
-					Queue waiter
-					Sleep
-	up_yyy()
-	LOAD waiter->task;
-	STORE waiter->task;
-					Woken up by other event
-	<preempt>
-					Resume processing
-					down_xxx() returns
-					call foo()
-					foo() clobbers *waiter
-	</preempt>
-	LOAD waiter->list.next;
-	--- OOPS ---
-
-This could be dealt with using the semaphore lock, but then the down_xxx()
-function has to needlessly get the spinlock again after being woken up.
-
-The way to deal with this is to insert a general SMP memory barrier:
-
-	LOAD waiter->list.next;
-	LOAD waiter->task;
-	smp_mb();
-	STORE waiter->task;
-	CALL wakeup
-	RELEASE task
-
-In this case, the barrier makes a guarantee that all memory accesses befor=
e the
-barrier will appear to happen before all the memory accesses after the bar=
rier
-with respect to the other CPUs on the system.  It does _not_ guarantee tha=
t all
-the memory accesses before the barrier will be complete by the time the ba=
rrier
-instruction itself is complete.
-
-On a UP system - where this wouldn't be a problem - the smp_mb() is just a
-compiler barrier, thus making sure the compiler emits the instructions in =
the
-right order without actually intervening in the CPU.  Since there's only o=
ne
-CPU, that CPU's dependency ordering logic will take care of everything els=
e.
-
-
-ATOMIC OPERATIONS
------------------
-
-While they are technically interprocessor interaction considerations, atom=
ic
-operations are noted specially as some of them imply full memory barriers =
and
-some don't, but they're very heavily relied on as a group throughout the
-kernel.
-
-See Documentation/atomic_t.txt for more information.
-
-
-ACCESSING DEVICES
------------------
-
-Many devices can be memory mapped, and so appear to the CPU as if they're =
just
-a set of memory locations.  To control such a device, the driver usually h=
as to
-make the right memory accesses in exactly the right order.
-
-However, having a clever CPU or a clever compiler creates a potential prob=
lem
-in that the carefully sequenced accesses in the driver code won't reach the
-device in the requisite order if the CPU or the compiler thinks it is more
-efficient to reorder, combine or merge accesses - something that would cau=
se
-the device to malfunction.
-
-Inside of the Linux kernel, I/O should be done through the appropriate acc=
essor
-routines - such as inb() or writel() - which know how to make such accesses
-appropriately sequential.  While this, for the most part, renders the expl=
icit
-use of memory barriers unnecessary, if the accessor functions are used to =
refer
-to an I/O memory window with relaxed memory access properties, then _manda=
tory_
-memory barriers are required to enforce ordering.
-
-See Documentation/driver-api/device-io.rst for more information.
-
-
-INTERRUPTS
-----------
-
-A driver may be interrupted by its own interrupt service routine, and thus=
 the
-two parts of the driver may interfere with each other's attempts to contro=
l or
-access the device.
-
-This may be alleviated - at least in part - by disabling local interrupts =
(a
-form of locking), such that the critical operations are all contained with=
in
-the interrupt-disabled section in the driver.  While the driver's interrupt
-routine is executing, the driver's core may not run on the same CPU, and i=
ts
-interrupt is not permitted to happen again until the current interrupt has=
 been
-handled, thus the interrupt handler does not need to lock against that.
-
-However, consider a driver that was talking to an ethernet card that sport=
s an
-address register and a data register.  If that driver's core talks to the =
card
-under interrupt-disablement and then the driver's interrupt handler is inv=
oked:
-
-	LOCAL IRQ DISABLE
-	writew(ADDR, 3);
-	writew(DATA, y);
-	LOCAL IRQ ENABLE
-	<interrupt>
-	writew(ADDR, 4);
-	q =3D readw(DATA);
-	</interrupt>
-
-The store to the data register might happen after the second store to the
-address register if ordering rules are sufficiently relaxed:
-
-	STORE *ADDR =3D 3, STORE *ADDR =3D 4, STORE *DATA =3D y, q =3D LOAD *DATA
-
-
-If ordering rules are relaxed, it must be assumed that accesses done insid=
e an
-interrupt disabled section may leak outside of it and may interleave with
-accesses performed in an interrupt - and vice versa - unless implicit or
-explicit barriers are used.
-
-Normally this won't be a problem because the I/O accesses done inside such
-sections will include synchronous load operations on strictly ordered I/O
-registers that form implicit I/O barriers.
-
-
-A similar situation may occur between an interrupt routine and two routines
-running on separate CPUs that communicate with each other.  If such a case=
 is
-likely, then interrupt-disabling locks should be used to guarantee orderin=
g.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
-KERNEL I/O BARRIER EFFECTS
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
-
-Interfacing with peripherals via I/O accesses is deeply architecture and d=
evice
-specific. Therefore, drivers which are inherently non-portable may rely on
-specific behaviours of their target systems in order to achieve synchroniz=
ation
-in the most lightweight manner possible. For drivers intending to be porta=
ble
-between multiple architectures and bus implementations, the kernel offers a
-series of accessor functions that provide various degrees of ordering
-guarantees:
-
- (*) readX(), writeX():
-
-	The readX() and writeX() MMIO accessors take a pointer to the
-	peripheral being accessed as an __iomem * parameter. For pointers
-	mapped with the default I/O attributes (e.g. those returned by
-	ioremap()), the ordering guarantees are as follows:
-
-	1. All readX() and writeX() accesses to the same peripheral are ordered
-	   with respect to each other. This ensures that MMIO register accesses
-	   by the same CPU thread to a particular device will arrive in program
-	   order.
-
-	2. A writeX() issued by a CPU thread holding a spinlock is ordered
-	   before a writeX() to the same peripheral from another CPU thread
-	   issued after a later acquisition of the same spinlock. This ensures
-	   that MMIO register writes to a particular device issued while holding
-	   a spinlock will arrive in an order consistent with acquisitions of
-	   the lock.
-
-	3. A writeX() by a CPU thread to the peripheral will first wait for the
-	   completion of all prior writes to memory either issued by, or
-	   propagated to, the same thread. This ensures that writes by the CPU
-	   to an outbound DMA buffer allocated by dma_alloc_coherent() will be
-	   visible to a DMA engine when the CPU writes to its MMIO control
-	   register to trigger the transfer.
-
-	4. A readX() by a CPU thread from the peripheral will complete before
-	   any subsequent reads from memory by the same thread can begin. This
-	   ensures that reads by the CPU from an incoming DMA buffer allocated
-	   by dma_alloc_coherent() will not see stale data after reading from
-	   the DMA engine's MMIO status register to establish that the DMA
-	   transfer has completed.
-
-	5. A readX() by a CPU thread from the peripheral will complete before
-	   any subsequent delay() loop can begin execution on the same thread.
-	   This ensures that two MMIO register writes by the CPU to a peripheral
-	   will arrive at least 1us apart if the first write is immediately read
-	   back with readX() and udelay(1) is called prior to the second
-	   writeX():
-
-		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
-		readl(DEVICE_REGISTER_0);
-		udelay(1);
-		writel(42, DEVICE_REGISTER_1); // ...at least 1us before this.
-
-	The ordering properties of __iomem pointers obtained with non-default
-	attributes (e.g. those returned by ioremap_wc()) are specific to the
-	underlying architecture and therefore the guarantees listed above cannot
-	generally be relied upon for accesses to these types of mappings.
-
- (*) readX_relaxed(), writeX_relaxed():
-
-	These are similar to readX() and writeX(), but provide weaker memory
-	ordering guarantees. Specifically, they do not guarantee ordering with
-	respect to locking, normal memory accesses or delay() loops (i.e.
-	bullets 2-5 above) but they are still guaranteed to be ordered with
-	respect to other accesses from the same CPU thread to the same
-	peripheral when operating on __iomem pointers mapped with the default
-	I/O attributes.
-
- (*) readsX(), writesX():
-
-	The readsX() and writesX() MMIO accessors are designed for accessing
-	register-based, memory-mapped FIFOs residing on peripherals that are not
-	capable of performing DMA. Consequently, they provide only the ordering
-	guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
-
- (*) inX(), outX():
-
-	The inX() and outX() accessors are intended to access legacy port-mapped
-	I/O peripherals, which may require special instructions on some
-	architectures (notably x86). The port number of the peripheral being
-	accessed is passed as an argument.
-
-	Since many CPU architectures ultimately access these peripherals via an
-	internal virtual memory mapping, the portable ordering guarantees
-	provided by inX() and outX() are the same as those provided by readX()
-	and writeX() respectively when accessing a mapping with the default I/O
-	attributes.
-
-	Device drivers may expect outX() to emit a non-posted write transaction
-	that waits for a completion response from the I/O peripheral before
-	returning. This is not guaranteed by all architectures and is therefore
-	not part of the portable ordering semantics.
-
- (*) insX(), outsX():
-
-	As above, the insX() and outsX() accessors provide the same ordering
-	guarantees as readsX() and writesX() respectively when accessing a
-	mapping with the default I/O attributes.
-
- (*) ioreadX(), iowriteX():
-
-	These will perform appropriately for the type of access they're actually
-	doing, be it inX()/outX() or readX()/writeX().
-
-With the exception of the string accessors (insX(), outsX(), readsX() and
-writesX()), all of the above assume that the underlying peripheral is
-little-endian and will therefore perform byte-swapping operations on big-e=
ndian
-architectures.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-ASSUMED MINIMUM EXECUTION ORDERING MODEL
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-It has to be assumed that the conceptual CPU is weakly-ordered but that it=
 will
-maintain the appearance of program causality with respect to itself.  Some=
 CPUs
-(such as i386 or x86_64) are more constrained than others (such as powerpc=
 or
-frv), and so the most relaxed case (namely DEC Alpha) must be assumed outs=
ide
-of arch-specific code.
-
-This means that it must be considered that the CPU will execute its instru=
ction
-stream in any order it feels like - or even in parallel - provided that if=
 an
-instruction in the stream depends on an earlier instruction, then that
-earlier instruction must be sufficiently complete[*] before the later
-instruction may proceed; in other words: provided that the appearance of
-causality is maintained.
-
- [*] Some instructions have more than one effect - such as changing the
-     condition codes, changing registers or changing memory - and different
-     instructions may depend on different effects.
-
-A CPU may also discard any instruction sequence that winds up having no
-ultimate effect.  For example, if two adjacent instructions both load an
-immediate value into the same register, the first may be discarded.
-
-
-Similarly, it has to be assumed that compiler might reorder the instruction
-stream in any way it sees fit, again provided the appearance of causality =
is
-maintained.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-THE EFFECTS OF THE CPU CACHE
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-The way cached memory operations are perceived across the system is affect=
ed to
-a certain extent by the caches that lie between CPUs and memory, and by the
-memory coherence system that maintains the consistency of state in the sys=
tem.
-
-As far as the way a CPU interacts with another part of the system through =
the
-caches goes, the memory system has to include the CPU's caches, and memory
-barriers for the most part act at the interface between the CPU and its ca=
che
-(memory barriers logically act on the dotted line in the following diagram=
):
-
-	    <--- CPU --->         :       <----------- Memory ----------->
-	                          :
-	+--------+    +--------+  :   +--------+    +-----------+
-	|        |    |        |  :   |        |    |           |    +--------+
-	|  CPU   |    | Memory |  :   | CPU    |    |           |    |        |
-	|  Core  |--->| Access |----->| Cache  |<-->|           |    |        |
-	|        |    | Queue  |  :   |        |    |           |--->| Memory |
-	|        |    |        |  :   |        |    |           |    |        |
-	+--------+    +--------+  :   +--------+    |           |    |        |
-	                          :                 | Cache     |    +--------+
-	                          :                 | Coherency |
-	                          :                 | Mechanism |    +--------+
-	+--------+    +--------+  :   +--------+    |           |    |	      |
-	|        |    |        |  :   |        |    |           |    |        |
-	|  CPU   |    | Memory |  :   | CPU    |    |           |--->| Device |
-	|  Core  |--->| Access |----->| Cache  |<-->|           |    |        |
-	|        |    | Queue  |  :   |        |    |           |    |        |
-	|        |    |        |  :   |        |    |           |    +--------+
-	+--------+    +--------+  :   +--------+    +-----------+
-	                          :
-	                          :
-
-Although any particular load or store may not actually appear outside of t=
he
-CPU that issued it since it may have been satisfied within the CPU's own c=
ache,
-it will still appear as if the full memory access had taken place as far a=
s the
-other CPUs are concerned since the cache coherency mechanisms will migrate=
 the
-cacheline over to the accessing CPU and propagate the effects upon conflic=
t.
-
-The CPU core may execute instructions in any order it deems fit, provided =
the
-expected program causality appears to be maintained.  Some of the instruct=
ions
-generate load and store operations which then go into the queue of memory
-accesses to be performed.  The core may place these in the queue in any or=
der
-it wishes, and continue execution until it is forced to wait for an instru=
ction
-to complete.
-
-What memory barriers are concerned with is controlling the order in which
-accesses cross from the CPU side of things to the memory side of things, a=
nd
-the order in which the effects are perceived to happen by the other observ=
ers
-in the system.
-
-[!] Memory barriers are _not_ needed within a given CPU, as CPUs always see
-their own loads and stores as if they had happened in program order.
-
-[!] MMIO or other device accesses may bypass the cache system.  This depen=
ds on
-the properties of the memory window through which devices are accessed and=
/or
-the use of any special device communication instructions the CPU may have.
-
-
-CACHE COHERENCY VS DMA
-----------------------
-
-Not all systems maintain cache coherency with respect to devices doing DMA=
.  In
-such cases, a device attempting DMA may obtain stale data from RAM because
-dirty cache lines may be resident in the caches of various CPUs, and may n=
ot
-have been written back to RAM yet.  To deal with this, the appropriate par=
t of
-the kernel must flush the overlapping bits of cache on each CPU (and maybe
-invalidate them as well).
-
-In addition, the data DMA'd to RAM by a device may be overwritten by dirty
-cache lines being written back to RAM from a CPU's cache after the device =
has
-installed its own data, or cache lines present in the CPU's cache may simp=
ly
-obscure the fact that RAM has been updated, until at such time as the cach=
eline
-is discarded from the CPU's cache and reloaded.  To deal with this, the
-appropriate part of the kernel must invalidate the overlapping bits of the
-cache on each CPU.
-
-See Documentation/core-api/cachetlb.rst for more information on cache
-management.
-
-
-CACHE COHERENCY VS MMIO
------------------------
-
-Memory mapped I/O usually takes place through memory locations that are pa=
rt of
-a window in the CPU's memory space that has different properties assigned =
than
-the usual RAM directed window.
-
-Amongst these properties is usually the fact that such accesses bypass the
-caching entirely and go directly to the device buses.  This means MMIO acc=
esses
-may, in effect, overtake accesses to cached memory that were emitted earli=
er.
-A memory barrier isn't sufficient in such a case, but rather the cache mus=
t be
-flushed between the cached memory write and the MMIO access if the two are=
 in
-any way dependent.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-THE THINGS CPUS GET UP TO
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-A programmer might take it for granted that the CPU will perform memory
-operations in exactly the order specified, so that if the CPU is, for exam=
ple,
-given the following piece of code to execute:
-
-	a =3D READ_ONCE(*A);
-	WRITE_ONCE(*B, b);
-	c =3D READ_ONCE(*C);
-	d =3D READ_ONCE(*D);
-	WRITE_ONCE(*E, e);
-
-they would then expect that the CPU will complete the memory operation for=
 each
-instruction before moving on to the next one, leading to a definite sequen=
ce of
-operations as seen by external observers in the system:
-
-	LOAD *A, STORE *B, LOAD *C, LOAD *D, STORE *E.
-
-
-Reality is, of course, much messier.  With many CPUs and compilers, the ab=
ove
-assumption doesn't hold because:
-
- (*) loads are more likely to need to be completed immediately to permit
-     execution progress, whereas stores can often be deferred without a
-     problem;
-
- (*) loads may be done speculatively, and the result discarded should it p=
rove
-     to have been unnecessary;
-
- (*) loads may be done speculatively, leading to the result having been fe=
tched
-     at the wrong time in the expected sequence of events;
-
- (*) the order of the memory accesses may be rearranged to promote better =
use
-     of the CPU buses and caches;
-
- (*) loads and stores may be combined to improve performance when talking =
to
-     memory or I/O hardware that can do batched accesses of adjacent locat=
ions,
-     thus cutting down on transaction setup costs (memory and PCI devices =
may
-     both be able to do this); and
-
- (*) the CPU's data cache may affect the ordering, and while cache-coheren=
cy
-     mechanisms may alleviate this - once the store has actually hit the c=
ache
-     - there's no guarantee that the coherency management will be propagat=
ed in
-     order to other CPUs.
-
-So what another CPU, say, might actually observe from the above piece of c=
ode
-is:
-
-	LOAD *A, ..., LOAD {*C,*D}, STORE *E, STORE *B
-
-	(Where "LOAD {*C,*D}" is a combined load)
-
-
-However, it is guaranteed that a CPU will be self-consistent: it will see =
its
-_own_ accesses appear to be correctly ordered, without the need for a memo=
ry
-barrier.  For instance with the following code:
-
-	U =3D READ_ONCE(*A);
-	WRITE_ONCE(*A, V);
-	WRITE_ONCE(*A, W);
-	X =3D READ_ONCE(*A);
-	WRITE_ONCE(*A, Y);
-	Z =3D READ_ONCE(*A);
-
-and assuming no intervention by an external influence, it can be assumed t=
hat
-the final result will appear to be:
-
-	U =3D=3D the original value of *A
-	X =3D=3D W
-	Z =3D=3D Y
-	*A =3D=3D Y
-
-The code above may cause the CPU to generate the full sequence of memory
-accesses:
-
-	U=3DLOAD *A, STORE *A=3DV, STORE *A=3DW, X=3DLOAD *A, STORE *A=3DY, Z=3DL=
OAD *A
-
-in that order, but, without intervention, the sequence may have almost any
-combination of elements combined or discarded, provided the program's view
-of the world remains consistent.  Note that READ_ONCE() and WRITE_ONCE()
-are -not- optional in the above example, as there are architectures
-where a given CPU might reorder successive loads to the same location.
-On such architectures, READ_ONCE() and WRITE_ONCE() do whatever is
-necessary to prevent this, for example, on Itanium the volatile casts
-used by READ_ONCE() and WRITE_ONCE() cause GCC to emit the special ld.acq
-and st.rel instructions (respectively) that prevent such reordering.
-
-The compiler may also combine, discard or defer elements of the sequence b=
efore
-the CPU even sees them.
-
-For instance:
-
-	*A =3D V;
-	*A =3D W;
-
-may be reduced to:
-
-	*A =3D W;
-
-since, without either a write barrier or an WRITE_ONCE(), it can be
-assumed that the effect of the storage of V to *A is lost.  Similarly:
-
-	*A =3D Y;
-	Z =3D *A;
-
-may, without a memory barrier or an READ_ONCE() and WRITE_ONCE(), be
-reduced to:
-
-	*A =3D Y;
-	Z =3D Y;
-
-and the LOAD operation never appear outside of the CPU.
-
-
-AND THEN THERE'S THE ALPHA
---------------------------
-
-The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that,
-some versions of the Alpha CPU have a split data cache, permitting them to=
 have
-two semantically-related cache lines updated at separate times.  This is w=
here
-the address-dependency barrier really becomes necessary as this synchronis=
es
-both caches with the memory coherence system, thus making it seem like poi=
nter
-changes vs new data occur in the right order.
-
-The Alpha defines the Linux kernel's memory model, although as of v4.15
-the Linux kernel's addition of smp_mb() to READ_ONCE() on Alpha greatly
-reduced its impact on the memory model.
-
-
-VIRTUAL MACHINE GUESTS
-----------------------
-
-Guests running within virtual machines might be affected by SMP effects ev=
en if
-the guest itself is compiled without SMP support.  This is an artifact of
-interfacing with an SMP host while running an UP kernel.  Using mandatory
-barriers for this use-case would be possible but is often suboptimal.
-
-To handle this case optimally, low-level virt_mb() etc macros are availabl=
e.
-These have the same effect as smp_mb() etc when SMP is enabled, but genera=
te
-identical code for SMP and non-SMP systems.  For example, virtual machine =
guests
-should use virt_mb() rather than smp_mb() when synchronizing against a
-(possibly SMP) host.
-
-These are equivalent to smp_mb() etc counterparts in all other respects,
-in particular, they do not control MMIO effects: to control
-MMIO effects, use mandatory barriers.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-EXAMPLE USES
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-CIRCULAR BUFFERS
-----------------
-
-Memory barriers can be used to implement circular buffering without the ne=
ed
-of a lock to serialise the producer with the consumer.  See:
-
-	Documentation/core-api/circular-buffers.rst
-
-for details.
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-REFERENCES
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Alpha AXP Architecture Reference Manual, Second Edition (Sites & Witek,
-Digital Press)
-	Chapter 5.2: Physical Address Space Characteristics
-	Chapter 5.4: Caches and Write Buffers
-	Chapter 5.5: Data Sharing
-	Chapter 5.6: Read/Write Ordering
-
-AMD64 Architecture Programmer's Manual Volume 2: System Programming
-	Chapter 7.1: Memory-Access Ordering
-	Chapter 7.4: Buffering and Combining Memory Writes
-
-ARM Architecture Reference Manual (ARMv8, for ARMv8-A architecture profile)
-	Chapter B2: The AArch64 Application Level Memory Model
-
-IA-32 Intel Architecture Software Developer's Manual, Volume 3:
-System Programming Guide
-	Chapter 7.1: Locked Atomic Operations
-	Chapter 7.2: Memory Ordering
-	Chapter 7.4: Serializing Instructions
-
-The SPARC Architecture Manual, Version 9
-	Chapter 8: Memory Models
-	Appendix D: Formal Specification of the Memory Models
-	Appendix J: Programming with the Memory Models
-
-Storage in the PowerPC (Stone and Fitzgerald)
-
-UltraSPARC Programmer Reference Manual
-	Chapter 5: Memory Accesses and Cacheability
-	Chapter 15: Sparc-V9 Memory Models
-
-UltraSPARC III Cu User's Manual
-	Chapter 9: Memory Models
-
-UltraSPARC IIIi Processor User's Manual
-	Chapter 8: Memory Models
-
-UltraSPARC Architecture 2005
-	Chapter 9: Memory
-	Appendix D: Formal Specifications of the Memory Models
-
-UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005
-	Chapter 8: Memory Models
-	Appendix F: Caches and Cache Coherency
-
-Solaris Internals, Core Kernel Architecture, p63-68:
-	Chapter 3.3: Hardware Considerations for Locks and
-			Synchronization
-
-Unix Systems for Modern Architectures, Symmetric Multiprocessing and Cachi=
ng
-for Kernel Programmers:
-	Chapter 13: Other Memory Models
-
-Intel Itanium Architecture Software Developer's Manual: Volume 1:
-	Section 2.6: Speculation
-	Section 4.4: Memory Access
+			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0D
+			 LINUX KERNEL MEMORY BARRIERS=0D
+			 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0D
+=0D
+By: David Howells <dhowells@redhat.com>=0D
+    Paul E. McKenney <paulmck@linux.ibm.com>=0D
+    Will Deacon <will.deacon@arm.com>=0D
+    Peter Zijlstra <peterz@infradead.org>=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+DISCLAIMER=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+This document is not a specification; it is intentionally (for the sake of=
=0D
+brevity) and unintentionally (due to being human) incomplete. This documen=
t is=0D
+meant as a guide to using the various memory barriers provided by Linux, b=
ut=0D
+in case of any doubt (and there are many) please ask.  Some doubts may be=
=0D
+resolved by referring to the formal memory consistency model and related=0D
+documentation at tools/memory-model/ directory of the kernel source tree. =
 Nevertheless, even this memory=0D
+model should be viewed as the collective opinion of its maintainers rather=
=0D
+than as an infallible oracle.=0D
+=0D
+To repeat, this document is not a specification of what Linux expects from=
=0D
+hardware.=0D
+=0D
+The purpose of this document is twofold:=0D
+=0D
+ (1) to specify the minimum functionality that one can rely on for any=0D
+     particular barrier, and=0D
+=0D
+ (2) to provide a guide as to how to use the barriers that are available.=
=0D
+=0D
+Note that an architecture can provide more than the minimum requirement=0D
+for any particular barrier, but if the architecture provides less than=0D
+that, that architecture is considered incorrect.=0D
+=0D
+Note also that it is possible that a barrier may be a no-op for an=0D
+architecture because the way that arch works renders an explicit barrier=0D
+unnecessary in that case.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=0D
+CONTENTS=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+ (*) Abstract memory access model.=0D
+=0D
+     - Device operations.=0D
+     - Guarantees.=0D
+=0D
+ (*) What are memory barriers?=0D
+=0D
+     - Varieties of memory barrier.=0D
+     - What may not be assumed about memory barriers?=0D
+     - Address-dependency barriers (historical).=0D
+     - Control dependencies.=0D
+     - SMP barrier pairing.=0D
+     - Examples of memory barrier sequences.=0D
+     - Read memory barriers vs load speculation.=0D
+     - Multicopy atomicity.=0D
+=0D
+ (*) Explicit kernel barriers.=0D
+=0D
+     - Compiler barrier.=0D
+     - CPU memory barriers.=0D
+=0D
+ (*) Implicit kernel memory barriers.=0D
+=0D
+     - Lock acquisition functions.=0D
+     - Interrupt disabling functions.=0D
+     - Sleep and wake-up functions.=0D
+     - Miscellaneous functions.=0D
+=0D
+ (*) Inter-CPU acquiring barrier effects.=0D
+=0D
+     - Acquires vs memory accesses.=0D
+=0D
+ (*) Where are memory barriers needed?=0D
+=0D
+     - Interprocessor interaction.=0D
+     - Atomic operations.=0D
+     - Accessing devices.=0D
+     - Interrupts.=0D
+=0D
+ (*) Kernel I/O barrier effects.=0D
+=0D
+ (*) Assumed minimum execution ordering model.=0D
+=0D
+ (*) The effects of the cpu cache.=0D
+=0D
+     - Cache coherency vs DMA.=0D
+     - Cache coherency vs MMIO.=0D
+=0D
+ (*) The things CPUs get up to.=0D
+=0D
+     - And then there's the Alpha.=0D
+     - Virtual Machine Guests.=0D
+=0D
+ (*) Example uses.=0D
+=0D
+     - Circular buffers.=0D
+=0D
+ (*) References.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0D
+ABSTRACT MEMORY ACCESS MODEL=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0D
+=0D
+Consider the following abstract model of the system:=0D
+=0D
+		            :                :=0D
+		            :                :=0D
+		            :                :=0D
+		+-------+   :   +--------+   :   +-------+=0D
+		|       |   :   |        |   :   |       |=0D
+		|       |   :   |        |   :   |       |=0D
+		| CPU 1 |<----->| Memory |<----->| CPU 2 |=0D
+		|       |   :   |        |   :   |       |=0D
+		|       |   :   |        |   :   |       |=0D
+		+-------+   :   +--------+   :   +-------+=0D
+		    ^       :       ^        :       ^=0D
+		    |       :       |        :       |=0D
+		    |       :       |        :       |=0D
+		    |       :       v        :       |=0D
+		    |       :   +--------+   :       |=0D
+		    |       :   |        |   :       |=0D
+		    |       :   |        |   :       |=0D
+		    +---------->| Device |<----------+=0D
+		            :   |        |   :=0D
+		            :   |        |   :=0D
+		            :   +--------+   :=0D
+		            :                :=0D
+=0D
+Each CPU executes a program that generates memory access operations.  In t=
he=0D
+abstract CPU, memory operation ordering is very relaxed, and a CPU may act=
ually=0D
+perform the memory operations in any order it likes, provided program caus=
ality=0D
+appears to be maintained.  Similarly, the compiler may also arrange the=0D
+instructions it emits in any order it likes, provided it doesn't affect th=
e=0D
+apparent operation of the program.=0D
+=0D
+So in the above diagram, the effects of the memory operations performed by=
 a=0D
+CPU are perceived by the rest of the system as the operations cross the=0D
+interface between the CPU and rest of the system (the dotted lines).=0D
+=0D
+=0D
+For example, consider the following sequence of events:=0D
+=0D
+	CPU 1		CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0D
+	{ A =3D=3D 1; B =3D=3D 2 }=0D
+	A =3D 3;		x =3D B;=0D
+	B =3D 4;		y =3D A;=0D
+=0D
+The set of accesses as seen by the memory system in the middle can be arra=
nged=0D
+in 24 different combinations:=0D
+=0D
+	STORE A=3D3,	STORE B=3D4,	y=3DLOAD A->3,	x=3DLOAD B->4=0D
+	STORE A=3D3,	STORE B=3D4,	x=3DLOAD B->4,	y=3DLOAD A->3=0D
+	STORE A=3D3,	y=3DLOAD A->3,	STORE B=3D4,	x=3DLOAD B->4=0D
+	STORE A=3D3,	y=3DLOAD A->3,	x=3DLOAD B->2,	STORE B=3D4=0D
+	STORE A=3D3,	x=3DLOAD B->2,	STORE B=3D4,	y=3DLOAD A->3=0D
+	STORE A=3D3,	x=3DLOAD B->2,	y=3DLOAD A->3,	STORE B=3D4=0D
+	STORE B=3D4,	STORE A=3D3,	y=3DLOAD A->3,	x=3DLOAD B->4=0D
+	STORE B=3D4, ...=0D
+	...=0D
+=0D
+and can thus result in four different combinations of values:=0D
+=0D
+	x =3D=3D 2, y =3D=3D 1=0D
+	x =3D=3D 2, y =3D=3D 3=0D
+	x =3D=3D 4, y =3D=3D 1=0D
+	x =3D=3D 4, y =3D=3D 3=0D
+=0D
+=0D
+Furthermore, the stores committed by a CPU to the memory system may not be=
=0D
+perceived by the loads made by another CPU in the same order as the stores=
 were=0D
+committed.=0D
+=0D
+=0D
+As a further example, consider this sequence of events:=0D
+=0D
+	CPU 1		CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0D
+	{ A =3D=3D 1, B =3D=3D 2, C =3D=3D 3, P =3D=3D &A, Q =3D=3D &C }=0D
+	B =3D 4;		Q =3D P;=0D
+	P =3D &B;		D =3D *Q;=0D
+=0D
+There is an obvious address dependency here, as the value loaded into D de=
pends=0D
+on the address retrieved from P by CPU 2.  At the end of the sequence, any=
 of=0D
+the following results are possible:=0D
+=0D
+	(Q =3D=3D &A) and (D =3D=3D 1)=0D
+	(Q =3D=3D &B) and (D =3D=3D 2)=0D
+	(Q =3D=3D &B) and (D =3D=3D 4)=0D
+=0D
+Note that CPU 2 will never try and load C into D because the CPU will load=
 P=0D
+into Q before issuing the load of *Q.=0D
+=0D
+=0D
+DEVICE OPERATIONS=0D
+-----------------=0D
+=0D
+Some devices present their control interfaces as collections of memory=0D
+locations, but the order in which the control registers are accessed is ve=
ry=0D
+important.  For instance, imagine an ethernet card with a set of internal=
=0D
+registers that are accessed through an address port register (A) and a dat=
a=0D
+port register (D).  To read internal register 5, the following code might =
then=0D
+be used:=0D
+=0D
+	*A =3D 5;=0D
+	x =3D *D;=0D
+=0D
+but this might show up as either of the following two sequences:=0D
+=0D
+	STORE *A =3D 5, x =3D LOAD *D=0D
+	x =3D LOAD *D, STORE *A =3D 5=0D
+=0D
+the second of which will almost certainly result in a malfunction, since i=
t set=0D
+the address _after_ attempting to read the register.=0D
+=0D
+=0D
+GUARANTEES=0D
+----------=0D
+=0D
+There are some minimal guarantees that may be expected of a CPU:=0D
+=0D
+ (*) On any given CPU, dependent memory accesses will be issued in order, =
with=0D
+     respect to itself.  This means that for:=0D
+=0D
+	Q =3D READ_ONCE(P); D =3D READ_ONCE(*Q);=0D
+=0D
+     the CPU will issue the following memory operations:=0D
+=0D
+	Q =3D LOAD P, D =3D LOAD *Q=0D
+=0D
+     and always in that order.  However, on DEC Alpha, READ_ONCE() also=0D
+     emits a memory-barrier instruction, so that a DEC Alpha CPU will=0D
+     instead issue the following memory operations:=0D
+=0D
+	Q =3D LOAD P, MEMORY_BARRIER, D =3D LOAD *Q, MEMORY_BARRIER=0D
+=0D
+     Whether on DEC Alpha or not, the READ_ONCE() also prevents compiler=0D
+     mischief.=0D
+=0D
+ (*) Overlapping loads and stores within a particular CPU will appear to b=
e=0D
+     ordered within that CPU.  This means that for:=0D
+=0D
+	a =3D READ_ONCE(*X); WRITE_ONCE(*X, b);=0D
+=0D
+     the CPU will only issue the following sequence of memory operations:=
=0D
+=0D
+	a =3D LOAD *X, STORE *X =3D b=0D
+=0D
+     And for:=0D
+=0D
+	WRITE_ONCE(*X, c); d =3D READ_ONCE(*X);=0D
+=0D
+     the CPU will only issue:=0D
+=0D
+	STORE *X =3D c, d =3D LOAD *X=0D
+=0D
+     (Loads and stores overlap if they are targeted at overlapping pieces =
of=0D
+     memory).=0D
+=0D
+And there are a number of things that _must_ or _must_not_ be assumed:=0D
+=0D
+ (*) It _must_not_ be assumed that the compiler will do what you want=0D
+     with memory references that are not protected by READ_ONCE() and=0D
+     WRITE_ONCE().  Without them, the compiler is within its rights to=0D
+     do all sorts of "creative" transformations, which are covered in=0D
+     the COMPILER BARRIER section.=0D
+=0D
+ (*) It _must_not_ be assumed that independent loads and stores will be is=
sued=0D
+     in the order given.  This means that for:=0D
+=0D
+	X =3D *A; Y =3D *B; *D =3D Z;=0D
+=0D
+     we may get any of the following sequences:=0D
+=0D
+	X =3D LOAD *A,  Y =3D LOAD *B,  STORE *D =3D Z=0D
+	X =3D LOAD *A,  STORE *D =3D Z, Y =3D LOAD *B=0D
+	Y =3D LOAD *B,  X =3D LOAD *A,  STORE *D =3D Z=0D
+	Y =3D LOAD *B,  STORE *D =3D Z, X =3D LOAD *A=0D
+	STORE *D =3D Z, X =3D LOAD *A,  Y =3D LOAD *B=0D
+	STORE *D =3D Z, Y =3D LOAD *B,  X =3D LOAD *A=0D
+=0D
+ (*) It _must_ be assumed that overlapping memory accesses may be merged o=
r=0D
+     discarded.  This means that for:=0D
+=0D
+	X =3D *A; Y =3D *(A + 4);=0D
+=0D
+     we may get any one of the following sequences:=0D
+=0D
+	X =3D LOAD *A; Y =3D LOAD *(A + 4);=0D
+	Y =3D LOAD *(A + 4); X =3D LOAD *A;=0D
+	{X, Y} =3D LOAD {*A, *(A + 4) };=0D
+=0D
+     And for:=0D
+=0D
+	*A =3D X; *(A + 4) =3D Y;=0D
+=0D
+     we may get any of:=0D
+=0D
+	STORE *A =3D X; STORE *(A + 4) =3D Y;=0D
+	STORE *(A + 4) =3D Y; STORE *A =3D X;=0D
+	STORE {*A, *(A + 4) } =3D {X, Y};=0D
+=0D
+And there are anti-guarantees:=0D
+=0D
+ (*) These guarantees do not apply to bitfields, because compilers often=0D
+     generate code to modify these using non-atomic read-modify-write=0D
+     sequences.  Do not attempt to use bitfields to synchronize parallel=0D
+     algorithms.=0D
+=0D
+ (*) Even in cases where bitfields are protected by locks, all fields=0D
+     in a given bitfield must be protected by one lock.  If two fields=0D
+     in a given bitfield are protected by different locks, the compiler's=
=0D
+     non-atomic read-modify-write sequences can cause an update to one=0D
+     field to corrupt the value of an adjacent field.=0D
+=0D
+ (*) These guarantees apply only to properly aligned and sized scalar=0D
+     variables.  "Properly sized" currently means variables that are=0D
+     the same size as "char", "short", "int" and "long".  "Properly=0D
+     aligned" means the natural alignment, thus no constraints for=0D
+     "char", two-byte alignment for "short", four-byte alignment for=0D
+     "int", and either four-byte or eight-byte alignment for "long",=0D
+     on 32-bit and 64-bit systems, respectively.  Note that these=0D
+     guarantees were introduced into the C11 standard, so beware when=0D
+     using older pre-C11 compilers (for example, gcc 4.6).  The portion=0D
+     of the standard containing this guarantee is Section 3.14, which=0D
+     defines "memory location" as follows:=0D
+=0D
+     	memory location=0D
+		either an object of scalar type, or a maximal sequence=0D
+		of adjacent bit-fields all having nonzero width=0D
+=0D
+		NOTE 1: Two threads of execution can update and access=0D
+		separate memory locations without interfering with=0D
+		each other.=0D
+=0D
+		NOTE 2: A bit-field and an adjacent non-bit-field member=0D
+		are in separate memory locations. The same applies=0D
+		to two bit-fields, if one is declared inside a nested=0D
+		structure declaration and the other is not, or if the two=0D
+		are separated by a zero-length bit-field declaration,=0D
+		or if they are separated by a non-bit-field member=0D
+		declaration. It is not safe to concurrently update two=0D
+		bit-fields in the same structure if all members declared=0D
+		between them are also bit-fields, no matter what the=0D
+		sizes of those intervening bit-fields happen to be.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0D
+WHAT ARE MEMORY BARRIERS?=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0D
+=0D
+As can be seen above, independent memory operations are effectively perfor=
med=0D
+in random order, but this can be a problem for CPU-CPU interaction and for=
 I/O.=0D
+What is required is some way of intervening to instruct the compiler and t=
he=0D
+CPU to restrict the order.=0D
+=0D
+Memory barriers are such interventions.  They impose a perceived partial=0D
+ordering over the memory operations on either side of the barrier.=0D
+=0D
+Such enforcement is important because the CPUs and other devices in a syst=
em=0D
+can use a variety of tricks to improve performance, including reordering,=
=0D
+deferral and combination of memory operations; speculative loads; speculat=
ive=0D
+branch prediction and various types of caching.  Memory barriers are used =
to=0D
+override or suppress these tricks, allowing the code to sanely control the=
=0D
+interaction of multiple CPUs and/or devices.=0D
+=0D
+=0D
+VARIETIES OF MEMORY BARRIER=0D
+---------------------------=0D
+=0D
+Memory barriers come in four basic varieties:=0D
+=0D
+ (1) Write (or store) memory barriers.=0D
+=0D
+     A write memory barrier gives a guarantee that all the STORE operation=
s=0D
+     specified before the barrier will appear to happen before all the STO=
RE=0D
+     operations specified after the barrier with respect to the other=0D
+     components of the system.=0D
+=0D
+     A write barrier is a partial ordering on stores only; it is not requi=
red=0D
+     to have any effect on loads.=0D
+=0D
+     A CPU can be viewed as committing a sequence of store operations to t=
he=0D
+     memory system as time progresses.  All stores _before_ a write barrie=
r=0D
+     will occur _before_ all the stores after the write barrier.=0D
+=0D
+     [!] Note that write barriers should normally be paired with read or=0D
+     address-dependency barriers; see the "SMP barrier pairing" subsection=
.=0D
+=0D
+=0D
+ (2) Address-dependency barriers (historical).=0D
+     [!] This section is marked as HISTORICAL: it covers the long-obsolete=
=0D
+     smp_read_barrier_depends() macro, the semantics of which are now=0D
+     implicit in all marked accesses.  For more up-to-date information,=0D
+     including how compiler transformations can sometimes break address=0D
+     dependencies, see Documentation/RCU/rcu_dereference.rst.=0D
+=0D
+     An address-dependency barrier is a weaker form of read barrier.  In t=
he=0D
+     case where two loads are performed such that the second depends on th=
e=0D
+     result of the first (eg: the first load retrieves the address to whic=
h=0D
+     the second load will be directed), an address-dependency barrier woul=
d=0D
+     be required to make sure that the target of the second load is update=
d=0D
+     after the address obtained by the first load is accessed.=0D
+=0D
+     An address-dependency barrier is a partial ordering on interdependent=
=0D
+     loads only; it is not required to have any effect on stores, independ=
ent=0D
+     loads or overlapping loads.=0D
+=0D
+     As mentioned in (1), the other CPUs in the system can be viewed as=0D
+     committing sequences of stores to the memory system that the CPU bein=
g=0D
+     considered can then perceive.  An address-dependency barrier issued b=
y=0D
+     the CPU under consideration guarantees that for any load preceding it=
,=0D
+     if that load touches one of a sequence of stores from another CPU, th=
en=0D
+     by the time the barrier completes, the effects of all the stores prio=
r to=0D
+     that touched by the load will be perceptible to any loads issued afte=
r=0D
+     the address-dependency barrier.=0D
+=0D
+     See the "Examples of memory barrier sequences" subsection for diagram=
s=0D
+     showing the ordering constraints.=0D
+=0D
+     [!] Note that the first load really has to have an _address_ dependen=
cy and=0D
+     not a control dependency.  If the address for the second load is depe=
ndent=0D
+     on the first load, but the dependency is through a conditional rather=
 than=0D
+     actually loading the address itself, then it's a _control_ dependency=
 and=0D
+     a full read barrier or better is required.  See the "Control dependen=
cies"=0D
+     subsection for more information.=0D
+=0D
+     [!] Note that address-dependency barriers should normally be paired w=
ith=0D
+     write barriers; see the "SMP barrier pairing" subsection.=0D
+=0D
+     [!] Kernel release v5.9 removed kernel APIs for explicit address-=0D
+     dependency barriers.  Nowadays, APIs for marking loads from shared=0D
+     variables such as READ_ONCE() and rcu_dereference() provide implicit=
=0D
+     address-dependency barriers.=0D
+=0D
+ (3) Read (or load) memory barriers.=0D
+=0D
+     A read barrier is an address-dependency barrier plus a guarantee that=
 all=0D
+     the LOAD operations specified before the barrier will appear to happe=
n=0D
+     before all the LOAD operations specified after the barrier with respe=
ct to=0D
+     the other components of the system.=0D
+=0D
+     A read barrier is a partial ordering on loads only; it is not require=
d to=0D
+     have any effect on stores.=0D
+=0D
+     Read memory barriers imply address-dependency barriers, and so can=0D
+     substitute for them.=0D
+=0D
+     [!] Note that read barriers should normally be paired with write barr=
iers;=0D
+     see the "SMP barrier pairing" subsection.=0D
+=0D
+=0D
+ (4) General memory barriers.=0D
+=0D
+     A general memory barrier gives a guarantee that all the LOAD and STOR=
E=0D
+     operations specified before the barrier will appear to happen before =
all=0D
+     the LOAD and STORE operations specified after the barrier with respec=
t to=0D
+     the other components of the system.=0D
+=0D
+     A general memory barrier is a partial ordering over both loads and st=
ores.=0D
+=0D
+     General memory barriers imply both read and write memory barriers, an=
d so=0D
+     can substitute for either.=0D
+=0D
+=0D
+And a couple of implicit varieties:=0D
+=0D
+ (5) ACQUIRE operations.=0D
+=0D
+     This acts as a one-way permeable barrier.  It guarantees that all mem=
ory=0D
+     operations after the ACQUIRE operation will appear to happen after th=
e=0D
+     ACQUIRE operation with respect to the other components of the system.=
=0D
+     ACQUIRE operations include LOCK operations and both smp_load_acquire(=
)=0D
+     and smp_cond_load_acquire() operations.=0D
+=0D
+     Memory operations that occur before an ACQUIRE operation may appear t=
o=0D
+     happen after it completes.=0D
+=0D
+     An ACQUIRE operation should almost always be paired with a RELEASE=0D
+     operation.=0D
+=0D
+=0D
+ (6) RELEASE operations.=0D
+=0D
+     This also acts as a one-way permeable barrier.  It guarantees that al=
l=0D
+     memory operations before the RELEASE operation will appear to happen=
=0D
+     before the RELEASE operation with respect to the other components of =
the=0D
+     system. RELEASE operations include UNLOCK operations and=0D
+     smp_store_release() operations.=0D
+=0D
+     Memory operations that occur after a RELEASE operation may appear to=
=0D
+     happen before it completes.=0D
+=0D
+     The use of ACQUIRE and RELEASE operations generally precludes the nee=
d=0D
+     for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE pa=
ir is=0D
+     -not- guaranteed to act as a full memory barrier.  However, after an=
=0D
+     ACQUIRE on a given variable, all memory accesses preceding any prior=
=0D
+     RELEASE on that same variable are guaranteed to be visible.  In other=
=0D
+     words, within a given variable's critical section, all accesses of al=
l=0D
+     previous critical sections for that variable are guaranteed to have=0D
+     completed.=0D
+=0D
+     This means that ACQUIRE acts as a minimal "acquire" operation and=0D
+     RELEASE acts as a minimal "release" operation.=0D
+=0D
+A subset of the atomic operations described in atomic_t.txt have ACQUIRE a=
nd=0D
+RELEASE variants in addition to fully-ordered and relaxed (no barrier=0D
+semantics) definitions.  For compound atomics performing both a load and a=
=0D
+store, ACQUIRE semantics apply only to the load and RELEASE semantics appl=
y=0D
+only to the store portion of the operation.=0D
+=0D
+Memory barriers are only required where there's a possibility of interacti=
on=0D
+between two CPUs or between a CPU and a device.  If it can be guaranteed t=
hat=0D
+there won't be any such interaction in any particular piece of code, then=
=0D
+memory barriers are unnecessary in that piece of code.=0D
+=0D
+=0D
+Note that these are the _minimum_ guarantees.  Different architectures may=
 give=0D
+more substantial guarantees, but they may _not_ be relied upon outside of =
arch=0D
+specific code.=0D
+=0D
+=0D
+WHAT MAY NOT BE ASSUMED ABOUT MEMORY BARRIERS?=0D
+----------------------------------------------=0D
+=0D
+There are certain things that the Linux kernel memory barriers do not guar=
antee:=0D
+=0D
+ (*) There is no guarantee that any of the memory accesses specified befor=
e a=0D
+     memory barrier will be _complete_ by the completion of a memory barri=
er=0D
+     instruction; the barrier can be considered to draw a line in that CPU=
's=0D
+     access queue that accesses of the appropriate type may not cross.=0D
+=0D
+ (*) There is no guarantee that issuing a memory barrier on one CPU will h=
ave=0D
+     any direct effect on another CPU or any other hardware in the system.=
  The=0D
+     indirect effect will be the order in which the second CPU sees the ef=
fects=0D
+     of the first CPU's accesses occur, but see the next point:=0D
+=0D
+ (*) There is no guarantee that a CPU will see the correct order of effect=
s=0D
+     from a second CPU's accesses, even _if_ the second CPU uses a memory=
=0D
+     barrier, unless the first CPU _also_ uses a matching memory barrier (=
see=0D
+     the subsection on "SMP Barrier Pairing").=0D
+=0D
+ (*) There is no guarantee that some intervening piece of off-the-CPU=0D
+     hardware[*] will not reorder the memory accesses.  CPU cache coherenc=
y=0D
+     mechanisms should propagate the indirect effects of a memory barrier=
=0D
+     between CPUs, but might not do so in order.=0D
+=0D
+	[*] For information on bus mastering DMA and coherency please read:=0D
+=0D
+	    Documentation/driver-api/pci/pci.rst=0D
+	    Documentation/core-api/dma-api-howto.rst=0D
+	    Documentation/core-api/dma-api.rst=0D
+=0D
+=0D
+ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)=0D
+----------------------------------------=0D
+[!] This section is marked as HISTORICAL: it covers the long-obsolete=0D
+smp_read_barrier_depends() macro, the semantics of which are now implicit=
=0D
+in all marked accesses.  For more up-to-date information, including=0D
+how compiler transformations can sometimes break address dependencies,=0D
+see Documentation/RCU/rcu_dereference.rst.=0D
+=0D
+As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for=
=0D
+DEC Alpha, which means that about the only people who need to pay attentio=
n=0D
+to this section are those working on DEC Alpha architecture-specific code=
=0D
+and those working on READ_ONCE() itself.  For those who need it, and for=0D
+those who are interested in the history, here is the story of=0D
+address-dependency barriers.=0D
+=0D
+[!] While address dependencies are observed in both load-to-load and=0D
+load-to-store relations, address-dependency barriers are not necessary=0D
+for load-to-store situations.=0D
+=0D
+The requirement of address-dependency barriers is a little subtle, and=0D
+it's not always obvious that they're needed.  To illustrate, consider the=
=0D
+following sequence of events:=0D
+=0D
+	CPU 1		      CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	{ A =3D=3D 1, B =3D=3D 2, C =3D=3D 3, P =3D=3D &A, Q =3D=3D &C }=0D
+	B =3D 4;=0D
+	<write barrier>=0D
+	WRITE_ONCE(P, &B);=0D
+			      Q =3D READ_ONCE_OLD(P);=0D
+			      D =3D *Q;=0D
+=0D
+[!] READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which=0D
+doesn't imply an address-dependency barrier.=0D
+=0D
+There's a clear address dependency here, and it would seem that by the end=
 of=0D
+the sequence, Q must be either &A or &B, and that:=0D
+=0D
+	(Q =3D=3D &A) implies (D =3D=3D 1)=0D
+	(Q =3D=3D &B) implies (D =3D=3D 4)=0D
+=0D
+But!  CPU 2's perception of P may be updated _before_ its perception of B,=
 thus=0D
+leading to the following situation:=0D
+=0D
+	(Q =3D=3D &B) and (D =3D=3D 2) ????=0D
+=0D
+While this may seem like a failure of coherency or causality maintenance, =
it=0D
+isn't, and this behaviour can be observed on certain real CPUs (such as th=
e DEC=0D
+Alpha).=0D
+=0D
+To deal with this, READ_ONCE() provides an implicit address-dependency bar=
rier=0D
+since kernel release v4.15:=0D
+=0D
+	CPU 1		      CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	{ A =3D=3D 1, B =3D=3D 2, C =3D=3D 3, P =3D=3D &A, Q =3D=3D &C }=0D
+	B =3D 4;=0D
+	<write barrier>=0D
+	WRITE_ONCE(P, &B);=0D
+			      Q =3D READ_ONCE(P);=0D
+			      <implicit address-dependency barrier>=0D
+			      D =3D *Q;=0D
+=0D
+This enforces the occurrence of one of the two implications, and prevents =
the=0D
+third possibility from arising.=0D
+=0D
+=0D
+[!] Note that this extremely counterintuitive situation arises most easily=
 on=0D
+machines with split caches, so that, for example, one cache bank processes=
=0D
+even-numbered cache lines and the other bank processes odd-numbered cache=
=0D
+lines.  The pointer P might be stored in an odd-numbered cache line, and t=
he=0D
+variable B might be stored in an even-numbered cache line.  Then, if the=0D
+even-numbered bank of the reading CPU's cache is extremely busy while the=
=0D
+odd-numbered bank is idle, one can see the new value of the pointer P (&B)=
,=0D
+but the old value of the variable B (2).=0D
+=0D
+=0D
+An address-dependency barrier is not required to order dependent writes=0D
+because the CPUs that the Linux kernel supports don't do writes until they=
=0D
+are certain (1) that the write will actually happen, (2) of the location o=
f=0D
+the write, and (3) of the value to be written.=0D
+But please carefully read the "CONTROL DEPENDENCIES" section and the=0D
+Documentation/RCU/rcu_dereference.rst file:  The compiler can and does bre=
ak=0D
+dependencies in a great many highly creative ways.=0D
+=0D
+	CPU 1		      CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	{ A =3D=3D 1, B =3D=3D 2, C =3D 3, P =3D=3D &A, Q =3D=3D &C }=0D
+	B =3D 4;=0D
+	<write barrier>=0D
+	WRITE_ONCE(P, &B);=0D
+			      Q =3D READ_ONCE_OLD(P);=0D
+			      WRITE_ONCE(*Q, 5);=0D
+=0D
+Therefore, no address-dependency barrier is required to order the read int=
o=0D
+Q with the store into *Q.  In other words, this outcome is prohibited,=0D
+even without an implicit address-dependency barrier of modern READ_ONCE():=
=0D
+=0D
+	(Q =3D=3D &B) && (B =3D=3D 4)=0D
+=0D
+Please note that this pattern should be rare.  After all, the whole point=
=0D
+of dependency ordering is to -prevent- writes to the data structure, along=
=0D
+with the expensive cache misses associated with those writes.  This patter=
n=0D
+can be used to record rare error conditions and the like, and the CPUs'=0D
+naturally occurring ordering prevents such records from being lost.=0D
+=0D
+=0D
+Note well that the ordering provided by an address dependency is local to=
=0D
+the CPU containing it.  See the section on "Multicopy atomicity" for=0D
+more information.=0D
+=0D
+=0D
+The address-dependency barrier is very important to the RCU system,=0D
+for example.  See rcu_assign_pointer() and rcu_dereference() in=0D
+include/linux/rcupdate.h.  This permits the current target of an RCU'd=0D
+pointer to be replaced with a new modified target, without the replacement=
=0D
+target appearing to be incompletely initialised.=0D
+=0D
+=0D
+CONTROL DEPENDENCIES=0D
+--------------------=0D
+=0D
+Control dependencies can be a bit tricky because current compilers do=0D
+not understand them.  The purpose of this section is to help you prevent=0D
+the compiler's ignorance from breaking your code.=0D
+=0D
+A load-load control dependency requires a full read memory barrier, not=0D
+simply an (implicit) address-dependency barrier to make it work correctly.=
=0D
+Consider the following bit of code:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	<implicit address-dependency barrier>=0D
+	if (q) {=0D
+		/* BUG: No address dependency!!! */=0D
+		p =3D READ_ONCE(b);=0D
+	}=0D
+=0D
+This will not have the desired effect because there is no actual address=0D
+dependency, but rather a control dependency that the CPU may short-circuit=
=0D
+by attempting to predict the outcome in advance, so that other CPUs see=0D
+the load from b as having happened before the load from a.  In such a case=
=0D
+what's actually required is:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q) {=0D
+		<read barrier>=0D
+		p =3D READ_ONCE(b);=0D
+	}=0D
+=0D
+However, stores are not speculated.  This means that ordering -is- provide=
d=0D
+for load-store control dependencies, as in the following example:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q) {=0D
+		WRITE_ONCE(b, 1);=0D
+	}=0D
+=0D
+Control dependencies pair normally with other types of barriers.=0D
+That said, please note that neither READ_ONCE() nor WRITE_ONCE()=0D
+are optional! Without the READ_ONCE(), the compiler might combine the=0D
+load from 'a' with other loads from 'a'.  Without the WRITE_ONCE(),=0D
+the compiler might combine the store to 'b' with other stores to 'b'.=0D
+Either can result in highly counterintuitive effects on ordering.=0D
+=0D
+Worse yet, if the compiler is able to prove (say) that the value of=0D
+variable 'a' is always non-zero, it would be well within its rights=0D
+to optimize the original example by eliminating the "if" statement=0D
+as follows:=0D
+=0D
+	q =3D a;=0D
+	b =3D 1;  /* BUG: Compiler and CPU can both reorder!!! */=0D
+=0D
+So don't leave out the READ_ONCE().=0D
+=0D
+It is tempting to try to enforce ordering on identical stores on both=0D
+branches of the "if" statement as follows:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q) {=0D
+		barrier();=0D
+		WRITE_ONCE(b, 1);=0D
+		do_something();=0D
+	} else {=0D
+		barrier();=0D
+		WRITE_ONCE(b, 1);=0D
+		do_something_else();=0D
+	}=0D
+=0D
+Unfortunately, current compilers will transform this as follows at high=0D
+optimization levels:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	barrier();=0D
+	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */=0D
+	if (q) {=0D
+		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */=0D
+		do_something();=0D
+	} else {=0D
+		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */=0D
+		do_something_else();=0D
+	}=0D
+=0D
+Now there is no conditional between the load from 'a' and the store to=0D
+'b', which means that the CPU is within its rights to reorder them:=0D
+The conditional is absolutely required, and must be present in the=0D
+assembly code even after all compiler optimizations have been applied.=0D
+Therefore, if you need ordering in this example, you need explicit=0D
+memory barriers, for example, smp_store_release():=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q) {=0D
+		smp_store_release(&b, 1);=0D
+		do_something();=0D
+	} else {=0D
+		smp_store_release(&b, 1);=0D
+		do_something_else();=0D
+	}=0D
+=0D
+In contrast, without explicit memory barriers, two-legged-if control=0D
+ordering is guaranteed only when the stores differ, for example:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q) {=0D
+		WRITE_ONCE(b, 1);=0D
+		do_something();=0D
+	} else {=0D
+		WRITE_ONCE(b, 2);=0D
+		do_something_else();=0D
+	}=0D
+=0D
+The initial READ_ONCE() is still required to prevent the compiler from=0D
+proving the value of 'a'.=0D
+=0D
+In addition, you need to be careful what you do with the local variable 'q=
',=0D
+otherwise the compiler might be able to guess the value and again remove=0D
+the needed conditional.  For example:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q % MAX) {=0D
+		WRITE_ONCE(b, 1);=0D
+		do_something();=0D
+	} else {=0D
+		WRITE_ONCE(b, 2);=0D
+		do_something_else();=0D
+	}=0D
+=0D
+If MAX is defined to be 1, then the compiler knows that (q % MAX) is=0D
+equal to zero, in which case the compiler is within its rights to=0D
+transform the above code into the following:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	WRITE_ONCE(b, 2);=0D
+	do_something_else();=0D
+=0D
+Given this transformation, the CPU is not required to respect the ordering=
=0D
+between the load from variable 'a' and the store to variable 'b'.  It is=0D
+tempting to add a barrier(), but this does not help.  The conditional=0D
+is gone, and the barrier won't bring it back.  Therefore, if you are=0D
+relying on this ordering, you should make sure that MAX is greater than=0D
+one, perhaps as follows:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	BUILD_BUG_ON(MAX <=3D 1); /* Order load from a with store to b. */=0D
+	if (q % MAX) {=0D
+		WRITE_ONCE(b, 1);=0D
+		do_something();=0D
+	} else {=0D
+		WRITE_ONCE(b, 2);=0D
+		do_something_else();=0D
+	}=0D
+=0D
+Please note once again that the stores to 'b' differ.  If they were=0D
+identical, as noted earlier, the compiler could pull this store outside=0D
+of the 'if' statement.=0D
+=0D
+You must also be careful not to rely too much on boolean short-circuit=0D
+evaluation.  Consider this example:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q || 1 > 0)=0D
+		WRITE_ONCE(b, 1);=0D
+=0D
+Because the first condition cannot fault and the second condition is=0D
+always true, the compiler can transform this example as following,=0D
+defeating control dependency:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	WRITE_ONCE(b, 1);=0D
+=0D
+This example underscores the need to ensure that the compiler cannot=0D
+out-guess your code.  More generally, although READ_ONCE() does force=0D
+the compiler to actually emit code for a given load, it does not force=0D
+the compiler to use the results.=0D
+=0D
+In addition, control dependencies apply only to the then-clause and=0D
+else-clause of the if-statement in question.  In particular, it does=0D
+not necessarily apply to code following the if-statement:=0D
+=0D
+	q =3D READ_ONCE(a);=0D
+	if (q) {=0D
+		WRITE_ONCE(b, 1);=0D
+	} else {=0D
+		WRITE_ONCE(b, 2);=0D
+	}=0D
+	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from 'a'. */=0D
+=0D
+It is tempting to argue that there in fact is ordering because the=0D
+compiler cannot reorder volatile accesses and also cannot reorder=0D
+the writes to 'b' with the condition.  Unfortunately for this line=0D
+of reasoning, the compiler might compile the two writes to 'b' as=0D
+conditional-move instructions, as in this fanciful pseudo-assembly=0D
+language:=0D
+=0D
+	ld r1,a=0D
+	cmp r1,$0=0D
+	cmov,ne r4,$1=0D
+	cmov,eq r4,$2=0D
+	st r4,b=0D
+	st $1,c=0D
+=0D
+A weakly ordered CPU would have no dependency of any sort between the load=
=0D
+from 'a' and the store to 'c'.  The control dependencies would extend=0D
+only to the pair of cmov instructions and the store depending on them.=0D
+In short, control dependencies apply only to the stores in the then-clause=
=0D
+and else-clause of the if-statement in question (including functions=0D
+invoked by those two clauses), not to code following that if-statement.=0D
+=0D
+=0D
+Note well that the ordering provided by a control dependency is local=0D
+to the CPU containing it.  See the section on "Multicopy atomicity"=0D
+for more information.=0D
+=0D
+=0D
+In summary:=0D
+=0D
+  (*) Control dependencies can order prior loads against later stores.=0D
+      However, they do -not- guarantee any other sort of ordering:=0D
+      Not prior loads against later loads, nor prior stores against=0D
+      later anything.  If you need these other forms of ordering,=0D
+      use smp_rmb(), smp_wmb(), or, in the case of prior stores and=0D
+      later loads, smp_mb().=0D
+=0D
+  (*) If both legs of the "if" statement begin with identical stores to=0D
+      the same variable, then those stores must be ordered, either by=0D
+      preceding both of them with smp_mb() or by using smp_store_release()=
=0D
+      to carry out the stores.  Please note that it is -not- sufficient=0D
+      to use barrier() at beginning of each leg of the "if" statement=0D
+      because, as shown by the example above, optimizing compilers can=0D
+      destroy the control dependency while respecting the letter of the=0D
+      barrier() law.=0D
+=0D
+  (*) Control dependencies require at least one run-time conditional=0D
+      between the prior load and the subsequent store, and this=0D
+      conditional must involve the prior load.  If the compiler is able=0D
+      to optimize the conditional away, it will have also optimized=0D
+      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()=0D
+      can help to preserve the needed conditional.=0D
+=0D
+  (*) Control dependencies require that the compiler avoid reordering the=
=0D
+      dependency into nonexistence.  Careful use of READ_ONCE() or=0D
+      atomic{,64}_read() can help to preserve your control dependency.=0D
+      Please see the COMPILER BARRIER section for more information.=0D
+=0D
+  (*) Control dependencies apply only to the then-clause and else-clause=0D
+      of the if-statement containing the control dependency, including=0D
+      any functions that these two clauses call.  Control dependencies=0D
+      do -not- apply to code following the if-statement containing the=0D
+      control dependency.=0D
+=0D
+  (*) Control dependencies pair normally with other types of barriers.=0D
+=0D
+  (*) Control dependencies do -not- provide multicopy atomicity.  If you=0D
+      need all the CPUs to see a given store at the same time, use smp_mb(=
).=0D
+=0D
+  (*) Compilers do not understand control dependencies.  It is therefore=0D
+      your job to ensure that they do not break your code.=0D
+=0D
+=0D
+SMP BARRIER PAIRING=0D
+-------------------=0D
+=0D
+When dealing with CPU-CPU interactions, certain types of memory barrier sh=
ould=0D
+always be paired.  A lack of appropriate pairing is almost certainly an er=
ror.=0D
+=0D
+General barriers pair with each other, though they also pair with most=0D
+other types of barriers, albeit without multicopy atomicity.  An acquire=0D
+barrier pairs with a release barrier, but both may also pair with other=0D
+barriers, including of course general barriers.  A write barrier pairs=0D
+with an address-dependency barrier, a control dependency, an acquire barri=
er,=0D
+a release barrier, a read barrier, or a general barrier.  Similarly a=0D
+read barrier, control dependency, or an address-dependency barrier pairs=0D
+with a write barrier, an acquire barrier, a release barrier, or a=0D
+general barrier:=0D
+=0D
+	CPU 1		      CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	WRITE_ONCE(a, 1);=0D
+	<write barrier>=0D
+	WRITE_ONCE(b, 2);     x =3D READ_ONCE(b);=0D
+			      <read barrier>=0D
+			      y =3D READ_ONCE(a);=0D
+=0D
+Or:=0D
+=0D
+	CPU 1		      CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	a =3D 1;=0D
+	<write barrier>=0D
+	WRITE_ONCE(b, &a);    x =3D READ_ONCE(b);=0D
+			      <implicit address-dependency barrier>=0D
+			      y =3D *x;=0D
+=0D
+Or even:=0D
+=0D
+	CPU 1		      CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	      =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	r1 =3D READ_ONCE(y);=0D
+	<general barrier>=0D
+	WRITE_ONCE(x, 1);     if (r2 =3D READ_ONCE(x)) {=0D
+			         <implicit control dependency>=0D
+			         WRITE_ONCE(y, 1);=0D
+			      }=0D
+=0D
+	assert(r1 =3D=3D 0 || r2 =3D=3D 0);=0D
+=0D
+Basically, the read barrier always has to be there, even though it can be =
of=0D
+the "weaker" type.=0D
+=0D
+[!] Note that the stores before the write barrier would normally be expect=
ed to=0D
+match the loads after the read barrier or the address-dependency barrier, =
and=0D
+vice versa:=0D
+=0D
+	CPU 1                               CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                =
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	WRITE_ONCE(a, 1);    }----   --->{  v =3D READ_ONCE(c);=0D
+	WRITE_ONCE(b, 2);    }    \ /    {  w =3D READ_ONCE(d);=0D
+	<write barrier>            \        <read barrier>=0D
+	WRITE_ONCE(c, 3);    }    / \    {  x =3D READ_ONCE(a);=0D
+	WRITE_ONCE(d, 4);    }----   --->{  y =3D READ_ONCE(b);=0D
+=0D
+=0D
+EXAMPLES OF MEMORY BARRIER SEQUENCES=0D
+------------------------------------=0D
+=0D
+Firstly, write barriers act as partial orderings on store operations.=0D
+Consider the following sequence of events:=0D
+=0D
+	CPU 1=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	STORE A =3D 1=0D
+	STORE B =3D 2=0D
+	STORE C =3D 3=0D
+	<write barrier>=0D
+	STORE D =3D 4=0D
+	STORE E =3D 5=0D
+=0D
+This sequence of events is committed to the memory coherence system in an =
order=0D
+that the rest of the system might perceive as the unordered set of { STORE=
 A,=0D
+STORE B, STORE C } all occurring before the unordered set of { STORE D, ST=
ORE E=0D
+}:=0D
+=0D
+	+-------+       :      :=0D
+	|       |       +------+=0D
+	|       |------>| C=3D3  |     }     /\=0D
+	|       |  :    +------+     }-----  \  -----> Events perceptible to=0D
+	|       |  :    | A=3D1  |     }        \/       the rest of the system=0D
+	|       |  :    +------+     }=0D
+	| CPU 1 |  :    | B=3D2  |     }=0D
+	|       |       +------+     }=0D
+	|       |   wwwwwwwwwwwwwwww }   <--- At this point the write barrier=0D
+	|       |       +------+     }        requires all stores prior to the=0D
+	|       |  :    | E=3D5  |     }        barrier to be committed before=0D
+	|       |  :    +------+     }        further stores may take place=0D
+	|       |------>| D=3D4  |     }=0D
+	|       |       +------+=0D
+	+-------+       :      :=0D
+	                   |=0D
+	                   | Sequence in which stores are committed to the=0D
+	                   | memory system by CPU 1=0D
+	                   V=0D
+=0D
+=0D
+Secondly, address-dependency barriers act as partial orderings on address-=
=0D
+dependent loads.  Consider the following sequence of events:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ B =3D 7; X =3D 9; Y =3D 8; C =3D &Y }=0D
+	STORE A =3D 1=0D
+	STORE B =3D 2=0D
+	<write barrier>=0D
+	STORE C =3D &B		LOAD X=0D
+	STORE D =3D 4		LOAD C (gets &B)=0D
+				LOAD *C (reads B)=0D
+=0D
+Without intervention, CPU 2 may perceive the events on CPU 1 in some=0D
+effectively random order, despite the write barrier issued by CPU 1:=0D
+=0D
+	+-------+       :      :                :       :=0D
+	|       |       +------+                +-------+  | Sequence of update=0D
+	|       |------>| B=3D2  |-----       --->| Y->8  |  | of perception on=0D
+	|       |  :    +------+     \          +-------+  | CPU 2=0D
+	| CPU 1 |  :    | A=3D1  |      \     --->| C->&Y |  V=0D
+	|       |       +------+       |        +-------+=0D
+	|       |   wwwwwwwwwwwwwwww   |        :       :=0D
+	|       |       +------+       |        :       :=0D
+	|       |  :    | C=3D&B |---    |        :       :       +-------+=0D
+	|       |  :    +------+   \   |        +-------+       |       |=0D
+	|       |------>| D=3D4  |    ----------->| C->&B |------>|       |=0D
+	|       |       +------+       |        +-------+       |       |=0D
+	+-------+       :      :       |        :       :       |       |=0D
+	                               |        :       :       |       |=0D
+	                               |        :       :       | CPU 2 |=0D
+	                               |        +-------+       |       |=0D
+	    Apparently incorrect --->  |        | B->7  |------>|       |=0D
+	    perception of B (!)        |        +-------+       |       |=0D
+	                               |        :       :       |       |=0D
+	                               |        +-------+       |       |=0D
+	    The load of X holds --->    \       | X->9  |------>|       |=0D
+	    up the maintenance           \      +-------+       |       |=0D
+	    of coherence of B             ----->| B->2  |       +-------+=0D
+	                                        +-------+=0D
+	                                        :       :=0D
+=0D
+=0D
+In the above example, CPU 2 perceives that B is 7, despite the load of *C=
=0D
+(which would be B) coming after the LOAD of C.=0D
+=0D
+If, however, an address-dependency barrier were to be placed between the l=
oad=0D
+of C and the load of *C (ie: B) on CPU 2:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ B =3D 7; X =3D 9; Y =3D 8; C =3D &Y }=0D
+	STORE A =3D 1=0D
+	STORE B =3D 2=0D
+	<write barrier>=0D
+	STORE C =3D &B		LOAD X=0D
+	STORE D =3D 4		LOAD C (gets &B)=0D
+				<address-dependency barrier>=0D
+				LOAD *C (reads B)=0D
+=0D
+then the following will occur:=0D
+=0D
+	+-------+       :      :                :       :=0D
+	|       |       +------+                +-------+=0D
+	|       |------>| B=3D2  |-----       --->| Y->8  |=0D
+	|       |  :    +------+     \          +-------+=0D
+	| CPU 1 |  :    | A=3D1  |      \     --->| C->&Y |=0D
+	|       |       +------+       |        +-------+=0D
+	|       |   wwwwwwwwwwwwwwww   |        :       :=0D
+	|       |       +------+       |        :       :=0D
+	|       |  :    | C=3D&B |---    |        :       :       +-------+=0D
+	|       |  :    +------+   \   |        +-------+       |       |=0D
+	|       |------>| D=3D4  |    ----------->| C->&B |------>|       |=0D
+	|       |       +------+       |        +-------+       |       |=0D
+	+-------+       :      :       |        :       :       |       |=0D
+	                               |        :       :       |       |=0D
+	                               |        :       :       | CPU 2 |=0D
+	                               |        +-------+       |       |=0D
+	                               |        | X->9  |------>|       |=0D
+	                               |        +-------+       |       |=0D
+	  Makes sure all effects --->   \   aaaaaaaaaaaaaaaaa   |       |=0D
+	  prior to the store of C        \      +-------+       |       |=0D
+	  are perceptible to              ----->| B->2  |------>|       |=0D
+	  subsequent loads                      +-------+       |       |=0D
+	                                        :       :       +-------+=0D
+=0D
+=0D
+And thirdly, a read barrier acts as a partial order on loads.  Consider th=
e=0D
+following sequence of events:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ A =3D 0, B =3D 9 }=0D
+	STORE A=3D1=0D
+	<write barrier>=0D
+	STORE B=3D2=0D
+				LOAD B=0D
+				LOAD A=0D
+=0D
+Without intervention, CPU 2 may then choose to perceive the events on CPU =
1 in=0D
+some effectively random order, despite the write barrier issued by CPU 1:=
=0D
+=0D
+	+-------+       :      :                :       :=0D
+	|       |       +------+                +-------+=0D
+	|       |------>| A=3D1  |------      --->| A->0  |=0D
+	|       |       +------+      \         +-------+=0D
+	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |=0D
+	|       |       +------+        |       +-------+=0D
+	|       |------>| B=3D2  |---     |       :       :=0D
+	|       |       +------+   \    |       :       :       +-------+=0D
+	+-------+       :      :    \   |       +-------+       |       |=0D
+	                             ---------->| B->2  |------>|       |=0D
+	                                |       +-------+       | CPU 2 |=0D
+	                                |       | A->0  |------>|       |=0D
+	                                |       +-------+       |       |=0D
+	                                |       :       :       +-------+=0D
+	                                 \      :       :=0D
+	                                  \     +-------+=0D
+	                                   ---->| A->1  |=0D
+	                                        +-------+=0D
+	                                        :       :=0D
+=0D
+=0D
+If, however, a read barrier were to be placed between the load of B and th=
e=0D
+load of A on CPU 2:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ A =3D 0, B =3D 9 }=0D
+	STORE A=3D1=0D
+	<write barrier>=0D
+	STORE B=3D2=0D
+				LOAD B=0D
+				<read barrier>=0D
+				LOAD A=0D
+=0D
+then the partial ordering imposed by CPU 1 will be perceived correctly by =
CPU=0D
+2:=0D
+=0D
+	+-------+       :      :                :       :=0D
+	|       |       +------+                +-------+=0D
+	|       |------>| A=3D1  |------      --->| A->0  |=0D
+	|       |       +------+      \         +-------+=0D
+	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |=0D
+	|       |       +------+        |       +-------+=0D
+	|       |------>| B=3D2  |---     |       :       :=0D
+	|       |       +------+   \    |       :       :       +-------+=0D
+	+-------+       :      :    \   |       +-------+       |       |=0D
+	                             ---------->| B->2  |------>|       |=0D
+	                                |       +-------+       | CPU 2 |=0D
+	                                |       :       :       |       |=0D
+	                                |       :       :       |       |=0D
+	  At this point the read ---->   \  rrrrrrrrrrrrrrrrr   |       |=0D
+	  barrier causes all effects      \     +-------+       |       |=0D
+	  prior to the storage of B        ---->| A->1  |------>|       |=0D
+	  to be perceptible to CPU 2            +-------+       |       |=0D
+	                                        :       :       +-------+=0D
+=0D
+=0D
+To illustrate this more completely, consider what could happen if the code=
=0D
+contained a load of A either side of the read barrier:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ A =3D 0, B =3D 9 }=0D
+	STORE A=3D1=0D
+	<write barrier>=0D
+	STORE B=3D2=0D
+				LOAD B=0D
+				LOAD A [first load of A]=0D
+				<read barrier>=0D
+				LOAD A [second load of A]=0D
+=0D
+Even though the two loads of A both occur after the load of B, they may bo=
th=0D
+come up with different values:=0D
+=0D
+	+-------+       :      :                :       :=0D
+	|       |       +------+                +-------+=0D
+	|       |------>| A=3D1  |------      --->| A->0  |=0D
+	|       |       +------+      \         +-------+=0D
+	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |=0D
+	|       |       +------+        |       +-------+=0D
+	|       |------>| B=3D2  |---     |       :       :=0D
+	|       |       +------+   \    |       :       :       +-------+=0D
+	+-------+       :      :    \   |       +-------+       |       |=0D
+	                             ---------->| B->2  |------>|       |=0D
+	                                |       +-------+       | CPU 2 |=0D
+	                                |       :       :       |       |=0D
+	                                |       :       :       |       |=0D
+	                                |       +-------+       |       |=0D
+	                                |       | A->0  |------>| 1st   |=0D
+	                                |       +-------+       |       |=0D
+	  At this point the read ---->   \  rrrrrrrrrrrrrrrrr   |       |=0D
+	  barrier causes all effects      \     +-------+       |       |=0D
+	  prior to the storage of B        ---->| A->1  |------>| 2nd   |=0D
+	  to be perceptible to CPU 2            +-------+       |       |=0D
+	                                        :       :       +-------+=0D
+=0D
+=0D
+But it may be that the update to A from CPU 1 becomes perceptible to CPU 2=
=0D
+before the read barrier completes anyway:=0D
+=0D
+	+-------+       :      :                :       :=0D
+	|       |       +------+                +-------+=0D
+	|       |------>| A=3D1  |------      --->| A->0  |=0D
+	|       |       +------+      \         +-------+=0D
+	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |=0D
+	|       |       +------+        |       +-------+=0D
+	|       |------>| B=3D2  |---     |       :       :=0D
+	|       |       +------+   \    |       :       :       +-------+=0D
+	+-------+       :      :    \   |       +-------+       |       |=0D
+	                             ---------->| B->2  |------>|       |=0D
+	                                |       +-------+       | CPU 2 |=0D
+	                                |       :       :       |       |=0D
+	                                 \      :       :       |       |=0D
+	                                  \     +-------+       |       |=0D
+	                                   ---->| A->1  |------>| 1st   |=0D
+	                                        +-------+       |       |=0D
+	                                    rrrrrrrrrrrrrrrrr   |       |=0D
+	                                        +-------+       |       |=0D
+	                                        | A->1  |------>| 2nd   |=0D
+	                                        +-------+       |       |=0D
+	                                        :       :       +-------+=0D
+=0D
+=0D
+The guarantee is that the second load will always come up with A =3D=3D 1 =
if the=0D
+load of B came up with B =3D=3D 2.  No such guarantee exists for the first=
 load of=0D
+A; that may come up with either A =3D=3D 0 or A =3D=3D 1.=0D
+=0D
+=0D
+READ MEMORY BARRIERS VS LOAD SPECULATION=0D
+----------------------------------------=0D
+=0D
+Many CPUs speculate with loads: that is they see that they will need to lo=
ad an=0D
+item from memory, and they find a time where they're not using the bus for=
 any=0D
+other loads, and so do the load in advance - even though they haven't actu=
ally=0D
+got to that point in the instruction execution flow yet.  This permits the=
=0D
+actual load instruction to potentially complete immediately because the CP=
U=0D
+already has the value to hand.=0D
+=0D
+It may turn out that the CPU didn't actually need the value - perhaps beca=
use a=0D
+branch circumvented the load - in which case it can discard the value or j=
ust=0D
+cache it for later use.=0D
+=0D
+Consider:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+				LOAD B=0D
+				DIVIDE		} Divide instructions generally=0D
+				DIVIDE		} take a long time to perform=0D
+				LOAD A=0D
+=0D
+Which might appear as this:=0D
+=0D
+	                                        :       :       +-------+=0D
+	                                        +-------+       |       |=0D
+	                                    --->| B->2  |------>|       |=0D
+	                                        +-------+       | CPU 2 |=0D
+	                                        :       :DIVIDE |       |=0D
+	                                        +-------+       |       |=0D
+	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |=0D
+	division speculates on the              +-------+   ~   |       |=0D
+	LOAD of A                               :       :   ~   |       |=0D
+	                                        :       :DIVIDE |       |=0D
+	                                        :       :   ~   |       |=0D
+	Once the divisions are complete -->     :       :   ~-->|       |=0D
+	the CPU can then perform the            :       :       |       |=0D
+	LOAD with immediate effect              :       :       +-------+=0D
+=0D
+=0D
+Placing a read barrier or an address-dependency barrier just before the se=
cond=0D
+load:=0D
+=0D
+	CPU 1			CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+				LOAD B=0D
+				DIVIDE=0D
+				DIVIDE=0D
+				<read barrier>=0D
+				LOAD A=0D
+=0D
+will force any value speculatively obtained to be reconsidered to an exten=
t=0D
+dependent on the type of barrier used.  If there was no change made to the=
=0D
+speculated memory location, then the speculated value will just be used:=0D
+=0D
+	                                        :       :       +-------+=0D
+	                                        +-------+       |       |=0D
+	                                    --->| B->2  |------>|       |=0D
+	                                        +-------+       | CPU 2 |=0D
+	                                        :       :DIVIDE |       |=0D
+	                                        +-------+       |       |=0D
+	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |=0D
+	division speculates on the              +-------+   ~   |       |=0D
+	LOAD of A                               :       :   ~   |       |=0D
+	                                        :       :DIVIDE |       |=0D
+	                                        :       :   ~   |       |=0D
+	                                        :       :   ~   |       |=0D
+	                                    rrrrrrrrrrrrrrrr~   |       |=0D
+	                                        :       :   ~   |       |=0D
+	                                        :       :   ~-->|       |=0D
+	                                        :       :       |       |=0D
+	                                        :       :       +-------+=0D
+=0D
+=0D
+but if there was an update or an invalidation from another CPU pending, th=
en=0D
+the speculation will be cancelled and the value reloaded:=0D
+=0D
+	                                        :       :       +-------+=0D
+	                                        +-------+       |       |=0D
+	                                    --->| B->2  |------>|       |=0D
+	                                        +-------+       | CPU 2 |=0D
+	                                        :       :DIVIDE |       |=0D
+	                                        +-------+       |       |=0D
+	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |=0D
+	division speculates on the              +-------+   ~   |       |=0D
+	LOAD of A                               :       :   ~   |       |=0D
+	                                        :       :DIVIDE |       |=0D
+	                                        :       :   ~   |       |=0D
+	                                        :       :   ~   |       |=0D
+	                                    rrrrrrrrrrrrrrrrr   |       |=0D
+	                                        +-------+       |       |=0D
+	The speculation is discarded --->   --->| A->1  |------>|       |=0D
+	and an updated value is                 +-------+       |       |=0D
+	retrieved                               :       :       +-------+=0D
+=0D
+=0D
+MULTICOPY ATOMICITY=0D
+--------------------=0D
+=0D
+Multicopy atomicity is a deeply intuitive notion about ordering that is=0D
+not always provided by real computer systems, namely that a given store=0D
+becomes visible at the same time to all CPUs, or, alternatively, that all=
=0D
+CPUs agree on the order in which all stores become visible.  However,=0D
+support of full multicopy atomicity would rule out valuable hardware=0D
+optimizations, so a weaker form called ``other multicopy atomicity''=0D
+instead guarantees only that a given store becomes visible at the same=0D
+time to all -other- CPUs.  The remainder of this document discusses this=0D
+weaker form, but for brevity will call it simply ``multicopy atomicity''.=
=0D
+=0D
+The following example demonstrates multicopy atomicity:=0D
+=0D
+	CPU 1			CPU 2			CPU 3=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ X =3D 0, Y =3D 0 }=0D
+	STORE X=3D1		r1=3DLOAD X (reads 1)	LOAD Y (reads 1)=0D
+				<general barrier>	<read barrier>=0D
+				STORE Y=3Dr1		LOAD X=0D
+=0D
+Suppose that CPU 2's load from X returns 1, which it then stores to Y,=0D
+and CPU 3's load from Y returns 1.  This indicates that CPU 1's store=0D
+to X precedes CPU 2's load from X and that CPU 2's store to Y precedes=0D
+CPU 3's load from Y.  In addition, the memory barriers guarantee that=0D
+CPU 2 executes its load before its store, and CPU 3 loads from Y before=0D
+it loads from X.  The question is then "Can CPU 3's load from X return 0?"=
=0D
+=0D
+Because CPU 3's load from X in some sense comes after CPU 2's load, it=0D
+is natural to expect that CPU 3's load from X must therefore return 1.=0D
+This expectation follows from multicopy atomicity: if a load executing=0D
+on CPU B follows a load from the same variable executing on CPU A (and=0D
+CPU A did not originally store the value which it read), then on=0D
+multicopy-atomic systems, CPU B's load must return either the same value=0D
+that CPU A's load did or some later value.  However, the Linux kernel=0D
+does not require systems to be multicopy atomic.=0D
+=0D
+The use of a general memory barrier in the example above compensates=0D
+for any lack of multicopy atomicity.  In the example, if CPU 2's load=0D
+from X returns 1 and CPU 3's load from Y returns 1, then CPU 3's load=0D
+from X must indeed also return 1.=0D
+=0D
+However, dependencies, read barriers, and write barriers are not always=0D
+able to compensate for non-multicopy atomicity.  For example, suppose=0D
+that CPU 2's general barrier is removed from the above example, leaving=0D
+only the data dependency shown below:=0D
+=0D
+	CPU 1			CPU 2			CPU 3=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+		{ X =3D 0, Y =3D 0 }=0D
+	STORE X=3D1		r1=3DLOAD X (reads 1)	LOAD Y (reads 1)=0D
+				<data dependency>	<read barrier>=0D
+				STORE Y=3Dr1		LOAD X (reads 0)=0D
+=0D
+This substitution allows non-multicopy atomicity to run rampant: in=0D
+this example, it is perfectly legal for CPU 2's load from X to return 1,=0D
+CPU 3's load from Y to return 1, and its load from X to return 0.=0D
+=0D
+The key point is that although CPU 2's data dependency orders its load=0D
+and store, it does not guarantee to order CPU 1's store.  Thus, if this=0D
+example runs on a non-multicopy-atomic system where CPUs 1 and 2 share a=0D
+store buffer or a level of cache, CPU 2 might have early access to CPU 1's=
=0D
+writes.  General barriers are therefore required to ensure that all CPUs=0D
+agree on the combined order of multiple accesses.=0D
+=0D
+General barriers can compensate not only for non-multicopy atomicity,=0D
+but can also generate additional ordering that can ensure that -all-=0D
+CPUs will perceive the same order of -all- operations.  In contrast, a=0D
+chain of release-acquire pairs do not provide this additional ordering,=0D
+which means that only those CPUs on the chain are guaranteed to agree=0D
+on the combined order of the accesses.  For example, switching to C code=0D
+in deference to the ghost of Herman Hollerith:=0D
+=0D
+	int u, v, x, y, z;=0D
+=0D
+	void cpu0(void)=0D
+	{=0D
+		r0 =3D smp_load_acquire(&x);=0D
+		WRITE_ONCE(u, 1);=0D
+		smp_store_release(&y, 1);=0D
+	}=0D
+=0D
+	void cpu1(void)=0D
+	{=0D
+		r1 =3D smp_load_acquire(&y);=0D
+		r4 =3D READ_ONCE(v);=0D
+		r5 =3D READ_ONCE(u);=0D
+		smp_store_release(&z, 1);=0D
+	}=0D
+=0D
+	void cpu2(void)=0D
+	{=0D
+		r2 =3D smp_load_acquire(&z);=0D
+		smp_store_release(&x, 1);=0D
+	}=0D
+=0D
+	void cpu3(void)=0D
+	{=0D
+		WRITE_ONCE(v, 1);=0D
+		smp_mb();=0D
+		r3 =3D READ_ONCE(u);=0D
+	}=0D
+=0D
+Because cpu0(), cpu1(), and cpu2() participate in a chain of=0D
+smp_store_release()/smp_load_acquire() pairs, the following outcome=0D
+is prohibited:=0D
+=0D
+	r0 =3D=3D 1 && r1 =3D=3D 1 && r2 =3D=3D 1=0D
+=0D
+Furthermore, because of the release-acquire relationship between cpu0()=0D
+and cpu1(), cpu1() must see cpu0()'s writes, so that the following=0D
+outcome is prohibited:=0D
+=0D
+	r1 =3D=3D 1 && r5 =3D=3D 0=0D
+=0D
+However, the ordering provided by a release-acquire chain is local=0D
+to the CPUs participating in that chain and does not apply to cpu3(),=0D
+at least aside from stores.  Therefore, the following outcome is possible:=
=0D
+=0D
+	r0 =3D=3D 0 && r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 && r4 =3D=3D 0=0D
+=0D
+As an aside, the following outcome is also possible:=0D
+=0D
+	r0 =3D=3D 0 && r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 && r4 =3D=3D 0 &=
& r5 =3D=3D 1=0D
+=0D
+Although cpu0(), cpu1(), and cpu2() will see their respective reads and=0D
+writes in order, CPUs not involved in the release-acquire chain might=0D
+well disagree on the order.  This disagreement stems from the fact that=0D
+the weak memory-barrier instructions used to implement smp_load_acquire()=
=0D
+and smp_store_release() are not required to order prior stores against=0D
+subsequent loads in all cases.  This means that cpu3() can see cpu0()'s=0D
+store to u as happening -after- cpu1()'s load from v, even though=0D
+both cpu0() and cpu1() agree that these two operations occurred in the=0D
+intended order.=0D
+=0D
+However, please keep in mind that smp_load_acquire() is not magic.=0D
+In particular, it simply reads from its argument with ordering.  It does=0D
+-not- ensure that any particular value will be read.  Therefore, the=0D
+following outcome is possible:=0D
+=0D
+	r0 =3D=3D 0 && r1 =3D=3D 0 && r2 =3D=3D 0 && r5 =3D=3D 0=0D
+=0D
+Note that this outcome can happen even on a mythical sequentially=0D
+consistent system where nothing is ever reordered.=0D
+=0D
+To reiterate, if your code requires full ordering of all operations,=0D
+use general barriers throughout.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+EXPLICIT KERNEL BARRIERS=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+The Linux kernel has a variety of different barriers that act at different=
=0D
+levels:=0D
+=0D
+  (*) Compiler barrier.=0D
+=0D
+  (*) CPU memory barriers.=0D
+=0D
+=0D
+COMPILER BARRIER=0D
+----------------=0D
+=0D
+The Linux kernel has an explicit compiler barrier function that prevents t=
he=0D
+compiler from moving the memory accesses either side of it to the other si=
de:=0D
+=0D
+	barrier();=0D
+=0D
+This is a general barrier -- there are no read-read or write-write=0D
+variants of barrier().  However, READ_ONCE() and WRITE_ONCE() can be=0D
+thought of as weak forms of barrier() that affect only the specific=0D
+accesses flagged by the READ_ONCE() or WRITE_ONCE().=0D
+=0D
+The barrier() function has the following effects:=0D
+=0D
+ (*) Prevents the compiler from reordering accesses following the=0D
+     barrier() to precede any accesses preceding the barrier().=0D
+     One example use for this property is to ease communication between=0D
+     interrupt-handler code and the code that was interrupted.=0D
+=0D
+ (*) Within a loop, forces the compiler to load the variables used=0D
+     in that loop's conditional on each pass through that loop.=0D
+=0D
+The READ_ONCE() and WRITE_ONCE() functions can prevent any number of=0D
+optimizations that, while perfectly safe in single-threaded code, can=0D
+be fatal in concurrent code.  Here are some examples of these sorts=0D
+of optimizations:=0D
+=0D
+ (*) The compiler is within its rights to reorder loads and stores=0D
+     to the same variable, and in some cases, the CPU is within its=0D
+     rights to reorder loads to the same variable.  This means that=0D
+     the following code:=0D
+=0D
+	a[0] =3D x;=0D
+	a[1] =3D x;=0D
+=0D
+     Might result in an older value of x stored in a[1] than in a[0].=0D
+     Prevent both the compiler and the CPU from doing this as follows:=0D
+=0D
+	a[0] =3D READ_ONCE(x);=0D
+	a[1] =3D READ_ONCE(x);=0D
+=0D
+     In short, READ_ONCE() and WRITE_ONCE() provide cache coherence for=0D
+     accesses from multiple CPUs to a single variable.=0D
+=0D
+ (*) The compiler is within its rights to merge successive loads from=0D
+     the same variable.  Such merging can cause the compiler to "optimize"=
=0D
+     the following code:=0D
+=0D
+	while (tmp =3D a)=0D
+		do_something_with(tmp);=0D
+=0D
+     into the following code, which, although in some sense legitimate=0D
+     for single-threaded code, is almost certainly not what the developer=
=0D
+     intended:=0D
+=0D
+	if (tmp =3D a)=0D
+		for (;;)=0D
+			do_something_with(tmp);=0D
+=0D
+     Use READ_ONCE() to prevent the compiler from doing this to you:=0D
+=0D
+	while (tmp =3D READ_ONCE(a))=0D
+		do_something_with(tmp);=0D
+=0D
+ (*) The compiler is within its rights to reload a variable, for example,=
=0D
+     in cases where high register pressure prevents the compiler from=0D
+     keeping all data of interest in registers.  The compiler might=0D
+     therefore optimize the variable 'tmp' out of our previous example:=0D
+=0D
+	while (tmp =3D a)=0D
+		do_something_with(tmp);=0D
+=0D
+     This could result in the following code, which is perfectly safe in=0D
+     single-threaded code, but can be fatal in concurrent code:=0D
+=0D
+	while (a)=0D
+		do_something_with(a);=0D
+=0D
+     For example, the optimized version of this code could result in=0D
+     passing a zero to do_something_with() in the case where the variable=
=0D
+     a was modified by some other CPU between the "while" statement and=0D
+     the call to do_something_with().=0D
+=0D
+     Again, use READ_ONCE() to prevent the compiler from doing this:=0D
+=0D
+	while (tmp =3D READ_ONCE(a))=0D
+		do_something_with(tmp);=0D
+=0D
+     Note that if the compiler runs short of registers, it might save=0D
+     tmp onto the stack.  The overhead of this saving and later restoring=
=0D
+     is why compilers reload variables.  Doing so is perfectly safe for=0D
+     single-threaded code, so you need to tell the compiler about cases=0D
+     where it is not safe.=0D
+=0D
+ (*) The compiler is within its rights to omit a load entirely if it knows=
=0D
+     what the value will be.  For example, if the compiler can prove that=
=0D
+     the value of variable 'a' is always zero, it can optimize this code:=
=0D
+=0D
+	while (tmp =3D a)=0D
+		do_something_with(tmp);=0D
+=0D
+     Into this:=0D
+=0D
+	do { } while (0);=0D
+=0D
+     This transformation is a win for single-threaded code because it=0D
+     gets rid of a load and a branch.  The problem is that the compiler=0D
+     will carry out its proof assuming that the current CPU is the only=0D
+     one updating variable 'a'.  If variable 'a' is shared, then the=0D
+     compiler's proof will be erroneous.  Use READ_ONCE() to tell the=0D
+     compiler that it doesn't know as much as it thinks it does:=0D
+=0D
+	while (tmp =3D READ_ONCE(a))=0D
+		do_something_with(tmp);=0D
+=0D
+     But please note that the compiler is also closely watching what you=0D
+     do with the value after the READ_ONCE().  For example, suppose you=0D
+     do the following and MAX is a preprocessor macro with the value 1:=0D
+=0D
+	while ((tmp =3D READ_ONCE(a)) % MAX)=0D
+		do_something_with(tmp);=0D
+=0D
+     Then the compiler knows that the result of the "%" operator applied=0D
+     to MAX will always be zero, again allowing the compiler to optimize=0D
+     the code into near-nonexistence.  (It will still load from the=0D
+     variable 'a'.)=0D
+=0D
+ (*) Similarly, the compiler is within its rights to omit a store entirely=
=0D
+     if it knows that the variable already has the value being stored.=0D
+     Again, the compiler assumes that the current CPU is the only one=0D
+     storing into the variable, which can cause the compiler to do the=0D
+     wrong thing for shared variables.  For example, suppose you have=0D
+     the following:=0D
+=0D
+	a =3D 0;=0D
+	... Code that does not store to variable a ...=0D
+	a =3D 0;=0D
+=0D
+     The compiler sees that the value of variable 'a' is already zero, so=
=0D
+     it might well omit the second store.  This would come as a fatal=0D
+     surprise if some other CPU might have stored to variable 'a' in the=0D
+     meantime.=0D
+=0D
+     Use WRITE_ONCE() to prevent the compiler from making this sort of=0D
+     wrong guess:=0D
+=0D
+	WRITE_ONCE(a, 0);=0D
+	... Code that does not store to variable a ...=0D
+	WRITE_ONCE(a, 0);=0D
+=0D
+ (*) The compiler is within its rights to reorder memory accesses unless=0D
+     you tell it not to.  For example, consider the following interaction=
=0D
+     between process-level code and an interrupt handler:=0D
+=0D
+	void process_level(void)=0D
+	{=0D
+		msg =3D get_message();=0D
+		flag =3D true;=0D
+	}=0D
+=0D
+	void interrupt_handler(void)=0D
+	{=0D
+		if (flag)=0D
+			process_message(msg);=0D
+	}=0D
+=0D
+     There is nothing to prevent the compiler from transforming=0D
+     process_level() to the following, in fact, this might well be a=0D
+     win for single-threaded code:=0D
+=0D
+	void process_level(void)=0D
+	{=0D
+		flag =3D true;=0D
+		msg =3D get_message();=0D
+	}=0D
+=0D
+     If the interrupt occurs between these two statement, then=0D
+     interrupt_handler() might be passed a garbled msg.  Use WRITE_ONCE()=
=0D
+     to prevent this as follows:=0D
+=0D
+	void process_level(void)=0D
+	{=0D
+		WRITE_ONCE(msg, get_message());=0D
+		WRITE_ONCE(flag, true);=0D
+	}=0D
+=0D
+	void interrupt_handler(void)=0D
+	{=0D
+		if (READ_ONCE(flag))=0D
+			process_message(READ_ONCE(msg));=0D
+	}=0D
+=0D
+     Note that the READ_ONCE() and WRITE_ONCE() wrappers in=0D
+     interrupt_handler() are needed if this interrupt handler can itself=0D
+     be interrupted by something that also accesses 'flag' and 'msg',=0D
+     for example, a nested interrupt or an NMI.  Otherwise, READ_ONCE()=0D
+     and WRITE_ONCE() are not needed in interrupt_handler() other than=0D
+     for documentation purposes.  (Note also that nested interrupts=0D
+     do not typically occur in modern Linux kernels, in fact, if an=0D
+     interrupt handler returns with interrupts enabled, you will get a=0D
+     WARN_ONCE() splat.)=0D
+=0D
+     You should assume that the compiler can move READ_ONCE() and=0D
+     WRITE_ONCE() past code not containing READ_ONCE(), WRITE_ONCE(),=0D
+     barrier(), or similar primitives.=0D
+=0D
+     This effect could also be achieved using barrier(), but READ_ONCE()=0D
+     and WRITE_ONCE() are more selective:  With READ_ONCE() and=0D
+     WRITE_ONCE(), the compiler need only forget the contents of the=0D
+     indicated memory locations, while with barrier() the compiler must=0D
+     discard the value of all memory locations that it has currently=0D
+     cached in any machine registers.  Of course, the compiler must also=0D
+     respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,=
=0D
+     though the CPU of course need not do so.=0D
+=0D
+ (*) The compiler is within its rights to invent stores to a variable,=0D
+     as in the following example:=0D
+=0D
+	if (a)=0D
+		b =3D a;=0D
+	else=0D
+		b =3D 42;=0D
+=0D
+     The compiler might save a branch by optimizing this as follows:=0D
+=0D
+	b =3D 42;=0D
+	if (a)=0D
+		b =3D a;=0D
+=0D
+     In single-threaded code, this is not only safe, but also saves=0D
+     a branch.  Unfortunately, in concurrent code, this optimization=0D
+     could cause some other CPU to see a spurious value of 42 -- even=0D
+     if variable 'a' was never zero -- when loading variable 'b'.=0D
+     Use WRITE_ONCE() to prevent this as follows:=0D
+=0D
+	if (a)=0D
+		WRITE_ONCE(b, a);=0D
+	else=0D
+		WRITE_ONCE(b, 42);=0D
+=0D
+     The compiler can also invent loads.  These are usually less=0D
+     damaging, but they can result in cache-line bouncing and thus in=0D
+     poor performance and scalability.  Use READ_ONCE() to prevent=0D
+     invented loads.=0D
+=0D
+ (*) For aligned memory locations whose size allows them to be accessed=0D
+     with a single memory-reference instruction, prevents "load tearing"=0D
+     and "store tearing," in which a single large access is replaced by=0D
+     multiple smaller accesses.  For example, given an architecture having=
=0D
+     16-bit store instructions with 7-bit immediate fields, the compiler=0D
+     might be tempted to use two 16-bit store-immediate instructions to=0D
+     implement the following 32-bit store:=0D
+=0D
+	p =3D 0x00010002;=0D
+=0D
+     Please note that GCC really does use this sort of optimization,=0D
+     which is not surprising given that it would likely take more=0D
+     than two instructions to build the constant and then store it.=0D
+     This optimization can therefore be a win in single-threaded code.=0D
+     In fact, a recent bug (since fixed) caused GCC to incorrectly use=0D
+     this optimization in a volatile store.  In the absence of such bugs,=
=0D
+     use of WRITE_ONCE() prevents store tearing in the following example:=
=0D
+=0D
+	WRITE_ONCE(p, 0x00010002);=0D
+=0D
+     Use of packed structures can also result in load and store tearing,=0D
+     as in this example:=0D
+=0D
+	struct __attribute__((__packed__)) foo {=0D
+		short a;=0D
+		int b;=0D
+		short c;=0D
+	};=0D
+	struct foo foo1, foo2;=0D
+	...=0D
+=0D
+	foo2.a =3D foo1.a;=0D
+	foo2.b =3D foo1.b;=0D
+	foo2.c =3D foo1.c;=0D
+=0D
+     Because there are no READ_ONCE() or WRITE_ONCE() wrappers and no=0D
+     volatile markings, the compiler would be well within its rights to=0D
+     implement these three assignment statements as a pair of 32-bit=0D
+     loads followed by a pair of 32-bit stores.  This would result in=0D
+     load tearing on 'foo1.b' and store tearing on 'foo2.b'.  READ_ONCE()=
=0D
+     and WRITE_ONCE() again prevent tearing in this example:=0D
+=0D
+	foo2.a =3D foo1.a;=0D
+	WRITE_ONCE(foo2.b, READ_ONCE(foo1.b));=0D
+	foo2.c =3D foo1.c;=0D
+=0D
+All that aside, it is never necessary to use READ_ONCE() and=0D
+WRITE_ONCE() on a variable that has been marked volatile.  For example,=0D
+because 'jiffies' is marked volatile, it is never necessary to=0D
+say READ_ONCE(jiffies).  The reason for this is that READ_ONCE() and=0D
+WRITE_ONCE() are implemented as volatile casts, which has no effect when=0D
+its argument is already marked volatile.=0D
+=0D
+Please note that these compiler barriers have no direct effect on the CPU,=
=0D
+which may then reorder things however it wishes.=0D
+=0D
+=0D
+CPU MEMORY BARRIERS=0D
+-------------------=0D
+=0D
+The Linux kernel has seven basic CPU memory barriers:=0D
+=0D
+	TYPE			MANDATORY	SMP CONDITIONAL=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0D
+	GENERAL			mb()		smp_mb()=0D
+	WRITE			wmb()		smp_wmb()=0D
+	READ			rmb()		smp_rmb()=0D
+	ADDRESS DEPENDENCY			READ_ONCE()=0D
+=0D
+=0D
+All memory barriers except the address-dependency barriers imply a compile=
r=0D
+barrier.  Address dependencies do not impose any additional compiler order=
ing.=0D
+=0D
+Aside: In the case of address dependencies, the compiler would be expected=
=0D
+to issue the loads in the correct order (eg. `a[b]` would have to load=0D
+the value of b before loading a[b]), however there is no guarantee in=0D
+the C specification that the compiler may not speculate the value of b=0D
+(eg. is equal to 1) and load a[b] before b (eg. tmp =3D a[1]; if (b !=3D 1=
)=0D
+tmp =3D a[b]; ).  There is also the problem of a compiler reloading b afte=
r=0D
+having loaded a[b], thus having a newer copy of b than a[b].  A consensus=
=0D
+has not yet been reached about these problems, however the READ_ONCE()=0D
+macro is a good place to start looking.=0D
+=0D
+SMP memory barriers are reduced to compiler barriers on uniprocessor compi=
led=0D
+systems because it is assumed that a CPU will appear to be self-consistent=
,=0D
+and will order overlapping accesses correctly with respect to itself.=0D
+However, see the subsection on "Virtual Machine Guests" below.=0D
+=0D
+[!] Note that SMP memory barriers _must_ be used to control the ordering o=
f=0D
+references to shared memory on SMP systems, though the use of locking inst=
ead=0D
+is sufficient.=0D
+=0D
+Mandatory barriers should not be used to control SMP effects, since mandat=
ory=0D
+barriers impose unnecessary overhead on both SMP and UP systems. They may,=
=0D
+however, be used to control MMIO effects on accesses through relaxed memor=
y I/O=0D
+windows.  These barriers are required even on non-SMP systems as they affe=
ct=0D
+the order in which memory operations appear to a device by prohibiting bot=
h the=0D
+compiler and the CPU from reordering them.=0D
+=0D
+=0D
+There are some more advanced barrier functions:=0D
+=0D
+ (*) smp_store_mb(var, value)=0D
+=0D
+     This assigns the value to the variable and then inserts a full memory=
=0D
+     barrier after it.  It isn't guaranteed to insert anything more than a=
=0D
+     compiler barrier in a UP compilation.=0D
+=0D
+=0D
+ (*) smp_mb__before_atomic();=0D
+ (*) smp_mb__after_atomic();=0D
+=0D
+     These are for use with atomic RMW functions that do not imply memory=
=0D
+     barriers, but where the code needs a memory barrier. Examples for ato=
mic=0D
+     RMW functions that do not imply a memory barrier are e.g. add,=0D
+     subtract, (failed) conditional operations, _relaxed functions,=0D
+     but not atomic_read or atomic_set. A common example where a memory=0D
+     barrier may be required is when atomic ops are used for reference=0D
+     counting.=0D
+=0D
+     These are also used for atomic RMW bitop functions that do not imply =
a=0D
+     memory barrier (such as set_bit and clear_bit).=0D
+=0D
+     As an example, consider a piece of code that marks an object as being=
 dead=0D
+     and then decrements the object's reference count:=0D
+=0D
+	obj->dead =3D 1;=0D
+	smp_mb__before_atomic();=0D
+	atomic_dec(&obj->ref_count);=0D
+=0D
+     This makes sure that the death mark on the object is perceived to be =
set=0D
+     *before* the reference counter is decremented.=0D
+=0D
+     See Documentation/atomic_{t,bitops}.txt for more information.=0D
+=0D
+=0D
+ (*) dma_wmb();=0D
+ (*) dma_rmb();=0D
+ (*) dma_mb();=0D
+=0D
+     These are for use with consistent memory to guarantee the ordering=0D
+     of writes or reads of shared memory accessible to both the CPU and a=
=0D
+     DMA capable device. See Documentation/core-api/dma-api.rst file for m=
ore=0D
+     information about consistent memory.=0D
+=0D
+     For example, consider a device driver that shares memory with a devic=
e=0D
+     and uses a descriptor status value to indicate if the descriptor belo=
ngs=0D
+     to the device or the CPU, and a doorbell to notify it when new=0D
+     descriptors are available:=0D
+=0D
+	if (desc->status !=3D DEVICE_OWN) {=0D
+		/* do not read data until we own descriptor */=0D
+		dma_rmb();=0D
+=0D
+		/* read/modify data */=0D
+		read_data =3D desc->data;=0D
+		desc->data =3D write_data;=0D
+=0D
+		/* flush modifications before status update */=0D
+		dma_wmb();=0D
+=0D
+		/* assign ownership */=0D
+		desc->status =3D DEVICE_OWN;=0D
+=0D
+		/* Make descriptor status visible to the device followed by=0D
+		 * notify device of new descriptor=0D
+		 */=0D
+		writel(DESC_NOTIFY, doorbell);=0D
+	}=0D
+=0D
+     The dma_rmb() allows us to guarantee that the device has released own=
ership=0D
+     before we read the data from the descriptor, and the dma_wmb() allows=
=0D
+     us to guarantee the data is written to the descriptor before the devi=
ce=0D
+     can see it now has ownership.  The dma_mb() implies both a dma_rmb() =
and=0D
+     a dma_wmb().=0D
+=0D
+     Note that the dma_*() barriers do not provide any ordering guarantees=
 for=0D
+     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"=
=0D
+     subsection for more information about I/O accessors and MMIO ordering=
.=0D
+=0D
+ (*) pmem_wmb();=0D
+=0D
+     This is for use with persistent memory to ensure that stores for whic=
h=0D
+     modifications are written to persistent storage reached a platform=0D
+     durability domain.=0D
+=0D
+     For example, after a non-temporal write to pmem region, we use pmem_w=
mb()=0D
+     to ensure that stores have reached a platform durability domain. This=
 ensures=0D
+     that stores have updated persistent storage before any data access or=
=0D
+     data transfer caused by subsequent instructions is initiated. This is=
=0D
+     in addition to the ordering done by wmb().=0D
+=0D
+     For load from persistent memory, existing read memory barriers are su=
fficient=0D
+     to ensure read ordering.=0D
+=0D
+ (*) io_stop_wc();=0D
+=0D
+     For memory accesses with write-combining attributes (e.g. those retur=
ned=0D
+     by ioremap_wc()), the CPU may wait for prior accesses to be merged wi=
th=0D
+     subsequent ones. io_stop_wc() can be used to prevent the merging of=0D
+     write-combining memory accesses before this macro with those after it=
 when=0D
+     such wait has performance implications.=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0D
+IMPLICIT KERNEL MEMORY BARRIERS=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+Some of the other functions in the linux kernel imply memory barriers, amo=
ngst=0D
+which are locking and scheduling functions.=0D
+=0D
+This specification is a _minimum_ guarantee; any particular architecture m=
ay=0D
+provide more substantial guarantees, but these may not be relied upon outs=
ide=0D
+of arch specific code.=0D
+=0D
+=0D
+LOCK ACQUISITION FUNCTIONS=0D
+--------------------------=0D
+=0D
+The Linux kernel has a number of locking constructs:=0D
+=0D
+ (*) spin locks=0D
+ (*) R/W spin locks=0D
+ (*) mutexes=0D
+ (*) semaphores=0D
+ (*) R/W semaphores=0D
+=0D
+In all cases there are variants on "ACQUIRE" operations and "RELEASE" oper=
ations=0D
+for each construct.  These operations all imply certain barriers:=0D
+=0D
+ (1) ACQUIRE operation implication:=0D
+=0D
+     Memory operations issued after the ACQUIRE will be completed after th=
e=0D
+     ACQUIRE operation has completed.=0D
+=0D
+     Memory operations issued before the ACQUIRE may be completed after=0D
+     the ACQUIRE operation has completed.=0D
+=0D
+ (2) RELEASE operation implication:=0D
+=0D
+     Memory operations issued before the RELEASE will be completed before =
the=0D
+     RELEASE operation has completed.=0D
+=0D
+     Memory operations issued after the RELEASE may be completed before th=
e=0D
+     RELEASE operation has completed.=0D
+=0D
+ (3) ACQUIRE vs ACQUIRE implication:=0D
+=0D
+     All ACQUIRE operations issued before another ACQUIRE operation will b=
e=0D
+     completed before that ACQUIRE operation.=0D
+=0D
+ (4) ACQUIRE vs RELEASE implication:=0D
+=0D
+     All ACQUIRE operations issued before a RELEASE operation will be=0D
+     completed before the RELEASE operation.=0D
+=0D
+ (5) Failed conditional ACQUIRE implication:=0D
+=0D
+     Certain locking variants of the ACQUIRE operation may fail, either du=
e to=0D
+     being unable to get the lock immediately, or due to receiving an unbl=
ocked=0D
+     signal while asleep waiting for the lock to become available.  Failed=
=0D
+     locks do not imply any sort of barrier.=0D
+=0D
+[!] Note: one of the consequences of lock ACQUIREs and RELEASEs being only=
=0D
+one-way barriers is that the effects of instructions outside of a critical=
=0D
+section may seep into the inside of the critical section.=0D
+=0D
+An ACQUIRE followed by a RELEASE may not be assumed to be full memory barr=
ier=0D
+because it is possible for an access preceding the ACQUIRE to happen after=
 the=0D
+ACQUIRE, and an access following the RELEASE to happen before the RELEASE,=
 and=0D
+the two accesses can themselves then cross:=0D
+=0D
+	*A =3D a;=0D
+	ACQUIRE M=0D
+	RELEASE M=0D
+	*B =3D b;=0D
+=0D
+may occur as:=0D
+=0D
+	ACQUIRE M, STORE *B, STORE *A, RELEASE M=0D
+=0D
+When the ACQUIRE and RELEASE are a lock acquisition and release,=0D
+respectively, this same reordering can occur if the lock's ACQUIRE and=0D
+RELEASE are to the same lock variable, but only from the perspective of=0D
+another CPU not holding that lock.  In short, a ACQUIRE followed by an=0D
+RELEASE may -not- be assumed to be a full memory barrier.=0D
+=0D
+Similarly, the reverse case of a RELEASE followed by an ACQUIRE does=0D
+not imply a full memory barrier.  Therefore, the CPU's execution of the=0D
+critical sections corresponding to the RELEASE and the ACQUIRE can cross,=
=0D
+so that:=0D
+=0D
+	*A =3D a;=0D
+	RELEASE M=0D
+	ACQUIRE N=0D
+	*B =3D b;=0D
+=0D
+could occur as:=0D
+=0D
+	ACQUIRE N, STORE *B, STORE *A, RELEASE M=0D
+=0D
+It might appear that this reordering could introduce a deadlock.=0D
+However, this cannot happen because if such a deadlock threatened,=0D
+the RELEASE would simply complete, thereby avoiding the deadlock.=0D
+=0D
+	Why does this work?=0D
+=0D
+	One key point is that we are only talking about the CPU doing=0D
+	the reordering, not the compiler.  If the compiler (or, for=0D
+	that matter, the developer) switched the operations, deadlock=0D
+	-could- occur.=0D
+=0D
+	But suppose the CPU reordered the operations.  In this case,=0D
+	the unlock precedes the lock in the assembly code.  The CPU=0D
+	simply elected to try executing the later lock operation first.=0D
+	If there is a deadlock, this lock operation will simply spin (or=0D
+	try to sleep, but more on that later).	The CPU will eventually=0D
+	execute the unlock operation (which preceded the lock operation=0D
+	in the assembly code), which will unravel the potential deadlock,=0D
+	allowing the lock operation to succeed.=0D
+=0D
+	But what if the lock is a sleeplock?  In that case, the code will=0D
+	try to enter the scheduler, where it will eventually encounter=0D
+	a memory barrier, which will force the earlier unlock operation=0D
+	to complete, again unraveling the deadlock.  There might be=0D
+	a sleep-unlock race, but the locking primitive needs to resolve=0D
+	such races properly in any case.=0D
+=0D
+Locks and semaphores may not provide any guarantee of ordering on UP compi=
led=0D
+systems, and so cannot be counted on in such a situation to actually achie=
ve=0D
+anything at all - especially with respect to I/O accesses - unless combine=
d=0D
+with interrupt disabling operations.=0D
+=0D
+See also the section on "Inter-CPU acquiring barrier effects".=0D
+=0D
+=0D
+As an example, consider the following:=0D
+=0D
+	*A =3D a;=0D
+	*B =3D b;=0D
+	ACQUIRE=0D
+	*C =3D c;=0D
+	*D =3D d;=0D
+	RELEASE=0D
+	*E =3D e;=0D
+	*F =3D f;=0D
+=0D
+The following sequence of events is acceptable:=0D
+=0D
+	ACQUIRE, {*F,*A}, *E, {*C,*D}, *B, RELEASE=0D
+=0D
+	[+] Note that {*F,*A} indicates a combined access.=0D
+=0D
+But none of the following are:=0D
+=0D
+	{*F,*A}, *B,	ACQUIRE, *C, *D,	RELEASE, *E=0D
+	*A, *B, *C,	ACQUIRE, *D,		RELEASE, *E, *F=0D
+	*A, *B,		ACQUIRE, *C,		RELEASE, *D, *E, *F=0D
+	*B,		ACQUIRE, *C, *D,	RELEASE, {*F,*A}, *E=0D
+=0D
+=0D
+=0D
+INTERRUPT DISABLING FUNCTIONS=0D
+-----------------------------=0D
+=0D
+Functions that disable interrupts (ACQUIRE equivalent) and enable interrup=
ts=0D
+(RELEASE equivalent) will act as compiler barriers only.  So if memory or =
I/O=0D
+barriers are required in such a situation, they must be provided from some=
=0D
+other means.=0D
+=0D
+=0D
+SLEEP AND WAKE-UP FUNCTIONS=0D
+---------------------------=0D
+=0D
+Sleeping and waking on an event flagged in global data can be viewed as an=
=0D
+interaction between two pieces of data: the task state of the task waiting=
 for=0D
+the event and the global data used to indicate the event.  To make sure th=
at=0D
+these appear to happen in the right order, the primitives to begin the pro=
cess=0D
+of going to sleep, and the primitives to initiate a wake up imply certain=
=0D
+barriers.=0D
+=0D
+Firstly, the sleeper normally follows something like this sequence of even=
ts:=0D
+=0D
+	for (;;) {=0D
+		set_current_state(TASK_UNINTERRUPTIBLE);=0D
+		if (event_indicated)=0D
+			break;=0D
+		schedule();=0D
+	}=0D
+=0D
+A general memory barrier is interpolated automatically by set_current_stat=
e()=0D
+after it has altered the task state:=0D
+=0D
+	CPU 1=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0D
+	set_current_state();=0D
+	  smp_store_mb();=0D
+	    STORE current->state=0D
+	    <general barrier>=0D
+	LOAD event_indicated=0D
+=0D
+set_current_state() may be wrapped by:=0D
+=0D
+	prepare_to_wait();=0D
+	prepare_to_wait_exclusive();=0D
+=0D
+which therefore also imply a general memory barrier after setting the stat=
e.=0D
+The whole sequence above is available in various canned forms, all of whic=
h=0D
+interpolate the memory barrier in the right place:=0D
+=0D
+	wait_event();=0D
+	wait_event_interruptible();=0D
+	wait_event_interruptible_exclusive();=0D
+	wait_event_interruptible_timeout();=0D
+	wait_event_killable();=0D
+	wait_event_timeout();=0D
+	wait_on_bit();=0D
+	wait_on_bit_lock();=0D
+	wait_event_cmd();=0D
+	wait_event_exclusive_cmd();=0D
+=0D
+=0D
+Secondly, code that performs a wake up normally follows something like thi=
s:=0D
+=0D
+	event_indicated =3D 1;=0D
+	wake_up(&event_wait_queue);=0D
+=0D
+or:=0D
+=0D
+	event_indicated =3D 1;=0D
+	wake_up_process(event_daemon);=0D
+=0D
+A general memory barrier is executed by wake_up() if it wakes something up=
.=0D
+If it doesn't wake anything up then a memory barrier may or may not be=0D
+executed; you must not rely on it.  The barrier occurs before the task sta=
te=0D
+is accessed, in particular, it sits between the STORE to indicate the even=
t=0D
+and the STORE to set TASK_RUNNING:=0D
+=0D
+	CPU 1 (Sleeper)			CPU 2 (Waker)=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	set_current_state();		STORE event_indicated=0D
+	  smp_store_mb();		wake_up();=0D
+	    STORE current->state	  ...=0D
+	    <general barrier>		  <general barrier>=0D
+	LOAD event_indicated		  if ((LOAD task->state) & TASK_NORMAL)=0D
+					    STORE task->state=0D
+=0D
+where "task" is the thread being woken up and it equals CPU 1's "current".=
=0D
+=0D
+To repeat, a general memory barrier is guaranteed to be executed by wake_u=
p()=0D
+if something is actually awakened, but otherwise there is no such guarante=
e.=0D
+To see this, consider the following sequence of events, where X and Y are =
both=0D
+initially zero:=0D
+=0D
+	CPU 1				CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	X =3D 1;				Y =3D 1;=0D
+	smp_mb();			wake_up();=0D
+	LOAD Y				LOAD X=0D
+=0D
+If a wakeup does occur, one (at least) of the two loads must see 1.  If, o=
n=0D
+the other hand, a wakeup does not occur, both loads might see 0.=0D
+=0D
+wake_up_process() always executes a general memory barrier.  The barrier a=
gain=0D
+occurs before the task state is accessed.  In particular, if the wake_up()=
 in=0D
+the previous snippet were replaced by a call to wake_up_process() then one=
 of=0D
+the two loads would be guaranteed to see 1.=0D
+=0D
+The available waker functions include:=0D
+=0D
+	complete();=0D
+	wake_up();=0D
+	wake_up_all();=0D
+	wake_up_bit();=0D
+	wake_up_interruptible();=0D
+	wake_up_interruptible_all();=0D
+	wake_up_interruptible_nr();=0D
+	wake_up_interruptible_poll();=0D
+	wake_up_interruptible_sync();=0D
+	wake_up_interruptible_sync_poll();=0D
+	wake_up_locked();=0D
+	wake_up_locked_poll();=0D
+	wake_up_nr();=0D
+	wake_up_poll();=0D
+	wake_up_process();=0D
+=0D
+In terms of memory ordering, these functions all provide the same guarante=
es of=0D
+a wake_up() (or stronger).=0D
+=0D
+[!] Note that the memory barriers implied by the sleeper and the waker do =
_not_=0D
+order multiple stores before the wake-up with respect to loads of those st=
ored=0D
+values after the sleeper has called set_current_state().  For instance, if=
 the=0D
+sleeper does:=0D
+=0D
+	set_current_state(TASK_INTERRUPTIBLE);=0D
+	if (event_indicated)=0D
+		break;=0D
+	__set_current_state(TASK_RUNNING);=0D
+	do_something(my_data);=0D
+=0D
+and the waker does:=0D
+=0D
+	my_data =3D value;=0D
+	event_indicated =3D 1;=0D
+	wake_up(&event_wait_queue);=0D
+=0D
+there's no guarantee that the change to event_indicated will be perceived =
by=0D
+the sleeper as coming after the change to my_data.  In such a circumstance=
, the=0D
+code on both sides must interpolate its own memory barriers between the=0D
+separate data accesses.  Thus the above sleeper ought to do:=0D
+=0D
+	set_current_state(TASK_INTERRUPTIBLE);=0D
+	if (event_indicated) {=0D
+		smp_rmb();=0D
+		do_something(my_data);=0D
+	}=0D
+=0D
+and the waker should do:=0D
+=0D
+	my_data =3D value;=0D
+	smp_wmb();=0D
+	event_indicated =3D 1;=0D
+	wake_up(&event_wait_queue);=0D
+=0D
+=0D
+MISCELLANEOUS FUNCTIONS=0D
+-----------------------=0D
+=0D
+Other functions that imply barriers:=0D
+=0D
+ (*) schedule() and similar imply full memory barriers.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+INTER-CPU ACQUIRING BARRIER EFFECTS=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+On SMP systems locking primitives give a more substantial form of barrier:=
 one=0D
+that does affect memory access ordering on other CPUs, within the context =
of=0D
+conflict on any particular lock.=0D
+=0D
+=0D
+ACQUIRES VS MEMORY ACCESSES=0D
+---------------------------=0D
+=0D
+Consider the following: the system has a pair of spinlocks (M) and (Q), an=
d=0D
+three CPUs; then should the following sequence of events occur:=0D
+=0D
+	CPU 1				CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+	WRITE_ONCE(*A, a);		WRITE_ONCE(*E, e);=0D
+	ACQUIRE M			ACQUIRE Q=0D
+	WRITE_ONCE(*B, b);		WRITE_ONCE(*F, f);=0D
+	WRITE_ONCE(*C, c);		WRITE_ONCE(*G, g);=0D
+	RELEASE M			RELEASE Q=0D
+	WRITE_ONCE(*D, d);		WRITE_ONCE(*H, h);=0D
+=0D
+Then there is no guarantee as to what order CPU 3 will see the accesses to=
 *A=0D
+through *H occur in, other than the constraints imposed by the separate lo=
cks=0D
+on the separate CPUs.  It might, for example, see:=0D
+=0D
+	*E, ACQUIRE M, ACQUIRE Q, *G, *C, *F, *A, *B, RELEASE Q, *D, *H, RELEASE =
M=0D
+=0D
+But it won't see any of:=0D
+=0D
+	*B, *C or *D preceding ACQUIRE M=0D
+	*A, *B or *C following RELEASE M=0D
+	*F, *G or *H preceding ACQUIRE Q=0D
+	*E, *F or *G following RELEASE Q=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+WHERE ARE MEMORY BARRIERS NEEDED?=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+Under normal operation, memory operation reordering is generally not going=
 to=0D
+be a problem as a single-threaded linear piece of code will still appear t=
o=0D
+work correctly, even if it's in an SMP kernel.  There are, however, four=0D
+circumstances in which reordering definitely _could_ be a problem:=0D
+=0D
+ (*) Interprocessor interaction.=0D
+=0D
+ (*) Atomic operations.=0D
+=0D
+ (*) Accessing devices.=0D
+=0D
+ (*) Interrupts.=0D
+=0D
+=0D
+INTERPROCESSOR INTERACTION=0D
+--------------------------=0D
+=0D
+When there's a system with more than one processor, more than one CPU in t=
he=0D
+system may be working on the same data set at the same time.  This can cau=
se=0D
+synchronisation problems, and the usual way of dealing with them is to use=
=0D
+locks.  Locks, however, are quite expensive, and so it may be preferable t=
o=0D
+operate without the use of a lock if at all possible.  In such a case=0D
+operations that affect both CPUs may have to be carefully ordered to preve=
nt=0D
+a malfunction.=0D
+=0D
+Consider, for example, the R/W semaphore slow path.  Here a waiting proces=
s is=0D
+queued on the semaphore, by virtue of it having a piece of its stack linke=
d to=0D
+the semaphore's list of waiting processes:=0D
+=0D
+	struct rw_semaphore {=0D
+		...=0D
+		spinlock_t lock;=0D
+		struct list_head waiters;=0D
+	};=0D
+=0D
+	struct rwsem_waiter {=0D
+		struct list_head list;=0D
+		struct task_struct *task;=0D
+	};=0D
+=0D
+To wake up a particular waiter, the up_read() or up_write() functions have=
 to:=0D
+=0D
+ (1) read the next pointer from this waiter's record to know as to where t=
he=0D
+     next waiter record is;=0D
+=0D
+ (2) read the pointer to the waiter's task structure;=0D
+=0D
+ (3) clear the task pointer to tell the waiter it has been given the semap=
hore;=0D
+=0D
+ (4) call wake_up_process() on the task; and=0D
+=0D
+ (5) release the reference held on the waiter's task struct.=0D
+=0D
+In other words, it has to perform this sequence of events:=0D
+=0D
+	LOAD waiter->list.next;=0D
+	LOAD waiter->task;=0D
+	STORE waiter->task;=0D
+	CALL wakeup=0D
+	RELEASE task=0D
+=0D
+and if any of these steps occur out of order, then the whole thing may=0D
+malfunction.=0D
+=0D
+Once it has queued itself and dropped the semaphore lock, the waiter does =
not=0D
+get the lock again; it instead just waits for its task pointer to be clear=
ed=0D
+before proceeding.  Since the record is on the waiter's stack, this means =
that=0D
+if the task pointer is cleared _before_ the next pointer in the list is re=
ad,=0D
+another CPU might start processing the waiter and might clobber the waiter=
's=0D
+stack before the up*() function has a chance to read the next pointer.=0D
+=0D
+Consider then what might happen to the above sequence of events:=0D
+=0D
+	CPU 1				CPU 2=0D
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+					down_xxx()=0D
+					Queue waiter=0D
+					Sleep=0D
+	up_yyy()=0D
+	LOAD waiter->task;=0D
+	STORE waiter->task;=0D
+					Woken up by other event=0D
+	<preempt>=0D
+					Resume processing=0D
+					down_xxx() returns=0D
+					call foo()=0D
+					foo() clobbers *waiter=0D
+	</preempt>=0D
+	LOAD waiter->list.next;=0D
+	--- OOPS ---=0D
+=0D
+This could be dealt with using the semaphore lock, but then the down_xxx()=
=0D
+function has to needlessly get the spinlock again after being woken up.=0D
+=0D
+The way to deal with this is to insert a general SMP memory barrier:=0D
+=0D
+	LOAD waiter->list.next;=0D
+	LOAD waiter->task;=0D
+	smp_mb();=0D
+	STORE waiter->task;=0D
+	CALL wakeup=0D
+	RELEASE task=0D
+=0D
+In this case, the barrier makes a guarantee that all memory accesses befor=
e the=0D
+barrier will appear to happen before all the memory accesses after the bar=
rier=0D
+with respect to the other CPUs on the system.  It does _not_ guarantee tha=
t all=0D
+the memory accesses before the barrier will be complete by the time the ba=
rrier=0D
+instruction itself is complete.=0D
+=0D
+On a UP system - where this wouldn't be a problem - the smp_mb() is just a=
=0D
+compiler barrier, thus making sure the compiler emits the instructions in =
the=0D
+right order without actually intervening in the CPU.  Since there's only o=
ne=0D
+CPU, that CPU's dependency ordering logic will take care of everything els=
e.=0D
+=0D
+=0D
+ATOMIC OPERATIONS=0D
+-----------------=0D
+=0D
+While they are technically interprocessor interaction considerations, atom=
ic=0D
+operations are noted specially as some of them imply full memory barriers =
and=0D
+some don't, but they're very heavily relied on as a group throughout the=0D
+kernel.=0D
+=0D
+See Documentation/atomic_t.txt for more information.=0D
+=0D
+=0D
+ACCESSING DEVICES=0D
+-----------------=0D
+=0D
+Many devices can be memory mapped, and so appear to the CPU as if they're =
just=0D
+a set of memory locations.  To control such a device, the driver usually h=
as to=0D
+make the right memory accesses in exactly the right order.=0D
+=0D
+However, having a clever CPU or a clever compiler creates a potential prob=
lem=0D
+in that the carefully sequenced accesses in the driver code won't reach th=
e=0D
+device in the requisite order if the CPU or the compiler thinks it is more=
=0D
+efficient to reorder, combine or merge accesses - something that would cau=
se=0D
+the device to malfunction.=0D
+=0D
+Inside of the Linux kernel, I/O should be done through the appropriate acc=
essor=0D
+routines - such as inb() or writel() - which know how to make such accesse=
s=0D
+appropriately sequential.  While this, for the most part, renders the expl=
icit=0D
+use of memory barriers unnecessary, if the accessor functions are used to =
refer=0D
+to an I/O memory window with relaxed memory access properties, then _manda=
tory_=0D
+memory barriers are required to enforce ordering.=0D
+=0D
+See Documentation/driver-api/device-io.rst for more information.=0D
+=0D
+=0D
+INTERRUPTS=0D
+----------=0D
+=0D
+A driver may be interrupted by its own interrupt service routine, and thus=
 the=0D
+two parts of the driver may interfere with each other's attempts to contro=
l or=0D
+access the device.=0D
+=0D
+This may be alleviated - at least in part - by disabling local interrupts =
(a=0D
+form of locking), such that the critical operations are all contained with=
in=0D
+the interrupt-disabled section in the driver.  While the driver's interrup=
t=0D
+routine is executing, the driver's core may not run on the same CPU, and i=
ts=0D
+interrupt is not permitted to happen again until the current interrupt has=
 been=0D
+handled, thus the interrupt handler does not need to lock against that.=0D
+=0D
+However, consider a driver that was talking to an ethernet card that sport=
s an=0D
+address register and a data register.  If that driver's core talks to the =
card=0D
+under interrupt-disablement and then the driver's interrupt handler is inv=
oked:=0D
+=0D
+	LOCAL IRQ DISABLE=0D
+	writew(ADDR, 3);=0D
+	writew(DATA, y);=0D
+	LOCAL IRQ ENABLE=0D
+	<interrupt>=0D
+	writew(ADDR, 4);=0D
+	q =3D readw(DATA);=0D
+	</interrupt>=0D
+=0D
+The store to the data register might happen after the second store to the=
=0D
+address register if ordering rules are sufficiently relaxed:=0D
+=0D
+	STORE *ADDR =3D 3, STORE *ADDR =3D 4, STORE *DATA =3D y, q =3D LOAD *DATA=
=0D
+=0D
+=0D
+If ordering rules are relaxed, it must be assumed that accesses done insid=
e an=0D
+interrupt disabled section may leak outside of it and may interleave with=
=0D
+accesses performed in an interrupt - and vice versa - unless implicit or=0D
+explicit barriers are used.=0D
+=0D
+Normally this won't be a problem because the I/O accesses done inside such=
=0D
+sections will include synchronous load operations on strictly ordered I/O=
=0D
+registers that form implicit I/O barriers.=0D
+=0D
+=0D
+A similar situation may occur between an interrupt routine and two routine=
s=0D
+running on separate CPUs that communicate with each other.  If such a case=
 is=0D
+likely, then interrupt-disabling locks should be used to guarantee orderin=
g.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0D
+KERNEL I/O BARRIER EFFECTS=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0D
+=0D
+Interfacing with peripherals via I/O accesses is deeply architecture and d=
evice=0D
+specific. Therefore, drivers which are inherently non-portable may rely on=
=0D
+specific behaviours of their target systems in order to achieve synchroniz=
ation=0D
+in the most lightweight manner possible. For drivers intending to be porta=
ble=0D
+between multiple architectures and bus implementations, the kernel offers =
a=0D
+series of accessor functions that provide various degrees of ordering=0D
+guarantees:=0D
+=0D
+ (*) readX(), writeX():=0D
+=0D
+	The readX() and writeX() MMIO accessors take a pointer to the=0D
+	peripheral being accessed as an __iomem * parameter. For pointers=0D
+	mapped with the default I/O attributes (e.g. those returned by=0D
+	ioremap()), the ordering guarantees are as follows:=0D
+=0D
+	1. All readX() and writeX() accesses to the same peripheral are ordered=0D
+	   with respect to each other. This ensures that MMIO register accesses=0D
+	   by the same CPU thread to a particular device will arrive in program=0D
+	   order.=0D
+=0D
+	2. A writeX() issued by a CPU thread holding a spinlock is ordered=0D
+	   before a writeX() to the same peripheral from another CPU thread=0D
+	   issued after a later acquisition of the same spinlock. This ensures=0D
+	   that MMIO register writes to a particular device issued while holding=
=0D
+	   a spinlock will arrive in an order consistent with acquisitions of=0D
+	   the lock.=0D
+=0D
+	3. A writeX() by a CPU thread to the peripheral will first wait for the=0D
+	   completion of all prior writes to memory either issued by, or=0D
+	   propagated to, the same thread. This ensures that writes by the CPU=0D
+	   to an outbound DMA buffer allocated by dma_alloc_coherent() will be=0D
+	   visible to a DMA engine when the CPU writes to its MMIO control=0D
+	   register to trigger the transfer.=0D
+=0D
+	4. A readX() by a CPU thread from the peripheral will complete before=0D
+	   any subsequent reads from memory by the same thread can begin. This=0D
+	   ensures that reads by the CPU from an incoming DMA buffer allocated=0D
+	   by dma_alloc_coherent() will not see stale data after reading from=0D
+	   the DMA engine's MMIO status register to establish that the DMA=0D
+	   transfer has completed.=0D
+=0D
+	5. A readX() by a CPU thread from the peripheral will complete before=0D
+	   any subsequent delay() loop can begin execution on the same thread.=0D
+	   This ensures that two MMIO register writes by the CPU to a peripheral=
=0D
+	   will arrive at least 1us apart if the first write is immediately read=
=0D
+	   back with readX() and udelay(1) is called prior to the second=0D
+	   writeX():=0D
+=0D
+		writel(42, DEVICE_REGISTER_0); // Arrives at the device...=0D
+		readl(DEVICE_REGISTER_0);=0D
+		udelay(1);=0D
+		writel(42, DEVICE_REGISTER_1); // ...at least 1us before this.=0D
+=0D
+	The ordering properties of __iomem pointers obtained with non-default=0D
+	attributes (e.g. those returned by ioremap_wc()) are specific to the=0D
+	underlying architecture and therefore the guarantees listed above cannot=
=0D
+	generally be relied upon for accesses to these types of mappings.=0D
+=0D
+ (*) readX_relaxed(), writeX_relaxed():=0D
+=0D
+	These are similar to readX() and writeX(), but provide weaker memory=0D
+	ordering guarantees. Specifically, they do not guarantee ordering with=0D
+	respect to locking, normal memory accesses or delay() loops (i.e.=0D
+	bullets 2-5 above) but they are still guaranteed to be ordered with=0D
+	respect to other accesses from the same CPU thread to the same=0D
+	peripheral when operating on __iomem pointers mapped with the default=0D
+	I/O attributes.=0D
+=0D
+ (*) readsX(), writesX():=0D
+=0D
+	The readsX() and writesX() MMIO accessors are designed for accessing=0D
+	register-based, memory-mapped FIFOs residing on peripherals that are not=
=0D
+	capable of performing DMA. Consequently, they provide only the ordering=0D
+	guarantees of readX_relaxed() and writeX_relaxed(), as documented above.=
=0D
+=0D
+ (*) inX(), outX():=0D
+=0D
+	The inX() and outX() accessors are intended to access legacy port-mapped=
=0D
+	I/O peripherals, which may require special instructions on some=0D
+	architectures (notably x86). The port number of the peripheral being=0D
+	accessed is passed as an argument.=0D
+=0D
+	Since many CPU architectures ultimately access these peripherals via an=0D
+	internal virtual memory mapping, the portable ordering guarantees=0D
+	provided by inX() and outX() are the same as those provided by readX()=0D
+	and writeX() respectively when accessing a mapping with the default I/O=0D
+	attributes.=0D
+=0D
+	Device drivers may expect outX() to emit a non-posted write transaction=0D
+	that waits for a completion response from the I/O peripheral before=0D
+	returning. This is not guaranteed by all architectures and is therefore=0D
+	not part of the portable ordering semantics.=0D
+=0D
+ (*) insX(), outsX():=0D
+=0D
+	As above, the insX() and outsX() accessors provide the same ordering=0D
+	guarantees as readsX() and writesX() respectively when accessing a=0D
+	mapping with the default I/O attributes.=0D
+=0D
+ (*) ioreadX(), iowriteX():=0D
+=0D
+	These will perform appropriately for the type of access they're actually=
=0D
+	doing, be it inX()/outX() or readX()/writeX().=0D
+=0D
+With the exception of the string accessors (insX(), outsX(), readsX() and=
=0D
+writesX()), all of the above assume that the underlying peripheral is=0D
+little-endian and will therefore perform byte-swapping operations on big-e=
ndian=0D
+architectures.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+ASSUMED MINIMUM EXECUTION ORDERING MODEL=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+It has to be assumed that the conceptual CPU is weakly-ordered but that it=
 will=0D
+maintain the appearance of program causality with respect to itself.  Some=
 CPUs=0D
+(such as i386 or x86_64) are more constrained than others (such as powerpc=
 or=0D
+frv), and so the most relaxed case (namely DEC Alpha) must be assumed outs=
ide=0D
+of arch-specific code.=0D
+=0D
+This means that it must be considered that the CPU will execute its instru=
ction=0D
+stream in any order it feels like - or even in parallel - provided that if=
 an=0D
+instruction in the stream depends on an earlier instruction, then that=0D
+earlier instruction must be sufficiently complete[*] before the later=0D
+instruction may proceed; in other words: provided that the appearance of=0D
+causality is maintained.=0D
+=0D
+ [*] Some instructions have more than one effect - such as changing the=0D
+     condition codes, changing registers or changing memory - and differen=
t=0D
+     instructions may depend on different effects.=0D
+=0D
+A CPU may also discard any instruction sequence that winds up having no=0D
+ultimate effect.  For example, if two adjacent instructions both load an=0D
+immediate value into the same register, the first may be discarded.=0D
+=0D
+=0D
+Similarly, it has to be assumed that compiler might reorder the instructio=
n=0D
+stream in any way it sees fit, again provided the appearance of causality =
is=0D
+maintained.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0D
+THE EFFECTS OF THE CPU CACHE=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0D
+=0D
+The way cached memory operations are perceived across the system is affect=
ed to=0D
+a certain extent by the caches that lie between CPUs and memory, and by th=
e=0D
+memory coherence system that maintains the consistency of state in the sys=
tem.=0D
+=0D
+As far as the way a CPU interacts with another part of the system through =
the=0D
+caches goes, the memory system has to include the CPU's caches, and memory=
=0D
+barriers for the most part act at the interface between the CPU and its ca=
che=0D
+(memory barriers logically act on the dotted line in the following diagram=
):=0D
+=0D
+	    <--- CPU --->         :       <----------- Memory ----------->=0D
+	                          :=0D
+	+--------+    +--------+  :   +--------+    +-----------+=0D
+	|        |    |        |  :   |        |    |           |    +--------+=0D
+	|  CPU   |    | Memory |  :   | CPU    |    |           |    |        |=0D
+	|  Core  |--->| Access |----->| Cache  |<-->|           |    |        |=0D
+	|        |    | Queue  |  :   |        |    |           |--->| Memory |=0D
+	|        |    |        |  :   |        |    |           |    |        |=0D
+	+--------+    +--------+  :   +--------+    |           |    |        |=0D
+	                          :                 | Cache     |    +--------+=0D
+	                          :                 | Coherency |=0D
+	                          :                 | Mechanism |    +--------+=0D
+	+--------+    +--------+  :   +--------+    |           |    |	      |=0D
+	|        |    |        |  :   |        |    |           |    |        |=0D
+	|  CPU   |    | Memory |  :   | CPU    |    |           |--->| Device |=0D
+	|  Core  |--->| Access |----->| Cache  |<-->|           |    |        |=0D
+	|        |    | Queue  |  :   |        |    |           |    |        |=0D
+	|        |    |        |  :   |        |    |           |    +--------+=0D
+	+--------+    +--------+  :   +--------+    +-----------+=0D
+	                          :=0D
+	                          :=0D
+=0D
+Although any particular load or store may not actually appear outside of t=
he=0D
+CPU that issued it since it may have been satisfied within the CPU's own c=
ache,=0D
+it will still appear as if the full memory access had taken place as far a=
s the=0D
+other CPUs are concerned since the cache coherency mechanisms will migrate=
 the=0D
+cacheline over to the accessing CPU and propagate the effects upon conflic=
t.=0D
+=0D
+The CPU core may execute instructions in any order it deems fit, provided =
the=0D
+expected program causality appears to be maintained.  Some of the instruct=
ions=0D
+generate load and store operations which then go into the queue of memory=
=0D
+accesses to be performed.  The core may place these in the queue in any or=
der=0D
+it wishes, and continue execution until it is forced to wait for an instru=
ction=0D
+to complete.=0D
+=0D
+What memory barriers are concerned with is controlling the order in which=
=0D
+accesses cross from the CPU side of things to the memory side of things, a=
nd=0D
+the order in which the effects are perceived to happen by the other observ=
ers=0D
+in the system.=0D
+=0D
+[!] Memory barriers are _not_ needed within a given CPU, as CPUs always se=
e=0D
+their own loads and stores as if they had happened in program order.=0D
+=0D
+[!] MMIO or other device accesses may bypass the cache system.  This depen=
ds on=0D
+the properties of the memory window through which devices are accessed and=
/or=0D
+the use of any special device communication instructions the CPU may have.=
=0D
+=0D
+=0D
+CACHE COHERENCY VS DMA=0D
+----------------------=0D
+=0D
+Not all systems maintain cache coherency with respect to devices doing DMA=
.  In=0D
+such cases, a device attempting DMA may obtain stale data from RAM because=
=0D
+dirty cache lines may be resident in the caches of various CPUs, and may n=
ot=0D
+have been written back to RAM yet.  To deal with this, the appropriate par=
t of=0D
+the kernel must flush the overlapping bits of cache on each CPU (and maybe=
=0D
+invalidate them as well).=0D
+=0D
+In addition, the data DMA'd to RAM by a device may be overwritten by dirty=
=0D
+cache lines being written back to RAM from a CPU's cache after the device =
has=0D
+installed its own data, or cache lines present in the CPU's cache may simp=
ly=0D
+obscure the fact that RAM has been updated, until at such time as the cach=
eline=0D
+is discarded from the CPU's cache and reloaded.  To deal with this, the=0D
+appropriate part of the kernel must invalidate the overlapping bits of the=
=0D
+cache on each CPU.=0D
+=0D
+See Documentation/core-api/cachetlb.rst for more information on cache=0D
+management.=0D
+=0D
+=0D
+CACHE COHERENCY VS MMIO=0D
+-----------------------=0D
+=0D
+Memory mapped I/O usually takes place through memory locations that are pa=
rt of=0D
+a window in the CPU's memory space that has different properties assigned =
than=0D
+the usual RAM directed window.=0D
+=0D
+Amongst these properties is usually the fact that such accesses bypass the=
=0D
+caching entirely and go directly to the device buses.  This means MMIO acc=
esses=0D
+may, in effect, overtake accesses to cached memory that were emitted earli=
er.=0D
+A memory barrier isn't sufficient in such a case, but rather the cache mus=
t be=0D
+flushed between the cached memory write and the MMIO access if the two are=
 in=0D
+any way dependent.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0D
+THE THINGS CPUS GET UP TO=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0D
+=0D
+A programmer might take it for granted that the CPU will perform memory=0D
+operations in exactly the order specified, so that if the CPU is, for exam=
ple,=0D
+given the following piece of code to execute:=0D
+=0D
+	a =3D READ_ONCE(*A);=0D
+	WRITE_ONCE(*B, b);=0D
+	c =3D READ_ONCE(*C);=0D
+	d =3D READ_ONCE(*D);=0D
+	WRITE_ONCE(*E, e);=0D
+=0D
+they would then expect that the CPU will complete the memory operation for=
 each=0D
+instruction before moving on to the next one, leading to a definite sequen=
ce of=0D
+operations as seen by external observers in the system:=0D
+=0D
+	LOAD *A, STORE *B, LOAD *C, LOAD *D, STORE *E.=0D
+=0D
+=0D
+Reality is, of course, much messier.  With many CPUs and compilers, the ab=
ove=0D
+assumption doesn't hold because:=0D
+=0D
+ (*) loads are more likely to need to be completed immediately to permit=0D
+     execution progress, whereas stores can often be deferred without a=0D
+     problem;=0D
+=0D
+ (*) loads may be done speculatively, and the result discarded should it p=
rove=0D
+     to have been unnecessary;=0D
+=0D
+ (*) loads may be done speculatively, leading to the result having been fe=
tched=0D
+     at the wrong time in the expected sequence of events;=0D
+=0D
+ (*) the order of the memory accesses may be rearranged to promote better =
use=0D
+     of the CPU buses and caches;=0D
+=0D
+ (*) loads and stores may be combined to improve performance when talking =
to=0D
+     memory or I/O hardware that can do batched accesses of adjacent locat=
ions,=0D
+     thus cutting down on transaction setup costs (memory and PCI devices =
may=0D
+     both be able to do this); and=0D
+=0D
+ (*) the CPU's data cache may affect the ordering, and while cache-coheren=
cy=0D
+     mechanisms may alleviate this - once the store has actually hit the c=
ache=0D
+     - there's no guarantee that the coherency management will be propagat=
ed in=0D
+     order to other CPUs.=0D
+=0D
+So what another CPU, say, might actually observe from the above piece of c=
ode=0D
+is:=0D
+=0D
+	LOAD *A, ..., LOAD {*C,*D}, STORE *E, STORE *B=0D
+=0D
+	(Where "LOAD {*C,*D}" is a combined load)=0D
+=0D
+=0D
+However, it is guaranteed that a CPU will be self-consistent: it will see =
its=0D
+_own_ accesses appear to be correctly ordered, without the need for a memo=
ry=0D
+barrier.  For instance with the following code:=0D
+=0D
+	U =3D READ_ONCE(*A);=0D
+	WRITE_ONCE(*A, V);=0D
+	WRITE_ONCE(*A, W);=0D
+	X =3D READ_ONCE(*A);=0D
+	WRITE_ONCE(*A, Y);=0D
+	Z =3D READ_ONCE(*A);=0D
+=0D
+and assuming no intervention by an external influence, it can be assumed t=
hat=0D
+the final result will appear to be:=0D
+=0D
+	U =3D=3D the original value of *A=0D
+	X =3D=3D W=0D
+	Z =3D=3D Y=0D
+	*A =3D=3D Y=0D
+=0D
+The code above may cause the CPU to generate the full sequence of memory=0D
+accesses:=0D
+=0D
+	U=3DLOAD *A, STORE *A=3DV, STORE *A=3DW, X=3DLOAD *A, STORE *A=3DY, Z=3DL=
OAD *A=0D
+=0D
+in that order, but, without intervention, the sequence may have almost any=
=0D
+combination of elements combined or discarded, provided the program's view=
=0D
+of the world remains consistent.  Note that READ_ONCE() and WRITE_ONCE()=0D
+are -not- optional in the above example, as there are architectures=0D
+where a given CPU might reorder successive loads to the same location.=0D
+On such architectures, READ_ONCE() and WRITE_ONCE() do whatever is=0D
+necessary to prevent this, for example, on Itanium the volatile casts=0D
+used by READ_ONCE() and WRITE_ONCE() cause GCC to emit the special ld.acq=
=0D
+and st.rel instructions (respectively) that prevent such reordering.=0D
+=0D
+The compiler may also combine, discard or defer elements of the sequence b=
efore=0D
+the CPU even sees them.=0D
+=0D
+For instance:=0D
+=0D
+	*A =3D V;=0D
+	*A =3D W;=0D
+=0D
+may be reduced to:=0D
+=0D
+	*A =3D W;=0D
+=0D
+since, without either a write barrier or an WRITE_ONCE(), it can be=0D
+assumed that the effect of the storage of V to *A is lost.  Similarly:=0D
+=0D
+	*A =3D Y;=0D
+	Z =3D *A;=0D
+=0D
+may, without a memory barrier or an READ_ONCE() and WRITE_ONCE(), be=0D
+reduced to:=0D
+=0D
+	*A =3D Y;=0D
+	Z =3D Y;=0D
+=0D
+and the LOAD operation never appear outside of the CPU.=0D
+=0D
+=0D
+AND THEN THERE'S THE ALPHA=0D
+--------------------------=0D
+=0D
+The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that=
,=0D
+some versions of the Alpha CPU have a split data cache, permitting them to=
 have=0D
+two semantically-related cache lines updated at separate times.  This is w=
here=0D
+the address-dependency barrier really becomes necessary as this synchronis=
es=0D
+both caches with the memory coherence system, thus making it seem like poi=
nter=0D
+changes vs new data occur in the right order.=0D
+=0D
+The Alpha defines the Linux kernel's memory model, although as of v4.15=0D
+the Linux kernel's addition of smp_mb() to READ_ONCE() on Alpha greatly=0D
+reduced its impact on the memory model.=0D
+=0D
+=0D
+VIRTUAL MACHINE GUESTS=0D
+----------------------=0D
+=0D
+Guests running within virtual machines might be affected by SMP effects ev=
en if=0D
+the guest itself is compiled without SMP support.  This is an artifact of=
=0D
+interfacing with an SMP host while running an UP kernel.  Using mandatory=
=0D
+barriers for this use-case would be possible but is often suboptimal.=0D
+=0D
+To handle this case optimally, low-level virt_mb() etc macros are availabl=
e.=0D
+These have the same effect as smp_mb() etc when SMP is enabled, but genera=
te=0D
+identical code for SMP and non-SMP systems.  For example, virtual machine =
guests=0D
+should use virt_mb() rather than smp_mb() when synchronizing against a=0D
+(possibly SMP) host.=0D
+=0D
+These are equivalent to smp_mb() etc counterparts in all other respects,=0D
+in particular, they do not control MMIO effects: to control=0D
+MMIO effects, use mandatory barriers.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+EXAMPLE USES=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+CIRCULAR BUFFERS=0D
+----------------=0D
+=0D
+Memory barriers can be used to implement circular buffering without the ne=
ed=0D
+of a lock to serialise the producer with the consumer.  See:=0D
+=0D
+	Documentation/core-api/circular-buffers.rst=0D
+=0D
+for details.=0D
+=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+REFERENCES=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+Alpha AXP Architecture Reference Manual, Second Edition (Sites & Witek,=0D
+Digital Press)=0D
+	Chapter 5.2: Physical Address Space Characteristics=0D
+	Chapter 5.4: Caches and Write Buffers=0D
+	Chapter 5.5: Data Sharing=0D
+	Chapter 5.6: Read/Write Ordering=0D
+=0D
+AMD64 Architecture Programmer's Manual Volume 2: System Programming=0D
+	Chapter 7.1: Memory-Access Ordering=0D
+	Chapter 7.4: Buffering and Combining Memory Writes=0D
+=0D
+ARM Architecture Reference Manual (ARMv8, for ARMv8-A architecture profile=
)=0D
+	Chapter B2: The AArch64 Application Level Memory Model=0D
+=0D
+IA-32 Intel Architecture Software Developer's Manual, Volume 3:=0D
+System Programming Guide=0D
+	Chapter 7.1: Locked Atomic Operations=0D
+	Chapter 7.2: Memory Ordering=0D
+	Chapter 7.4: Serializing Instructions=0D
+=0D
+The SPARC Architecture Manual, Version 9=0D
+	Chapter 8: Memory Models=0D
+	Appendix D: Formal Specification of the Memory Models=0D
+	Appendix J: Programming with the Memory Models=0D
+=0D
+Storage in the PowerPC (Stone and Fitzgerald)=0D
+=0D
+UltraSPARC Programmer Reference Manual=0D
+	Chapter 5: Memory Accesses and Cacheability=0D
+	Chapter 15: Sparc-V9 Memory Models=0D
+=0D
+UltraSPARC III Cu User's Manual=0D
+	Chapter 9: Memory Models=0D
+=0D
+UltraSPARC IIIi Processor User's Manual=0D
+	Chapter 8: Memory Models=0D
+=0D
+UltraSPARC Architecture 2005=0D
+	Chapter 9: Memory=0D
+	Appendix D: Formal Specifications of the Memory Models=0D
+=0D
+UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005=0D
+	Chapter 8: Memory Models=0D
+	Appendix F: Caches and Cache Coherency=0D
+=0D
+Solaris Internals, Core Kernel Architecture, p63-68:=0D
+	Chapter 3.3: Hardware Considerations for Locks and=0D
+			Synchronization=0D
+=0D
+Unix Systems for Modern Architectures, Symmetric Multiprocessing and Cachi=
ng=0D
+for Kernel Programmers:=0D
+	Chapter 13: Other Memory Models=0D
+=0D
+Intel Itanium Architecture Software Developer's Manual: Volume 1:=0D
+	Section 2.6: Speculation=0D
+	Section 4.4: Memory Access=0D
--=20
2.47.1.windows.1


