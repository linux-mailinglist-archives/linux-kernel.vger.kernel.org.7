Return-Path: <linux-kernel+bounces-804722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F840B47C0D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E443C1CBD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCAA28313F;
	Sun,  7 Sep 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8SrCPTG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C925A331
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259143; cv=none; b=N2ClbihIp5LDLOBdf1jlZH3tH6AXvI2gaIWHn0z5QCbU/50AcU/WSZNV5AzdiI0iLx5FUsaUGkZjNrBaBhfYCCM2vg68y+76/S0yYIXpK98qC77zc6sqWJtYQybXfWfH4GbWMTfKyVUHKYx22CNeXdoRsVO7zDpaDD+FLVym1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259143; c=relaxed/simple;
	bh=mY9/IMadYtGG3Q/PozD/fi116o1/XlYJhUZ3Yod0klQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qJuZfTVzDTU4b6X/IkAhdhucWb033+R+x/Yxeie83tR1muNeqFdcDrkcf3+wobPVwMDRs9ElWoVw5o1tbX2zVe7VsFB59DJP1Fm+zciEiKm285lJTj5RBM/mYjEGomflB99MhV3BAbsDA2Prr+Xn5p9n9C/bDZl26F9VcChWamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8SrCPTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B14C4CEF5;
	Sun,  7 Sep 2025 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259143;
	bh=mY9/IMadYtGG3Q/PozD/fi116o1/XlYJhUZ3Yod0klQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y8SrCPTGsnjNcF235KxhwGvIRKiu4C+n/VYC3Vwu/pfHLFzjvEKEvwxneKNgXeheY
	 LbEovD7a3dQBq4Dalwkz583P2i2d3VQqR8nnCPyOmd/CVnIZ8mkSpW3jfER5jVixXD
	 g00e4z8DjbhLa/bH4ApfXZ6aeiZDy37ERz1yFE1KDCniTInSmLXcmYugv7En2rDrqQ
	 MSPNdaFoV5tMO1rw+XjLhJfGxP08QzO5Y4AglDii7oC/765UtkkHKbUw8aaJCXhJK+
	 Z7kGgQubTs/icJAf6KPZ1qbairF9mlbPwcQtwfmS4oEjLPQ/7f/Hd2tKlgyxOsU5E/
	 Hs3Dl3I3ghYwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B56383BF69;
	Sun,  7 Sep 2025 15:32:28 +0000 (UTC)
Subject: Re: [GIT PULL] timer subsystem fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aL1gCBN1MlhGPAja@gmail.com>
References: <aL1gCBN1MlhGPAja@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aL1gCBN1MlhGPAja@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-09-07
X-PR-Tracked-Commit-Id: 762af5a2aa0ad18da1316666dae30d369268d44c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ab41fca2e8059803b27cef336d2abe7c936ba0b
Message-Id: <175725914709.3081192.1510886894111493541.pr-tracker-bot@kernel.org>
Date: Sun, 07 Sep 2025 15:32:27 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Sep 2025 12:35:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-09-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ab41fca2e8059803b27cef336d2abe7c936ba0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

