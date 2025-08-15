Return-Path: <linux-kernel+bounces-771531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6EB28878
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C5AE77D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C813FEE;
	Fri, 15 Aug 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI9bZmyO"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDE1FC0F0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297880; cv=none; b=osJraHrmSVi86xAZeHvZsVH6n2JIc1HWaPRiVizBykRfqq35k6uSn2BDkeKZf0uLFU+xo/V+Rfs/YQE0f+wIzMprp5kIqPqSvDrzL8k7iuu0jIs9WivtN5PP4LHqT87zTN21ZteQzHskiY7QuzBA2Sy4luRyZHOVHZRzeRUF+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297880; c=relaxed/simple;
	bh=h7EVCv8DU7s/6u1eCfhVekIEZQU6Q2TaFHEgBqjvO7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2WvpkWQT+8H2gSIoU5AWczibjCWRFBSuSUXyoCmTIEflsmZPKsjiJSxTAeHddWtL9wV/FnsRgZlnL1vRAWcsT3ubTYzXfpA5I+R6COFs4ywBff/7kde8Wxfa3boPJJNCc4oFeUT5Hi/RKnXsK3UQUFqK5BbLMAII1IBNxojJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI9bZmyO; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e5700aa375so15755445ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755297878; x=1755902678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7EVCv8DU7s/6u1eCfhVekIEZQU6Q2TaFHEgBqjvO7Y=;
        b=jI9bZmyOhYaxQ9Vok4qJXoDqWNsZ8keNxzVywvr/zj2ufExvMzdZZ9fD9H3Ywq0Xuj
         StubxbnMTxnNzZqQkH3Geyee0iUTol7Ciksrr+LUKte9Jw31az5KII4rKBC5ZVy2epdH
         n6XI1Gf5Fk4OTas3j+H0RN9wft7RWjGfKJJ13GAyonTidRH5RU+ve/jjy/LTo7ayvl+4
         makJcVdWqkudnt2ubd1MsxgfJtiz62h92mRywwFTcelmjnyjODCCKB69m0LEsDWrDqkO
         Za/bRVsdDeGXaNF+M6QjLNKqrwnhbXguS37rrJtstX+0XTAcnVU9z/m8B/g7WcM1j0ER
         Sppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755297878; x=1755902678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7EVCv8DU7s/6u1eCfhVekIEZQU6Q2TaFHEgBqjvO7Y=;
        b=p4EURHIn1E0U4x0M5/US9pcJqp1OcfkCa09RpoXe67+zu8Qo9U035doz2FrRKGRCUF
         JdMKY0zLOzA2EfJpEzyTI0FYM8ciGWv+FewxqcreQO0Vn6rGrqHh/DRVY5aSmycboj57
         9KqlG+Yot/wOS+c8tGE9lA0KPMmpBVrewRW9O25jF5t42adjOq/QH0Hor1UuA5p+lC7K
         xEXfb5treGu+g8mKTzelMbjMldx5SRqX3vtE8on2Pi/2OeewtfwMt1JcW9ZQuSpdmbg+
         guux9tbKUfwpgLU5QWNeSqoukOAK5WVHTyyHZ/z0PS3kKZTh04QIrtm2T5iIZtouqPWP
         gOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZ3SxYrqLYcLS5pzcZi4/FpNvLah/7G6/wL9eYYpGKrsSvtKREtp8Mp2GOlnLzqvLNQyp3ZKnuOMqg7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ9Kb5NWdk8dk/NZ4nfgl5l1qK9D5dBq5CNrT/jbbnzuoqNyXs
	k8kMFegiPRcQsQDhvMczc3jEDh4Oc4Fn+msDJSqk8rKDrBCjXVz70jkVNmwGlxdpz6wy/tBXU1t
	DHAhaCyjhwyKlV2NKAkvRgJi29gIxpZwaBv2H
