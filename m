Return-Path: <linux-kernel+bounces-737293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF41B0AA59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8490DAA2368
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405722E9EA9;
	Fri, 18 Jul 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLnPf4wC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03612E9748
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864596; cv=none; b=jJ8las/SUyiWPnwbkKOKJ2GOKJU8pvo/GtfF8uMmvIFGzUQ7u4WolHXPA0OyUQ5iisKszK5yCC4+THKtV6ml8ujOOOPWhuNDVkqxVJbRfp653UuQgfxOsxKH9+FNex5RZMnmw5UBIw4m+7C2heYpa4xDtz+Li/X5YLGHGBYwGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864596; c=relaxed/simple;
	bh=LgNyHVcCYFsR0OE5JdraPux6MKjmJAD2mC02gWfBFro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rkI0L0JjM12wDw2QorYX2CVWvhb6H7ow4u9jfyecmvxa80bHCSNENYKogyG29dchZ8uecA6q6qO8MD+aS63zFmFeWBMKiT9zCQ2F5aG1r/OuaoR8ee6mQ4PBNhwGmESdAY0b+4K2H4lbH5lOk1qqAKjxQimbwbwTeitto2p0Uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLnPf4wC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8287DC4CEF7;
	Fri, 18 Jul 2025 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864596;
	bh=LgNyHVcCYFsR0OE5JdraPux6MKjmJAD2mC02gWfBFro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZLnPf4wCScPHa+pNkS0g0c8U/PK8rPCPWRrDD50oq5hgBNS7xrIfBlgXQeFZ6+rOV
	 2Xgjk+P4w3r3DXSu/jdGNGsXL1ktgti06hWEieNc49p94Ezbv6/naeSeW9vSZ/JbTX
	 isljPb9IhRsGfjbwA/3weqtfST7/4BYPVPyaSLOc1SkHtDCzZVc0MTOfMd1ZfTcyVa
	 6kX3GNeJQjiJ6oXHmfOQNdFy1+aPqzYUxg7XR1+lmu4mivlrLFchNzwkl7DJwNDBYF
	 wf8+hmrg5atx+07+f44SZABMLMXvQV8GrqyEZdbMHm5+r7z4UeCAQVqpEPRXHcjbpl
	 pSCTx38mqpwwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C51383BA3C;
	Fri, 18 Jul 2025 18:50:17 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHnzxqKFj1jgxG_v@vaman>
References: <aHnzxqKFj1jgxG_v@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHnzxqKFj1jgxG_v@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fix-6.16
X-PR-Tracked-Commit-Id: b7acfeab8af9ee661c933522132f3d1d92ed12d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b35eb8435fd33f357918f2aefa50357695522e3
Message-Id: <175286461647.2758519.7061039007885514276.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:16 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 12:42:06 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fix-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b35eb8435fd33f357918f2aefa50357695522e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

