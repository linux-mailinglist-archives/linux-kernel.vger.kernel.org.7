Return-Path: <linux-kernel+bounces-838668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD91BAFE12
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B5B1C7556
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781702D979D;
	Wed,  1 Oct 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b="fUaBeeAH"
Received: from 4.mo548.mail-out.ovh.net (4.mo548.mail-out.ovh.net [188.165.42.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208562D978B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.42.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311370; cv=none; b=jw2scQWo0pwgwBz3IfcWI5cbdEnPJkfThT0RPn6EiOUUbufLxTFUUtbmfCI5x2uRBVTqOnWgEBk9Ue+dEwqB5JzhfCcCs+WeiwXI5qlQFJoA7h7473xm2FUffZTOZIziq43vkXdhPWCEWe4Jktg29+v05F+bOawwNQgW+JCOAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311370; c=relaxed/simple;
	bh=ZlooDmtZiUTkC/0YPFTkC8CkS5N1i8PGe7PkSLwTf9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TqStr7gUwhcc5RUyengugxaqdU4/8SEhwxvexqTUZPVaMiUSOg7F/CS1KQyNWSIbG7EQD2ipBG4/vK20UH7zrYwPgyGiNQgRCTUsn/n4wH/5GFFBZaEdloi1v+lFHMqB+SjQz8KfnCLY34huQvX5sNEBwKLLTFdVhZomMmYtGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=kaod.org; dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b=fUaBeeAH; arc=none smtp.client-ip=188.165.42.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaod.org
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.73])
	by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cc8tl1TK0z6VT1;
	Wed,  1 Oct 2025 09:35:59 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 1 Oct
 2025 11:35:58 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-101G004de14898d-4384-48f9-b123-7ae4092cda50,
                    D9D4E9C7278927B1F3584C3B5B4DCE3027F8E762) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <67e40a87-40e0-466e-877e-efac28ce5b75@kaod.org>
Date: Wed, 1 Oct 2025 11:35:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
To: Pratyush Yadav <pratyush@kernel.org>, Guenter Roeck <linux@roeck-us.net>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, Cheng Ming Lin
	<chengminglin@mxic.com.tw>, Cheng Ming Lin <linchengming884@gmail.com>,
	<mwalle@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <alvinzhou@mxic.com.tw>, <leoyu@mxic.com.tw>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <20250407075400.1113177-1-linchengming884@gmail.com>
 <20250407075400.1113177-2-linchengming884@gmail.com>
 <d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
 <mafs05xh6pf7s.fsf@kernel.org>
 <da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
 <a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net>
 <aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
 <ff485da8-1a02-40a9-9286-94459e52b26c@roeck-us.net>
 <mafs01prbvbjm.fsf@kernel.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <mafs01prbvbjm.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 4db64a8b-ac4c-4c98-9cb3-697aaa65b04d
X-Ovh-Tracer-Id: 17725886659947039550
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGHYjw70Je/q4in0RDfaFuFDlSoG0XRb5XZHSS187Cl0iGyIpcnLlgSkwO9UIczNEmU4pM9QaeP51JQUg/A+ogk3l/Rm5N3PiIKpk6SWzTosQVqmCeZ+ZzsNEn3sX1Gpx42izDSikKbioeFwWEa4PBlHGMgxpSDai/o3JjK46/4FlzTkydwF+uYqx7sU3w9wEpnf9KLkhXf2QGfo8KDyBDfAm19ZHbqpAoXiiNRmu3JBSRt3JeAv2TNBMAeQVt9ymSggE4NeX413UYOH0LAj55SWw5ySxeE1Ey5n1yDHdDKb5dLu+tTZWRFAr91FYxNf7pgAUTFdGQafZYRIwQXMjqviImj7QCbqZumPW7hzT4CY7FLOMOvWg/PAnxz6SrZDgRsHTycG33gsltxXTVYU7XpD4SlpIHAwR/aJwzV6nS4vFyeWHUxiANmOZ0OmLZB/+S2hb9OcAZo0ABR8xh+r6I82Pma/wIwjaYCHhVB31CGcyD8fgJoLf89WK4RVrGYa5CJikd9cTjzGZEESLUOd9oSTGnW7sSuCtV4+vEm10c7Lx8PG/VsZorIPT76X3sf2zWP1/vYcISynttbisJ9cIdALq7E5SUGsxKrHKr9XaTBX5nJCcL5biC4MUv+RHt/BXUnOVLkjkMvDtJLZuUZNTlxCWnqx42I7E8PRIL+EPuPaw
DKIM-Signature: a=rsa-sha256; bh=mCYvBDY4Ggt0s6fhPh745Fmpj2gWSEbSOSHtBjOApzc=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759311361; v=1;
 b=fUaBeeAH/s19hOaMl2x+pKE+l4fTvuRnyI3RQIJ9mza1HBqZ7tdX9TaBIXEfTj6sFMK1Yp9S
 gUa58E6QfKdqd3m3wUqIa+vOJlcFFLMggwBgSHPeKvgKVYdfnDAO9f7H/bV/H1fdFDytVsz+tHl
 axq6VlRUWG/f2A7Fmq6LO2KpALZ6Dx0bVDNhkpbUDXU6Jtbbeo+JnzrVUXQB2cBXleHJkW1gW8Y
 R6eL03Pn5G8i8HDmW4XPGyk5CVbrkBKNCwE3whfbYECeyAgKK+DD89bAKsfpxOJyDImHvNF3UjY
 Wn5Kt62B0T2HgTM7rPzaciAo1xOpCPFwrwZTGPcDjvwlA==

