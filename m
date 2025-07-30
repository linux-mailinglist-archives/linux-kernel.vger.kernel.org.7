Return-Path: <linux-kernel+bounces-751104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FAEB1654F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88B5566944
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6672DE6E3;
	Wed, 30 Jul 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr3IYbDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF2DCBF2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895990; cv=none; b=kN6hFVjl4brM6C9E9GBmayZS+U2lwufR8xDNi/mZu5VXpc4tc034PQ0PlymRzrA1hhxVN1rs6zOuWtXUM0hgESssj9wq2UR5Km3Ni7alEFlxrKvIVFcZSyGExysNFJcLan/D/wY7ENu8FXJrPM3/cr2CgNSka1kxQ/e+kYq2K+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895990; c=relaxed/simple;
	bh=CQTsNGrLVlOyPWOkdIBqRhQz4jq7AfjVW2m4lEYekcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YVW3P+x8f74ce6RYhxNMqVzSS4psSAj6ZZNy5tcRhSctCP0WE7EjziZF0OGB0Ir6+nxA/fBDB3UXHyAmXRAJ1oB75xSkdYBNPOOPxbn9OBMSaEJVpWKtb7iCuUkjquyRcccHtnI54IHQPJfFvhDCt+ENlhLRRPNOgSgFc6eHXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr3IYbDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CBFC4CEE3;
	Wed, 30 Jul 2025 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753895989;
	bh=CQTsNGrLVlOyPWOkdIBqRhQz4jq7AfjVW2m4lEYekcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wr3IYbDFwiHigsUHmvJHnXDLg941kU2z9tuEFFQ3R2kdzUK92oLqifEKbMSBBDgKm
	 iX1dFDichWNRxygenv/4SQCqEL95iTZ97kWrTAeUJuGlAY+lluVIsbnpvBFp5wSLbp
	 teTmzLXmBtHC2uDrXMYFGvm++KvJStdhHN2FDx7JiJeIb9jm46dRzsreJE2HApKk8N
	 Y2SbmbMuVX1EiMKdwbtE2WfQNHvNzCFU658TW5YBSuG5rWSxf/ZofQCFWrl7TNOowj
	 DUCU5+j+dLGuS7hEBGzB9eRct/CSz9EDIMpuOSd7tzQVILqNYtYT2hdXWFWvOYFlkp
	 RfqrEghmK7hMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB114383BF5F;
	Wed, 30 Jul 2025 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop inode from the donation list when
 the
 last file is closed
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175389600575.2380550.14219275331926903435.git-patchwork-notify@kernel.org>
Date: Wed, 30 Jul 2025 17:20:05 +0000
References: <20250729204719.1253285-1-jaegeuk@kernel.org>
In-Reply-To: <20250729204719.1253285-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 29 Jul 2025 20:47:19 +0000 you wrote:
> Let's drop the inode from the donation list when there is no other
> open file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 2 ++
>  fs/f2fs/file.c  | 8 +++++++-
>  fs/f2fs/inode.c | 2 +-
>  fs/f2fs/super.c | 1 +
>  4 files changed, 11 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: drop inode from the donation list when the last file is closed
    https://git.kernel.org/jaegeuk/f2fs/c/078cad8212ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



