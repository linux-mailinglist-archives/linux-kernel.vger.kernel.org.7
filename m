Return-Path: <linux-kernel+bounces-887716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7DC38F08
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04B904EB8BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BED154425;
	Thu,  6 Nov 2025 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7TCD885"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2E1EA84
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398141; cv=none; b=rthQNan6RabExAdP7f25vpK3ykCpN5iiGTINrLUXBswRRhGMJ3B3O4KFQWaPzQ5aee3hQcbz9ECcaYfCShyU7qmtL4ImCaKm5wf/KIbAd65weVqUxamgobZDlnugIwUIMHzwhp5uVoN172orwh5isdcRHDyFeYyjnmGnXILiq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398141; c=relaxed/simple;
	bh=Kqvf9mGvhQ804Eoz9/qab3V3WXgY3X1gqB1lr87U+b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/VsYcMx+Dl0gj01Z9/CeEgIcdbnKkiP6XNNADjLi3JS9CLWHFTs5Nkw4b3df3dO4iEqoDy9WdIny3I0IACm6dSR1m/wT1ZhQQ6l/h6su8gbmMbghEfwwEAclSY1aaNoMT3WKwGHXVzVkTFBmDNz3YJtFMju4p27RgSW9Myux8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7TCD885; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640f627d01dso829811a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762398138; x=1763002938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdTVOQ5C6+I6zTXTkQAAntlGv9zzOWGKY2nCqub+/QI=;
        b=D7TCD885asWc1HhGogTpawSCoDkyF0PUlmxj015yM441ODc06kZ7IkzmRJwx06249A
         EsWC6R550DGNP0xpIWE8LdVznfa+4YEtN/a1gn9PYCkn9ecIen/Q5o6pWSK9yIkDtu2D
         i0hvPK3npnHHkOK7nQdfz6T9i4NqJal29kb36uJbXIwr0ymWrhQCQg+YtsSdMXDTb5EO
         5YXZ8rgeFxcsYMhCyBtohvh/M2Iz4m7rDAy3rdYbWcxJi0RcOsY8QdZ41Th+ujP/xbDl
         AX8EFYkc4ORiqpC+LgezFHU/YCMZRbqLowqqI1CtGRNFvZyOdd5JQuuWFd2BT2ptWVJo
         Z5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762398138; x=1763002938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdTVOQ5C6+I6zTXTkQAAntlGv9zzOWGKY2nCqub+/QI=;
        b=NxTjCgHhremMN1L+fvoPRq5NolI1T0Y0jo+dIeqB7YlH5DUd9vygmVJSBu+k/ZGS0O
         n5mFSzMaJk/mM13uh3Vx3DlJX9+FyfeUL6YK5YhIPpMFRRCHqrd3awFsJ7kszudMFV/c
         zdOa8YyejZN+oosAwC8/UQDKxh4qE9QEvqdZti/7Esvb6Im/5rlvClZCaCab0oWGbPdC
         ixTXUKo+74EGihVzdMHkMj1q8YkGZmkNADdl8XGF+LH0BV5Cbv1ExIQzO8ilA2HuqjjW
         av9YklSJVzF+lfhXsdWj8GRwoIxdajoADHccQHF2sOQLD7Cx/r58WNnmZnIsgXPtSR7K
         IokA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Z5REf5yeO2THS21RpRbhxq/Gozlkd9FEz1f5ejx9A7qBpso3UNw8/y+dLFkIF2TrG7C2TP/t/PGgefQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1gcrNZp7UUZ5WOr2XSIhVgcFtQH+fiqXAWeQO0TXRjnEqqGE
	SnD0zEjekHU4TptuQ9t23c5XBBIT9HLS7H4oj2vlfi1h8Ab9Y6LbE/x95hBThY2fHHL4qQqsP7U
	UOXypbn8lkleKq1zmjXhVePxUz97NqoE=
X-Gm-Gg: ASbGncvVZf1zB0+RVGuasgAb8spG51IsgMvu9LBoHSKog2uqEuRa+7r6JMH7EClQVb6
	oeku43+khVG2q46R5Qx2YX8fPPnysqjphxCYSJjq8jgdcLUdnYPmQ9YwtFwRvJsC2yCv5Spakmw
	bI8GMxDfKQUyr2n6djT9wJmM22PCplcOXHMGXAEJMvQfUAm7ySgsiVD2h5UgbAITMuKb4pSKzNV
	NQRHQ5C2qv4zojq63viZoRETgg9bOA3oj/3OPmLm4TQPctqArd6EUqWwrLbZhNYzLKfiybs5Nb+
	stO7zXzM8AXT4fs=
X-Google-Smtp-Source: AGHT+IEj9m5ZkaxmPEyaM29/PZON51jtee+49+ZR5dFaEI08ZZsdq2jvMbQ+D4eQUShG1eHFYMyFG9ITbmJGz6KZXw0=
X-Received: by 2002:a17:907:7284:b0:b72:6383:4c57 with SMTP id
 a640c23a62f3a-b7265688425mr496965366b.55.1762398138199; Wed, 05 Nov 2025
 19:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <20251105132023.GC19044@lst.de>
In-Reply-To: <20251105132023.GC19044@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Nov 2025 13:01:51 +1000
X-Gm-Features: AWmQ_blU2RdEZd9t9U93QfcNDb_wTd4nmog6RFwVnxgAE9dHZ0GjWIC6Zcaxd-0
Message-ID: <CAKmqyKOuR4jyJyY3ypqMMbghBioG3u3xECJnsmM_sRtcOeeaug@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:20=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> >  4 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index a01178caf15b..19980122d3d5 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(str=
uct nvme_ctrl *ctrl,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       *buf =3D chap->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
>
> I'm really confused about both the existing code and this fixup.

Mostly just to keep the original style from the fixes commit from the host =
code.
7e091add9c43 ("nvme-auth: update sc_c in host response")

>
> Why isn't chap->sc_c directly passed to crypto_shash_update here?
> Why do we need to memset buf when only a single byte is passed to
> crypto_shash_update?
>
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > -     *buf =3D sc_c;
> > +     *buf =3D req->sq->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
>
> Just pass it directly here?

We can directly pass it. The rest of the code is copying data into
`buf` so I went with that way as it matches the existing code. I feel
it also makes it clear that it's just a const input and we aren't
editing it in crypto_shash_update().

>
> >       if (ret)
> >               goto out;
> > @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 =
*response,
> >       ret =3D crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->ho=
stnqn));
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       ret =3D crypto_shash_update(shash, buf, 1);
>
> just have a
>
>         sttic const u8 zero =3D 0;
>
> and use that here instead of the memset?

We don't actually need this memset at all, it's a mistake from my
rebase, I'll drop it.

Do you still want me to just directly pass req->sq->sc_c in?

Alistair

