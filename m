Return-Path: <linux-kernel+bounces-771199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5CB2840B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6D916A051
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3F30EF96;
	Fri, 15 Aug 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSTS0VFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4F30E0F2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276010; cv=none; b=NnFEPVrFfnVtE9KguHWw4HbyjKOaDKD0WvOAE8UdLmBOxQg+dvJ2hFwpIfQcCMYhmpe7sVIXQ2xXxXivtpOgcJdpNr9Vfk5KdLiw1smjfVHVDXekP5ea1WNrsi0PgWPWZk0XlRKrkDZ2WDFMegEWTtKa/SszSk6tZjiXP1Rj2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276010; c=relaxed/simple;
	bh=xtXYrwV7vztFKIXogJ7dxVkOMx90AXRfJ7vPLXPkc2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NkWBMWuEJnPBC+tNdDDKzAkIAWvCdbiX8wLCvmfr3l5UQH1oOEB2g1KRBKfX5RJ2PHfqhGjRQcSmUrvsyKU6LP18DtaK57mfuF2lro5WJ9o6/c0BzBImv25RL5gKEYS5liVhYsfOTjzxCj9p7nDbnv+kQr2zn811cPbR0JubdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSTS0VFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA4C4CEF4;
	Fri, 15 Aug 2025 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276009;
	bh=xtXYrwV7vztFKIXogJ7dxVkOMx90AXRfJ7vPLXPkc2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XSTS0VFpWVumB4m/cJJao0CYY/Y34vVayul4C6zrdmtyEej4C3Aelk9yefBRPGyu3
	 xAqFzk0TuSzMPX1r9yKgH6WBvUCJXIMNqzY89PxqJmW7b7QDaw8rT/dsn0Y3ckBLR6
	 q1iGzlBmmTnlx0LB7Iv8+Xd430VpyNBZwMg8HAeBsO0srgVmusqrmVK5L+L/Deap8h
	 FkXFmElpnYrLNoz4FNHnhJEcslwK+/k/V+t7d786VppvNjWBeTnud+9hwnI2VbvNUb
	 Bl7NY1JbwH8kWNCqxU6LPx1cvtmjlEe3yG9eTc4XRiQDhTk76SEmL+imURbqK7bSvx
	 1aMil/Eit0tVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDD39D0C3D;
	Fri, 15 Aug 2025 16:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ get_left_section_blocks()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527602073.1161945.5338356216953620697.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:20 +0000
References: <20250811114123.1085143-1-chao@kernel.org>
In-Reply-To: <20250811114123.1085143-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 11 Aug 2025 19:41:23 +0800 you wrote:
> Introduce get_left_section_blocks() for cleanup, no logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.h | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up w/ get_left_section_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/3ea4ad0a1df0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



