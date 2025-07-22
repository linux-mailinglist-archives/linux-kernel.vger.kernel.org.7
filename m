Return-Path: <linux-kernel+bounces-741165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD06B0E0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA4E3BC6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A8279DB6;
	Tue, 22 Jul 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0xA+kf0"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C2279918
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198923; cv=none; b=ZbEl6nwCLKotPd5A/KwTl7iWhC9euZIPs7aBnanQ7Urr1ULubEv2L9OBUmiBJQ3FbowoAEXImeSEIszBXnybLeTzP9fE9zn0qf5nq971M3f07p5lF1gF4zHAH21dtUv7+gm4zNyp4IrOCuaKUEaej5PYuGWRHaExzj5/t09iLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198923; c=relaxed/simple;
	bh=g9EEklXk902C8ofxuE8rx2WBA3m7abatvb7woZ+cMsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAmbfsyGwdsIiv7PU+2q0Wo+qW+WrXDcZVd3/TzlSFeTDKIL/hH7f9WfMeWAdGorQcpl2BxN6EXY9yk2kukMMuhU+JJ7kMRCfcsQY9Sf/m2jgn5wMmDZ/GsIKnjoEQ8oil26eHBYT6pDU1/nrypMpxdqtTvExGTsKc+36iLBINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0xA+kf0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab82eb33f9so93415771cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753198920; x=1753803720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qBHdKmYPMFtPjBkykZtOEGhLmANMjG/wOtN6adOqo0=;
        b=k0xA+kf0W/hi+5CA7OXgy3ZpOEekh2tL9D+GJo1GQ4Y3lRXv7TSXsVvWc/6ArmOj9I
         ARyAMZazO20Ia515EQQDXKA+Q3Ft+9Nla+8yIBy4iPlAKiU5oLDIfSyDRWqASNPQ2C+N
         eAXL8SGPGTGO6/wvK0joh7s7p7+CyIAFhhDhwk6QyNywcWdXJzUZ4qq+MADDWZiSreXY
         IO2kQKmQkvs9s5ze0XxY7gHQHIv9yFqNSoEnBOGZshTzLn+tn+S5dbPbGZQwCf49+q/4
         hi18z/07g7nbhNEnNoufmvHpFQ9qqu1rfrJzGP94LAznzVFJgX4Kgm/ff4GZkuKVWDSM
         +0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198920; x=1753803720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qBHdKmYPMFtPjBkykZtOEGhLmANMjG/wOtN6adOqo0=;
        b=hWvRhbzlmlJNfFzRSZl029y8eDbjLk+ABpLjjBCAfM5dV6OBr53dEhTFGBy/qa12Mi
         Dcubq/FPxN08SABd+43J5BZt0ykhl+c4u10F2UoH0scAHwKtV8P3du71wE7Teawxxc3I
         3HBsdAU9zMRB+WK0RgEJM35UZYr5wmX49PHXhLucFwMo0oxpEev8lTNQPlh6n5qENw+I
         L5r+91vI3QDfcdT73cYnlDhVIDQzotewb/yo6CFn5RW6VzfNoYkuvtdz6LnXqNG94DQZ
         oMDtuNKbFJScNjMII0/Hg3RZ7yed0myWVWSKTaLjKS+OTxIc2HVMFzXlOSXnZT3n1hLL
         TPPw==
X-Forwarded-Encrypted: i=1; AJvYcCVmuKKPrM1z4IuC2R0J5C8qQ94MXt14oj0mNNJ/0fAlqMIXha0kr6iyTpt5vWAp5hvISZbRG6gCqANWNVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjfnx7NHkngcLIDCLMdAo1cgW02lRKu2l43IP2H01uBs/EMEWc
	vvYaPSqkYMefHaox2N8rLbXAi1p4tGr9lW3FFy7f4wsa2GgBfNFfwapKimGjzY2E81VkjqokyQF
	NudVQscQdSbMyGPYE0VTTykW/lDEU/cMSTCoftKpS
