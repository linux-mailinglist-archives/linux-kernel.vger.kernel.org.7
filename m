Return-Path: <linux-kernel+bounces-836909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51EBAAD93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB883ADC11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654891DE4CD;
	Tue, 30 Sep 2025 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHHfC3LQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181E1DA0E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194802; cv=none; b=LBTB2Itk9V23p+r6mxFDRIg9lKiOOVZk+doSUwCeeVfyxPeuctgPCef34srWxIChkwsii+n6sCxignrxzJwGc7OCOc3WHel/f+k5Ai137smUJYbUD67Ntxo0bzlYsDYqTKSm9fLAdEwNDSzy8Y29q8tlRThl/+Ao5fd6tUxrzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194802; c=relaxed/simple;
	bh=u0IGviLKXSqwxrypRnQnN8m3y1Bsw86whL17SuDws3M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a7hDWvUcsyZZhGjrLXasytpuNHR44PtJ1ks4tJ1GUuQFFIAh7ieBYn3hjmYK6Vw9+/zX1tgu9zO745wfUcShC6rthDLgc0yAgVhwCQ6x9kSqkuXeojxh7PcKBacVg2K0FR7kjqAOniPTpPL65QY2GBfimquXvQZ00hNCNMU7S3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHHfC3LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4003CC4CEF4;
	Tue, 30 Sep 2025 01:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759194802;
	bh=u0IGviLKXSqwxrypRnQnN8m3y1Bsw86whL17SuDws3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hHHfC3LQKXsLO6GReUnEAqeZHuV0emC4xpOPgB5qz3xuEFdiZ1DjRTBp70xMytHTg
	 KP1DXx9ZeyRFG+b1Loh04YpESzX2j+k3LPVcV0MIQFwcSCjSNbN6oA5FNzB7TrFbKK
	 0ZA8MXA6yznD4zZkNWYpYVq7ZxM0vUgFgdo8Hok/StKZbWCy2Uc9YM8ytTVPdAjp3j
	 0xabPEuWbLeBFcORm1kXSzaT8mLyIiVFTBpT1hbDtTJhzICpcmJH92/3Cfk+yYItH1
	 2uHm/pMLySbrZUZOqqBYNzPTlVsrr/UHOjW9NC5L57eShaMY7r4X/blnaC9DBSv6KF
	 kN97i1tYDBQLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16939D0C1A;
	Tue, 30 Sep 2025 01:13:16 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202509291207.66FBEC8497@keescook>
References: <202509291207.66FBEC8497@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202509291207.66FBEC8497@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.18-rc1
X-PR-Tracked-Commit-Id: b0c9bfbab925ac6385d4d06a134fd89cadf771fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a240a79d435ae7206a5c5101033f3f81d68bc3b4
Message-Id: <175919479563.1773917.2266439370329067324.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 01:13:15 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>, Johannes Nixdorf <johannes@nixdorf.dev>, Kees Cook <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:07:59 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a240a79d435ae7206a5c5101033f3f81d68bc3b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

