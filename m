Return-Path: <linux-kernel+bounces-609632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6DCA92544
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1443B30D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307A25B675;
	Thu, 17 Apr 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="A5ElI5kj"
Received: from mail84.out.titan.email (mail84.out.titan.email [3.216.99.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6719F40A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912803; cv=none; b=oh8uVh+wqtziMp9zhjr+8Gde7ROkdM/Dk/0GZFkEtAgaSydKr9NKT1oLULRxswTl8Bu5XHzVaJeE2UvXHlRAg2MQugWZoTO8YY82Euj2RlqaArB9QyzgBXWOR9XxRXoE9FXzE58JD9wvxEeV188ckeJOkiv4OR7Z/eHQVFKCV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912803; c=relaxed/simple;
	bh=dtb9K8lcpmys1W32pb4Durrh6XWu23sh+YsgDer1diQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n5NPvNX+pgqcsG+yONqBduQQrumtIrAqDAXIn7XnPc+HfB4WmDJoAudEceC4vF2NGwAPgGyVo9UtDbrMZlByR5aIN9qRsiwA9ejy3hixbJWXCHQ3lCx6/IFe1jNdsljsEZ8z729EmOMRD9fO+/Nyv02LWH9CG0hC31dq+JDZFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=A5ElI5kj; arc=none smtp.client-ip=3.216.99.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 2E995E03F8;
	Thu, 17 Apr 2025 13:11:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=JSduZ8d++wQ3nvXz3tNF7pbhlQZRllEIV6azsHZ8TPo=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=in-reply-to:cc:references:subject:from:date:to:mime-version:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1744895515; v=1;
	b=A5ElI5kjlOJ1vwK7+UoOWh5AWqnuoXJWfAXWbNTJjHiyfHrj0hIAKYYk8jeJuSh4s++5cR2X
	po6CPLW9b7C8k0walzZAL4Z37+v2Qa4eTwftjYlewD78oNYBUSUbzQavghNw40aXMU1shIh9lMU
	43/xEmyTzkfzN93p77Dq3w5A=
Received: from smtpclient.apple (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4A185E02FF;
	Thu, 17 Apr 2025 13:11:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] md/bcache: Mark __nonstring look-up table
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <994E520B-64B1-4387-8DFF-88755346FE55@kernel.org>
Date: Thu, 17 Apr 2025 21:11:39 +0800
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcache@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <208BFA1D-F3E9-4D9F-A4A1-4E4C3F4CA309@coly.li>
References: <20250416220135.work.394-kees@kernel.org>
 <CAMj1kXHfearSZG6TFTxxX87qmRkUmAefQm-TfPNS8j09kWxujQ@mail.gmail.com>
 <994E520B-64B1-4387-8DFF-88755346FE55@kernel.org>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1744895514990706196.26132.3658974856431284874@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=fZxXy1QF c=1 sm=1 tr=0 ts=6800fe1b
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=dxI0GJXRgo0QjBsCUv0A:9 a=QEXdDO2ut3YA:10 a=UZE0bJQDkNwXTw_to89n:22



> 2025=E5=B9=B44=E6=9C=8817=E6=97=A5 15:10=EF=BC=8CKees Cook =
<kees@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On April 16, 2025 11:16:45 PM PDT, Ard Biesheuvel <ardb@kernel.org> =
wrote:
>> On Thu, 17 Apr 2025 at 00:01, Kees Cook <kees@kernel.org> wrote:
>>>=20
>>> GCC 15's new -Wunterminated-string-initialization notices that the =
16
>>> character lookup table "zero_uuid" (which is not used as a C-String)
>>> needs to be marked as "nonstring":
>>>=20
>>> drivers/md/bcache/super.c: In function 'uuid_find_empty':
>>> drivers/md/bcache/super.c:549:43: warning: initializer-string for =
array of 'char' truncates NUL terminator but destination lacks =
'nonstring' attribute (17 chars into 16 available) =
[-Wunterminated-string-initialization]
>>>  549 |         static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>>>      |                                           =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>=20
>>> Add the annotation to silence the GCC warning.
>>>=20
>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>> ---
>>> Cc: Coly Li <colyli@kernel.org>
>>> Cc: Kent Overstreet <kent.overstreet@linux.dev>
>>> Cc: linux-bcache@vger.kernel.org
>>> ---
>>> drivers/md/bcache/super.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>>> index e42f1400cea9..577d048170fe 100644
>>> --- a/drivers/md/bcache/super.c
>>> +++ b/drivers/md/bcache/super.c
>>> @@ -546,7 +546,7 @@ static struct uuid_entry *uuid_find(struct =
cache_set *c, const char *uuid)
>>>=20
>>> static struct uuid_entry *uuid_find_empty(struct cache_set *c)
>>> {
>>> -       static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>>> +       static const char zero_uuid[] __nonstring =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>>>=20
>>=20
>> Just
>>=20
>> static const char zero_uuid[16] =3D {};
>>=20
>> should work fine here too. No need for the initializer.
>=20
> =F0=9F=A4=A6 Yes. This is what I get for fixing dozens of these. I'll =
send a v2...


Can we do this,

static const char zero_uuid[16] =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0};

I like the explicit array element number 16, and the explicit uuid =
content by obvious zero (=E2=80=980=E2=80=99) symbols. They provide =
redundant information.
Not sure whether GCC 15 complains or not.

Thanks.

Coly Li=

