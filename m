Return-Path: <linux-kernel+bounces-771544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B403B2889B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE60C72843E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CE2C3755;
	Fri, 15 Aug 2025 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWBORuT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD624339D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298996; cv=none; b=V7mwKavBCYvMRcxbu4c07sN9SnCqGzYRWJeI8U2977wCbcLRstMA1/Ewfzpxc/8trxA7p2RmBwfXzfVzwaoKXddjiHbxr+qICUJLIZN1t+evPm5i8uxyQNx2w7iYxobn4pT1tpr5gnVimF66ZUX2Fynfgfd7RTRZbBMINUlJzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298996; c=relaxed/simple;
	bh=rKJD0WJwPXnV0TpKTnu/O7uPaB/YcI0O6XgrOSvYRM0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nj9+43ckGwb+SMT/XitDOMjffjS1flcCUn5/meDoX0kpzkt/ADioO1Go8xEDtAU0spiaF5up550ynHQRJ1WaQ8f/hjoNRLulKVqJgtQ9j2zuIwAAElA4wX33KurVGyNCyYQDxEpq+/2APP9YF/xUhZSB/YVGbFYl6Tz8VswGnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWBORuT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0B3C4CEEB;
	Fri, 15 Aug 2025 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755298996;
	bh=rKJD0WJwPXnV0TpKTnu/O7uPaB/YcI0O6XgrOSvYRM0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bWBORuT0wzYYsnIo5OS0OskLiayu+atKmtYVXmCY1P+Kaq17kpLFmAFrYQz4b/6nT
	 T35ut8ywhyZBGxdQalQtguwN51HjsQmagMz53fFpbYKGT/FPHUlqIe/xKO7Wi0qwYP
	 qNFNC64F+JfI2ahzF9fxkOqPHavduUKKK1IerVExlKO8tGlRYDZzBjZxBnv2hJDa3K
	 EjImdjHYewtdmspika4DQ8BR143WcYkjDmFxspKKqCQaqSArbN5hJbKOy9OpGOm+iS
	 UpS8AMu6fCFC5si2iUfIBOiBd/BRYIr3XZw0pYsKin9H8NTIxm5aflX8ZIEWDQ35Qb
	 rsHqpy/l1O9KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08539D0C3D;
	Fri, 15 Aug 2025 23:03:28 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyB2nWb_L8DvXFQ3PUo516j2Z6UW9-t3d9o0yBM7TzBuw@mail.gmail.com>
References: <CAPM=9tyB2nWb_L8DvXFQ3PUo516j2Z6UW9-t3d9o0yBM7TzBuw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyB2nWb_L8DvXFQ3PUo516j2Z6UW9-t3d9o0yBM7TzBuw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-16
X-PR-Tracked-Commit-Id: 00062ea01d35eaca34d561e5c76cd988dc8c3b83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfd4b508c8c6106083698a0dd5e35aecc7c48725
Message-Id: <175529900745.1301055.17572234635565155628.pr-tracker-bot@kernel.org>
Date: Fri, 15 Aug 2025 23:03:27 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Aug 2025 07:24:32 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfd4b508c8c6106083698a0dd5e35aecc7c48725

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

