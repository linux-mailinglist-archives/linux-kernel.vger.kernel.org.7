Return-Path: <linux-kernel+bounces-728451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A252B02854
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F963BB52B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826C7080C;
	Sat, 12 Jul 2025 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgvinlAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781344AEE2
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280135; cv=none; b=rY4ikDmA+8tk1u5G4m6ZJcX7R5H6lZRjuHdOA6pUDy86IaEi0AWsYnpMEHCt+TsbqMuBVVkrT0ZzhE/9JWVB50ycVQO6jNcfI6jKbuGTzhEWO8IoX27gdKtE3/B09sP7aSOyBjkv9sUTR+/SJri0xE5Mw5Gz2WzFDCjs7CZWLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280135; c=relaxed/simple;
	bh=oHdR+rd9ayhYY+O+Ztg6B70LwIfaZNbmLd6g5Ym5x8c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nr38uVf93yrSwSZhtSXVvpIPm0CwKHosQBULr6RPaYI/CsExu6rqAOOd8z/tIE/51dNyt8zoFyfpUWi81eF23X8F2cszPKbAHhhHB5ny8XW9/YinNjMQVVe74ihEGH6Aeakk++BhSk/+54c2DkdD2ML1MAzp7w0reoqrBs65IXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgvinlAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A39FC4CEED;
	Sat, 12 Jul 2025 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752280135;
	bh=oHdR+rd9ayhYY+O+Ztg6B70LwIfaZNbmLd6g5Ym5x8c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NgvinlAYB4AolRn5uRkduZfyQKbbnnFHRQ8Ta00mOT2ZbBz/2RiXB19x3GeSrRsKR
	 memI7TXE5RpNARY4REE3MOJ2iHep+UhYgYxW6XRMYeaEuD62wE0/2i9Vu8nLlRX1xO
	 dIafVi0FWT+TeVzvh4pLmqrJbDLMZ5JfICRWGv7Z/eucYPmdbSctstsUlhocNqQa93
	 94yZecR6w+xBIyQNP8+bF2Ij44B5WnaB5ugS9bhhWEPLQAhwZIx250KiQ9VusMfzB0
	 QdoiF/i1qfQgf5NBAj013537O9mY9VablhCSWjv6LQSJYUa3/lP42fJFROS9vEtSmN
	 3g/pe+zcwog+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6E383B275;
	Sat, 12 Jul 2025 00:29:18 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHGMDdZNDhjND0iT@phenom.ffwll.local>
References: <aHGMDdZNDhjND0iT@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHGMDdZNDhjND0iT@phenom.ffwll.local>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-12
X-PR-Tracked-Commit-Id: b7dc79a6332fe6f58f2e6b2a631bad101dc79107
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c2fe27971c3c9cc27de6e369385f6428db6c0b5
Message-Id: <175228015714.2445691.7721712957105667270.pr-tracker-bot@kernel.org>
Date: Sat, 12 Jul 2025 00:29:17 +0000
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 12 Jul 2025 00:11:25 +0200:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c2fe27971c3c9cc27de6e369385f6428db6c0b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

