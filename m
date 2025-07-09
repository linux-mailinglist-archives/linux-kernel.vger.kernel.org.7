Return-Path: <linux-kernel+bounces-724253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D7AFF082
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47C53BCAFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C70238C2C;
	Wed,  9 Jul 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NImqP9Nw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5995237708
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084588; cv=none; b=q8D5kWGvXuP+PK5IdNxkrczufKBZvKwTVSrgYtX/JFrG4ScfOTl4y/uouaB7lTz/C4OO1DnuYwZvyfF3jV31KEKdgB1tYhbdNU3cj+0QUWSd6FZv95HZWHAURnKHUXXhFF4qmWveyJ7esAeTk/gebhRehbYZ2hr3cIu2Sw+ot58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084588; c=relaxed/simple;
	bh=BsOGMwnuVXVpxz2AP8u8d6e3+gRAhs6ZI8AQjqzy5Yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NX+o210g3OHoanYk4CyaAqL1kT8k9jtylBVI8lTV9HtFyYCUY1hPXPd+RQzFsw4WLK+IyQS57eb9OidYeM7ZARSkP7vQ+Rvd4spaTDPi0LujEhNhmrxrQhsDcHhxsXswUHPW7kGEdAMcLZnG2j7fQU4A+wMgJwLcBIPUe7oDUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NImqP9Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7207EC4CEEF;
	Wed,  9 Jul 2025 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084588;
	bh=BsOGMwnuVXVpxz2AP8u8d6e3+gRAhs6ZI8AQjqzy5Yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NImqP9NwFNL4Bfwe8gFXCoPICs82sfyFJOOHb8n6vbxwXPKSDC04ucnnVTc8NjX+B
	 VDNfSSGu2zJ73+jrX3TCnLOaCWCbpXADtZMNSeJ/61gW0MXR7M5XJ1YfeM1z+UXXZr
	 6zJSE3T9CKxpyZigWulmbcAAtGaf5LG5aMq2B04/L9oXIpNd8xjuZhSX87O/9t84uG
	 YucrL8TFLoJWg7xJeCXjh6yisxsvTExvFmuOTAVMJD6IokcuKYh34LhX6r3TNxCXFs
	 Qq8etC9DVvC8JJcpHQIeaTd7xc1BSPANgaUGguq6+07iDnkHvV/sgMBrKviEIzW9yw
	 EV7NN25ZJiRAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC5380DBEE;
	Wed,  9 Jul 2025 18:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check upper boundary for value of
 gc_boost_zoned_gc_percent
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208461075.806926.14733447162737936340.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:10 +0000
References: <20250625001408.1961-1-yohan.joung@sk.com>
In-Reply-To: <20250625001408.1961-1-yohan.joung@sk.com>
To: yohan.joung <yohan.joung@sk.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, pilhyun.kim@sk.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 25 Jun 2025 09:14:07 +0900 you wrote:
> to check the upper boundary when setting gc_boost_zoned_gc_percent
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/sysfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check upper boundary for value of gc_boost_zoned_gc_percent
    https://git.kernel.org/jaegeuk/f2fs/c/10dcaa56ef93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



