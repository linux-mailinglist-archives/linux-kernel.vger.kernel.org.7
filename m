Return-Path: <linux-kernel+bounces-841894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E31BB87CC
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE1F19E2C0B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D71A073F;
	Sat,  4 Oct 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkDzHnN4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F419D065;
	Sat,  4 Oct 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542056; cv=none; b=tjVSwQ7J3iCv/4pHaTp5rwBCEIrcbMkZnTyk4K169MQBUnxlPsJV1NWxSdMjCtzr3bnXCLZ+53oqFuShJudjBX3Gp9fPAMCV0AKjnNFmL2gi5jNeXehdXULGyqroWS6RuNCWGAgvFegtR3dC+kB60o71V2cPK0rP2qBYTEFw9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542056; c=relaxed/simple;
	bh=CJzQOqRsZBKVzjNWIigbuOTbeA5vMz9jnNA736zVWx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=egmQkvDJlPztDUH0+HVBBOgqFk0Y+5rfftT1lDyy8NgBCSkIGySwGsNh9Y8iPle34FtKCVn2Q6wMQmZv881E+BFqPS3beMQULaMTIIkmZyGpw93VXqX2CsTi6PKjEsygw9OjFA77jFRZDMKQAz7BySjaAIGB9v+LxQyWFbcMD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkDzHnN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E358C4CEF7;
	Sat,  4 Oct 2025 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759542056;
	bh=CJzQOqRsZBKVzjNWIigbuOTbeA5vMz9jnNA736zVWx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AkDzHnN4sK9OR5wg00aqsVLrwePhmxBU+eEIDDkl7qwhXi7DRWTsNGQ7qbqoY5nx1
	 uoWO2tKJ0r9fz/yDx0P240dcYw4YEjV5njTt1oMbYr6Wt/QUMO6mYXcKoHxSFaXf5N
	 P8NLSyU96Dv59tMHlMI8sc6WZLLsQe7BxEMAhTwZm8cy6foFS0RJfn6FFNVLfR5bnO
	 ipIxpJm4DYxazTomj5wlPQYQtmJnhasSisIaeL4KBc0PmDgz4Io3TqyTWWjYsGI9ma
	 kqaKZtquFQA7GvJHpDCGKvB5/H8UCvsiq9QcY16o/7wjHlQt9JUdUnsUIHJSvTePxA
	 KX6toirBIHUDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A036E39D0CA0;
	Sat,  4 Oct 2025 01:40:48 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ecrow4mt.fsf@trenco.lwn.net>
References: <87ecrow4mt.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ecrow4mt.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.18
X-PR-Tracked-Commit-Id: 99510c324e531addd9f7b80a72dab7435ca66215
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee2fe81cdcd17f875aeca074afe64d7e8f57750f
Message-Id: <175954204734.144727.280835995208565601.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 01:40:47 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 05:39:54 -0600:

> git://git.lwn.net/linux.git tags/docs-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee2fe81cdcd17f875aeca074afe64d7e8f57750f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

