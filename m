Return-Path: <linux-kernel+bounces-764788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBEB2275C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7694E1A25E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9825C706;
	Tue, 12 Aug 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj4cGhxE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A123B627
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003001; cv=none; b=NMIhltHA1nZ5hty7wBsElmGDMEaljizsGceOK0G2SmCa/edLpnon6ogNAGchWeGJdU4QWatbfSz/Y7grImM7AGqKxy8uN8Xdo2y+O63tBIdtta2oRvt5DD9f0zfft/71qjZkGqmzChU03KIbk27ZY+amTFaoFXbd7jYIClQ+IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003001; c=relaxed/simple;
	bh=3RquuvcTmFUlX6uOMPWGwfEdEt01Ni6UgRw12eOQ5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=hp9GiDRETPmOSu+2ufLv2aOCm8Wxh3pLcQvrF7zxP9pY0LO4HXFvDG3BDbNxTuns/7TGKRP5wAqt4dGMKETHl+7MzvRRykSK78V+tsbr+G+Emf1G7GyaoKIGeCf3EnzajLF1EeVZAxTxAPyFgBqFcUn/rWZNsxdYPEypYGuUAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj4cGhxE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755002998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ZE38hmpc99A2k7OXVLbkRVM4tCEFDqNHUDB9CwwXLA=;
	b=Aj4cGhxE/tt1ZU/OInmkiEEcafnQVLvt4r4jehTweFXaFbLdX7/+Tff0WkmnLsCtEU6rcx
	FZZO3SUeJA4YfKscjycW9FpPBDsuKpzOw5fobPuenLU3alkz5HXTQ2FW87SaF+2Gt+Wcnq
	DQvy+movEiaazCnox0r6/OgM9/v69tY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-o8yLrza-Pk6ODkq5WeTjFQ-1; Tue,
 12 Aug 2025 08:49:55 -0400
X-MC-Unique: o8yLrza-Pk6ODkq5WeTjFQ-1
X-Mimecast-MFC-AGG-ID: o8yLrza-Pk6ODkq5WeTjFQ_1755002993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3BB119560AF;
	Tue, 12 Aug 2025 12:49:51 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCF6730001A1;
	Tue, 12 Aug 2025 12:49:44 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
Date: Tue, 12 Aug 2025 20:49:29 +0800
Message-ID: <20250812124941.69508-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently only hw_tags mode of kasan can be enabled or disabled with
kernel parameter kasan=on|off for built kernel. For kasan generic and
sw_tags mode, there's no way to disable them once kernel is built.
This is not convenient sometime, e.g in system kdump is configured.
When the 1st kernel has KASAN enabled and crash triggered to switch to
kdump kernel, the generic or sw_tags mode will cost much extra memory
for kasan shadow while in fact it's meaningless to have kasan in kdump
kernel.

So this patchset moves the kasan=on|off out of hw_tags scope and into
common code to make it visible in generic and sw_tags mode too. Then we
can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
kasan.

Changelog:
====
v1->v2:
- Add __ro_after_init for __ro_after_init, and remove redundant blank
  lines in mm/kasan/common.c. Thanks to Marco.
- Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
  this is found out by SeongJae and Lorenzo, and also reported by LKP
  report, thanks to them.
- Add a missing kasan_enabled() checking in kasan_report(). This will
  cause below KASAN report info even though kasan=off is set:
     ==================================================================
     BUG: KASAN: stack-out-of-bounds in tick_program_event+0x130/0x150
     Read of size 4 at addr ffff00005f747778 by task swapper/0/1
     
     CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #8 PREEMPT(voluntary) 
     Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
     Call trace:
      show_stack+0x30/0x90 (C)
      dump_stack_lvl+0x7c/0xa0
      print_address_description.constprop.0+0x90/0x310
      print_report+0x104/0x1f0
      kasan_report+0xc8/0x110
      __asan_report_load4_noabort+0x20/0x30
      tick_program_event+0x130/0x150
      ......snip...
     ==================================================================

- Add jump_label_init() calling before kasan_init() in setup_arch() in these
  architectures: xtensa, arm. Because they currenly rely on
  jump_label_init() in main() which is a little late. Then the early static
  key kasan_flag_enabled in kasan_init() won't work.

- In UML architecture, change to enable kasan_flag_enabled in arch_mm_preinit()
  because kasan_init() is enabled before main(), there's no chance to operate
  on static key in kasan_init().

Test:
=====
In v1, I took test on x86_64 for generic mode, and on arm64 for
generic, sw_tags and hw_tags mode. All of them works well.

In v2, I only tested on arm64 for generic, sw_tags and hw_tags mode, it
works. For powerpc, I got a BOOK3S/64 machine, while it says
'KASAN not enabled as it requires radix' and KASAN is disabled. Will
look for other POWER machine to test this.
====

Baoquan He (12):
  mm/kasan: add conditional checks in functions to return directly if
    kasan is disabled
  mm/kasan: move kasan= code to common place
  mm/kasan/sw_tags: don't initialize kasan if it's disabled
  arch/arm: don't initialize kasan if it's disabled
  arch/arm64: don't initialize kasan if it's disabled
  arch/loongarch: don't initialize kasan if it's disabled
  arch/powerpc: don't initialize kasan if it's disabled
  arch/riscv: don't initialize kasan if it's disabled
  arch/x86: don't initialize kasan if it's disabled
  arch/xtensa: don't initialize kasan if it's disabled
  arch/um: don't initialize kasan if it's disabled
  mm/kasan: make kasan=on|off take effect for all three modes

 arch/arm/kernel/setup.c                |  6 +++++
 arch/arm/mm/kasan_init.c               |  6 +++++
 arch/arm64/mm/kasan_init.c             |  7 ++++++
 arch/loongarch/mm/kasan_init.c         |  5 ++++
 arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
 arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
 arch/riscv/mm/kasan_init.c             |  6 +++++
 arch/um/kernel/mem.c                   |  6 +++++
 arch/x86/mm/kasan_init_64.c            |  6 +++++
 arch/xtensa/kernel/setup.c             |  1 +
 arch/xtensa/mm/kasan_init.c            |  6 +++++
 include/linux/kasan-enabled.h          | 18 ++++++-------
 mm/kasan/common.c                      | 25 ++++++++++++++++++
 mm/kasan/generic.c                     | 20 +++++++++++++--
 mm/kasan/hw_tags.c                     | 35 ++------------------------
 mm/kasan/init.c                        |  6 +++++
 mm/kasan/quarantine.c                  |  3 +++
 mm/kasan/report.c                      |  4 ++-
 mm/kasan/shadow.c                      | 23 ++++++++++++++++-
 mm/kasan/sw_tags.c                     |  9 +++++++
 21 files changed, 165 insertions(+), 47 deletions(-)

-- 
2.41.0


