Return-Path: <linux-kernel+bounces-848734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A515BCE736
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1184B3BBC45
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905D302152;
	Fri, 10 Oct 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNYDjXUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2B3019D7;
	Fri, 10 Oct 2025 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126991; cv=none; b=ZfMuWLWaAZrtXgasVkm+hVD7o7PT5G4Gv0gebcdcTIvjOOGY3kczV2g2JBHjYXZKjMm90Qt2FoS3M6d08CIN4otfRfMM4lvohOF/PUAGM2nGbMFffj5c0LOjMtpgiX4FI6M6rFTnSTkkmqzqhOETGMpXnxPS8sqhbJ/02+oYtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126991; c=relaxed/simple;
	bh=FKgGuDtt0Pnc3/yW4OxO1lKL8OdnmI52i9MqQFrr4mE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KlhvEU3pLIIA+Z8FJBlMmq3b0gNaQt9VcGhJW7u9RZ+Vs7Akmuf7EvJOinpBh2TngIjvM6sMEkWw5XNTZEwJjJllERFlRi6jNcsfj5wKr0h89olUealKqIlqoIPpoVD7TawX2ypgResnbCxQLXx46l8PV+QWJ9DWuHN35Twy47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNYDjXUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BCCC4CEF1;
	Fri, 10 Oct 2025 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760126990;
	bh=FKgGuDtt0Pnc3/yW4OxO1lKL8OdnmI52i9MqQFrr4mE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nNYDjXUN7pPm+7G04HFO2WkZ8UPofgHxAwkmBnmooulkAwBJuItTBVe9iG1bbhrjn
	 7OOyXjPF4iSHUZrVYFAwNCvPpsqWclXKbzlmnRGpQ1CXST/uTbwrYN5Y4m4D2I9EO3
	 pYngtlIQDV8u3+iXksI4e9RwxmHqSRwxXpli7BRV0unUNNaZdGdwn0VJolczSvC6qY
	 qb+qVz4RotSKH6LbtXm/G/chlMZdz1Ap2PqC4xSQmEp6qyEanbXzZLD71vaYfTJCpK
	 5A/RNnapMqHe7bwBt7+Npvpjvzmnn1Fq4qPy3svtfUgWelGohoUAw7pT29llWGMK8Z
	 qzdRFage0xN8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342693809A07;
	Fri, 10 Oct 2025 20:09:39 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.18, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251010191703.GA796093-robh@kernel.org>
References: <20251010191703.GA796093-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251010191703.GA796093-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.18-1
X-PR-Tracked-Commit-Id: ce740955b238761ec1d8cf0590d7e6802d3a813a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f76b1683d16dcd5299a9b67d8ef45fe8d29cb2e6
Message-Id: <176012697783.1109730.8829801239710230932.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 20:09:37 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 14:17:03 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f76b1683d16dcd5299a9b67d8ef45fe8d29cb2e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

