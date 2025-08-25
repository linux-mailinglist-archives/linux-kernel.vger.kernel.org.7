Return-Path: <linux-kernel+bounces-785456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0DBB34AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837EA1B240E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C62848B4;
	Mon, 25 Aug 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGpq1sP5"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3802848B2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150420; cv=none; b=Za3aIIHGJRhFdqd87BneGQit2jWC7on2+WGkjSq9qveUGodlhgwMFGFsIXiFYBwE1No6VHWcxYP3mQKr0jXoPEmhP9VDZl6tB/+1doV12tlAttSwvFw6gA7EG9aA83pBrNLQBtMSc1PL3yEnPMkfS+sJJQTyRXdYB9Vh+NPyAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150420; c=relaxed/simple;
	bh=S7AAqN5jURT5/z3vahcejf5DpecFFf0mqMMmmi7onvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcvRH4irxJ8XYgDhnCPdEgvpqo6RrJnJo6PJaTHqN894HV5cS06SbLILcibj7fq4DsPFiGWq3ha8kZ3ksA5krQLKxkJjh546k0CzRMLsARosov/qMD/yLXwpdzlyb8bS+FYHHGLyIau86l5jH+hvEU+sYrA/Ew7xgvlD+zhifGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGpq1sP5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b1098f9ed9so35699621cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756150418; x=1756755218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxffX3a0/5wfsp9GphcAYcfX3auUfB5UZgtehPW6yAk=;
        b=JGpq1sP5wIsLMDuR6Z5zYhOes4tz/rqHSEtCAAESVKrAE1//VRxmucTHxpYZnkVHLG
         gNu+V+HmPi4qyxQEuWajl7lEuJrI3ExDJvMyfJVzRf2yWLvfuj5ziSt7UgjWHwhKQaHb
         Xmknb0R+c9I4/bgC66u9sTJ5gNKqVcY0tgDLpnEwcD95YaWwZ+bjxH3+/aY/CumVVadq
         Qta/jurfPf6IwSFC+H4oSphCSNz4R5/PI7TJieLKiNLsrtgzFv7T0eQX4EJ/XY95e+cI
         1b54AqNXFc1lQE6ePo5VX18IlWGL/ZtsmGl224c4L48LNSCr8xNO95RaBuQcyodasQuZ
         A3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150418; x=1756755218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxffX3a0/5wfsp9GphcAYcfX3auUfB5UZgtehPW6yAk=;
        b=Y1C99MfVd9efUTB3MGF8aBXI0ZLnDZKvxXB3RCFgZSaMkC0rwY8Tz9oHlgvrlDpA4F
         sk6AnPf2+6XcZiXNmn9VRLOWtrY2tGxtJRcjwBbKj/vzPuDxQufYaAyTmOsnvxbO9Dnj
         a+U4LHQ6LOHyNHtcAF4tJikj4uFwDsZLi9G38pDS/kab/x8KH9I73QzgFJkGW7p3EUT3
         60cZej1YfdcctzaAQnqXvL14xxhMG5gXe7Mtyjt7fSn08oHzm3ZMaEt4d6owkSoWK4jP
         MNW8GKurDAnrF3k2Tztu4whNVqolTw9Fa7PAG5pgI0YkO2VzuxTi/D6Fkxi3b2gl8VJL
         SNqA==
X-Forwarded-Encrypted: i=1; AJvYcCXbXP/Qbb8stbR8iMCTNuKpeVGF4BhzSFzqMTJGbquVYalABkwY5vyT4mL2A2sKGYg0m9otgPlHILa0epk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KYlxcKti4k5kg6giLg+HasD6aTLHhs2AEj5jBiv8N3X43MI/
	3J5n8P8fidJxFh57K4BftbqaKNzm0vRTD+/QwGW3NHkku2jiUxOG1COEnFUfogOKmmolJ1/OeTK
	xUTLOGOX9lrTYHqFUQHRyFm8m8GiGeudk9Kta3kXD
