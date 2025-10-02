Return-Path: <linux-kernel+bounces-840763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B890BB5390
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86D894E6E50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8EC2C029C;
	Thu,  2 Oct 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFwMJG3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA67299AAF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438217; cv=none; b=VJUUZFcOL3AlrdChkx00tNIlWSTYi/hSrLZp+4eYXYD1L2syzAECrWXERQ+aF+4fw9PJDy3etPzxgEv3njoWHutPEVgnO3Ggt5ZavSthJp9PTe67rbkftKFVKc4mrNHT2h2SEOjXl/7orJRGAw6+a1+pEdyGO7D/GRb9gZn4maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438217; c=relaxed/simple;
	bh=EXhKnU3EDHpJYtT4b6I9iscaUcjmn1BwkTdxsF58duI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ftdlbwc4XTPtGgFk9UtzjbqA5j3s9F72Vy8fUzkvYqm2EemCgDFHt+OAQRjnmLiuH7HwPN2LWx2papS2/8JJ44PWdTf5js7C/DQsof8s+lATH7J6VNBhZMLk9CI1QhpwR5FxdPffh1S3l25sVlcIUyy99822q5Qtbv/2B0lPZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFwMJG3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682DCC4CEFA;
	Thu,  2 Oct 2025 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759438216;
	bh=EXhKnU3EDHpJYtT4b6I9iscaUcjmn1BwkTdxsF58duI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFwMJG3Ap/dfw78C5j55wWJzhX+v6JR0pMgVsu9zW59cVqn/ohJlWUo0AloogtP99
	 BWTplnBM8DsaVZ17yveyb9Q1q6MQ7saVAVXyW80qy7DazRagQgUL6VXQQB3a3j5CW1
	 hWYeAjkpozBHH4hr+g2pZEroVJYkGsf2ldfNOzeT/zcKbMSmz5d5cg3iY7tk6Aey6s
	 syY9OgF1iGlY05jZ14SbjFnZowEsy9sloSURiEp6wugZyXuwZF8y3GIKzOLfOhM67n
	 oGZQNSzF5nYylq5invIAx22r5oEfWMGJEaa+BVFFJpD8gy8tG6RDMvvniVCXhjDx+T
	 FqBpJ5yFIQ/ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7102039D0C1A;
	Thu,  2 Oct 2025 20:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ifolio memory leak in
 f2fs_move_inline_dirents error path
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175943820824.3449937.3681276954916769253.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 20:50:08 +0000
References: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
In-Reply-To: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
To: Haofeng Li <920484857@qq.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, lihaofeng@kylinos.cn,
 13266079573@163.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 30 Sep 2025 17:16:21 +0800 you wrote:
> From: Haofeng Li <lihaofeng@kylinos.cn>
> 
> Fixes a memory leak issue in f2fs_move_inline_dirents() where
> the ifolio is not properly released in certain error paths.
> 
> Problem Analysis:
> - In f2fs_try_convert_inline_dir(), ifolio is acquired via f2fs_get_inode_folio()
> - When do_convert_inline_dir() fails, the caller expects ifolio to be released
> - However, in f2fs_move_inline_dirents(), two specific error paths don't release ifolio
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix ifolio memory leak in f2fs_move_inline_dirents error path
    https://git.kernel.org/jaegeuk/f2fs/c/9fc1840e0217

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



