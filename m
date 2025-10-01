Return-Path: <linux-kernel+bounces-839626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CABB209D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBFE487DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61531283F;
	Wed,  1 Oct 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyOEpsB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEC29C325
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359648; cv=none; b=Ie3fFJUvzjPmK9G4cwqXIFqUWf+gtIypU76K5k21WBGdm+nywXLyPxBkyTdvFiQxG/Slj8IARgnz5JmojZbc4FK/nztbdVCH49hd/IcEskrn4uJEOILfrls5/SEgmyvqS54jUaEtD58fnO0Ao9ge/yyI5kFoEx840ehzvmdS0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359648; c=relaxed/simple;
	bh=2zYUpGtyJX8BcQxzlCGFTIHwF8onwXMlCgu/kjo8T1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HtpuYI2ediOO3B2TzF+ra9OyD57qxQ8GK+e1s/U1LwHY+ffeKpTUi/wnHh2P8+QcFFONV6tIETLek0fqOtn4tcBnPwV8n4Hx1YUst58FjB4xD9EZo/asC/9VRVSTbRtykeih6d5lNdGEtXbYo/9OtMgdd/L7m8eYBaQV11QMidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyOEpsB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A384C4CEF1;
	Wed,  1 Oct 2025 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359648;
	bh=2zYUpGtyJX8BcQxzlCGFTIHwF8onwXMlCgu/kjo8T1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IyOEpsB7cDJd8Dv6drfiuEmibPNm5icKUrVrhPSkue3Aaszs0yK6n7dSFZzTYntx8
	 Ip36RqsWP8ZQFTm6LMVSQHFEsISEPlGK8Mt73dGrcqymSYPhcBOg78R3BaCWhLxMkD
	 nezNeQtkKOypVU2OyBQWzzlp4NxwCcH745irp4+kyuyT6c9Brwgys9QpcZR4kcu/DF
	 9O2Ya4Cwqxg9nlE+HDQAWMXYFwORZGIww4NMwtO2NGZUdrR6PAdijRsTl6328pcz+i
	 q09SI1lOCFzLRoZqk9zlOj3hIjSHthG04IeEbii6MIpsoujflb0iVyYCXN7a1Ha0PE
	 FkOmHUfxGj5eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02339EF947;
	Wed,  1 Oct 2025 23:00:41 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.18 kernel
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929134642.GA748211@workstation.local>
References: <20250929134642.GA748211@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929134642.GA748211@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.18
X-PR-Tracked-Commit-Id: 40d4c761200b796a44bf2c7675ae09c87b17d4af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f07c3695bf65220a69a848478bd9099bdeaafa78
Message-Id: <175935964049.2651312.8860314281892811573.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 23:00:40 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 22:46:42 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f07c3695bf65220a69a848478bd9099bdeaafa78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

