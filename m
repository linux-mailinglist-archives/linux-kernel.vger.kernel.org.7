Return-Path: <linux-kernel+bounces-776571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC93B2CEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E76524C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC93054EC;
	Tue, 19 Aug 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3LdfPM8"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF03054C3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640511; cv=none; b=bSe/N1MPSYtGVaGj5X1rOGOgBFRlRr/O5jQCR0VNCgIn7zUfvCqhHhkHnRp9OCxCfviZDguBHPNHTWQiVKh4UULXj7pSD5dA1lJIdtcI3aAuG4gKToZoi1GhRf+LHV+cMBubYCjuM5QLDt9ma3J7y53zheLGUMD7/1WWJy4t0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640511; c=relaxed/simple;
	bh=jugAp7iAiTN5wpRLM0Lfl5uLxQIUuuVskd6wG72PHAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYCk80fCgazNJDWnMX6gPTLmN950SJ2QWQHBMVL7evKP10fsnX8mHpHRKBDwHxZQtHOFsud1fJAkK+9dLmuPaQ0oFwi0WOtp/eWSsd8ur9/v+RcMQFL3R7wcABpku8Wfa/smY3onFYei17O9gVcapuASkpFtrZl/kEuAOw5LZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3LdfPM8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cdfd57585so678e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640508; x=1756245308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VjKxvkqlHvKuDQTAdp11Q1px0mlLxmaJPy90ey9LnI=;
        b=o3LdfPM8idVZbUxrj9am39LbMwWCU2T84wyc+PsE8dM367cJO0Ugc7yuvcTtK47bSd
         DbWJw/8odp4Cpmesnwhgng2AyUbE0t1q9WlcGNCNChL8E5aS5nZGrO9V+TNDcLnoxPkX
         VXWIiX6+SNsmC9vnVwxNg1YXsUHBOPBFj79ZxiR9bVOFSqza1f14lNPlxnthrroHhnk5
         UBRK74IWvtqQSMhfcWoITeAMpTJBqi34y4zw3IBbj0VFxppzjnhdhNRh7wofb0dZJbCx
         CGrV9QSIBVLgdMsXBM5QPQlKcq4ILsoXpuFqMw3xMYv25nq8rrFtJD8Bkcq/CHtis/To
         PBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640508; x=1756245308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VjKxvkqlHvKuDQTAdp11Q1px0mlLxmaJPy90ey9LnI=;
        b=KO3xClH0qHdDGJ43qcnrpce2A3NuDKmrIHQnzL/M3mXU9Bogdc4cO9O8OFKlWD4ip8
         uRbMAB7Oz7rdhI3hhCZEFVoejW10HSlxaWAbwbXWi717ISfA15/ZJ3x6/+8NHYMbrVl4
         mUoV7IRQsMccvYEUAoCAm9Y9OicUYUrPw/plqDDnQ5ILrqgJXTUYZJTrJazU5m7nSGjG
         KpNzoLXYNXW+OLiSAltqbQo8vNpeqQn6m0a3fg1ZUOfHAz6JUTrAd2a7OYaaXWBd/spO
         QRfSynwKaCmiG4Hsj9MZt7o+5iFzSpoPgKsisKnf4EoQ0/2LHfv9eg36kzX8fF6LcROg
         EdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmmfGK6GOe32ToC6nnf+MxtBIMsssh5Lr0jdjuvlZ+bCe/LZ4HvphQy9LO7zxU11wT89g+r4W+I21aGkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJewjRGSJnY0T3THcAbRAsvMVjKTXn50h2Gdr3zrv7A46UtPy
	nE4pr8HOdGPXCmBiPFdhgm77hP1v1AaWq8OR0SwS6aEDRn91ywyAdXHyd/03uY3rPzcYImcM2KQ
	AINV1s7Bj5Y1FtOm2z6kZm92Mul91SDOzdpjr4Zqd
X-Gm-Gg: ASbGncvEeTRmQllRyGiVmyLOs3pdtSlymcluPKf5TVmmubX56maX7LSlN/uT4YDFZ99
	qF21S055VXP/RGMy4kWZABKY7mEZHu8i9Lf5iITg8ZpiW3JsGdCBvj1kSOhcr7wWt8WxJsTEpia
	ALI/IreWsRKDqfM181k5p01XdnGl2GQ1Oomg+WRbIsQa2ywWsgaScACB1lc0Rj6jLklXETFKCjU
	3qcCDNC9N7P7Rz3e0S6wpn8OBJn1V8EbHOJVG4q8Pw0lqKMlGSsfuQ=
X-Google-Smtp-Source: AGHT+IEENPeJUziX5JKCVFlOK3QcW9hOPlY+os3uYUuHODeq049TKSrhikj9f/ivABKSBZN/jlqaOuHA4OZlfyxo/To=
X-Received: by 2002:a05:6512:6401:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55e066d2922mr97406e87.0.1755640507787; Tue, 19 Aug 2025
 14:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <819d46e1354b0c7cc97945c6c7bde09f12df1da6.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <819d46e1354b0c7cc97945c6c7bde09f12df1da6.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 14:54:55 -0700
