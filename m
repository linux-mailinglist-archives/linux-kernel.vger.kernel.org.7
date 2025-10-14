Return-Path: <linux-kernel+bounces-852339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4CBD8B76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEDB18A7B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C532F49FE;
	Tue, 14 Oct 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEVRacHY"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED02A2EAD10
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437159; cv=none; b=QnR3QQrbynsv4INVKcBnUGjQtd1/3RRDu8z6E9O7c5S/dXytV945EJXSgDnE7Oe32YVRpVrSCMNwgwTXegpdRZfSDgSpzTKBsPNlNq1oBjOGYZO0V4oH6NXYvmUq+ChWtBaUk77+632D/WsiD65vsPZl/lt216+Hd1IUFP5vrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437159; c=relaxed/simple;
	bh=XX+rZvIXhJtvIL7uOxz4xW1dsb6uuqCSyoLnZXBNsS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf45c0yb6A+hjqIv0dZEA5HxLIxRstr796Xv/iRPT3P51P8aHEARvT3N3S2EvruNmdsa1mlbYOJZ+PXKS7UOaNkxfsbgn1HL7DtN3mBDhW/l9YGfXmsNxlRgrSq11ueuC+ceqy31MBVFitB6XUO2CHvXuiBeJoVZa8J8S7dBHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEVRacHY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8608f72582eso347914885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760437157; x=1761041957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GhdPCYEOIPlUxhGKbw+Pmeq+R0XeZpDT4H4TE9DD8w=;
        b=YEVRacHYlyKqcZVQlt+WexZtwvOXk9UVLKgP64Ayn+4XASsRHsLO+WmxzMgxa2qbwb
         +Klo+CPTmMljRK0NC93SlWyo5I4DN2CKOt3jcNoKRC5ECZJTJArIWynlreEyj2O0aWPX
         p0hN2N8LMUamDTzii5ftX0BvrfmtK8DTOiGJduZvwkTtW3PohHRrKUoEmBsy5FZOGGlk
         DG0B5gYdfYNHcrmNwarcueAnlXBzroNzwe177n2SIWa8SkA7JGyh0N+XznpVRx7AMnrI
         a+5rbFzUlJqyuE6YgYQo8rTXcJ5icnTxVVZyGdePtHzc7bRYSdKtD7jzy520WkJB+hox
         iPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437157; x=1761041957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GhdPCYEOIPlUxhGKbw+Pmeq+R0XeZpDT4H4TE9DD8w=;
        b=vY0ljw54hWHjNGqaL7xdxZnmPgKqLgHzHZpQXSjWuvny+jVKPxrxGlfXRnEvBU96C+
         +RPLn52x4P81ofTJRx6+ER7Q32CXr6ceof+/XWWwlippfmwzu2NfKP29oSmb3P3CTmrs
         jQHkF5TPSWrCM09V8etVVjNrIlfZFoT4YJH7h0pS/7CegncPNKfmziuztmmu6u3kkAIR
         kL+Bb4vaGH6S4OE/7MpsdX4qDPC4ONrf4rfgyQqiPI4NHq8Q0NNFBFc4s0T/NCZXLscD
         5uUfm0Byj96NEATEtpgTG5f3KBTb2OERH2YwzJHVKB/ng36ydDc17sH9FHOk+jPjZcnm
         oBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRiQhOWGlkNqKNURuhVfiNRWPSApzMpJ0Bm7N0DfptL0Rz78q6Qu5/jt0jYK12RDcai/CDVpBu+wlGrKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvUp7ZUx1427AHn303JixLKHzFtzBusTuKqF0sutQdIbtCspj
	MI4uYu3tbBR8O/xvYGgHJqRoGZTzUEMl2Erovte+wMDEPLSXqqjkuiwCUVTPOgfQG1N8jLQE8wv
	nXJwFec8TublBFkYO6WzWKCgBNUkjMuk=
X-Gm-Gg: ASbGnctr1YDEkxIbk6pjf0LS/KdQPbpJyhThk74iCtK56f/w16upHrt5xzzuHx2AB4H
	sske75ddMHmS5x/Sirf4xgKdJOceZv+stgA3Ie612pXZUXU4jy7nBm9lRB9yRHfV+iGZ9YqITKm
	qaMtGV4z4owJHT6JlMiXi4NVlQnOc9OwaNIkpCB/GMu7e8P9VtySpK9zQGW7uMQjDreV2K7zA2k
	jic4c5+rksYjuVBX7DeDi84Upf/Hn98aibd4Xkq8NUsEOTm2sC8CupVAimT6qiNwZih
X-Google-Smtp-Source: AGHT+IHkG+3MijbAqPzBuX6WT5qM1UH5wFEx4+o96mRJarvePfqJF8HiiyZhUvW6BxCxk3W2HxXrCx44GyONpuhGsYg=
X-Received: by 2002:a05:620a:1a82:b0:864:c4b9:da16 with SMTP id
 af79cd13be357-883570ce5e8mr3684480185a.73.1760437156675; Tue, 14 Oct 2025
 03:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com> <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
In-Reply-To: <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 18:19:05 +0800
X-Gm-Features: AS18NWC6N5v2tw8omBV7hBy3g3GX8bmzsyDFnwNBZ4EEXltiuUXlhijttlnObnI
Message-ID: <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > >
> > > I think you are missing something to control how much memory  can be
> > > pushed on each TCP socket ?
> > >
> > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > >
> > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> >
> > # cat /proc/sys/net/ipv4/tcp_wmem
> > 524288  1048576 6710886
>
> Ouch. That is insane tcp_wmem[0] .
>
> Please stick to 4096, or risk OOM of various sorts.
>
> >
> > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > 4294967295
> >
> > Any thoughts on these settings?
>
> Please look at
> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>
> tcp_notsent_lowat - UNSIGNED INTEGER
> A TCP socket can control the amount of unsent bytes in its write queue,
> thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> reports POLLOUT events if the amount of unsent bytes is below a per
> socket value, and if the write queue is not full. sendmsg() will
> also not add new buffers if the limit is hit.
>
> This global variable controls the amount of unsent data for
> sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> to the global variable has immediate effect.
>
>
> Setting this sysctl to 2MB can effectively reduce the amount of memory
> in TCP write queues by 66 %,
> or allow you to increase tcp_wmem[2] so that only flows needing big
> BDP can get it.

We obtained these settings from our hardware vendors.

It might be worth exploring these settings further, but I can=E2=80=99t qui=
te see
their connection to high-order allocations, since high-order allocations ar=
e
kernel macros.

#define SKB_FRAG_PAGE_ORDER     get_order(32768)
#define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
#define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_MAX_SIZE)

Is there anything I=E2=80=99m missing?

Thanks
Barry

