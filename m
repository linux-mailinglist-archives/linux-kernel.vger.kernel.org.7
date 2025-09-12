Return-Path: <linux-kernel+bounces-814209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612EB550CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E1586AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F67308F24;
	Fri, 12 Sep 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4F/j9KvO"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F013BC0C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686755; cv=none; b=ER+unKTApdJfS6utIEBBEwJbgMYpqK8vuj+31UYd9nWmAFi8zOaiVYWXUxU5HkDgFU4dca6uMYzKxh7JOMzKFpp147F1E9Gi2kxPSnYuNM/1Nj7XPkihGJtZdIK/nPxNs1IEJgIWSQIpB/wdayQ38nxyFnyAbzOOLEY5fOSiCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686755; c=relaxed/simple;
	bh=DvXpHvEJ0p4DqJ3NRYzOqsD/rTFzc/TriCC2S5OkytU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccGAVaDvswWbvmH0pFQq8AvvEZe4A4tKqy8AXGeFTOd8y7gl3LEHD5i+glw6DcM62t6/YdNYRZmtkW+wy1aF4q9RIlWy2pt6Wlo7wtiz5pWxwHCJ5KLeJpdyNWHuAuRHdWy5S6HV9yscGZDXgIgzmcWslnEdXxVisCfatHuSfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4F/j9KvO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5f7fe502dso10587871cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757686752; x=1758291552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM4cXfsx0W9pxO9c+zmvYxuG+N7LbG4mrlPiJQK3K1k=;
        b=4F/j9KvObruqgk5ctkQMQVKi7gLB+hbPHyMgFy9h3XG1SQAflCoILEbmC/Ki0+fDH+
         zJw1zVJ4O7eMgsK5IX8hXDebwHVIDsz+zUJ7KBYcoGbf5819J9xCeWFE1Xikr+ckQ5Wo
         S9jG2U3YzYQF3lsBWsUytI5sn+lXW5Ss+2A3V4YnKv3SgeobrkfnZVB8udkQAUGzV/Vm
         0+Kwf/JhO5eHjiwQPZLI/QJcpWl3K87L+fbk9LUgRUfXZOEFctfBVMnq3TZUsI+uikxo
         5IomjaA0LmnSDc3AFUenkA6+WlBJNBdXx3BRJtLY4IYLB+CnMqEHjgpWAmfMICh5C8CI
         xkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686752; x=1758291552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM4cXfsx0W9pxO9c+zmvYxuG+N7LbG4mrlPiJQK3K1k=;
        b=i6c1oZOovqw9IAXdsozr0ieoiQJQxq9I+Ny+Bavvgj262zSEAepw8sOuuJ3B25fuTp
         /xCbFQ0y9yMMG4oGgnJV30OhvToaHJ0/DkQDa3OsjTBAgq9i8dEsHHYfZLmCmWcbkmvO
         dPfPixTNImCfT1dfkW9clOkocPkVT8zZxvrBk8Juu/GPDQCmbx6RUAHrfPX3CckT973I
         XrYZVHqjLP4YvhwYNbDwEqKVKdOXlj8nSqrvihobLpOSu29BWTw37/Id9+ctFr91o2md
         8RH3e65TSjFEEK9P/K1qyBp9vaU1hJ0iO+QFWFBRwtIA6XcipxELyjO0F5STADi0C6PC
         rdow==
X-Forwarded-Encrypted: i=1; AJvYcCVWFhqH2DlAOrff//Mt4woigbagkBhkb8/DRlo7nsRjzTVbrBtD7OsYJVrNUZJ3FQd7O3cWoPdInLoK3Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dONG/VU5e/FY5OsmbugmvEffQmOkB2n03uESQn5W1gMTrfDt
	axEHPd5dGXe4Nk4UCoOB//wW/LQSBbzTlaf3yVfS7nxNMOR56QX5hWVodeJF6gobL+dkSCUgcKb
	KjdJKhTwlsapMVfFhDSyKDViIIMWLYGS6lnFGZ1d45JHQBDVvDJe1SHJdZps=
