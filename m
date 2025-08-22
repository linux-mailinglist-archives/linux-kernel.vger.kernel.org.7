Return-Path: <linux-kernel+bounces-781792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3736B316CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347767B23E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71F2F90ED;
	Fri, 22 Aug 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="D05sy7mU"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31E17B402;
	Fri, 22 Aug 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864131; cv=none; b=bIp4w8Z9ot0Bumkgj6i90BDW5+yPderlxJfH24wVLY+6ZWD1hBRf2Nl4VH6YP1myyG1m/kRcIGSYDx3HVZHSd5WwbrCOlJSC6wTQpY055qtizI7vo9XVpmngkz+OhpdUw4Fz6Ax/TXdqO6WG6QZaZTmQrIexcQDkAaiLTQVvugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864131; c=relaxed/simple;
	bh=oiw6zqSGckEv8r9kq0C9HN50WKjtTtL9z1NPZus69jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVSCLoHcDMBcqY9jLfiF/ucyrYLyCHNSSjSYqHPKWN15kMevQaH0wRXM4Ri7jfVhYwjU+tzA6x4/j40HfAZqRPX5EX6XSVowfC2PrEInG+fx3lbgtTaxaNgJRWgDAFpvlx+5lXeHKyDHtik1ONNnIKWGy+pLV6gCBh5iCBP1jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=D05sy7mU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755864127; x=1756468927; i=w_armin@gmx.de;
	bh=oiw6zqSGckEv8r9kq0C9HN50WKjtTtL9z1NPZus69jg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D05sy7mUI7fSb4wD3Qya0nOJqpZK31kBzZtlfVWW7lKxt302e9AdFtbtGwI8u3iI
	 HmtT+KSlz1GsXojPr2CUdzn8OlvL0W5gQXKGUzanew9eGgBfm9DK98jNFQU0rde5k
	 cvZdCOFlMomjoDBiz0As1F8ld3QSPlHweUfUcAJ927GS+S1C4RdOZRJBCHCp1FbqT
	 xxZFCaX7OYGZ4+hCn9BG5Uux36FX7nWssFHSl3el+BpZYuGh0Li1NpoKp5YJLJBJN
	 /iY0wXGIAfauWCbOanvrgaz1mwAmILblc1AX4ZzBFYngjFrHRUokeh22pgpR7MCz+
	 SMiSgOg0cUTSkNk01w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.189.91.1] ([176.5.63.45]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1uFFli3HDw-00cJgF; Fri, 22
 Aug 2025 14:02:07 +0200
Message-ID: <400ad8a1-eb7f-4737-9434-62aad120ef4a@gmx.de>
Date: Fri, 22 Aug 2025 14:02:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control
 support
To: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
Cc: basak.sb2006@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jlee@suse.com, kuurtb@gmail.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rayanmargham4@gmail.com
References: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
 <81e92b2d-825d-4455-9042-474c66c91120@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <81e92b2d-825d-4455-9042-474c66c91120@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KPqD7HeKhqi+dKBzLfcTvRJZQjT+kNBJreepmXI5/Zlp/7qCb8z
 sx62zcXwhMyLnMtdv0w0YO+1Y9qX554gIx4KdFEhTUHKnFXgk2fXwcSRdY8gJY/BZaOTGqJ
 +8HQ1OWIz4eLk0ruyvVQVDBUV4PZ1T0MVRsVftS4FDEfJ8uYIneK21/W+ilo+dsoPSZkybG
 jZwO+n/+vw+ULkb+PLwvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vGbGaNJEPhM=;UzgWxI4ZvaIW+MbNzVahe/FZRcD
 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
 O2xzsCQ=

Am 15.08.25 um 08:17 schrieb Fa-Iz Faadhillah Ibrahim:

>> > This experimental patch series aims to add fan control support to=20
>> the > acer-wmi driver. The patches are compile-tested only and need=20
>> to be > tested on real hardware to verify that they actually work. >=20
>> > I CCed two users who requested support for this feature. I would be=
=20
>> > very happy if both of you could test those patches and report back.=
=20
>> > > I am ready to help you both with compiling a custom linux kernel=20
>> for > testing this series.
>> Any updates from the two people with Acer hardware?
>>
>> Thanks,
>> Armin Wolf
>
> Hello, I've tried your patch on my Predator Helios Neo 16 (PHN16-72)
> using quirks from PH16-72 and it looks like fan control works just fine.
> On other note, can you please add PHN16-72 to the quirk table?
> if you need anything to test please do notify.
>
> Thanks,
> Fa-Iz Faadhillah Ibrahim
>
Hi,

sorry for taking a bit long to respond, i am currently on vacation. Nice t=
o know that the experimental patches work :).
Can you send me the output of "acpidump" on your machine?

Thanks,
Armin Wolf

>>
>> > Changes since v2: > - remove duplicate include and replace=20
>> hwmon_pwm_mode with > hwmon_pwm_enable in second patch > > Armin Wolf=
=20
>> (3): > platform/x86: acer-wmi: Fix setting of fan behavior >=20
>> platform/x86: acer-wmi: Add fan control support > platform/x86:=20
>> acer-wmi: Enable fan control for PH16-72 and PT14-51 > >=20
>> drivers/platform/x86/acer-wmi.c | 298=20
>> +++++++++++++++++++++++++++++--- > 1 file changed, 273 insertions(+),=
=20
>> 25 deletions(-) > > -- > 2.39.5 > >
>> -----------------------------------------------------------------------=
-
>
>

