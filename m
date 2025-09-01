Return-Path: <linux-kernel+bounces-794075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CAB3DC88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FA817D0F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6732FAC18;
	Mon,  1 Sep 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSayuxF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142752FB99F;
	Mon,  1 Sep 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715671; cv=none; b=fIn6mBJVCpHzmhrcUv+z3yDH4Bue1xEAa9NQw6rOGXKUKOmErnnwuLm6mUCoTOU2lP5c8wrMqb6jOOlNwhRikmdILq4x2OBuSyBDS4efVp2ddbTk643GqwAOSMo3Xk9B+0gctJWiOB5nPZ9L30HUT+UGXUDkWXkThtR+mbHrLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715671; c=relaxed/simple;
	bh=YniABXTMehUmrQNyxrnxV6TCLO8GP4oi7+6p/ouGAZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVaM0aJaUvTOG0qGf2Tu03CXkzFbzuVISaqkXqy5LwpQuUGhyTawelEhbzzEwtQ0riHKX9jf/ZyuUZSeO9RmkVCykurAwVjpO1dUmfOvd+mbgBivlBt+vYvB9gwE+4a+4eZSzqWbjkPNZelvor+b/4D4GgQWvXcrdilxHWM6u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSayuxF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34389C4CEF4;
	Mon,  1 Sep 2025 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756715670;
	bh=YniABXTMehUmrQNyxrnxV6TCLO8GP4oi7+6p/ouGAZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=fSayuxF+wbFCiWZEBOUbqBm+UQcn47oEm7NsLj08ek+p9jMmQvyzqYzjypmRmiK15
	 r7F/+n5PoNJbRo2vag6G4CjffX0MWC6AacU1Zj8wOXfmeK7uLCerqcqHD7BJl8nnUZ
	 bSUZh8CJItd8xbAbt069DRXV3+ET6D/dNEDf/y+bJFvXv+IN4LBOglsgIht7e1/MqK
	 El2Mt85kX1XTMz1cUS6M3kngnw7N3fvyVf7SKcxYpuDRLtaUDvk+m7crTBb5j4QsHI
	 mV/LCqvIJxksn0Ohexg/0LNLGYqkJH8bmyIm0dVnytqm0w3SsiKuF47zBnMNk1k0aQ
	 I5TjNUc//phrA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 0/4] mm/mm_init: simplify deferred init of struct pages
Date: Mon,  1 Sep 2025 11:34:19 +0300
Message-ID: <20250901083423.3061349-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches simplify deferred initialization of the memory map.

Beside nice negative diffstat I measured 3ms (55ms vs 58ms) reduction in
the initialization of deferred pages on single node system with 64GiB of
RAM.

I don't have access to large memory machines, so I'd really appreciate
testing of these patches on them to make sure there's no regression there.

v2 changes: 
* fix "sleeping function called from invalid context" bug reported by
kbuild:
https://lore.kernel.org/all/202508251443.f2d9f77f-lkp@intel.com

v1: https://lore.kernel.org/all/20250818064615.505641-1-rppt@kernel.org

I pushed the patches to memblock tree for wider testing.
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/log/?h=for-next

Mike Rapoport (Microsoft) (4):
  mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
  mm/mm_init: deferred_init_memmap: use a job per zone
  mm/mm_init: drop deferred_init_maxorder()
  memblock: drop for_each_free_mem_pfn_range_in_zone_from()

 .clang-format            |   1 -
 include/linux/memblock.h |  22 -----
 mm/memblock.c            |  64 -------------
 mm/mm_init.c             | 197 +++++++++++++--------------------------
 4 files changed, 65 insertions(+), 219 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.50.1


