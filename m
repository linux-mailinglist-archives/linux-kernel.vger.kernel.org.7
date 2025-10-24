Return-Path: <linux-kernel+bounces-869632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C9C085CB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECAC3BC5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128530E84E;
	Fri, 24 Oct 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8/vLx1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4F1F1932
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350266; cv=none; b=BQZNiC+wkkNsB9/P6JhSohwnblcKTNM1lwVuDIFA+qwQe0N93IiqiIWelbUt83Jq0YUYFkfd4kPrZU9NIdP9je356tvbS3DS2ngghTBFsA+MmnqJVnd39jFC9wWNi0aLgWHLlME6YsmEniC9MC2TuWAyxKZeNszZSkO4zQSAt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350266; c=relaxed/simple;
	bh=+Abpmx80dHyLdRXIXAEx6hgQNdKU00coHtI7fLEuwRc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q+/nd9+HE/hBwjkEb59i33FCVrdMWSA/Ch343SwZ3pStTfGWp98k8kXvbjre8SwbxDt9Ki1qkjAUMh9fRkN6YFBTFngFg71M3B07MWlQTJvn7YaUR0dmECqhyGbsYLHUM1uezRBrC+H4kCEKvU7tA2K6uyPA1LeiAJ5IYGHNkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8/vLx1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA10C4CEF5;
	Fri, 24 Oct 2025 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761350266;
	bh=+Abpmx80dHyLdRXIXAEx6hgQNdKU00coHtI7fLEuwRc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y8/vLx1ApQeihaTL0vL/8zWOEihCTuEGoaZgFduT4RNhnc0gkcmEktKHWb1v7k4gP
	 Z7q4hyFiNHqFqRxqCSp55q68nIF4B7a/NjFkCsTyR2KX8+qgx1VmMhQZt3oUzrLOPu
	 RCXGuL90yZFlUAeTOJs+Jid0eZsaHKmVF2JNYLtkweODLtrGnViQVxbjypZ8JzUoFe
	 HYCX5kyg2vWRYY16NA6ZjOUEhEQqMmGuswExSERftzPKLd6HmqJHOcqrECX8Gdv2/b
	 F5i00q9a+apdl1re7NxmwAwg3jIQe5GGm2zl7eKaPZU9jnZpK10Z1Z6ZuNNqarWPSn
	 nsaB3i2BEA1YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E91380AA54;
	Fri, 24 Oct 2025 23:57:27 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for -rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPvojo5uhoAatX2Y@phenom.ffwll.local>
References: <aPvojo5uhoAatX2Y@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aPvojo5uhoAatX2Y@phenom.ffwll.local>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-24
X-PR-Tracked-Commit-Id: 18b1ce0b29c41833363b58ad030b76dabf984899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d08a425d2f667edf9ab7f9c3d999c218a96ba6f
Message-Id: <176135024595.4099580.14354874840145229936.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 23:57:25 +0000
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 22:58:54 +0200:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d08a425d2f667edf9ab7f9c3d999c218a96ba6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

