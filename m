Return-Path: <linux-kernel+bounces-585766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77169A7973D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB917163E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D71F3BAF;
	Wed,  2 Apr 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6L2XnSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5B1F12FC;
	Wed,  2 Apr 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628196; cv=none; b=VOCg+pLqc6zKg6zD8cI50IQrXw2u+qDlAt/9zxjcq4VwbHDMxMsr5refHso7NpVJ4WTa6bRTZkvk4ucaPIczfgb+MM5qX/rO7zLfCUoF+DlTpkUUEKEyUyO30bQSo3lgZsv7U4k0X0wM4p3QLul9O9qEzRVx95bXrcUG3XdKYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628196; c=relaxed/simple;
	bh=XA1GnVPZ9o8FT5WId4vucT14twjD0XBRsAIYlvmm8dI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ihLq0QqYyReQnb9/Js+4UweSM4Q7WGwK2AQcJJHPWLI/w/sE1aaZmDNJ+tuBTVktmY3sFulDZYDPUyvRZ22Dunj1Y4u5AW9k9RZLpZfwUPNLmP9Ms4VuuSjz8uYauozXp0wYJbwUTZkKEQrxEtk/D9aNTNP3jR08JC6+ogg5NSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6L2XnSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA45DC4CEDD;
	Wed,  2 Apr 2025 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743628195;
	bh=XA1GnVPZ9o8FT5WId4vucT14twjD0XBRsAIYlvmm8dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X6L2XnSGX6Tui5WFlSV2+4mGSFraOHaiBUnnU167WYzx89wZAyuyFjRgGkhL8W2c4
	 /j9Yw7mYVI77jxZx74ztNL1TPC4rydpbWVsOmMWtas43ovtfjOZbRox3IbAYOURlG9
	 aLoD40CjTPPlMrM75E9nPokbm2N6cb9xZ50ltPd2RNHgiaasOUlwS16JQ8PYbrA41I
	 XX6IIIOqOdycotmncGepwb/rS5flURPmRycI134cwqmM1kPcE4FfAlo6y5kdBFTMa5
	 X/VlzpWWEUr7htKwFIdF6adbtB3Kmr3+CrxhcFK5EMX0HCNGEq62VDiWHqvcSNijTk
	 3WY9A60pDhyPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE01380665A;
	Wed,  2 Apr 2025 21:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: fix NV variant for one of WCN3950 SoCs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174362823277.1678044.5851216887579937470.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 21:10:32 +0000
References: <20250401-fix-rb1-bt-v1-1-0d140c583a06@oss.qualcomm.com>
In-Reply-To: <20250401-fix-rb1-bt-v1-1-0d140c583a06@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, lumag@kernel.org,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, wsl@trackunit.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 01 Apr 2025 18:04:03 +0300 you wrote:
> The QCA_WCN3950_SOC_ID_S should be using qca/cmnv13s.bin, rather than
> qca/cmnv13u.bin file. Correct the variant suffix to be used for this SoC
> ID.
> 
> Fixes: 3b0e0839d9f2 ("Bluetooth: qca: add WCN3950 support")
> Reported-by: Wojciech Slenska <wsl@trackunit.com>
> Closes: https://github.com/qualcomm-linux/meta-qcom/pull/817#discussion_r2022866431
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: fix NV variant for one of WCN3950 SoCs
    https://git.kernel.org/bluetooth/bluetooth-next/c/87d48ed16c9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



