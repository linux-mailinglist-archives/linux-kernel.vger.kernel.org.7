Return-Path: <linux-kernel+bounces-836857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F5BAABD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCF3420F89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41232737F2;
	Mon, 29 Sep 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG/9XCS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267392727FC;
	Mon, 29 Sep 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188152; cv=none; b=RGIP2dumQqTSuVHSNWy5YcM3kSDiw541WgxVRqPQydWiWIVqsUb/HAFWYyLUSmccyX0TORMU34xbXR9F76tfsbUtyqkJzQtb+NQWTCLrq56aW+uwbaHk+/wN7CbLLdLj+sP22ad2sDunZJwpmLYSyDWQAhdkMNdfYtL95G1NiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188152; c=relaxed/simple;
	bh=ScSfMoOm3S8VvfgMxppvjOCrqQCdnO52JEYaRdpzQRQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Eh6uNV932WDQTEV6faliLDpgFIah/0CiQRtn20IlxLqA2twwaW2i9e/xqNriWkEqJrxsm6p8oV1dnKT6hja9fnIR+sHz8slIgzQDv9v5Aq7TFP1BSHMZxpZ62w1Xbt65hzop3KKclsSQTNFkizZkWZRMjj9LqKUZMjSoPJdjHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG/9XCS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0856DC4CEF7;
	Mon, 29 Sep 2025 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188152;
	bh=ScSfMoOm3S8VvfgMxppvjOCrqQCdnO52JEYaRdpzQRQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XG/9XCS9Yp4xijdJtDh61hCnJKccPBP4CZKBp/aH/kLENE0Mb7rhfohMHi5K2KqZ4
	 0yx6ak9bD0rqzHtawtH6cl4rlGBl+NxR+Kacnio8YhRpy9Hjw9BP1U+tinIKkIDb0I
	 S4m7U8qHiNr6wOnNGGIP44INlk820o8HK5Yt7c5JV7OVkdLo9DvM3ihO9mAOA5wMZk
	 5Mcdlcn/EPl7vikjKRIjXESPLXY+yuphatdl3U1nQmEUNqIHkzUm/cF/1cDulciP3Q
	 tydJ0Q28Ccdifh3G9euO6VtC/P7nRj0+O/nh6hsG0PHtEdOXN/6sspdAE7tfcOBLcP
	 ParJdki5EdQpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF539D0C1A;
	Mon, 29 Sep 2025 23:22:26 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNqag0RIXLcG5BH3@redhat.com>
References: <aNqag0RIXLcG5BH3@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <aNqag0RIXLcG5BH3@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.18
X-PR-Tracked-Commit-Id: 8e40210788636619404871df07445fa4590138b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a769648f464c9f453b3dc5c2bb8559b28c5d78a1
Message-Id: <175918814534.1748288.3555970470278452904.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:25 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 09:41:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a769648f464c9f453b3dc5c2bb8559b28c5d78a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