X-Gm-Gg: ASbGncs55RMgQCWl99Iq09kQP7/j+eN8DIZ83hpfYiTnB/BLlchRWRm6rNqY20Dvuou
	i61VQf/VqwrodYiYPqilJlDcd4Ei8MAlNoB8HgliVE3SI4qQhBHbxRO58cKmL4O0swtcAkrhWnC
	MtzPj9AIJyOUEAi731fyRP2edAcdq9ZYFjaRDTLHXZfdFr2jGyYmMcOs9wFNrbxip0t2thw67py
	v+K8fN4dV8rTbA=
X-Google-Smtp-Source: AGHT+IEtf/9wf7+2/c/rNT0NYgi10xYmRrdVN2JDXyvdU2/6uZzQBPwxIFBBNmJNsr9XwCc4R2Dzkd9jHijR6MgVSrc=
X-Received: by 2002:a05:622a:47ce:b0:4b1:dd3:e39c with SMTP id
 d75a77b69052e-4b2aab467c5mr152508311cf.63.1756150417382; Mon, 25 Aug 2025
 12:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825190715.1690-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20250825190715.1690-1-andrea.mayer@uniroma2.it>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Aug 2025 12:33:26 -0700
X-Gm-Features: Ac12FXz0I9GuTz90X-rPTA1ZksZsbDknybu0BHszaMYs1YDI6C_dwuD3QVo4i00
Message-ID: <CANn89i+UTv8nJ=cc67iKky=MLXOnzF5XyVRsV-TMXz7wUQ6Yvw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: sr: fix destroy of seg6_hmac_info to prevent
 HMAC data leak
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, David Lebrun <dlebrun@google.com>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, 
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:08=E2=80=AFPM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:
>
> The seg6_hmac_info structure stores information related to SRv6 HMAC
> configurations, including the secret key, HMAC ID, and hashing algorithm
> used to authenticate and secure SRv6 packets.
>
> When a seg6_hmac_info object is no longer needed, it is destroyed via
> seg6_hmac_info_del(), which eventually calls seg6_hinfo_release(). This
> function uses kfree_rcu() to safely deallocate memory after an RCU grace
> period has elapsed.
> The kfree_rcu() releases memory without sanitization (e.g., zeroing out
> the memory). Consequently, sensitive information such as the HMAC secret
> and its length may remain in freed memory, potentially leading to data
> leaks.
>
> To address this risk, we replaced kfree_rcu() with a custom RCU
> callback, seg6_hinfo_free_callback_rcu(). Within this callback, we
> explicitly sanitize the seg6_hmac_info object before deallocating it
> safely using kfree_sensitive(). This approach ensures the memory is
> securely freed and prevents potential HMAC info leaks.
> Additionally, in the control path, we ensure proper cleanup of
> seg6_hmac_info objects when seg6_hmac_info_add() fails: such objects are
> freed using kfree_sensitive() instead of kfree().
>
> Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structur=
e")
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")

Not sure if you are fixing a bug worth backports.

> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6.c      |  2 +-
>  net/ipv6/seg6_hmac.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 180da19c148c..88782bdab843 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -215,7 +215,7 @@ static int seg6_genl_sethmac(struct sk_buff *skb, str=
uct genl_info *info)
>
>         err =3D seg6_hmac_info_add(net, hmackeyid, hinfo);
>         if (err)
> -               kfree(hinfo);
> +               kfree_sensitive(hinfo);
>
>  out_unlock:
>         mutex_unlock(&sdata->lock);
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index fd58426f222b..19cdf3791ebf 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -57,9 +57,17 @@ static int seg6_hmac_cmpfn(struct rhashtable_compare_a=
rg *arg, const void *obj)
>         return (hinfo->hmackeyid !=3D *(__u32 *)arg->key);
>  }
>
> +static void seg6_hinfo_free_callback_rcu(struct rcu_head *head)
> +{
> +       struct seg6_hmac_info *hinfo;
> +
> +       hinfo =3D container_of(head, struct seg6_hmac_info, rcu);
> +       kfree_sensitive(hinfo);
> +}
> +
>  static inline void seg6_hinfo_release(struct seg6_hmac_info *hinfo)
>  {
> -       kfree_rcu(hinfo, rcu);
> +       call_rcu(&hinfo->rcu, seg6_hinfo_free_callback_rcu);
>  }

If we worry a lot about sensitive data waiting too much in RCU land,
perhaps use call_rcu_hurry() here ?

