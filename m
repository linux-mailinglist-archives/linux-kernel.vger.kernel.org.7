Return-Path: <linux-kernel+bounces-842131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7FBB90EA
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD0D3C34A4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F8287263;
	Sat,  4 Oct 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFVh5djH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976343D3B3
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602014; cv=none; b=AS4rL3OACSKlcR2mQzLD3lRddmtVYtSUL/kiUoeSfrfOAaZMXBy9zQJItTIQL/xf4WRPfnlZid7zVIigxcvkMlt8MaQJwtk8S4Ml7XqME/9Q0t2wtTrp8xdeHfQd11WLzv2BeLDxUiEXe7fmr3Yn6NKFlk9K7pbbWthAB9Ajarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602014; c=relaxed/simple;
	bh=UNiwFUS4ldqeg0GJOU9a265vk+ZPdpUgZgkE72UdIjc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uCGmoAbMam0BTmnaUlndwJVSCiWSDJUAgZFbPqm8+bBRspDrHV2wK3m4VvuTtUsj6hyFykoI8FEIcIrRve9xnALPPOJ+/1jqqD4jo8pW4HKKe6ymQdc3WhJ9rXXgaFBj4hKk81dthAr8Sp5e0anybeQcR6QVv+332SHLgivWTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFVh5djH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC22FC4CEF1;
	Sat,  4 Oct 2025 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759602014;
	bh=UNiwFUS4ldqeg0GJOU9a265vk+ZPdpUgZgkE72UdIjc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FFVh5djHgXweVoU7/T6A7H6M5cVxgV9J+Lwdeg8CxYDibw0QMCUYlYMFwcsn9900D
	 2lj8b6p3go4FQQ6c4sFeeMOy9k4pDI0KY5SRP8OxRsedND/CPSZKOlKS9rBFaiROB6
	 iycK6itv9nd8zCM0PIf1z6NGNpGJKB5l3or1PNdKT3QyA1zulRMff4TCdE7Mi1uyoa
	 8D9W/V+HZdkxQ3Q7G3BJ4cfUsqhMDx//BjECQgY54DAvYPBJ727FmoeDi2QWqSIMvx
	 ugAs2M7ETH1lyl8hatYH9e94Sm28IL7RATIo43gkn1Mz2MKgTCAqorW5AiC49JSXV4
	 TBZdxDXtUtgqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCB39D0C1A;
	Sat,  4 Oct 2025 18:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aN_B5NanyUEXsLxo@aspen.lan>
References: <aN_B5NanyUEXsLxo@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aN_B5NanyUEXsLxo@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.18-rc1
X-PR-Tracked-Commit-Id: fdbdd0ccb30af18d3b29e714ac8d5ab6163279e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b7ce9385441cfce92e6b7324216cc38614f86ef
Message-Id: <175960200448.404121.15569388005485838582.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:20:04 +0000
To: Daniel Thompson <danielt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Thorsten Blum <thorsten.blum@linux.dev>, Colin Ian King <colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 13:30:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b7ce9385441cfce92e6b7324216cc38614f86ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

