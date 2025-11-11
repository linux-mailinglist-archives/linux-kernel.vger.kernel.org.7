Return-Path: <linux-kernel+bounces-896279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD1CC5005C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A44F6DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229522ED846;
	Tue, 11 Nov 2025 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBYnHmnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99E2EDD5F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901457; cv=none; b=une9wcKIWhH1cskr8ed8fowMSa0+WcEwv59/Acuyxpj3IkIfd/x0YApUC2N/dl+qeZLEAZcYzDDt4GbtCB9GCNciNee3VHBrbZoI3TPsyq/ygfUZ2DE9J0SJkLAV1kA4rtwATs2yq/Rwwk56FD/aH5x7lJDMnkyFnsu0nqbSAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901457; c=relaxed/simple;
	bh=7VpfNaZ4adwApeqpXtv2bP78gdROBfMS0yAzq0Rrk4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E2B6tgWmvjHb7++OCndq1FuUOZe07bToGEf7YIxHZdfAzkm83nQ1kGWdoeEKcL6KgxI9w/wZcr5ryyyT6DWHA03UyY50uDlWv8TK4jBH4pU+aFiutw35PVVUHOY6anp7vckGuLhnVsECi6r8Qf10qEd7ZviXPtt3DpJNoVVWHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBYnHmnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D4C4CEF5;
	Tue, 11 Nov 2025 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901457;
	bh=7VpfNaZ4adwApeqpXtv2bP78gdROBfMS0yAzq0Rrk4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HBYnHmncznDlrXvgfoDQSW73xZ8qIeTq9ZugmaLO6E4YhVomvl+Yw2d4FvNZqomvY
	 ppztbU7WfcEQfAdXPM7BidOw1XGS8SDw/asoGatqecgtCezGGEMpz40Mw2CIUW6VDX
	 Z7k5mroKzMSjWVT4T+/FjdFfuBrk6T7vgB1YzoWtwV2rHksxC+MvyadETHHVEoOokJ
	 alyDdFjqH33kLIgu3ytYj3htdEZQh2eoOLPjrHGJ9cSV2rFqPKJmJgMzDDIH5tmqcj
	 OpFRnmQ8+fUjRkMKDiBmv2x+OTXqiFKzI55YePeLOutO1OZYKr42cNA/qQpl2g4iYV
	 tPBDtNurPejfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC88380DBCD;
	Tue, 11 Nov 2025 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix age extent cache insertion skip
 on
 counter overflow
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290142724.3596344.8108085156417902298.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:27 +0000
References: <20251027092341.5011-1-hexiaole1994@126.com>
In-Reply-To: <20251027092341.5011-1-hexiaole1994@126.com>
To: Xiaole He <hexiaole1994@126.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Oct 2025 17:23:41 +0800 you wrote:
> The age extent cache uses last_blocks (derived from
> allocated_data_blocks) to determine data age. However, there's a
> conflict between the deletion
> marker (last_blocks=0) and legitimate last_blocks=0 cases when
> allocated_data_blocks overflows to 0 after reaching ULLONG_MAX.
> 
> In this case, valid extents are incorrectly skipped due to the
> "if (!tei->last_blocks)" check in __update_extent_tree_range().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix age extent cache insertion skip on counter overflow
    https://git.kernel.org/jaegeuk/f2fs/c/96d62153b64c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



