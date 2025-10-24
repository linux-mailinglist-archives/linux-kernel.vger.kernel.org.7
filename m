Return-Path: <linux-kernel+bounces-868774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9AC0617E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3A357899
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90E2D641C;
	Fri, 24 Oct 2025 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THBKORSJ"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA22C324F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306611; cv=none; b=cMVHYNpCHVXuKkJziAdeMa1ZO0vfuyENeb9lpSbY3c7S6G9Lrfrm5NPJF6WxGTta1MaXLNB9kVGGpk1kjz+AQUDfW+BmznXeAnamgf5mJ8OiVswXG1stjt0yVrJfqNEnj/wdBxXkT/p73zf1d9Uh2RbyPFKu6g6lAfUpUt+ROjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306611; c=relaxed/simple;
	bh=JyNPoOflrd09KImJzGn+Oa6R2et+UXAyI1HgrMWnlrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLt11PPe3Fs3h/9ZTbEwSSI6gyp93DCggEwLnYHO30rQnQSqTz3JdLHCrEb2u/XnRzFnLesmFubSt5SEbfdIx5ENqZzOWucQ+FOmpC1p2OpyGPYaKJ2w/tnevd3O8RzeTPj17xY/LC1FXGLYuDhgcri7an03b9T8BykPDk0vP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THBKORSJ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e1a326253so2141937d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761306607; x=1761911407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPu7vN1calUWS9Gz7jrsKnKSCyFmaW2kq8XMxDii/Ww=;
        b=THBKORSJHmb2r0wEkEg4vLDxBhzZNXJ06lh/v4ndf7RrKUw6f7FFFU5n+wbq7o+ONa
         lyR3opdpVcoz34/rnDcpAHwd+ovhsoxjbIXgyfp0zWu0chNnDxPnKmt8Pa2rGPoxGFM3
         S9tKWGvPHRex65AJ7zDwUQR18+Or/TDmtLbvcXrqUrxXMZTdcVASJ8MNZm+cPisyrGt8
         ymsZwaVkrdBtVWn6Z+nTb+L2p2qxsoBgxUQpR2FHhBLR5+1llqVV3Q/d+8n5bJAThEWZ
         wDqY/TigG7de52PcbeFDWcri0KF2ngxwd5+Sm3sCDVfGCbbNs34MKsvxQDaRmy2GnOY5
         psOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306607; x=1761911407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPu7vN1calUWS9Gz7jrsKnKSCyFmaW2kq8XMxDii/Ww=;
        b=lg7RIV6L3hpXGyA7PimWjM2K4jgrE5S60uAffH+PKj1ijjRUfn18/AC6cr9mB68Vks
         AKJ6zw+gUd35CEJ3aeqP3/k4/J625ntWft6e+qfJzwMgHN9OOPN9L7O8x7cOpIo3TvNn
         BXW2dLb9KBIfHGyKlNAyxH3juhMzb1fvnJnmWLU2RZcD6TMOf7yNiHzom/H6pcrcj+5o
         F48qyAC/5WjyAsJAaKmdnJJ5+0jhWrxwFoOohPs1fsDVYJTGa/Mqb3BiftqRCGVW3cq6
         Dwl9X9kOMxk/uvF5ojY8Z6YVr+VLdqcfA3SEra+zpbYaiGyISjaSWRXu+lLegrpFo6+s
         oM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3W/VYAzq5WUYIpE0d+MelJdDgZlGcVmKeewhleQBFPZxQ7qP6LYQpy6ouFshpHKOF34lk+Fkmk5JIEME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEoIDIf2+HmYXzx6XKuk8JHkoJU2/pNV77NH3BBwR9KIsqqRN
	qbyoSHOIrpuffICctJ1L/xUcznGi+lwldePVfna9HOlcxjB4wrIYaiN1doyNoSIGwhOACaUrXbv
	8Qf6P2y8Qu9a9bJfHXJTJ8KFdoDG3LKEjYGhbkCGr
X-Gm-Gg: ASbGncudMHhQMR5ZBnZxj6FRJplLepWyP8xmR+aBgkM8e+mCC5uk4Ordm0woiSEJdTF
	lCEaDORzvJgXFDuU4IHf/o4QHThRxECL55bKFEAqhZ/+NQPWv7ROeO4eKAwPepGIq5j2x5Y11hV
	GM5Heisc6JQPZpPO1bkhxHJXvaH1pws40CUfi/g1JDFFnrDiSjAhFXqL0BrtStZQrm3fLuADwT8
	uXuTWRfz4tVx9W5NJR/BbIqfnv60DCkJpA1a51bZq2sUm2HG6Ccq6pRUjjXnkYD5ZB2wA==
X-Google-Smtp-Source: AGHT+IFiXZPFoW3XumCylfcB7j13+foGPrt/PBXHdC1d5im6TR7Pl10kLZ/EEoKE1RNBjalMg75qFAT+YfmAMkkUFZ0=
X-Received: by 2002:a05:690e:1c08:b0:63e:4150:4a0b with SMTP id
 956f58d0204a3-63e41504b4cmr12608126d50.64.1761306607028; Fri, 24 Oct 2025
 04:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024093901.1202924-1-lizhi.xu@windriver.com>
In-Reply-To: <20251024093901.1202924-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 04:49:55 -0700
X-Gm-Features: AS18NWCyXWglYAph4MhDJQMx_rCfCfaeUc5A_R94Ms8hmdKV9GKUS6s1Tfgfq_I
Message-ID: <CANn89iKxjOPyP7h-8bCtx1SwCM1FaXDAXfcdCW7uXxKsy49L3w@mail.gmail.com>
Subject: Re: [PATCH V3] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, horms@kernel.org, jreuter@yaina.de, kuba@kernel.org, 
	kuniyu@google.com, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:39=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2=
.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat=
,
> a UAF is triggered.
>
> To avoid this UAF, defer the put operation to rose_t0timer_expiry() and
> stop restarting t0timer after putting the neighbor.
>
> When putting the neighbor, set the neighbor to NULL. Setting neighbor to
> NULL prevents rose_t0timer_expiry() from restarting t0timer.
>
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_a=
x25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
>
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>
> Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: Putting the neighbor stops t0timer from automatically starting
> V2 -> V3: add rose_neigh_putex for set rose neigh to NULL
>
>  include/net/rose.h   | 12 ++++++++++++
>  net/rose/rose_link.c |  5 +++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..33de310ba778 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -167,6 +167,18 @@ static inline void rose_neigh_put(struct rose_neigh =
*rose_neigh)
>         }
>  }
>
> +static inline void rose_neigh_putex(struct rose_neigh **roseneigh)
> +{
> +       struct rose_neigh *rose_neigh =3D *roseneigh;
> +       if (refcount_dec_and_test(&rose_neigh->use)) {
> +               if (rose_neigh->ax25)
> +                       ax25_cb_put(rose_neigh->ax25);
> +               kfree(rose_neigh->digipeat);
> +               kfree(rose_neigh);
> +               *roseneigh =3D NULL;
> +       }
> +}

You have not even compiled this patch.

Also please carefully read Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).