Hi,

On 6/22/25 21:09, Pratyush Yadav wrote:
> Hi Guenter,
> 
> On Tue, Jun 10 2025, Guenter Roeck wrote:
> 
>> On 6/9/25 23:46, Tudor Ambarus wrote:
>>> On 6/10/25 1:14 AM, Guenter Roeck wrote:
>>>> On 6/8/25 18:13, Guenter Roeck wrote:
>>>>> On 6/8/25 05:53, Pratyush Yadav wrote:
>>>>>> On Sat, Jun 07 2025, Guenter Roeck wrote:
> [...]
>>>>>>> With this patch in place, some of my qemu tests no longer recognize the
>>>>>>> flash chips (MX25L25635E/F). Do you have a suggestion on how to handle
>>>>>>> this other than avoiding Macronix flash chips when working with qemu ?
>>>>>>
>>>>>> Could you share some logs? Does the flash fail to detect, or does the
>>>>>> SFDP-based probing fail? Since this is qemu, it would be even better if
>>>>>> you can share a setup/reproduction guide. I have been meaning to set up
>>>>>> qemu for SPI NOR testing for some time now, but never got around to
>>>>>> figuring it out.
>>>>>>
>>>>>
>>>>> I suspect that the SFDP data for the affected flashes is incorrect in
>>>>> qemu.
>>>>> Since this is very likely a qemu problem, I'll just configure
>>>>> different flash
>>>>> chips when running affected tests.
>>>>>
> [...]
>>
>> Some debugging shows two problems with qemu: The returned SFPD data for one
>> of the flashes is wrong and does not reflect the data qemu is supposed
>> to provide, and qemu does not provide SFPD data for all flashes.
>>
>> I don't know if the bad data is due to a bad Linux driver (unlikely), a bug
>> in qemu's SPI emulation code, or a bug in qemu's flash emulation code.
>> Unfortunately I don't really have time to track this down further.
> 
> I used the command you posted in [0] and tried to reproduce the bug, but
> for me the flash probes just fine:
> 
>      root@romulus:/sys/bus/spi/devices/spi0.0/spi-nor# cat manufacturer
>      macronix
>      root@romulus:/sys/bus/spi/devices/spi0.0/spi-nor# cat jedec_id
>      c22019
>      root@romulus:/sys/bus/spi/devices/spi0.0/spi-nor# uname -a
>      Linux romulus 6.16.0-rc2-00308-gf7301f856d35-dirty #5 SMP Sat Jun 21 19:29:15 CEST 2025 armv6l GNU/Linux
> 
> The rootfs is also mounted on a mtdblock device backed by this flash,
> and everything appears to work fine.
> 
> Which version of qemu are you using? I can see that SFDP data for
> mx25l25635e was added to qemu in commit dc907a667c ("m25p80: Add the
> mx25l25635e SFPD table"), which was released in v7.2.0. Older versions
> of qemu might run into trouble with this flash if SFDP data is not
> available.
> 
> FWIW, my qemu version:
> 
>      $ qemu-system-arm --version
>      QEMU emulator version 10.0.0
>      Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
> 
> [0] https://lore.kernel.org/linux-mtd/da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net/
> 

Some comments on why the mx25l25635e and mx25l25635f flash devices
were introduced in QEMU.

These do represent real HW flash devices with the same JEDEC ID and
different SFDP tables. We discovered that the hard way when doing
bringup of the OpenPOWER servers, some flash devices had 4B opcodes
support, some didn't and it confused pretty badly firmware. IIRC,
we bricked a few BMCs long the way. Hence, the work we did in QEMU to
improve support.


This is not particularly old by Linux standards, less than a decade,
and there may is still be hardware in the field using these devices.
How well they are maintain is difficult to say but I wouldn't risk
bricking them though.

I hope this gives some background.


If you need more info on how to run QEMU for these machines, please
look at the aspeed functional tests :

   https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional/arm?ref_type=heads

and/or contact us on the QEMU devel mailing list.

Thanks,

C.


