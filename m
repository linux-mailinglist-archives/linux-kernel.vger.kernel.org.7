Return-Path: <linux-kernel+bounces-606004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9713A8A92B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 22:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0876D443CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC798255259;
	Tue, 15 Apr 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuqIeJ1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E62550D5;
	Tue, 15 Apr 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748405; cv=none; b=FGGO02ekSJQXNyJ0lfM8didTQBV6TxE3Uo6/2Kp335T0qrtL+ueO6ol3cCMFTTrfVN6HPmZQ4P2bFTTntfU+Kc1OEFyMDJntSoQkTGZ49C5D43VdtwG0xQnVD2+wZMCTd/KVSJUUVSVigQE8KrKGvHydnyhXfgy5fPlnJ+ttQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748405; c=relaxed/simple;
	bh=1JKJ+YF8DTnS/OrSbdUjhbYimCbDafSrXXlmbRcbY0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OCQnRIKlCF7phrD5kXyJMVk9lMiVgMjAci+sZeQxI4h8OMJRWGjH7rl/A8jdP3A+qo03KJ1HZtCyorSMM48Heb4+nuIVTxvIuuBLA1nuujUwQ/KW3oh5LfCEU5/IdBIdEU5kiRGS7zLmJN6PPzWYsWn3MxW/XVwEH6hVGhxFOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuqIeJ1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE412C4CEEB;
	Tue, 15 Apr 2025 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748404;
	bh=1JKJ+YF8DTnS/OrSbdUjhbYimCbDafSrXXlmbRcbY0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JuqIeJ1rcd4N5cndJ7JFXCx0HJZUVj1l87t+rC++1wyTO+IhUiyPjyR1xBZzTSNe/
	 xWwC1vHi2RiyPQ804hfTsOlt6L9Ud+mkeAOPbh988mjmbSzN6TSn91YwA9vyQ6nD12
	 0PMIv61LMSqxg6bwJYqSxwO6pZigMIMuwPw4/epApNX4y4LT625i9qvp0ZSexb7heW
	 xynUmqIZgNgll3bHEAFVFuSdKVhUF6Lyw0dzysYlDn1AM2eS1r5n22im72MQFkycLr
	 Jyw/SaXd+lfXj/TGJC5jin11qHWx0eowS/xMi44E3O2qYhIgiwRVFr0mCnz1/J2dm0
	 0gpaE5Vjc5WKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF83822D55;
	Tue, 15 Apr 2025 20:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174474844274.2765712.14627130286232594097.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 20:20:42 +0000
References: <CC9464EB852D10EC+20250415023350.16083-1-wangyuli@uniontech.com>
In-Reply-To: <CC9464EB852D10EC+20250415023350.16083-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 lihao1@uniontech.com, zhanjun@uniontech.com, niecheng1@uniontech.com,
 guanwentao@uniontech.com, garrett@system76.com, tcrawford@system76.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Apr 2025 10:33:50 +0800 you wrote:
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=b850 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d31c22dbcca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



