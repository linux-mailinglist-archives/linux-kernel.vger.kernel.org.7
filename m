Return-Path: <linux-kernel+bounces-887710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0333C38ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63A4434F15C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97421146C;
	Thu,  6 Nov 2025 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luiN5yY6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5518EB0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397735; cv=none; b=Wn31KWma7TB2M5/beELB6cBKYsQGmHjv1ITxaOYblqVNTszChxy74tPzbBPgRUg2GcY+UXre93T006/VAH2hclb0Djpd5sn6F7Qmm1XhOvxiE+4Vnxqqbeusz03Y0V8K+S6BoRhM2gT92vadav02TpkZVRva5dBwwEcdPMHMX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397735; c=relaxed/simple;
	bh=C3x4YBb3VroXZ04dSH+6b1wjFsCPs09Fm33UEihKV2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj/RVEqSfc2/fZZKus/7SX0fCGn/0pUZU72T5HTxVXA62N/7oZFb1/wbpJ8x4DK+LcG9btF4EJNQ1UaRDNWpp9WA0xMZj9fMfrp3zsTTFrshofnWWL/UweTHmchGQaKgcYPNWqZxC7/u2TxZyXEje5yuV6XUbQNSlHF8daK9ABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luiN5yY6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so492952a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762397732; x=1763002532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlk/ug0JgPSr2/LEI0WtcL8rXm2ERpWKIu4XhoKULa8=;
        b=luiN5yY6C2N/BvZ6j6iEssxjJ3tp3DD14xns1AFTcav/pYuZ9hLnB78VROiGIegsjA
         D2Opb/qLkURod3DC8RcB1yifiwFnmAl1XjmAte3TQQU9GIj3eGBq/MgOdOhAyptQ3HQX
         IMYJQxwjAHX42I1+AfCOGJmcPqgiw7d4VU1K3wRUlsiixGdjb56491Z5UcO+R/9H0RNG
         KevZv145X6u7T8wdhumnk6Jo0h5I5sxPNK89I2UK8IKAXtf0scXloxLu7IgQUMQ4WgGg
         A53WXf/ZNwpVp8wIui0qZMEi1ABink0XphcfB/+5SvLx02OxJoCwqpWqMWtL+h3/Azst
         CIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397732; x=1763002532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tlk/ug0JgPSr2/LEI0WtcL8rXm2ERpWKIu4XhoKULa8=;
        b=BcTePuVU7RGGrxHTmgZeL8M8T1vzoRqNNDh9teEnpCD7zgeaM7ondkPcZ/t3w/bmtB
         927IbZNnmofBYQWvVJW4UwePwNu//3vk4CM+lZmNQ31hvr/gKXjs0cqkljsPeYVKidhB
         HP++TFdlPuOzAVMVkSVWOtemwxdzYpbtfh9ZcZ+Xt/fE09+QjcnTvl5A6mprAWmCOxid
         1NtLc5PstvWBrt3qEZgHuolBssXY1J6ym5Vnr9yVTT7Y/VE99bJjadT+RO84wmb9xyva
         dKzTpUwmM15QfwGpI3xg3R5mklMia2Sj15I4bsBQsXM45fVQyqmbQf2qCacaFRAXOObe
         ETrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVpQUykaTjBfHgMSZIumds/Qn/SNUDsnndkN1fRtat0oJ0HGd2zjLU/yebd+1wFMtM8nbs0Pa15FqcynE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLSnsT3gUY7nEogef7q6XCpDU6Tak+tLEimfETRh2oR6Tho1m
	FOMw7XKNPdxDZieZNzygqTdicEp/tGpb5VMLPAVuGk6oV9pqbKmaZ/MyPY5W6tAwxO8DrF2EwcP
	DcvdXGVTdz7aLIQxxnU/BF5OTORQp4FM=
X-Gm-Gg: ASbGncuhx++9pnrdOVGz3XgOFp7EL7IGDXwNho7Gshec14v6Ipnt6QhIRyEEra356bp
	z7uQp8209N1O+Xf4IRy7dxRLgzE49E4d+nl8OWEIzoudoNTqIfNCh107p5hM+W1QSMUOTyo+Wid
	KGcV33DWJNn0AfZQ7s0Jl9DFma7cDkPhx8A52RrbOLNYi8wPSPYgm4FDnWjHjjZNxwd2SJ69niG
	hpUxj9zbXm/j26hrLhpHPU6WyOf/cnLSd2RuFJpa6lM+goo+Bpxeb9A5Ikx8FOWmRPwMOrSmR2a
	RHn1ckZ2kNG3AbI+8uiZMfbyQA==
