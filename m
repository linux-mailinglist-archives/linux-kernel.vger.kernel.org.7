Return-Path: <linux-kernel+bounces-774451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDCB2B273
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A77C5622CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D951212B31;
	Mon, 18 Aug 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN2t7qCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD076199BC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549208; cv=none; b=Ibs5o64LcaQcMb5htBkb4Lg7er9uYnBXP4BjwYBZKzsdv5s2YBEB4xmiEpRjyt2NbUIAqdc8fd88syBnU580DmVtluWp0jMHTKmTnQgqu5sXYeCqwN1PNc49sDd5HWn6ClkmK1khDjoRpnukZeoLexmqsDpxgu2X3IOJiMNBlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549208; c=relaxed/simple;
	bh=0grDu4TlIM6Bxz+SXpvxsWdWaHdxACyGKxQJCimpybU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJZMav7I8YhC5uqZZ0+8A5/vkKhfnnMnEjy2JhzkNLKt0aG/Vd0Cxt0Qu58YlK9ShiTPrk+HqFS/C+nV94YP/WAjTzEdnoCEPraHHpr4vyLGuShoj4HkRXUtqF9tybmHyTuu5JxJxc3228tTX7vTQn3yYm2WRfhUJaZP+8NjsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN2t7qCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2FC116D0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549208;
	bh=0grDu4TlIM6Bxz+SXpvxsWdWaHdxACyGKxQJCimpybU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QN2t7qCS/gTbPJAQ6E10ozYfTW6YlG+SQMFUsPdQzjUjQqJciMV+77iwtRyHBbLk4
	 O1TpCEY7YTVCCxt+XNQ8lDTp9izStZZdmljZUEzH2DfFrFZXKQHnr4EHrbwmgakhUI
	 tohDN7dTXI3ehzYKcPTBPdXPQLi0rHA8+ynnKcSJlIXHe4xXTEK4f+hEivM1j40th8
	 DFd2BlAXIITGmgqkrfo+6EkxVYxGV6bxW2hZk/zhVc+JZYHs6XXJLa+hthpWOfIFPd
	 l11DcOVHFB86fiy56/sGeoVfD/DiUPItrt2OLPd6ogWS1Ro2POzlVgOodTxccXNeqK
	 VSx2v+7+6nzEQ==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so5725e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2lvAV/2ko+tCIglTsNVBSuRgGEH7OqOayCX4BLLcgGjk48QdA14AwXvKsU+tugE1EYmeons7Mte9w5j4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5COoqHP16ylAOrag8QIVCBPLOzGDOd05W5AvHvG58hSiSuSX/
	x3pWJibn8ODtZVugV7xW0hlkMx8wTXTQ+UVZDgQLNuvxUy2ZmFuYrL724aLjJ4jrPtHFCIhabGK
	5P+hpz8vAB2QrSp508lgN9u35HIeP6cZyifgQfzSu
X-Google-Smtp-Source: AGHT+IG4uVj8WtLu6RVGY+veaDWTkHp/2BauSJRgH5ZTzXihTTq7HI8p/iecvTt1+XFX4swuUe4k8TxGcn62xrRXS4A=
X-Received: by 2002:a05:600d:b:b0:442:feea:622d with SMTP id
 5b1f17b1804b1-45b43ac33b5mr10905e9.1.1755549207039; Mon, 18 Aug 2025 13:33:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuPwfRVHpvNRr=1NT4z_3Pmr-1u4vfRYmkvh_Kh4uNGy9w@mail.gmail.com>
 <20250818181800.59827-1-sj@kernel.org>
In-Reply-To: <20250818181800.59827-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 18 Aug 2025 13:33:15 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMJzWzrZDzbXtjUsp7M4546pS7Cjgc8ksu4RcGW5_T+Zw@mail.gmail.com>
X-Gm-Features: Ac12FXxPf6XYh5boVgDdp9E8nhx0iNpxsxAH5CLfhy1_uFfxEY4eFGtmdDWkmmo
Message-ID: <CAF8kJuMJzWzrZDzbXtjUsp7M4546pS7Cjgc8ksu4RcGW5_T+Zw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:18=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Fri, 15 Aug 2025 19:23:10 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > On Fri, Aug 15, 2025 at 5:14=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > Sounds good.  So in the next version (v4), I will drop compress_fail.=
  Instead,
> > > I will add two new counters, namely compress_engine_fail and the new =
atomic
> > > counter, say, stored_uncompressed_pages.  Please suggest better names=
 or
> > > correct me if I'm missing some of your points.
> >
> > Sounds great. As I suggest in my other email, if up to me,
> >
> > "crypto_compress_fail" and "stored_incompressible_pages"
>
> Nice names, thank you!  I'll send the next verison soon, following all yo=
ur
> suggestions[1] together.

Thanks, looking forward to it.

Chris

