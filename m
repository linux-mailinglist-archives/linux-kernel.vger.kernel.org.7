Return-Path: <linux-kernel+bounces-836836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBEBAAB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2107A579D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78121242D97;
	Mon, 29 Sep 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2YChlgf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D623AE87
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185029; cv=none; b=LYuj6q5yKNiCenjF+axonsMQcgrYLm5YFcwOZD8WFV11jsT9PxYFdjcc86r4IuX9zyC6x6FscwSr3knzwZbKsoC8p+ivkvU9nAP4zjRmMpvKUemkHScRPFTH7YZoXmrd5YF/U0NFLTFPG6kKmaEUWcJawh5ou5Qou/LDNX6d2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185029; c=relaxed/simple;
	bh=r/6eQ4xAfKw7QHXF/YCZUxGy7DBiUINaTSM4hQEn4z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bAa93+uiC6kzJIJSlZk7y5CZr0hAqimKyFhBfHeRH4Zc96m0ZjpXwQpfcIKLIVuz9tYZwILVSYygXpQxGRWNyyiqkPfcQBG1gLs/swexaGy2htxyHWlyLuWECmciNw2Dlq5L2288BM6P12s9xLodk/pwabmQ9/jm/auZDWvzfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2YChlgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730E5C4CEF4;
	Mon, 29 Sep 2025 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185029;
	bh=r/6eQ4xAfKw7QHXF/YCZUxGy7DBiUINaTSM4hQEn4z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2YChlgfWXGdg06vduN1JrCokTYZ8ScAMft6ncK+4R/M2HC/iyOKMQgUQg3BsQgvE
	 OZ+NpLanNEmvnB+xP9EyEnRzgqlcKtR4fsA1ljICspHEeZLRRzr8BMIDmg5yd/5jaE
	 tTo6/VxHiaruEbJchfHUYH/Gk6gppWK2k7VSwhR1OJ7bbmBibEKK7lpxbGoF1jC5Ak
	 EC9NJjhAyMdQvTtUGL69emncKQz+00LQWz0NLpJvgq+E/VwkaPX9DRVX9ACy5L67tM
	 mZMi1J7ETg/6J/4w1uwi0B3e4PTiqc9Hqm0LNrPtnUqPCFMYeuVEmT2h2k9iMqJ6/d
	 okdAgEHYrjdPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5F39D0C1A;
	Mon, 29 Sep 2025 22:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: merge FUA command with the existing
 writes
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918502299.1733438.14091327351810942619.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:22 +0000
References: <20250904181642.3879283-1-jaegeuk@kernel.org>
In-Reply-To: <20250904181642.3879283-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  4 Sep 2025 18:16:42 +0000 you wrote:
> FUA writes can be merged to the existing write IOs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: merge FUA command with the existing writes
    https://git.kernel.org/jaegeuk/f2fs/c/44749759d5e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



