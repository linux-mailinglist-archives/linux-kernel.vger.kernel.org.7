Return-Path: <linux-kernel+bounces-753047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6EFB17E1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA8E3BFEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B91FAC34;
	Fri,  1 Aug 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqe+sSUv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82335B21A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036420; cv=none; b=qG/JKUFjvc9roI+xgmafifA/Psj0XYrw9OzFokjSH0IalL1m/m4d7VYNA/K8QKevCTmxOP4gdS8ctaIgUrruUo6ERt58RgoOxBh2ljLhJuI8PpxFjvvht5p39aA6p8omOYvspsUJxm444DUVlczmzQGyYS71uicDqe7a7f35WGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036420; c=relaxed/simple;
	bh=G1pQsJvFjVoLfkGZnseLbuNsZ6Eyg1M9ApsSEGBS728=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4YREiAPRTqeKgpPsCl+gGvBYz+9OobI03ZyXH4nrVdiheDtqa1AAbASOfmszNwA8umqVycQbT7NoRRIGvOKssCojoKjnjI0Ygvi/JBzuLSdsTe0dF6E1UderiqBnPoVODoUsYOF07sr7vGOcZ0sK9xmmUfC4D0ZaVbh3RNOI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqe+sSUv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754036417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZUpb6CxFxqCnvCJ7Sae21Wa8wNJ4gkxD1bxjlVHC2FA=;
	b=cqe+sSUvNCeulsTrtN/vCKml6tv7agHjzSDmJvigU5fYgS+5vB2FietudSAljznQbDW4di
	TN3kHKxkvu9j1MG/73ctBhKhBnyHyEFGT6QsH7bMMVvsBiYUmfTO5OelLRIZ1t19PqglcA
	5x73UQqPDaIMOIDh+YQT5zRy6sQiBw4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-8kJv2xFxOOOe_XR__w3zfw-1; Fri,
 01 Aug 2025 04:20:14 -0400
X-MC-Unique: 8kJv2xFxOOOe_XR__w3zfw-1
X-Mimecast-MFC-AGG-ID: 8kJv2xFxOOOe_XR__w3zfw_1754036413
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D7C41800284;
	Fri,  1 Aug 2025 08:20:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2A781800D8E;
	Fri,  1 Aug 2025 08:20:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in header files
Date: Fri,  1 Aug 2025 10:20:05 +0200
Message-ID: <20250801082007.32904-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The kernel Makefiles define the __ASSEMBLY__ macro to provide
a way to use headers in both, assembly and C source code. This is bad
since macros starting with two underscores are names that are reserved
by the C language.
Additionally, all the supported versions of the GCC and Clang compilers
also define the macro __ASSEMBLER__ automatically already when compiling
assembly code, so some kernel headers are using __ASSEMBLER__ instead.
With regards to userspace code, this seems also to be constant source
of confusion, see for example these links here:

 https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/
 https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
 https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
 https://github.com/riscv-software-src/opensbi/issues/199

To avoid confusion in the future, it would make sense to standardize
on the macro that gets defined by the compiler, so this patch series
changes all occurances of __ASSEMBLY__ into __ASSEMBLER__.

I split the patches per architecture to ease the review, and I also
split the uapi headers from the normal ones in case we decide that
uapi needs to be treated differently from the normal headers here.

Many other architecture maintainers already merged the patches, e.g.
the x86, parisc and sh patches already got merged via their specific
architecture tree:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24a295e4ef1ca8
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a141be3233af7
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cccaea1d66e94b
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e2b6a188625a2b
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cc646950eefda

So I assume the powerpc patches should go via the powerpc tree.

v3:
- Improved the patch descriptions a little bit

