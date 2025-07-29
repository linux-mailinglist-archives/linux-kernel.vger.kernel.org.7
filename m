Return-Path: <linux-kernel+bounces-749958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FEB15565
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEFA4E58FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4A279359;
	Tue, 29 Jul 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKCJpksk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9202882A5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829129; cv=none; b=WsXJoVASZW7qWfEN53++6TyhIXPpzmu84TE0xk+etgItTL8zwFvVeVIKsq6tX8zOATeFEIs/dI9aXdwOUxxpVUekgciXOgM+/mgLk5/RQT2/lqZaTCiLZYY/T9dtKVW0ci26wlX8p5Vt2x2ewYnZv8tE7G7cDa4G4jCs1gQm0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829129; c=relaxed/simple;
	bh=Ud1xkZ+9Izgdo3HKw2/E3lkDDlWRajEl4DaZuCTnh1M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qVsa9r0Epk99JkxO+EuNdt++zfMDDqXizQqvj3NSYl1Yq/6GKKZFC77CU02SQb6Spczw8tlpiC5+Jp4VdQ/DuRx3noze0NcPmPm1SdSZY4rIhiPrhSLcyp8EeigwEaAsou2b26ZJa23sNiuTBE9i6IFojpCD6Sl1LGFhgL7e22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKCJpksk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFFC4CEF9;
	Tue, 29 Jul 2025 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829129;
	bh=Ud1xkZ+9Izgdo3HKw2/E3lkDDlWRajEl4DaZuCTnh1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iKCJpkskoKlMQFPnOEAdmPK/TU6Sd1QtF0Jm5ATQ1vxAhqAaYPJ2jwf14+FLpDCQ8
	 cBJuXkJiM5y67ET6ktCGfPUk83ZpoiMqzL5WJ7L0Rwas0aTwtkEAtM0tlRAF7GvHgR
	 wKf3DWolzXxEGknnJgB5bqNvzHnzmCiNsTb+uVS1hvRlY8RkR0AwegteIX2KfScAa+
	 gKeBCkdrXUmk+vJTUyjlQQKiR3TUqGuC5RnZ0dsi1omcd+b3a05BIHm52guYEiqaxQ
	 BmhmulYX9AysSGcopKq70f2uJt7cYB+RC2lWrpq6UhcJ5EolP3lYtIOcf3xbQMs0NY
	 6eMnhjzdrANlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB1383BF5F;
	Tue, 29 Jul 2025 22:45:46 +0000 (UTC)
Subject: Re: [GIT pull] timers/cleanups for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365568651.581055.9100195148414545609.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13> <175365568651.581055.9100195148414545609.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365568651.581055.9100195148414545609.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-cleanups-2025-07-27
X-PR-Tracked-Commit-Id: e78f70bad29c5ae1e1076698b690b15794e9b81e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99e731bcb8e6dd197aa4ab587887a3f670d12b72
Message-Id: <175382914506.1670422.7670183498692817627.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:45 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:37:58 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-cleanups-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99e731bcb8e6dd197aa4ab587887a3f670d12b72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

