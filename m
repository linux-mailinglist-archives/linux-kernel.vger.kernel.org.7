Return-Path: <linux-kernel+bounces-888553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E703EC3B2CD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8482D566410
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB532AAD8;
	Thu,  6 Nov 2025 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiXqHk7r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54828C871
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434355; cv=none; b=Yt80+LGcFAGB8ixls+uXMdRT86I33UcPDPFpXSJHMuC5PkFow4T70k7IoKs3ZUNuSkfXLoYggUej7CFb8kxftUDUywtoj6eZ1xT07Cye1IhUAH0hg96RPsKjxs3E3Z+xduqD8HciOgNiZfYpNKUE/qkcnWj0QKAfLj60biAsKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434355; c=relaxed/simple;
	bh=VU60D2UfixiPsFKpqgiffnpmo6ToMl/72XAmMuxmIgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VuN9dIID6+vz+JG75t8lK+LmJ3Mg2ciJGCvWXZXheWkG72iOolz+aQs4iHfS4c5WpRZlEP0RAoXb2agwmYi4/0yyNeHq76vE5li6rsVeoHAO4r/aKQ7lK2qYtsZG4adIzIdxPAU2yLr1B0Dif8/fGoDN2yhr7TRMxPK9rhPLy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiXqHk7r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2952048eb88so12446685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762434353; x=1763039153; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mgw/fPrHMpJPDRmtQHXy3qFjXzsQgXrjXttBI0uY/iA=;
        b=EiXqHk7rjRFP9j/sLOV6DBGQngoqm/eCr+Hd+6dp7hWFaS45FqU0HXPnKsUsyyq48+
         Sfh4WLfugpmpMVC4yjaJ5DB/IsQrGGh3Q3YSjQZydP50z5cG2JWeV0YSfxiJpsuC0PMx
         mneg0y+ws0pRPIqnEl4nYq4W//HTlqNrVAGTQHJEhSOpfEsKFmOvcjp9zH+40wNY+TI8
         HmvRaR2dRj2XPZMuNkO4s0HMDDHNWi24InhayXKWkjBxtTePKcxA30DU4dspl5Cog/fQ
         e5ibhTrLC/wN5lfSU4x+M4reK0hhaE9rVPf0tPx1gCWisYcLTwsC4cctIOsOzc3+o4s2
         1Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434353; x=1763039153;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mgw/fPrHMpJPDRmtQHXy3qFjXzsQgXrjXttBI0uY/iA=;
        b=hymWPzrFKH1JnrX8ivgxPT5+/Mbt+UJ9e/f836sxyvll+MpsrgiSuHmHz+m4BlImXy
         gqDyIRiYmxI219w9K8W1q81qzmfbadLxThOSRinQulHSUDWIiu7ymZV6plscBD8RNuFV
         a73cU4RKl5je7sQ5fkQuZGqgauktdXkXn2T6R9KDwGiaPuynPXYi9z05kSzPQAeMJhtk
         cTCr+LZjdoodh07GZJxDUpZnVQgFgjr53iH8w880P6rS90abc/th39GZHL3UAruZ6XG0
         qRoqQ/2A3NPW0hOooLEXrh/desg2lIBPpuYos+KCeqn+zpRRQ+ylN9HWNSgv7HgXXeSd
         PODw==
X-Gm-Message-State: AOJu0YymB/6LXA/TPiH3hfQdsWlcauGLEXsETgzzfr7E4CEuwnSkhKys
	noFquNe/i7aU4ppcrnQIZ3qj1RjxCSGcFqqbd7xj+54jkE8IORXOdaEH
