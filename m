Return-Path: <linux-kernel+bounces-851776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05853BD738C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A19F1896A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7D307AF8;
	Tue, 14 Oct 2025 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhT1ss6r"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D525D1E6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414973; cv=none; b=WFY2bH6Dckn2M34HoDYkKlRIBRayKtUnfcIoCRr1bPvPdAr7JtdGTG/7Acnt3n5FaPQ7uvLZd17zYp9aq/ckyg8UepfdqzBBpSup18HwDTkCzapBkcpoMmsveNAOuRqjbpYLJNAld12bV2iAnRaAqv/1GvgKyAj/U/rDNTbu0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414973; c=relaxed/simple;
	bh=QmKsXUDLO2UOS9i7oWY5FjWNJqQhabL/4daX4mxaWDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm6OtLTz2eQG7Y4BIQsIVa5XZZGfUibUENTg52zRCuIsBXND/+n/I/YqNwJ4lFyVoyONhaDsVkn/79OXNyjJp4O27JVY5TaMYYTsb8hF5t4ozgPBbzViESeyswNZf19BQdzTW5TVqMGQwYvG7uDh/KjFpSMcbrLGpzRjRY+Zpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhT1ss6r; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-856328df6e1so640812485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414971; x=1761019771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t/ysbOLBQifu3AncOUS++OTG/U64LIdWxNEMaNf1Yk=;
        b=RhT1ss6rJnMKvB52ZZtuXvA/QhV4mRfZ5PP2uU2ezBtgpZXS70/ZHNok2S80/YCWLe
         UBODpQ4Ny9JsEVaJRHR/kqbLGjTJ/JquzUgQv/QesY5LKRRcfXu6mdRfWJmzZ3Ak318Y
         5aMdAcpNTdijFdL5Qq/3D2IXoQkwgcvslUTSUsmPGSSPQl5SSFlJaj3ZDlK0La7Vc91P
         oeXF1SP6jBQmvCDxCQcVvszEFVukppijE3DjPqkvOqHW+B/FbedTevOgjMfflD8Sh3Qz
         9hASe9cOroyvOhxe9JSGvJMm64SDA9T6VgOG+xhp/K1YZrsOX+dFDtgUChqd6om2Mt1Y
         ui1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414971; x=1761019771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t/ysbOLBQifu3AncOUS++OTG/U64LIdWxNEMaNf1Yk=;
        b=Pj+mrOkO3rE38XebdLCiRUiFxrB+y34+eAj5CEVurw7wT0RlXeOvryLOzEphZf/LWd
         bM4647boP6t9Qv6o1P+49X1nZe97Ic4tZyXVddPReKBvjweQVmZ54rw0zxAeS499u5sa
         OGtT8y7i6fHAUOO8GE3hUTyThP0gnBah/qN8Y9aNssDUb+mu9/1NV0yCcG/ZEiVHr42W
         G/ZSMsOFT4FihkH3sX0COhbEP6LlVgONMWxW4CYhQB5Q9KoEmnpEeaWTD5PUtLJPLztr
         lvI+QHdLkTW0CnqPh/MjO9xWvvVFg7VsQUH2TG7nzsiwpDL+ZapCdLm22oDR/JwBvh5K
         z3PA==
X-Forwarded-Encrypted: i=1; AJvYcCVsJVauNfjk5CxzMRYeah9xsOg++9qXzxz+q2y8/4QdopPYFSq7UaS+gyeCulFYnHDBQPxNu7v9+hBQSR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3N5y3MIcPqNQ5w2rEIjP8tFwX2DUrVhs0V/6sxbYpWM0xDgU
	wwpoi9KRbwTL40BRhGfA8n32SBQ1fw64FIiYKUMdgbAngGZcXXgW45K4iiuO1Am5P1OqX6+kIGG
	xRP8jqI7Qvw8tlGVLX/zwJ96aoymnDYw=
X-Gm-Gg: ASbGncutfdgXxN5VKZnL5VvHC97fKb8ISWyrJBYvYRlCUQBGOT8nvv7QhbIL2EvV5bL
	MzkdunOifuea9zKwH+anj7woNQ6DIuXBjUpnuweY7k+T9a0AY+TipRqmDlPpG374BBLJFB17mvD
	XL4Z5H/dYuOW+usj/oW6WlhGZmdjwN417JKeJkqvO6ESYFVOLLrg7StSExHkDM40AXjinaGtq3I
	IfCg9g5b1tehC2gxPmML+7WX64fiA48WG0MDE3WWSRT7WOLX19eg6+GJg==
X-Google-Smtp-Source: AGHT+IETi+Y5YVwDc4yOoULmeg0a/9GeqOMfyBB7w5srSvCikgvrnPsYVAaDacZCpZa84Vw9/offBLIwQL/Ei3+rCbk=
X-Received: by 2002:a05:620a:2696:b0:883:9634:5182 with SMTP id
 af79cd13be357-883963455a8mr2869615085a.2.1760414970813; Mon, 13 Oct 2025
 21:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
In-Reply-To: <aO11jqD6jgNs5h8K@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 12:09:19 +0800
X-Gm-Features: AS18NWCg3XvdE0hLImKQoNMslsxmyNkYfWghrFBQZL30dkAgd-aSHHY4CyF1lvs
Message-ID: <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Jonathan Corbet <corbet@lwn.net>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:56=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Oct 13, 2025 at 06:16:36PM +0800, Barry Song wrote:
> > On phones, we have observed significant phone heating when running apps
> > with high network bandwidth. This is caused by the network stack freque=
ntly
> > waking kswapd for order-3 allocations. As a result, memory reclamation =
becomes
> > constantly active, even though plenty of memory is still available for =
network
> > allocations which can fall back to order-0.
>
> I think we need to understand what's going on here a whole lot more than
> this!
>
> So, we try to do an order-3 allocation.  kswapd runs and ... succeeds in
> creating order-3 pages?  Or fails to?
>

Our team observed that most of the time we successfully obtain order-3
memory, but the cost is excessive memory reclamation, since we end up
over-reclaiming order-0 pages that could have remained in memory.

> If it fails, that's something we need to sort out.
>
> If it succeeds, now we have several order-3 pages, great.  But where do
> they all go that we need to run kswapd again?

The network app keeps running and continues to issue new order-3 allocation
requests, so those few order-3 pages won=E2=80=99t be enough to satisfy the
continuous demand.

Thanks
Barry

