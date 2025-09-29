Return-Path: <linux-kernel+bounces-836843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484C6BAAB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712FC3B9880
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF032676F4;
	Mon, 29 Sep 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O91s7ILH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A6265626
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185041; cv=none; b=TmVGs0o5QaNMUMG/wrFbU6McxPrRokdfNbGJ3w9CgZmhKlTssGQUFAw27+uFMSoDbOY5i6VGRB+gp5ujLTsJU/1NnvjZoYlEFPZGzjgO1YwRFuLJfsqJvzibk+CH4weIeilFiXst5hnVVVQEvLsxTbkjaBhwi8EyItXsI+exhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185041; c=relaxed/simple;
	bh=aQAK/k9mmfxKrAqNBeXS/dBzTkpkQcyv7mduu3pCvpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=buQiykl1JnK2ZeEeenZx4wqWLdqK9ktDb9pz4+pRbjErLWUBKt8+ib1BT9ARgvGscMvbRjRwm4qMTzDpktNXVhHD22KSoEoo/LNbTiH9/wms3tkH7wdQ/shIt15ATS3+ETACyYsLQcgKHu5hALSlxoU28N7dYxD3Grm/qMOKH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O91s7ILH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E5C113D0;
	Mon, 29 Sep 2025 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185040;
	bh=aQAK/k9mmfxKrAqNBeXS/dBzTkpkQcyv7mduu3pCvpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O91s7ILHHS0A0h03M6g070586dVXe2R7U1+bvZRPgrH39kKcq7K/fJBhQqOurDyiK
	 AjmCuGVMgUSFTs/9aU2zKZqjWp004q41v5wugOrM2cO1p+/BXrT+os03JyjYcPwhOV
	 StAYRQC76HBgnHL2cJ4fZffsVqcVWWkVSP7wUQAnsiWESpeR74lZOnwySBi/Vvz9rq
	 wpC1eQh64pjixXl9K4Lfj0a0KFPqezy0p6SBvJhX7V3wILC9x2G9hAqy7E2gARfA++
	 X2CxwdBmWVLxPo0h52H1gkM/z5WXsINw//zaZxNgt1HOF4QZM/i1wqiJW9VM6kHei5
	 sTxg0Fs4znhVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9239D0C1A;
	Mon, 29 Sep 2025 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix zero-sized extent for
 precache
 extents
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918503424.1733438.15522047521357961173.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:34 +0000
References: <20250917023622.516052-1-wangzijie1@honor.com>
In-Reply-To: <20250917023622.516052-1-wangzijie1@honor.com>
To: wangzijie <wangzijie1@honor.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 feng.han@honor.com, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 17 Sep 2025 10:36:21 +0800 you wrote:
> Script to reproduce:
> f2fs_io write 1 0 1881 rand dsync testfile
> f2fs_io fallocate 0 7708672 4096 testfile
> f2fs_io write 1 1881 1 rand buffered testfile
> fsync testfile
> umount
> mount
> f2fs_io precache_extents testfile
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: fix zero-sized extent for precache extents
    (no matching commit)
  - [f2fs-dev,v3,2/2] f2fs: fix infinite loop in __insert_extent_tree()
    https://git.kernel.org/jaegeuk/f2fs/c/23361bd54966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



