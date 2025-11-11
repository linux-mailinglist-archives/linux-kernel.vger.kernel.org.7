Return-Path: <linux-kernel+bounces-896273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31494C50041
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743FC1890B34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED032F617F;
	Tue, 11 Nov 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4Oo8UR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BE2F60CA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901449; cv=none; b=DOw9ir+qt+cCLNl2966CunETBtGYLEyAP2ssQBYrTTuJIPGWLQQYtEVIPsFupBKlvfk3urPKj0cH4NArOZ7qfuQkcoydg9vyPP4PUcEfnVbzLBlSigLEqpxQq30hkodAOaYY76eqeM/fsGuX0tDMrHmyccSkZZ1Oqy7o4/XQ76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901449; c=relaxed/simple;
	bh=MapFwYBdepkknCvD5b+KZQlwR4RcWHE5HPDQANoxlM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rsu2yU0PUU3Qm7RwnkKMHT3G7ThDe7SaEmABhlTSZEbjmu75yGA/I2K3V1wWUk0v1Rr5YIPHdeL1w8C4dSQG5nHJ9U9Nmh/kX/M2Cv6APIOj7ZrapTiGJ1H8eGMI6w1y9jFW+D9AHlnWT0GBdOZPhsfuyoxhiZ4RWnSy/5nyCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4Oo8UR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF25AC19423;
	Tue, 11 Nov 2025 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901449;
	bh=MapFwYBdepkknCvD5b+KZQlwR4RcWHE5HPDQANoxlM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y4Oo8UR4frGw7wi0FYMB2URgXmhKhMYNj84PU8hpt/gqeywOG6OQGBCSFeKcNXstw
	 vB06erkPXVLw/ALd1llveQEneUAGk2xxd11axDtpHq9GqaH7tq2p8zkV8MJIWc4wBU
	 jL3xi5Qw0nPj2dPKnfWm4+Iv2Q2JMMFflDwKNeuKV8k4rCvpvz/aoAmWSgklNPTSSq
	 4cAkfEUGRyqiP0wQZ9uSTh8CYCPvMRyC2CbKcIOvwSBxM36vovsCy9/PvXhahC5xsh
	 I8Iji9hJUf2AdeP53YryqJBwCVmLT6ClHNNM1F2p0h5mtqXCUSe0c8vYXvrEm9huWr
	 n566hi/Bp1KrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFB380DBCD;
	Tue, 11 Nov 2025 22:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix uninitialized one_time_gc in
 victim_sel_policy
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290141874.3596344.13380399502745715174.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:18 +0000
References: <20251029051807.3804-1-hexiaole1994@126.com>
In-Reply-To: <20251029051807.3804-1-hexiaole1994@126.com>
To: Xiaole He <hexiaole1994@126.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com,
 linux-kernel@vger.kernel.org, jaegeuk@kernel.org, stable@kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 29 Oct 2025 13:18:07 +0800 you wrote:
> The one_time_gc field in struct victim_sel_policy is conditionally
> initialized but unconditionally read, leading to undefined behavior
> that triggers UBSAN warnings.
> 
> In f2fs_get_victim() at fs/f2fs/gc.c:774, the victim_sel_policy
> structure is declared without initialization:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: fix uninitialized one_time_gc in victim_sel_policy
    https://git.kernel.org/jaegeuk/f2fs/c/f10e76889502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



