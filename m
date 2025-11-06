Return-Path: <linux-kernel+bounces-889412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BBFC3D802
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38FB54E4EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E3306D3D;
	Thu,  6 Nov 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EB4I/SS2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFD2DF14A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464563; cv=none; b=CDLpLK0SeJl5q+oneYzHrr1h7QR8g5tpCupix5E2+vxg8EEHnSIpYtR9EulfRFdUDjQb3q92M4dKyk/HXppvpdxewOewFtFRpgA1Zjz0aoB4hG8lG6HJL7MxkgQWpRTiisV3i2Zd0LjX3I3KS+OY22x9q1dCVCVGJGZ4WDLb/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464563; c=relaxed/simple;
	bh=fmMPx+nIE9R0eDvKMK0buO9dC4R4qwFjkjuZ9muvTuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPrdTbi7dFyeJS0agODj2PjN95U/gaG6caoWxXZWVCItJgQUk68N/QSmDw5gbBQtnCvWgAAA9AllHYQWnxgxKCa4xorVetKSibGXjcO+OFPomMmkPWCtLDbg2IfdwUXeQ6szT876/Te2Zls/Vfokksm/gYm875eEVqLyjZOg0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EB4I/SS2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bfwhX0idL+jcT4fehCnbdNH5+2W0J91n2IFBGm3eZ6c=;
	b=EB4I/SS2HQOHNlA6VzIfesqrhMk7WHiqMgi/daeESRsG1Imi+/iCFIivoQMoKj03OkG8+w
	oAgLSrOnes430o2/5KeD75Z9l+7Y+pj+wBc8ABSA7oyJHbjEPZHSxvfNtrGO0uoV2WyHm2
	Rf/F6iUyoc3+tOn60CHp+KIAdok79jM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-iBqmsrqeMyW0bHI0o7um3Q-1; Thu,
 06 Nov 2025 16:29:16 -0500
X-MC-Unique: iBqmsrqeMyW0bHI0o7um3Q-1
X-Mimecast-MFC-AGG-ID: iBqmsrqeMyW0bHI0o7um3Q_1762464555
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4A801956063;
	Thu,  6 Nov 2025 21:29:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F25819560A7;
	Thu,  6 Nov 2025 21:29:13 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 00/10] mm: thp: always enable mTHP support
Date: Thu,  6 Nov 2025 16:28:47 -0500
Message-ID: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Today, if an architecture implements has_transparent_hugepage() and the CPU
lacks support for PMD-sized pages, the THP code disables all THP, including
mTHP support. In addition, the kernel lacks a well defined API to check for
PMD-sized page support. It currently relies on has_transparent_hugepage()
and thp_disabled_by_hw(), but they are not well defined and are tied to
THP support.

This series addresses both issues by introducing a new well defined API
to query PMD-sized page support: pgtable_has_pmd_leaves(). Using this
new helper, we ensure that mTHP remains enabled even when the
architecture or CPU doesn't support PMD-sized pages.

An important detail is that we need to do the same refactoring for
has_transparent_pud_hugepage(). I actually have patches for this one
too, I'm not including them here because I want to get some initial
feedback on the general approach first (and maybe it's better to
do that in a separate series).

Thanks to David Hildenbrand for suggesting this improvement and for
providing guidance (all bugs and misconcentpions are mine).

Luiz Capitulino (10):
  docs: tmpfs: remove implementation detail reference
  mm: introduce pgtable_has_pmd_leaves()
  drivers: dax: use pgtable_has_pmd_leaves()
  drivers: i915 selftest: use pgtable_has_pmd_leaves()
  drivers: nvdimm: use pgtable_has_pmd_leaves()
  mm: debug_vm_pgtable: use pgtable_has_pmd_leaves()
  treewide: rename has_transparent_hugepage() to arch_has_pmd_leaves()
  mm: replace thp_disabled_by_hw() with pgtable_has_pmd_leaves()
  mm: thp: always enable mTHP support
  mm: thp: x86: cleanup PSE feature bit usage

 Documentation/filesystems/tmpfs.rst           |  5 ++---
 arch/mips/include/asm/pgtable.h               |  4 ++--
 arch/mips/mm/tlb-r4k.c                        |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 10 +++++-----
 arch/powerpc/include/asm/book3s/64/radix.h    |  2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 ++--
 arch/s390/include/asm/pgtable.h               |  4 ++--
 arch/x86/include/asm/pgtable.h                |  6 ------
 arch/x86/include/asm/pgtable_32.h             |  6 ++++++
 drivers/dax/dax-private.h                     |  2 +-
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
 drivers/nvdimm/pfn_devs.c                     |  4 ++--
 include/linux/huge_mm.h                       |  7 -------
 include/linux/pgtable.h                       | 14 +++++++++++--
 mm/debug_vm_pgtable.c                         | 20 +++++++++----------
 mm/huge_memory.c                              | 13 ++++++------
 mm/memory.c                                   | 12 ++++++++++-
 mm/shmem.c                                    |  8 ++++----
 20 files changed, 72 insertions(+), 59 deletions(-)

-- 
2.51.1


