Return-Path: <linux-kernel+bounces-844647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26318BC26A6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B19E402F27
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA672E9746;
	Tue,  7 Oct 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYLwRvvq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028041E25F9;
	Tue,  7 Oct 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862368; cv=none; b=qTeKc+QC3lykBQne31hml+FXUMNg90ats0Q543TTGXpiVnnNtbK2KHT+iDlbMXUZCk5i9UQd5p/gV8vvntgDEHs5Dqdh88QT1+oHXKeCmyiMMShWGwtEaDfCVOxOMizwAI8qJL1GlTBI/omH3ZavdhsYAQT4rEGYMirLjw9LDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862368; c=relaxed/simple;
	bh=moUEoohyX/Ba+2iDi3GUCyEk7dPGvolwtigE3GGTBeY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gqFWvIP7gjHNRXmdHAIWERuzdP0mK9m8epTO2dDEy9VHI3kkdw8AckD0okI3UuI6rK0PbDlIrTe8JOv2YXgpvnPmHCA85oVsC8JaGxEgAfm7/9vkPBMor4IvNQgtnVQ/9JTmsix5gyT+P6230whuG/r4D4ZrTrFlhk4+CFXQ7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYLwRvvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B9C4CEF1;
	Tue,  7 Oct 2025 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759862367;
	bh=moUEoohyX/Ba+2iDi3GUCyEk7dPGvolwtigE3GGTBeY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tYLwRvvqxFrj2lM2p7JEP8Cy4+nShL7vBioVGKVGQpPvaGzkfNjYK0mqwDme7Y0km
	 tSOcSx/m4eCQbK/H1BZoE6d1If+/NAOv39alUAIgcAVuvbYAOSqzyGEYxlnlCAI/u4
	 rclpGlnguBmEApSd2NucoPP28ZNSC2XMDUwk8vSxQACirm+bK7kOb3nhJ6YPuelE+6
	 EyiFWpniKD+To+rx4TPP19uUWvLQW4Vz2/9jS65cyRgCiSFI/CFl9sY2YcV+3MAQSM
	 JHcsmXENFWZ2qdnJYAMsPTXXePU33ywFcdnce1lgQVdZycSH3VFM4RLydZCbkMLEoq
	 f/ni++6kWXvpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3039FEB72;
	Tue,  7 Oct 2025 18:39:18 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251007051720.11386-1-sboyd@kernel.org>
References: <20251007051720.11386-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251007051720.11386-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 112104e2b72c5c7ba1590e3a5614b2ff76474f14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 522ba450b56fff29f868b1552bdc2965f55de7ed
Message-Id: <175986235666.2733874.13530216567970643653.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 18:39:16 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Oct 2025 22:17:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/522ba450b56fff29f868b1552bdc2965f55de7ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

