Return-Path: <linux-kernel+bounces-828369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A7B9479E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430B94416B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FBB30274C;
	Tue, 23 Sep 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7/XMcH0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95952571C7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606673; cv=none; b=RDfr9nwL9J/nLgBV4FeoT+cF1SB9APq30T1y2QHHOO1Sn/qV+HARejQqcciUarKorhoDU4Vvg6vWJjAyrqIYlBKWKXzLJmUxVW6WFrIF9nlS7D4lISjIU0VwkG6MhXtBDxasQo5BXOvlNdr4e0Su0Zv98tOqW2c3AX5UstyXGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606673; c=relaxed/simple;
	bh=7vzNUyVbTkZEX9Yo0h80M9KHJXaNs2BROEdqSbIJ2I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCkRpsdSv8ag6G0IjE7haMN8wWUGIRhEu/5DBcus5u7PLCbtTQkstUwX/LMmKUT/FKMw1ZZbTRMjNQ1BYaSDtvDk4785Tx+kJTkKs1Q9Q+nNHgN+9mgXuErebRvX1/5W6Ol1wPgT7VoJnHTraQJg96jCVyYr9Sr3COuf31HhrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7/XMcH0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2e66a300cbso250598466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758606670; x=1759211470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rclo64BIQ60aWNHFZJxWB0Ardorfdp+QiYuOEftSfU=;
        b=W7/XMcH07SWvC/rY1TEOWUER1ejTMEj6/ei9+AO75Ztj5JviHn93IjzogAp+Cksnbv
         iK/pUTiC9rJA+2SNMdqcKCk9jXoQRjsUuKLvDLALF1QXrhboFQUVBjwpfSsQZRCjxs6N
         dp/4esytpCXYHOPGoARofm4Ze4oFDDYhsQI6UKH4Vl5xfFQralVaWbHonxbDzGLul4Sz
         10VQ3JRhh3hE38d8Hz6hGJV6ioalsSYISGscAevKDYinIrKNPZ7aic6DVeqSChFDbboE
         jRIbLmWMI5Dnz9Y/09zk0W4vswANkKw8mHYhHLpOEEwA5opKm7r9JP3E10mSO8cI7dfl
         6YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758606670; x=1759211470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rclo64BIQ60aWNHFZJxWB0Ardorfdp+QiYuOEftSfU=;
        b=R+7Foz5Tg+yofRMwsOsUigazQuqi9gRtQkFECJLt5TpGDHYpO3M4mOaZb0c5xejSkY
         VNc+dP7uvz7yD08BFwJAJBhoYhHTiacAso8BKWo6QNkkbHegqEEWlIIt+7ccfPfYujiJ
         vclJzEJPmqGXqGohzwPZp+dtftYXgCE6WfQKDh8hNpmIRSX8tknOzVcLAbAUPE7q/c67
         pmAdXTFfdZhO6WK+9TFuis6ZV8kkLUly8lYHGR/wUMeg4y8k6jyB1y6b9+bM768ar+kC
         IsqKSG9QZp7U0uHU+ek65Z4a2eWhnt2spaIuz6Feo8sRZwRXDaKjeJPP2EZslAF3AOdO
         NfUA==
X-Forwarded-Encrypted: i=1; AJvYcCUNJqiQYlY5CjWWWkoeaOBlvs7tlNh9kqcdtjY19e+CrzXUlTFuKkAEQkaYK6oMDKa8pGSbIbbcmtr2+iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRoPs+MRhX4slrX+vEDCkE6IYJ+9J127Z+5GSrGuWeLZUXkl9
	u396t7SLUmwxwtxHTESTAWkIWDKxKBcWJeFkBnx2JpYr/crN0Sr5Im+5Ig9Lz9WI9WEk0Urr4HS
	pcAUgk+MPNazdO7aaOazuHu2TNqsQw/M=
X-Gm-Gg: ASbGncs0VsgTCSf4KSjDZR4mloKzzm+ILF9xm8nyE/8smlpWAXJeluS+ZTShBn8NoCK
	gUlqukHhVrIxOuVme/XXygZHWwiagO3NQjFAL5Z66ETRGsLt0b3Y349yHQS1o8ihNs8CbBsEXGE
	qTHDXMEQ3NR0bA98xJsE/arxw6OYBWadqgx+hncKKTe9UkwUn4jcm5fg6hk60etam2XwOXJzXz5
	RZIuA==
