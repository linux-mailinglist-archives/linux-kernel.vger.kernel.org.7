Return-Path: <linux-kernel+bounces-856778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270E9BE50BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FA2545EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90803225785;
	Thu, 16 Oct 2025 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAPKydVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA687464
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639076; cv=none; b=XQ5aZYbUj3UxmuOTzaZIiG49u0QC3HuUmsjmmd0MTJhk7t/IpXPwHcpMTT9698oAUxRxFxJgRA0VcNlx8whGCOIrya9dhhYNHUY7U98dLFM5eFsRNC82pLqzzGnev9jpi+pT1c0Dm3M9aPfCCgbkHoiOzaskbgI7rAUErHUdqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639076; c=relaxed/simple;
	bh=TPTHCPwqGZ9LOOxGmtMZ+cselDo9inzb2+E40aM+RIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i3A/0CbQ8gOyWtAbnIn7fdrQJdgwguNYqaloCTGUQ103+0blyYyVKj0Wfw3SLIH4YFWs6iAlMHotFVpWFuKluZWPPyQPA3An5iliR1JwLrO1df+g60OTaS+xYNhtgzojEUonn1yuoDvjQkcmfKm5iZQ8bJXjImN3DrERjcAL/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAPKydVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E02C4CEF1;
	Thu, 16 Oct 2025 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760639075;
	bh=TPTHCPwqGZ9LOOxGmtMZ+cselDo9inzb2+E40aM+RIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SAPKydVdK5R30Jule55EwpR11Eb1Kh9FiLjoLwYfpyLCzR+sCRDx/nLzzG6+aRByv
	 3oD2sqLGaV9Q7nXcD2/EiU2auzSrBxS1rkw4F+pBPN/PSq6xghguRgqG/4Xq/XjdbX
	 UC/CqWIBUrUyLnUDMsVd2W7OxmcXaqHqY1pQJXAUCak+KxpXMH7Q7TjI3sxngIXU6q
	 JBfvcpJdXJSAKIK4FIIXE5qzyntTwqdzOWgGNYzDpAGVBOdmII7D9XMEjFHM991JQx
	 IwtS+yt0LcQhdWtREoV1qaHqHPNmDrhtV3LoWYGt0t+S5nFSyn2vfhjEl+uTpTuHoZ
	 wPnwVM28lGaYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2D39B167A;
	Thu, 16 Oct 2025 18:24:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: maintain one time GC mode is enabled
 during whole zoned GC cycle
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176063905975.1852182.15050146332743005367.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 18:24:19 +0000
References: <20251003224308.1948874-1-daeho43@gmail.com>
In-Reply-To: <20251003224308.1948874-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  3 Oct 2025 15:43:08 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The current version missed setting one time GC for normal zoned GC
> cycle. So, valid threshold control is not working. Need to fix it to
> prevent excessive GC for zoned devices.
> 
> Fixes: e791d00bd06c ("f2fs: add valid block ratio not to do excessive GC for one time GC")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: maintain one time GC mode is enabled during whole zoned GC cycle
    https://git.kernel.org/jaegeuk/f2fs/c/5d431cc8759b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



