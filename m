Return-Path: <linux-kernel+bounces-836844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5EEBAAB40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B913C181E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365923AB8E;
	Mon, 29 Sep 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLynGGpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093026A0D5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185042; cv=none; b=ZWlWHDb8mhSnY7lwTmfFxdVEm5mgu/m+/xRxOSDrY414MRLcFa3wzEEatWOZ6g144uXuqNy1b8sYQ9q1DyKtW8ABBxOD2pYd2n/4xiFf7eDPwltZNFyVdsOqvd/i95Qf2vR4E7Z7aQwSXDHyrDBU4zgGREa7kPilG88Qx7nqYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185042; c=relaxed/simple;
	bh=xr3Vr5z7ZMusZyiO5tXSn9jP46rjLBrsMfvrhvdsjdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdezcIzz9KHBh1zq8d9PpLtKjmYIK2BcJq6MDncLKsEsL3zfjyy5wtLqxfP/DJgFM7MdHGahhmWep2h45Nt4MWz5uypT5oYXG8pppRVLyz0ziVRnu4PronC95oE0l9+hrnnTK82Tv7AgKJooDFlA3EXnEcO3UHzd0G2uV4RHTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLynGGpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4617CC116B1;
	Mon, 29 Sep 2025 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185042;
	bh=xr3Vr5z7ZMusZyiO5tXSn9jP46rjLBrsMfvrhvdsjdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nLynGGpU0zmglCgmg5pTp0iBcQyHEZE7hrJlXI2XnpfRf4zeGePfubwXpBsA0KaWE
	 UHXB0DCWLkp3P4MGbKSMOOG5v58V3X9IhYrw2Yjbhmv5B6Nn/mihxRurZmVc5PJt6G
	 q3wqb52LtyfMFW0hYuJSltXfmq6pKlOBSD/YgjJbnjKx+ld39nhuEFYnCN3rFDM74v
	 EAB1G9TZ2FTh2FwwS7+tmQmfTl+uP/rCEZw2DdvY1YkLYnTQ64T9GZbIA3/rrfFbkU
	 VJGiHasV4Fykej5li9EoO7QK/eDZwb2uJpiflKXCA+QkbkCqETuunXPspagvAr0IIH
	 ft+ebdJgoKIiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABF139D0C1A;
	Mon, 29 Sep 2025 22:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: add sanity check on ei.len in
 __update_extent_tree_range()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918503574.1733438.9199587753366819023.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:35 +0000
References: <20250916085243.4165099-1-chao@kernel.org>
In-Reply-To: <20250916085243.4165099-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, wangzijie1@honor.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 Sep 2025 16:52:43 +0800 you wrote:
> Add a sanity check in __update_extent_tree_range() to detect any
> zero-sized extent update.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/extent_cache.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: add sanity check on ei.len in __update_extent_tree_range()
    https://git.kernel.org/jaegeuk/f2fs/c/45b70947a425

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



