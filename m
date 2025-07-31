Return-Path: <linux-kernel+bounces-752577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876CB17763
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E1E563AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D028261393;
	Thu, 31 Jul 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+xhiI2k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54825A620;
	Thu, 31 Jul 2025 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995082; cv=none; b=qHwOv3C0m6urN94ETkutbcPLeVKoiG8eDTo6OmK9ZOubjRjhjz0IlPX16co3QS10L287DJi/bNVQLiXZKujb5RdusMWS0YYrGGqgXjouGd5DrW13v2QwFLRS+k1X3jmF95qU3CCoHb2bw87rV5Q9J/El0Ne+gXYSiY3LfjoZduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995082; c=relaxed/simple;
	bh=JXuG/njPy/Mswl2rTJFPrFzbeEocyeYu3OfEJ+QXAhs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aO8blwOq4vPkexqgfjFfpPGhCPKBsSrZyQsdAdW/QNHVKZcgM/JLBBZSYBXySM8HYJ3EGFME63MGhRkjRPBOAmiy9K6V225p/MvLJI+cejkkHb5532GdLoLdEtAKf6bcS8jbL+9qKGMEr0SxPW+VT+FRQO4HnUKjiLPUQTxcobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+xhiI2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABEEC4CEF7;
	Thu, 31 Jul 2025 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753995081;
	bh=JXuG/njPy/Mswl2rTJFPrFzbeEocyeYu3OfEJ+QXAhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z+xhiI2kb4ILbxzxaTNx9/U01gnxKugohc1uHxTWnPU0F1T5kSpu617lvvcV2VYPc
	 t5jjplz6rjRJYawZfEzAqqFobAF1WKYfyL8ft3DHy93yoaJxdWv9TTANBpg9QfIlCf
	 Q8GXLBdHRV0YxZJSdJcb7uxVS0jM5X/eWxgP/L5ETTvew5/oxigctzljzRJ9blKpyr
	 3Ps7WjzhRgVc4atb+WDZ5ZiuN+/PAf3HZb9W4P1ReDXFx70PfaL3pBLfAspEK3Hvtd
	 y4U1BGiQ9pMAf9expaA7jyI3KB+uIxWw57Y9iY0+p118TVuPvR0zR0rmErrJm17Sgb
	 iHKWY7F9AUQAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9D9383BF52;
	Thu, 31 Jul 2025 20:51:38 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250731152917.1864644-1-linux@roeck-us.net>
References: <20250731152917.1864644-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250731152917.1864644-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.17
X-PR-Tracked-Commit-Id: de1fffd88600c5ee1c095c84b86484cd0329a9e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be413ec746afc951c79d5907cf62ab6757330bdb
Message-Id: <175399509764.3294421.4903589140273295026.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 20:51:37 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 08:29:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be413ec746afc951c79d5907cf62ab6757330bdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

