Return-Path: <linux-kernel+bounces-896275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EDFC50053
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E04F4823
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F432F8BCB;
	Tue, 11 Nov 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV4wwU7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117632F7465
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901452; cv=none; b=ZnsIZSXSz/yJ3BSpza2gWmelmB+/r7jJnYVvBYfWWMixF2toxOZ0dDYbX44NEr+Gcp6EDV9RmbFNR8xKla8dOtLn+1/Dgm1aSdOR2/Alw/3DivE+Y4hoHYoO4Sh42RNKo/D9CjNUJErG3ZurW3iqqXSPlFKBy8KqB/6akSF3Q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901452; c=relaxed/simple;
	bh=aBeUVRElA6skoKpJp7e24LRjOo41rE3IgWMUo5RwVfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j88GPd5kgWkok8Cs5bqaZembmhnHI+hS298ys68L3jh51VHW+NmOqwpEVfW8fPulmTt+reguDSHCwg4ic+TJpXBGCosr1qKCgNHWbjnZVQFAHbCxc1ZkxDsJOh+wxlTAMDJsdJwio0fZptMeX11mUe1nVs9FPgKjiCmhqr2DvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV4wwU7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A415C116B1;
	Tue, 11 Nov 2025 22:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901451;
	bh=aBeUVRElA6skoKpJp7e24LRjOo41rE3IgWMUo5RwVfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oV4wwU7PMLNL8tSbxjcJBNKJZR2Yl7nZx1Bb/IvL3mHJ01hzFaUBvgK1qG8bD7hsV
	 /DtyjbEDN/rG8im93qORWJ34LamMOqIhE/OJiCAnD8BRURQN2z4DeUx+xwRyLcsEeJ
	 CwH8DPMUW5pNgVEMxysMZXpvRFBymo1xvjsJSLnV11gt4VjUpzwQSCSk5smqXgqxUR
	 hmWU/KWEdPu5M3qvluZGjSmRcR6jq1vUY4dKYoYt3LLshIeBRemur5yfOJDaSuACR4
	 PsXU+iVbPKDB7aK/GFtENSCoqaRLyMEK8Nm7kmwW16JXNz3IzM8NnJa4bUbMlymm8m
	 1emtmFAaPklMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB26E380DBCD;
	Tue, 11 Nov 2025 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix return value of
 f2fs_recover_fsync_data()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290142149.3596344.6185023964431728544.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:21 +0000
References: <20251105065023.3656975-1-chao@kernel.org>
In-Reply-To: <20251105065023.3656975-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Nov 2025 14:50:22 +0800 you wrote:
> With below scripts, it will trigger panic in f2fs:
> 
> mkfs.f2fs -f /dev/vdd
> mount /dev/vdd /mnt/f2fs
> touch /mnt/f2fs/foo
> sync
> echo 111 >> /mnt/f2fs/foo
> f2fs_io fsync /mnt/f2fs/foo
> f2fs_io shutdown 2 /mnt/f2fs
> umount /mnt/f2fs
> mount -o ro,norecovery /dev/vdd /mnt/f2fs
> or
> mount -o ro,disable_roll_forward /dev/vdd /mnt/f2fs
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix return value of f2fs_recover_fsync_data()
    https://git.kernel.org/jaegeuk/f2fs/c/d05faa07e7da
  - [f2fs-dev,2/2] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
    https://git.kernel.org/jaegeuk/f2fs/c/ca244e9242a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



