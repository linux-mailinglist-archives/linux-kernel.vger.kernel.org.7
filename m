Return-Path: <linux-kernel+bounces-782760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37FB32505
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9550D3B60F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1027CB35;
	Fri, 22 Aug 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJXgVyIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E915539A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901309; cv=none; b=uI4X2os9BxzD8ZviaFU/E/GlZKL+kKuIdFy3eGI6ppohDrupegYcrETBeYsCOmqlk7pRKPB96SNdOfG/rv1CfaTuLbwt4V8bI8nB2Ur3kHfZeXsjODnDuaL//7TvrYHI5jKKNmd/Dt8ZLcpymZz7qDxdZk28VrdDNrHOw6LtIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901309; c=relaxed/simple;
	bh=BMOxwfSNpAEUbgWcSk+9Ur6RChgCBTmACh4pdd2awNA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=an/V9hLxjZdsDJoPSe3tA0sNw/lLWfzBJgP/Yo2s35A5FgTOrYze6c5k4Jm33bXiNIb1lSTfvOgrhpkNpUS0DAmgILoG4YZ4ajdPLdfosUH5hB17noeyLUl/S8pQOeH34ei39knNgi3OkT1Ku9JZva2nIuL2gmsQhmBc5Zp0aWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJXgVyIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CC9C4CEED;
	Fri, 22 Aug 2025 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755901309;
	bh=BMOxwfSNpAEUbgWcSk+9Ur6RChgCBTmACh4pdd2awNA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJXgVyIm3RV++2/6oRgGxzuKvaforJghA9okVb3UGdcwGd9SMRXW39mWKvsb1e5sR
	 alWhVF6zqtCIByXhIALnb4ep1SvBzXBdTaje2pi1j5LA/TANyJ7TuaW4EllklzCjAR
	 vIcXR2hIgH8kiIsVFKGcOGjVJw3gw8G32ivIUwRUM2LtChCk0iQN4rHsEOpppQRc+i
	 QE6G0WF5yHBtzxycpqN8UeBkXHumglmaxXykfoJcfT/r3RTzFXMIfgyrZ5tx2pFJdd
	 VqsR2Xbz5L7StDCXedQGszuF50abb/cna3IqCjxaTMVwXlu6Elb4p0xqFOtHwLUm0l
	 ST5RqZJChwn5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FB2383BF69;
	Fri, 22 Aug 2025 22:21:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx3c2SzxmsTaySLHVVUyHd+zcB-axUL0Hbtk5DdQQ8rrQ@mail.gmail.com>
References: <CAPM=9tx3c2SzxmsTaySLHVVUyHd+zcB-axUL0Hbtk5DdQQ8rrQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx3c2SzxmsTaySLHVVUyHd+zcB-axUL0Hbtk5DdQQ8rrQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-23-1
X-PR-Tracked-Commit-Id: a60f5ee68efd91b4507eacbb40d4024ecf363304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6debb69041724bae8a8a4d0ac60502754c1cd945
Message-Id: <175590131783.2018712.14349272942198070563.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 22:21:57 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Aug 2025 07:49:34 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-23-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6debb69041724bae8a8a4d0ac60502754c1cd945

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

