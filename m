Return-Path: <linux-kernel+bounces-611408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0EA94181
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 06:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD4D19E7C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497954D599;
	Sat, 19 Apr 2025 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="oJhOnwfe"
Received: from mail83.out.titan.email (mail83.out.titan.email [3.216.99.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB627442C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745035276; cv=none; b=ZSVc5tB+78CoAstcYKf+vaoQw+Yu41ZbIGOdrVzRhw4nG5auEkaMiolKURR5Leqzm2NZJd+4f5E0dPB4aYNpRYN7LM6eUgPcQJ1RtlmCfiM8gmvjBuglP8mww4NPCYBbTjKgsvgE+6nv74Kz+W9IrN2qNj97sJKsvuXwghZ9YmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745035276; c=relaxed/simple;
	bh=8vsWUbNInXOmJ6LkU6uCbJfr9BGsN9vSttRt6BzaTnU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hpyjmn1aYIyIG6c5lWZDkziQd4SayVWHj3uolworMWxOFQ3AcBoV/zQtsEFEj1Gf7mKUpCA/YHnFa2VryrAR/5gb83PWWh3Dm8CN2z1VywOPNZXupYWnTAiQvGxAa5A9WZ3KV3BYTFH6Y57ATBJbzMVHb2osrjaPfThZGl/nk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=oJhOnwfe; arc=none smtp.client-ip=3.216.99.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id D13B760059;
	Sat, 19 Apr 2025 03:55:26 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=bAvYi5ImaoxjDMe4vzylBlBmlqcUZYzHCYPKwoB87qI=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=from:in-reply-to:cc:to:mime-version:subject:references:date:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1745034926; v=1;
	b=oJhOnwfeVOG8XG2+ePu+rd/hidWNokUuygMfqtb86FuyRwQz7ETjQwhTBXb7BCwtnAY3iYwH
	Yh1+xXALoOaA+3snTLim7K46mUvpB+x3mwVCC6wrPZiKcHLJZgeMtxiTfm/uHx9NomZibAM/Ar/
	VJgUsYz0lAVs9qpKOELp5Qy4=
Received: from smtpclient.apple (unknown [43.161.241.230])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id C447160038;
	Sat, 19 Apr 2025 03:55:23 +0000 (UTC)
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
In-Reply-To: <20250418202130.it.887-kees@kernel.org>
Date: Sat, 19 Apr 2025 11:55:10 +0800
Cc: Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Ard Biesheuvel <ardb@kernel.org>,
 linux-bcache@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <389A9925-0990-422C-A1B3-0195FAA73288@coly.li>
References: <20250418202130.it.887-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1745034926648469019.5242.7544881322108761200@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=RvE/LDmK c=1 sm=1 tr=0 ts=68031eae
	a=sdR4fqZNG57T/J2FY8bnUA==:117 a=sdR4fqZNG57T/J2FY8bnUA==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=BDcCamcCxTd4Ojxa7JYA:9 a=QEXdDO2ut3YA:10 a=FvX_cx3yyqDC_9C4kSCW:22



> 2025=E5=B9=B44=E6=9C=8819=E6=97=A5 04:21=EF=BC=8CKees Cook =
<kees@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> GCC 15's new -Wunterminated-string-initialization notices that the 16
> character lookup table "zero_uuid" (which is not used as a C-String)
> needs to be marked as "nonstring":
>=20
> drivers/md/bcache/super.c: In function 'uuid_find_empty':
> drivers/md/bcache/super.c:549:43: warning: initializer-string for =
array of 'char' truncates NUL terminator but destination lacks =
'nonstring' attribute (17 chars into 16 available) =
[-Wunterminated-string-initialization]
>  549 |         static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>      |                                           =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Add the annotation (since it is not used as a C-String), and switch =
the
> initializer to an array of bytes.
>=20
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> v2: use byte array initializer (colyli)
> v1: =
https://lore.kernel.org/all/20250416220135.work.394-kees@kernel.org/
> Cc: Coly Li <colyli@kernel.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-bcache@vger.kernel.org
> ---
> drivers/md/bcache/super.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index e42f1400cea9..a76ce92502ed 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -546,7 +546,8 @@ static struct uuid_entry *uuid_find(struct =
cache_set *c, const char *uuid)
>=20
> static struct uuid_entry *uuid_find_empty(struct cache_set *c)
> {
> - static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> + static const char zero_uuid[] __nonstring =3D

I notice zero_uuid[16] changes to zero_uuid[], then the element number =
information is removed.

Is it OK for GCC 15 to only add __nonstring and keep zero_uuid[16]?

Thanks.

Coly Li=20


> + { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>=20
> return uuid_find(c, zero_uuid);
> }
> --=20
> 2.34.1
>=20
>=20


