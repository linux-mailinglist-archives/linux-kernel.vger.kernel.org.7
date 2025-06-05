Return-Path: <linux-kernel+bounces-673992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E41ACE87F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 05:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5521896CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4513AA3E;
	Thu,  5 Jun 2025 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHKN0hlE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2278462;
	Thu,  5 Jun 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749092602; cv=none; b=BifIZDOKmqJhIe3jrSiRxBHpS9d3UL2shyw8KXjPp+kTM0Rvr9CwE1AXiC/GvVZufhsxSPBDGBdc3VxOOj5UE5uKTvCb7DbO6Cz7eizzv4BoUXY4TcIhdKNpxB+n1BdCSs1v9PS0Q6gVMaGCueXzbFQQFoLDcu3C9BEWoXDMGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749092602; c=relaxed/simple;
	bh=puViIcy0fLmx48qFkHTXomeoMb2W/ioS2AUHaXZ54eA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ff2cpH/+M+ibU1ESKx/9hbXi8XKcGsySfJbBtXqR69XoQmYDQgveS2O08dg4OOE5sBpSKwEg5PXyAqzWH0CqKYeNGVzbHn5aj3qkyYAUTUCAM3+dq8R6IzWUzcKSMJQUYxwJinPHo4VT/5vkbZTME0AgFYz6xXonsVfb1/IRiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHKN0hlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3C9C4CEE4;
	Thu,  5 Jun 2025 03:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749092602;
	bh=puViIcy0fLmx48qFkHTXomeoMb2W/ioS2AUHaXZ54eA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZHKN0hlEVfsOXvnmvvpqHgxmMWtvIFW1pTGWoHQb+Q9dxHU4zIBSQVw/OpKL7JaLK
	 UdmPB85jWmIz0vsMqd39pzf9uyzoI/RJlWKLCB2sUKOsUyyDxFtWfSpydxGOOcFbCz
	 tsVuCxjydyXUNBuSV3yHjC7BnJr9JhE3G+qbd6fzfrZlpQLVzexALfJTTa/A8hHy/W
	 CKerneXb9/gXyGM6NZ3aTtiTEF7Y7gICyUesm6grBZKRjqiZkBhuGSJgPQtJCdkZAi
	 dXTlz6Crm9bbegE3pCkteecWnEURvtd37OyxQ34sIlAYLG7ZvZZ3AfQ04Dj5/Zu8vV
	 uyIfM3mhwINZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0C1380CED9;
	Thu,  5 Jun 2025 03:03:55 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd sever fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muDAU9fFmkDERtE_Dvrt2HgC4s9t1wH-uHG6B4vQH39iw@mail.gmail.com>
References: <CAH2r5muDAU9fFmkDERtE_Dvrt2HgC4s9t1wH-uHG6B4vQH39iw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muDAU9fFmkDERtE_Dvrt2HgC4s9t1wH-uHG6B4vQH39iw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.16-rc-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: dc3e0f17f74558e8a2fce00608855f050de10230
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2fec01e89447729c7b9d722a8e7ef9d1184c7be
Message-Id: <174909263420.2554386.1610719925903832578.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jun 2025 03:03:54 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Jun 2025 18:20:46 -0500:

> git://git.samba.org/ksmbd.git tags/6.16-rc-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2fec01e89447729c7b9d722a8e7ef9d1184c7be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