X-Gm-Gg: ASbGnctyrD6zgpV5tFllLR+dxXxuX7kvE087YJoCWeIJ2pOZeol/p11qr4dvGaUM7Mk
	XiOQ4oX68CYf7b5/X7rYbszxMxH/pQKUbktCISo2P1Q1dWUAfDkhe5OPcDwaoSn/7ZXVpf2IlG/
	0NzDw3qmcnVEzukSPccTUXLVciF8GLINIGpeotdi0EoAjTgnMKTy6/VmXj8zYJsHEdVXHPppJLz
	e16XQ==
X-Google-Smtp-Source: AGHT+IFz3i1EtapV0IvQfMG2OwnY161D0xKDC7JwKfOL7HxpCFq49fqtCqXRwaiQlIgHTAbfGBWChoDUfHIlflY9Vnw=
X-Received: by 2002:a05:622a:190c:b0:4ab:3ff6:f0e9 with SMTP id
 d75a77b69052e-4ab93c430f7mr382067691cf.1.1753198919441; Tue, 22 Jul 2025
 08:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:41:48 -0700
X-Gm-Features: Ac12FXwxZbJIBYib8fr6Oyem19af1On_m2X-wW_EUa_K4ODkvuxy53heJa_cUR8
Message-ID: <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:15=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> When changing the tx queue length via dev_qdisc_change_tx_queue_len(),
> if one of the updates fails, the function currently exits
> without rolling back previously modified queues. This can leave the
> device and its qdiscs in an inconsistent state. This patch adds rollback =
logic
> that restores the original dev->tx_queue_len and re-applies it to each pr=
eviously
> updated queue's qdisc by invoking qdisc_change_tx_queue_len() again.
> To support this, dev_qdisc_change_tx_queue_len() now takes an additional
> parameter old_len to remember the original tx_queue_len value.
>
> Note: I have built the kernel with these changes to ensure it compiles, b=
ut I
> have not tested the runtime behavior, as I am currently unsure how to tes=
t this
> change.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  include/net/sch_generic.h |  2 +-
>  net/core/dev.c            |  2 +-
>  net/sched/sch_generic.c   | 12 +++++++++---
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 638948be4c50..a4f59df2982f 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -681,7 +681,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash =
*,
>  void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
>  void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
>
> -int dev_qdisc_change_tx_queue_len(struct net_device *dev);
> +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int o=
ld_len);
>  void dev_qdisc_change_real_num_tx(struct net_device *dev,
>                                   unsigned int new_real_tx);
>  void dev_init_scheduler(struct net_device *dev);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index be97c440ecd5..afa3c5a9bba1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9630,7 +9630,7 @@ int netif_change_tx_queue_len(struct net_device *de=
v, unsigned long new_len)
>                 res =3D notifier_to_errno(res);
>                 if (res)
>                         goto err_rollback;
> -               res =3D dev_qdisc_change_tx_queue_len(dev);
> +               res =3D dev_qdisc_change_tx_queue_len(dev, orig_len);
>                 if (res)
>                         goto err_rollback;
>         }
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 16afb834fe4a..701dfbe722ed 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1445,7 +1445,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsig=
ned int new_real_tx)
>  }
>  EXPORT_SYMBOL(mq_change_real_num_tx);
>
> -int dev_qdisc_change_tx_queue_len(struct net_device *dev)
> +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int o=
ld_len)
>  {
>         bool up =3D dev->flags & IFF_UP;
>         unsigned int i;
> @@ -1456,12 +1456,18 @@ int dev_qdisc_change_tx_queue_len(struct net_devi=
ce *dev)
>
>         for (i =3D 0; i < dev->num_tx_queues; i++) {
>                 ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> -
> -               /* TODO: revert changes on a partial failure */
>                 if (ret)
>                         break;
>         }
>
> +       if (ret) {
> +               dev->tx_queue_len =3D old_len;

WRITE_ONCE() is missing.

> +               while (i >=3D 0) {
> +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);

What happens if one of these calls fails ?

I think a fix will be more complicated...

