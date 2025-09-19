Return-Path: <linux-kernel+bounces-824072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB6B880F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D6B1C868BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788C2BEC2B;
	Fri, 19 Sep 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOycbW4B"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BF2BE7B5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264561; cv=none; b=kSDM2VuWrRdostDZRP0fe+4Lktc65GXNVcot0WsPHyZKmRHOaBmORL3xeCbDf0s5TLC0AK3FsFE08ovm8X9/J65t3hqp1Trf4yzVdmPtlEHvdgpk6XPP40pgHd7NiJBNCPen6acjv800rHAcMGeZABUq6mTW7xP2eKZyG7UTQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264561; c=relaxed/simple;
	bh=G/Y7HxY0FgwAyVdDq0T0Ves/OjOQrfhEFwiNcNQPWlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7L3WPUJmL6QD0qIButYmwBBYx6mVl3W2SHbca7vttyGwEB9fQ3uKrhLqGTyE1Dj074v8t7oc4o1gZbTks7lyyltXxKzpgXgjnMscE0osxubCLiuji5uFAXSSZqGRvaRqIP3pXz1QLBNTIVV9autidD58ofFeEvk8s8KzxBRfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOycbW4B; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54a1bef404fso1323098e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758264559; x=1758869359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8ChdVFL3VbJv1RwXe37ElFR0o5xJ4LIb9+Ne1LI908=;
        b=QOycbW4BaPPqvnkt/mFZ8Yn7TnL9txpIaZlThNhLXiTV9Y3hTUZY8lr4Cl9/D9qW/t
         p5dbEoSR5EzGx8SXAZq74LnbbtNsKOZtmVJ5K1mdWkinl/WvNrR/qW99A9ugSMClk6KP
         cSmuroOQq8cq3S7lCdCAWEawSJ4qUyxyuun+FpwRTIhVLdwn9Rf9FQI/Yr9DEx13UCfP
         MovCxAkdjoToAR/Mo9yvwQBhSMrw1OlIeZcoVLrXF2REVoNugDUFrKDynBJLXlZYlCPj
         iuiayoI90PSETM/P7ekeXtcnzR+0RSvEJIi3gzB4+3hgg6VqePh2Z6IOChwh5ek+6fbA
         nz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264559; x=1758869359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8ChdVFL3VbJv1RwXe37ElFR0o5xJ4LIb9+Ne1LI908=;
        b=NwsXNIEC+UxJcUNmkOZzMVTDbUmEEvpsFMgxfHbCLrzVrRRX2Y5rJqSNQCfAwEv7N+
         PsTJYuifMYdR6b2/e9YezcHu3NFTxrhitUsD5kEamdY36sbzzyxGm4OJyuUK4rBIhcrQ
         /fcIbI0JRzqNCaz+jt51dvPhdu7lN+ZIcBeU0TQ+twjj0WiKuL8fWd6VCINlxyO+4w0k
         jxWuZf0YfolB6UBfnKp9hF5Hgq4ZgJeADg9LKnfzYoqimOMFoExhsM5mgWRUfW9a8dmQ
         y3vWxaTkqCEOZZGwN/XjU5BDrVzqVko/+vIAECbUnwWaJyJOoEh7eGsWBsKUGeGXUUrv
         Tyeg==
X-Forwarded-Encrypted: i=1; AJvYcCU34RNM+BP1jYZqWdxyGN7jKvM1CVcjIxc5xSb+XNp2NvR+BGJht5QhwY3cSxnYZUm+mlf3kZ7CMkS4ViA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZo3dOmOc2UwE9uDq3QOye2UD2mJUc2vvqNgG/9ZtzU3gxz3NQ
	Oqxmhs/TNaUH8KToZHDSVNmJx++AqvpAfE2qMcPePMm2AGR10x2l7sFkvGpC2SxkoBjnt2wC21u
	OmZ4jkfytOjPMtFCDdYzKFD2baRLBmgzSajFvgymS
