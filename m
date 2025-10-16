Return-Path: <linux-kernel+bounces-856779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43023BE50BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059005471E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84211231829;
	Thu, 16 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbFjOPjC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A0229B12
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639077; cv=none; b=FrhEsHxiHMOlIDyCtklvJWtgit8eZC7dE8u82Lz/EyCTLRTT7kuMiXnmFGBpXXLUR1izqiVcYhcravaRcUQQRcXjgejQsjC0r7GasiUmVB2hm244iSOIyVyfdVDkNjH3XMjjYBXIuzuFO1wh719SSuxBnhh63svzIZzbr+ACQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639077; c=relaxed/simple;
	bh=UG4tJ47jBwN6WkEwJhZo8CXkSYUtmUCcVml6zvd2iZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OiHT9/KEXZziNl9zLJeT0/E/Cs6J0R53baMG9PPIdGNdOgQ+yXORiaTASqkEsTtGGpv5ywLJw0ABM7ZPlpHo+ngGF9jH2lZKLJMxiE9gm3TkodUoaWTjwx4NGiMDRLTDkSTOGptW658eHrZzs5Q0PxmM2pZsS/t5uYb2d73QJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbFjOPjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8DBC4CEFB;
	Thu, 16 Oct 2025 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760639076;
	bh=UG4tJ47jBwN6WkEwJhZo8CXkSYUtmUCcVml6zvd2iZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CbFjOPjCpta7jhz0j5nw7ki4tJZgwIm2HdOp8Vc3I+RMND5GzR7KG+wzPz8ISZQ/r
	 VtwLX7VUwtrHm2JJ/wc7nxV2XUAKXDvHb12NMROEjR1d6E3LQLoYCWY+iSibXzVzUi
	 wca3rDVgrJO7bs7GN/onmXfbGu2z7s7g7uHzav6+5xBhqdmU2nyEgmLLjSWDZ9NCPB
	 H3JdbCW/SZCq5h8DcgX5yR5tELu4BN7OpCgDIf7ib5u8MXn41Wstx/qcEHPqFJ3N/A
	 gJ2LARDpT1WG6luh0JnLjZF6ZUxgunylPNcwFYlkNORdlUtodt8KVMdlMDlR1pqRjr
	 opGfsvcku0sEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FCE39B167A;
	Thu, 16 Oct 2025 18:24:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use folio_nr_pages() instead of shift
 operation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176063906099.1852182.14456838329334893039.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 18:24:20 +0000
References: <20251004031217.50242-1-pedrodemargomes@gmail.com>
In-Reply-To: <20251004031217.50242-1-pedrodemargomes@gmail.com>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  4 Oct 2025 00:12:17 -0300 you wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use folio_nr_pages() instead of shift operation
    https://git.kernel.org/jaegeuk/f2fs/c/c9cd50d5aaf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



