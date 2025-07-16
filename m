Return-Path: <linux-kernel+bounces-733834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47741B079A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8A27BAF04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6DE2F5098;
	Wed, 16 Jul 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmkuWvqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D072F4A05
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679284; cv=none; b=SJISILRKU2pPDjj6AT5+qPzLiQ3tCCSNr+yMM1AyehLI8zwNbEn97BuPQakeKwF26tulAgcFSDz8lZrB06SjcTHnNbQ6ffUiYJAHzbuToQ0R36dXLMERJ8zgSSaWyjtbQQ8xiL9hGGnXrA1xQLrXO53N4ROg4ytxfyA0Qc9fJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679284; c=relaxed/simple;
	bh=N9DR2XoFU8LJ40xmBBEoBU+ULNUrw05MSwSTwA269Vw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WDtYXHGZkPO4KKrgwzTaFC4Rk3VnjCZMeupXSNhM3Fd+I9YJiQ7hVlDVsObPboulweyEZajrxQXc2rwq2xiuoARJ86IXPJSLdrUm5u/8yq1Vfcl5EhDPlz70RROnPV9BR278KOVGOHgCHhWvJuQnM/Eey34zCPfTRokVpvDaMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmkuWvqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E49C4CEF4;
	Wed, 16 Jul 2025 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679283;
	bh=N9DR2XoFU8LJ40xmBBEoBU+ULNUrw05MSwSTwA269Vw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmkuWvqLDRyRSNj9dulYvxOc08DmdmzpwoJID//N3AjazJZ5+3yihVYJWly9foRm1
	 pY+kagnCLWU5FkldusKOaJmutDjZLVDbmKDaOK0EU+L1NWR3iVZKWsyEKLR00qbaBQ
	 DGCOL48W401QoXZEsTwlaYRpwzSqXBcgpQ+/5u347J6a8wZ1VXoaRiJuek3fVONzCu
	 fYtcADOp90PCiI43k5jsD6Detk2zD12p+XpVjB4veJrO1Il8bXiOAEw3yeaZ/VtFHh
	 10KIPvNIeKqqaTfmdv7/LVyQmu3qjMGKYbtmETulyzOHcS8N/+LQ0NqROfAmMk5u1g
	 dMl6YmZV1e8Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE772383BA33;
	Wed, 16 Jul 2025 15:21:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] mm/rmap: make folio unmap batching safe and support
 partial batches
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175267930360.1224517.58776217215607423.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 15:21:43 +0000
References: <20250627025214.30887-1-lance.yang@linux.dev>
In-Reply-To: <20250627025214.30887-1-lance.yang@linux.dev>
To: Lance Yang <ioworker0@gmail.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org,
 huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 mingzhe.yang@ly.com, baohua@kernel.org, lance.yang@linux.dev

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 27 Jun 2025 10:52:14 +0800 you wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> can read past the end of a PTE table if a large folio is mapped starting at
> the last entry of that table.
> 
> So let's fix the out-of-bounds read by refactoring the logic into a new
> helper, folio_unmap_pte_batch().
> 
> [...]

Here is the summary with links:
  - [1/1] mm/rmap: make folio unmap batching safe and support partial batches
    https://git.kernel.org/riscv/c/ddd05742b45b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