X-Gm-Gg: ASbGncsxL9Rcu5RL9yVQB470vyoMt4SsP57HzzO7epDkpHrhnecOPrXsU9xmcUl/TEt
	eQu2SKUBe61JptseNwgCff2qAxEGRwOYqO6VyOgWLku0WpW5yCCBoNfTd6eJIFpuahQgNz/WSmP
	uygcEXluTjKsQfMAITVRanB2iuSAP6T3ULIee6gngEFWWGXM/MM+NqZ1QiITeRPQM3uHwoRVSx/
	L/ogbSOPlV1urtNHQAZB2gr9sb0a8tGx58Qgvit4N2pLUcQ
X-Google-Smtp-Source: AGHT+IFVsk862c6jBLBQHlKlwevYkZVfUWmmFw+NQU42kXUhgZ2xtmh0tS9iCTXHJ7q0fDyvegsZslZdHcK2rLPpIvA=
X-Received: by 2002:a05:6122:2a05:b0:530:5308:42ec with SMTP id
 71dfb90a1353d-54a837e6887mr813853e0c.8.1758264558514; Thu, 18 Sep 2025
 23:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917025019.1585041-2-jasonmiu@google.com>
 <20250917122158.GC1086830@nvidia.com> <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
 <20250917163200.GC1391379@nvidia.com>
In-Reply-To: <20250917163200.GC1391379@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Thu, 18 Sep 2025 23:49:06 -0700
X-Gm-Features: AS18NWCRC_XaURHfJJfME-M0Ey0ObAUOEvcdAIB2Bzvin5AUuRN7ltMM3UG48RQ
Message-ID: <CAHN2nPK+Z5cvQ_waTWyPZiEoeSc9o7e3YnQLLjRzNzrb7VhAqQ@mail.gmail.com>
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Wed, Sep 17, 2025 at 9:32=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Sep 17, 2025 at 12:18:39PM -0400, Pasha Tatashin wrote:
> > On Wed, Sep 17, 2025 at 8:22=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 07:50:16PM -0700, Jason Miu wrote:
> > > > + * kho_order_table
> > > > + * +-------------------------------+--------------------+
> > > > + * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
> > > > + * ++------------------------------+--------------------+
> > > > + *  |
> > > > + *  |
> > > > + *  v
> > > > + * ++------+
> > > > + * |  Lv6  | kho_page_table
> > > > + * ++------+
> > >
> > > I seem to remember suggesting this could be simplified without the
> > > special case 7h level table table for order.
> > >
> > > Encode the phys address as:
> > >
> > > (order << 51) | (phys >> (PAGE_SHIFT + order))
> >
> > Why 51 and not 52, this limits to 63bit address space, is it not?
>
> Yeah, might have got the math off
>
> > I like the idea, but I'm trying to find the benefits compared to the
> > current per-order tree approach.
>
> It is probably about half the code compared to what I see here because
> everything is agressively simplified.

Thank you very much for providing feedback to me, and I think this is
a very smart idea.

> > 3. It slightly complicates the logic in the new kernel. Instead of
> > simply iterating a known tree for a specific order, the boot-time
> > walker would need to reconstruct the per-order subtrees, and walk
> > them.
>
> The core walker just runs over a range, it is easy to compute the
> range.

I believe the "range" here refers to the specific portion of the tree
relevant to the `target_order` being restored, while the
`target_order` is the variable from 0 to MAX_PAGE_ORDER to be used in
the tree walk in the new kernel.

My current understanding of the walker for a given `target_order`:

  1. Find the `start_level` from the `target_order`. (for example,
target_order =3D 10, start_level =3D 4)
  2. The path from the root down to the level above `start_level` is
fixed (index 0 at each of these levels).
  3. At `start_level`, the index is also fixed, by (1 << (63 -
PAGE_SHIFT - order)) in a 9 bit slice.
  4. Then, for all levels *below* `order_level`, the walker iterates
through all 512 table entries, until the bitmap level.

so the "range" is the subtrees under the start_level, is my
understanding correct?

--
Jason Miu

