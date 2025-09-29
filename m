Return-Path: <linux-kernel+bounces-836840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D3EBAAB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1CA421D62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C662625CC42;
	Mon, 29 Sep 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anEYKVYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177725A350
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185037; cv=none; b=bmrfdnWm6knGMSS6l0dyxPtFJSEpWSHlPjSibaWPJbdGr3YfP9MY44uqFNNpgTHBpfz6UhkEqKGEG2+UlhF8CtVRJZLk0iwaI3hsMT2UlyX1omS5+LdHEnvw1pQVHciWWLktZJH8UCvZw4BZV/p8Md0bznbAo9xcRQkdfU8qzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185037; c=relaxed/simple;
	bh=G9TiOjCPerDpwIRRsRGWiZgp2hDuJO0vOo5XGhLYi/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AbbISK7rk40dK0ATT2T4qHGvU9pPDS+E138jClV63SZjyWfV/hK5AUHy1mI/IL5sGgtr6OM7cy3QQUKYvXnOdmDO3eDO9DIESkAaWexStv3sC4ExtagyuEzAQMbFhWK/s9dkrT3ywp7ahJg4coo44cfbmw/GRqxkcEOntW+DMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anEYKVYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE7C113D0;
	Mon, 29 Sep 2025 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185036;
	bh=G9TiOjCPerDpwIRRsRGWiZgp2hDuJO0vOo5XGhLYi/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=anEYKVYcn8rF+spwMkVUp3KQ4mAJ6zrMMe1pAaso3o9hJdW9l8gcup+QSEONNMUxF
	 Mi+6BFNzTb+aqPk0eWG9OFQwiTWivw3XbX+gO8MYMlF4u7lLnNCy/L9Z1N89PkQCbJ
	 eiptXTIJBoBZrZtJUOVTQJtH35Ff4HhVvAqMb8HF2ZVSnnl0GgpEB99D7DH6cEEIoo
	 1xLC3Mr4epnWjT+l61lX2N7uTP7MfuWw49EKlXPLbEmqmkw2MneZ+rEmKOqGtfsyuN
	 Ft/gCy4JVluTB5VekBAtw//aoYb3gkHyytKRhjhWrGGTRXhQkQ0OmBjH3TWzrBB3aV
	 YEJbUO/oAu1Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AAB39D0C1A;
	Mon, 29 Sep 2025 22:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to update map->m_next_extent
 correctly in f2fs_map_blocks()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918503024.1733438.12651094031657355399.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:30 +0000
References: <20250912081250.44383-1-chao@kernel.org>
In-Reply-To: <20250912081250.44383-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 12 Sep 2025 16:12:50 +0800 you wrote:
> Script to reproduce:
> mkfs.f2fs -O extra_attr,compression /dev/vdb -f
> mount /dev/vdb /mnt/f2fs -o mode=lfs,noextent_cache
> cd /mnt/f2fs
> f2fs_io write 1 0 1024 rand dsync testfile
> xfs_io testfile -c "fsync"
> f2fs_io write 1 0 512 rand dsync testfile
> xfs_io testfile -c "fsync"
> cd /
> umount /mnt/f2fs
> mount /dev/vdb /mnt/f2fs
> f2fs_io precache_extents /mnt/f2fs/testfile
> umount /mnt/f2fs
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/869833f54e83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



