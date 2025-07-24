Return-Path: <linux-kernel+bounces-744704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F44B11001
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9773A23C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6F2EAB98;
	Thu, 24 Jul 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3BqV6fV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DC2EAB66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376196; cv=none; b=HYP0YR2OogfVyZ40SpArPPrZdhQTKnO9p5INhCb3qrPdPhQabBCwNVot7qALP2b/H1wProBpk2h366PUcf+V7yfRY5KkJRRD3vVoFX5FgdPb6vBvZXf08ArldyvV2zXkK7LAqqc27xrzkoYnaosYubwcG4HyCBiWXrxNxhw+RZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376196; c=relaxed/simple;
	bh=pyk73s/rNvyurZ/Ot1PRShVA7sPCJz6bljzDW6hOjs8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rby4ccjiX9izB+OxEyEodJcFEenSeZUDlptzPyAgR87mROBUvsUYC3dpc9r7p7+ESA3VPvtnHj/ppSo6u2LgsG9h+bUcwTDfNUk8f27Wmm82Ez8k47mOIPNVBSKjij8pGqjwmmtgjcR0nKn/jLJYbvqetf2IbjXyUMvMxEb0DrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3BqV6fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48670C4CEED;
	Thu, 24 Jul 2025 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376196;
	bh=pyk73s/rNvyurZ/Ot1PRShVA7sPCJz6bljzDW6hOjs8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S3BqV6fVfx58PLGUujWa7vx80h7Wx+6l4PrLsPRviraMYNqZfPSbZs/9UqdkwR8as
	 VhrKgGaEZgL9I3TSOBK+iLwGbaOHUSARhGB06kJVy+ViO6X8WKojf5mU8tnJv8llsE
	 ueHgYP4N2VIRUmNvNWcv3hVL7l+egQdx//kdN1TEYNPFTPTLzrNzzp/y7Q+j+KnsN4
	 Ayvb6tPwYL37hPa4EVX8pMlxONyeVFyI+m7jFRQvXnciGCPR2nxDqXfwozX5wwgVRd
	 qg+2tGCK8vlgSLp+p5UDhPz+zl5GHbzIneAfsVNjhnob6u9kDF5cIU0HsGSAQnXxUK
	 QWP6BxlyiMJsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 69C71383BF4E;
	Thu, 24 Jul 2025 16:56:55 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIIAZiQ6ca3DFHpE@willie-the-truck>
References: <aIIAZiQ6ca3DFHpE@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIIAZiQ6ca3DFHpE@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: d42e6c20de6192f8e4ab4cf10be8c694ef27e8cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cef6c8c92fafa58fa04d8622e89ed4871d121fc3
Message-Id: <175337621396.2464257.2491131967302422873.pr-tracker-bot@kernel.org>
Date: Thu, 24 Jul 2025 16:56:53 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, maz@kernel.org, mark.rutland@arm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 10:44:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cef6c8c92fafa58fa04d8622e89ed4871d121fc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

