Return-Path: <linux-kernel+bounces-803415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF5B45F92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052F3562F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73172309F1B;
	Fri,  5 Sep 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKHr3Zag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A20306B1B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091988; cv=none; b=W096afmpTDg39Fz0so61MgStWbUlhGeWJdRWDcfwCjRzp5KYWwpIi0NXkdRPDuep3Faxu6rP1e5Ogg043pCHqzO4Ul7JgqhJCIPHgh4aVgtR2V5p9x1vo+xHo5TvVQLIBBBcCuAcdVKbGUYgPCAFqNjo5IzyAPlJxEAlGgnUX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091988; c=relaxed/simple;
	bh=tYh35AYJ6Wvh5wwAnaTijSPtjoMtOJBNFt5DalI1foU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cl2NwUYCsFiEjNQKjEOxSJGIVQgyBa9Zih920/QocKhO8XwnGI4yQ0j/JLCH5AI7Ktxj/5KzhJUoD5BrWhekUlfHRI1luuRkRC/pDxej5QCZKQzokWz+ZY8FuwY2cfDywLyG+j2sWNE5QQQpWNNGiAD8IZQmDLUMRx+MCSiMywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKHr3Zag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4649C4CEF1;
	Fri,  5 Sep 2025 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757091988;
	bh=tYh35AYJ6Wvh5wwAnaTijSPtjoMtOJBNFt5DalI1foU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KKHr3ZagMYM2mLRat8FC1MecLswT/EeJ5I27OOsoqQCqwghLK6yipgRpYz5vzGUen
	 656pJ7Ez54wQ2tgw1J8LSazQE5iVy5DWdfMEbaMHB3UNhTy+b3+NmMGSPf1f2La+2g
	 4i9/QiyvVO3/JIj8da+ygvS9BNsEuWq4OiDqH9seHOOxrXJr36w2cn4/DiVVUGPh6s
	 C4KeH98FLccqUo+sNRuDChGT1tNqKRV/TN/131eDdGVCS/Nxqg8VRQ72Jeii0Zqts7
	 0/Vidg+jUWgljKWnMo28exPKHBWc/0UZhQh6yb9qALb87GdU75XjtQtpuWIo5z1rRF
	 u53Cq7X4X3XHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BED383BF69;
	Fri,  5 Sep 2025 17:06:34 +0000 (UTC)
Subject: Re: [GIT PULL] PCMCIA bugfixes and cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <aLfTTBltkS0ONZlZ@shine.dominikbrodowski.net>
References: <aLfTTBltkS0ONZlZ@shine.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aLfTTBltkS0ONZlZ@shine.dominikbrodowski.net>
X-PR-Tracked-Remote: git@gitolite.kernel.org:/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.18
X-PR-Tracked-Commit-Id: 4a81f78caa53e0633cf311ca1526377d9bff7479
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e47e46718c466d90f7a452579f9ed1a7c250553
Message-Id: <175709199290.2623294.7243427300720437042.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 17:06:32 +0000
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Sep 2025 07:34:04 +0200:

> git@gitolite.kernel.org:/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e47e46718c466d90f7a452579f9ed1a7c250553

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

