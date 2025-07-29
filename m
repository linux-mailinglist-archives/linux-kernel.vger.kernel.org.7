Return-Path: <linux-kernel+bounces-749798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFBB15302
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6539618C2339
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542B299AAF;
	Tue, 29 Jul 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUBPVPag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F929E0E3;
	Tue, 29 Jul 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814443; cv=none; b=e6y3OFo4iVrw65qnH8etFjZRiu4eUpIA1guiBMlheNTdzsVHApnHavmUaT7KpwAq+A+uZ9MR8alqY6WQojRstQZxPd1wAlCJL7nBblk6FhCc+mQPok/FS6nk4QWH3b0LCtEjo6NNrlRwKakD/2yB5+HqlQ0s3uq/KBqhA9jij68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814443; c=relaxed/simple;
	bh=h4XaBnZGq3CZrkr6uQn/PSFLlCUkSylzmY0smerqPQ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mzjXbKv66rXAKhqzRYLjPPpk/Ill/WQMaf1e62zSsOcELqWBixrqxawGoEVu+VKWNiizzyAri5ZxianqWHqAj4ygpGo9T5L0f15TUyeACNa7rAYXaEHvZ6f2if5oT5dPfhBGlg9wfv1l6Mmx6hSiMJVpYiiYCFjS0RYcOBZ3i5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUBPVPag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A92C4CEF6;
	Tue, 29 Jul 2025 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814442;
	bh=h4XaBnZGq3CZrkr6uQn/PSFLlCUkSylzmY0smerqPQ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GUBPVPagK01dRShDBmDXq5F3jgRjEYTqGekdzYYYjUBimaDMY00WOj1d3kPDVosBX
	 px7kJ9OiuzgiqWuqHQOaYlMa/lApsVBPMtE49Cj8+ZBDyxmfj44HyA6Axvpn31NPgH
	 3ID+wpgbTBfYln2J2uJQBnNPK9O+OntJ2nuueNw1LYMCRoCbzqXP0GETIDjC/+Kygd
	 8+gCZmYJeEGTNSkNCiACHiSvKjx948lgI92yWADDIw04kLiz+w92d/RtUa2KVMy55P
	 EaFU5+4H8kRY4nv3wbIj9ax5EPvdH1+QcBKNtFIVFHK5eJ7Fzlq3q76b6ssygA4RZF
	 nZILY/G1K/w5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6A700383BF61;
	Tue, 29 Jul 2025 18:41:00 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729015048.GA235874-robh@kernel.org>
References: <20250729015048.GA235874-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729015048.GA235874-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.17
X-PR-Tracked-Commit-Id: 0121898ec05fa4c1f566fc05c7e8b3caf0998f97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69f2970aad93758bea863432e49b564e0ba649ca
Message-Id: <175381445919.1585410.6589342284536349047.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:59 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 20:50:48 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69f2970aad93758bea863432e49b564e0ba649ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

