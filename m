Return-Path: <linux-kernel+bounces-782194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F582B31C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A045464596B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DB3126C2;
	Fri, 22 Aug 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2FioDPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B58311591;
	Fri, 22 Aug 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873599; cv=none; b=TnuigTf+yxNG1PSBSOPA4Zb0f6zE3rnGE214+tNe/JY8+zjH1XNkB5/WJvnct2nRKiOqqI3g6doxIsPqrwwoa14QfXefN52oEUe1aSZiMQhU3y06fHKZU+bjebke1OxXJ3ESfTQJ664G7UFCwKGsIUXeRYg0AhmIeDghjn79xE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873599; c=relaxed/simple;
	bh=D8w/1DhgLLeYIgP/I5clMaOgv2UguW2Fv9bG90Ap+qU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lddmVQX/FJGmr2anj4nIKpEvAlUy+Ej7hWcbQSb00Tf1E7/WPpW1NpDDpCdel1aBLbWAVabETqNULIjuGbm2hIRE9Oj2pwd5tsoA0CgPDG36kRarx8+58osdpP+AO1xOBzqzn380serMuX10IOPUx17k9Na1L0Z608FIEfSm1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2FioDPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FADC4CEED;
	Fri, 22 Aug 2025 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873599;
	bh=D8w/1DhgLLeYIgP/I5clMaOgv2UguW2Fv9bG90Ap+qU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f2FioDPuzS5gk7KD7L9NxC1q3R21t2UM50FcPOFojv+IRd0/PKw3+ysC/2kiL+Lfu
	 YWXpMSTMCZ09qvfG41iBuDZZ03SwCPWcjj8UUaLfQyL30rlXXiRED6Sp8l1ez6Zl0s
	 inBSH3J7/4x4pJAwYBf0uCqt4HKymeCvWBrLWR8PkI8ZpTRD241hOh9rYulDehxg6V
	 Kx+fqBtRpNgo0v3sIYnc/kFxxc7OVOCZdCPs8tOdk+6OJUkmZRBJqL8w1ifCRlHxjp
	 msbNy/8ne9YuDFkXygZ5HbH8PIZbzAGPGTZyFiWTIx/5mvi6PBMWcWRDxL9VGR3LDV
	 7nWHJ54CzcaGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 30BE2383BF6A;
	Fri, 22 Aug 2025 14:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_event: Disconnect device when BIG sync
 is lost
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175587360799.1857936.12788969137412778225.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 14:40:07 +0000
References: <20250820-bis_dev_disconnect-v2-1-a0e1436690e2@amlogic.com>
In-Reply-To: <20250820-bis_dev_disconnect-v2-1-a0e1436690e2@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Aug 2025 10:16:17 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> When a BIG sync is lost, the device should be set to "disconnected".
> This ensures symmetry with the ISO path setup, where the device is
> marked as "connected" once the path is established. Without this
> change, the device state remains inconsistent and may lead to a
> memory leak.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: Disconnect device when BIG sync is lost
    https://git.kernel.org/bluetooth/bluetooth-next/c/0dbbf48d4b4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



