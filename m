Return-Path: <linux-kernel+bounces-771521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784FAB2885D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090ADAC8147
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BC2417C2;
	Fri, 15 Aug 2025 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6DGIhH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E242056
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297280; cv=none; b=W7aX7/y2EHg7aUGkC0ggPiqoDuSjsPgmAwecmhqlqofm6e1cyQYdqp3gPQobctsH4ysJpsAXdeOPQCTR0xJYGNA0iBK8CVwft0RaxpGKG4n1E4tbXxEyOkt6fc5bbvwmY6UdIJbCyZW53MTEb8q83Q/oKK5AfonVXJHgwQk4hR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297280; c=relaxed/simple;
	bh=gL2z2AAQav+D5dERtLWe1hphxLyPwbvfVga0OBj1evQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peUubDnfm4Ug36RMNEYc8gIEoDorEvuz+cHGKZxRHccbNeUWNmogRtsbC1VVcEuZt+h7iSGnMopJ+1xJNT7HWiJv26kdV7f4z288GKsM+ezBK2ZsduhtxyenqfTcQdsZCKPUgWpgmM+jLkXeb/PnlX/95IXWi+P3oERLV+eq8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6DGIhH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5325CC4CEF9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755297280;
	bh=gL2z2AAQav+D5dERtLWe1hphxLyPwbvfVga0OBj1evQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E6DGIhH07Iii7o+LnYyAYBeKoVSzf2WfgJyTsr6EDVmPj5qULKjbzjsaaztybIPpx
	 7yf+kRQUNXklq7/j+INOaexRPvRaZKX+qYMDKQ9vUTr5HxEt+QcJRr/9BH3WNi+TEW
	 dZzYWY1/AZoj5oaqhO8NLx1ONDTlupQQHfukx1BGJErZfb25vtlHRCqK/6WZ2EXMKD
	 aLYW1QduoPGzG5AjjZfh1K24EaES+qejDnS4rCTHnASE6/e/UPgK+vBbsw/q7+tGh6
	 7ho+L5fao2GxPSIErOHbvL3z3jUPzx0nQckfYujMm/wnAze/f2CvDSx+cboxqLcvIo
	 JQGPdc721/Zpg==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so26615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:34:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc944eL8aTS1YelIDRnZwfALqrBcX8TG7H5WL8AWA8lhxThJSGUfe1pP0biULjFz0LBIQSkxzKELBtEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+XIjbqZolWU9db2KaHX1J8EB9P2VcFEor3Pq8C2Bq7yG69KO
	2G2bvJClieVdKRrbt3cI4AEjQ4xT1whbF1TxkHh38PgIzrww3PFN9gGlCSEB9BjyaXq/827jAqL
	rgWeNa/XJcHBBodwV2MxMP5qYr5R7TiQxO8AMx74w
X-Google-Smtp-Source: AGHT+IHiUcq90nV7OAgUXWgA/tg601KKCuJBzGd6aGo7C/7GWIPkifRQ2oNcnHOV0LyB64YLTxdLZN2/Am1QGjylw30=
X-Received: by 2002:a05:600c:870c:b0:459:d7da:3179 with SMTP id
 5b1f17b1804b1-45a26f07dcbmr147775e9.5.1755297278909; Fri, 15 Aug 2025
 15:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <CAKEwX=MzHu+kXygCx=AC7MptExsy8CS9c6-fBbFK=shYDD4S7w@mail.gmail.com>
In-Reply-To: <CAKEwX=MzHu+kXygCx=AC7MptExsy8CS9c6-fBbFK=shYDD4S7w@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 15:34:27 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPgNyWF5ZWccnz1KRCtqsiXRy_U-LcQxJ3jnSH2eQq-xw@mail.gmail.com>
X-Gm-Features: Ac12FXwU0TQik4UWtVPNW7D3bsO2nltOHiCeIjitxIW72ep4bzPRxcmJd5qgbD0
Message-ID: <CAF8kJuPgNyWF5ZWccnz1KRCtqsiXRy_U-LcQxJ3jnSH2eQq-xw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> > I know Hugh has some idea to store incompressible pages in the swap
> > cache as well. Hugh?
>
> I've also proposed that approach internally - keeping the page in
> swapcache, while adding them to the zswap LRU for writeback to disk
> (and so that we do not consider them for zswap again in the future).
>
> But after a while, we decided against it, mostly due to the complexity
> of the solution. On the zswap side, we need to distinguish between the

Google actually has an internal patch to keep incompressible pages in
separate LRU out of zswap. But that breaks the zswap LRU order as
well. If there is interest and I can find the time, I can send it out
for note comparison purposes. I do see the value of maintaining the
LRU in the zswap tier as a whole.

> ordinary struct zswap_entry and the struct page on zswap's LRU list.
> Externally, we need to handle moving a page currently in the zswap LRU
> to the main memory anon LRUs too.
>
> Migration is another concern. Zswap needs to be notified that the
> "backend" of a zswap entry has changed underneath it. Not impossible,
> but again that's just more surgery.

Ack. We might need to get that operation inside zsmalloc.

>
> So we decided to start with a simple solution (this one), and iterate
> as issues cropped up. At least then, we have production justifications
> for any future improvements.

Ack.

Chris

