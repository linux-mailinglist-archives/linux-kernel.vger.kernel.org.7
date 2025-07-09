Return-Path: <linux-kernel+bounces-724264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA1AFF09E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DBF17EDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96612245025;
	Wed,  9 Jul 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/4jmyRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02EB245007
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084606; cv=none; b=itzw97FoXiniK7a5QPqXL8SwMPxqCevowZ1t4n4prtl+Y2AKUbIEj4XCJXaiGKIzDYzHJJuqafbOQd7VM37a3EC1yhhkm5selaS/24Uffq+7fU9fvKbySuelLM+HenhmbVDw/Ywtj9Wdg3+sgFTfqpospOHTw6yZ+9C4QlOlYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084606; c=relaxed/simple;
	bh=HpLA/csdIf4y0vi9CmCGy/+RR/+xZan3AAxP+nrDaec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aip6cDmjg2w/ixQ/5tgkl0GcYpSzxTqGYnAoF6LXUua7wj1qvO9YwZbQAjicsDrETqdJlXMhWZqwRoJVbytHpomoEbd3mZpeV7VqopPaTNGTMLdCkoeD6SHqJ0SY4EuthUz+pfRVBxo8YEPnrXn5H58tIlwYBn4yU0JJmGywjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/4jmyRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF40C4CEF6;
	Wed,  9 Jul 2025 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084605;
	bh=HpLA/csdIf4y0vi9CmCGy/+RR/+xZan3AAxP+nrDaec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/4jmyRDuF9b2FHz0GcygnbXH1j72BbZ4HWWBf6OPM3ri3guL2pGHmfHdrGqkzb8B
	 OVw1EjAi3pLr0EBkCzvjToXugOoFFUnmkBRXvbVYK7PD2H1LUZM38dJh2Lm0uLf6be
	 hFyF09CZFpk/ZBNLxbYYxUNaGMXdO9bYU+r5MGyEQWXdooCBxb9Vr+kvgfJJeadSml
	 /IyuUE6FrKz0GHrSpaxecqHMt4IGun3PZS0mfpoulJ9Wxokazcnbv74H/Mxu9VUWUD
	 GMFMBfuMX+MhpmwfK4cfxwF2/MKSVm+2RO/24sloA8y6vKn1ncyAmneAmd0HjBOmU6
	 C5PArQUTo2ZnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4C380DBEE;
	Wed,  9 Jul 2025 18:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce is_cur{seg,sec}()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462800.806926.16263047137393300350.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:28 +0000
References: <20250707114614.2769306-1-chao@kernel.org>
In-Reply-To: <20250707114614.2769306-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  7 Jul 2025 19:46:14 +0800 you wrote:
> There are redundant codes in IS_CUR{SEG,SEC}() macros, let's introduce
> inline is_cur{seg,sec}() functions, and use a loop in it for cleanup.
> 
> Meanwhile, it enhances expansibility, as it doesn't need to change
> is_cur{seg,sec}() when we add a new log header.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: introduce is_cur{seg,sec}()
    https://git.kernel.org/jaegeuk/f2fs/c/c1cfc87e4952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



