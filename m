Return-Path: <linux-kernel+bounces-676232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48339AD0918
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CF53B5C80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6D6214A97;
	Fri,  6 Jun 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olS/jM+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5021CC4D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241820; cv=none; b=ahAEPldyJBMSwg5z0UwM26Rlt1ifBHrUyHxCmNhY2Uj/udNz0J/wSxz5nWfmT2E88BAjVG22wSHs4vbcVaItE2DO4sAnoHlQU9tXXS8vgTjfq6gXsnQ+2cqw0NKVzFMGOF1shOQ84DyamonnmDX/8n1LRnxZWiFTD8THXSJpzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241820; c=relaxed/simple;
	bh=qClHSvkypT9+TRjOKsntP3tSctkRqSzJG5/vB2N9Saw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k3cBlFD6HjGDlI8XgS95vfAaq+nYSOM/3PB4V9V1dc57lLkg40ctr0XUqbd+J4f9MIBB41o2SiSqrWzKID03hioAx9ZFwdVaG0yvT1sfd8JAQhtybC/vwwKcmj30vysyRhSRevNXWX4NdElUUVYZemOq+/n0nABXvGC+hc4pq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olS/jM+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDFAC4CEF1;
	Fri,  6 Jun 2025 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241820;
	bh=qClHSvkypT9+TRjOKsntP3tSctkRqSzJG5/vB2N9Saw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=olS/jM+DsGtgA0HY/P+VaVHP64uWdjj7UeID/iVnio9gBZMntAJUeOkKfzRLBixj0
	 eJnvZ8GrXNYWODJF/FYqXuAVr3K2cbdKk3ScW6W7CSaVU7Jjy6+oqnCvnoVbo9+hgU
	 ZAc/CGncnZt4BSaGAce4RkgwS1adLts+v9h47Sv1Qa5vTLxd9tbkZF/+h80aGt08lu
	 fmAQspQTJ2xNLA97ZTLpy4c8Ec01QfNEovaPcRiDOxa+VHGjarPOTAUd0WmjgOWAKi
	 t59D3Tnbi/HCvEWolZn7n1DpKqiiycel0necJJn3v2d00sisgVCi9NzgcAfDv2hlxr
	 493xTgz+IK3IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3DB7639F1DF9;
	Fri,  6 Jun 2025 20:30:53 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.16-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <8d81a11b97b3aa5a588cc136f37bcf25.broonie@kernel.org>
References: <8d81a11b97b3aa5a588cc136f37bcf25.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d81a11b97b3aa5a588cc136f37bcf25.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.16-merge-window
X-PR-Tracked-Commit-Id: 65271f868cb1dca709ff69e45939bbef8d6d0b70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7582bb0a4f54979cef625df35ff9fd845400769
Message-Id: <174924185200.3981198.5256737915744950790.pr-tracker-bot@kernel.org>
Date: Fri, 06 Jun 2025 20:30:52 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Jun 2025 15:45:34 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.16-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7582bb0a4f54979cef625df35ff9fd845400769

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

