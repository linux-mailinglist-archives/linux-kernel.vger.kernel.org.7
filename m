Return-Path: <linux-kernel+bounces-894040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872DC49223
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F1188ABC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BB33C513;
	Mon, 10 Nov 2025 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqGRM6j3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lA6EeayO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDC2EAD15
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804154; cv=none; b=L4Ak58+osO2Z6RgWezqwTY50ZjZxc0DZZCmkm2ZKJ6WIH5Oag5iYBhXSQc4Fq43OfXMFW26EnQ94Io0PKQOcHBzHw9v9FQXr1lbxD9ZCisstDWpovHWmMaywaUEdLEfokK7ibdo++FcsSMzLqhY8ZoYHYOqKutc1vy1UHKDSxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804154; c=relaxed/simple;
	bh=xKxyNxQEbkwLV73VAK1IAAduVglv/ftuHSgoRB72B3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbWrWJ1UV7dg+TZvro/UwuIdh6oZatc8ZRXTLzeM/I6Y4vxBlHajnF+/u8g3FR36a6/pSXQQhoqqf1KsuCgPpP7iBhrUzcJE9t4QNQ06veWqu/LhnShzMOTXaBJOGWLOlA3v5dNM+8IqrVVK/a2bukbkOJIn+alNyHWgbetRzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqGRM6j3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lA6EeayO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762804151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsC4OIMe3gmRmvlNNFpXstoVUqeEj0XTO2Zj29ABnBo=;
	b=UqGRM6j3cScTX3dZCCqvGUeHhsKN0uahJVGNJdsuRUnRejKI2kIdYAdVCFpV62grt3oDSX
	lhxsRVnslvSNN92NT671c/Kjgtg9GLUXr8VCpONshEhWLHvxKFTuQAX/hOm5qj8eJtcEs4
	9l32huQpRW89p4optjuX7HbIiTGfRWw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-qGj1hx9eOYiPWdri0mfrVw-1; Mon, 10 Nov 2025 14:49:10 -0500
X-MC-Unique: qGj1hx9eOYiPWdri0mfrVw-1
X-Mimecast-MFC-AGG-ID: qGj1hx9eOYiPWdri0mfrVw_1762804149
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b522037281bso2467863a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762804149; x=1763408949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsC4OIMe3gmRmvlNNFpXstoVUqeEj0XTO2Zj29ABnBo=;
        b=lA6EeayOymBhRxlxO2rYu4SxmpaZYaiUm3a/JbWX47lr2/8QBDIfYfxygOHBd0S1Fs
         H3jMnIB0X95fadcvRn6EmyiRVHZ3/QOw13UUnz4qccQJTEEAVaATpxsQK5HQi9+qpXE+
         jw7bsG/QP2K0n8etupuZ0D+5w35itJYEdw/lJQiyq+LPu1uoC/HipXemUYQiAPDvAfq+
         IcoVqbdit6UIssNIGtZHqXabav5wvaBbkEVUSOOyTu2GuxxRshOsfCJMoEY2bU4hyBiJ
         Nn8SLsGGnjrhYJGEl0+W8pes20jJLE4Gz2pLHMZT8EL/b2j07uVcf8RBCRLtxnvCitrP
         VVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804149; x=1763408949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsC4OIMe3gmRmvlNNFpXstoVUqeEj0XTO2Zj29ABnBo=;
        b=HNtYBEMXhPfX/bc+kuC5X9WGwfmf0xO1Qg5yxASDCHrsFI4TAu0xqn5qvs2Js2653h
         mQLeJSJyEoMEwl0B7Vw9bbZuAGmZAbnEmaPkW1Qbgwj1AESJiyBpQqgXmOHgaYFuU+/5
         gm1CZtLZsuwM455+8BjkQfV8YRfzEgZ71ww+iUCZpcOii7QuT3lLu467cGkKxklcucb2
         8Lu6vsBMGF0OEeuLdN79el3qztB0rgs9vfvsIIz9uNvwQtJ8IZD3bZ18h908YJNleATr
         Wz1wIacodcc+FxVM/hDT21XcqhGco7SQQ8chRwDkvqhwqa7Rq9AnJ/x3T7OpFCAkwGf3
         FVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsPpgV5GNVP5CQLlNIlg0kAs5VDbwF46S7d+maTVv2sE+p8rJPyVaNG3a5d0qRg5/VcldhMts2HV+KeZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI51R4KTO0uZFZMfFS1fdn/JD2qrL6cbnqxhuwSJzuz2QTrxIO
	LEhlKpbBJnkbYs4VbdrgtmIpU18PgfQQvOAX/P4gGKzfkHi3H4A2gzTqS6sF9czJ2RPhTq1yAX3
	s1BKHL9b5IBx/29LwUkinOBx53yZWDmhOmteQhPDNrfUBnm/PQ+ctI+jNAYnyp8givpDHjgv4vP
	ZPi+DeTkNlYbUt5oGdvQxJ10HG86Y4zfOYx8/ecpJF
