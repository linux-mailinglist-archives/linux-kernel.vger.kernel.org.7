Return-Path: <linux-kernel+bounces-880236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A47C25294
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 685933506F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A834A79B;
	Fri, 31 Oct 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGWTOgvT"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E0343D72
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915901; cv=none; b=k0ISWb9WHqOapPbvDmT2YJD7p4/+MVtOFdYMNdwtsuBe24P/YFkrm/yUj6KpNsUd7rvrxgsgmiwkJlnRFtRUAGaDri5Ss8PblqDfLdZA8s4slzFiDeYdIXXeOtmEI5umnu8ouD+FE69sMFtgUrOJn78uPG5Bs7wSYOs/48rxxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915901; c=relaxed/simple;
	bh=ZXkLDTr8nSCVJ26GqbMBd9kDRvIEMx/HbigcYuaDpnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At3QlfTsvejExOo5iBdcodRM/N1wI6TGTpRhkEeIyGOT7MDSNqEionqGB0AqJI2OOJ6wZ5ByPzany1DFKclFcd7uVebFszqyvB8anmD55/i4rQRWEEzStiFB8iKVFgQMQTnmvvLTzUiJU9V261yNsq6KD50f6fkI7RbHkIAoAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGWTOgvT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed101e8496so16516401cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761915898; x=1762520698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDiDynQdbM4YCkifi3qZwLvI//rX+qgG18kLYdtT/4E=;
        b=zGWTOgvTB3D/F66yiJp5yMOyuYmT3GOWJK09pjy7HAD27axObslNoBdhL+1clNj2iE
         no2NH/+gS2aW5AuBgoXJNVx5f7OeCaeGtaa93ET/ggb5vdTnEyu18YGIkhFPkkhcVwdV
         5Gd+uB8RZolTTjthq8iiA9r8xfuIMbXNlRvPmP/CF5g6qDmJUNX/WY98mBwuGxe4y2Bn
         jEZ0G6AUEeZIJTxsm+xXcrtygNWhxhsUgfUnNe8iQ5ya2LwRnpTCN2M+dk/l9+1nsJ35
         x2BScEfgyc5PqcAA4u5Fdv3XoR9gfS3LhHtDvyCq2lobQ3aAKu7ni1bgtHeZs5p3QVzg
         8SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915898; x=1762520698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDiDynQdbM4YCkifi3qZwLvI//rX+qgG18kLYdtT/4E=;
        b=wMHs5VaGc3zhAc0+08nU71+nWD47gwfrFLo7KMtuf+nCrVPV8UKvCKMAsniR9h45uL
         ZlJHSNYYcrKr2l+EVaSxMreRFJ53Cix4kG7kpB5G7cG6v/mEiNxvHX1o+m9Rjoldt64R
         Emvt1a4yKeQEQAXp4E/CHzNeeYBgsFMN2hbtjbW6D9JwqFcJGG1TRa4Koyk+gHtPxIre
         ELwgX6iR47FP8hbI4HwdJ9I5mCmrlQn+ruDeaYE4f4dSAkr0zdfqZ9oKCUUZTLcQ/Bc4
         Uh1ACIrKi8jVuUYB+ZMFHbqYDyRXUPIxbFSsQdiJTFaU4nmMjKOI8RBLFKCBd7oRqLK9
         MNFA==
X-Forwarded-Encrypted: i=1; AJvYcCWI9xaZ4dsjMGsVssHKUY6wtZE/80EkqecQXpN9lCvjTsjMxJWsXtxRGdkGsN+py5rAbzdzSiy9YPPYf1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Q1WEr4zkE74ZNa2D7dUM83rN/1jIPQg1ODp5aZFOVBE3O42Q
	knF0bcSAgh9fo3QVDKyLMo1UPhNlBmVF2pGYQltkonA98suyM5cvdZXTkieFOmVwqUO6YR/5DSj
	0YIE9s7bT5FVds0VLKh+fvThUN8YP2Bvd4iELxh9G
X-Gm-Gg: ASbGncvNDlu6rA1+mAI/zWEjFpOyKF8ZjqZ70NNOqGuktVTHM/15/7MLwGtVD8pU4b0
	tdPIsbb6TBq94HECAXdnQoilEGAq70DDPiShBG6+nIjijDxx2BXZPDb1zHf5L8tTKuGakoZWoJ6
	h1Bud/Rn/ooOOdmklGfD0fVBtKomG8pCg8wVLICvmx3SkROoAT2PEk+V6COYfiY2d5a7yBgcnAb
	b3H4lNqMQeH+D0iKZl4mHgGRwqjnTzLmqXUKKZ8TlkQpHg5LRWS4+Xv6ok2ru/G7xVNgWo=
X-Google-Smtp-Source: AGHT+IHegrj0d0o9bzyKTvokwzDp4oyCK2YZvXyBZt7oa/GcTr6PrpKIl05o7IhuEsdDpdFZDAMZ3HEW+TjxbJ0bK34=
X-Received: by 2002:a05:622a:4106:b0:4eb:9d8d:2f24 with SMTP id
 d75a77b69052e-4ed30f9c8camr40022091cf.40.1761915898124; Fri, 31 Oct 2025
 06:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-infoleak-v1-1-9f7250ee33aa@gmail.com>
In-Reply-To: <20251031-infoleak-v1-1-9f7250ee33aa@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Oct 2025 06:04:45 -0700
X-Gm-Features: AWmQ_bnXpmkVe3zJAzdYr8G9bxgCyUuK6HP9RyRDjUsMT-RKlpN9aPLHRuGIsyc
Message-ID: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
Subject: Re: [PATCH] net: sched: act_ife: initialize struct tc_ife to fix
 KMSAN kernel-infoleak
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:24=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
>
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
>
> This fix has been tested and validated by syzbot. This patch closes the
> bug reported at the following syzkaller link and ensures no infoleak.
>
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: ef6980b6becb ("introduce IFE action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
> ---
>  net/sched/act_ife.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 107c6d83dc5c..608ef6cc2224 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -644,13 +644,16 @@ static int tcf_ife_dump(struct sk_buff *skb, struct=
 tc_action *a, int bind,
>         unsigned char *b =3D skb_tail_pointer(skb);
>         struct tcf_ife_info *ife =3D to_ife(a);
>         struct tcf_ife_params *p;
> -       struct tc_ife opt =3D {
> -               .index =3D ife->tcf_index,
> -               .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> -               .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> -       };
> +       struct tc_ife opt;
>         struct tcf_t t;
>
> +       memset(&opt, 0, sizeof(opt));
> +       memset(&t, 0, sizeof(t));

Why is the second memset() needed ? Please do not add unrelated changes.

Also I would also fix tcf_connmark_dump()

> +
> +       opt.index =3D ife->tcf_index,
> +       opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> +       opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> +
>         spin_lock_bh(&ife->tcf_lock);
>         opt.action =3D ife->tcf_action;
>         p =3D rcu_dereference_protected(ife->params,
>
> ---
> base-commit: d127176862a93c4b3216bda533d2bee170af5e71
> change-id: 20251031-infoleak-8a7de6afc987
>
> Best regards,
> --
> Ranganath V N <vnranganath.20@gmail.com>
>