X-Gm-Features: Ac12FXxeo1Wf2dKxzd4cQVsy9kzkzxP83IAtSvMfurLpwYPvoLmCKi5ODIA8qfw
Message-ID: <CAHS8izOru3+zGPkOa5XMWOo1uhtzz+Zt7yDC7R=NZFfyPdeK9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/23] net: add queue config validation callback
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> I imagine (tm) that as the number of per-queue configuration
> options grows some of them may conflict for certain drivers.
> While the drivers can obviously do all the validation locally
> doing so is fairly inconvenient as the config is fed to drivers
> piecemeal via different ops (for different params and NIC-wide
> vs per-queue).
>
> Add a centralized callback for validating the queue config
> in queue ops. The callback gets invoked before each queue restart
> and when ring params are modified.
>
> For NIC-wide changes the callback gets invoked for each active
> (or active to-be) queue, and additionally with a negative queue
> index for NIC-wide defaults. The NIC-wide check is needed in
> case all queues have an override active when NIC-wide setting
> is changed to an unsupported one. Alternatively we could check
> the settings when new queues are enabled (in the channel API),
> but accepting invalid config is a bad idea. Users may expect
> that resetting a queue override will always work.
>
> The "trick" of passing a negative index is a bit ugly, we may
> want to revisit if it causes confusion and bugs. Existing drivers
> don't care about the index so it "just works".
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/net/netdev_queues.h | 12 ++++++++++++
>  net/core/dev.h              |  2 ++
>  net/core/netdev_config.c    | 20 ++++++++++++++++++++
>  net/core/netdev_rx_queue.c  |  6 ++++++
>  net/ethtool/rings.c         |  5 +++++
>  5 files changed, 45 insertions(+)
>
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index b850cff71d12..d0cc475ec51e 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -147,6 +147,14 @@ void netdev_stat_queue_sum(struct net_device *netdev=
,
>   *                     defaults. Queue config structs are passed to this
>   *                     helper before the user-requested settings are app=
lied.
>   *
> + * @ndo_queue_cfg_validate: (Optional) Check if queue config is supporte=
d.
> + *                     Called when configuration affecting a queue may b=
e
> + *                     changing, either due to NIC-wide config, or confi=
g
> + *                     scoped to the queue at a specified index.
> + *                     When NIC-wide config is changed the callback will
> + *                     be invoked for all queues, and in addition to tha=
t
> + *                     with a negative queue index for the base settings=
.
> + *
>   * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specifie=
d index.
>   *                      The new memory is written at the specified addre=
ss.
>   *
> @@ -167,6 +175,10 @@ struct netdev_queue_mgmt_ops {
>         void    (*ndo_queue_cfg_defaults)(struct net_device *dev,
>                                           int idx,
>                                           struct netdev_queue_config *qcf=
g);
> +       int     (*ndo_queue_cfg_validate)(struct net_device *dev,
> +                                         int idx,
> +                                         struct netdev_queue_config *qcf=
g,
> +                                         struct netlink_ext_ack *extack)=
;
>         int     (*ndo_queue_mem_alloc)(struct net_device *dev,
>                                        struct netdev_queue_config *qcfg,
>                                        void *per_queue_mem,
> diff --git a/net/core/dev.h b/net/core/dev.h
> index a553a0f1f846..523d50e6f88d 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -99,6 +99,8 @@ void netdev_free_config(struct net_device *dev);
>  int netdev_reconfig_start(struct net_device *dev);
>  void __netdev_queue_config(struct net_device *dev, int rxq,
>                            struct netdev_queue_config *qcfg, bool pending=
);
> +int netdev_queue_config_revalidate(struct net_device *dev,
> +                                  struct netlink_ext_ack *extack);
>
>  /* netdev management, shared between various uAPI entry points */
>  struct netdev_name_node {
> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> index bad2d53522f0..fc700b77e4eb 100644
> --- a/net/core/netdev_config.c
> +++ b/net/core/netdev_config.c
> @@ -99,3 +99,23 @@ void netdev_queue_config(struct net_device *dev, int r=
xq,
>         __netdev_queue_config(dev, rxq, qcfg, true);
>  }
>  EXPORT_SYMBOL(netdev_queue_config);
> +
> +int netdev_queue_config_revalidate(struct net_device *dev,
> +                                  struct netlink_ext_ack *extack)
> +{
> +       const struct netdev_queue_mgmt_ops *qops =3D dev->queue_mgmt_ops;
> +       struct netdev_queue_config qcfg;
> +       int i, err;
> +
> +       if (!qops || !qops->ndo_queue_cfg_validate)
> +               return 0;
> +
> +       for (i =3D -1; i < (int)dev->real_num_rx_queues; i++) {
> +               netdev_queue_config(dev, i, &qcfg);

This function as written feels very useless tbh. There is no config
passed in from the caller, so the function does a netdev_queue_config,
which grabs the current-or-default-config (I'm not sure which tbh),
and then validates that is applicable. But of course the current or
default configs can be applied, right?

I thought there would be a refactor in a future patch that makes this
function useful, but I don't see one.

The qcfg being applied needs to be passed in by the caller of this
function, no? That would make sense to me (the caller is wondering if
this new config is applicable).

--=20
Thanks,
Mina

