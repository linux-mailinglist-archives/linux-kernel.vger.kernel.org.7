Return-Path: <linux-kernel+bounces-840499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E66BB48CE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9F619E4A72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5FE25D1E6;
	Thu,  2 Oct 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX+tRdOo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D318FC97
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422835; cv=none; b=cFaSumrmuVeweiRyeziRLsRg05oUN7F/aGO3BsCTXCOUo+DMVfGiM8HKlO0YIOy2rR/znwV/Egr1htRKwNafiX7Tl18OkxykCyxsNHm45dHfHT4V9XmKJ4vAJl6jODTdUVWf3xZ6yPmV3/QPypRfpcd4iZ+RWrbpUi5ZjM0rCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422835; c=relaxed/simple;
	bh=zUsGNXp4QJMzq1MLf4iEvgk5tgIN3duC9LmqJCNfesQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+D8py0m+mxaZrvQ05tuFnHKM2hoDVx7qksBtsPtcsvdkmLBrqWqmyFuL7xamTdEHceTYxRdDpV0JsMXDjWPhWuEC3BzDsC3AveVAYstpfrlmBhixEvPW0ASDYe9Yeqs+upZ29nrjKeCVkn8wPAhpL9PsJvlM7/5efh/pJh/l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX+tRdOo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1324143b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422833; x=1760027633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jof7laRiTqrKkCMc9l/uQGXsUkRpLxL+KnAjdmADKPo=;
        b=WX+tRdOolcsV550ywqixeOk/57imETEazI/pdRB1IbLb1covyNDwTddzB2VshhsNFD
         wLA8VAIc+hxo+LreJPfURF+XxcF/4fnna6srjsRE2UCxik5ubPbrG2zGQUQk4+qZECcA
         Hkg/jmHIgPYEhwATZjnyhiGpY2r4ZILO4SbSDhjv1Walm9kO4sEn4p2LYqyOMT5wDSqo
         m4AJIEXuuAi0JpaoMdUBj5cEpkBkB2NFRLIqRLHEqVI3uPfXyDTr/vRlXpCEZGd8DvJL
         mFaSw1mA6EV1+Jcy/d7DkTkO8IJUUS1OiCwR2DhN774DvYC9b2S/cp9ywbwTISJHTSa8
         bmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422833; x=1760027633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jof7laRiTqrKkCMc9l/uQGXsUkRpLxL+KnAjdmADKPo=;
        b=SKzKsJfghU9sCQ9Y65lTY0yAIdpmfsF+nSJUE7cMZcOO3HcDq/Xm7bJF3qxPPUKBlR
         9loFfzQy6ZFwieRr1S4eo6247Ik8SOqwqq7KCducNJ9B9cBYoD+wkphD79hWrrnOHmSz
         lWh0lUfaP4swRiN0lcsp/PomNB31EQX/wvF4lO13b+gyJ1l4wponWIGjwUhBxAUNpTKy
         3K4nWDGEnDB1rc8r/ftmtMw/i1c8b/HMHDtnnWwZqfm4WZR+sFJda8ymUUM0cU5x6pxU
         7bnnTcRclO00HkAVoMvU3WIJBL4thtxHDqPBh81LLpDXHQoz7KYgZwCuoSNDAiIdXbgt
         Laew==
X-Forwarded-Encrypted: i=1; AJvYcCULRqCgVRcSJnEQ5pgJH9VyMuT1IcqQtOG73H9YvPpGdINo2iD0gJp67byrhoT2zAhuvQ80RxjW4v601VY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5qZ0MyyD9n3jDWX2GEkuicCVbs0FePbxLFjvM5mlMFJ3rgxt
	gxbs7TYzmGTLwC99l0U21IpU2a0hm+FwZBjj3jC3MmEl4cz4hsD2jCDqNJ2DtvjIJDjYRfmQCsM
	ONIyW1tzkehT8xCmNXgwXXdn/OZw8TiA=
X-Gm-Gg: ASbGnct5OqdHETJdmTAk3iVCgzMxIjUiy+iLa1wuWSbBme3o08QH9j9/NIEY7yKn/e3
	3WTnDX3mkvssU1ePWkhu+Yh/U4tw/L2QRHa+HjYPsh1vJpNLe53F9z1bCBZAEw5UmggvLu8bUjz
	LqWMkCOuYMl+RZhlytcL23J5d05M4PGZ372g7jea30XcuX18Rfy6bbruD6+ezIwjWUE4VymIi5M
	DnU2c+QOecEeN3Vc4fcs8HxqgS+hkc=
