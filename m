Return-Path: <linux-kernel+bounces-799537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EDB42D50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68F97B8843
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91FD2D8798;
	Wed,  3 Sep 2025 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GAmlVTOx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B627380A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941781; cv=none; b=JofVjsZnBPXg1TQLuh1RfdGF/WbRosQbVvKsGdeUFZsTtiFE8ObmUsL70vfROjapF0wqCJDpbRAJAeogh3cQ0Jr6k+1ioJ8j8IWRgnOVe6mVR10J9wV/sxQ3YjoCDxjWLXFNCts7NZIrlztrbuSkILcXaMV05bVKT4Jg7N93PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941781; c=relaxed/simple;
	bh=r2tw/SXKsViGJosKPqa46gpirEWHmAwA16Ckt/uA5bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8ltVswX3aDBt5VIhL5t/Il2baDVA0EESb5iAsPAT5IVf45vt0QNhcaf6RA24Wn7rNKWJvNSdr6aLCrgHuY/89CIxfh3roO2R4auLphy1LTni1FhT0lK+pgGRz1CBWtVlHREZnX6e0m5NcLp80qgcQlaehEo7xNsgJQf6AkfNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GAmlVTOx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7722c8d2694so441413b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756941779; x=1757546579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4XIWP4mz0mOkbzLcWDjXBPjad5L7kQQIgQS1CIcJ6w=;
        b=GAmlVTOxtuWlDVWagPxBZGTlySkp96SH66DodT35+FwNqzOJp1mLmRCuHOiDR9JrQi
         NAa8Haaz8dLtCwGcCu3N5TdeTDSaMb4F3ehwlsuAaioU4BwNIHg6WJ7IBbd2Qt7p9iUE
         m8dyzwrHWiZvXF7FlNLWLqno9h95Dyktr9/O9Na6NkxC8tUXu3t2a+uNAB7Shn5ubzed
         8jx3eLmgRO9su3SSW+se+o2AUtKc+B13/RXYuUHNMnixIvqeB229Hqe3V0WL3skSeJN8
         3oorte4cgxHI2IoghR800+cVIZmgvudFnaVcxYMt5j7h+8ZSexPiR2dmMs1uA6US73YU
         W9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941779; x=1757546579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4XIWP4mz0mOkbzLcWDjXBPjad5L7kQQIgQS1CIcJ6w=;
        b=A5saIYSaU13mNlAz2rVNP20tcPEtB8+k5OGZDp0WIG4Vy06LqZ01VI7ibEojfnxaPR
         39g4J3ELkGkWogL1bisI0Kj7laL9YrnWKiMnYp3AKWJUGsBV/3KlubKorx3Auiup5t+V
         nCt7aE33SlLwfrKkn0rdtnT4ll5yL445k4jbgl/dQegdmKIS9fEEvZwsPLLtXjVlblMI
         T5tL5u4Iu53M/3pzpKItWSswrWuyZTNKqKhapSFzcN7pFwtr2rKEKpElkNKqleDr6Cwc
         o9lBuzkH2geusDryNutPUBkS4hlLGnx4Ixv1C3ZRUFmz8/ct0CjGdajNeyRsDigMd3/L
         eK3g==
X-Forwarded-Encrypted: i=1; AJvYcCVjA7U9u7DhECEKqwiNnYK0fsZGlOqp8F9GuVstwD1LdlB5dDbKMT7RnQYki75T33/6ypv60WOhK4Oi4B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0uf5jhZk3z+4tzbQ6dlUYviVvdhmtHU8aINbpJUVyEjJRECs
	XDQorEaOjMYRNRCoOiGA3WRfmfhHfneJcW28pxHhY6NKPWkLPkTQYaPLpZsA/LUjO5212NQ1L5W
	7nE8CA5fkYb0JMXIozuDgi4nzC1VYTZmokxyMOYHu
X-Gm-Gg: ASbGncsqjqDO4h/fmCVsoriknHBcIkcTEfdR58xfeNhDd8tmVGizDxbWbePl7QaOHFD
	e63WsQFwp3muWBWliiavgcG2HSAXhDVFSiR1q/5dYbpn/4q6ncrTTKMOH4HI8/MJHhOnvvRLnRE
	GlZGt9N8N+a9GBawKRa97OjEDbazzGZLxpXqo4+iqoChLZhVvdJtIJwRj70LU4Nz+1eEtiTn5eP
	oKd11JskPBeziW0AAVHQ45G7ISlxGSka7Mflz2rg2PQfGS5jnvDq72isdG52RrQCr+PLBSI7wlG
	q592gIjCUbfrJh5zqkiNUrsiNdvJ++Oj
X-Google-Smtp-Source: AGHT+IH9MjGeox+wSgTiIMBeKsSu7LetRxaQTb6E/Q/TtqttUThhXc5gLE93MsmjwoVe3/bGA3nnvBy9ymVgyancptg=
X-Received: by 2002:a05:6a20:2586:b0:24a:8315:7f2 with SMTP id
 adf61e73a8af0-24a83150a75mr1841811637.49.1756941779042; Wed, 03 Sep 2025
 16:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
 <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com> <CAAVpQUCiaQ7yr+5xLYVaRp6E2pzNDwSiznEOkmd5wS-SAosUng@mail.gmail.com>
In-Reply-To: <CAAVpQUCiaQ7yr+5xLYVaRp6E2pzNDwSiznEOkmd5wS-SAosUng@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 4 Sep 2025 00:22:47 +0100
X-Gm-Features: Ac12FXzVdH0aYM16lsXXLkWflOvz9fPrPjqdH7hlsGgyEtSmdjfndIM56Q9g4_A
Message-ID: <CAGrbwDQVeE=-gVNQhWZ_YqsMRTX=2B49O7k3j-FjVHCLrTWUnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
> <devnull+dima.arista.com@kernel.org> wrote:
> >
> > From: Dmitry Safonov <dima@arista.com>
> >
> > Now that the destruction of info/keys is delayed until the socket
> > destructor, it's safe to use kfree() without an RCU callback.
> > As either socket was yet in TCP_CLOSE state or the socket refcounter is
>
> Why either ?  Maybe I'm missing but is there a path where
> ->unhash() is called without changing the state to TCP_CLOSE ?

Well, I meant "either" like in "*yet* in TCP_CLOSE or *already* there
(being destroyed)". Let me rephrase that as I'm going to send v5 with
your suggestions for Patch1.

> > zero and no one can discover it anymore, it's safe to release memory
> > straight away.
> > Similar thing was possible for twsk already.
> >
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
>
> Change itself looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks,
             Dmitry

