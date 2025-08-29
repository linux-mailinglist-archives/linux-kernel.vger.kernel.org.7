Return-Path: <linux-kernel+bounces-792168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A5B3C0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815DC584FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9FC33A009;
	Fri, 29 Aug 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeFTVAVc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED2338F55
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485577; cv=none; b=nxfJe1mGHXsvF04Uqa2lkycjbeBvSlVzUxwweNV0wXhTiGSCKh8abbkqV3lwNM9qytgc78uYsMGlumrZV3RDl44hRatnakQ3+FLsVYj9lv3NxWq/nxwH2jRcsxGTgwlZKzDCZ0KoPBAIPrY+fKjTNTO7qM3Ogz6sQtE+iDY2ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485577; c=relaxed/simple;
	bh=uoJosz2+VKXad/ubM7qraSbtwAg45ShkwS/JnIKK+38=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qkZpaK9ud5bu8sKe+C4ygQcH2O21zJLcWbLbJ+TnG/MxiRfmhZ65aHL9HZpC5oEqqGf3gEwLKZoqqQxtrFZO78UcmnFaWgau7lmr0xZv9HfK2xHD0Bl/c8ln1kDcwVes4Dn936ToTtfPvZAPt4c/vToerhsDGvboTNOv98MYFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeFTVAVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B199EC4CEF6;
	Fri, 29 Aug 2025 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485577;
	bh=uoJosz2+VKXad/ubM7qraSbtwAg45ShkwS/JnIKK+38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JeFTVAVcXkDg01ZJBd7ovWmENG+71rOKMIZjBnHW3U77UzHMHc+C0Ff647ZUXdOAy
	 pZop0pCNNcA0y03YCdsdlwVWPfzX0q8S+DEKasfNClgLLbRtdqAS3KKmpIQUGLr9fr
	 oy+pgEznUzOIjbgtQ7rRYfBXSKpEy1rEnNm+bGNmfeBICbdo+APwpivbiu8Mx7r6hJ
	 tJpzMdOu7KWGNnem7jfeuTPXtpcIHCmthA2SxzK1kg568jYYzsMUCxvG+rZDOn8QkE
	 s4jC98LOPQFqCvcKGlZD86egMgP2es3cppiEQOrg6G1AdSXoIInLDpmcdYDllC2pUM
	 Z8ix8tLDOF6lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE015383BF75;
	Fri, 29 Aug 2025 16:39:45 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <95ec661014b45484c239a057b6d954c0@kernel.org>
References: <95ec661014b45484c239a057b6d954c0@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <95ec661014b45484c239a057b6d954c0@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc3
X-PR-Tracked-Commit-Id: ef3e9c91ed87f13dba877a20569f4a0accf0612c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec1abfc8333110b9e645cd59eb3bc0541fd5bd2c
Message-Id: <175648558436.2275621.826679059451117925.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:44 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Aug 2025 11:09:52 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec1abfc8333110b9e645cd59eb3bc0541fd5bd2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