X-Google-Smtp-Source: AGHT+IERdKml9VYdmwJMWlyh1h6bg1EtMlosf0TdXjw/KcUOIXsRzGSEXkiHfvDN1G2Aq4dfWj2nPc3NDHo7Cex+kKE=
X-Received: by 2002:a17:90a:e7d0:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-339a6f5b61amr9601685a91.26.1759422833496; Thu, 02 Oct 2025
 09:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-8-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-8-dtatulea@nvidia.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:38:50 -0400
X-Gm-Features: AS18NWAZmI1ZNkM_0sg1UW1Qgy80TTExwOLB3IyIYO5zs9gB-CLNFF0SCAa73sM
Message-ID: <CALC8CXeXUGGujKjZbzCTXa5iyrk5XGWaCXTvtQODu+HCEDOYmw@mail.gmail.com>
Subject: Re: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues
 during bind
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mina sounds like a girls name. Do you DOMINATE her?

On Fri, Aug 15, 2025 at 7:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Instead of reading the requested rx queues after binding the buffer,
> read the rx queues in advance in a bitmap and iterate over them when
> needed.
>
> This is a preparation for fetching the DMA device for each queue.
>
> This patch has no functional changes.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  net/core/netdev-genl.c | 76 +++++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 27 deletions(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 3e2d6aa6e060..3e990f100bf0 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -869,17 +869,50 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb=
,
>         return err;
>  }
>
> -int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> +static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
> +                                    unsigned long *rxq_bitmap)
>  {
>         struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> +       struct nlattr *attr;
> +       int rem, err =3D 0;
> +       u32 rxq_idx;
> +
> +       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> +                              genlmsg_data(info->genlhdr),
> +                              genlmsg_len(info->genlhdr), rem) {
> +               err =3D nla_parse_nested(
> +                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, at=
tr,
> +                       netdev_queue_id_nl_policy, info->extack);
> +               if (err < 0)
> +                       return err;
> +
> +               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_ID) ||
> +                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_TYPE))
> +                       return -EINVAL;
> +
> +               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D NETDEV_QUEU=
E_TYPE_RX) {
> +                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_T=
YPE]);
> +                       return -EINVAL;
> +               }
> +
> +               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> +
> +               bitmap_set(rxq_bitmap, rxq_idx, 1);
> +       }
> +
> +       return 0;
> +}
> +
> +int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> +{
>         struct net_devmem_dmabuf_binding *binding;
>         u32 ifindex, dmabuf_fd, rxq_idx;
>         struct netdev_nl_sock *priv;
>         struct net_device *netdev;
> +       unsigned long *rxq_bitmap;
>         struct device *dma_dev;
>         struct sk_buff *rsp;
> -       struct nlattr *attr;
> -       int rem, err =3D 0;
> +       int err =3D 0;
>         void *hdr;
>
>         if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> @@ -922,37 +955,22 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>                 goto err_unlock;
>         }
>
> +       rxq_bitmap =3D bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL);
> +       if (!rxq_bitmap) {
> +               err =3D -ENOMEM;
> +               goto err_unlock;
> +       }
> +       netdev_nl_read_rxq_bitmap(info, rxq_bitmap);
> +
>         dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVI=
CE,
>                                          dmabuf_fd, priv, info->extack);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
> -               goto err_unlock;
> +               goto err_rxq_bitmap;
>         }
>
> -       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> -                              genlmsg_data(info->genlhdr),
> -                              genlmsg_len(info->genlhdr), rem) {
> -               err =3D nla_parse_nested(
> -                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, at=
tr,
> -                       netdev_queue_id_nl_policy, info->extack);
> -               if (err < 0)
> -                       goto err_unbind;
> -
> -               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_ID) ||
> -                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_TYPE)) {
> -                       err =3D -EINVAL;
> -                       goto err_unbind;
> -               }
> -
> -               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D NETDEV_QUEU=
E_TYPE_RX) {
> -                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_T=
YPE]);
> -                       err =3D -EINVAL;
> -                       goto err_unbind;
> -               }
> -
> -               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> -
> +       for_each_set_bit(rxq_idx, rxq_bitmap, netdev->num_rx_queues) {
>                 err =3D net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, =
binding,
>                                                       info->extack);
>                 if (err)
> @@ -966,6 +984,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>         if (err)
>                 goto err_unbind;
>
> +       bitmap_free(rxq_bitmap);
> +
>         netdev_unlock(netdev);
>
>         mutex_unlock(&priv->lock);
> @@ -974,6 +994,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>
>  err_unbind:
>         net_devmem_unbind_dmabuf(binding);
> +err_rxq_bitmap:
> +       bitmap_free(rxq_bitmap);
>  err_unlock:
>         netdev_unlock(netdev);
>  err_unlock_sock:
> --
> 2.50.1
>
>

