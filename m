Return-Path: <linux-kernel+bounces-749788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC054B152FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2085A1C35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1B229A32D;
	Tue, 29 Jul 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzCnUG60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D36255F27;
	Tue, 29 Jul 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814397; cv=none; b=qxRZhHKSqizzjezgWkYC0yUgJZzrCw+fSnl4uiFEHekhSHnRFg+4BU7aP3D5jaMb7Sr1isBvnCeNvwIeRBsVf7eHngLyIguB6sPCoUl7gweh1F2k2q9Qjnf0MZGAvklRUoloRD0u4EtlR1i8i+iWffNL1J8kunJuwCjdCuc//OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814397; c=relaxed/simple;
	bh=KQOtmDXH1BtTjIG0VTWQWNgUGw7+W5U+f2f8dvTfO1w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K9Mw6PsR87Epw4o0/AisbtucXm6LOJFLy+eCF1/yX45RkmN5gTVTWH8YykO6IvWVpKXOXG/qwUkXOSh4bTd9RESyiEs5m6H6S1XKNHNxH2PimzU35g0K+YkVKy6LPAo4tRiCmzDS/PIvEfeyJ4i2DibJenX5iyfDWQtGUmD10NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzCnUG60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9616DC4CEF6;
	Tue, 29 Jul 2025 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814397;
	bh=KQOtmDXH1BtTjIG0VTWQWNgUGw7+W5U+f2f8dvTfO1w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NzCnUG60fZGEl1/TW03G3Jr96IbPRX7Sm5FVGHaNuZLRRW6iUX70kZ39V0XIp0JaS
	 7r/OkOJILmqQR/p0Tp2fq4DrjjPC9NohtRsSwrm/wAeGPTJe9mtKT/4FJNZfc8iPE8
	 r3CBgHJ8eUBeJjycMMx3dcJMdruXrM79dbLEFituNvjQMrtc0bEso80eSnu5LcssYU
	 wyD/J68tnDwL3JF8t/AlLy1PW12mFxGR5Uz23Pvcl3sXdL6i+WxG7ORSTysJWt1Jfd
	 LfHkZQ5R3s0ozJRGzSN3m/vq5NCWv6Sqeuu/l9E8W3ZlfVmorHYoi4SxWqcaPnXhDf
	 Z8SNjPtvDlBbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19968383BF61;
	Tue, 29 Jul 2025 18:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIea0h6hkgqgeFUf@kroah.com>
References: <aIea0h6hkgqgeFUf@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIea0h6hkgqgeFUf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc1
X-PR-Tracked-Commit-Id: 51d4b0a44c82e5eff056ef76acd2c3c605a8eb74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eee1520ea845a6d6d82e85498d9412419560871
Message-Id: <175381441383.1585410.15507318222720685900.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:13 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:44:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eee1520ea845a6d6d82e85498d9412419560871

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

