Return-Path: <linux-kernel+bounces-839629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABFABB20A9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8665A1888073
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683D313296;
	Wed,  1 Oct 2025 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc3iDd+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BA313291
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359654; cv=none; b=ltRf29l6ab3fBeu4PfCwhj1HgL8aCHWmxx2q64VyLN26NxcHmKT23Ba2CPQghtYdhOEz4FpaRhdD9qt5cEOucGLgDKaU/0xane4DyDkceK+L1ASWIL3wuKLHscPvOM7IrFZhZfz4zq4Kkm6Egy0HRuNzGKAFPdXeIjKncskwzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359654; c=relaxed/simple;
	bh=+vrZSMHpylY5P4NovQZE9OBT5dYOGMu2TmW7uBprz50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tEq2NGnFUzCEab2BaocVsZcA3P2gF+1Mx1l37eIJwoUKZMYVZ2k7Et1jtx/TWFftG7pxerr4jGPTJ4tyjan7itYN2oK/41gN7ucwIVKWmiDMVyWGk4mXi9cMaiJFV2T0vbVCWFX3syLHw5Po0AFL1V7chptcc35HmZtsGnusaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc3iDd+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C3FC4CEF1;
	Wed,  1 Oct 2025 23:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359654;
	bh=+vrZSMHpylY5P4NovQZE9OBT5dYOGMu2TmW7uBprz50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gc3iDd+cS806XAgqmZmwuf+07SrFctDU2NLMt2lB7GAfLd7mSjnxuwX6gRoRSWZs3
	 zAJfaye8uRJiROEjBqkYfF23Fcjnx4hlaM6jKyEvSCHrG/ynBnK+f/pE5e/TZQ1f36
	 jqJxYEtIFbcJfgxgFS9KXxGyyhjwklW1kZQK0BACDM0zrMfoslrjRdeiXTI5i08Wys
	 wgKmLt/Kjwj3O6iKkvpOG3ji1q/2z8WvPHZ5T0CTQDe1qA3L63/nGVBqEe1zrDWvM5
	 yZY2iUqFG4bnRapdgyHQ7KXELy0y3eYY7AGUoXn2uZwzz3IAnA+gwVVDa+VNxkexKw
	 QRCmoxmublgqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24639EF947;
	Wed,  1 Oct 2025 23:00:47 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <c2wz3qml5mpdyyztgoilddzcjulkqhl3yowznr6jh6r42ghin5@hlmfe6yyscw6>
References: <c2wz3qml5mpdyyztgoilddzcjulkqhl3yowznr6jh6r42ghin5@hlmfe6yyscw6>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2wz3qml5mpdyyztgoilddzcjulkqhl3yowznr6jh6r42ghin5@hlmfe6yyscw6>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.18
X-PR-Tracked-Commit-Id: ca50b295fd473ef797b69b8538036cca716f3d55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dba8acc3ef34ca5189d393b0dc4d3cdf0058fe49
Message-Id: <175935964620.2651312.4949792354532890394.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 23:00:46 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 02:02:26 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dba8acc3ef34ca5189d393b0dc4d3cdf0058fe49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

