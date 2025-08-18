Return-Path: <linux-kernel+bounces-772976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8BB29A02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC833A5766
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E7277C82;
	Mon, 18 Aug 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Ak7vcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB22701D2;
	Mon, 18 Aug 2025 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499583; cv=none; b=AiruCoScZ8iCB7ORYYRI7jeNaqGeSSsEZ/EgthKm7eDc6IHF4bbEAAzKsBxa3EKpg4gMY25DQD1U+afmbYnMKOeB2P4flT31FtFeY7sUvpr6g8gWFtSzwK/kDx09bpIValztm4c1aeglKPwmZnS6lcawnc1lQqvQ1YIZzKrp4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499583; c=relaxed/simple;
	bh=k4wONO4GgkZMYhiVNRn+Rqnc6LMhXUM48Phy2bxQxHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrNDebXwucguuop9Vos1a4V0qBC/yidd89dHwNewK98BgtsJOTo/At/fZ5bdzZQxgAwOVgreNfPzAIJoCSiOVdhxObYKMQ1DUKVKfsTwpOjWKxVJukGBzWZCG6Jum0mJplqe9JGiQI9vuzAxqaGJWJtcbtJvWUO16QSr2pDE1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Ak7vcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A80C4CEEB;
	Mon, 18 Aug 2025 06:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755499582;
	bh=k4wONO4GgkZMYhiVNRn+Rqnc6LMhXUM48Phy2bxQxHI=;
	h=From:To:Cc:Subject:Date:From;
	b=B4Ak7vcNjHcl3W8hAbH6xBZ+wbLYCOfqkG60Sdu897lVLfK1LXXnhUht3bRC4Jq8P
	 VEChPSyBLxM4RgEv0aekhlDJYA9jDa/WWebABA4qnklv7rnhxQZPv6bYXoCNLCQDdY
	 UBa0ZeOXdAhEfKiUkIgfC/SPPiEujZxxLi2wbNScw1IH4IC5/qe6Ccxkrnmcwc7hhw
	 I30DdRoCb+xuoQTTCRDtt5H3Fp80+vUsRniIX1GqzD5rphLKbUYBiu5nbz8Wu6HVfN
	 2FjqOQg7nL/R60MEq/tmHX/SZqcdwRHB87q7lJfEEMIRJTnmAU/Hs4NJxJ0ygInlrI
	 546Z0BC7FB3ZA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/4] mm/mm_init: simplify deferred init of struct pages
Date: Mon, 18 Aug 2025 09:46:11 +0300
Message-ID: <20250818064615.505641-1-rppt@kernel.org>
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

Beside nice negative diffstat I measured 3ms reduction in the
initialization of deferred pages on single node system with 64GiB of RAM.

I don't have access to large memory machines, so I'd really appreciate
testing of these patches on them to make sure there's no regression there.

The patches are also available at git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=deferred-memmap-init/v1

Mike Rapoport (Microsoft) (4):
  mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
  mm/mm_init: deferred_init_memmap: use a job per zone
  mm/mm_init: drop deferred_init_maxorder()
  memblock: drop for_each_free_mem_pfn_range_in_zone_from()

 .clang-format            |   1 -
 include/linux/memblock.h |  22 -----
 mm/memblock.c            |  64 -------------
 mm/mm_init.c             | 195 +++++++++++++--------------------------
 4 files changed, 62 insertions(+), 220 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


