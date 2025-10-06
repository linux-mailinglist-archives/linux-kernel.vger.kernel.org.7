Return-Path: <linux-kernel+bounces-843332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454DBBEF52
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4A73C4AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0C2D94A6;
	Mon,  6 Oct 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVD+MZ9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73B2D8378
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775343; cv=none; b=HhYrVkeatbk7+4vLhg+iYqby/qVYaJW79cJYo74fifb82GP48k/rfaj2cqv8Pghf1t3LqPrPl8TS+d9rBt7PybXn8ijI1LgFBQRUNeh4Bw7RZy1fVbhLL4dd1S/3J+GhmNAXYHqX+//lhPL7eg/PJ/dj114rPBaPSw/h7gvPFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775343; c=relaxed/simple;
	bh=7VGYn75dnSkc8YwAttXA6Ax/zqR7ljxRuDtkdSeRO/Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=omGhK2F9cKHwEFRzmX0jBJnAoh9RqaSDdCpjxVh13MyMc5P1Ob1B6ANsXvyh/8RGrlUHgrgVaa3YQeAl+g+h00OQS7IClshAO/YttlO55psrh18THa1pGc5VpMiPwBV0jtbGz147hZNq2DweNbG1uhGmZiVvmHe03fVYZLpQN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVD+MZ9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0DEC4CEF5;
	Mon,  6 Oct 2025 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775343;
	bh=7VGYn75dnSkc8YwAttXA6Ax/zqR7ljxRuDtkdSeRO/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cVD+MZ9GyE63JCxopsoz4E7sMHg3C3rUTkHERAbNut4NNwo7Hd9T3LhAVHwkgSR0w
	 SIv28pxKBW2a6WF2212K4fxGVgnu4fIqULG6p4p9jUzTObJnWjEvOnf0gg3cUmzyno
	 9Zyn1ZCHZ5+7sHHzL9vdFIxdEY0PrFDmQE6AOQ9B12gwD06R+J0bojj3KCN/Eaw6jE
	 dfOTmv8ElCQOCtDV/A7Tu5gI7ywdZ1Pjt1GK8BGXcjLgGJdURQ0tLGKRnxzq+M0z6H
	 ECIkwYdhgPNf4Mh67zZq/whFxa/DpZupaQKtDn3mNbBBVKuDhiS3+Jkixtc55eldWy
	 c0FLpb9FWRI8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4539D0C1A;
	Mon,  6 Oct 2025 18:28:54 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy subsystem updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aONwiS57g9IAefP0@vaman>
References: <aONwiS57g9IAefP0@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aONwiS57g9IAefP0@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.18
X-PR-Tracked-Commit-Id: bdb978979ed133c47e19099ff2a4ae51e515452b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d1ba4d390141d602dbce8f5f0ac19a384d10a64
Message-Id: <175977533306.1510490.336877531445390395.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 18:28:53 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 6 Oct 2025 13:02:25 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d1ba4d390141d602dbce8f5f0ac19a384d10a64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

