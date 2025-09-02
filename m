Return-Path: <linux-kernel+bounces-797293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF391B40E84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD1D7A35BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4C35A29D;
	Tue,  2 Sep 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/0b5CFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1635A289
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844408; cv=none; b=Yn8LT+9JhK9ehXJLWD/6bgcRuCB3878gnK6RhvbOwuLnWpM52CwD+w9PpXXTC3oKxBDMyzJd2ZZAjXp1GH7KIJDKjA/ZTdioOmbOb0Jg91Ekj0cdiE2hj+DqKQunG77jqQSzw0p6PwDDft/nmaPdwTcq/Jocy5A3sWp1fxduC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844408; c=relaxed/simple;
	bh=PwOmcYZ+4wSAR671uBP+wyJSVUsoGTkD0PrI8IMT7ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NN8f2vxymuYuZIhckxLEV0lGcSZky35RNYYTreo4A3uHHddF3+zIh5fTTq96bK4arBrwUfNq0UzxsKeTtlTo7jKeZVT2C7TI/8/j6dTA3DnxADTXLvhPsrP2M3gCmtnQxZUc3UuIMePj6vuLyEpyVFHMBJi3MbobSTBFAcTtB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/0b5CFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E6C4CEED;
	Tue,  2 Sep 2025 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756844408;
	bh=PwOmcYZ+4wSAR671uBP+wyJSVUsoGTkD0PrI8IMT7ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y/0b5CFhYijlV+q/qFuSKF9bOr4jYw6n6VwLySQu+RqRbA3ucfcJfoKz/NPRvHPEX
	 6aomzt24PIZvrxJMxC56X2chORKBcPoncZtphIqMsOTqC8carn7pkI1fXVHnbcdnOj
	 c4XV+hRBbHiV/lXhlYLPn3olIWRPdBR6Nt28ePyElAe11MMI4L7Rz9bIhevXXq5IQk
	 bcOg7tIgl14/FfVYeCq2MGQcX1fDAn+D5Iz23Zkwlj7PVmzLllPeDzXeGQ390nZffQ
	 BAIcnPinbYbmKz5Giu1RJ+ttwkZwI2sRntyvaU+m6Y1XBRza/eDZj/wNTn3rsUwBw0
	 EAPyefqNQpPXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC711383BF64;
	Tue,  2 Sep 2025 20:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175684441374.425353.1717450032024097846.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 20:20:13 +0000
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
In-Reply-To: <20250827215222.1615844-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 27 Aug 2025 21:52:22 +0000 you wrote:
> Let's split IPU writes in hot data area to improve the GC efficiency.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: allocate HOT_DATA for IPU writes
    https://git.kernel.org/jaegeuk/f2fs/c/c872b6279cd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



