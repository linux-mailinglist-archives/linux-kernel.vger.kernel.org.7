Return-Path: <linux-kernel+bounces-727936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC5B02193
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBB83BE696
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EC2EF641;
	Fri, 11 Jul 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWNZcYEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B62E92A2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250798; cv=none; b=Z/svblu9ym8qJXOMPLv9+Iaa5PPFzk/auN48JtHv4qoXZQk2KAAYsBa4romIbt/uiU8titZ3dNcyKF0V8bDOu8ziyG1v+H8KJpdX9z7fUC874YQjdOS/tgp6MZ5/sKrnH7VzsKJxMo7rtkyagx10YClIW2W2jwNlqd64lIfl4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250798; c=relaxed/simple;
	bh=1Cc4/JfdEwYxt9wDCzQswq8lMP1iCeM+kgPAm365koM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JO5ib9c9526j+VizdrxwUsZSG86MaFkYXKW6FA9C+Qgt2u/eMSAcz+9qviTAADkrhl4Kk68mjkpG/5LYTmPZ69NyzGlAj9r1JGNzaifkvm029euFTX6ugG7VF3bG/hM5nDKbvCd2GCGhjWkhJVbanYhTwOv6uDdKjLYDFO7w3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWNZcYEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F0C4CEED;
	Fri, 11 Jul 2025 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250797;
	bh=1Cc4/JfdEwYxt9wDCzQswq8lMP1iCeM+kgPAm365koM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RWNZcYEOQkKajxdfntCy4fNxtgO8cTjwrYtATtWgSn//qj5ZYENkJsJTn2yyWEOES
	 8nxjJY2QYTCVVc2G9Ee1774aI6WTfEZ2oCKyb7QJOKh7eIG/Qt+QIwEpF+7gWQWx3K
	 GdIbmI3PirIjSPEqKEf79U5bNmYY3RX/d+ehIe9EkrE0wcwqNfywMLkG7Hw7yuIHW+
	 4iFfX6fsWogdGiqM9BCdlBrE4MZ8MpyDiYbYcPEm4IrdAQfkDaMSaXHpqHibchCOb4
	 /SA+coo1TCIdF+7pXgUiY+FcYRqbK2oAa+0kGF9OwWtlls4xaMDD7gODXU0O/miemg
	 Gg9Z7jkA02eJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBB383B275;
	Fri, 11 Jul 2025 16:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-boundary access in
 devs.path
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175225081949.2325425.16515007956966725798.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:20:19 +0000
References: <20250711071450.207302-1-chao@kernel.org>
In-Reply-To: <20250711071450.207302-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 11 Jul 2025 15:14:50 +0800 you wrote:
> - touch /mnt/f2fs/012345678901234567890123456789012345678901234567890123
> - truncate -s $((1024*1024*1024)) \
>   /mnt/f2fs/012345678901234567890123456789012345678901234567890123
> - touch /mnt/f2fs/file
> - truncate -s $((1024*1024*1024)) /mnt/f2fs/file
> - mkfs.f2fs /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
>   -c /mnt/f2fs/file
> - mount /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
>   /mnt/f2fs/loop
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid out-of-boundary access in devs.path
    https://git.kernel.org/jaegeuk/f2fs/c/65eeef059d04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



