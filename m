Return-Path: <linux-kernel+bounces-889516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E156C3DCD4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05E63A8DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E0319608;
	Thu,  6 Nov 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQBhQs9l"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F42DA76A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471114; cv=none; b=cagpQTVteKk5CkN/a6gk+OVFBHsd+mV3ZW0aNdIUUuZc9B+8vAHJRPoLbuJ0c5qC80jLP9NmEK6EX3WpTF7hMplUSBmb3qiOkEgliyJb/q32d6sRROYEX5vi2076NGZpKgCw25s3zTSidJEVWoLa3cIQCcXYGEDI7rRc3D8YLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471114; c=relaxed/simple;
	bh=pJv4zqeHNRTU4obBtaUTIfBb2/QOdc1xoGqDwBpqYyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIJWZf2hBi6Odjw2ZYx+mu2UKWZKYSDgUyGSuPrd5hCw0ZltqmzFCLvRkdRk1aJugst2s3R3fO2jwVZt9FTLgCQ6+jRpI8RGDnIOP2VbCmaX4Q37zixiHNd3wI1hsO5GYum9q8eZbwrLzsSvFSzMKQa17zrfbPVvN2/eUuV0dmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQBhQs9l; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so291671a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762471111; x=1763075911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOUOWyN3SQvZiS/RbaKwiZi9YRB0sBMbqUhJ8OtdPmE=;
        b=VQBhQs9l8s29JcsXcZMvKXE7GzuL6auflRRAU28ptQT12CENWV5Kha5RYcIWR6B5t5
         YBau/CCYY97R3+paGz+/7pmXJlSHCq3ivGJ0ghSdlG/b6pq6h++AU78z5QxI20YDBnnI
         2ne8QZZSBU+9z6Odpjtm4R5ZODQu62JXOo8TfO3zKmvYlv6+mDIAtsiJlu5jWGLh/BCz
         CGFnrUnmt6hejFxjUqo5frQpOeznQy72Ess9GLUm04+ORq6PFDnRhTQNZlinTrmEiSiS
         8FuRxP6RhwHu5QqijXIKBXUN1fhuFq6ThgBQKtaxc50trwD5BK3x2wsAS/wLHKwGkksd
         lR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471111; x=1763075911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOUOWyN3SQvZiS/RbaKwiZi9YRB0sBMbqUhJ8OtdPmE=;
        b=sgHMWIIyyI3ZqS/Bdrd6pNEyg0lHZRankTDJGCfU1r4jUddngHLix8jcGjkdRDMECd
         Dzsd8Vb3qUhZyjzPiW4V2bnHr/cZnRy7pPoCp/u1kK3KwMtJ/mOvkrRpMaQoKgU7iZ5F
         MlDEc8k4dYZNfcDajnfZ9X+hYOYofxB0fFOR9nmNUj4ro/K0W1rfvCFne8/EUFw3Bsxu
         9qcejI03eT0AWSV0VIaiD/cpANrixeOi1cicu6ahInpMu3FaNuvKbFiSpApE1bMuaPHi
         aX6gFfzqS6rjcgxNq/Rs/JkLcn2h+Cx5LBGFJd+6UKOgh1Dcy6TWxLJXQfuyGnZ9hdf5
         tLUg==
X-Forwarded-Encrypted: i=1; AJvYcCXMQ1gIMZzwG2etRXDSY37Nxeq6T+nZ1bq5+N2Ms2Y8Ko6eAGIlDB9IDljSxvSJuFBN8ZXVzlam7qR+8Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ugIJAdb5bLEcmpgGQhCy+4TsIChGuwFXnec0R2JIDd1a0FfQ
	jv6BNgVGN0jJSeTIErFN33g00+KxlccwMwOYl4is+Mu+CwXy75Zqs63U8WJ4xYIJCw5BcVwYXq5
	fcZm8G7aJdagQ29OZxhDkh9VmZ0Lv6iQ=
