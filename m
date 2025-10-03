Return-Path: <linux-kernel+bounces-841778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2EBB835F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BACB348C95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8E27AC21;
	Fri,  3 Oct 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrgJ5YoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD127B352
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527203; cv=none; b=Z8cJoMBvhJFUF/SKDf7SpBepvTF+KFPjeJOVXIU63w3tg3o0AlFPBc0npHu5aU9kGCaMTr+S/ZXs0pdtUIM8M7nho/XEWnvwAkQfj37DLoerzGvloDSL+pAX22rkCGRb3Y2R/KnQ1SxLNQw0aakKMacNCWf7QBCUWPXAoM33IDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527203; c=relaxed/simple;
	bh=gFH+K0zTaB+S1SUCL7G/S6JbiAsQ2i1eXn/174rZBT4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e4/q3SunrBz9+2Oy5m/LvAaNNg0MF9WD67M5yNAcUzhbXs5yYai9L15r5acESS/whSJKbfrzGLhxNau+bmIStESWbZ7UNWfDWWGGehnPM1X7WKsSCazofIstnrsFFalenf6UQUyDc2oyf1MnXZbEEPfawfBGeg+WU0vfXZR7IAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrgJ5YoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E834BC4CEF5;
	Fri,  3 Oct 2025 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527202;
	bh=gFH+K0zTaB+S1SUCL7G/S6JbiAsQ2i1eXn/174rZBT4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JrgJ5YoRyz3maklzPKAMXQi5rHThOO2g9MNZkjKZszdcGsULGJdkhAR018CDHiABS
	 VwnprP8VZgKnl91RGOqS4DCGJrzRXGfQI3mY+tg+2EyvxqlTq3zSOdaknmVdwQSZeJ
	 W8o4VvkIcJIV82LWTlTQMdJeDCepheE0V/ImicxrzCwtMOlsTUPEtL1MYtNMI/CgxC
	 fLeLPtpC5OxCpcQvSgc69llkiFvkQhAKk4EE9tSBZRHWcOXC5AMBmd7zHf/PJQKlNK
	 Qx5OGQG7lKstvhqFsk/Bajt/RJPOusj15K6rt9d/mnmopSaesItm93h5RQw/rad/zn
	 btIcW+WbUH9hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7839D0C1A;
	Fri,  3 Oct 2025 21:33:15 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOAOS864BmSwjfGm@google.com>
References: <aOAOS864BmSwjfGm@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOAOS864BmSwjfGm@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.18-rc1
X-PR-Tracked-Commit-Id: 4e715744bf7b4e5521cc3b77f310060f862cb719
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86d563ac5fb0c6f404e82692581bb67a6f35e5de
Message-Id: <175952719403.86168.1769122833708943464.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:33:14 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 17:56:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86d563ac5fb0c6f404e82692581bb67a6f35e5de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

