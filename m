Return-Path: <linux-kernel+bounces-867321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5337C02416
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E4314EB270
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263C24DD1F;
	Thu, 23 Oct 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tpKreE2p"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FCE24DCE6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234794; cv=none; b=nymfLywbx8DiN7/kojfGq7Gy+AoFDvvk/NhShn9V4cwdvfiW7gLML72mx4izgSdAsY4HmyrS1wok0qdQWKzUlpGpXUVl+vhNy7k4SpitAoFsbJ1CChYFTBeWhTApwoS1ithf/rmnzoUnokyoTpvvG3xWZF8wOixRScahfhgEwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234794; c=relaxed/simple;
	bh=ozAThHz6HQthUou8RUOhZ/yMsM4/CbbJ0fmf3s8ExDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyVNmXCk1HV9InDesRS2Epoktcl97S+QRxkStJskOUs4ATPgOK38u2PoB77dq0nXfbblrqg3JMRkFHSsgiAG8r+rsL42lNaauoGYoTlOKfdW7X40+7h4MKkGBcuNbC7rCCLsFN6kwVNbC95kElwVAwvP9S3lP7g6gY7cZMMhqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tpKreE2p; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4csrCn2M3qz9tmt;
	Thu, 23 Oct 2025 17:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761234789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0atqt29j38GuBRhYc4ja9297alyKMui/08oB1QhWzH4=;
	b=tpKreE2pk3d1abCk9xBoUhAx3KcBuCEPhou7RMeHsY/gCziF+it/Zxb6HpWx7oLMicm334
	qZj9V/ejXxjLEc+pMCgP5hk25Mp/fCZWuo8vIhfhSMfXDDa0Q2IqhlfQJ/nlkADMUQcP84
	7/rAYUikJXdfXgtm+Tc1wN56vXixDqGzN3awO56vPe3kSChNjr/bXu7Z7mSgAI+SDENVvn
	c3Gez2TZ+90utkr9tghsVhaWl26HkLsvZdE7HbMO12oH1e5tMrQT192zJ8DIrUomssNAjg
	A8DOO2TAyqNrF+yiguUir6FYHFzZ2A6CunZnPMSn5a2L02yLwS4iXhuzMvbbnA==
Message-ID: <07aba8d4-533d-40f7-bcd3-548704d7d228@mailbox.org>
Date: Thu, 23 Oct 2025 17:53:06 +0200
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
 Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
References: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
 <3381308.aeNJFYEL58@steina-w>
 <e6b282cf-e9de-43b7-a8d4-30e67cefe430@linaro.org>
 <5d042f21-274e-4b69-849a-3342d77942eb@mailbox.org>
 <00555ed7-1aee-459a-ae60-0242809d7b85@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <00555ed7-1aee-459a-ae60-0242809d7b85@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jdqggkk454ujny9h4p815r9kkre67smq
X-MBO-RS-ID: fa5d91469f820ba399c

On 10/23/25 5:32 PM, Krzysztof Kozlowski wrote:
> On 23/10/2025 17:27, Marek Vasut wrote:
>> On 10/23/25 5:22 PM, Krzysztof Kozlowski wrote:
>>> On 23/10/2025 16:03, Alexander Stein wrote:
>>>> Hi,
>>>>
>>>> Am Donnerstag, 23. Oktober 2025, 14:19:15 CEST schrieb João Paulo Gonçalves:
>>>>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>>
>>>>> Enable the necessary missing configs for the i.MX95 to boot and also
>>>>> have Ethernet working:
>>>>>
>>>>> * CONFIG_NXP_ENETC4 for the network controller driver
>>>>> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
>>>>> * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver
>>>>> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller
>>>>>
>>>>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>> ---
>>>>>    arch/arm64/configs/defconfig | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..787d3ae3f5afeac486a905e0943e7b0e1dcee3a9 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -354,8 +354,10 @@ CONFIG_FSL_FMAN=y
>>>>>    CONFIG_FSL_DPAA_ETH=y
>>>>>    CONFIG_FSL_DPAA2_ETH=y
>>>>>    CONFIG_FSL_ENETC=y
>>>>> +CONFIG_NXP_ENETC4=m
>>>>>    CONFIG_FSL_ENETC_VF=y
>>>>>    CONFIG_FSL_ENETC_QOS=y
>>>>> +CONFIG_NXP_NETC_BLK_CTRL=m
>>>>
>>>> Are you sure this should be module? Shouldn't NFS boot be supported by
>>>> default? I might be wring here though.
>>>
>>>
>>> NFS root is supported already with this being module. Yes, it must be a
>>> module, cannot be built in.
>> It seems I am using it as built-in on MX95 Verdin (patch is posted on
>> the ML), and yes, I do boot from NFS root without any initrd/initramfs.
>> It has to be built-in for that use case to work.
> 
> 
> Every arm64 platform is supposed to use initramfs and we already use all
> over the place.

Shouldn't the platform also be at least bootable with the defconfig ? If 
yes, then initramfs is a mandatory requirement for a NFS root boot (not 
a ... supposed to ... optional one), which does not seem to be the case 
until now.

I would argue the ethernet MAC support should be built-in to achieve 
maximum utility with the defconfig.

