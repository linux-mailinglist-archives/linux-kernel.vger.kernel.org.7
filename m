Return-Path: <linux-kernel+bounces-738305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C141B0B6EC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D095A178D12
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F762253EB;
	Sun, 20 Jul 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4DcdU2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D42224B1E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029062; cv=none; b=lNuyZ+3c/qm2umFp+jlePgUlT4mv7eLrEU8rzu54eK8DRsA/zpT9efea8BMZ/E27luYXmKbTWWPfzBqZsCrPdkvLKzufhoy1SSjZSL9QwYGUyNKlDZyh95vKkTxuGo2O1yUq+HQf0KkVTVY6yEUZsaA9Lbe7XzQDzStkK17+ucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029062; c=relaxed/simple;
	bh=lUk4MtFp0whHxsOBtopl5zSMdusJaLMrYahVZCAa0gQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I6RkrnNm4K1xlMEIpY1IkTYsnaIUZKUrgqcFJEcfxiC1M1nAPRlM2fnQ3zFrZLTfro1JhEt5YBkuj219/1YCCdr+Dmf4NJzR7XIu6p7ZcbNIU4ZFIKTibPC2FjY51/T1DIg5Ieq2XfgCDoYN0tsXj134VW0+zBxMFLp1A7pTP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4DcdU2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3B3C4CEF8;
	Sun, 20 Jul 2025 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029061;
	bh=lUk4MtFp0whHxsOBtopl5zSMdusJaLMrYahVZCAa0gQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e4DcdU2KWHhWpk4pv02Gm6hiLJ7z84UIWe8fhgSUpg86oOlXjNwiKm7jxlhja7HSz
	 vDo2Zr5MMlvlbi+smd09BGqEqrhh6pwxV57a25KIaaYQA2dZklW5gorRVuBpIykyV9
	 YnsgbNc4lOLGeYHKzymeSlu7QnwjdV9Dz3ucrCRrnOV4ImPTWDfnVL3P+DSwUygSYq
	 qRS5HNjiChM7OVqnxPGznshGxtjejg4q1ws/fwZIp9h+U1N7aHYOOoyx5h/lhHABAu
	 dqKj+K2wVpGtWiNagiCl1BWVcZFJwsdSfqup4rXorfqIv4CdxMxNT6JtMcQzW0yXiO
	 biLj9oDne++mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AFD383BF51;
	Sun, 20 Jul 2025 16:31:22 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <4fc0f5d3fe86cb5c2d1faa80b619fd53.broonie@kernel.org>
References: <4fc0f5d3fe86cb5c2d1faa80b619fd53.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4fc0f5d3fe86cb5c2d1faa80b619fd53.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.16-rc6
X-PR-Tracked-Commit-Id: c871c199accb39d0f4cb941ad0dccabfc21e9214
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 875dd235ceca6dc1821ea4ba6a7d41cdf0df6a55
Message-Id: <175302908088.3241589.11301765441800977851.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:31:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 15:17:49 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/875dd235ceca6dc1821ea4ba6a7d41cdf0df6a55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

