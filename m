Return-Path: <linux-kernel+bounces-724303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404CAAFF0F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358261C46A5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA61233735;
	Wed,  9 Jul 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJf4DHSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D023507E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086202; cv=none; b=rVwezDGhyBwjD0WAuFNs0UfaQhuXJ4A/2xQotlDV6PMDchSN1q5ZvgBgvh6HWWc228m3EWyfqZLbO6YNsJ+qk7UqFNWgahMJ5RlEneKj9Jn2EKx8MQM+t0YK/dsgCq1N+/1/eNZtuP03FfXyc9gpe7cmeURz5u1WzR4ixJY6K44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086202; c=relaxed/simple;
	bh=Hx2Z8LWsM4BgshqAi1E58fO9f58s3x7Ck2+xgNr26Mo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ASTY8t9bax1mvlvM/wvXIqzmAluB8GZeedEbm4rsSXxZR4NdcpIqzHssZy9R+Dz+gl/Xi0lQFVRt4dkeK4l4BT9vq0M9Vz65jSenXyH+ixt/I6ugme3yyPaUB2l1yclLa6kHDeUXDc9BAacBJmABfwHyY6IBh7fEfD3KdnZ0X24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJf4DHSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58CEC4CEEF;
	Wed,  9 Jul 2025 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752086202;
	bh=Hx2Z8LWsM4BgshqAi1E58fO9f58s3x7Ck2+xgNr26Mo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJf4DHSkQu18uwAt8RJHROsrf5O5r80eM0Ic4O3qPdtwrNUTuqvOL2u7DtjiP6R1g
	 xDmUvN+kFdyKke9ZFY43TGA4RUAjO0EDYW4vMJY7fA4A5QZZ7qWfdPDV8k0d8rPLRb
	 uFm/A/dQw+XbPx/9Hqsmz2KyC3uGBlSlkHGdXTfFnqmJuwtHWzN1XuOWzdJRiTRfMH
	 e0pcg3fTMo2VyMNfQLK9H64MVWPx4PA4Nq+pT4pjEY3rn6U0+PuOXYhJIc5EuMptIK
	 uzTBo59yYzR/38ce9EpM1JWc5L6t+gens4ILrXg+1ihFJGNvz5XQ2ybXQ7pHJEPwXw
	 u4dbJs+z9D/kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF13380DBEE;
	Wed,  9 Jul 2025 18:37:05 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aG6GAKc8EV0cERsn@willie-the-truck>
References: <aG6GAKc8EV0cERsn@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aG6GAKc8EV0cERsn@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9dd1757493416310a5e71146a08bc228869f8dae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f69f5aab1fad379bbef9339f66bc8323daffe56e
Message-Id: <175208622434.814034.11084342849878217311.pr-tracker-bot@kernel.org>
Date: Wed, 09 Jul 2025 18:37:04 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 9 Jul 2025 16:08:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f69f5aab1fad379bbef9339f66bc8323daffe56e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

