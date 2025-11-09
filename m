Return-Path: <linux-kernel+bounces-891761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2FC43699
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375813B09B2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BBA944;
	Sun,  9 Nov 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH+C+UfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E03FF1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762646929; cv=none; b=rRQAtOZO4ugKzaHs6S/2oVg/LUBx7edhG75/TSkY4ePvtueGLn6uMWjKWUOql1AMJHhtsKtsHMfQzuScsLam+RJsE8D0ySsnsGgIFh9ta16E4XQnbiMYQACokwBxphBWRR4iK1VsRcjFDLgwBgb3TZmA2fx6+YW8uv7zxJMj6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762646929; c=relaxed/simple;
	bh=2zJu5ZBmInsPJLDEBVTUzUNPMHzWVJvDJqcnpEhgk9s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L20ZmR7wcx2Pwue9krfbtvKrXUgHI4DamgVg3Y1rbC1RrPB/ezEDH294DAHBbRaJ4ouWZSI+O7Y3BXyEKaXxPMHuM1NISHeqPLC/AyuXLJsYMB128zI6C8SCmS0qmSh7qB3zDiDkbb5WH2BaiFXFLGbRaqjkmyWS3l0AXB+pHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH+C+UfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCBDC4CEF7;
	Sun,  9 Nov 2025 00:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762646928;
	bh=2zJu5ZBmInsPJLDEBVTUzUNPMHzWVJvDJqcnpEhgk9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uH+C+UfZqV3R2+AYkKMnSEkwWB3L/TPPgCS/iq1Ueq+sYc/RmgnYsCaBEH71TUnSc
	 lqsOKJwDZkfashyBxKCg8ScHGMCLFQH8n3AyxK2/YbCksL9votjRA62+ibeRlDlvnS
	 spzMIVNWjcIyIRzZ3+DGzxnqPC+ZSFG8cWCIzsD5gUqaId9N0NA2Z2RVxloJ71phB9
	 rAABTFRi/Ce/FOC26KSulbzEkZbtYg8wsygUSg2XutzuzYDYf23HuiVYLXzYvOxVjO
	 xGRIBHVhzbNocsZiRFWBvG4uQMuo348f3cFMtyWO59o/1OImTSlmCXDiU2TcSPJawo
	 CG6AEZaR7StuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECCB3A40FD8;
	Sun,  9 Nov 2025 00:08:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes urgent for 6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twWJuOWLGVoMNdQhpu_5-diyLuHw+QhENenW_wGxu6GOQ@mail.gmail.com>
References: <CAPM=9twWJuOWLGVoMNdQhpu_5-diyLuHw+QhENenW_wGxu6GOQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twWJuOWLGVoMNdQhpu_5-diyLuHw+QhENenW_wGxu6GOQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-11-09
X-PR-Tracked-Commit-Id: 411336159064c5e89e8b89d30c6855db4bb92814
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 439fc29dfd3b9c072dfff292d91cfa2f6cfb702b
Message-Id: <176264690030.1423288.11220520199599135537.pr-tracker-bot@kernel.org>
Date: Sun, 09 Nov 2025 00:08:20 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Timur Tabi <ttabi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Nov 2025 08:44:40 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-11-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/439fc29dfd3b9c072dfff292d91cfa2f6cfb702b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

