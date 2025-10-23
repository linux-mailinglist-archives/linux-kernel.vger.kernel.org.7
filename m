Return-Path: <linux-kernel+bounces-866634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF463C004D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A612A4E92CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F33090C9;
	Thu, 23 Oct 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4D2XouK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32D2D2498;
	Thu, 23 Oct 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212426; cv=none; b=IATSCZGbl1bi0ABHbWmx8UDmJCoGVMHKTN1GyULBXbm5qJHt2/jZhOiVfI3Chtyx6DM2teFnIJa5EmxcQ2utdEzDzotBExBWIfv6N3D3WGm7k+Wwufg/Xv6/Az2KSCTrT6FxfrTQtXZ6YE0ZLCZslhYAHqwGm0uoYPEsYKc56kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212426; c=relaxed/simple;
	bh=nJOnAXX5sRVFOgviHjMHBI/zr4WV3fKNmsk5kSsFjtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V7AjiZCmAj5Lz+cEejFB5gPiZzOJ8Qip/E5HjBn/S1H8ILVJGwlmAnogr196dGtI3WD6dKEdbBeqhjqjMQdfmHD8ZA/A0ttVsTiYElqFfGvancGsoR1xEQSg5Va5uApp/FW6ACa63vyUuuKHCqQxLxeNYeQl256ssFMkNDuOMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4D2XouK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF390C4AF09;
	Thu, 23 Oct 2025 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761212425;
	bh=nJOnAXX5sRVFOgviHjMHBI/zr4WV3fKNmsk5kSsFjtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T4D2XouKlTdAaJXNLAB2DTxUcIAy1Cxw740vuAlenlseHGSG1GHpyuA+vpYtNq05o
	 QOIhWRRvk49Gizl2n1iwQYmVDql5KMYNRpwDkiOAk0XB+5PaMZCh6gixKFX41f1b3x
	 eODq72LXUIWDoN7rWi4S2N4WY9yhhfISiOR2iFbkUOjbJxzHX/iLBOBRJlp4AFjhLN
	 eZ3JLdLA8Nblb5Gsu7RPUWIrbatsgEzzq29Ye55KOTu90oJ4zjnpgtyDvUZ0t92T0c
	 o3Zh0M1mEbbPoW3PcdwzEKINGFwUzeq2gR/vbowKuEcS3VmNbT8y+Kg2IfsNCbIMK4
	 xPAtuVQwubTwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D063809A2D;
	Thu, 23 Oct 2025 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Omit a variable
 reassignment
 in prueth_netdev_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176121240626.2969431.4409960503973897261.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 09:40:06 +0000
References: <71f7daa3-d4f4-4753-aae8-67040fc8297d@web.de>
In-Reply-To: <71f7daa3-d4f4-4753-aae8-67040fc8297d@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andrew+netdev@lunn.ch, byungchul@sk.com, davem@davemloft.net,
 diogo.ivo@siemens.com, edumazet@google.com, grygorii.strashko@ti.com,
 h-mittal1@ti.com, kuba@kernel.org, jan.kiszka@siemens.com,
 krzysztof.kozlowski@linaro.org, danishanwar@ti.com, m-malladi@ti.com,
 pabeni@redhat.com, r-gunasekaran@ti.com, rogerq@kernel.org, horms@kernel.org,
 vigneshr@ti.com, linux-kernel@vger.kernel.org, linux.amoon@gmail.com,
 christophe.jaillet@wanadoo.fr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Oct 2025 16:02:56 +0200 you wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 15:46:11 +0200
> 
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete two redundant variable reassignments.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ti: icssg-prueth: Omit a variable reassignment in prueth_netdev_init()
    https://git.kernel.org/netdev/net-next/c/e0665df8c501

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



