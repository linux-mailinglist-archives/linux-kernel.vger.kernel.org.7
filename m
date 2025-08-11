Return-Path: <linux-kernel+bounces-762185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD3B20316
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02063A91DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812B2DD5E0;
	Mon, 11 Aug 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC1/WLPH"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E592DA774
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903968; cv=none; b=doL+Sz3sK0aTvvgRfY1gmh0ngEnBlKbeSuMO21MIowZ5Gsg9m5JGEm8mBlgEfCuNaepwkGmIGwa97miKuTY1TXHPtpU05q+5t8/H11RsS9dgqUlLCnqBO8Ne0qsjfZo6Ozxw+zjj1DdSGOf7oS/PpKwoFXMIYOu0gYWV/4Zgpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903968; c=relaxed/simple;
	bh=eOcXVHRq7KcT5QV7lddFhfB5s66umFv3YrBqQ/TX/uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpW5FiRjMw4+yvLU6hfdhk1ivORPnjDCxShEfxuVpERQm8EGa/1KpzIqZNrdeWmH4c4NVduBI14bdlIIuk/dRYu2FN9E3hsM85JyphXJGc8hTN6dUUIcsMzXuM7Ay4dCuu87Pn0xKV9sOrCcMFJyy3eBVUMmQ8wO4/05MU1t4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IC1/WLPH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4af12ba96daso46837571cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754903966; x=1755508766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X3+VyeiU1OgsV7atWhvLrxkvJsIXxj9Qgw0FX6QMEE=;
        b=IC1/WLPHof7gy7NDluHwPQCGGRp2bnxoJO4nLyeMuVaA16aD3gkdia/0IJYpGsPeOA
         fDEUWTLRFEY4x/jukbffuRlMkGPhe8jUSuvZ1yPPjOW/OD4TF5PTjoohB8ffB9FP6O3D
         /CJUO7Uqpl2ON+hNvU+owkyFKmK3aoCnsikY4BjlivzSsdtfdFu0w9uROLcP0c3SYJc2
         YJRBkBMz0vykid9wn4+q8Aolv31wwmF694SG9VkAzsE+kqHtqPApSPD5fh2XufQv0oah
         yuXzHBZNPPoD/rayCyX35a5NhVRLO5IKBfSWfiuprwJQLon+moeaW7p496duSTFbMbN6
         qQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903966; x=1755508766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X3+VyeiU1OgsV7atWhvLrxkvJsIXxj9Qgw0FX6QMEE=;
        b=hRUjgxxUUR+CE8uQc24SCzzGLZykFwNMTxLKZwcRVV6bq2BZm7Jkv2GZRaywhSEKHe
         RbM2d5gMQB7HOLalj+upWUnN4B0HTUOdMf9eiXxX8I5XA/BnpYpK4I1gpIskFLS5l/E/
         FQHvH5bihQ+f2dPKAdNMzyvnDviLr21av6DEesmuB7VfkfFGankBSU9gwDYTOsqRM7n0
         zozM9TuWnlrdnRyg8gP1K7WI6I7PfILikp1b8YoBRimvEmu3JAaVduJvwPAUEt6YRrqy
         U8KTcoLTATcSUKD9xjLh+DF8f9oSsIFPZH3B7qrC9Brl5guVfBc6LdJQoAjTcX8IfshQ
         +niA==
X-Forwarded-Encrypted: i=1; AJvYcCW73k7x3wlQuaJ6Le+dZlvgmVwPSDNA56wfUV/YMs4O0YRr+GyDqWSO1W2Khh0xqXcmylfRzfne5nG3cjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOxnW0efpaPhcaa/90EWKZbAtTd2QNMEiSJMk/WQ8zS/WOIJ6
	l9Vajxw5n1HPyWFlxrUzl4bSl9G8FEp7vTwcFMv02kEtb0G+cYqW370xD8lCvtJaHb8weCcngAD
	RqwSCNRXQpqn2whXMdcs1HNO9nUGcbnfFtPMCR5UF
X-Gm-Gg: ASbGnctIqXX77uwvQ37SYcW5KFcUazT9RftfEEL07agM+wAF/pUvtcej6y61xVrGUsE
	f/mlbpo8gABPFzmCxDPFvawTYzhbWNatRVu2umBsyK/Scr4dpnuqHSF4msYsDU3/1UNfhJdyRhE
	ck4BM7SQkEsWBN/OqHMxXSV3UWdMllCXwHbcQQgFGMm0iJAOY26SUZv30zcR+KqTwtukrEseyyV
	m1z8Ag=
