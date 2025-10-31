Return-Path: <linux-kernel+bounces-880972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593AC27147
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA681B226D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4CB26FDA5;
	Fri, 31 Oct 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJmHXK7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7583161AA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947590; cv=none; b=EtrPg45VqLN5M3D482XyOioTYxXS3Y7dq5MNpCZsqwPpiNyDKjyhQ+S1VsjFrQz/7kkO8wSOCbyzJctdKZy0ti0aJNc63Wi243J7d5Lnd416Xh3AVVTrhAvPMOKHbgDpjyPlGCgA62yDNpQDvkSvDWg/ukDaCwJZkNnhO9MsXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947590; c=relaxed/simple;
	bh=JvoRvfCxZUYt2g8uVJ6bHPnNedciMmKoytiyMwtSl8E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UzmB5skn7thl8/INWEvs9wuZAQPsDoZDLjiVpQOrBWTMpR6qNoisUxgXIHr3J4SCNfUoY4esCc76IGTcGosJjgLQsAKPd6t3v+bvNDRR/U55GcseBilbm5utWvN9DYGKy76nFrj2R61l5ZVyWsyKnAwBCeGBqH0I1zroYnpyUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJmHXK7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DF7C4CEE7;
	Fri, 31 Oct 2025 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761947589;
	bh=JvoRvfCxZUYt2g8uVJ6bHPnNedciMmKoytiyMwtSl8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fJmHXK7vKX5QoXLJNCmqCG7Zn9w4VolIDRn9MzyEh5m6wa4LU5P0pTzVkN67b3WwC
	 ycJMAAgV9Wl07Ktbcqc4GTHpXnex3YSG2XjebLeum0wXOctzAvjUilNT4q/1KpUZIP
	 LYg719DkMaEtOxBxC+eHVN0vBw0DEm3K25Co4juft1dcNZHkfiWG6rXR093D6ZsSnf
	 ZibJMS7g0JH+38tso7oSMAuxdArP0eQUwkYuJpBcqaqPIqzAYx0dRZwBfQlGpGm5Ze
	 fPmif3IlMoYCMJm2xJmXDpPB8FlDFccFJfhwiHuuZsWJc3S5yScfvkZTslvP3yFD2A
	 HHBq0bLlVz9WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F353809A00;
	Fri, 31 Oct 2025 21:52:47 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQUs9m_M8NbteVhR@phenom.ffwll.local>
References: <aQUs9m_M8NbteVhR@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQUs9m_M8NbteVhR@phenom.ffwll.local>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-31
X-PR-Tracked-Commit-Id: 41dacb39fe79cd2fce42d31fa6658d926489a548
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec0b62ccc986c06552c57f54116171cfd186ef92
Message-Id: <176194756579.649199.7609217927268762355.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 21:52:45 +0000
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Oct 2025 22:41:10 +0100:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec0b62ccc986c06552c57f54116171cfd186ef92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

