Return-Path: <linux-kernel+bounces-843462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D131BBF885
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC805189D814
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05F2D47E9;
	Mon,  6 Oct 2025 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6JdPQlM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6D2DCF4C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784461; cv=none; b=P43XBHVFA1UO59WrMz0kZJyosWOLwUX7EogQXtjiwIGlA/95RzHx8JAukYi6ufX9JsbRR0u15VCZ4YpvCB88i34R328D6NmoleCw5P+49aKuBwL60OU2Mwp/RW7uRInh1BCgpK2920Bukswzga3Z0Fac7owKRXfvqZMubNk8w64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784461; c=relaxed/simple;
	bh=vhZ7HKajK6lxxXMq+INHP5c8Q0eOE8Gyvz38BbtjKMg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m7cuSMWRl30rhC2BF1bAqOUUNJkrT7cvviZ3rSeIOjcgTlw6ssJ00w64l0Q6t/QNNEI+kcQ57e3WF9WwHB6SJ1zPaWBpEVhT8WqrTkMQjnkieuNFpuV2xrgIomcSby9e3CohyQ2Ub22kRasY4+t8sPQgGq6W0cnV0p/UG8qM+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6JdPQlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAAAC4CEF7;
	Mon,  6 Oct 2025 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759784461;
	bh=vhZ7HKajK6lxxXMq+INHP5c8Q0eOE8Gyvz38BbtjKMg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V6JdPQlMrvfXf3sSUVj2Z28DITSgn2WdjUtwLoYggdZuWvQ1mXHqozm4eObt7Atvw
	 xqWAdMYfpIYKWLIsnCBTs4RLJ8h6Y67YF7UUe5NwKGPYPHe6EZYHeqS9k33KtlBT8j
	 ChEzx59/aHh6Dcn3+dzMyqwzXxW5Sp+zH7v85i+N3lyUod5eQuGBNup2esb7fIozFJ
	 IpjiII7CWW8yLo3/1wgcEtMz7Y18oIEnI6lzFg1wldSoqroOhHGCwo4Uz0cruZoGe5
	 fohTjcR8+rWLzwuIpDGgYQal9sfjBsZugIy+tyE/kuC6ps2jwF7xgFAn252wzolt1i
	 /2N9Te7VHqpiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72F0939D0C1B;
	Mon,  6 Oct 2025 21:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] uml 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251006093601.33082-3-johannes@sipsolutions.net>
References: <20251006093601.33082-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <20251006093601.33082-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.18-rc1
X-PR-Tracked-Commit-Id: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc282d1731ec4686c1a84f8aca50c0c421e593b5
Message-Id: <175978445107.1594692.3062366928983165088.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 21:00:51 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Oct 2025 11:34:50 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc282d1731ec4686c1a84f8aca50c0c421e593b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

