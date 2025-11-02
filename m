Return-Path: <linux-kernel+bounces-881860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61BC29153
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5475D3AFB49
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3022424C;
	Sun,  2 Nov 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQf9zryt"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D0EEBB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098677; cv=none; b=Icda/w2LXpEyjigBr052G5UXFsiV++uwygxud7vwYVN514JHuKmCPtNMomjjCV/C5AU7X9kdiyV+AXlah27Ia4QQt1P+2/5mmcAo84o5DbodS6+QCNy6EUTGZocFCpgtumOS2MVfcFhs6xDf+2c9R8tHro6pCfRRAll9rrqZrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098677; c=relaxed/simple;
	bh=IVGRhEx6SwwcuiB/43BUyx3KBlWNJ/Z9V62kRKtkTWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTqYAouLQytYn6j5oUgtuIdarykI+FJC+3SN7FtprWj/+MvOJjTUO+cTvZHYdrSHyeYBGlvWwcCtlrPcm4swEV5mXdKoCew6cDO+6YWzsnG7uDqKM2w5apZYvJ1s5Rj0i9TKALxJ5YobScOVDFGYsRHYzuL99t2IEu7qbJQDPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQf9zryt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340cccf6956so587030a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762098675; x=1762703475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8zabFFXO/kK05h5IRuopTuEr8QgfbyLWlJrEPONgeY=;
        b=VQf9zrytheMhxs5YMPKkJdiLX1HAcVEvvMLEaqi1y4ix0raiW5BBki5mdeHWMTBaG2
         5kKdbiEKBw6fUP8n0euuwvs2ukubvZO4ZHYrc4TSTqOid6X5TQVfCSTMLaU8l42fDuRS
         h1w59tpgsMJBSwff1LbdKkI+USEoYRP7WXnKuumYDvyewtrhbFJRNaw8GhI33si5dqzt
         HZ67jLhNwEXkGZxrW0KZ11fe1T6QB6hNk34r3Mg1lOb+fg8EqatHxcqu1jyq3nG+raQB
         J+OPQbkCewc3jylay35DVrfIkP10k9JJvxRXmczhR6DnnVPdHUblSSIYeVH8YnRgSCcv
         7+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762098675; x=1762703475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8zabFFXO/kK05h5IRuopTuEr8QgfbyLWlJrEPONgeY=;
        b=S6kmyRKkVf1RVtaCZmdS/kBlnbV1ir1NZBKevCKO0sy3N3eeocX99j6J71puNcCANL
         cigVDM2v0ZEMO6Gpz/Z+5M+r192Rd0XBS14e/47xe3t7WqvGVAp+uJ0m6V61+JBClZrk
         LCeynnNX43v7zbiMX/p63Jj+ojSX67NqqsR258vJ2XfK3qDTKwCihJYaIuLUDHerDWif
         TwKOwzZOEvKCBBZqU3CNpx/sbmNM/KeIbL0qgYCcBo4ZHPhKiqXJxP8iKXl9/CqaCgPg
         20OwINR18wef6NasUW04jeClOvKqyNH6EgMGsgkwGPUgb6ZCpPauLVhdEYwsQ/b45Ido
         J57w==
X-Forwarded-Encrypted: i=1; AJvYcCWUEjCcbrUT/Q2iVIiAqQRB672aGQFrPxDUQxgKuAkezNfi5ELemkV6Kkhj+SgOiNkZsvHEvLfmoWgO3kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qQ1iHJI4d68JyDXzJ6Bs8pxi+4HAj020YGj773OJgGUHxk2/
	NYQGm8hAS9Gg9210nQK2mvE/BIO4Wl6FixgDqxCz2G/7IJqKhNZZ4HtxkT7EG3+Qp59MZi2BnbR
	2kxIecENEdurY3em63o/D4yQUn1/gTkq1VA==
X-Gm-Gg: ASbGncsuFkFqTh9AiKjeewaxP2x1lkUTNOpMBugPz+paNUzJpCiphMOLnc1cpK0gasm
	TRn4Tm7Ej7ZYGzWl4kFOok86CbHHuOTrOPrnrmFwkNeigVAW6+bZy3rWR0m/NYBuYkQc3t7eYSj
	8r/3+804peyJsxJwsa5CVxfRN9QPs7wAkUgu2daxDqee2+656eTtQC5YuTlMmenOwaHbpKM9HW7
	jYk6eMZg2urnTdiC2zDA3ZwIyKIo13N4FjoPnYnVDQBfkHM6Y8QLPE5VaaWIQX7yqEmKfTxbw==
X-Google-Smtp-Source: AGHT+IFTwYjObHjVACXx+yKhmx3nHerpwqmx/UegK6/vDIN0wNRsze92crbnrrslfRfu6uaTLgeVSRptXrdqwClZN5M=
X-Received: by 2002:a17:90b:2e07:b0:341:194:5e71 with SMTP id
 98e67ed59e1d1-34101945f39mr2615733a91.29.1762098675493; Sun, 02 Nov 2025
 07:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101163656.585550-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251101163656.585550-1-hehuiwen@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 2 Nov 2025 10:51:04 -0500
X-Gm-Features: AWmQ_bmS4T2uL37JePpWdJiTenPBPVlMVaI2XJrFASO8Jy7GhhDEL4pW3BmfvMc
Message-ID: <CADvbK_cUA1TR2+=-k8iUu=y6rxEj7Qn+EcvRzKy7xkAhGrE6Ww@mail.gmail.com>
Subject: Re: [PATCH] sctp: make sctp_transport_init() void
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:37=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wro=
te:
>
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
>  net/sctp/transport.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> index 4d258a6e8033..97da92390aa7 100644
> --- a/net/sctp/transport.c
> +++ b/net/sctp/transport.c
> @@ -37,10 +37,10 @@
>  /* 1st Level Abstractions.  */
>
>  /* Initialize a new transport from provided memory.  */
> -static struct sctp_transport *sctp_transport_init(struct net *net,
> -                                                 struct sctp_transport *=
peer,
> -                                                 const union sctp_addr *=
addr,
> -                                                 gfp_t gfp)
> +static void sctp_transport_init(struct net *net,
> +                               struct sctp_transport *peer,
> +                               const union sctp_addr *addr,
> +                               gfp_t gfp)
>  {
>         /* Copy in the address.  */
>         peer->af_specific =3D sctp_get_af_specific(addr->sa.sa_family);
> @@ -83,8 +83,6 @@ static struct sctp_transport *sctp_transport_init(struc=
t net *net,
>         get_random_bytes(&peer->hb_nonce, sizeof(peer->hb_nonce));
>
>         refcount_set(&peer->refcnt, 1);
> -
> -       return peer;
>  }
>
>  /* Allocate and initialize a new transport.  */
> @@ -98,16 +96,12 @@ struct sctp_transport *sctp_transport_new(struct net =
*net,
>         if (!transport)
>                 goto fail;
I think you can return NULL; here, and delete the 'fail:' path below now.

Thanks.
>
> -       if (!sctp_transport_init(net, transport, addr, gfp))
> -               goto fail_init;
> +       sctp_transport_init(net, transport, addr, gfp);
>
>         SCTP_DBG_OBJCNT_INC(transport);
>
>         return transport;
>
> -fail_init:
> -       kfree(transport);
> -
>  fail:
>         return NULL;
>  }
> --
> 2.25.1
>

