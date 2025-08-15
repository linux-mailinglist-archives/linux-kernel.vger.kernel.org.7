Return-Path: <linux-kernel+bounces-771558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430A5B288E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE859AC7568
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF92C3755;
	Fri, 15 Aug 2025 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9tSaF81"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041026E6FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301266; cv=none; b=BLamQWV1ZLrHRpQXiBts8aE9TixD0sfYs5kjYUAZdY51CfuLOuOKZgeISFDdKcnry6o/parIOen7zDmIeyg7w7YVrkRywpo8dnWlPRQrW9L5hiJ4yIZxY7AA0YdkNj/TK2b86yHoa+eqZneECS9+cAKbatlq03RBdHOaA8WUrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301266; c=relaxed/simple;
	bh=FPUaJR4iSyJI55hPFahbgOU0TItvHGLdDN3KMFhT+RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mpdg5JLBV49yDia0YLWhH5pfYz20jc7wJojpc8Gh18wNTJjN1hz14CYYZlyvi8Ey3mlv1vVLeUTcHPQg0+A4K2E6E3oTj5ccHm4A3Yml4/FsNiDxXXRw1HLFjHno1vRNRNmuiUfoOkv3Drn4WaV+lRZm91U+C+utqB2mp7+ifME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9tSaF81; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0bf08551cso88841cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755301263; x=1755906063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC+hmy8FxOOZt0BUy+LXGgoJOiZCGQ/IiVXODEc3P1o=;
        b=J9tSaF81KGzn3WtKKUyGe7ZDd9Y8e8rrYTbcSpo9668EXPr5xZTJkMByO96fVxsW7+
         aiYqWUQdLh3xIXwqNn79pefDHsnn+nB6+F/q2RHLKtDXxVkntAdlWWEVM2ET1BCOsXrE
         I0lpzDj4/Wo/m+jQkQe0JziSwKspB15Opn72hbidlCrXB/1xsbM5DRNmqYJ3SXYPB/3X
         3obrc/o9SjSFAgNiC/2L2j96sKpKY+O54tWsS/HeY8jPPqDFVSeWxH6O/IpMvQop7Sew
         xZeX4AEKti4DJQChj45RD40LfamE+/DIzmjz4GuYTZ99Etxs9XwSRv2JNNwiwYBRCF1j
         9Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755301263; x=1755906063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC+hmy8FxOOZt0BUy+LXGgoJOiZCGQ/IiVXODEc3P1o=;
        b=m+E1Exh4wqwIZJ3jwp467EgYJp7YTypYjnJlDGgVh7xcUVF4xpVGIuIXUNQ19E2CNS
         xRBMY9R2iMqQAsV3O7kBgFC96/fN1St56uyn35dpKoEZRxtaNxZ4/Ygx5uHVHo31xg7U
         KIt0uv6ez8aEINqdA3AO3LtORHDApgMxi/yZ/5Tq6bDjp1rM7s/KrPVEO84D4TbamVzH
         0Ff0SeUOneEmlSfb6TZT29jpydyJ6X5fKfjfKhUf8sTD4m7r2xSA8jVcKLgqD1/+7jPW
         zoTr5ArMh2wVAT2O+aGWEVpabOds+r80n1JKZHO4W+hYhMp5d9Ru2QvhAeHkD2LzVARS
         tSPg==
X-Forwarded-Encrypted: i=1; AJvYcCXqoHvEovArR8y3eM6BtcnE4oKIIS/jZ1CCJ7Z+2OYOL4gBbqMTVVUeTQX+xDzw3na30fLB7p5oxZU/VPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRDs0dcKw6yecYTi/UULYDd2mKZ5IgWt0iS/6eyp0BWIVlemi
	Sa2HxKV6qZsSvvr+7vBb0rdjCfXkGJFNVcV4bnRqrF5sk+Y86HzePWrY5QgoLCbKFgbOninKEyx
	KROGpRY/h4JNU3EzOrBKwE3wJAL7+0ZrUJ+5ujhGn
