Return-Path: <linux-kernel+bounces-801495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1190B445C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791111660EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05525743E;
	Thu,  4 Sep 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgUT/zbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70030230D1E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011870; cv=none; b=Sg55KW5jOdlzTCmzPAeRB2h6EjlnayFd42aS+IinOxtJoVnvrgIvtuMZ19T2NhzXOZfItKAQbB0HhAjRYbYOmAjv5/EoDLQ+9OZ2m8ywnQCwzRi59mT8D5jZsmzmij9ThaD6TsXaqmTG+13xItnubNsMGLVXh4gejsPIFoXeUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011870; c=relaxed/simple;
	bh=ai6lB+pefFbgDbEnmQTP4yLV88R+b8W9zigHFvjXlLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7/ol3tdjwKAY/7PbSdZOI1qqIKjT1TySvaAj3YZ2u21EntTYAgjT1EtCgHfD5CF+EY539RqlnL2ggJMJYW7nLky+qw2tMvwAqO0MawyrGj1ue9ra88yNLYRj0uw0J2M1wkurwo2wuHqqhZ4ODAMnURx8RFE0P87WCLEojh9ViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgUT/zbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B1BC4CEF0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011870;
	bh=ai6lB+pefFbgDbEnmQTP4yLV88R+b8W9zigHFvjXlLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CgUT/zbP7Om17YgTUoZ/0Q816jHJtq/UJY5s6ec3LduAUaacBJqEqvDYSkW09fqp6
	 /Z/SqJTTav+zVa/V7GhZhiP00Y7yC73i3S35EoNTHxZ/qG9yMGGWMaGkDzRZcBZSff
	 Qd67ndibH5bCEPcwGaJFfLEF+ozAL+ArAfHewhtIn7HBPEyLNByyTxbMh6sv74x67f
	 /L+jEpjRRz9Z8+pKIgUf8v9QluZ4nCWjJTtGGLqmTvzUlJ62Co0r1yZ3Nz+gId+cuc
	 xFpznwGkLS6wVIUN/3eIZcDhC3J2RgGXICQG8W/MO59i46PMFno3u78QH/yuEzSKAy
	 azf8X+6smsB6w==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60501806so14207087b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVevcoGiILg6o17K8X0lFrQDvxZtSkhsaFQF9ZZkZpeWViu/GMBQbOCWAz1F5O/ntspcAL6ucd6StOKUuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIjq8CnApYtyaZWSB7yviBTbWHcFtyaQl43mBfpMO1+cXvstY
	J5o+KjXK1mOGtHkBDVTHvLq9NXe6cIhwXbNL3mfbuhcCLubmgOQFN7IxLCve3CPsPTx5mq3xlbs
	3Mg0qBqEdskBMeDv4R/wqz1vBgohgXiYbUHZj0MPd9Q==
X-Google-Smtp-Source: AGHT+IH7qVxpOons5SDsE4z29KsS6P8pao64rTUzhFDwFK8Zp3/crRXFA210Kjq5GPcKz7VZKCxE/sWGa4j+RdNQvxw=
X-Received: by 2002:a05:690c:dcd:b0:722:6dd:55e8 with SMTP id
 00721157ae682-72276356b17mr210031997b3.11.1757011869282; Thu, 04 Sep 2025
 11:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <CACePvbWG85YJFpLDoFnz05tX2trUJFTzyuELMGYSYr5ye_hQ6w@mail.gmail.com>
 <CAMgjq7Bv99OHvbEiDcEMVYS5bRdSgSu75a8YUEQ+3roLiOo=ug@mail.gmail.com>
In-Reply-To: <CAMgjq7Bv99OHvbEiDcEMVYS5bRdSgSu75a8YUEQ+3roLiOo=ug@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 4 Sep 2025 11:50:57 -0700
X-Gmail-Original-Message-ID: <CACePvbWg1hg1G0+unAJKz9SiwJOhahf8Gsoq+VB-5HDdAiRcqw@mail.gmail.com>
X-Gm-Features: Ac12FXwtTkBGJRru6NjbBV2SHpTb7Nla8kbUmwJPWO1uDuzkKSDkxwjE537gem8
Message-ID: <CACePvbWg1hg1G0+unAJKz9SiwJOhahf8Gsoq+VB-5HDdAiRcqw@mail.gmail.com>
Subject: Re: [PATCH 0/9] mm, swap: introduce swap table as swap cache (phase I)
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Sat, Aug 30, 2025 at 2:57=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Kairui,
> >
> > I give one pass of review on your series already. I Ack a portion of
> > it. I expect some clarification or update on the rest.
> >
> > I especially want to double check the swap cache atomic set a range of
> > swap entries to folio.
> > I want to make sure this bug does not happen to swap table:
> > https://lore.kernel.org/linux-mm/5bee194c-9cd3-47e7-919b-9f352441f855@k=
ernel.dk/
> >
> > I just double checked, the swap table should be fine in this regard.
> > The bug is triggered by memory allocation failure in the middle of
> > insert folio. Swap tables already populated the table when the swap
> > entry is allocated and handed out to the caller. We don't do memory
> > allocation when inserting folio into swap cache, which is a good
> > thing. We should not have that bug.
> >
> > I also want some extra pair of eyes on those subtle behavior change
> > patches, I expect you to split them out in the next version.
> > I will need to go through the split out subtle patch one more time as
> > well. This pass I only catch the behavior change, haven't got a chance
> > to reason those behavior changes patches are indeed fine. If you can
> > defer those split out patches, that will save me some time to reason
> > them on the next round. Your call.
>
> Thanks a lot for the review and raising concern about robustness of phase=
 1.
>
> I just added more atomic runtime checks and ran another few days of
> stress and performance tests. So far I don't think there is a race or
> bug in the code, as I have been testing the longer series for months.
> But with more checks, we are still a lot faster than before, and much
> less error prone. So it seems very reasonable and acceptable to have
> them as this is a quite important part, even for a long term.

Yes, that is what I want it to be. Every time an entry messes up in
the swap table, that is one page worth of corrupted data. I definitely
don't want the corrupted memory to propagate to another place, e.g.
write to the harddrive. That is much worse than having a BUG() and
stopping the machine there.

> That will surely help catch any potential new or historical issue.

Yes, let it rip in the mm-untable and hopefully we don't see any
trigger of that in the wild.

> V2 would have a few more patches splitted from old ones so it should
> be cleaner. The code should be basically still the same though. Some
> parts like the whole new infrastructure are really hard to split though
> as they are supposed to work as a whole.

That is great. Looking forward to it.

> > Oh, I also want to write a design document for the swap table idea. I
> > will send it your way to incorporate into your next version of the
> > series.
> >
> > Thanks for the great work! I am very excited about this.
>
> Later phases will also be exciting where we start to trim down the LOC
> and long existing issues, with net gains :)

Same feeling here. Also looking forward to it.

Chris

