Return-Path: <linux-kernel+bounces-775173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E98B2BC28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84C81BA390E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82A311C07;
	Tue, 19 Aug 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghez2W9x"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694433115AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593237; cv=none; b=lBDgbmFuMVaVV0ckjzLu5HrbrUPNaZtfr7Q4r8JKsHqYx14AVqM8n455CbK51aUGUQIhw8gvym6wHAK9zNTGR4lXOFTa5Bh4960iCl+ZiRnIVV7EkCGy5hY2wuzdlbdBVaHez9vv260pZSWIaL8EY5LMFjunjAk0y3uD9ATIOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593237; c=relaxed/simple;
	bh=jYLXe5QCSU4Gs2P5pMxvYSKcjUVhNYe9tWHDneqGIYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYZ+wE8T7joBfJsvz1zPufV0qBca7iLc4jOFOdG6WW/NF4WQQqdK5sj+RhVmu0a6BJqmjUVsdbjrrzikSHbRG/ykQqIvfNRnjiWovaIWicWwdEJQZkpfaQLvlyT1OhtpaTDirKTbh3Hh9fPEcSxFLdUNtJ6YvOf7L+kZS0JHtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghez2W9x; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109c6b9fcso46594161cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755593235; x=1756198035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTjTOjrKpq7HcHOMrHkF7ZbVz5wRss5ik5G5OB8UHHE=;
        b=ghez2W9xaYog1lJncuXoF9PAobjV4ZkNi/UbToVqw8CP1y2SR4XUCpUebRApvwbvdb
         Ov+tlAXqCHqiSVO16TL+dNiWHNqqtkzS/+k8btllYEzU4tN4O0dG7/pEL1ZaAlItyqd5
         k/qehHpzzSYN0sOBRqoLOZFqdXuWcvxSO6tKCm62roVepcR3WGVz0Vl6qUVzt7Dmsmt/
         07WHwh/70IdAMCW809xmDWOMvLI4L/JnD+DmIQp2V0oX+nqjMa3DN7kaUIuXA8ZntsA8
         //N/HD9aZvOplBWlbhRBCvE6tX/Kaepqq42jetmnsmOjdfFJxcIbqT4DS/GZEvXP7ccp
         163A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593235; x=1756198035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTjTOjrKpq7HcHOMrHkF7ZbVz5wRss5ik5G5OB8UHHE=;
        b=jUjVO9J5zG3zajpTKaEQAmCk9Po9+VXDov8v8DUGceD0sc683ATaF9c86BrS4luAdR
         3+ZRNrIJATYMSYD6W4PuVq7o2y3zhdg7izDf7cMEaTbo7hcLkd07HJqN4NpldjIgsbBj
         22gViamfpuAkZ4VZpLNzRktm9Lj01wRIxaAHzpLC9mt5DtZu1oaXprY7vA2DWjqWWG1D
         PdQ6n58LwDWmAUluRkNRhK8mE/MYgTABTmk98P8IcLjRkk6OIkFuh0EF+aIp4YdU9NIp
         bPpFDY4AigOIhexmyI+9YaKQx7wtk8pM0wJw2sTGvR1twal0YUHn0Ep/PcTy5taUmwUs
         40Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVLWg4dwNowj/2c30a2HS2HA7hY2OMY8CGEsfd6edJFycvfJW30ne6A7rlB9hK6rHNHzqOcvqb9ZTJB1uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjioW6GG+6/NnzvO1MGPUHdzeB3QC/sHnIUd4hW50gDyE4Ke6
	tZ0/4iQXPCFjPDky2HlO+/KqkEgbjK4jS6tpDe4csNgw7tgx0v9n8i0ZT6fPX9LLPNYM/4l15zc
	svHKJsUvWLR6X/32cVjBdOz1qaPruA5eKhQbBeJRV
X-Gm-Gg: ASbGncsltN4bhb24rHrmjlvj4RJ65gEqgl2zHtfShyDv+8wpy/tdtWIaJPzL/QhejA+
	OOebHS3kQ5BGT/2a3lBcXmN7yVVS1Rggoeft2WDNgZJ5rM2pI/nji7uPEI05Dr2FjHlYNWa+B3a
	lbimHj3EEsB+TmJlGVevjCN5k0wKjCqnYX0dySnz1aa+JvFNhuOGaTfJ8pkZkliqFdsCPJvNHA8
	bhUH0H0OIBf5wI=
X-Google-Smtp-Source: AGHT+IGHTzLeNk8ykX+lpN/s5xUDjFhZiDUiNtDjALn7/NzmVRolIT0jQeRREaRRmVzzKNX71GQdH8cn8uZTsOWBwhQ=
X-Received: by 2002:ac8:584e:0:b0:4b1:226e:bce7 with SMTP id
 d75a77b69052e-4b286c6f9e3mr19777321cf.26.1755593234750; Tue, 19 Aug 2025
 01:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819063223.5239-1-richardbgobert@gmail.com> <20250819063223.5239-2-richardbgobert@gmail.com>
In-Reply-To: <20250819063223.5239-2-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Aug 2025 01:47:03 -0700
X-Gm-Features: Ac12FXyp82W8J4J-AaMbBX0uUMle9ZdE5ooUJY4dnTJNG1DUI1ywoFZBUTgbfZk
Message-ID: <CANn89iL8XHOeBbq_73SiCEEhYrudeDVagtr=K6wpEkh9JuZV6A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] net: gro: remove is_ipv6 from napi_gro_cb
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com, 
	salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, 
	ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, florian.fainelli@broadcom.com, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org, 
	linux-net-drivers@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:32=E2=80=AFPM Richard Gobert
<richardbgobert@gmail.com> wrote:
>
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
>
> Using sk->sk_family is reliable since udp_sock_create always
> creates either a AF_INET or a AF_INET6 socket, and IPv6-FOU
> doesn't support receiving IPv4 packets.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      |  3 ---
>  net/ipv4/fou_core.c    | 31 +++++++++++++------------------
>  net/ipv4/udp_offload.c |  2 --
>  net/ipv6/udp_offload.c |  2 --
>  4 files changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/gro.h b/include/net/gro.h
> index a0fca7ac6e7e..87c68007f949 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -71,9 +71,6 @@ struct napi_gro_cb {
>                 /* Free the skb? */
>                 u8      free:2;
>
> -               /* Used in foo-over-udp, set in udp[46]_gro_receive */
> -               u8      is_ipv6:1;
> -
>                 /* Used in GRE, set in fou/gue_gro_receive */
>                 u8      is_fou:1;
>
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 3e30745e2c09..261ea2cf460f 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -228,21 +228,26 @@ static int gue_udp_recv(struct sock *sk, struct sk_=
buff *skb)
>         return 0;
>  }
>
> +static inline const struct net_offload *fou_gro_ops(struct sock *sk, int=
 proto)

const struct sock *sk

> +{
> +       const struct net_offload __rcu **offloads;
> +
> +       /* FOU doesn't allow IPv4 on IPv6 sockets. */
> +       offloads =3D sk->sk_family =3D=3D AF_INET6 ? inet6_offloads : ine=
t_offloads;


Do we have a guarantee sk->sk_family can not change under us ?

IPV6_ADDRFORM is available to UDP sockets after all.

