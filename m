Return-Path: <linux-kernel+bounces-808488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F277BB5006C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4437160D70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CB34DCFE;
	Tue,  9 Sep 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty9fQXAc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8E1F0E2E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429928; cv=none; b=QEr200WL4zpYBOwt1uDfMxc4Gs0rNcMwvyNPBCpF6W/Tq4mordbj1J+waKzdbjfwGYJKbccZmAHeldnE6lmIVQkZ3SbYfxVmkTmnsjGWxy4B8FyNJ5AFXwtpl9SFwGeKFhH6Xtd8fNrTqzav86eeakgpXHDB2lJ/bEz2trOcpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429928; c=relaxed/simple;
	bh=GPXq7GLxQi+GK9C9f/V23ZUAplO/KiiJUwnq8p2H+lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDFqCWjuf3BcEDIUIN3UZJxEBtKjDGx13K+WaoxOWoHgpe8AF76v7K1MGgjbl8BvMR+Pk0kfoD5qYV+zwWRsZpk34d5Cv4EcB4EpA4xnEoIfahG6XgBGR+0kDH3ggH8YM1LRxDpYkhpZ8kSM19AlVJj4xfSPSj9FVvtBbCJNyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty9fQXAc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso961889366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757429925; x=1758034725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m8UfLRkwYkCoRG9q4AW4F/X1zLc8k+fkHHKjv2oYWI=;
        b=Ty9fQXAc/1EmQunP0B4G1cSg0S5LG+0I0eeAJUOWjgkdJrrWkgLS1LW7aMennvWvak
         ZnNaW5Eo5SczahS4mB0wOlPRNwMXNpmu0G0phua57B89U0jWkrHWKIDOGSxas7YXnIdR
         /27SCwCXVOQoB2XgQXLpP8ZKiJu189mTOmta+vYQ+cHSUqE/zWOHP7Unn2w2lEeznIof
         Y6wWhlOr+igmjKz4aK9HNO16NNsQNZ43ynQfNd+qmDskrsjrNGL2qU/AcDyV2KxFWle2
         khZ0gCQazRoEqsz+TFrbQ7OLzBKIfGSRlMCNd77x3zq4ppsnKZi8XBvyjh/6SXI28gQ4
         OJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429925; x=1758034725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m8UfLRkwYkCoRG9q4AW4F/X1zLc8k+fkHHKjv2oYWI=;
        b=K0uYZCQ/NVkqFGh5UUrE0VA4jFWdnViAme89AQEfiuRrDZCBulM2yskQLnEoMNo2H/
         J63DD7AazYfr4w+O4VmKnJyPpPzG0bv/1jz2uWghFt1OG1kHhxaMzTQ9ISqEMrcjeFqP
         d08k5hhukUrkjpmDVQO37gn7OCQ4vUGMRwxQv7HETlhFmawGHGHmXuITHoOvoEnPzCDD
         LtXvtULELUY6/uGPE4E+pyrX1+oLzZMQUalbxcRGzQcetZJncJL3EHJKh7MG8uPUzLnx
         1CAxImfbDfiVDs0Q4c95ty6jZ5zE5qZTqQbdexpmZVJBjQC/g/sNxJQoJK/gT9ZHVP8X
         yFfg==
X-Forwarded-Encrypted: i=1; AJvYcCW9hxg3xK0ssdDD83Dx1MU2gvuCDCVutgezhB5PZVj53ukIn0mLLB52AxpYJKeJJ6ridoc9ecQ8DrgzyE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypIg4VwoQpJYHkn1X6VHdykdamwglyUL94EV1SK/AV3EaWxm+g
	YnJ+ypYQ6vYKc4QUfzqsXSP5i0Ll8qHCtb70/KlBbRqiaGllj7y4b51igjwLlZFMdzOmSq/Tj+A
	nHn59YbqCNF2m5AqK6j4+PoRtX7CXww8=
X-Gm-Gg: ASbGncufM83V83pnJ4tcbnmiIbGzHY9mjUEcytmT5ILFxBZ2xf+eyhRBIXK9gyZSR6B
	HnRqdSoEbyhtNMTd+6saK6i2hBJCqXVgARSaGqfbD57hsrOj1LELDKMPM8BcAskyY5aQYG7VsPM
	ELtcKAGBwTZXKeKkQwwaOtgOtWP4uANTuVOqAGGfShC9AAdWv3fZHXWkPkwf/BcjHKUozvjXJ7e
	r8GNWa10kdG2zzsXeIFeg==
X-Google-Smtp-Source: AGHT+IFWy3IZpvbKMW0rMWL9k3GfHz9yi8+0YGLSFX8InBG0mqrVOBpoQPrpe/jA576SWjVAzPg+gM9DAa/5Tc1gW4U=
X-Received: by 2002:a17:907:d2a:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-b04b1542faemr1056559566b.36.1757429924635; Tue, 09 Sep 2025
 07:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-6-ryncsn@gmail.com>
 <0bbda135-068a-45bd-afd6-3f5cdf4e570d@redhat.com>
In-Reply-To: <0bbda135-068a-45bd-afd6-3f5cdf4e570d@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 9 Sep 2025 22:58:07 +0800
X-Gm-Features: AS18NWDGLlwdkrvwzMJL7zTY0JXDCsXG30VSD6e-dpjxVCyt6CGtodppdyFsSnU
Message-ID: <CAMgjq7CsKYWzAD0Ev7q0cocQO8kOYLmhgLD0wk6AX-HUzWFJZQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] mm, swap: always lock and check the swap cache
 folio before use
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

On Mon, Sep 8, 2025 at 10:08=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> >
> >               folio_lock(folio);
> > +             if (!folio_matches_swap_entry(folio, entry)) {
> > +                     folio_unlock(folio);
> > +                     folio_put(folio);
> > +                     continue;
> > +             }
> > +
>
> I wonder if we should put that into unuse_pte() instead. It checks for
> other types of races (like the page table entry getting modified) already=
.

Doing this earlier here might help to avoid the folio_wait_writeback
below? And checking the folio right after locking seems to follow the
convention more strictly.

I'm fine either way though as there should be almost no difference.

> --
> Cheers
>
> David / dhildenb
>
>

