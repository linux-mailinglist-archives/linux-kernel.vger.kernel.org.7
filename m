Return-Path: <linux-kernel+bounces-724259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB143AFF098
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FADC16B82E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458492405E5;
	Wed,  9 Jul 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez9Wweml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1623F41A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084598; cv=none; b=CCweGkYLZWX/bgzRtEM0M/S61OwDlU1rXlunGxFr1IPGIKojjPnGCSFidTIRcsmQLQWWsJ92xkvVzmo+EaGOKwoiq/YmT++9jrUQkY4mHOOhUCysTTeRUefFlCMx1W+ZC3vRWbO6w6AHmUJ1Y2LArVcLHMJnOQ4KMnkFecQGs4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084598; c=relaxed/simple;
	bh=PKgtzgcV/ujkOAVJ93cjdK7VUxmhwe/fYDKEX/qBY2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QjpP8jKeNItd1IJBjK8ltwHdD1ydCAgo/exrk/PkIObr4QuwcwAcKdxZcC+uNfYCz3jmsn9LrH8iYQtiwTT3MtRi/jRC89OHyH71AX+2KLgMhCi9Nkvbx7K16nbyN37rjk08nEqL5U3yHiT7lTKI7y4H72SPtlhz5qTDDpkOea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez9Wweml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32985C4CEEF;
	Wed,  9 Jul 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084598;
	bh=PKgtzgcV/ujkOAVJ93cjdK7VUxmhwe/fYDKEX/qBY2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ez9WwemlwXgWPpRJYi6waK0cw98qZ/rZP7chh0KdElvol6VTRL3N3HrJdBwdrOd7j
	 MvYoU7gNE/zB4yNDyvQUTcmFfNKqD5MNcFV2ZzEPd6mgJGPZqDFkwj+prt1WsotMGU
	 cT6IZD5OeMuRSR+gRJeJI55PBszo8SgoapsMwKROHnnr2AGUAP3ainhrJpTEyL+ycX
	 r7UBaVRCOV5fOE3l7yC+BEVljJ5UrsTpV7kTbSNhuLBqmV2CRMX4ssMH0rF5mOecnc
	 COtBhqTBWHMjdbp2wRt46eTyyWEKfkkNNn3TK8nK+gPq8J0FMdGgO4EH+Bx+k859Ig
	 2TEvNTTYn27qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6C380DBEE;
	Wed,  9 Jul 2025 18:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: check the generic conditions first
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462050.806926.15984243723421568237.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:20 +0000
References: <20250630160839.1142073-1-jaegeuk@kernel.org>
In-Reply-To: <20250630160839.1142073-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 30 Jun 2025 16:08:38 +0000 you wrote:
> Let's return errors caught by the generic checks. This fixes generic/494 where
> it expects to see EBUSY by setattr_prepare instead of EINVAL by f2fs for active
> swapfile.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: check the generic conditions first
    https://git.kernel.org/jaegeuk/f2fs/c/e23ab8028de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