X-Gm-Gg: ASbGncv9zqKU3J8mzQafPv0PeCzI4UVmFu2v2aknC8cFD9k5nvInqPjKviE75cYc1AR
	AoHvbfNw6Jjg+0v0bBmlqcUiUhuUGAP/ktRCeTF2keqEBPYHQ6vYWfOXUOJmtW7zDHDIGWOcx/3
	CTNY5XI7gdR0yVPHI1Li4XxmpIZ1r/OALnPReJeiLkZvA0oLCkkZS55B+s5i6m462pNsGMevZJt
	1NGidBPIsrI/qJ34bphzIVprbwylyihUCadlf984K05MTpp/jin6GmqWAfSIMhUL2tbEtWm2HH0
	NwrAHI4FeqP4yyg=
X-Google-Smtp-Source: AGHT+IFQ3p9ssmPv8Jm7gFsQL6RL6oReE2y+7vSXZxGI2qjE3DMYEWlLAqv+wQJCw4Kqxr8DuM1E/gWRvm7feQCSeeI=
X-Received: by 2002:a17:907:6e94:b0:b72:6fec:5d0e with SMTP id
 a640c23a62f3a-b72c08dca97mr94592666b.13.1762471111104; Thu, 06 Nov 2025
 15:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
In-Reply-To: <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Nov 2025 09:18:04 +1000
X-Gm-Features: AWmQ_bm5LInA_pSlrz_9pdkVaeGS-Cw3yi_cxhx174Xg7NOZ-pKujDIKCUNvg0k
Message-ID: <CAKmqyKOMFdKqcYN1Nuz224nczaQMmXhk=H6Vx6n+XLRpeVQdNA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
To: Martin George <martinus.gpy@gmail.com>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:05=E2=80=AFPM Martin George <martinus.gpy@gmail.c=
om> wrote:
>
> On Wed, 2025-11-05 at 09:14 +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> > the sc_c variable to the dhchap queue context structure which is
> > appropriately set during negotiate and then used in the host
> > response.
> >
> > This breaks secure concat connections with a Linux target as the
> > target
> > code wasn't updated at the same time. This patch fixes this by adding
> > a
> > new sc_c variable to the host hash calculations.
> >
> > Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v2:
> >  - Rebase on v6.18-rc4
> >  - Add Fixes tag
> >
> >  drivers/nvme/host/auth.c               | 1 +
> >  drivers/nvme/target/auth.c             | 5 +++--
> >  drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >  drivers/nvme/target/nvmet.h            | 1 +
> >  4 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index a01178caf15b..19980122d3d5 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -492,6 +492,7 @@ static int
> > nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       *buf =3D chap->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
>
> This memset in host/auth.c doesn't seem to serve any purpose. Also
> given your patch is intended to modify the target behavior for sc_c
> handling, maybe you should restrict the patch to target side updates
> alone.
>
> All the memset cleanup in both the host/auth.c & target/auth.c should
> ideally be done in a separate patch, and not part of this current
> patch.

Yeah, I realised I don't actually need any of them. They have been removed =
in v3

>
> > diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> > index 02c23998e13c..f54a1425262d 100644
> > --- a/drivers/nvme/target/auth.c
> > +++ b/drivers/nvme/target/auth.c
> > @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> > u8 *response,
> >       const char *hash_name;
> >       u8 *challenge =3D req->sq->dhchap_c1;
> >       struct nvme_dhchap_key *transformed_key;
> > -     u8 buf[4], sc_c =3D ctrl->concat ? 1 : 0;
> > +     u8 buf[4];
> >       int ret;
> >
> >       hash_name =3D nvme_auth_hmac_name(ctrl->shash_id);
> > @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> > u8 *response,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > -     *buf =3D sc_c;
> > +     *buf =3D req->sq->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> >               goto out;
> > @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> > u8 *response,
> >       ret =3D crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl-
> > >hostnqn));
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> >               goto out;
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
> > b/drivers/nvme/target/fabrics-cmd-auth.c
> > index 5d7d913927d8..16894302ebe1 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
> > *req, void *d)
> >                data->auth_protocol[0].dhchap.halen,
> >                data->auth_protocol[0].dhchap.dhlen);
> >       req->sq->dhchap_tid =3D le16_to_cpu(data->t_id);
> > +     req->sq->sc_c =3D le16_to_cpu(data->sc_c);
>
> Given sc_c is an unsigned 8bit int, is there really a need to make this
> endian safe by calling le16_to_cpu()?

No, it's not required. Fixed in v3.

Alistair

>
> -Martin
>

