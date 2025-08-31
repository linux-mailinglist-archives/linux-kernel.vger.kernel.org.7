Return-Path: <linux-kernel+bounces-793545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F3B3D4FE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B63BB41A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698A22425E;
	Sun, 31 Aug 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="APWhBNce"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67A1F37D4;
	Sun, 31 Aug 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668845; cv=none; b=GiMTToOE68Jw4xL/3yA+mb5iA4W4AP646r55UWm5pg+jwqspbZn75ku5E2uF/1wunPgdz0gON7rzDy88x+XgbOppwsgqropOPzxyx+w48BgFEZ8NE0QFB9PDiur1mpJqfbc99FcTu83xoxBQVo9UZT8amskAnl0rMPyG0y4a2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668845; c=relaxed/simple;
	bh=aJmR4TsSq7dkD6zSzBGam8hbl8zAXz4Hr2O0DEPl6JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9pOH/BLNZAJZmo/GBrASTC6q9uPl6j4rj6ETg66+WyL20pixSxdCy8nYjefu8bQICQIgBzwk+pKTxvgc9KTkhDWUjz2Q8tlRZAPcO9MLTp9qvBnD8xfoUT6r3lOPU48uh3dBJC4EE1s9g10GxDJ2OS5vujkgemS9Cgi/cv6BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=APWhBNce; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756668841; x=1757273641; i=w_armin@gmx.de;
	bh=aJmR4TsSq7dkD6zSzBGam8hbl8zAXz4Hr2O0DEPl6JA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=APWhBNceVjIIen6+DihM/Qy9ba6icJ3EoA5zMUoxW53ebw6iItawBwnmScLNPZSv
	 oWUfbie1SjHcHRAnXZJ6f5FTIcjaYtnLS8IFFNjlR6XbeE5hpq5VyH2i8Gi9iLo8K
	 D92yCiWCZXrQxC2VvveTEPsLjHLa/E52tJFxNY26wRelG6YVKKeA5i9K0e/gb1X/i
	 w3xeLwNi9J/ZmTLNxjeVjKldPf6zfvrI/fljkfsJPrG6Ksppiytgs+wPt+wkDTLgQ
	 ZieaN6ZhTOyqQzX/zfG6MogKJn1m/I8y5jsYvfnc0UvSgPvxgyQAzWmRsi3Z5uVa5
	 J+dHR0eOwhNtEX1M9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.241.135.1] ([176.2.64.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1uOSx02OZe-017tuN; Sun, 31
 Aug 2025 21:34:01 +0200
Message-ID: <5b7f6b40-8d4f-470e-ae84-b51d4177af39@gmx.de>
Date: Sun, 31 Aug 2025 21:33:53 +0200
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
 <400ad8a1-eb7f-4737-9434-62aad120ef4a@gmx.de>
 <1bb3edd6-405f-4615-831f-301dba525bc3@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <1bb3edd6-405f-4615-831f-301dba525bc3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YGYjWGaTqStoyIX0YZxQo5lg+IYwxC4W5/HIpbu+qDiwUcZBM/W
 NlZFVt5shgLOTbKqzA4gZ/H8WYQwYQZIFGuInobidZWDUzZekwUE3HgWpEBlumejHhKOTQ/
 OrGBLE0s34YxLSrEC3/picPDOHdmkCux60BOsSa21tfGeH6GUFXnOXNqiFlE3b6we8B0IXO
 CSssEwfcXvX4sdr+Xu+Ig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ygQhV3K8Hs=;2xOxfNEwfE/11KTJd9LaEaiGLvN
 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
 M3d81nHvkfIcSJhkYWB

Am 23.08.25 um 03:27 schrieb Fa-Iz Faadhillah Ibrahim:

>
> On 8/22/25 7:02 PM, Armin Wolf wrote:
>> Am 15.08.25 um 08:17 schrieb Fa-Iz Faadhillah Ibrahim:
>>
>>>> > This experimental patch series aims to add fan control support to=
=20
>>>> the > acer-wmi driver. The patches are compile-tested only and need=
=20
>>>> to be > tested on real hardware to verify that they actually work.=20
>>>> > > I CCed two users who requested support for this feature. I=20
>>>> would be > very happy if both of you could test those patches and=20
>>>> report back. > > I am ready to help you both with compiling a=20
>>>> custom linux kernel for > testing this series.
>>>> Any updates from the two people with Acer hardware?
>>>>
>>>> Thanks,
>>>> Armin Wolf
>>>
>>> Hello, I've tried your patch on my Predator Helios Neo 16 (PHN16-72)
>>> using quirks from PH16-72 and it looks like fan control works just=20
>>> fine.
>>> On other note, can you please add PHN16-72 to the quirk table?
>>> if you need anything to test please do notify.
>>>
>>> Thanks,
>>> Fa-Iz Faadhillah Ibrahim
>>>
>> Hi,
>>
>> sorry for taking a bit long to respond, i am currently on vacation.=20
>> Nice to know that the experimental patches work :).
>> Can you send me the output of "acpidump" on your machine?
> Hello,
>
> Sorry for disturbing your vacation, hope you're having a great time :).
> Output of "acpidump" attached below.
>
> P.S. Sorry for the messed up formatting before, first time here so I'm=
=20
> still learning how this works, hopefully it'll be okay now.
>
> Thanks,
> Fa-Iz Faadhillah Ibrahim

Thanks.

Would it be OK for you if i send the non-RFC patches once i am back home (=
around 15.09.)? The reason for this
is that i made some improvements to the RFC patches, but those improved pa=
tches are only stored on my develop
machine at home.

Thanks,
Armin Wolf

>>
>> Thanks,
>> Armin Wolf
>>
>>>>
>>>> > Changes since v2: > - remove duplicate include and replace=20
>>>> hwmon_pwm_mode with > hwmon_pwm_enable in second patch > > Armin=20
>>>> Wolf (3): > platform/x86: acer-wmi: Fix setting of fan behavior >=20
>>>> platform/x86: acer-wmi: Add fan control support > platform/x86:=20
>>>> acer-wmi: Enable fan control for PH16-72 and PT14-51 > >=20
>>>> drivers/platform/x86/acer-wmi.c | 298=20
>>>> +++++++++++++++++++++++++++++--- > 1 file changed, 273=20
>>>> insertions(+), 25 deletions(-) > > -- > 2.39.5 > >
>>>> ---------------------------------------------------------------------=
=2D--=20
>>>>
>>>
>>>

