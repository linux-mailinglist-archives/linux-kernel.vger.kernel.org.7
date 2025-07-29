Return-Path: <linux-kernel+bounces-748999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A80B148B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB387544F29
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86363277804;
	Tue, 29 Jul 2025 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hin4gogS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6922275B0A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771813; cv=none; b=Ig348sycFpCC+1TLfODDb8rqKaJnBK5zxyw3+wRz7/Uq6tNtm+XzdKh4Uf6H0+YV/pKbaKcx/eOtTWXX+oaD/N1AxzTv0D3hf4yF7o52jklxo82jQDioIg/h22PTavQXTvqo0oh8l2kh0Y+quxrDbP+LSL5l7bbqkAQ0v79BLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771813; c=relaxed/simple;
	bh=ZeCFUTYECxnF6TcgMOoHvZ6jHxABklU4FilrYrKxhio=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TSl6vjpPlIOOORV+LXbzDc4apOPDNDznqucQxLZt02h7SBOLwgvHA0alqwZJfaquU+SqySRZh9cutGVyXOI6VyYuNIuSafixzSlqDwLZtSG7areICRFsmLuatspK3YgR72/GV2rUTNSgdTaCc4r4VNxfY+QIZ+l81EsaxkQscJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hin4gogS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2D1C4CEF5;
	Tue, 29 Jul 2025 06:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771812;
	bh=ZeCFUTYECxnF6TcgMOoHvZ6jHxABklU4FilrYrKxhio=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hin4gogS7SZ7SPOhRy0C3XN6KPq+tGyP7dzZ19O8tdZUkeKgUUoVx7rVqMK5DgOXV
	 Rb0TBtYz/gAgFKNd3c2/zz8Gf4lzsMxrteb2pc2jSEO2KwxzAE6rvxuSDB4YYKKCGb
	 J/nbQXHJbZHgMJ+Py5raJt68RaHkMxIbogVzuuk2n/bBQLnEg4Uqeon7SjR3xnifFA
	 LF3GDXKlr6fPg/092p6Fy1/619F0E4CESH3f28ZFi2TzSJ4bdEky72/ZDhAnGSGqPE
	 23mKfiXVI3Hsn/1kGjwNB0XXdF+v2BSq7+JZW44hC4/8U+hFjJdw9Ej+T4XVEYBsNG
	 ar4gezI5Nrzng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851A6383BF60;
	Tue, 29 Jul 2025 06:50:30 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <a887f34ce497dc8d6b92f087e3cc3a65.broonie@kernel.org>
References: <a887f34ce497dc8d6b92f087e3cc3a65.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a887f34ce497dc8d6b92f087e3cc3a65.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.17
X-PR-Tracked-Commit-Id: 0bd042ae771d61ef7ccd5882f7aeca59a25f71d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf977a9ad33d204c8ca646cef83184eb364820ff
Message-Id: <175377182945.1356386.9040382262700855918.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:29 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 13:24:24 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf977a9ad33d204c8ca646cef83184eb364820ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

