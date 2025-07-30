Return-Path: <linux-kernel+bounces-750153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A81B157E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170667AF2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C71F237E;
	Wed, 30 Jul 2025 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b65JN4tA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292991F03D7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846780; cv=none; b=SWTKnZ2H9erEc0qjPoYAC55XXyZUfLA3a+KDokop9Kl8fuFEDfkvvMEWXr8pIuvr32DBZ/hdzWKVleqbwLE3f14zv3XWCKnfj9w/XeXIZCS/BFBS2VrdyPVTYArAMfkxFW8viVyvCWKkmsEtsbpeIZOE3M1I5/stqdCdYx/gt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846780; c=relaxed/simple;
	bh=oZrcGnGSWGkVWEZ/+HC3sRMQdPreQpqGKfi/sHeIhuQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pWeq0zncxXIBwDpq/WMF1mJ/+gBTGWAE8C3p3KPG/xlYDMRkZSOXCbSM161Q1AiCtQABee5ooZHIaHIFDhrQU6rQNqwzPglFvsikP7W8mrskdeukVJ82JxVhc9HHp09s0pvQL5VQnKov5KN3pFajDGNh3bklZsW+hXu+ho6flSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b65JN4tA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62BC4CEEB;
	Wed, 30 Jul 2025 03:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846780;
	bh=oZrcGnGSWGkVWEZ/+HC3sRMQdPreQpqGKfi/sHeIhuQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b65JN4tAHXssvgQE94EoI4R6wCLLiy4MnmOSte3LcVSu5IIrZt1XLKj70uYdp9Aq+
	 YE1MdnhBXjUUhmKo8SmGOiaa1bbNWTMn7rMl3QSDinDKbYbV98egxr0uxOKJRojT/N
	 lsYBFXz//ocp7kJayjCgUR2CyUy5rZtkkaPBbGd6s3z5EJTfzxIFMZfd93GSMeNzRz
	 scbuKfDADjfjcoTpIpSuwOhSiWYDYDJklHko1kdepgf3K4Om6Ad6fkcwQn1gxQyw1N
	 AP5cOZNYbQY0jEiHevop9S0NV9uw1CwBx4v1DWVDL/y1PqZ04/dh84q7y+cKHicfOT
	 LB3TfGVI0/FRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B2F383BF5F;
	Wed, 30 Jul 2025 03:39:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIhxs-6YQFywxr5k@gmail.com>
References: <aIhxs-6YQFywxr5k@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIhxs-6YQFywxr5k@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2025-07-29
X-PR-Tracked-Commit-Id: 7f2b41ac3f29f682cde113f1d0b4b43d261902fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1645f6ab966b828bc160c23626d071914debfa79
Message-Id: <175384679609.1749338.2846277661568460640.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:56 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 09:01:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1645f6ab966b828bc160c23626d071914debfa79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

