Return-Path: <linux-kernel+bounces-797097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D6B40BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8658A1B63DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7634165E;
	Tue,  2 Sep 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGflFP54"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17562DF125
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833277; cv=none; b=pkFmh/L+v4K0GRU4LTYDwD9DMhtk4fCu7rsSxhEY/1UNVQ8GjXq+y29PpC+/lkX4DsewpSe7pruoyNiO3cia+Yz7SlafbZ2/UaSQZssXVrQ5GwmXo0rMbBteKlTp1otryU+w1tcpEKJDbWCbHMzysEzm06/Sacl2SNC3+J3aQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833277; c=relaxed/simple;
	bh=43jkeAMzXZfaBDRjnYuQWs0uMB6zqC5XvFEq6e1iOLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qzqc6pPBwJs98FdwvfGcDbs98Ocbl78TBr99nnTp5WcxWIUpLEYqVbtk32SctbprzsbIwieEfnhtk0MhBzrxCNBM5w6p6dDgYlTfOP9SI48uqU1XPYSoC7VpAM2j8g0Dimjqvr4IlMc5KY1g5ot8Odm7SedHWY5fwa6sB4W6SbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGflFP54; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so9944367a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833274; x=1757438074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzqnghrN1r+1VEkAjN5obE3DlhAu8tPALVKnOpzq7AE=;
        b=FGflFP54KPedFOCUQDUsGpTA5kIyABNn/CJts3WW0kWrw59Rrr3RLmyGTKJhE4cgQn
         WZn5WwdRcCftlDmqSNQUaPOnEZ6v6PNRFNuzqs56gE+byksTBP8P1q24WVfvEuc4b4vl
         yVzUndvQlV/MYSOfuMHbWYNkwAtFQzpd8aWYQVGSfUwATW1/s10Jf8EzmketdQt5pUzM
         Au3eAwIyDRhE2QlvS1kKmfY3RbTH4xTYKYd9+wiqMmctRVHDfU/95nRVFdbsuqYOMRy2
         doWQmo89JEa0MYAh9wyNaGbMokNBUtlr6fSLtQNzw7m+BGmLKNuY7KNsPH2lXHWnIDa+
         wK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833274; x=1757438074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzqnghrN1r+1VEkAjN5obE3DlhAu8tPALVKnOpzq7AE=;
        b=PDL1l5+o7Ks508+8Ev7MrYkkDqo07CVQ6Se6wkD+XWW7qRoWjnoLqOccWDZXU0D0pM
         XVZp+m0BOxW+lBNUHZkaX0KnNylZYLQk0rU/q5M+k4r4q47udQq33jIHy6MHjDLadXBS
         qlVnBy1CtwsxrEVbpcU59U+4/JCSMcCaMKEVvgDv5z0O4p9OoP8WazdkCticrVcNQYiO
         UzCK7MlZ277VX8tKOQsDCqOpsYb/pDyvM6qUAIT7YB762vn3LcP4pkdJ+m7VnJWwl4MF
         H4D9Z7d4OlPrcBWXBPPXInOY7ZbcAZ3TK+8vyEoq7lnaoieKDuvXFm7MZ11WJo1HFuu4
         b4rA==
X-Forwarded-Encrypted: i=1; AJvYcCWNhW9QnY8CrJ7ZYZRRT5mOOPii70zmFFSBV3/uQOw/yUSpB587yFAj2JZJazkTjKrK+tcvMGj9S07xfps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywui2afY0wVz6efOHl108uETBl6DZUYjMOHQHs2RSUimobAftKq
	G84yZvdFVLCu0ewi8z9RdBUIxamWR3/2I2z5bC1/47pwJigpkON1rL7HJ4zRzsYuHZ0d6TFt53z
	83xVlZelenPrUzmKKYfIobWQU/WP6NII=
X-Gm-Gg: ASbGncv7w5QPgQS/qV4NEiG8qzJCVcOsviipDqL+xJjm9MrhGWH/LE8i4PBeiSY2E0t
	d3RGb69SE7nDzIfyFo9VUrmu/Nhg4gVigI0N1yPG2k+iBFhLIlo5gMr7RP5CMk5l7nMLM1nZ1W6
	CKaNnTWXGyrVincf993fqLlYpnoD8vUw2Zr2PsKP5pmUmlRobD8QoqMbiDYg68tIU+h23lDwq7U
	XcBlSGx5xlRIqph0sOFBQ==
X-Google-Smtp-Source: AGHT+IF0NGx8oVy2iJNx4drE5tFtZCJfWO9mL7z2enJS2tyiDJa5XKFbAOkTOsRGoBMQnxLhsnZ5IN1yxy9vDuIMZ0M=
X-Received: by 2002:a05:6402:2742:b0:61d:1d16:19b4 with SMTP id
 4fb4d7f45d1cf-61d26997586mr10620645a12.2.1756833273971; Tue, 02 Sep 2025
 10:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <e22b8472-6d20-49b4-b49b-78f79f126294@redhat.com>
In-Reply-To: <e22b8472-6d20-49b4-b49b-78f79f126294@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Sep 2025 01:13:57 +0800
X-Gm-Features: Ac12FXwxkC-P5aYCZJOxQozwt63VrhkLO_QpMo-3Ez5Wlog8Xkv16zhs2hfV23I
Message-ID: <CAMgjq7Bqffjm3dTZ+bHALisCkw7ASao_1h4ZZVM6kd14YdKzmA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:13=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 22.08.25 21:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Always use swap_cache_get_folio for swap cache folio look up. The reaso=
n
> > we are not using it in all places is that it also updates the readahead
> > info, and some callsites want to avoid that.
> >
> > So decouple readahead update with swap cache lookup into a standalone
> > helper, let the caller call the readahead update helper if that's
> > needed. And convert all swap cache lookups to use swap_cache_get_folio.
> >
> > After this commit, there are only three special cases for accessing swa=
p
> > cache space now: huge memory splitting, migration and shmem replacing,
> > because they need to lock the Xarray. Following commits will wrap their
> > accesses to the swap cache too with special helpers.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
>
>
>
> > +void swap_update_readahead(struct folio *folio,
> > +                        struct vm_area_struct *vma,
> > +                        unsigned long addr)
> >   {
>
> Oh, one thing. Regarding recent const-correctness discussions, "folio"
> should probably be const here.
>

Not here, swap_update_readahead does folio_test_clear_readahead so...

I'll try add const to other places where I see the folio is const,
thanks for the info!

> --
> Cheers
>
> David / dhildenb
>
>