X-Gm-Gg: ASbGncsH6WGHJTkgon+yLZw8l84bqPkoZjytejdhbkPKjj/MdMP2fEFZXhhsbBiNMy9
	wDxsY5LMHIPxTrjWPJUV9QEIP6Uo/YI62eQtuy/j1JPDxusU4zPMua7khO5dZpDUtzXytzTUqP1
	iR+qNczb9C42OKsh2OxMLHNLoCDrl1tOEhj1t6D3QXhQqQ8RkAfyJHSo49tHWUMzxykOnbOSFgC
	T839DWw4gI=
X-Google-Smtp-Source: AGHT+IFYWvGPQuJv08IxnOCKGvIZjk+nEyO34AR84OPul9f5Gq0QsOn48fw0yQSKP7mN7sS9gmiA8aACo9ZpUI51beU=
X-Received: by 2002:ac8:7d88:0:b0:4b3:4c51:642e with SMTP id
 d75a77b69052e-4b77cfdbc50mr28052461cf.3.1757686751387; Fri, 12 Sep 2025
 07:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911053310.15966-2-yyyynoom@gmail.com>
In-Reply-To: <20250911053310.15966-2-yyyynoom@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Sep 2025 07:19:00 -0700
X-Gm-Features: Ac12FXw7adrTtTEamjUd1dARgNXXs2vtOQ7AFK8Dk6Xa4BQJI1VYpFDvt0r4s3I
Message-ID: <CANn89iLUTs4oKK30g8AjYhreM2Krwt5sAwzsO=xU--G7myt6WQ@mail.gmail.com>
Subject: Re: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on
 `netif_rx()` failure
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:35=E2=80=AFPM Yeounsu Moon <yyyynoom@gmail.com> =
wrote:
>
> `netif_rx()` already increments `rx_dropped` core stat when it fails.
> The driver was also updating `ndev->stats.rx_dropped` in the same path.
> Since both are reported together via `ip -s -s` command, this resulted
> in drops being counted twice in user-visible stats.
>
> Keep the driver update on `skb_put()` failure, but skip it after
> `netif_rx()` errors.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I do not think this Fixes: is correct.

I think core networking got this accounting in netif_rx() in 2010

commit caf586e5f23c (" net: add a core netdev->rx_dropped counter")


> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/natsemi/ns83820.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/etherne=
t/natsemi/ns83820.c
> index 56d5464222d9..cdbf82affa7b 100644
> --- a/drivers/net/ethernet/natsemi/ns83820.c
> +++ b/drivers/net/ethernet/natsemi/ns83820.c
> @@ -820,7 +820,7 @@ static void rx_irq(struct net_device *ndev)
>         struct ns83820 *dev =3D PRIV(ndev);
>         struct rx_info *info =3D &dev->rx_info;
>         unsigned next_rx;
> -       int rx_rc, len;
> +       int len;
>         u32 cmdsts;
>         __le32 *desc;
>         unsigned long flags;
> @@ -881,8 +881,10 @@ static void rx_irq(struct net_device *ndev)
>                 if (likely(CMDSTS_OK & cmdsts)) {
>  #endif
>                         skb_put(skb, len);
> -                       if (unlikely(!skb))

I doubt this driver is used.

Notice that this test  about skb being NULL or not happens after
skb_put(skb, len)
which would have crashed anyway if skb was NULL.


> +                       if (unlikely(!skb)) {
> +                               ndev->stats.rx_dropped++;
>                                 goto netdev_mangle_me_harder_failed;
> +                       }
>                         if (cmdsts & CMDSTS_DEST_MULTI)
>                                 ndev->stats.multicast++;
>                         ndev->stats.rx_packets++;
> @@ -901,15 +903,12 @@ static void rx_irq(struct net_device *ndev)
>                                 __vlan_hwaccel_put_tag(skb, htons(ETH_P_I=
PV6), tag);
>                         }
>  #endif
> -                       rx_rc =3D netif_rx(skb);
> -                       if (NET_RX_DROP =3D=3D rx_rc) {
> -netdev_mangle_me_harder_failed:
> -                               ndev->stats.rx_dropped++;
> -                       }
> +                       netif_rx(skb);
>                 } else {
>                         dev_kfree_skb_irq(skb);
>                 }
>
> +netdev_mangle_me_harder_failed:
>                 nr++;
>                 next_rx =3D info->next_rx;
>                 desc =3D info->descs + (DESC_SIZE * next_rx);
> --
> 2.51.0
>

