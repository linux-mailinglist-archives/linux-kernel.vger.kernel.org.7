Return-Path: <linux-kernel+bounces-661206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E1AC27E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 18:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72D91C05514
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB5296FDF;
	Fri, 23 May 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkzqvywf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECF2063F0;
	Fri, 23 May 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019060; cv=none; b=EJoMqTL4cFaH25bwXAEvYYCGJrtTVkLsl5HjJz2HN7b/nxdoP5K7BMuiOVtHdNaIvg+At1O5u5csRdpAV5x6ULutbtRERQEuzwmzIgQkRNh1FwUeW0YHCO/oieRMEyqiSQMnX/VQE913GgGCjAY75D/enYKZps+Lqq/A0NDE/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019060; c=relaxed/simple;
	bh=6CiA/dI+9hc98ym5mhyRTZeJoWyaHXWJHbSan/vnN30=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OeRHKcUMDQRtgaUvRxyGaSCSoBKPSeqH9ZPBBsWsFVJXkzPfVzXZcK+La326MWxqiQKVFpAL+7yOPLCtXlWMmpi0PjZ/mYJExsn+pUEAOhAzxg+zdGfpvmkzW4wLYteHyg/PHffExkfMCIDJhQn8m6wptYwhhlGpQMI08JqoAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkzqvywf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B92C4CEE9;
	Fri, 23 May 2025 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748019060;
	bh=6CiA/dI+9hc98ym5mhyRTZeJoWyaHXWJHbSan/vnN30=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MkzqvywfDRXwafiZJNBVfHgYaRbeAXbMTVto1/v/KE05phXSjJVLW9eLG+IArRTs7
	 XnVc+iE0N/+/oEPUu35ZSE6MwMsh+QNFFgzPiv/e4ttneK7dxJY5OMphhwiPAoqLz8
	 X6SWxOHW2tTYyhIlkXL+ul3OPHYDbO+q0GqQckTub8j2t8kxl9W4hKeu0gA86JQCvY
	 j0APpnYKA46WGQE7PD6DfIW4XIAQ3WBwAd7jKzD1VBhzK4XOeMvpWRC344hcrfAPbO
	 4UgWH4PSTQuh54XHJHdf4PprGAle9w1fGIaTqkc5uyFN3hkZfxBEDvrLLAxVm29Jbu
	 jHEKhRoIMpUFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711D1380DBEB;
	Fri, 23 May 2025 16:51:36 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mud60X1UsmL0OiF6OQhA-wW8WzfP7SyOZBmDEG-hfD4QQ@mail.gmail.com>
References: <CAH2r5mud60X1UsmL0OiF6OQhA-wW8WzfP7SyOZBmDEG-hfD4QQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mud60X1UsmL0OiF6OQhA-wW8WzfP7SyOZBmDEG-hfD4QQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/v6.15-rc8-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 10379171f346e6f61d30d9949500a8de4336444a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0f8e1a7c18bfbb203122e98dbd08e0e68dcbd76
Message-Id: <174801909512.3663029.3450981754455219794.pr-tracker-bot@kernel.org>
Date: Fri, 23 May 2025 16:51:35 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 10:23:53 -0500:

> git://git.samba.org/ksmbd.git tags/v6.15-rc8-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0f8e1a7c18bfbb203122e98dbd08e0e68dcbd76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

