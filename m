Return-Path: <linux-kernel+bounces-737292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57BB0AA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFB01C80E27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC612E9EA5;
	Fri, 18 Jul 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuU7hOwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0D2E9743
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864596; cv=none; b=Du6H7nOKF1hhX19gbNh1GyEoURUAWMUCcAd2xo5i8qLiTJDLw0Q4mO1EHV2NcQCdQbM6eRZasr1uxmJaY7XLtJ5jgZxPXa9y214kOdhXM5zFhrwN13gBrl63+TQTFRlSy38k5N3g+kDL0e1cnU7CEyz/4cLVS/KIu92AzT780hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864596; c=relaxed/simple;
	bh=o9UxKVKF+g8ocslLE6so2+50W4IAxe3qqqybLYzVeSk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OGnHBOM1CLte9HAw9tV1cKsppq492o2DLjEkVb913ooCJUyDHCYq9ee1+QZYk1R7BbocuUNf1b31qxVQvNBywkA7PH6MLbGCgBHt+kO8MQxo4DXc8VP2vQ/iSauRBp+aVR/N4gXhheUTHvc/LXCyQXOoid+McK7CVOiwbgkLYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuU7hOwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E21FC4CEF5;
	Fri, 18 Jul 2025 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864596;
	bh=o9UxKVKF+g8ocslLE6so2+50W4IAxe3qqqybLYzVeSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IuU7hOwBDeOmulZ20BYLfVL4ai244HEWvWG1veSZNYzHQqUqzjM4kSgW2CPRav3i/
	 eGGEAt6wpG1PtUA5qE+/fUBPbYpascAxuHvkzkg7RhoXVl0+MFD/g7MEXGjuLFbX0i
	 8bkh1PTI8pi9JpxfF439AeqCt2YkDou6z/Q8Bic5meB0zJFA6psijEoiV9uV78vT98
	 v2TraBZKclxhlwP4u9DKhvMYOiKl+UFOuLQgXfxSazleHxDMG3jfdvocTcM3M1GxSM
	 FaeEor4Hyt4L0gcYO+Mx8dyEeZu4VDjrHanrdVydd/dq2kxv03l6OE1HIVCuoDNzGn
	 ysZ4W5M2bn0iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF8383BF4E;
	Fri, 18 Jul 2025 18:50:17 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzJPpV89V934YdOO=i1gEVwx9NOMV+w8+hqRgDLk+6L+A@mail.gmail.com>
References: <CAPM=9tzJPpV89V934YdOO=i1gEVwx9NOMV+w8+hqRgDLk+6L+A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzJPpV89V934YdOO=i1gEVwx9NOMV+w8+hqRgDLk+6L+A@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-18-1
X-PR-Tracked-Commit-Id: 4d33ed640ffc06734271cebda5ac2e3b5a79f453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c460535a6d6182dcb00773132a8c384c1f9b5408
Message-Id: <175286461638.2758816.12877251994317780459.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:16 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 20:33:49 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c460535a6d6182dcb00773132a8c384c1f9b5408

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

