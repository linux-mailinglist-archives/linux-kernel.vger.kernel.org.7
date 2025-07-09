Return-Path: <linux-kernel+bounces-724255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11FAFF093
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E873BF97C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00F237162;
	Wed,  9 Jul 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Qeq4cZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15562367D7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084594; cv=none; b=u6M610EYcgDO+eR1o26xTc70tq4hB/Qz6AlrlwGiwWNbk2rzH3XrB+WKUOinp+zCh9kKimRFvGG8PACbsXGXBLSyhmPNPcI+NBSBYVECGBTDIhL6nqgG/+4DcscMZmy58wl5t6RQ7fk1azvaVrdrHetpsABQLhQg3EWOLKTFgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084594; c=relaxed/simple;
	bh=sA5J+muO6rD3pT+tp/xSgnrdLGmaAE23n4SGICzARtc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRkKlyBsND75UrzQs9Wr5ZQRX4MviCXLGoJAhoXRumOhrlyiWyciCKIZ58ZM504BgIuowtV2fBotsat1dFpshETevvsKs3z8Ft2EIz2cyUrfHlX9aEtROIVLPInpO1yfQTIOrezmPoyvK3jhtJw1hdi8h3x1wDSsbVuFiT8ZOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Qeq4cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7520BC4CEEF;
	Wed,  9 Jul 2025 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084592;
	bh=sA5J+muO6rD3pT+tp/xSgnrdLGmaAE23n4SGICzARtc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H9Qeq4cZqHeWNs54ca7LX9aAoGcJZmwDX4Bye3hypNcVB9cHo9H2eCg6sIWtVoHss
	 zFsPno0WJHDEhqY8mUZ6oCaBe5B4PSXFaJVx3B5F20cKxSikmTHHFJNPaEEQnG1+av
	 mRVv3I3JY3bzk5lkJMuIksPSpylGz5ASri3Ky9TAowsozkJ184MlIu1PshchetZve3
	 ZTzOI4Niwhf7LF4eCSW2cRKH7O+21JavalY1fwHhWXUtt2tagemJp/uKXoAw2fNiKD
	 ap+IfvYj9YnfrWBGzsdbHBdLMoUQqXYllSB8LacTCxFNd+WTYDnVIfBwm9czWDiUR0
	 Ll3mV0tg6u0BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343DB380DBEE;
	Wed,  9 Jul 2025 18:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: enable tuning of
 boost_zoned_gc_percent
 via sysfs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208461478.806926.9492710512867516204.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:14 +0000
References: <20250625001336.1937-1-yohan.joung@sk.com>
In-Reply-To: <20250625001336.1937-1-yohan.joung@sk.com>
To: yohan.joung <yohan.joung@sk.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, pilhyun.kim@sk.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 25 Jun 2025 09:13:35 +0900 you wrote:
> to allow users to dynamically tune
> the boost_zoned_gc_percent parameter
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/gc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: enable tuning of boost_zoned_gc_percent via sysfs
    https://git.kernel.org/jaegeuk/f2fs/c/956b81b3d41a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



