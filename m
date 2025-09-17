Return-Path: <linux-kernel+bounces-820588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDEB7C5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE361894D41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3F371E9A;
	Wed, 17 Sep 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A77T/z21"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCF1E32B9;
	Wed, 17 Sep 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110041; cv=none; b=MUUkFLRKUx2ezAgbh3Cks2Yb7kqTt3Qan4geUCvXvev0p7/ORWNqPd8R2l5VcrSbwmDQMeNolnlxjzGLxTZ+/8nOuEdcw3yA9H/uU6+Mewj241WMlin3YRkfKXpxzAc2vOISnGdbwA83DNINV2zVxm+5iHRI+DZvjjHS1CqxIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110041; c=relaxed/simple;
	bh=gi4OziqmeqkoXsQcp7NMfSD4b7MAu5D/AiyhtslgU+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW2eESo//vHPufPFFBhI6d08VTM3PFDf+FDDo/ATPuD73EoDqBxpWPVwLZ1aCNc6p3Ik4diBETA4EJXeFufXmiKaWv6byNjSUU/mORP1+eUU2ZYvaTHTxfOixvXjtqQ1XTgRaSmFz9+leV639E2MVvoYA6J/LEX1ancx3vGhGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A77T/z21; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758110038;
	bh=gi4OziqmeqkoXsQcp7NMfSD4b7MAu5D/AiyhtslgU+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A77T/z21aH402bY6G6mCyLiy0Mc5p8WVI0s1d3ShvSei79Fh+v5o9xgdhp+tTQCP7
	 pUW22EagPett90K0MFdM+hQ2ldlUMaI33pKF2BQrD1zVbRFNU/JSd5vhka8Kd2+RTy
	 erxlmd4nN9xe3Yone+fjYsgcbt+SBmNQ7A+5aMQndk0ee/vjjsR2/2Z8s7bkEAWmMp
	 6gXv0y4xJ2HyWPkoL0hyMmS2YXFtOBTw87+NAeAr0wPxtJF+S/p/j6P8e7YpIYsWos
	 SfG4hoVADGpYhLIEys0UZQQufiROflCStuTDwKfnLyFN5Gar6x0fZJ71KlokRQU8if
	 iSh0YeSp9uphQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B1FC217E0A49;
	Wed, 17 Sep 2025 13:53:57 +0200 (CEST)
Message-ID: <9d895847-9dd8-45e4-bc3f-a27e80371836@collabora.com>
Date: Wed, 17 Sep 2025 13:53:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt7622: add 'serial' cell to
 efuse
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <18af6977cc34de75e64279141dee69dcbc81c420.1758063737.git.daniel@makrotopia.org>
 <87179c9f-cc7f-446f-9e8d-c84bddb48660@collabora.com>
 <aMqImGmz0uf_aTUR@pidgin.makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aMqImGmz0uf_aTUR@pidgin.makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 12:08, Daniel Golle ha scritto:
> On Wed, Sep 17, 2025 at 11:06:13AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 17/09/25 01:05, Daniel Golle ha scritto:
>>> The efuse of the MediaTek MT7622 contains an 8-byte unique identifier.
>>> Add a 'serial' cell covering those 8 bytes to the nvmem defininition of
>>> the efuse to allow easy access from userspace, eg. to generate a
>>> persistent random MAC address on boards like the BananaPi R64 which
>>> doesn't have any factory-assigned addresses.
>>
>> Sorry, but I don't get why this is named "serial" and not "soc-uuid".
>>
>> Care to explain?
> 
> I don't have documentation covering the efuse content but only got this
> information on an informal way:
> 
> https://forum.banana-pi.org/t/bpi-r3-serial-number/14556/10?u=dangowrt
> 
> Either name is fine with me, I thought of it as "serial number", but
> obviously "soc-uuid" works fine, too.
> I can change it to that and send v2 tonight.
> 

Aaaaaah that's why "serial", okay - I got confused because the eFuses contain
many "calibration data" entries, and that triggered me to think that it could
be a "serial calibration data" entry.

After reading the commit description it became very clear that the initial
impression was wrong, but then still, when reading the devicetree without having
the description of the commit introducing that, it's easy to get confused again.

In any case, well, it could be a serial number, or it could be a randomly generated
UUID - but since we don't know, I think that calling this "serial-no" may actually
be wrong anyway.

We can escape this uncertainty though: a serial number is supposed to be unique,
and it is used as an identifier (which identifies one, or multiple aspects, either
an increasing number for chip number, or one that says the production date and
chip number).

Seeing it like this, calling it "soc-uuid" identifies this array as containing a
number that uniquely identifies the chip, be it a serial number or a randomly
generated number.

In case you find out sure information that this is really a serial number (which
doesn't really look right, it's too many bytes, but you never know) you can always
come back later and add a comment in DT saying that it is just.. that.

For now, let's go with soc-uuid :-)

So please, change the name to soc-uuid on all four commits, after which, feel
free to add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

to all four commits.

Cheers,
Angelo

