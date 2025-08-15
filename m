Return-Path: <linux-kernel+bounces-771190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E221CB283F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E3AB00C06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E156730E0FB;
	Fri, 15 Aug 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXEP2HOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33930E0F9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275999; cv=none; b=EprtvZ2xQ6qClmrJmvgNgL9t6kzH7TOdrhjJtU5BOpJ7UdeO5/6gYf71o4Kr2/mOC5BK2P9mxxVzRiCxiwR0jnSV5tIgQtBsatJ/arOm6Z33jUJJo26dxP6+pKFFhs9+2r8zGFbe4+kpm5W3ZFLnEOF9QveqDgJOB2XcYnxJUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275999; c=relaxed/simple;
	bh=y9d5xuqRVvqJXmyoxx0QT1QVdEClBj28FW1UTbEJL+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uU1OOvTPujx4XVp7jLEdF0R5SUXBozlKuSaa6VdS5OctPqg3ReLQCC2XLYji5oL9DgUFMa67zt0cW+UpXA1+Uta6XUlWjMGQuW4Mntn5cC3vSNS1tOLjm7IUylvmg6xSxl+xyTmkOf38gCGjLVGanKcv1IkIOeahHkEsiFq28dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXEP2HOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1940C4CEF6;
	Fri, 15 Aug 2025 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755275998;
	bh=y9d5xuqRVvqJXmyoxx0QT1QVdEClBj28FW1UTbEJL+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXEP2HOHDNjzXGBHRRfJtnHZ/CWS6PWgJOPwlljH5Rl18IOjsE9u48rOrZED2DB4L
	 IJSOnjfswJWZTkYfQETrEulvCC/PQk5lJ2IXjlLL0MGOAbvQKSbJmGR8TLBrP0h4W7
	 +9MEVPqpHikD0wQom29wHfpAm/pYXrO7EuPJqebCW2rBM5hwULkkvQBCy58DeTQRhW
	 PCIhWyIMz6C/Qs+bAXPJUVUW6Ok0lQ2Hlw0+qi/Rx6yaqMLUB9mIpCH6cXXbfOXAx9
	 YNm6gCFmgeQunkRS+AU5ZqV3CNw91fJi9WtGPOzmXvUGnAEGW+MpVNfqs+8N3PESdK
	 pzQXXhlNXRG9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A3E39D0C3D;
	Fri, 15 Aug 2025 16:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/3] f2fs: fix to avoid overflow while left
 shift operation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527600974.1161945.15609859403158896445.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:09 +0000
References: <20250805062912.3070949-1-chao@kernel.org>
In-Reply-To: <20250805062912.3070949-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  5 Aug 2025 14:29:10 +0800 you wrote:
> Should cast type of folio->index from pgoff_t to loff_t to avoid overflow
> while left shift operation.
> 
> Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v3,1/3] f2fs: fix to avoid overflow while left shift operation
    https://git.kernel.org/jaegeuk/f2fs/c/0fe1c6bec54e
  - [f2fs-dev,v3,2/3] f2fs: fix to zero data after EOF for compressed file correctly
    https://git.kernel.org/jaegeuk/f2fs/c/0b2cd5092139
  - [f2fs-dev,v3,3/3] f2fs: clean up f2fs_truncate_partial_cluster()
    https://git.kernel.org/jaegeuk/f2fs/c/cbba5038ee29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