X-Google-Smtp-Source: AGHT+IGsGqL0Tet528TAr+FeI8cqB44Iw1Yw7vkXFDKW2y66uKrMwpszv3VtSYrNMrGppCnsouzQ6A2JECoC7Hzay+s=
X-Received: by 2002:a05:622a:548:b0:4af:203f:73e9 with SMTP id
 d75a77b69052e-4b0aecff0afmr124996791cf.3.1754903965426; Mon, 11 Aug 2025
 02:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811084427.178739-1-dqfext@gmail.com>
In-Reply-To: <20250811084427.178739-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Aug 2025 02:19:14 -0700
X-Gm-Features: Ac12FXyDAHXwINvs0_c2V2RB4ZbG2aFo4c_KD22t99jVdd62EqxWa-M4aOJp_VE
Message-ID: <CANn89iLEMss3VGiJCo=XGVFBSA12bz0y01vVdmBN7WysBLtoUA@mail.gmail.com>
Subject: Re: [PATCH net] ppp: fix race conditions in ppp_fill_forward_path
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:44=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> ppp_fill_forward_path() has two race conditions:
>
> 1. The ppp->channels list can change between list_empty() and
>    list_first_entry(), as ppp_lock() is not held. If the only channel
>    is deleted in ppp_disconnect_channel(), list_first_entry() may
>    access an empty head or a freed entry, and trigger a panic.
>
> 2. pch->chan can be NULL. When ppp_unregister_channel() is called,
>    pch->chan is set to NULL before pch is removed from ppp->channels.
>
> Fix these by using a lockless RCU approach:
> - Use list_first_or_null_rcu() to safely test and access the first list
>   entry.
> - Convert list modifications on ppp->channels to their RCU variants and
>   add synchronize_rcu() after removal.
> - Check for a NULL pch->chan before dereferencing it.
>
> Fixes: f6efc675c9dd ("net: ppp: resolve forwarding path for bridge pppoe =
devices")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>  drivers/net/ppp/ppp_generic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.=
c
> index 8c98cbd4b06d..fd3ac75a56e3 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -33,6 +33,7 @@
>  #include <linux/ppp_channel.h>
>  #include <linux/ppp-comp.h>
>  #include <linux/skbuff.h>
> +#include <linux/rculist.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/if_arp.h>
>  #include <linux/ip.h>
> @@ -1598,11 +1599,14 @@ static int ppp_fill_forward_path(struct net_devic=
e_path_ctx *ctx,
>         if (ppp->flags & SC_MULTILINK)
>                 return -EOPNOTSUPP;
>
> -       if (list_empty(&ppp->channels))
> +       pch =3D list_first_or_null_rcu(&ppp->channels, struct channel, cl=
ist);

It is unclear if rcu_read_lock() is held at this point.

list_first_or_null_rcu() does not have a builtin __list_check_rcu()



> +       if (!pch)
>                 return -ENODEV;
>
> -       pch =3D list_first_entry(&ppp->channels, struct channel, clist);
>         chan =3D pch->chan;

chan =3D READ_ONCE(pch->chan);

And add a WRITE_ONCE(pch->chan, NULL) in ppp_unregister_channel()

And/or add __rcu to pch->chan

> +       if (!chan)
> +               return -ENODEV;
> +
>         if (!chan->ops->fill_forward_path)
>                 return -EOPNOTSUPP;
>
> @@ -3515,7 +3519,7 @@ ppp_connect_channel(struct channel *pch, int unit)
>         hdrlen =3D pch->file.hdrlen + 2;  /* for protocol bytes */
>         if (hdrlen > ppp->dev->hard_header_len)
>                 ppp->dev->hard_header_len =3D hdrlen;
> -       list_add_tail(&pch->clist, &ppp->channels);
> +       list_add_tail_rcu(&pch->clist, &ppp->channels);
>         ++ppp->n_channels;
>         pch->ppp =3D ppp;
>         refcount_inc(&ppp->file.refcnt);
> @@ -3545,10 +3549,11 @@ ppp_disconnect_channel(struct channel *pch)
>         if (ppp) {
>                 /* remove it from the ppp unit's list */
>                 ppp_lock(ppp);
> -               list_del(&pch->clist);
> +               list_del_rcu(&pch->clist);
>                 if (--ppp->n_channels =3D=3D 0)
>                         wake_up_interruptible(&ppp->file.rwait);
>                 ppp_unlock(ppp);
> +               synchronize_rcu();

synchronize_net() is preferred.

>                 if (refcount_dec_and_test(&ppp->file.refcnt))
>                         ppp_destroy_interface(ppp);
>                 err =3D 0;
> --
> 2.43.0
>

