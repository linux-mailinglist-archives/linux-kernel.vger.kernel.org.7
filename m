Return-Path: <linux-kernel+bounces-843657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC0BBFEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40483C4B32
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892B1E835D;
	Tue,  7 Oct 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxBotesK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14E1D6DB6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800179; cv=none; b=NcIfixpJdlR5clV4oMLea0aESG+zZX+M6MQOyHqXUrYHNWLIbY/kOQIzYKNG0xIfc+ufkago5+5qdFMV69fUjR86+wfWJmZYCEp6vZOcPjgfKTaB1CFlUDQuD7E3yckkBXynqGyAHiAI1pYnllbynT/yZ/bihBpUkC+qsJqttWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800179; c=relaxed/simple;
	bh=00hx5O89+8fvzy4PkP6xQKJCZLvcQoPJKp5vdlCLTCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD7jULjxmWRRKl3z8HVC1S08vlmwdbV5kULlluBhFnZtSq/WtZcq9KF0Uvf6o6e5M+a1C1qM4oXEBu/dgiCmxjEojnRBO+ZnIGGygTLypWzAvow5bX6e3zbVin1FxELpryYuIZrnY8byy1AX2MP1rX6TG0xlFhN9D+mxmvTGKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxBotesK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so6719795a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759800175; x=1760404975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=cxBotesKVT0kItaCi+pL79Rrdy7oHT/uuYEDZPxBFct+abfWG5d4HATokKErrW6Dov
         8LWvTC2r6AiCf/12ib4PyDnFYyo1rbz31IcEhzWeCLYpaSKEUVFq4CrOvMZcYr4gwbPH
         Rch5xtKR2oqwJ17lxy9L6RGmoGAb8ObcoCauAwoIW0IpqpzUe2Sni6rQnGMGgWvZ15tO
         FKv6HB/L4snlgopisxw6TsUTVEv4ItS6cxhYcXh7/Eh02tMMmtELMrwrTFJ4VNZmnNIH
         +w65691ilDaIiDGbzVQ0QX2hw5fXhO4qN25lkV5AUkqGod9x0m6/typnjfSkVxjdx92m
         rawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800175; x=1760404975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=rOj1mj88qFQybXviOVKmxWocZNDJoEXBfp4tEpToB/MVkQHVV6y0skqAKX47BrdFBF
         rH2Qbc9kDf+/wHir/824GmBh0ZljUf9K0JMnz8s/qdj6hB0qOlArNSzNuJCeR734D0NZ
         OQkRBZ6bH7GugsLcMEvsaEA/znd7tD23+ZfEk0W9wSPzl0NGD8Ff8Y1hlEJ8jMe0cubX
         kLi9Wbmn/69LSc3C2pH1mtWiuZ5jfb6rDZlxOoIpEmWxxDjUqTSX7IZmRW/z7SqMPoXB
         8tpxM6YY7th8EJBABH/9yNJvpErXO+McSimU5pKUSIOViN2k8IgP/b+E1Uwhhgb4Qo2n
         DpLg==
X-Forwarded-Encrypted: i=1; AJvYcCVM69h1fcrNTL+tzwhQgenZleh9e/Z9dJfy1YDPkAx8CvVwVIDHbpfWfN7jFxsGOS6mtuhyIT1ZgIzajQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHtl4U93TvdqfvfUXXZve/R0nM/C+swcFKKKE+mtlxtCQ61DSZ
	0ApGxXBPlyHnkmDJ6aowmBjO2LVjN2T7HsoNaiidfdLxRGCSE/OoNT4wBSHlajG4eK5aCZBl/cU
	l4i7l0PKX6uwnulbhTRYZDiGtZVVC1N8=
X-Gm-Gg: ASbGncucNBFezLQ+wl3MRj09z9VJCyTxDDFvHWh4B0aFUkVd4gT29pklH2VGc7Vn5+6
	gpbk7jq2CmGpv8/hxEzJgCCXa/aPyejN8T4iPT1sorZMVK0ssJN8C0P3liqKAJEkWUIkscxIyfo
	ZFJpzAtK1CnidbkA7fZioB2BazQRA3+9HxkCzZnQ5LpzmSXct7x4qzsPrr96wReLY8d1y7fQ+7A
	BvYEiWRGF5Ol26Eye9Qr6Uukdgjm2o9wCgtJWEMZPJWwYDrOktVahqeT04u3A==
X-Google-Smtp-Source: AGHT+IEqVioe1S+GxtMPUCva4kG5CmfdDTTGDPNdiniLUblABnKsGagheixLUyeC/Xqdz84Zg3zCalpzx4OwzsmlUYQ=
X-Received: by 2002:a05:6402:b0a:b0:638:d495:50a7 with SMTP id
 4fb4d7f45d1cf-639348fa973mr13226165a12.16.1759800175262; Mon, 06 Oct 2025
 18:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-4-alistair.francis@wdc.com> <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
In-Reply-To: <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Oct 2025 11:22:29 +1000
X-Gm-Features: AS18NWA3ErD_gS2cWuFH4B1EU9R8Gp49Hxw1eP3L2D2MX2i73c7hEabcslLmzvQ
Message-ID: <CAKmqyKMRXKJTQciiqjPXYAFa6UUJ6xkTSdEfU+9HnyNTOx-BxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:16=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 10/3/25 06:31, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > To avoid future handshake_req_hash_add() calls failing with EEXIST when
> > performing a KeyUpdate let's make sure the old request is destructed
> > as part of the completion.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - New patch
> >
> >   net/handshake/request.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 0d1c91c80478..194725a8aaca 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, =
unsigned int status,
> >               /* Handshake request is no longer pending */
> >               sock_put(sk);
> >       }
> > +
> > +     handshake_sk_destruct_req(sk);
> >   }
> >   EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
> >
> Curious.
> Why do we need it now? We had been happily using the handshake mechanism
> for quite some time now, so who had been destroying the request without
> this patch?

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Note that destroying is mostly just removing the entry from the hash
table with rhashtable_remove_fast(). Which is what we need to be able
to submit it again.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

