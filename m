Return-Path: <linux-kernel+bounces-867284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF90C021A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CF01A67030
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E0339B33;
	Thu, 23 Oct 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ftyvr8Pd"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D4339706
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233284; cv=none; b=OqLgAqcKAFbHoVwOd2qVtt6yaqf1OqWH8dkCACluPh0VcouiVAjT/wrBw+/2aGK0kVkRvC5YeRjXgPXZZ0DoYu7unVcPBZlteO3KQnX8HcdMvZdfFroYndUh2Qt7RjDWO+rNlhQsM6kumo4SAQg1T8qJxcScq3Ob8Sa2OstQsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233284; c=relaxed/simple;
	bh=pZu1ShAn0nVANuV4TK7/J6fNkyMWyOE6PrFX2appC/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUB0z/u3Cq2/y07cslNcXOKQ+xf2jdmc/RzArCHjKhn/Mv7MVXqtMPnlCBtuYlnweUOZ9anKvYHW5Oa/TxKhTeb751WvygmLBzmZitGJo2FvBS9zXKh/Z2qp4GrcWmcHAxip6UgMWXUwHjIAOtZImk0xxhQfBX3fJgwRbwU8JcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ftyvr8Pd; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4csqfk5fYHz9smZ;
	Thu, 23 Oct 2025 17:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761233279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaTVtJ4OrJzYKggTYWIJ1AL/0/t292AjyM4TtlZT+cM=;
	b=Ftyvr8PdNZPcW37381mPmDju2UQ0q/6HFsKMzF0ry/wHjLtBkTq5T7DYF9AhnxRW4UCHM7
	R6MAC+w/0U33kwfH9embjLBMJY+l9DOAj0cDIkx6OVnXi1p+ehvg+bPsEpZVm7BfDCx09+
	3IAgnZi+ZncU7457fm9WS03PX1uML51xpIeYS7KJZvRIQ9DvIODkho7spdjCghkL8TotNv
	27fJbVWl8ey95DHMQEQRWzHDvOgm6qmVKvtW+FjjTK6QjF4/h82/RZyNyP0x7uNEtqWeOo
	lEt3feRl7aDA2uTF+wAkQHurbWDLxDwzmUyLj7B1jCgQm/9+TuiGOaErxrYu/Q==
Message-ID: <5d042f21-274e-4b69-849a-3342d77942eb@mailbox.org>
Date: Thu, 23 Oct 2025 17:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting
 and Ethernet
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
References: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
 <3381308.aeNJFYEL58@steina-w>
 <e6b282cf-e9de-43b7-a8d4-30e67cefe430@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e6b282cf-e9de-43b7-a8d4-30e67cefe430@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fcjaid5riwda4hyq9u9xigyobbg4aqdu
X-MBO-RS-ID: 0cdc8df6d33fff8a636

On 10/23/25 5:22 PM, Krzysztof Kozlowski wrote:
> On 23/10/2025 16:03, Alexander Stein wrote:
>> Hi,
>>
>> Am Donnerstag, 23. Oktober 2025, 14:19:15 CEST schrieb João Paulo Gonçalves:
>>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>
>>> Enable the necessary missing configs for the i.MX95 to boot and also
>>> have Ethernet working:
>>>
>>> * CONFIG_NXP_ENETC4 for the network controller driver
>>> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
>>> * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver
>>> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller
>>>
>>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>> ---
>>>   arch/arm64/configs/defconfig | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..787d3ae3f5afeac486a905e0943e7b0e1dcee3a9 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -354,8 +354,10 @@ CONFIG_FSL_FMAN=y
>>>   CONFIG_FSL_DPAA_ETH=y
>>>   CONFIG_FSL_DPAA2_ETH=y
>>>   CONFIG_FSL_ENETC=y
>>> +CONFIG_NXP_ENETC4=m
>>>   CONFIG_FSL_ENETC_VF=y
>>>   CONFIG_FSL_ENETC_QOS=y
>>> +CONFIG_NXP_NETC_BLK_CTRL=m
>>
>> Are you sure this should be module? Shouldn't NFS boot be supported by
>> default? I might be wring here though.
> 
> 
> NFS root is supported already with this being module. Yes, it must be a
> module, cannot be built in.
It seems I am using it as built-in on MX95 Verdin (patch is posted on 
the ML), and yes, I do boot from NFS root without any initrd/initramfs. 
It has to be built-in for that use case to work.

