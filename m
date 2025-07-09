Return-Path: <linux-kernel+bounces-724256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E729AAFF094
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F012F480AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796523B633;
	Wed,  9 Jul 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcg89k/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CC23AE60
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084594; cv=none; b=mkZWUaFoLb6FuCxQcRxyIjorPnDt6NKj2Nb38mnDzzqdT8I9ncZU/kFIEdf4+s7boIYXhuwRvOn0ZxNbrfhmiXIPwDbZokaskG/FZCeo4F/UbgU7uCAF5dwcjxvdNJrjAZf5EfmUOGgY/GlmAYBO+znoP0YvoxveCxdMw4JGRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084594; c=relaxed/simple;
	bh=deWznCu+qIVvHco4q82pWqu7tD2dtpJCvTArIsFwwoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pLqSBjSOg9BLAYOTo8H90ofGsCjIizXZYIaWP5+LFxSRaT+Y9ltuXz5VRHI61+Sygo3/xOZ+aZegxwdT1FCI4mOYeG78yqXXp4f0OQUBcG9lSZ7loPzxJXkFYLwFqcp/pQ7wo7B5PB4Na/mGQ2LHGwW5OogV+tXOcu209V4AWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcg89k/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E1EC4CEF4;
	Wed,  9 Jul 2025 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084593;
	bh=deWznCu+qIVvHco4q82pWqu7tD2dtpJCvTArIsFwwoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pcg89k/5aI50z22ZC0VOG+RaCBBRuG0I2Rxs0OESF+As77JBKssJToQQvS/UpzHuV
	 wj00tFkwiG6JcbRm0hlzPIASIOzpyIGa3PHs43Vv+/l4egALWvnHvOkam2jbemkZAU
	 mxk2u9qQzqMwtcyGhB+N2n+F0d4A332lXpQPgnAx97dTOw4ueVGP4TikyjwXZ/lMBN
	 dfJQ3/gnxp2IorXT941oMpQyPod9pwWptUl5eXyF5xlvgOauilLqFnJOyr4snZncJw
	 Vw9U1jVzELHWNTmPFovgBl0fIclSHSRoUBG5y4uDTFxqKvRks8D/2DkHqb4ZTidapc
	 WpCMqN9s9ikfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE363380DBEE;
	Wed,  9 Jul 2025 18:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix the typos in comments
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208461625.806926.1915540263699572760.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:16 +0000
References: <20250617174047.1511951-1-s.prabhu@samsung.com>
In-Reply-To: <20250617174047.1511951-1-s.prabhu@samsung.com>
To: Swarna Prabhu <sw.prabhu6@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, s.prabhu@samsung.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 17 Jun 2025 17:40:47 +0000 you wrote:
> This patch fixes minor typos in comments in f2fs.
> 
> Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
> ---
>  fs/f2fs/f2fs.h  | 6 +++---
>  fs/f2fs/node.h  | 2 +-
>  fs/f2fs/super.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: Fix the typos in comments
    https://git.kernel.org/jaegeuk/f2fs/c/1f136890263c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



