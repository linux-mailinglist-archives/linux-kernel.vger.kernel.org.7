Return-Path: <linux-kernel+bounces-851818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00DBD75B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF901405B09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB7235041;
	Tue, 14 Oct 2025 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lb61Ez9F"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BE4A3C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418282; cv=none; b=DA7cl4pS+wufLosZZcx7xeXwzKxZbX6U4nUEqWvLl+6tYEC/Y4FaUpdwLEv6YtAzomlHeDwqmnOJta3AdHoRWbUSr2X+s19T7KFyKqLVC19kv+dClFvGGvdsgilQOxfsMfAr5prvytB32n2widLlLpOWaZ8zd2paQ+FrUfs1TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418282; c=relaxed/simple;
	bh=S4XKHgeq43nkiwFR0wRXnBxbDhoQpqFTDLiyK1HwUwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNMskaYiRfCsOak+8wZgzoN3WE87CpmM86GmqZ4ApCJAX96DmyDhbDu76yiQIj6g7IGnWuwsPKJDNAz8QB8TfJ5DkDuQnCoHFxxbE1ZRDTHne14H5ylmOcHWh+pFBoy0SpJefjqGxrn+8PgJegenQtsM6foM2XMKOQgVgCHu3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lb61Ez9F; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-791fd6bffbaso77152936d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760418279; x=1761023079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irzV2QUfJJ8dqUzMZqecWufn5bUU0255l1546dL2h1g=;
        b=lb61Ez9Fs5sxnrcKvIeT3FLxQE0N7q/D0DjKhA2s6J5HH2edZ30PpR3USJD8bhfd8w
         B32RRli6FrsI53Cr08MK+24yHPOu1Y9/FIVAjWjpIxZTuNrnDNuf0qHTKcENqjjUQRHj
         SChtzLfITv3IEHOKul2hgGhHbWmsruY4Hr8F2kDZ8ri250oVCOWZNQ15/CpnhkWqu+Bp
         JICCa4i0rdQbD2UOd3yEcUCmu9+UVlxZ5Hu713Z85qXNUokq4QIN8z3PvFw0KjswjLt8
         gGnBtBaYw2CBagUg8wU/ADQax/0+xeTbBR4cwS8oI0mM/kdxnNK8fQHYbWntgb+F4Lv2
         +gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418279; x=1761023079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irzV2QUfJJ8dqUzMZqecWufn5bUU0255l1546dL2h1g=;
        b=OYNe8JRc1nXk5tzQLLAiZBofNkofofc6fnBEnsofUVXjF11XYda8mlv6A8WBTprHY9
         8oBm8WgBlMDs3nQ/cjaeZ/+57jVeA5a/Wd6AGSQMT4fGv9mwT1FbnC+aNcQVSBBqtnHw
         K/F1cIpdTr/2DP8OoGiOCJgFO4CWlUjVmuzYABnQ/2QrBjQC4It1oMNx92NH7UCvOCqc
         U+rGhyIYne0wLFBuUv1v0ssCjcjA50f91uYuuh/ZW44rsisYZkqUfzkkxLPfLTLmC0Gz
         4CYz7be987B4zfEgBIpMtQY0j9T32pbZCX6grDaLVaylNfOSjyesB3z9sPOKwDULXYhy
         kslw==
X-Forwarded-Encrypted: i=1; AJvYcCWfA35npwzxyiF3znAcfruwXdSgDwdJzJmEhx+2lKzHfxLVQ5ozhZ+WJT75VOVA2JJiHnVO7lT+aXjOOHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzA0y8l5vbw+fSwvrVzPbmv5IYkXNvxAIzqaEkN4gItrkPsF6
	LuDVETKads/e3zoVoTBSokMGut7YAxahBwQeepsVSnfMRz806bHUMcNfacKUt4g2PC2OTJfZNMN
	gwN6qi6XVQJkaAPaF8hVloYnVWArkB8Tg76DBsoXS
X-Gm-Gg: ASbGncuQcrRnZItMVgNRrI/svJaT2217UZRdxO+NbZrTNKwxb8SmNTSxWapREYVgNEU
	8mSK1vpkHqJyzD5/D3pn7v48n2ZB57dWBDuw/DxuLDF37vGDQkYPaJC4gkpPGvjDqVeqlnOn26Q
	sgdLJaeEFHFkzA9wLzR4Tbu7lndw6ESgz9v2hZeVWPMW6ljMB+FsjmlaTfy7Cc4cLZt1knLTZve
	4IL863UPCPx0mOIl3nnzZaOTXa8P/ITRfkwe76R36s=
X-Google-Smtp-Source: AGHT+IHZgIxpjg/6kkvcMW/J7xD1PN1qAsKtx/7STdfwV4yzIcWv1dUE7oPcxZBo21d0/mZd0RfXxsWJndcH5nudxHU=
X-Received: by 2002:ac8:5755:0:b0:4e7:2b6a:643a with SMTP id
 d75a77b69052e-4e72b6a671cmr56529361cf.12.1760418279258; Mon, 13 Oct 2025
 22:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
In-Reply-To: <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 22:04:28 -0700
X-Gm-Features: AS18NWArWNcPKS90Zk5Pwo5Ct2LOmBIBPcz-hhg5UK9PsI9_HIhdsDtGvM5VF4s
Message-ID: <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
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

On Mon, Oct 13, 2025 at 9:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 5:56=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Mon, Oct 13, 2025 at 06:16:36PM +0800, Barry Song wrote:
> > > On phones, we have observed significant phone heating when running ap=
ps
> > > with high network bandwidth. This is caused by the network stack freq=
uently
> > > waking kswapd for order-3 allocations. As a result, memory reclamatio=
n becomes
> > > constantly active, even though plenty of memory is still available fo=
r network
> > > allocations which can fall back to order-0.
> >
> > I think we need to understand what's going on here a whole lot more tha=
n
> > this!
> >
> > So, we try to do an order-3 allocation.  kswapd runs and ... succeeds i=
n
> > creating order-3 pages?  Or fails to?
> >
>
> Our team observed that most of the time we successfully obtain order-3
> memory, but the cost is excessive memory reclamation, since we end up
> over-reclaiming order-0 pages that could have remained in memory.
>
> > If it fails, that's something we need to sort out.
> >
> > If it succeeds, now we have several order-3 pages, great.  But where do
> > they all go that we need to run kswapd again?
>
> The network app keeps running and continues to issue new order-3 allocati=
on
> requests, so those few order-3 pages won=E2=80=99t be enough to satisfy t=
he
> continuous demand.

These pages are freed as order-3 pages, and should replenish the buddy
as if nothing happened.

I think you are missing something to control how much memory  can be
pushed on each TCP socket ?

What is tcp_wmem on your phones ? What about tcp_mem ?

Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat

