Return-Path: <linux-kernel+bounces-694705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC1AE0FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 00:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79AC189E2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321C293B46;
	Thu, 19 Jun 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKAPMSJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A2290BB4;
	Thu, 19 Jun 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373396; cv=none; b=JpOYCW2PQHJWLmi2OYf7Q8/kWYwYAmbgqfTZHY+CxkO0oBRF7ui5kDAtfwkci5AGBRjuSDrDEjg8ERRrTF4IDV9+sQfx8bVRDe5lFP0H4iI4V/iKIFk0AJ+p3grTmz7nIMVQOghvepy2O1xWGuHWLdATZkr+vRQOz5ss7fiIyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373396; c=relaxed/simple;
	bh=IEl3Qxe9G4aEzvOzD9TPWOAxEI89WxS5C40gmzn3ckM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lxexd5chvVLX5/KC9fLEYwlvE3iACoLR9K8Ten5TE7j0/KBXXXuYoCu8xqfZLHIYzmYkCWtw+yvpSO9IrP75EjEGNLphBbovcOdVOe7u/M0CusqrfZFacEZC4UPu+8rS6V45DD/jzGjnLJwnnBcqoMa7t8B09bpUVTBRSSAbDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKAPMSJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50A0C4CEFE;
	Thu, 19 Jun 2025 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750373395;
	bh=IEl3Qxe9G4aEzvOzD9TPWOAxEI89WxS5C40gmzn3ckM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eKAPMSJ+/ILWNsGYLtmi201BqpyQISe5SReL3J49kOvB2WtfsX2ND1Dc04aLBU/Vk
	 nb0UJlRgFLm7T2dJ56H+RiQusC1WpXRxyyaTMlCQRIY89Qq7SwOBAvHjACENElXt3F
	 6hmwAYr4QHGeKHl8lwochHmYr94lDZffdv5dbSvISt0PMmR7v69mKm/f4WnbfDWeO3
	 Q+NAikNlElK5qSC4dYdntLvpJqH30dTkWe98EREM/Inq4rwNaYr2QoE/pSVfffLU8u
	 BosberWYzMLYF/0KSRBTpkgwFsSNNf/JTbWSqmJPIekW9ZbqNrdfGBIc7Jkb8o8wos
	 Y56W7TQ6EhIcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE538111DD;
	Thu, 19 Jun 2025 22:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] igc: Make the const read-only array supported_sizes
 static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037342399.1010622.16235636667757427783.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 22:50:23 +0000
References: <20250618135408.1784120-1-colin.i.king@gmail.com>
In-Reply-To: <20250618135408.1784120-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 14:54:08 +0100 you wrote:
> Don't populate the const read-only array supported_sizes on the
> stack at run time, instead make it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - igc: Make the const read-only array supported_sizes static
    https://git.kernel.org/netdev/net-next/c/deb21a6e5b4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



