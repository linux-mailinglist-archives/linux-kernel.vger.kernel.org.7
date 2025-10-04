Return-Path: <linux-kernel+bounces-841988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E162BBB8B8C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214A24A57A4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522532580F2;
	Sat,  4 Oct 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL4174Ye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FD34BA3F
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759569588; cv=none; b=BDDdVybXEzXbTfrc3AuSfAC7AFXbwgfahA3IS+mrJ9TGIbXQgOJ09FcXIILCTAKnN46x6wi3mHqpfkqmO+1d56YeQxo4oFU6Qd5p7rg/dkPcaIlr9QmpmJjmm0G7oeqgC71x3e80Rs8c1OEXp6XV8gI0CPgN41LMBHbKUyVy3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759569588; c=relaxed/simple;
	bh=KY1sX8OSJOh9C1F2nogtM66uWvTnblV5Te6fP8LKJFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gkg0eU98skcAlzS72qyBMGSlfKjPoxhOZmtABkNtiP36tQE2vxUPfLhft1rMV3J2uFC7p9WMQD+FtUNfznu6yswnrYlLfA5eVMBtODsY/P8hvNNUn9Yosy0FUVnW7HUNsB0+g5UjQEFS9Vsh7oatGH5lZ5W6AXNeUGs37QSy1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL4174Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC9C4CEF1;
	Sat,  4 Oct 2025 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759569588;
	bh=KY1sX8OSJOh9C1F2nogtM66uWvTnblV5Te6fP8LKJFo=;
	h=Date:From:To:Cc:Subject:From;
	b=HL4174YeEnScY90+2h9VljzlObU0qFm2rUj+ciEnAEqj1Bpm6LTXugsyjjnWH4hUP
	 ABdaSUkNiBn7I+XplDfuqNl9MHViaqzZQQeV17Uaxw9CBtGsVHvR/Q69DmMBKcKR0Y
	 ZOCWt0C1yp1vmg0vFRaUkMS9BETe51wzpngZ+kjn02UuQe3J29J4ZVTjyitab7yo97
	 CqatEoXMjJ49mSoGlNYjedIWgDviqNN4nwRkatvc6oHHUTleXx8k8kXrgTmXHHzL5P
	 uRjivTQmhNNRSb2tgPcWHR1RtcVx5ZKhfJ/0eGpn/bbOItFE3EXwM8XhIzxDcq1tNY
	 1DBtf8jNZ3+tg==
Date: Sat, 4 Oct 2025 11:19:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [GIT PULL] mm/mm_init: simplify deferred initialization of struct
 pages
Message-ID: <aODmrlNys5x2LVtl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.18-rc1

for you to fetch changes up to e68f150bc11d0a05cbe984a4e5c0f72a95cae07d:

  memblock: drop for_each_free_mem_pfn_range_in_zone_from() (2025-09-14 08:49:03 +0300)

----------------------------------------------------------------
mm/mm_init: simplify deferred initialization of struct pages

Refactor and simplify deferred initialization of the memory map.

Beside the negative diffstat it gives 3ms (55ms vs 58ms) reduction in the
initialization of deferred pages on single node system with 64GiB of RAM.

----------------------------------------------------------------
Mike Rapoport (Microsoft) (4):
      mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
      mm/mm_init: deferred_init_memmap: use a job per zone
      mm/mm_init: drop deferred_init_maxorder()
      memblock: drop for_each_free_mem_pfn_range_in_zone_from()

 .clang-format            |   1 -
 include/linux/memblock.h |  22 ------
 mm/memblock.c            |  64 ---------------
 mm/mm_init.c             | 197 ++++++++++++++++-------------------------------
 4 files changed, 65 insertions(+), 219 deletions(-)

-- 
Sincerely yours,
Mike.

