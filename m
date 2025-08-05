Return-Path: <linux-kernel+bounces-755968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C29B1AE2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E3A3AB8F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01F21A94F;
	Tue,  5 Aug 2025 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTm92kw5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C257186294
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375030; cv=none; b=rjpcjUShaG2BDF+j8Add/9pPf8VsPUCKQBLeYwb+2oejYt6oTDxDcCpjLa0j2BX4bWDqecMY52I/vn9nTnidvaKCzG6qbYskFtHIlIl3ZC9aY0gcfkeM+7KWIyXRiVX9Sa/b9zim622Shdm1ZvNdFLuF8QQEP7NSrDDvKDpIGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375030; c=relaxed/simple;
	bh=HEPYGvI1vk3cetbRLjPfD2HI7d3WgP0RuNbGbhuWcX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=RmnYwfvXlmPPoWDaWeeEv0o2fcdZvhSppWSiTHPfAUYrrtA1t+E1QY6BzrTQbZDuE6/gb+dA7q+CtxumkyDOUETsnd/BzHC5Y7zMC4ENgwqHVM0ihVMaC1DF2m+pfNK7L2dNYibHbnJLmeeWDONxg09qCRz2kCiUBXaeF1gkDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTm92kw5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754375027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YSXKdaD3IZAs8uieY7LPn8yhD3PkW5u9fBN/Is1bw+s=;
	b=eTm92kw5ySyzMtRHOyf9QLC4RimZyRy3gIWPMGnX+6p2dFAaHUn1NpobeGcvqdgcLqNEn1
	9yDN/5NtP8/Kmyn+KbkfePu6D/e1wu5moJnIPmuGZnVBPCq00lZEclnL+WtdJrFrPFnVJp
	KSAf0ek56MhHNBo9pnEQbtNb+ARFW4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-L51CUMXUOgaWzMV0lMozWg-1; Tue,
 05 Aug 2025 02:23:44 -0400
X-MC-Unique: L51CUMXUOgaWzMV0lMozWg-1
X-Mimecast-MFC-AGG-ID: L51CUMXUOgaWzMV0lMozWg_1754375023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D3CD180045C;
	Tue,  5 Aug 2025 06:23:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AF5F1956094;
	Tue,  5 Aug 2025 06:23:36 +0000 (UTC)
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
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
Date: Tue,  5 Aug 2025 14:23:29 +0800
Message-ID: <20250805062333.121553-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Test:
=====
I only took test on x86_64 for generic mode, and on arm64 for
generic, sw_tags and hw_tags mode. All of them works well.

However when I tested sw_tags on a HPE apollo arm64 machine, it always
breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug 
can always be seen too.

"BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"

I haven't got root cause of the bug, will report the bug later in
another thread.
====

Baoquan He (4):
  mm/kasan: add conditional checks in functions to return directly if
    kasan is disabled
  mm/kasan: move kasan= code to common place
  mm/kasan: don't initialize kasan if it's disabled
  mm/kasan: make kasan=on|off take effect for all three modes

 arch/arm/mm/kasan_init.c               |  6 +++++
 arch/arm64/mm/kasan_init.c             |  7 ++++++
 arch/loongarch/mm/kasan_init.c         |  5 ++++
 arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
 arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
 arch/riscv/mm/kasan_init.c             |  6 +++++
 arch/um/kernel/mem.c                   |  6 +++++
 arch/x86/mm/kasan_init_64.c            |  6 +++++
 arch/xtensa/mm/kasan_init.c            |  6 +++++
 include/linux/kasan-enabled.h          | 11 ++------
 mm/kasan/common.c                      | 27 ++++++++++++++++++++
 mm/kasan/generic.c                     | 20 +++++++++++++--
 mm/kasan/hw_tags.c                     | 35 ++------------------------
 mm/kasan/init.c                        |  6 +++++
 mm/kasan/quarantine.c                  |  3 +++
 mm/kasan/shadow.c                      | 23 ++++++++++++++++-
 mm/kasan/sw_tags.c                     |  9 +++++++
 18 files changed, 150 insertions(+), 46 deletions(-)

-- 
2.41.0


