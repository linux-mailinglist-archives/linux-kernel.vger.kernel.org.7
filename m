Return-Path: <linux-kernel+bounces-808444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA35B4FFCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3314A4E2295
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACA350826;
	Tue,  9 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOdIY1Bv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2044A07
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429077; cv=none; b=T5AZh/xX56LF33PJ1Vf6xpk6F7kAQ5e8gJRVr+N44H5w1x0ShsTN6ywNdjJL/FS2XLJZw1czYtXe+YB2SVQDQ4oXBhbhoHChoXP+SxtARFKb0m/Bh2CgDkPq7tgSuZSe9F/i2pTNxzsg1qSFchlOkdpW46HivA/rRzpxfgUau2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429077; c=relaxed/simple;
	bh=gr1qOquHmGnAq/jY71lVBf8+IAgpqOxYBEJiNJgw11k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/ChPg9hndO0JC3Z87Jfe2Q33jaBqBK4hBH74VDprXXZtVTqz4HQ0R6sF0yPpPicoykkgZxbtmkfc5jfPnzb65MAAMl2uhKVAgj4tnfkYsPvsjMAbd382UaiBcRzM4TC1El6WELiwF/QOzzV5R1J9Xh1yt9ZlQB+jZNe/aPjlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOdIY1Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0B7C4CEF4;
	Tue,  9 Sep 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429077;
	bh=gr1qOquHmGnAq/jY71lVBf8+IAgpqOxYBEJiNJgw11k=;
	h=From:To:Cc:Subject:Date:From;
	b=XOdIY1Bvtm5/HQ3Iyd6I4zi6z1teXURtfIj2qsCbBwJ/B1fq91940d14ku6nZXAvy
	 FGHtQINugOPSfPhRObkdKVa9fSZ6opE3H8hSg786egjE+xrPstMsKjm23QyM28TiAu
	 7WW5PZEasI6WKDsH7p2byHV6ODIq2pMKA2+HSAINeyH+Gg7K61cbc8Cltw9+HxvspL
	 PKOhjeQB3g63ev+XnJvDNQnHq3RAVyh5EySucVBhOU5M55Yo0XArUFsuWYZFZktJ9n
	 kIShKdzJCeqyf5m/Nxt02v/gGZkoEs9q7wJC03XHc6IT3Ss5CMrghedNAemAk1gy5O
	 QEZy1m3N9IiVg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] kho: introduce the KHO array
Date: Tue,  9 Sep 2025 16:44:20 +0200
Message-ID: <20250909144426.33274-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces the KHO array concept, and to demonstrate it in action it
converts the perservation bitmaps to use it. It also takes Mike's vmalloc
preservation patches v2 [0] and ports them to use the KHO array as well. The
memfd preservation proposed in [1] can also be a user of this.

The main idea behind the KHO array is to build fundamental and flexible
serialization data structures that other layers can use to make their logic
easier. There was extensive discussion on this topic in [1]. This series
provides actual code in action to give more substance to that discussion.

Patch 1 adds the KHO array. Read it for more details on the data structure.
Patch 2 converts the memory preservation bitmaps to use KHO array. Patches 3 and
4 are from Mike's vmalloc series [0] and are modified to use KHO array instead
of open-coding the linked lists. The full git tree can be found at [2].

When converting the two users to the KHO array, I think it did make the
serialization logic simpler for both. The actual judgement of whether this is
"worth it" is of course subjective, but I think this should at least give
everyone a clear idea of how it looks like.

[0] https://lore.kernel.org/linux-mm/20250905131302.3595582-1-rppt@kernel.org/T/#u
[1] https://lore.kernel.org/linux-mm/20250807014442.3829950-30-pasha.tatashin@soleen.com/T/#u
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/tag/?h=kho-array-rfc-v1

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in
    fdt

Pratyush Yadav (2):
  kho: introduce the KHO array
  kho: use KHO array for preserved memory bitmap serialization

 MAINTAINERS                    |   2 +
 include/linux/kexec_handover.h |  21 +++
 include/linux/kho_array.h      | 300 +++++++++++++++++++++++++++++++++
 kernel/Makefile                |   1 +
 kernel/kexec_handover.c        | 291 +++++++++++++++++++++++---------
 kernel/kho_array.c             | 209 +++++++++++++++++++++++
 lib/test_kho.c                 |  30 +++-
 7 files changed, 768 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/kho_array.h
 create mode 100644 kernel/kho_array.c


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.47.3