X-Gm-Gg: ASbGncvP7lf2CYgof0dToprVf1X0qzmNkirY1tLHMNdePaUCNlTrU91atC5GWYXc4Vt
	uIKcO++ViSoVauVg7mMC3dOQOr2qIX1J+QAwGt0+bt1uJHSDKzaRAtxp1pVNYwsb/FnGEgQDQwd
	djg2zA408lntTDyKl00bIesn2s3cBNiYLRBUGbDeaO+PylMVxHlcqoT0TEUFeZTcTRPLZ4q/Dkd
	BcaxqW0c/btnU5gKFzoePA=
X-Google-Smtp-Source: AGHT+IGrhyPvvxTOfa6TjnEQTZi75pbn9usZY5vdhT1RdyXHVbBFYpxokexBB2Fw8B3UMydhkThzOeMQPkqiMVkwmJU=
X-Received: by 2002:ac8:7d48:0:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4b12bac1cd2mr671791cf.9.1755301263038; Fri, 15 Aug 2025
 16:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815215914.3671925-1-axelrasmussen@google.com> <7a46f7jwlwgkbdjvbxjaalrrdamgtxkptmytllhkr2qv4ovbge@nbugfzavwh5w>
In-Reply-To: <7a46f7jwlwgkbdjvbxjaalrrdamgtxkptmytllhkr2qv4ovbge@nbugfzavwh5w>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Fri, 15 Aug 2025 16:40:26 -0700
X-Gm-Features: Ac12FXw_HFPZ095gKMlHpRFMN8lgcVFvzndQzLXfmu0HxmUJr4sDsvsxZ5Xh-Uk
Message-ID: <CAJHvVchYa-vUcQo92awyHE663n-iMsLK31o+1FKrMvdLMAuUOg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark MGLRU as maintained
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:13=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Aug 15, 2025 at 02:59:14PM -0700, Axel Rasmussen wrote:
> > The three folks being added here are actively working on MGLRU within
> > Google, so we can review patches for this feature and plan to contribut=
e
> > some improvements / extensions to it on an ongoing basis.
> >
> > With three of us we may have some hope filling Yu Zhao's shoes, since h=
e
> > has moved on to other projects these days.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  MAINTAINERS | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index daf520a13bdf..8e987f2668cd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16058,6 +16058,23 @@ F:   mm/mempolicy.c
> >  F:   mm/migrate.c
> >  F:   mm/migrate_device.c
> >
> > +MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
>
> Why not just add yourselves (and the missing files) to the existing
> reclaim section? Eventually we want a single reclaim solution, so why
> not start with single reviewer section?

Sure, I can see the argument for that.

I suppose the case against would be, perhaps the folks already listed
in the RECLAIM section don't want to additionally get e-mail for the
extra files listed in this patch? (Perhaps mostly the MGLRU
documentation, the rest of them aren't necessarily MGLRU specific.)

I don't have a strong preference either way, I think mostly I'd be
interested to know Andrew's or the other reviewers' preference. Note
Lorenzo suggested a separate MGLRU section here:
https://lkml.org/lkml/2025/8/14/271

>
> > +M:   Andrew Morton <akpm@linux-foundation.org>
> > +M:   Axel Rasmussen <axelrasmussen@google.com>
> > +M:   Yuanchu Xie <yuanchu@google.com>
> > +R:   Wei Xu <weixugc@google.com>
> > +L:   linux-mm@kvack.org
> > +S:   Maintained
> > +W:   http://www.linux-mm.org
> > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:   Documentation/admin-guide/mm/multigen_lru.rst
> > +F:   Documentation/mm/multigen_lru.rst
> > +F:   include/linux/mm_inline.h
> > +F:   include/linux/mmzone.h
> > +F:   mm/swap.c
> > +F:   mm/vmscan.c
> > +F:   mm/workingset.c
> > +
> >  MEMORY MANAGEMENT - MISC
> >  M:   Andrew Morton <akpm@linux-foundation.org>
> >  M:   David Hildenbrand <david@redhat.com>
> > --
> > 2.51.0.rc1.163.g2494970778-goog
> >

