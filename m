Return-Path: <linux-kernel+bounces-824278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02736B888DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB92E1C865D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923B2F3C32;
	Fri, 19 Sep 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b="feONaI8L"
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8361247291;
	Fri, 19 Sep 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.220.24.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274143; cv=none; b=YbxGxSEsv26uMyzp2BErXLAB5tEz0eDTgRKz08aaELmvydEs9KvF4idS6s9R4aipsyIYdq5NRG6EHbSpPpE/X6Go4FFAAFrr1jcSxnaJ2uIKuSEr2xsfOzXkDLUe52bWYBGqpFAL8ijgkyrZulW+8SfXxSuM+66NobRSb3EAXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274143; c=relaxed/simple;
	bh=/bBCEPU2/0tv/K9YmbIdh5G90E4fXWa6Xx5dfbkFTiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O5BTU2bYcG0x+z3E58zsftHANfM13Mt9osfmOydPLOlbrUL6zSoHQH0AzqMLB9TiCC5BCu9Om0PggxaUhP9i/JFEE3QFZKO0MBhn2S0vyrchwYkd7sg6hpWHfTRUjeAFNlYQX/SRGrglEbytcMDYyMcN5gJ0AKI8y8M+Lx0PRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com; spf=pass smtp.mailfrom=wildgooses.com; dkim=pass (1024-bit key) header.d=wildgooses.com header.i=@wildgooses.com header.b=feONaI8L; arc=none smtp.client-ip=91.220.24.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wildgooses.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wildgooses.com
Received: from [192.168.8.153] (unknown [94.228.36.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ed@wildgooses.com)
	by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4cSnJ75j6rzkd2v;
	Fri, 19 Sep 2025 10:28:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
	s=dkim; t=1758274139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bBCEPU2/0tv/K9YmbIdh5G90E4fXWa6Xx5dfbkFTiY=;
	b=feONaI8Lw64SjaoDRMMiIvlGMwvLCFWYcp5EFABRsaS8yWkOIE3/uxBdPMBw+ds7phhE+u
	ILyaf27i9LOJdFQlkn02/HVKGg25a+4nn6RKmIG0wQIrPnPfw25MmbNo4kesaYOzxNnIlu
	+oIoDq8x2vqMfIeswxMTGhjx06poDfs=
Message-ID: <da24e503-cb43-45e7-99ff-38eab11a203b@wildgooses.com>
Date: Fri, 19 Sep 2025 10:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa
 ZERO3
To: FUKAUMI Naoki <naoki@radxa.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250917114932.25994-1-lists@wildgooses.com>
 <FBB5B30DE8FEABD7+59ee6f48-2ad1-45dd-8cf1-8b58a03513a9@radxa.com>
 <adbc2396-d5f0-4dd6-a65e-0dd78a58b9a4@wildgooses.com>
 <2325560.3ZeAukHxDK@diego>
 <0DB47BC84E90B0E6+694b1274-4826-4ec1-9aa2-ca8aa790f61a@radxa.com>
From: Ed W <lists@wildgooses.com>
Content-Language: en-GB
In-Reply-To: <0DB47BC84E90B0E6+694b1274-4826-4ec1-9aa2-ca8aa790f61a@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19/09/2025 00:57, FUKAUMI Naoki wrote:
> Hi Heiko, Ed,
>
> On 9/19/25 01:18, Heiko St=C3=BCbner wrote:
>> Am Donnerstag, 18. September 2025, 17:23:04 Mitteleurop=C3=A4ische Som=
merzeit schrieb Ed W:
>>> Personally, and I'm saying this as a user who is technical enough to =
fix the definitions, it
>>> took me
>>> quite a few days to figure out what was wrong with the definitions an=
d understand the intricate
>>> tree
>>> of dtsi includes, to finally figure out why I couldn't just do a "sta=
tus =3D "okay";" to enable the
>>> UARTs... (which is roughly what is shown in several radxa supplied ov=
erlays to enable uarts on
>>> various boards)
>>>
>>> So my vote would be to correctly define all the hardware for a given =
board. Then users can
>>> simply do
>>> a status=3D"okay" to enable and off they go.
>>
>> And I'd agree with that argument. Setting up the needed pinctrl settin=
gs
>> for the peripherals described in the device documentation
>> ( https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interf=
ace#gpio-interface )
>>
>> is the sensible thing to do. While keeping the peripherals itself disa=
bled
>> and for the user to decide which peripheral to enable.
>
> I'm not strongly opposed to this policy, but I thought if you're going =
to do this, you should do
> it for everything, not just UARTs.
>
> Best regards,
>
> --=20
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.


I would most definitely be in favour of doing this for all peripherals! Y=
es please!

I have a selection of Zero 3W and E devices here. We are going to potenti=
ally use them in an OEM
capacity, and I might have some I2C devices to plug into them in the futu=
re, and for example would
like to get the I2C working on the pins (is it 2 and 4?). It will be at l=
east some weeks before I
can work on that, but if you want to offer some support to fixup at least=
 that device I won't decline!

Thanks for making these boards

Ed W


