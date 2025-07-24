Return-Path: <linux-kernel+bounces-744909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA05B11261
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901731C83DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D32E7F1D;
	Thu, 24 Jul 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKEgLJa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550252E5B2F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388994; cv=none; b=tJFGnllQEFSzGvyDlPOJxrcYQ5m6fmk+3zEljoKjNIkjceY6sF3rEo34+/2qwI5G5OpR+opVgwmIK7XFClWXmhGHodeA2HGq641t7LTcV4R4Xv4epIlBSkFJQqQWwi7VTie12fmGmkZgMzYitmpJuplpaNwpvhcskJdGQJI/qGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388994; c=relaxed/simple;
	bh=LYDvAi+oLveMgY3YmOkXpDoCDiOLM8woIasqX1I8qZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzUNqCG0ctk26lMirxujoo+kBVEnAajExHN/Cj0GHL1sJvHCbPUp6yM0flio1y13bq/0dJ5vniqGlbgxfFYuYbG/bXnrru7HcUUFSPoCX1wwQ4Mkv5BH/bAaDSgBqrZ6hRYDW5a2idiyul9EB3aU2nnYOHqweaUKgzwVhRGA7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKEgLJa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF8FC4CEF4;
	Thu, 24 Jul 2025 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388993;
	bh=LYDvAi+oLveMgY3YmOkXpDoCDiOLM8woIasqX1I8qZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKEgLJa1elFugQ6mzuAcPZM7Ri9Nio7lgRkOCpEHtyN1WKBCj4FNcqOTmEw+pRg3i
	 C0hkR+gKfnTp82MfabcNqNlzSHJdTuE+w8VIr1pU2OQtj2FhiT1GbgF0+9h2ZDEFBm
	 VjtBTITIs8Ku/xRqjMPlHITsFJiI+PVdobmwXo6E6fcK4dsZAG3W+6AOA7KfCbfcct
	 3rIs5waVwQFh8/2OjpwFyva9u+LvwWqarE4bF02rei3oI8KMu0kxuS6cJA+bZQLjJS
	 Lz9WhOJPu/cPnYyLm1qSdstNFcMMDL6KCSHbWJ0UOLdlrRoLpoRXI8dYacvOPpd9Ss
	 BnK0uVoTL+yTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDC383BF4E;
	Thu, 24 Jul 2025 20:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: zone: wait for inflight dio
 completion,
 excluding pinned files read using dio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175338901149.2519964.13246019745046353367.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:30:11 +0000
References: <20250722060240.1469-1-yohan.joung@sk.com>
In-Reply-To: <20250722060240.1469-1-yohan.joung@sk.com>
To: yohan.joung <yohan.joung@sk.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, pilhyun.kim@sk.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 22 Jul 2025 15:02:40 +0900 you wrote:
> read for the pinfile using Direct I/O do not wait for dio write.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: zone: wait for inflight dio completion, excluding pinned files read using dio
    https://git.kernel.org/jaegeuk/f2fs/c/3bf1bab503a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