X-Google-Smtp-Source: AGHT+IHA+7AGTg05JB1vLt2XrUjagvVvtpOglKMuwX3Og02E6bEEagClfceX/hELr6wRF2qmpna20dsF9kRJoVyrtFY=
X-Received: by 2002:a17:906:f58d:b0:b72:52c2:b8e2 with SMTP id
 a640c23a62f3a-b72653b9b85mr522952966b.26.1762397731465; Wed, 05 Nov 2025
 18:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <31a4e5f0-43e1-4aed-af84-715aca53fa1b@suse.de>
In-Reply-To: <31a4e5f0-43e1-4aed-af84-715aca53fa1b@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Nov 2025 12:55:05 +1000
X-Gm-Features: AWmQ_bm_EKk5XRW7XS4RKJsgEiVgBQB3O8X5XRCIc4C-Nz9KT0_E157CqAjKTng
Message-ID: <CAKmqyKM+ntRgu5ovaWh6c2ffTG2k=_YBTNapBbm2C-BoaNayXw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:29=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 11/5/25 00:14, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> > the sc_c variable to the dhchap queue context structure which is
> > appropriately set during negotiate and then used in the host response.
> >
> > This breaks secure concat connections with a Linux target as the target
> > code wasn't updated at the same time. This patch fixes this by adding a
> > new sc_c variable to the host hash calculations.
> >
> > Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v2:
> >   - Rebase on v6.18-rc4
> >   - Add Fixes tag
> >
> >   drivers/nvme/host/auth.c               | 1 +
> >   drivers/nvme/target/auth.c             | 5 +++--
> >   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >   drivers/nvme/target/nvmet.h            | 1 +
> >   4 files changed, 6 insertions(+), 2 deletions(-)
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
> >       if (ret)
> > diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> > index 02c23998e13c..f54a1425262d 100644
> > --- a/drivers/nvme/target/auth.c
> > +++ b/drivers/nvme/target/auth.c
> > @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 =
*response,
> >       const char *hash_name;
> >       u8 *challenge =3D req->sq->dhchap_c1;
> >       struct nvme_dhchap_key *transformed_key;
> > -     u8 buf[4], sc_c =3D ctrl->concat ? 1 : 0;
> > +     u8 buf[4];
> >       int ret;
> >
> >       hash_name =3D nvme_auth_hmac_name(ctrl->shash_id);
> > @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 =
*response,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > -     *buf =3D sc_c;
> > +     *buf =3D req->sq->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
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
> >       if (ret)
> >               goto out;
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/targ=
et/fabrics-cmd-auth.c
> > index 5d7d913927d8..16894302ebe1 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req,=
 void *d)
> >                data->auth_protocol[0].dhchap.halen,
> >                data->auth_protocol[0].dhchap.dhlen);
> >       req->sq->dhchap_tid =3D le16_to_cpu(data->t_id);
> > +     req->sq->sc_c =3D le16_to_cpu(data->sc_c);
> >       if (data->sc_c !=3D NVME_AUTH_SECP_NOSC) {
> >               if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
> >                       return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
>
> Hmm. Storing 'sc_c' directly does away with the need for the 'concat'
> controller setting.
> Can't we just drop that and use 'sq->sc_c' directly when checking if
> secure concatenation is enabled?

I think we could drop ctrl->concat, but I feel like maybe that should
be a merge window change instead of late in the RC window.

Alistair

>
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index 73da823a91fb..20be2fe43307 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -159,6 +159,7 @@ struct nvmet_sq {
> >       bool                    authenticated;
> >       struct delayed_work     auth_expired_work;
> >       u16                     dhchap_tid;
> > +     u8                      sc_c;
> >       u8                      dhchap_status;
> >       u8                      dhchap_step;
> >       u8                      *dhchap_c1;
> Cheers,Hannes
>
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

