Return-Path: <linux-kernel+bounces-776113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E0B2C8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E9E528652
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236EB286D79;
	Tue, 19 Aug 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewgO2ztM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA72868AD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618657; cv=none; b=jx9wUsvqGVUCVe18cuT0DcIHzvHEkF0nOJ3J+wQAvH2sw2f8xtn+tselzQptVZOBbfbboQZqxycXgFWY2Fxe9W+LiAadYZ375I13SHT0mLzZIwRm55yzG1ix0+7UDrjKTEyPyJ/IN4JuId8qs3TKhStrBlOkUWFIT5e01QqwVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618657; c=relaxed/simple;
	bh=EN12J6DbyV4sKao0k/wWO0Ij0Z0A4t3D9eRUSLtSn7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TiFu5nodvVADsR8H6hUAziSo9aTN9x5FpLiP62tlH18b5HcnBuhOoB/eayJilO3VjWdtnJDt6oOcmR88CNfSc+BTvPUC5YdZhMPhmxYWpGTkhltlxl5CwqNJ6RGVLGCPySQoXvJz97Nax56wVRXCa1fCpBMlwSW244uXvaNCwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewgO2ztM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB6CC4CEF4;
	Tue, 19 Aug 2025 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618656;
	bh=EN12J6DbyV4sKao0k/wWO0Ij0Z0A4t3D9eRUSLtSn7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ewgO2ztMYDiTlc55qlipJRhorXn7jgfGCTiE1RipVHrEWsGWt2TRB4M4HdzK1HAYP
	 hVzskfwdFKBMcMLjECCBGDMYvPw429zElKN1Rb44J5GWHZde1sNw+6cyg2PzQ4lyS8
	 8C8xn56LHXa/F3+ocZmJZNQ41DpWWGpaAoCoa5fNI7s9DM4lr9AMMI/N5xmcKO+FC1
	 JTgiXukjMsx3jT5av5nK3eBpVVjW4w6lA0Y+w8B3uWoFXTEavyTfBdesNBSAS72r8F
	 D2wjfZ0na9XX1oSx9pLNkSO9yIdd1+y5qRLKrfiMQYVZyguhYiOvPlQ9VwhKP7fc+o
	 tmfbriAc8uWMw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>, 
 Peng Fan <peng.fan@nxp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250815-pca9450-v1-1-7748e362dc97@nxp.com>
References: <20250815-pca9450-v1-1-7748e362dc97@nxp.com>
Subject: Re: [PATCH] regulator: pca9450: Use devm_register_sys_off_handler
Message-Id: <175561865504.183354.10100694727990904311.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 16:50:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 15 Aug 2025 12:52:09 +0800, Peng Fan wrote:
> With module test, there is error dump:
> ------------[ cut here ]------------
>   notifier callback pca9450_i2c_restart_handler already registered
>   WARNING: kernel/notifier.c:23 at notifier_chain_register+0x5c/0x88,
>   CPU#0: kworker/u16:3/50
>   Call trace:
>   notifier_chain_register+0x5c/0x88 (P)
>   atomic_notifier_chain_register+0x30/0x58
>   register_restart_handler+0x1c/0x28
>   pca9450_i2c_probe+0x418/0x538
>   i2c_device_probe+0x220/0x3d0
>   really_probe+0x114/0x410
>   __driver_probe_device+0xa0/0x150
>   driver_probe_device+0x40/0x114
>   __device_attach_driver+0xd4/0x12c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Use devm_register_sys_off_handler
      commit: 447be50598c05499f7ccc2b1f6ddb3da30f8099a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