X-Gm-Gg: ASbGncul9gNK/uEmtGWU5D3Godp9j4RbalSwmIBLSFPF7AsxHhWrN5kzJyIie7/Tqui
	ZQHEeoPlxy7GU+ich6jAaeJuPXhKdxnxAv8lvDBzJWbzxWmm/O2BesOgzK6br+QXk5tXrVqtTmw
	5L5HWlWQvG0no9cjl4t2hhVwcJIXsCNrK4aTcnCjE6vrikQF8V1fv/POItFK0HRgolyyHVrgOL9
	lP4Z/4=
X-Google-Smtp-Source: AGHT+IEbYDqhh7FqTPONmtFsbbf6vTp1Xfo6Q0tD7SFahOtC2Az2TA90JsIsbdhcXOmhTRT/lvikmv8wgpmda3tuLyw=
X-Received: by 2002:a05:6e02:1446:b0:3e5:4631:54a5 with SMTP id
 e9e14a558f8ab-3e57e9a859emr85486695ab.18.1755297878256; Fri, 15 Aug 2025
 15:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <CAKEwX=MzHu+kXygCx=AC7MptExsy8CS9c6-fBbFK=shYDD4S7w@mail.gmail.com> <CAF8kJuPgNyWF5ZWccnz1KRCtqsiXRy_U-LcQxJ3jnSH2eQq-xw@mail.gmail.com>
In-Reply-To: <CAF8kJuPgNyWF5ZWccnz1KRCtqsiXRy_U-LcQxJ3jnSH2eQq-xw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 15 Aug 2025 15:44:26 -0700
X-Gm-Features: Ac12FXwUehbQUCEmcoI2pfKPlqAT-cU8u3Hs7e7dWGlNROXhtNc8ttCA3D6xeF0
Message-ID: <CAKEwX=N9yPqX-m8hhOJqq2eaNPkX-nNMcURB-hwveuUs-SPqQg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:34=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 11:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > > I know Hugh has some idea to store incompressible pages in the swap
> > > cache as well. Hugh?
> >
> > I've also proposed that approach internally - keeping the page in
> > swapcache, while adding them to the zswap LRU for writeback to disk
> > (and so that we do not consider them for zswap again in the future).
> >
> > But after a while, we decided against it, mostly due to the complexity
> > of the solution. On the zswap side, we need to distinguish between the
>
> Google actually has an internal patch to keep incompressible pages in
> separate LRU out of zswap. But that breaks the zswap LRU order as
> well. If there is interest and I can find the time, I can send it out
> for note comparison purposes. I do see the value of maintaining the
> LRU in the zswap tier as a whole.

It would be very valuable. Much appreciated, Chris!

And yes, we also discussed that approach too. What I described above
was an attempt to get the best-of-all-world.

There's a couple of desirata:

1. Maintain LRU ordering, in case we want to do zswap writeback.
2. Do not retry incompressible pages, until they are accessed.
3. Minimize the cost of page fault (memcpy, page allocation/free), as
much as possible.
4. Do not retry incompressible pages, until they are dirtied (a
stronger guarantee than 2).
5. Keep the stored data migratable.

In the end, it got too complicated. So we decided to go for 1, 2, and
5, with this approach. Regarding 3, this is still an improvement over
vanilla zswap (which writes to disk, and tends to have an even higher
cost of page fault).

I believe Google's approach gets us 2, 3, 4.


>
> > ordinary struct zswap_entry and the struct page on zswap's LRU list.
> > Externally, we need to handle moving a page currently in the zswap LRU
> > to the main memory anon LRUs too.
> >
> > Migration is another concern. Zswap needs to be notified that the
> > "backend" of a zswap entry has changed underneath it. Not impossible,
> > but again that's just more surgery.
>
> Ack. We might need to get that operation inside zsmalloc.
>
> >
> > So we decided to start with a simple solution (this one), and iterate
> > as issues cropped up. At least then, we have production justifications
> > for any future improvements.
>
> Ack.
>
> Chris

