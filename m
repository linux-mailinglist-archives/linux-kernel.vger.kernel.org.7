Return-Path: <linux-kernel+bounces-821392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA3B81237
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CCA16874A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE642FCBF5;
	Wed, 17 Sep 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc22X9eD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583D230270
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129170; cv=none; b=Jd9H1EDzNwC823WqSmDjNlYfr5CXJZXdaLGl8ehGxCjR348bMwxJ+HMKp9alulespWLmw5MogDMx6nMNrxVVc7C1Papb4JC/B97fXtHHWpYNMfBxaq06GaucRCRtb97iowfcPlugnyyBzilAed/5QIQurQi+YOjt2GUQQY0mIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129170; c=relaxed/simple;
	bh=6yuEuVQsyw6TlrxFPqJhgc7eImQajVyZhThJ1SvONOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNzunjOsIKyswA+xu9NjPFTA6lwX5LTJJ7tODhCNylMLwR174gQK5Z45gOQ6zg6d0n16bTKh3FgPRzpfQVUC6T066MX9FU44zP90tdwUjmdcxuBpGKQE+2UUoHoVjMxXJtGfb74X2zpIkmK9VZ5GMc5e4fTaEKtVBK2GXWJbDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc22X9eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B5AC4CEE7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758129170;
	bh=6yuEuVQsyw6TlrxFPqJhgc7eImQajVyZhThJ1SvONOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zc22X9eDpdOL4W4eBKizdfaCC0VttxSHXAwiSQtGB3WvAm/uQvG2TQwRUtL3kV9W7
	 4+efetiASPjcbftC1O/BYj8sk+STgg+zhMHnLgQWh/4VQVSdfYnPQjc7xW0g1biXSi
	 bzkNVcBIuYl3T/5SHZ6YHA78P3MboYUUodLEdcvgGM5/OjojHxwJ+OUqNVvB9BmJIb
	 gk+Krxh82BdxEfUhItMAftlmWQgGxgEgec+PU5xCjQSGnwha0xXo8evW+A74WrT3vY
	 xaC693d7aQ7Ggvwj6eLrrBCTRA9d7RzsTdpoQlxwQf5WCtldaekecAoAyypN0lVcqf
	 QtOHtsceJmxFg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60150590so810587b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:12:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMSNzONLz2YOkl9pMqtSqyJazFi0P/Oj0sBfAIOAMI677wqflpgq+srC1F1ezdaDXOctrRygps6sABqNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2r1n+sHJYz3i9qq8T0TPNgd/t3+EYe8YY6jAT9QGxCY1QtSk
	USEs+V/VqtKqVfDnpAigx2ShrJ3wQErqTVBSQipFHiw7CmlVE5YSRaz5BmfyiZ0S9mn9KpXubQa
	/odlIL/YC9Y+GiBdv5QeWGfUaqauMLOXnqrQzWaNOSg==
X-Google-Smtp-Source: AGHT+IFd888IRBE4Sf82BHMCQfDhWqTS3ION4XiTCcKYpkm4cn07bM0uPiFHOr4mYnxepbYWwhnWlnLG5H94D/W/SNY=
X-Received: by 2002:a05:690c:48c5:b0:729:f78b:4261 with SMTP id
 00721157ae682-73892549c74mr22655067b3.38.1758129169547; Wed, 17 Sep 2025
 10:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-2-ryncsn@gmail.com> <20250917161432.53960-1-sj@kernel.org>
In-Reply-To: <20250917161432.53960-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Sep 2025 10:12:38 -0700
X-Gmail-Original-Message-ID: <CACePvbVq698sKmH_oWi448HybDS0EB8DKXte-pFVB5mwvcNA+w@mail.gmail.com>
X-Gm-Features: AS18NWCm0IEjP5lKC3pZd8YW-DiiHhyK2Pdy3yyGTDhxAVu8k_fGiPAVahiFVEo
Message-ID: <CACePvbVq698sKmH_oWi448HybDS0EB8DKXte-pFVB5mwvcNA+w@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: SeongJae Park <sj@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:14=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 17 Sep 2025 00:00:46 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Chris Li <chrisl@kernel.org>
> >
> > Swap table is the new swap cache.
>
> Thank you very much for doing this great work!

I only did the prototype. Kairui did the heavy lifting.

> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  Documentation/mm/index.rst      |  1 +
> >  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
> >  MAINTAINERS                     |  1 +
> >  3 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/mm/swap-table.rst
> >
> > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > index fb45acba16ac..828ad9b019b3 100644
> > --- a/Documentation/mm/index.rst
> > +++ b/Documentation/mm/index.rst
> > @@ -57,6 +57,7 @@ documentation, or deleted if it has served its purpos=
e.
> >     page_table_check
> >     remap_file_pages
> >     split_page_table_lock
> > +   swap-table
> >     transhuge
> >     unevictable-lru
> >     vmalloced-kernel-stacks
>
> The above diff is adding this great document on 'Unsorted Documentation'
> section.  Could we add the document on the main section?  I think swap.rs=
t on
> the main section could be a good place, and wondering what others think.

That is a good idea. Will do together with another minor fix reported
by Barry. I will move it after "swap.rst".

Thanks for the suggestion.

Chris

