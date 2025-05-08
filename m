Return-Path: <linux-kernel+bounces-640076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5EAB0060
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88993B9752
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CE2798E2;
	Thu,  8 May 2025 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="TRggdLXE"
Received: from mail60.out.titan.email (mail60.out.titan.email [209.209.25.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC9221263
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721504; cv=none; b=qSfSBEzQ+MD9TMhDl4wo+A0pkjdwl3VSM0vdh/yuvoLhIwCSxjmC9PybfVBUDwOWoZh6LaKI0r5wM+DwrCoha/v975WA+CDF9g5S4mSPAewGNhzz5PdUHGJpL8V78t3t084GenuyhFSo82gLz+MjxFMMO1c9SwpjS5vk+nDCVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721504; c=relaxed/simple;
	bh=T2DTGsDRdArRCaS2FN2J3QoGWbMHNQsTYpTibzEj6bg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f8uAxq0FTwEL5vQ18O1MRG5GkjoRwrzlxWj38o1sIzqk3NLEUbac90EaaCZqd1qThICKKyZ9lUC8er/NiVyQ5YO/M3Vp13y/Q1mp5WrHNj9PfU0tIWzbia2/9P+jFD4DCPkuM8L1ME06jRhka/L2y6D07BH+ycYiXm5LjaPQ+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=TRggdLXE; arc=none smtp.client-ip=209.209.25.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id CAE4EE0107;
	Thu,  8 May 2025 16:00:00 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=u/FvevRsgL+DZjKgVYLFKDjkbcSxXS1/GItuAGT1qp8=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=to:from:message-id:mime-version:in-reply-to:cc:references:subject:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1746720000; v=1;
	b=TRggdLXEEw7SpF9o7r3kJf1ovOK1sc1y79Qk7u19BT7lneNnSsdiieYhoQ97/5slu6qX1QqK
	vlaKALallZUUEB7Bk9b1j/y7hzrkfseMleCnghqx07WyIqkJ1FOt35Y+bihMj28C3wTDPkX6R0e
	m7O0X4FXALP/UhAFXD9Zc7/Q=
Received: from smtpclient.apple (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 2C61FE0314;
	Thu,  8 May 2025 15:59:56 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] md/bcache: Mark __nonstring look-up table
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <202505080844.DD7F50F0A@keescook>
Date: Thu, 8 May 2025 23:59:43 +0800
Cc: Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Ard Biesheuvel <ardb@kernel.org>,
 linux-bcache@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <02B98CCF-15A9-46EE-AD00-C5EDCAE774F0@coly.li>
References: <20250418202130.it.887-kees@kernel.org>
 <389A9925-0990-422C-A1B3-0195FAA73288@coly.li>
 <851B250D-A22C-4B47-BBAC-55284B5B5790@coly.li>
 <202505080844.DD7F50F0A@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1746720000629225916.26132.7404258459398680928@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=O7TDvA9W c=1 sm=1 tr=0 ts=681cd500
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=LN1WO8SOcHLxaujQaaAA:9 a=QEXdDO2ut3YA:10 a=K3YW7E1MVtJkPNdb1KoQ:22



> 2025=E5=B9=B45=E6=9C=888=E6=97=A5 23:58=EF=BC=8CKees Cook =
<kees@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, May 08, 2025 at 11:01:34AM +0800, Coly Li wrote:
>>=20
>>> 2025=E5=B9=B44=E6=9C=8819=E6=97=A5 11:55=EF=BC=8CColy Li <i@coly.li> =
=E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>>=20
>>>> 2025=E5=B9=B44=E6=9C=8819=E6=97=A5 04:21=EF=BC=8CKees Cook =
<kees@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> GCC 15's new -Wunterminated-string-initialization notices that the =
16
>>>> character lookup table "zero_uuid" (which is not used as a =
C-String)
>>>> needs to be marked as "nonstring":
>>>>=20
>>>> drivers/md/bcache/super.c: In function 'uuid_find_empty':
>>>> drivers/md/bcache/super.c:549:43: warning: initializer-string for =
array of 'char' truncates NUL terminator but destination lacks =
'nonstring' attribute (17 chars into 16 available) =
[-Wunterminated-string-initialization]
>>>> 549 |         static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>>>>    |                                           =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>=20
>>>> Add the annotation (since it is not used as a C-String), and switch =
the
>>>> initializer to an array of bytes.
>>>>=20
>>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>>> ---
>>>> v2: use byte array initializer (colyli)
>>>> v1: =
https://lore.kernel.org/all/20250416220135.work.394-kees@kernel.org/
>>>> Cc: Coly Li <colyli@kernel.org>
>>>> Cc: Kent Overstreet <kent.overstreet@linux.dev>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: linux-bcache@vger.kernel.org
>>>> ---
>>>> drivers/md/bcache/super.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>>>> index e42f1400cea9..a76ce92502ed 100644
>>>> --- a/drivers/md/bcache/super.c
>>>> +++ b/drivers/md/bcache/super.c
>>>> @@ -546,7 +546,8 @@ static struct uuid_entry *uuid_find(struct =
cache_set *c, const char *uuid)
>>>>=20
>>>> static struct uuid_entry *uuid_find_empty(struct cache_set *c)
>>>> {
>>>> - static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>>>> + static const char zero_uuid[] __nonstring =3D
>>>=20
>>=20
>> Hi Kees,
>>=20
>>> I notice zero_uuid[16] changes to zero_uuid[], then the element =
number information is removed.
>>>=20
>>> Is it OK for GCC 15 to only add __nonstring and keep zero_uuid[16]?
>=20
> Either way is fine. I can update the patch to use the "[16]" again if
> you'd like?
>=20

Yes please. Thanks in advance.

Coly Li


>=20
>> Ping ?
>>=20
>> You are expert here, I need your opinion.
>>=20
>> Thanks.
>>=20
>> Coly Li
>>=20
>>=20
>>=20
>>>> + { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>>>>=20
>>>> return uuid_find(c, zero_uuid);
>>>> }
>>>> --=20
>>>> 2.34.1
>>=20
>>=20
>=20
> --=20
> Kees Cook