X-Gm-Gg: ASbGncuzVPd9QvpmgqbLfQpH/CVay+AevhlAHKw+NAnnzXDWVHOgSNfaV3ARbzFlh3R
	6vxuNwAOYb0oxNde2n4pjDKzSASwHxlvtt6c63DKsB+QrgrqtPNM3uFofcWJreMVFnT+xdBEsdi
	W7OPD20UCZl47ApJ5vBOOMvLkmnV/+vCiqAqH88LmaQpT+OO/YIlFHeEs=
X-Received: by 2002:a17:90b:1809:b0:341:88ba:bdd9 with SMTP id 98e67ed59e1d1-3436ccfe206mr10197969a91.25.1762804149252;
        Mon, 10 Nov 2025 11:49:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDDdLvizeyNG51jHfQSI5Ft2PD8gmaHQ8j7PSR+JdRkj+cOLe0GAfm6pJ08Cn2rdWSSBdvGCzHpukYt7r3jWQ=
X-Received: by 2002:a17:90b:1809:b0:341:88ba:bdd9 with SMTP id
 98e67ed59e1d1-3436ccfe206mr10197957a91.25.1762804148890; Mon, 10 Nov 2025
 11:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110144404.369928-1-andriy.shevchenko@linux.intel.com> <9f7339a71c281e9f9e5b1ff34f7c277f62c89a69.camel@ibm.com>
In-Reply-To: <9f7339a71c281e9f9e5b1ff34f7c277f62c89a69.camel@ibm.com>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Mon, 10 Nov 2025 11:48:57 -0800
X-Gm-Features: AWmQ_bmfM-1dFi4Eh7we5WOp65_WNqiXfsYaelXYRaQCm5VKfJ5DFu_8_7vlU-Q
Message-ID: <CAJ4mKGYPoxPS62yFigmqFPPTHOSwgtj+WKwEtdpNGsu3BJya3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ceph: Amend checking to fix `make W=1` build breakage
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nathan@kernel.org" <nathan@kernel.org>, 
	"justinstitt@google.com" <justinstitt@google.com>, Xiubo Li <xiubli@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"nick.desaulniers+lkml@gmail.com" <nick.desaulniers+lkml@gmail.com>, "morbo@google.com" <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:42=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Mon, 2025-11-10 at 15:44 +0100, Andy Shevchenko wrote:
> > In a few cases the code compares 32-bit value to a SIZE_MAX derived
> > constant which is much higher than that value on 64-bit platforms,
> > Clang, in particular, is not happy about this
> >
> > fs/ceph/snap.c:377:10: error: result of comparison of constant 23058430=
09213693948 with expression of type 'u32' (aka 'unsigned int') is always fa=
lse [-Werror,-Wtautological-constant-out-of-range-compare]
> >   377 |         if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> >       |             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Fix this by casting to size_t. Note, that possible replacement of SIZE_=
MAX
> > by U32_MAX may lead to the behaviour changes on the corner cases.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  fs/ceph/snap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> > index c65f2b202b2b..521507ea8260 100644
> > --- a/fs/ceph/snap.c
> > +++ b/fs/ceph/snap.c
> > @@ -374,7 +374,7 @@ static int build_snap_context(struct ceph_mds_clien=
t *mdsc,
> >
> >       /* alloc new snap context */
> >       err =3D -ENOMEM;
> > -     if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> > +     if ((size_t)num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
>
> The same question is here. Does it makes sense to declare num as size_t? =
Could
> it be more clean solution? Or could it introduce another warnings/errors?

Given that the number of snaps is constrained over the wire as a
32-bit integer, you probably want to keep that mapping...(Though I
guess it's the sum of two 32-bit integers which technically could
overflow, and I'm not sure what happens if you actually hit those
boundaries on the server =E2=80=94 but nobody generates snapshots on the sa=
me
file in that quantity).

All that said, it'd be kind of nice if we could just annotate for
clang that we are perfectly happy for the evaluation to always be true
on a 64-bit architecture (as snapids are 64 bits, we will always be
able to count them).
-Greg

>
> Thanks,
> Slava.
>
> >               goto fail;
> >       snapc =3D ceph_create_snap_context(num, GFP_NOFS);
> >       if (!snapc)