X-Google-Smtp-Source: AGHT+IH7TdssnS5qMaLU0popPFCw6NnbrKbkqeHN9FUSAFsycRrelKRVehoar4TXFvkLVFGqYheq/LvCXZYe8biHGWk=
X-Received: by 2002:a17:907:9287:b0:b07:c815:70a9 with SMTP id
 a640c23a62f3a-b3028427f9fmr111647866b.26.1758606670182; Mon, 22 Sep 2025
 22:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922082417.816331-1-rajasimandalos@gmail.com> <CAH2r5mtpEc7ePZ58_qdE+9GRPVO3PPYuN44uHuskoQpnssbkdA@mail.gmail.com>
In-Reply-To: <CAH2r5mtpEc7ePZ58_qdE+9GRPVO3PPYuN44uHuskoQpnssbkdA@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 23 Sep 2025 11:20:58 +0530
X-Gm-Features: AS18NWCtF7MOgYcDiyoQBMAI1ZcnuNUHSecZ96WtJR-i9O-dzS01hRDZseli6rA
Message-ID: <CANT5p=oG_btGS7xKXoRS8Z46JqBQ2E8pud9XRDWrJe1AhGaZYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when max_channels=1
To: Steve French <smfrench@gmail.com>
Cc: rajasimandalos@gmail.com, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, linux-kernel@vger.kernel.org, 
	Rajasi Mandal <rajasimandal@microsoft.com>, 
	samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:36=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> i just noticed a more serious problem with multichannel/max_channels
>
> When we mount with multichannel (at least to Samba e.g.) with
> multichannel disabled on the server it confusingly returns "resource
> not available" we should at least log to dmesg something more
> meaningful than what we do today:
>
> [ 1195.349188] CIFS: VFS: failed to open extra channel on
> iface:10.45.126.66 rc=3D-11
> [ 1195.454361] CIFS: successfully opened new channel on
> iface:2607:fb90:f2b6:0732:7504:183c:991e:6e53
> [ 1195.454599] CIFS: VFS: reconnect tcon failed rc =3D -11
> [ 1195.457025] CIFS: VFS: reconnect tcon failed rc =3D -11
> [ 1195.457040] CIFS: VFS: cifs_read_super: get root inode failed
>
>
> Samba behavior is also strange - it advertises multichannel support in
> negprot response but doesn't advertise it in session setup flags.

If the user mounts with multichannel enabled, then it is expected that
the client will try to setup more channels.
If the server cannot support it, these logs are expected.

Btw.. It looks like the client was able to setup one additional
channel above. But reconnect tcon failed. I wonder why that happened?

>
> On Mon, Sep 22, 2025 at 3:25=E2=80=AFAM <rajasimandalos@gmail.com> wrote:
> >
> > From: Rajasi Mandal <rajasimandal@microsoft.com>
> >
> > Previously, specifying both multichannel and max_channels=3D1 as mount
> > options would leave multichannel enabled, even though it is not
> > meaningful when only one channel is allowed. This led to confusion and
> > inconsistent behavior, as the client would advertise multichannel
> > capability but never establish secondary channels.
> >
> > Fix this by forcing multichannel to false whenever max_channels=3D1,
> > ensuring the mount configuration is consistent and matches user intent.
> > This prevents the client from advertising or attempting multichannel
> > support when it is not possible.
> >
> > Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
> > ---
> >  fs/smb/client/fs_context.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> > index 072383899e81..43552b44f613 100644
> > --- a/fs/smb/client/fs_context.c
> > +++ b/fs/smb/client/fs_context.c
> > @@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct fs=
_context *fc,
> >                 goto cifs_parse_mount_err;
> >         }
> >
> > +       /*
> > +        * Multichannel is not meaningful if max_channels is 1.
> > +        * Force multichannel to false to ensure consistent configurati=
on.
> > +        */
> > +       if (ctx->multichannel && ctx->max_channels =3D=3D 1)
> > +               ctx->multichannel =3D false;
> > +
> >         return 0;
> >
> >   cifs_parse_mount_err:
> > --
> > 2.43.0
> >
> >
>
>
> --
> Thanks,
>
> Steve
>


--=20
Regards,
Shyam

