Return-Path: <linux-kernel+bounces-886607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4937C36112
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDF55646D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF0E3277BA;
	Wed,  5 Nov 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLWiJu/C"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3C3164BB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352796; cv=none; b=gXcUuc+91BzSnFhz1TzicHPd2eYThXhLbvHFHyz2vJIeMucdw6vYaw7ksc+7vtpivn0MAjhit1OOcsoCVhC1930eTtyPy3sF9kIZ8eWl3b/y3UQoVMgkfci6bjoLu+VDVrHFSMo+8D9kae4unBj1iu7JAlSJ/bB6GZPqMwP7fpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352796; c=relaxed/simple;
	bh=UNLeQYL51m+DVasBcWR7PNTrx8XW9tm4YcPbq3YJCTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtbahLkNCcO+WfnME3U/86BmUDKb9LCDnMGfPhTI1hGefeFq06Gs/i3pIB/zlpRQTjBvDqMfNuYALgnOcsM2OMx2qbR1B1vy6mZyYQaVsC2IkiNEiC2v+BUFfOvDCm6FbnhiCrRofl7y1Q63iAv2s8saLX/tLHosuzio/mUuJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLWiJu/C; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed612ac7a7so22507341cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762352794; x=1762957594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn1Akn56TAK9vxYVpNAmwzoyFjP8WhPaxNLUGZGYjkM=;
        b=uLWiJu/CoXQzzp40yTT9Q02+Yr46Xz5hL6nHYdW8LNVCbBaT1XWa/CmfAcBlhLb1bg
         77lz7tMA5pk12nds7S0eNIJ8PnapTj6d2LYNkYSTWSpfttWWg4UOGRsAKg/kv9XfIDq+
         Zfd42QumaLkTDJD3dQ4PSmehIKfKkPfV2TiWLRenRLUMKS+oEBbsvaPWdfiPm9EDnhG0
         uJzLbhoyha2mQOqitlyEjw8K9UEXFhdGUjWj6DuW7CHIj/2BxX1UQQexRkjfzg/WxI5W
         Yt2IGmhBYbE8LqTJzbmWfFC15/a/xj/RhLDs8w7sBS5yFWu/klp4Ld4ciVlctYE5X6DH
         tlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352794; x=1762957594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn1Akn56TAK9vxYVpNAmwzoyFjP8WhPaxNLUGZGYjkM=;
        b=urx+d3tNRtVnwSKDDfCX0lgCjiq/iN27Gevrzb+bmVNku1V6HQ3wpy2ibkf3yhJ+sB
         FUaKOXZyq2YL+I6lBOSqHMUzoxuN9zoNKEDlOFKVK09ZSs2sPWUAfx8hO5BPn1H4FHrQ
         NqzS6pvh6Qc9aEc2Me9TQt3YNgZueSM0tfStgElk0hspcv2SNSLKh/ayCLqnfTq/rKdd
         KYMDEdeuT0ivH7v5bITSbUfsan7C6gIwjJSTiA+QVi3bYjdSD7MS7XJnhSbmZvLI/faN
         0uzopZBvpvu2S/KgEFc8S30LmH8BQh6ZEhGrfA1UiLmNLbpdkl51PrDYioxddc92mNAH
         R3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUGgGNQLjX9hAMyJLy22yf2AN0Eigsk8BYVg3iG9rtyzWgWXMVBWjNGYI6VWQBNnG8BP2Sk5lWdITQT1jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEfrhnqln+wNefBUmBDKs7koibxdkoa9DHBgefs2RbZAEJiRv
	crI90ifjeyG5LA1voHtAH33DAWIlriCxFziVdh7mWalADFTRAP7f2ZNkfjiV6W24mDQV+hAkhog
	bDPOj7RgHK9aANHpjPhnaWOpqWesXU7+WManOCz4N
X-Gm-Gg: ASbGncv1qj03XvKggWePMIbUnoVTQtdQHf59dMOrJH2fgrzrkIpNUp31ihb/Wyipmcw
	sIVEz345NadG/O7j/aQhmzbo4M0QYpsQtUgCw2UWWsNWst8DI4SL4JKyUQR2OstAm2cCUNQIzG5
	skZSGm9BU0tLgydMXvXKtKrc19oT1G2AbzvbdENMkdVs4xy1uE8ufmkSvSZ654joDSgfvfOLKi/
	HXHgORyWQ2xE8m05OSNtGKSBLobexwvcFkOoJd1qtE/OBcSWoZLDP7Z+uRS/A3/RuzywDc6wziV
	b3rvGQ==
X-Google-Smtp-Source: AGHT+IEyRyguqmLTVuV/+p4rWmG9dIhs2YGO8hfZ3uT7d0TjJn2hFD71728jqAvX+zyf0Qlwg6ZcF52UU2ueLDMEGK4=
X-Received: by 2002:a05:622a:1cc3:b0:4ed:42ba:9bd5 with SMTP id
 d75a77b69052e-4ed7262edbcmr35915681cf.72.1762352793343; Wed, 05 Nov 2025
 06:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
In-Reply-To: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 06:26:22 -0800
X-Gm-Features: AWmQ_bkdl5RhKS829nQ2M5b3RoWq2JzXUH6E0i1Wig8_xYGoL3cCA0DzQqGNDNg
Message-ID: <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: chuang <nashuiliang@gmail.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Networking <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com> wrote=
:
>
> From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2001
> From: Chuang Wang <nashuiliang@gmail.com>
> Date: Tue, 4 Nov 2025 02:52:11 +0000
> Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebind=
ing
>  stale fnhe
>
> A race condition exists between fnhe_remove_oldest() and
> rt_bind_exception() where a fnhe that is scheduled for removal can be
> rebound to a new dst.
>
> The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> for deletion, but before it can be flushed and freed via RCU,
> CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
>
> CPU 0                             CPU 1
> __mkroute_output()
>   find_exception() [fnheX]
>                                   update_or_create_fnhe()
>                                     fnhe_remove_oldest() [fnheX]
>   rt_bind_exception() [bind dst]
>                                   RCU callback [fnheX freed, dst leak]
>
> If rt_bind_exception() successfully binds fnheX to a new dst, the
> newly bound dst will never be properly freed because fnheX will
> soon be released by the RCU callback, leading to a permanent
> reference count leak on the old dst and the device.
>
> This issue manifests as a device reference count leak and a
> warning in dmesg when unregistering the net device:
>
>   unregister_netdevice: waiting for ethX to become free. Usage count =3D =
N
>
> Fix this race by clearing 'oldest->fnhe_daddr' before calling
> fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> setting it to zero prevents the stale fnhe from being reused and
> bound to a new dst just before it is freed.
>
> Cc: stable@vger.kernel.org
> Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")

I do not see how this commit added the bug you are looking at ?

> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  net/ipv4/route.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 6d27d3610c1c..b549d6a57307 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> fnhe_hash_bucket *hash)
>                         oldest_p =3D fnhe_p;
>                 }
>         }
> +
> +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> +        * rebound with new dsts in rt_bind_exception().
> +        */
> +       oldest->fnhe_daddr =3D 0;
>         fnhe_flush_routes(oldest);
>         *oldest_p =3D oldest->fnhe_next;
>         kfree_rcu(oldest, rcu);
> --

