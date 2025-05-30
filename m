Return-Path: <linux-kernel+bounces-668625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF1AC954A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5D41C2433E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D42750FB;
	Fri, 30 May 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1TwhZe/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B86275844;
	Fri, 30 May 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627496; cv=none; b=SW1PLlSGNHv3LeOnL/STEa0/xyp1OPcivs30CdAkNe2zf69YCMZOETHDkkL4r8KJXC0gWhKialm3ZK7t64MOW7NBQ0K9swTTuQUshrXoFW1vBT9W/bf3YUqr+OzB0QAAVmO4TOvQSs9IA+VOeVj3l0OqwSPUnBVeoOwZJqUg7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627496; c=relaxed/simple;
	bh=EASUUD4qyLfg0Po2bCeQbInqvYTnMlOcq8AC7xmSvIg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AilfUOIwWqdiefv86IsigOdK2k0JyMqxeNkqz8w2zJQEvOdtKw76qvu/LJe/gkO5Y1PrLdW6xUT9FxFEFBP9QxRIIsRNtZrrX4HeJ75ApGy3b9A8cQ2XIKMbml6KQMIhGh51PX5vNHswPYMtXEUrQilKM3tgzaWVdZV/12EL5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1TwhZe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF08CC4CEE9;
	Fri, 30 May 2025 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748627495;
	bh=EASUUD4qyLfg0Po2bCeQbInqvYTnMlOcq8AC7xmSvIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j1TwhZe/kVcOoM4BMtuVxKZI0URaVA+4KVUdnSCwXtGocHDbzs62OChxYf56f0cay
	 0PdsbP2W9BaGYbpGOXH/AvWpTeqf0lfOkTQx/sm+0qpYsPZs7rX5qdY6CgwHOPjNnj
	 IbUnCzNucwEyofrvaQ4dRyA4QM9axTfh6wyGqEH0ybP8K5bNEG3VIsxvFGnOErKBSL
	 TySdCCY+PMUvAFnf2Ya492zhAQuzw/kJgHwzrtjJIEhcdXyG+vymm34f109gGwFu+Q
	 dyZmWGIfh1fWeQd/bhHSwfoNqeTWd/i4cHeTlhgfVyDY5WuB9uWJ1mLe84yZc4eafS
	 Lly9SXdOWDXyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7142D39F1DF2;
	Fri, 30 May 2025 17:52:10 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDmght5YpHmJ6qZ2@8bytes.org>
References: <aDmght5YpHmJ6qZ2@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDmght5YpHmJ6qZ2@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.16
X-PR-Tracked-Commit-Id: 879b141b7cfa09763f932f15f19e9bc0bcb020d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8477ab143069c6b05d6da4a8184ded8b969240f5
Message-Id: <174862752903.4058361.1021172028826066641.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 17:52:09 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 14:11:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8477ab143069c6b05d6da4a8184ded8b969240f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

