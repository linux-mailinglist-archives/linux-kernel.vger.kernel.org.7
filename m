Return-Path: <linux-kernel+bounces-896280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE2C50068
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 143024F7856
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288E314D1B;
	Tue, 11 Nov 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFL9lVU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF42F12DE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901461; cv=none; b=lpaiD04QVVmqBCBqNoKQMcn19Slh541743rM+4oif5MWB6pc0ljaUZd3Dd+haEQRsCS2NrrxkvW/eKA8/ppCrtMDwBx1SYQ+dmSC2NLTF/icvblBmggJkYUEt3LYo8LWr8Rs0TKJYcjtJSjIOhMou7juEufgxhOu4ssWblPX+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901461; c=relaxed/simple;
	bh=u51U8yVkwn+sqh38JGcORAerkrd9IH4FeT/eOeCwWMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DBFddaiWWjm8LNwCmQ/l90xoTR50r+TccPhlTo2NZIheMHp3DDYpbUuQDds6dhAl2oqvrynDbp8mwN6t+5IClXSJw/bjRAK9vfsVWHtYbL/ERR49DXenyaNttgGjULtNuaAVLLLx9Zp6A6GBlGvVzd0bXCiT3urdsXS4at6xDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFL9lVU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D2C116D0;
	Tue, 11 Nov 2025 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901460;
	bh=u51U8yVkwn+sqh38JGcORAerkrd9IH4FeT/eOeCwWMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cFL9lVU8P8B2/FgWp6hFLkhO91Fq6rOeAvHISsN9tQvyuIL1WuHHXdaARX7v1qBwM
	 a4bhiVaTySMFg8DbTTYtU99hX46T1hopgYn4zgJW0ry6mn/o+tTnbA7t9BJdafAlij
	 vWW1bPNlDftqWyPCycJPe+LknhgWuRYb/p7mMxbqq+v3Mh7PUPlyiGHF3DZxcvRRZQ
	 +E/7G5TZkF0au7h4Ycl7StFz/UNwRUi5iLDsB7tLzTVN7NcUDxZiO4f0wjBLibAfIK
	 lUSbxNm+MXHlJUhx9TQuAq2NQynjgywcgOqPDBamufXfitqoi2Xvj/pIEQNAOLHwhi
	 /13YQ0BIrQ7Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA8380DBCD;
	Tue, 11 Nov 2025 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Use mapping->gfp_mask to get file
 cache
 for writing
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290143023.3596344.4932276486991628363.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:30 +0000
References: <20251010-origin-dev-v2-1-952a3c98cd9c@amlogic.com>
In-Reply-To: <20251010-origin-dev-v2-1-952a3c98cd9c@amlogic.com>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 devnull+jiucheng.xu.amlogic.com@kernel.org, tuan.zhang@amlogic.com,
 linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 10 Oct 2025 10:45:50 +0000 you wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> On 32-bit architectures, when GFP_NOFS is used, the file cache for write
> operations cannot be allocated from the highmem and CMA.
> 
> Since mapping->gfp_mask is set to GFP_HIGHUSER_MOVABLE during inode
> allocation, using mapping_gfp_mask(mapping) as the GFP flag of getting file
> cache for writing is more efficient for 32-bit architectures.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: Use mapping->gfp_mask to get file cache for writing
    https://git.kernel.org/jaegeuk/f2fs/c/2308de27c03d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



