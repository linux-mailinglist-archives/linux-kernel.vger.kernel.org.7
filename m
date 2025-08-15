Return-Path: <linux-kernel+bounces-771195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2400DB2840A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF01C8227D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125F30F809;
	Fri, 15 Aug 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUPh+IHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4730F7FE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276006; cv=none; b=kshc6vb5LgbohaNe87/Md+BEiSGVgXN092DvdGNf88IkTX77rdRuaUu+Sfmtsh8XYAyM0m1MGIkEZ4F3/q3hTlQgRUGTywVYM2RAaNO0hPBZTTWbZd36a+KCz11GOEEPB27/crhQqDLyIOCKsh1cH05zgSHGctoROFaUOEMJNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276006; c=relaxed/simple;
	bh=a95RvXhj76wg4j8/YlXy+Y3TsKNaDGJmw+oSsJ8lrVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fm/XfI0VakgCxL0S9YzCmKzyg5gIcCKXRZoZm01SEd7teweXW58AU2GNFO/blzXC0+HRLkvhWjfftDcZj7jiRj9WiEskr33A2Ps2n66vMxOHlmlQXDoJpLu89XP6IeuACLi54PMWjWQfTxmQz8YGJssCQzmJcddXlJF/RqBXli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUPh+IHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB160C4CEEB;
	Fri, 15 Aug 2025 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276006;
	bh=a95RvXhj76wg4j8/YlXy+Y3TsKNaDGJmw+oSsJ8lrVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XUPh+IHfb/68GPiml32CuObsiWqtPV8V7wlrrCqcAoChJTi4Z8/94TEvm60VpOnfD
	 YU6i/ab9wLgm1mt69FaOvPXeDXcPQoSxqZBDwH1srpNx8wzwgfhdjaErv+dM3qXOZU
	 MJhxKrh9Lf4g5sRetifcG9SSUSfq0FgaMha3mEzcv+PxTpvKq0bvHiRWIRo0zbaKI5
	 WmkZDSnoHUKgSbhNY6JEkDRMlsckfQtiLU4YFVuTT9+d/ghxHPexHyd1IgWiOmfedR
	 fpG63pfUlNJ/PQsIRE1vL6sdj8/gnBKyN6TvTc2I0bs2GJx4GCM87g9d5YTjM8Nack
	 s/KddtQVkA+4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A2139D0C3D;
	Fri, 15 Aug 2025 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4 2/3] f2fs: fix to zero data after EOF for
 compressed file correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527601673.1161945.11812358458954256363.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:16 +0000
References: <20250806061106.3445717-1-chao@kernel.org>
In-Reply-To: <20250806061106.3445717-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  6 Aug 2025 14:11:06 +0800 you wrote:
> generic/091 may fail, then it bisects to the bad commit ba8dac350faf
> ("f2fs: fix to zero post-eof page").
> 
> What will cause generic/091 to fail is something like below Testcase #1:
> 1. write 16k as compressed blocks
> 2. truncate to 12k
> 3. truncate to 20k
> 4. verify data in range of [12k, 16k], however data is not zero as
> expected
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,2/3] f2fs: fix to zero data after EOF for compressed file correctly
    https://git.kernel.org/jaegeuk/f2fs/c/0b2cd5092139

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



