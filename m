Return-Path: <linux-kernel+bounces-874762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CEC170B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB886564A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798442D0634;
	Tue, 28 Oct 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxks5iyN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D7155333;
	Tue, 28 Oct 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687028; cv=none; b=Ba3BX0UaumRduVdDxPSWufCCjJY3PrHpNijT4Qgoo7N8b/Fj59Itqe9ia+jhEzI8efF7QY0XXTC7Xd7OEBE6qgb8wM/rxPbodKrn1r0w8QdzVX8gacEV1K4agRmnd/ea9hNLL7w05/H3PhflvqcCDTV46p33ClnClxmgJ1dX9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687028; c=relaxed/simple;
	bh=0tVt+9QENEkl81X45ztx5JTDdZku9E6SSVoKpz21vik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s9fC0AgJNu3c+8NC0BiX54Aj3gQhK/bz3KNe3LHq9y/MeEfcWjm5nrzR40CELTyhoTBGqVDgulB8ByqV5P8OTZBsxCxxMEKnRPF9SFWk11qhPZ7Di5L63/pPZ8/C283fFAFEhudbpKSmgU4+/5N5uwhXaNSaS7ds3LSenpyNDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxks5iyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A046DC4CEE7;
	Tue, 28 Oct 2025 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687028;
	bh=0tVt+9QENEkl81X45ztx5JTDdZku9E6SSVoKpz21vik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qxks5iyNXT3VXf8Zx/9zCTo3ghNz9vnwpJm+BMdiq81CVLDYuOx8vtQnHQhAKBEXZ
	 7wXAgSagf5oeeFyQ+zn7NugENtBHKcVnizXQvStpnCLHAxxrJhud3A1ApquOYXG2hi
	 E0QN+yQYgnfHxFPNL5M2UMG+FgIjZwpsZsekv3hxdLPafrJxJzekJJCFudF7Gwnawr
	 Z3q0rutLnUNCkCtCULUHnp6uaPzVK0JgOJvAZNP6Wi9C3sHiyDgeyTdUtxAeIj1Z2z
	 /XrDuh18830rm0VLb4HkPIF2xMoVb0lbrg3gDQSVHEzqIb8eOLJoveszLDKHspwHbm
	 7qYN2iW+0ghYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6E39EFBBB;
	Tue, 28 Oct 2025 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btrtl: Add the support for RTL8761CUV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176168700626.2391991.1018861580284993450.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 21:30:06 +0000
References: <20251028062413.252504-1-max.chou@realtek.com>
In-Reply-To: <20251028062413.252504-1-max.chou@realtek.com>
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 hildawu@realtek.com, alex_lu@realsil.com.cn, niall_ni@realsil.com.cn,
 zhu_qing@realsil.com.cn, wangchihhs@realtek.com, brenda.li@ublnx.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Oct 2025 14:24:13 +0800 you wrote:
> Add support for RTL8761CUV BT controller on the USB interface.
> Do not apply IC_MATCH_FL_HCIVER when hci_ver is 0 in the ic_id_table.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=c761 Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Controller
> S:  SerialNumber=10000
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btrtl: Add the support for RTL8761CUV
    https://git.kernel.org/bluetooth/bluetooth-next/c/ab8cafa86951

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