Thomas Huth (2):
  powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
  powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

 arch/powerpc/boot/page.h                           |  2 +-
 arch/powerpc/include/asm/asm-const.h               |  2 +-
 arch/powerpc/include/asm/barrier.h                 |  2 +-
 arch/powerpc/include/asm/book3s/32/kup.h           |  4 ++--
 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |  8 ++++----
 arch/powerpc/include/asm/book3s/32/pgtable.h       | 12 ++++++------
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash.h          |  4 ++--
 arch/powerpc/include/asm/book3s/64/kup.h           |  6 +++---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      | 12 ++++++------
 arch/powerpc/include/asm/book3s/64/mmu.h           |  8 ++++----
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |  4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 10 +++++-----
 arch/powerpc/include/asm/book3s/64/radix.h         |  8 ++++----
 arch/powerpc/include/asm/book3s/64/slice.h         |  4 ++--
 arch/powerpc/include/asm/bug.h                     | 14 +++++++-------
 arch/powerpc/include/asm/cache.h                   |  4 ++--
 arch/powerpc/include/asm/cpu_has_feature.h         |  4 ++--
 arch/powerpc/include/asm/cpuidle.h                 |  2 +-
 arch/powerpc/include/asm/cputable.h                |  8 ++++----
 arch/powerpc/include/asm/cputhreads.h              |  4 ++--
 arch/powerpc/include/asm/dcr-native.h              |  4 ++--
 arch/powerpc/include/asm/dcr.h                     |  4 ++--
 arch/powerpc/include/asm/epapr_hcalls.h            |  4 ++--
 arch/powerpc/include/asm/exception-64e.h           |  2 +-
 arch/powerpc/include/asm/exception-64s.h           |  6 +++---
 arch/powerpc/include/asm/extable.h                 |  2 +-
 arch/powerpc/include/asm/feature-fixups.h          |  6 +++---
 arch/powerpc/include/asm/firmware.h                |  4 ++--
 arch/powerpc/include/asm/fixmap.h                  |  4 ++--
 arch/powerpc/include/asm/ftrace.h                  |  8 ++++----
 arch/powerpc/include/asm/head-64.h                 |  4 ++--
 arch/powerpc/include/asm/hvcall.h                  |  4 ++--
 arch/powerpc/include/asm/hw_irq.h                  |  4 ++--
 arch/powerpc/include/asm/interrupt.h               |  4 ++--
 arch/powerpc/include/asm/irqflags.h                |  2 +-
 arch/powerpc/include/asm/jump_label.h              |  2 +-
 arch/powerpc/include/asm/kasan.h                   |  4 ++--
 arch/powerpc/include/asm/kdump.h                   |  4 ++--
 arch/powerpc/include/asm/kexec.h                   |  4 ++--
 arch/powerpc/include/asm/kgdb.h                    |  4 ++--
 arch/powerpc/include/asm/kup.h                     |  8 ++++----
 arch/powerpc/include/asm/kvm_asm.h                 |  2 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h          |  6 +++---
 arch/powerpc/include/asm/kvm_booke_hv_asm.h        |  4 ++--
 arch/powerpc/include/asm/lv1call.h                 |  4 ++--
 arch/powerpc/include/asm/mmu.h                     |  8 ++++----
 arch/powerpc/include/asm/mpc52xx.h                 | 12 ++++++------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h       |  4 ++--
 arch/powerpc/include/asm/nohash/32/mmu-44x.h       |  4 ++--
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h       |  4 ++--
 arch/powerpc/include/asm/nohash/32/pgtable.h       | 12 ++++++------
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  2 +-
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h    |  8 ++++----
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  4 ++--
 arch/powerpc/include/asm/nohash/kup-booke.h        |  4 ++--
 arch/powerpc/include/asm/nohash/mmu-e500.h         |  4 ++--
 arch/powerpc/include/asm/nohash/pgtable.h          |  6 +++---
 arch/powerpc/include/asm/nohash/pte-e500.h         |  4 ++--
 arch/powerpc/include/asm/opal-api.h                |  4 ++--
 arch/powerpc/include/asm/opal.h                    |  4 ++--
 arch/powerpc/include/asm/page.h                    | 14 +++++++-------
 arch/powerpc/include/asm/page_32.h                 |  4 ++--
 arch/powerpc/include/asm/page_64.h                 |  4 ++--
 arch/powerpc/include/asm/pgtable.h                 |  8 ++++----
 arch/powerpc/include/asm/ppc_asm.h                 |  4 ++--
 arch/powerpc/include/asm/processor.h               |  8 ++++----
 arch/powerpc/include/asm/ptrace.h                  |  6 +++---
 arch/powerpc/include/asm/reg.h                     |  6 +++---
 arch/powerpc/include/asm/reg_booke.h               |  4 ++--
 arch/powerpc/include/asm/reg_fsl_emb.h             |  4 ++--
 arch/powerpc/include/asm/setup.h                   |  4 ++--
 arch/powerpc/include/asm/smp.h                     |  4 ++--
 arch/powerpc/include/asm/spu_csa.h                 |  4 ++--
 arch/powerpc/include/asm/synch.h                   |  4 ++--
 arch/powerpc/include/asm/thread_info.h             |  8 ++++----
 arch/powerpc/include/asm/tm.h                      |  4 ++--
 arch/powerpc/include/asm/types.h                   |  4 ++--
 arch/powerpc/include/asm/unistd.h                  |  4 ++--
 arch/powerpc/include/asm/vdso.h                    |  6 +++---
 arch/powerpc/include/asm/vdso/getrandom.h          |  4 ++--
 arch/powerpc/include/asm/vdso/gettimeofday.h       |  4 ++--
 arch/powerpc/include/asm/vdso/processor.h          |  4 ++--
 arch/powerpc/include/asm/vdso/vsyscall.h           |  4 ++--
 arch/powerpc/include/asm/vdso_datapage.h           |  6 +++---
 arch/powerpc/include/uapi/asm/opal-prd.h           |  4 ++--
 arch/powerpc/include/uapi/asm/ptrace.h             | 12 ++++++------
 arch/powerpc/include/uapi/asm/types.h              |  4 ++--
 arch/powerpc/kernel/head_booke.h                   |  4 ++--
 arch/powerpc/net/bpf_jit.h                         |  2 +-
 arch/powerpc/platforms/powernv/subcore.h           |  4 ++--
 arch/powerpc/xmon/xmon_bpts.h                      |  4 ++--
 .../selftests/powerpc/include/instructions.h       |  2 +-
 94 files changed, 240 insertions(+), 240 deletions(-)

-- 
2.50.1


