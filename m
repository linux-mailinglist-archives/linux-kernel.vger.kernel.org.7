Return-Path: <linux-kernel+bounces-836864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11805BAAC02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25914210C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8634D27F16F;
	Mon, 29 Sep 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+EP6hyT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA3275870
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188179; cv=none; b=rlVKEd9pJrNji+oZ3UMUaQ4z7Z9wGTEIpNPWYwt1elLfUEdH6+hxxdE24jHeDlQsAQ84HiWuPT7lMkEABmOsGy6pnhKWhBNvvELn85gT5w7QgZDrA3XVKLgMReflUbnkAMAhutUy23lP9T4od6tyQG//Qy+WySIVD1Hiy8iJjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188179; c=relaxed/simple;
	bh=mRXmguWRKqQeBkWx0PpUv1EQNoYuDPaQjTmU8rHZpS8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pe8wojVVImOl13V2qTIIxNnT+UCTTO2rAalPepcJMnKxzF0uwVPNT5luU6uXAyUtkk+qgSJGy1ukdFWxSTvHuq2Wc3C0VwMshadwNfM7pU/NbcIrwC+lSi7quPa/IIMObTHyNwSDQtCPE1Edi1UxtSJgMhhQfOe88NQ0zUrj9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+EP6hyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7691AC4CEF4;
	Mon, 29 Sep 2025 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188178;
	bh=mRXmguWRKqQeBkWx0PpUv1EQNoYuDPaQjTmU8rHZpS8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H+EP6hyT17VCAipO1qpt8o3LCzwOzM2DgLOq/w+b4xEKfD08S/CRzHNt0rGgvYcqV
	 Qz0VObHdiU3VH1omUxeU2ISBFlJmKLzqglmPohOnJVs3bXEbUcyy5IqWmOxFhO9Blz
	 ZySnp0Qnenn8VujcZCFlo+EC/zjhXKfsXWRDxT1rHohRFfs2cx7Qo2hZbWM9EWBK1V
	 RbzB+g5IWT1hnMTbBjnSLpSbsVoyKxt4FgiO5DLgQGITcQYlWUF40wYpR122A6YojK
	 eK7HAdDCBxeDWeqeW4UCxTqtduSWk4wJQ7pdvCn2p83Vr3xb7GUNdCo7/B9BRzRQ8I
	 /wDBtI7EOOx0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBF39D0C1A;
	Mon, 29 Sep 2025 23:22:53 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNqZE+ex0ci1etXU@debian>
References: <aNqZE+ex0ci1etXU@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNqZE+ex0ci1etXU@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc1
X-PR-Tracked-Commit-Id: e2d3af0d64e5fe2ee269e8f082642f82bcca3903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5928397f5739fb94559350575826d94fa8c35929
Message-Id: <175918817183.1748288.12528740975921892274.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:51 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 22:34:59 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5928397f5739fb94559350575826d94fa8c35929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

