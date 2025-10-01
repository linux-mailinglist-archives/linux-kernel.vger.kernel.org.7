Return-Path: <linux-kernel+bounces-838273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C65F9BAED91
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 712DE4E1E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CB1F8BA6;
	Wed,  1 Oct 2025 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcyHUF94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281C632
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276963; cv=none; b=XnIXOJgk8kCUZRG8gEq402lXvBE94o0METup77iKN8tDS/BH/LBKyIYFyJcKtvyxmpb3KNHIeZ0AdcGgfmzxMpExfkwi0MbNb4JATncCV3imWI869kthFNZs33PcJc0+IIdrZFmte4EwLsOciOaj1eUVCazVcQJDsMwWsFo0E2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276963; c=relaxed/simple;
	bh=Hn8cjU8s0r70uMrcHOvfENoVs3XPXiYzBDbAzt6eZAc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DE0QCWyJNRwm8tkJXZj3rLAxH38jq5xcOe2+hYPs/DZS8+X5IsKbiFiy5ENdSjpmfiWJJTf0+I9/j0KAhMSY63OeFxLRxDBVAwVykl3kq5j8pRt4D9+Gfl2zv3MZf3sKgTTkmjLp6Ddm1VjRAPxfr0fX0JFpi6NGohLRtAjkqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcyHUF94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46904C113CF;
	Wed,  1 Oct 2025 00:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276963;
	bh=Hn8cjU8s0r70uMrcHOvfENoVs3XPXiYzBDbAzt6eZAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lcyHUF94iQuPGv4HiRiagveQCOAK7hMvcR8xpfF976LauP/KhYiaHuaNLGcqWG6C1
	 +PJzh+5ql7+Kd2U/Stn9qlL9vZ0b3Gb9bx7+cQyFWPrUjn1uaOuYYs9zhKnTzGPxkL
	 gPWwoLVtn+jr2jjvtr/Zy/86m2qQu0nRDgPe9IlaJzioltpq0x1AJvBWusosb9SEk9
	 9pma5pSsclt37OkTpi1qccG8hfvJ+7BzSO7p/DLDgDj5oXvZicPgDMVZPDKeSrP3nC
	 7X8Q4xGsoXIgGIWwecMJ7eQDyYUJpwe2QgwA9oA5B1hGO7mYk2VDJAhB+AC2qTIl0y
	 A15/T0V9EdyLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7B39D0C1A;
	Wed,  1 Oct 2025 00:02:37 +0000 (UTC)
Subject: Re: [GIT pull] timers/vdso for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913809032.495041.16459509621135862969.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913809032.495041.16459509621135862969.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913809032.495041.16459509621135862969.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025-09-29
X-PR-Tracked-Commit-Id: e82bf7570d5ca3667a9038a3c5a42d451b949d89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b81e2eb9e4db8f6094c077d0c8b27c264901c1b
Message-Id: <175927695615.2242674.14231258880386481393.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:36 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:29:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b81e2eb9e4db8f6094c077d0c8b27c264901c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

