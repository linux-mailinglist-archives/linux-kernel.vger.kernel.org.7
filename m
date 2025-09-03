Return-Path: <linux-kernel+bounces-797938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D6B41767
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBA43A67C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5C2E1F03;
	Wed,  3 Sep 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="W/FEEsSf"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E42E1730;
	Wed,  3 Sep 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886250; cv=none; b=n+8LNj8R5ISJuegZFBJLpNpceP3j01cE4BNnH9WxkahIMKf2ljvuNtBnJXNyPDQ2W3idjZVB1hqil2ngSBGTk7xb6KxhOHCekV0Krq5rkkhfiJ5jPT6ELFAx4NLbTYWwwU4wxw1Cx0X3Az0C2kQVTA2JdcwB3RJDL9Z8eu049hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886250; c=relaxed/simple;
	bh=cEx8Nl8pn0SNYahl72ZQZJ8k0RE71ZlKsgtOt/JNegM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jn8u31tYH4Mgy4ea2HzVj78VTLkKzahHyUvT6fUx7v+dGfpxXECRX7iVKVbbFAHrCri1MjDpWFcwziRkz+i7ICxVup95ZAHq8VqXcVPO0URvAGmZ8aI3sRWuNbqe+9340f4G3oDgwck/lLKFC0wVTFeUZJq9J8OdfZHSg6fVIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=W/FEEsSf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AEB01A0AE8;
	Wed,  3 Sep 2025 09:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=G9LuJtlyVxPJhHT/WYbe
	GudzGNgkTAxPFbkh2SdZG50=; b=W/FEEsSfmuCfkCG0oEWET5i9SdjR+Z0hvfnD
	919tOq99XHewP0Qxui/gVeTMGHVF+bAraGIUssL4DjV3wPhiMWjXY6wsd6R3IHJG
	RrWJpi0osuY+ejwE+x128F/NtgLzQH+zwIU9rL7L6ddeLx8swhRjX9OGUBd+kNus
	/Jpy+IXIvZm/72mCZgnQi3IO68KBYNnOusbDZEYp5J0PX0w3JlLG258yJpHITK2e
	4fxm7IlwRESqtaTuTqnjf0VxPxGtMkdV2YgL9KuHoLRlO1CZFkAxLiO8gNpOAre9
	SGH0m+ZLq72p+eOJqA474r5WhVUBkw2RRm4mBSo7sN6JzqTAnss+T1VMT/AFcq6M
	1M9/GwtSaqWxhg+YPw1Kvm2bNF2Infl214GRQCmt0Ywc1csgo9Ucg1e6LUMEW38f
	52c/acGWhU5oNA8/FEGNN0XhlzlaKzVABqO8xJKnTBnaDANfSwNEbGEdaG2MlFmA
	gQGVycQpR7SccNLHkGJtuhc7nqBH+atmeDsa/d6xqtAoRs/mhHP3eb3eKpV7BWCh
	MG3g0giYeSF3brw1etx7ozIrhO5BGshnl0ydzwoiWDSCYR62WYOFHCk1mIqgeacB
	0YcEQglvKToDXPJ7syEfUzPjzBWS6iaQ8A6S4KL7NnHRauOicMemAL5gJ3tooSKJ
	EWvW6/w=
Message-ID: <57518c46-2e92-4689-80a3-ae4c99b9fc32@prolan.hu>
Date: Wed, 3 Sep 2025 09:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>, Csaba Buday
	<buday.csaba@prolan.hu>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
 <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
 <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E637062

Hi,

On 2025. 09. 03. 9:50, Ahmad Fatoum wrote:
> Hi,
> 
> On 03.09.25 09:43, Csókás Bence wrote:
>> Hi,
>>
>> On 2025. 09. 03. 9:28, Ahmad Fatoum wrote:
>>> Hello,
>>>
>>> On 15.08.25 17:17, Bence Csókás wrote:
>>>> The Ethernet PHY's reset GPIO should be specified in the node of the PHY
>>>> itself, instead of the MAC (`fec`). The latter is deprecated, and was an
>>>> i.MX-specific extension, incompatible with the new reset controller
>>>> subsystem.
>>>
>>> One reason to do it this way is that the PHY is in reset when the OS starts
>>> and the external phy-reset-gpios allows MAC probe to get the PHY out of
>>> reset, so it can be probed after reading its vendor/device IDs.
>>>
>>> Does switching to this new binding address this scenario? If so, it should
>>> be noted in the commit message.
>>
>> Yes, but after it has been reset, if the platform supports Power Management, the PHY's clock will be turned off, which some PHYs (in our case the LAN8710) don't tolerate. This has been reported many times, just search LKML for "lan8710 reset".
>>
>> So we want a more general solution [1] where the PHY subsystem resets them before enumerating. However, if the MAC driver claims the GPIO, then it can't be used by the PHY.
> 
> I agree that it makes sense for a PHY reset to be associated with the PHY
> device and controlled by the PHY driver. I am wary of regressions though,
> which is why I wanted the commit message to clearly spell out the implications.

You're right. We'll put this all in the message.

>> I will clarify the commit msg with this in mind.
> 
> Thanks.
> 
>> [1] https://lore.kernel.org/lkml/20250709133222.48802-4-buday.csaba@prolan.hu/
> 
> Is this mainline yet?

Unfortunately, no. It apparently still needs some polish.

Bence


