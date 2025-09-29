Return-Path: <linux-kernel+bounces-836841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9575BAAB34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AB2189EC65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB27261573;
	Mon, 29 Sep 2025 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpowPGdq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90625E816
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185038; cv=none; b=jYPGfvnJCdGludRZ7tEZXnWDDWqxMTozrLIg4K20a+6+hPpja0DBvYuFu4ZMJhwC3FFPonY1BkTIA7wG6iDXvqMdfA+tfOpJOq9JeYQbM1BURXX3Z9HE6X2wg0TIeZ4Sam1+lmDEQHegMzp//Scy/wtTn2EUesr7uXnbfY1/x9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185038; c=relaxed/simple;
	bh=EfltOg2/g+0OzcQYOIHaLxnWVQ/3BkQk9eFFQdoxWEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VubyF7EFSiaOoeNBrxz08saDrXmM/N/OO0B88yZcgz2QhC306nS0wbllnB/ifdHHClFZ1/do2KC8y3qYaXFcL6tWUL2COlBcSFpQMft8+DndfJeDLMq/MVOXQyeO46yfi9AEYPVfQuaTaS/J4vt+BYlshq/tQcFV9FSRxirCl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpowPGdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036FBC113D0;
	Mon, 29 Sep 2025 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185038;
	bh=EfltOg2/g+0OzcQYOIHaLxnWVQ/3BkQk9eFFQdoxWEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EpowPGdqFdoliAeFR3MahJJhc4/Zh4T4PYnOb721++WKVOjnk1HTF8FzczegkG7f9
	 6kNiVZWhZjBWfb9b9tNfHZERHNfLZYjO1BVPZcIpTLD3DTaw8FtsYX0QR1UzPnoK7w
	 Au4MmDMENGegVQKFjihAKk89NIhTScAErEwfmjD7j3TNLC5UCdFVFLWnuFvX4JdLr4
	 pBTc1F9p5l50ineSw4FMHxJEwtz2OncD6szSEdso9smd9jQqQtkw5bwdVb1Mr1/wzh
	 pYcQQW/6f5erQCWBLEBL+k9dC4PMhzdN2urAWXO1UPj9iPLrhLI+KCXTAe+wpHA1IV
	 P/o+FbTWQI+Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3F39D0C1A;
	Mon, 29 Sep 2025 22:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid unnecessary
 folio_clear_uptodate() for cleanup
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918503148.1733438.7250596778534076911.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:31 +0000
References: <20250902122720.2750481-1-chao@kernel.org>
In-Reply-To: <20250902122720.2750481-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  2 Sep 2025 20:27:19 +0800 you wrote:
> In error path of __get_node_folio(), if the folio is not uptodate, let's
> avoid unnecessary folio_clear_uptodate() for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: avoid unnecessary folio_clear_uptodate() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/2f84e99d6194
  - [f2fs-dev,2/2] f2fs: clean up error handing of f2fs_submit_page_read()
    https://git.kernel.org/jaegeuk/f2fs/c/d0236266cbfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



