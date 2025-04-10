Return-Path: <linux-kernel+bounces-597296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71EA837B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 06:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90C13BF6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA3201261;
	Thu, 10 Apr 2025 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQdToegW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024D1FE45A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 04:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258202; cv=none; b=IQZrk5gb8lDH3C7E7ypQvNjiVR9DaPHSaok5C454jx45mIvXB7rXPbuyOgipi75IsGzkVBIpoH5Hu7rPOOtjKzcSOyVK7T3L/HIsuPZEXvzl9asCh9+FxX6YoCt+Cq6XFxKHaBYtORY+be25JDcK9hRrX2XjuexxtrbLS8NEwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258202; c=relaxed/simple;
	bh=3D0KxFdT7AaX3IlEJQU4ODQ06zsDhm92FFBCaoIfeG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KYB+W7ewVFp5t5iHV4IRA4SK/0ARnCSwHwv2HXNhDjXlqfJ45TTb8x4tJbInRXrtg1AZanYqCXsCINBRtR+xFLEaMqB+qHphkgvuM0mQuJ4MbmxNCGkNPtG5akIGWNljU+X0n0hGRa6PM3Kjr5KMfPoWfNRSy5aLGQBovgzi5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQdToegW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE83C4CEE7;
	Thu, 10 Apr 2025 04:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744258201;
	bh=3D0KxFdT7AaX3IlEJQU4ODQ06zsDhm92FFBCaoIfeG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQdToegWpr7tOtIQL8BNqnnlcFNI0/LV5zIcgRxVR9lXOGZGg+TMU1ubuAP+W4q7e
	 8Mc2A22Mj5yRHzL7UoCf3UNadtD1zkg2Opk5shiKTZEtUb43oSzPCVPO1cbljPTC2O
	 yRkpcTMAJPNV/vxVM2PTwv0KMb9/X6gFJO39F1d/fmNz/WpMzaOD3z+/2pXYeoZ0+i
	 amepeZETQBKkorGzKzptELKeIV8U3ns2DciOFHd6NsIFe9tJya47egOsuEQoyiwowE
	 X9crj2mIXV/BGsXikaFOutpes7tLaseAnxJ/TTS9MUqXu890e121y6bWP4FbDzWzme
	 EohSGnfnw8MRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D61380CEF9;
	Thu, 10 Apr 2025 04:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to set atomic write status more clear
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174425823876.3146257.767452728339565870.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:38 +0000
References: <20250327055607.3829954-1-chao@kernel.org>
In-Reply-To: <20250327055607.3829954-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 27 Mar 2025 13:56:06 +0800 you wrote:
> 1. After we start atomic write in a database file, before committing
> all data, we'd better not set inode w/ vfs dirty status to avoid
> redundant updates, instead, we only set inode w/ atomic dirty status.
> 
> 2. After we commit all data, before committing metadata, we need to
> clear atomic dirty status, and set vfs dirty status to allow vfs flush
> dirty inode.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to set atomic write status more clear
    https://git.kernel.org/jaegeuk/f2fs/c/db03c20c0850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



