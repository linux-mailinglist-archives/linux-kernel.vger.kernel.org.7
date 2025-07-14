Return-Path: <linux-kernel+bounces-730505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE6B045A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C07AF45E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6154262FD4;
	Mon, 14 Jul 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3nY4kX4"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2325A34B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511188; cv=none; b=ib9ULIW05zR0ZKbeUgZVCkOUWRZTI3GLNgKt4bG6V7RwXmbwTFuaEofh8saoYeBOSuLs+3B2dDgxWIWFnm+VLcHsG2B3eMEJvHZSW3mFzHqW16aPnb59x3bV1jzrVk46T4Q6esRjGVbNzflnIvb7PpniCjlX1CI3benFPZEzcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511188; c=relaxed/simple;
	bh=nVGZfVvmnLc3ZSNSNApCgVpp19nDe5r2+SDjdGuL1c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dffJ+yaUuOJWqbkblzuwoaLdK1HphBq6KcY+4E9c9FlRQEyE/fYz/9D8NqPVI9esaftykASNvnSus7u4qJbYw9ikUG/ZZdvVrdBrCbGypIqD7RIIa0XZ0i9ICI1cL3KuR8VqgeqwYUz5S/jaJxymh4BQWZ6czEfiMxgfSeKwOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3nY4kX4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a8f69862so3695105a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511185; x=1753115985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX+NdQT2VcB2DI7YKmKSFArOzHaTXAju68p1bOFs5qk=;
        b=m3nY4kX4hjZTfpE9chtiQmSDABnDeqF8w8Qr3/cajLstFh1v/xtfq5c1zQxHQ8vxI6
         nwwbBka3PKsMrwcPXNwD8z/XFvlVjnFkVD/PNLl9FmF3mjazNAnqlguG1tmsRD5w6lKy
         eFsTsYo9jWNqfMqnzKwHemNJOg22A0rh63wdViyVEixt9jssjJwZOBtJFrJS12VLOHgC
         6RJKKgwwkvO7QeZI7HFpZvhKsexdmqjqqprt3o2E1pyLjq25gbLAieIWU3E3/Fk7SjYD
         d9oKu+QaKiGWkeG5t/pr21tOOPjPN/5DJW12O9dbDlW1qe0ZUEX9pBCSiaJ3iV7RyDvI
         Yf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511185; x=1753115985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX+NdQT2VcB2DI7YKmKSFArOzHaTXAju68p1bOFs5qk=;
        b=iVAil9+VLDbqN4C6Tnw/iOqcwJwI7qp0RBrkH8D+6HkiU2aUBp/9oig5q03Ars1Jnl
         Y8ASCPOP3u98dRbyiBeqBkiV9Nh0e6/U2bl4CvL85azrvXOFlAgqnTlv1IqN3Gol4S3X
         67fcRUiWqTJ8eUELjK3fCjWwXngQSr+1FI45i1kjK0nSoI+qH1QTSyzUpE9t0nfy36uy
         IOgBXyzZEzNU02iIiLJbnrrMDDPCieyV+uw9ENmxXJ5U0pVpmyTSxUXKRK9OEL33ourV
         d90PzfmsHbMAes3LFDUEa7k1wjYe//mma61m08zj8HjtW6xLNssi0DW4UQuijZjK1b9S
         48Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXVqSESNeG8XOLuiTMNlcYoLvZrgtyrTMDOSSgZT7bgL4XQNOxkmasaJrqb7OCfOCStUMvWwOw0uQ7DWfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHRzLOOTqAYg7HxbGJqlqpINFzGxJXjCT8oI32eb/OL4TJ5gV
	/bJUILyidUAZPiUNbBejnmu7C/k2HWLtd6TUi55CI/dmyMLHat3PPdsWsVWNhMaIboZEP6g+lzY
	52bD45+17/m1E5yeAGK/QSdU4gt5vEfq4O2bEh0YB
X-Gm-Gg: ASbGncvBqDtxSug6PjdMT23OHNxjcaew4rZ40179d0tvxMcXvdQuaN1YjuLYw7a42A+
	KWe/z1WZGL8YbkGssQ6FWOpv87J1lVPGNxcG3Hlwf4c5lsNmQiBBBEutsfgjWxfVPIl9iJ5Dxzz
	wtT4v+rofN11neg2VdZGf/AmDwVCs852tiluaafZm4yi5ovvmI2kkgmWhhqkcYyDVLUQezYLian
	pz/hi99U8upi5RfkoYPI287bwBlh2rRa7zYhoigr5Jr2SZR
X-Google-Smtp-Source: AGHT+IHuvzV1B5jmmplYRcd2fSL9lO+HJ9iCoILBY6Q+z+Ye/2f/3tqKbg7MoipTfaHsyTSNRtE3BYb2xb5g0IU2l5A=
X-Received: by 2002:a17:90b:4b84:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-31c4f4b8228mr20540049a91.12.1752511184340; Mon, 14 Jul 2025
 09:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714081732.3109764-1-yuehaibing@huawei.com> <20250714122927.GM721198@horms.kernel.org>
In-Reply-To: <20250714122927.GM721198@horms.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:39:32 -0700
X-Gm-Features: Ac12FXwFDVrP8a5a_KA8U55jsclsAFnwWq_Nmf70ytnDDTXqm8tVAqn6jh6e6Ys
Message-ID: <CAAVpQUC4=c5w4wWMnU+DTkzeuWBnw1uPdFrfn7rDchrHvsGVhQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in ip6_mc_find_dev()
To: Simon Horman <horms@kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 5:29=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> + Iwashima-san
>
> On Mon, Jul 14, 2025 at 04:17:32PM +0800, Yue Haibing wrote:
> > These is no need to check null for idev before return NULL.
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > ---
> >  net/ipv6/mcast.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> This appears to be a side effect of
> commit e6e14d582dd2 ("ipv6: mcast: Don't hold RTNL for MCAST_ socket opti=
ons.")

Exactly :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you!

>
> I've CCed Iwashimsa-san, who wrote that patch.
>
> But in any case this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index e95273ffb2f5..8aecdd85a6ae 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -329,9 +329,6 @@ static struct inet6_dev *ip6_mc_find_dev(struct net=
 *net,
> >       idev =3D in6_dev_get(dev);
> >       dev_put(dev);
> >
> > -     if (!idev)
> > -             return NULL;
> > -
> >       return idev;
> >  }
> >
> > --
> > 2.34.1
> >

