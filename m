Return-Path: <linux-kernel+bounces-748404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FC5B140C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692E94E5D52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844B274B52;
	Mon, 28 Jul 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnIoKuhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8B212B28
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721404; cv=none; b=HNQ2ObtzmFENdlK70m0kKi6K5MxGLOGuV1Yrs8Ko015UPI683Eo/8u50/pFclMX4OT9lOmJGqneNl+qHMnm4Gou8PE6wW41F9YBTJFEYlEsBJhbFidneYUqPSv/AJCX1kIDizyfmwsQSpEhGtNeqSC01HjIgurvAtEa4a/iJKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721404; c=relaxed/simple;
	bh=E40iXFH03lE41BAGYpM5On1XrJwL7oI+XFMR1X+a1LQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LIcCEUB25xY/Z4ZoCWKf9DQlHP2s0yuyl0ZTOonXGiOlhH0+6fUDGAKyDIT/2ChrMttqb+Mf4wwUr22RLoTMAYxtLxe9aG5HjQtt43JsPAt5SPAtKSZ0m6v9n8/RUVIJq6af5T6zq19KoM0Xc7Ms0RHx6y/PSi08osvnOeDDWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnIoKuhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D662FC4CEE7;
	Mon, 28 Jul 2025 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721403;
	bh=E40iXFH03lE41BAGYpM5On1XrJwL7oI+XFMR1X+a1LQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AnIoKuhz9XyGZ9w/lbOVj7shQ1rIMdNSpTaDjZtYAoAQORIA07A5nd6c5rrnqBzj9
	 vBrv+P+dQHch8UL/sICDL1lJ8qZXkA7NZg9Ff8YFhwISk21p1UXsZjMPWbe3IXcFCM
	 zPRZA3fRZrdUMKPOxZC5I74NsX8pjSIxvRKyVnmTgdKTqmTJVxLNP/Q/TbWimx8bzW
	 ogLVhDW5owkgkZzlT6DWENkxAijtiyJ72vy++RIsYZzhOt+reNEzrxk4YSZVAOHojL
	 8w+0nHHhuQ6hFxwKvyErbi1566ikk+i+HpAW1wc7wwUeyxp+R0spd0lvc8urznGU2Q
	 72wu9X0/ryGeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0D383BF5F;
	Mon, 28 Jul 2025 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: avoid redundant clean nat entry
 move in lru list
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175372142024.776676.5036079944268949062.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 16:50:20 +0000
References: <20250728050237.1563560-1-wangzijie1@honor.com>
In-Reply-To: <20250728050237.1563560-1-wangzijie1@honor.com>
To: wangzijie <wangzijie1@honor.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 feng.han@honor.com, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 28 Jul 2025 13:02:35 +0800 you wrote:
> __lookup_nat_cache follows LRU manner to move clean nat entry, when nat
> entries are going to be dirty, no need to move them to tail of lru list.
> Introduce a parameter 'for_dirty' to avoid it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> v3:
> - followed by Chao's suggestion to update comments
> v2:
> - followed by Jaegeuk's suggestion to add a parameter in __lookup_nat_cache
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: avoid redundant clean nat entry move in lru list
    https://git.kernel.org/jaegeuk/f2fs/c/0349b7f95c80
  - [f2fs-dev,v3,2/2] f2fs: directly add newly allocated pre-dirty nat entry to dirty set list
    https://git.kernel.org/jaegeuk/f2fs/c/40aa9e1223fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



