Return-Path: <linux-kernel+bounces-825969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C77B8D3BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2CD3AFB86
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07729199252;
	Sun, 21 Sep 2025 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUEOe0jL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE72F29
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758423030; cv=none; b=Xd6QWTkL+ilFB0FbSI43YfIIvEI6X2Ke3EdEpPimjb2gbM02Ng7N8u6IRF2IJpNpjgunk2q1KQGcvSa7PshV40DV9bFeiBTCLzTJGBhtcsxNw0mx8/JnH1GhiuBc9eNXcUTga9DhiqyVNf+ieT8wlbhWLDFZbsxf0QusW60ByKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758423030; c=relaxed/simple;
	bh=5xdtYrMfwfRwogunWck//ocyEkoakFistnfKGeOzpYc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IIa47A+k2h0lD9h0b3oxyGpoNlN6rVwNQ8p2zZRWuDIuFyo9374m0FgmFM3JEKJG+fRDKxg9fKHiOsSnI/4Cb+N2kOFhBLNxsF6U1SfaqOTwVIC2Q1NLYvtIgIMSkEU309xrOPyM0UhHJZyV5qdKcUQxcWpHoi4fStRlD1T0Yx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUEOe0jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E907CC4CEEB;
	Sun, 21 Sep 2025 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758423029;
	bh=5xdtYrMfwfRwogunWck//ocyEkoakFistnfKGeOzpYc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZUEOe0jL74qXyfhCsIeO9GCymDay9zTQr42DHb1+j96H2OZWfVhb1hRODdM3+iu3x
	 nwYgSbmtODjlIHw/M1PCQrXPOkAVl8uyjjM+dCF/jAHEFArjAZXvEwjCB6sR8bgjjO
	 vVhzj3exY8XIru6z2C6X/T+zX2fQpZV9G09jWCO3JPkjcnzPn21kMdw9G8pzUCfpZl
	 mEm+QbXr5mh27r2W7XiWfHGLUWSsp1ewvkbhJf523iHfuaIRP/6AATTfN3jSHijx4E
	 MEMVsCO5WcEeZugw5aC6pa9CsJKHni4CW+0YHvKq1KmX6sWqvk2Vygd2tMFNbXWITR
	 5b1NOMiTtDOHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04439D0C20;
	Sun, 21 Sep 2025 02:50:29 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250921012255.GA49526@workstation.local>
References: <20250921012255.GA49526@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250921012255.GA49526@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.17-rc7
X-PR-Tracked-Commit-Id: 853a57ba263adfecf4430b936d6862bc475b4bb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f46486981e7c3109aab71623eab3ce26dcadbdf
Message-Id: <175842302833.4042380.8204477887232775572.pr-tracker-bot@kernel.org>
Date: Sun, 21 Sep 2025 02:50:28 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Sep 2025 10:22:55 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f46486981e7c3109aab71623eab3ce26dcadbdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

