Return-Path: <linux-kernel+bounces-730035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13449B03F70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCD51A62582
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58021251792;
	Mon, 14 Jul 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecA91RjH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B4221F29
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499040; cv=none; b=bp++48lQxi51JKt9atQVFxPJZ8jgxHM08yGON/sebSw50JW8XiTOooHgexvcO0pnW9Zh85kpnLdxWvuyH5W20N09o+5Ropzuum6Obgjnn9iUftYiuYWai4b5+VMp/jX3O0exdj108lDtFFScmi+w2y0cGgX/fMwlZ//1p2UP1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499040; c=relaxed/simple;
	bh=BMO+ID1Ro8tp+ejLK0HPFiChgc8oLeZ+pXCxeheX3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuKAFWbXT4NPqeNn4zJ6BF5apWEc0U+DY+3K4pE1AJrltjGfnVMMLlyM7487AlKDnvGoHqWiyc2tqT9Ga9bgtjzkFKZ+QtJYMgpSX3RbNIRCUa228zUUIX/DJ2CFdZWNfxd7nxh8xN6lg8Y7DcJv42/jySzh9rNq1kgofPDhgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecA91RjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JpuXpChj0ZpEUckajTyWMrvnlvd0TvK3w9exvlL/95E=;
	b=ecA91RjHV9fCPPYJcoAzQTh/lVXReLTajwQf8G4MdxQLRFE4hQGi0JYpb94JykXV7ErXuu
	N/W6QcqmGGWboCz3uOgkOCT583vBeKpqJ6h/kG4WBcW0ZyeEruIhDZmDWodEUZ6cA+cEJ9
	rWBGOt3/77j1+U2WjTgScnhhlOj00X4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-oYRiNPINObSvP-Ipg2WQ7A-1; Mon,
 14 Jul 2025 09:17:10 -0400
X-MC-Unique: oYRiNPINObSvP-Ipg2WQ7A-1
X-Mimecast-MFC-AGG-ID: oYRiNPINObSvP-Ipg2WQ7A_1752499029
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6920219560A2;
	Mon, 14 Jul 2025 13:17:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59E2D1803AF2;
	Mon, 14 Jul 2025 13:17:06 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org,
	harry.yoo@oracle.com
Subject: [PATCH v3 0/4] mm: introduce snapshot_page()
Date: Mon, 14 Jul 2025 09:16:50 -0400
Message-ID: <cover.1752499009.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi,

The series introduction will follow the changelog. This is against bc9ff192a6c9 .

Changelog
=========

v2 -> v3
  - Small snapshot_page() refactor to simplify and fix stack-out-of-bugs bug
    reported by Harry Yoo
  - Use clear_compound_head() in snapshot_page() (Shivank)
  - Read head pointer from ps->page_snapshot() for tail page case (Shivank)
  - Improve comments and macro name in snapshot_page() (David)

v1 -> v2
  - Include is_huge_zero_pfn() patch and use it (David)
  - Move free page detection to snapshot_page() (David)
  - Changelog improvements (Shivank)
  - Added Acked-bys

RFC -> v1
  - Include <linux/page_idle.h> to avoid build error on sh arch

Introduction
============

This series introduces snapshot_page(), a helper function that can be used
to create a snapshot of a struct page and its associated struct folio.

This function is intended to help callers with a consistent view of a
a folio while reducing the chance of encountering partially updated or
inconsistent state, such as during folio splitting which could lead to
crashes and BUG_ON()s being triggered.

David Hildenbrand (1):
  mm/memory: introduce is_huge_zero_pfn() and use it in
    vm_normal_page_pmd()

Luiz Capitulino (3):
  mm/util: introduce snapshot_page()
  proc: kpagecount: use snapshot_page()
  fs: stable_page_flags(): use snapshot_page()

 fs/proc/page.c          | 50 +++++++++++++++-----------
 include/linux/huge_mm.h | 12 ++++++-
 include/linux/mm.h      | 19 ++++++++++
 mm/debug.c              | 42 +++-------------------
 mm/memory.c             |  2 +-
 mm/util.c               | 79 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 144 insertions(+), 60 deletions(-)

-- 
2.50.0


