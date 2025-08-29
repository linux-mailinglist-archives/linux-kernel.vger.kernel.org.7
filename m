Return-Path: <linux-kernel+bounces-792167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E64B3C101
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479241CC4464
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9267338F2F;
	Fri, 29 Aug 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr7gRBz4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3F3314B0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485576; cv=none; b=fgr2p3yoqkYRCoth8CfwKNXHTRb/hhujyza24wqzkTBtKaY9GmSM4rbIi/pb9FftZens3CiId2Cj54BFAhdPMWWZm2loRm5hCDcX24XX4mSUFcCkkkvdZRaSy4nu1bH5ncYjNhiWIMLZ6xToW3pDnEi08PEIBQgyVNeDw903myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485576; c=relaxed/simple;
	bh=Kc8e+V5hgu76KlkxtggRd2VXkgJ/MzmndljvanrhbVk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eaTqo1nfylaV1UxuKjNCeQFnUDrCtygjmPrkZkrNbE3emGYNVnfmyDofqbqP9ENKKB6b/PjjuVkzO5gTFUM/mxL4vuVKePYYxt2X5HPwcToDGrw+3DL7+4yMDE6LYHtrKLL3lqxFZOosWknNSDu/gkDeJS6P7dAGALrYXLm6UbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr7gRBz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A69C4CEF0;
	Fri, 29 Aug 2025 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485576;
	bh=Kc8e+V5hgu76KlkxtggRd2VXkgJ/MzmndljvanrhbVk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kr7gRBz4QdkFWNJywMJUF/dyIPlGE1wK+yqDSJfviqOJn1i3P8mut7A2GKgE/qXKh
	 45tdScQBfPW0vpbyuiCk2qiq67KoGTZBAFUgd10XHHieLvLlpY2ImeR5wEEYG8LsMx
	 570fAhZjlmjKCzkrNeS0cil7uDQoL0Q5IvfRTp4KMi///ndmF4GwfYvQVZ4C22Go4T
	 /XUReUKaR0kOG3D74KhGYhrsiuazTJZyCx8F+JdARUezviRnk/8+Lqt2rB9+DcfPju
	 ewTw05fKDeA/txKXmiBGb0TpZ1jANfeUwSFFlGCcBRLPWhvmX2U358nA5Y/WgSVn6j
	 98AdRxwikfWJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8E383BF75;
	Fri, 29 Aug 2025 16:39:44 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txr3jRk-+wk5J-raoWgYmeo5QRwBp0uCzLj67omDB13YQ@mail.gmail.com>
References: <CAPM=9txr3jRk-+wk5J-raoWgYmeo5QRwBp0uCzLj67omDB13YQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txr3jRk-+wk5J-raoWgYmeo5QRwBp0uCzLj67omDB13YQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-29
X-PR-Tracked-Commit-Id: 42d2abbfa8c40299e047a9b3e5578fdd309dd2ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18ee2b9b7bd4e2346e467101c973d62300c8ba85
Message-Id: <175648558291.2275621.226431442088147559.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:42 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Aug 2025 12:54:44 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18ee2b9b7bd4e2346e467101c973d62300c8ba85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

