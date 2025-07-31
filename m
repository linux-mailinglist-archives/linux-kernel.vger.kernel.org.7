Return-Path: <linux-kernel+bounces-752578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BEB17762
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494C31C80665
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF32652A9;
	Thu, 31 Jul 2025 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1pRjlEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB01D52B;
	Thu, 31 Jul 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995083; cv=none; b=mutFaJp3gHqay5gEpnndc8rtvbAVuhbYTOm9GMVVkqiWOYXsOZ5P57uYsZokR0mKGc4IP1eavrRCwDn28I7m/000I3z0+CuaXKwxYtpJz7bOCNc7zEYip9a7Qpj7AmIUrNZ80e2+W8kf8AIrSsHbAY8hWpzTZo5XtZQxTJU6EAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995083; c=relaxed/simple;
	bh=W266oNs/4JOTpY47hGeOJ5gEFyyUObJMd7Mw9u1dyAA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BSkkqNctbQVB+tvJn3EFymqrLvcU6pfWgL+Gl1ssIu+zGNaJE9/T/KBZEP/c9h4ERWid0/VfmkuFmvNyPVlaLTnYvMDJVr33XFasJbqq+uWHXTV7wX/csq7JCpVMD9erknKCqQoo6pentELv21cWuEX8Fqnlj021UsHxiokfalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1pRjlEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1AEC4CEF4;
	Thu, 31 Jul 2025 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753995083;
	bh=W266oNs/4JOTpY47hGeOJ5gEFyyUObJMd7Mw9u1dyAA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D1pRjlEXV0sBDTGEvCUBW5z2hFi1jb7F7i/jNcXToesZ/8wZ9AI6qlQ/hauEsDGTo
	 kaIexg/fOmW97SCvgPuGXLpJHlwey/4E4R30xSD5OL05olWpOFQzXKl8b1T08eW5U6
	 5yQh987mrczrpEgOmGI3d17kULoKObFvAvKhuDkysxRJZLv+JNMUqsveg+3k7vKSwR
	 RiCGhCswrS2Jhk4KLRBSX8kVhyTXVArPvtJhXIEPsV+tPcdVkA/p/4BhUtjmMuIWu1
	 gaCbmGabDqcXvlJsd3wDXoOwvpKBCyEC7IFcYo+nBpvN2BMkrrx3bDGBahG66o7JeI
	 KHHkKMgiCWJsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A5269383BF52;
	Thu, 31 Jul 2025 20:51:40 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250731164335.2032758-1-sboyd@kernel.org>
References: <20250731164335.2032758-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250731164335.2032758-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 64c21f253a3737c15ab745e9276b2352d86aed26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d945dde7fa3f17f46349360a9f97614de9f47da
Message-Id: <175399509934.3294421.13765380743632184466.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 20:51:39 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 09:43:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d945dde7fa3f17f46349360a9f97614de9f47da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