X-Gm-Gg: ASbGncuWnuOwpCuPlRayCns9yJI6hHVnjIOoGkqVZpFMBwpfaOagj5FX0ZCIYgXt+CN
	/VndVvAtdyT4GV/IaEXJXGkk6tjpNKB1x2LL15dd80ls+3TMecwyvxjf2DcaF1AbT0YgCdzGUtL
	sN09M74k/QIcHaxFJUrRB6omtQ7nmUkfGS4yKBt72PMbd2ndLGKgwdPifT5d/JsELGDL/tMo23k
	CEwRIXCFI7qGY7YY6K9fbVAnejm6Do+KQwOpN3blYlAlXoWa/eZMKbeml7BRikFDZa2LwDZG22j
	ksYKipo8UKpy8k+TsgplsWwLR8r1icKejZa5uyKSWaVdhyZ97H1sLhpFqLLldZ+XIp99vIayqfX
	LuQW+7AzetcyYQUzzMUxFNXCSe+VG72oSW4qfmG7k8Le002Fxo93RsCd3WBJ6NT/y430qf99O5h
	VGsEdWPo5seytYcRA=
X-Google-Smtp-Source: AGHT+IHqcc5CJfMeCuuz9hqI9HoVghkGsu7NtrT1o4XJ7ZdhguAZZC3/CDPR1sbAfdfYDDOUGTjUOQ==
X-Received: by 2002:a17:902:f541:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2962addb63emr97589505ad.61.1762434352926;
        Thu, 06 Nov 2025 05:05:52 -0800 (PST)
Received: from 10.0.2.15 ([223.185.133.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7445dsm28265955ad.62.2025.11.06.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:05:52 -0800 (PST)
Message-ID: <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
From: Martin George <martinus.gpy@gmail.com>
To: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, 
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 06 Nov 2025 18:35:48 +0530
In-Reply-To: <20251104231414.1150771-1-alistair.francis@wdc.com>
References: <20251104231414.1150771-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 09:14 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host
> response.
>=20
> This breaks secure concat connections with a Linux target as the
> target
> code wasn't updated at the same time. This patch fixes this by adding
> a
> new sc_c variable to the host hash calculations.
>=20
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
> =C2=A0- Rebase on v6.18-rc4
> =C2=A0- Add Fixes tag
>=20
> =C2=A0drivers/nvme/host/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/nvme/target/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++--
> =C2=A0drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> =C2=A0drivers/nvme/target/nvmet.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A04 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a01178caf15b..19980122d3d5 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -492,6 +492,7 @@ static int
> nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 2);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> +	memset(buf, 0, sizeof(buf));
> =C2=A0	*buf =3D chap->sc_c;
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 1);
> =C2=A0	if (ret)

This memset in host/auth.c doesn't seem to serve any purpose. Also
given your patch is intended to modify the target behavior for sc_c
handling, maybe you should restrict the patch to target side updates
alone.

All the memset cleanup in both the host/auth.c & target/auth.c should
ideally be done in a separate patch, and not part of this current
patch.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 02c23998e13c..f54a1425262d 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> u8 *response,
> =C2=A0	const char *hash_name;
> =C2=A0	u8 *challenge =3D req->sq->dhchap_c1;
> =C2=A0	struct nvme_dhchap_key *transformed_key;
> -	u8 buf[4], sc_c =3D ctrl->concat ? 1 : 0;
> +	u8 buf[4];
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	hash_name =3D nvme_auth_hmac_name(ctrl->shash_id);
> @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> u8 *response,
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 2);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> -	*buf =3D sc_c;
> +	*buf =3D req->sq->sc_c;
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 1);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> u8 *response,
> =C2=A0	ret =3D crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl-
> >hostnqn));
> =C2=A0	if (ret)
> =C2=A0		goto out;
> +	memset(buf, 0, sizeof(buf));
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 1);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
> b/drivers/nvme/target/fabrics-cmd-auth.c
> index 5d7d913927d8..16894302ebe1 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
> *req, void *d)
> =C2=A0		 data->auth_protocol[0].dhchap.halen,
> =C2=A0		 data->auth_protocol[0].dhchap.dhlen);
> =C2=A0	req->sq->dhchap_tid =3D le16_to_cpu(data->t_id);
> +	req->sq->sc_c =3D le16_to_cpu(data->sc_c);

Given sc_c is an unsigned 8bit int, is there really a need to make this
endian safe by calling le16_to_cpu()?

-Martin


