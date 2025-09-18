Return-Path: <linux-kernel+bounces-822034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D266B82E80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A84E0421
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D9258EEA;
	Thu, 18 Sep 2025 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvi6M7kP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1F218580
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171067; cv=none; b=T0J83Q0pIC09Qm29UpN9WHrR2tq0ehiVjV4qCfy7J2duDuXfUM/XpB9HZ3NWbSP92zVyLDOe2yBOh26QibErre/oDXMJzWs0tCJMu5nIK+k/mOrDEAdXGnOh9HDMZe6MNKim77096FvLK2jRe3UdUmCII4FAXyEplmqJ9juGCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171067; c=relaxed/simple;
	bh=hSCbFYdol4gwU++b+q+6eG54SBwRB29n9V4ZoQ3yoqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biXxkdZy1yDxMyFLMZrAQf0k0g7qlLe7ur4+uP+v6PYvKYNLzCb5rQIzZnwy8rwJgWUAYadrnvLwwnBsMex7oyGnEsryAiKkC5JYLk4H6Ctp7WL4tCGVC/JTaZjnBfZdvM6FnMfE1pGc3A83byrMN520C1Je2JmJShKJfykRPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvi6M7kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF48C4CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758171066;
	bh=hSCbFYdol4gwU++b+q+6eG54SBwRB29n9V4ZoQ3yoqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rvi6M7kPzwgDwjRR+dHs6GZB2dtkrFpkcxSA6qk76jbky4SiLIY4pLQVCJPXuY1/Y
	 GHG8b+x7L4NAIjfZ9t5HDBcW9XRV1GA8pM7nBa0ipTV8J+/Ksk4VOavSbOrFjczFAB
	 PUtZywW+ZEohs4JPkXmLMA6TnDBnMCjvzdBuxYPDp49HBKKMxEQP852MR2NW22mw7W
	 kqN6ssGE1ynd5z7Ju0732sLq1Dd52OqW/3W29MrKGn2YR2M4MVnvb6o0hagQiweTou
	 htPgAzW7z73LZTXqtcfOi8HwfQ61ApdJSuZ0aAW4iqao2Jn6CBLxuVUieR3Y0JLNg/
	 +QaJAfSGT6gFw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso672553e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:51:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWm5JC8e1vxY0224SXVTesbd+2gc1Pt4BmxYKdgy5LROyCOIojyxSjyh21XU53VcVf+DZ+09acRKJYeLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQL0PE995nbzmpan75zY9nNuUWBrKAnz6aNf5o/5N5td2N2F7w
	OmdQ9DA0Yey8JcCorfqQr4JDuoQDIYO0AFvtaeRPq8b+F01Tnt2DRA0G+ZbtsZ4F94xG/svbczj
	TJIQfBD2cQxTEk3wXNloLnhbEToP/fQ==
X-Google-Smtp-Source: AGHT+IGgmr35+M05vhNol35FnfvJZhXDPXXRR6AIoJkQcdnzfAX1KrKgvXwk0v6y57+pEk1zXQlQA9r/6aTx3Dz3NtE=
X-Received: by 2002:a05:6512:2903:b0:55f:486b:7e5b with SMTP id
 2adb3069b0e04-57799405777mr1451888e87.41.1758171065295; Wed, 17 Sep 2025
 21:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
 <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
 <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
 <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com> <CAGsJ_4xTPJo7+kCkkiZhn8b7xjH7yXeJ2XPoXeoJm+XwJB_o9A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xTPJo7+kCkkiZhn8b7xjH7yXeJ2XPoXeoJm+XwJB_o9A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Sep 2025 21:50:53 -0700
X-Gmail-Original-Message-ID: <CANeU7QkKS+1TvCRkJUcWQo_emyDJ-q261SfjKoPuEfPG3Pbifw@mail.gmail.com>
X-Gm-Features: AS18NWBUHzf4JRxxpGz4NBNi-ZdFJXllMYmFHXL-HaEBN1mSBaZpw2RCXXPZ-ak
Message-ID: <CANeU7QkKS+1TvCRkJUcWQo_emyDJ-q261SfjKoPuEfPG3Pbifw@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 4:50=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > Perhaps you could describe the swap table as similar to a PTE page tabl=
e
> > representing the swap cache mapping.
> > That is correct for most 32-bit and 64-bit systems,
> > but not for every machine.
> >
> > The only exception is a 32-bit system with a 64-bit physical address
> > (Large Physical Address Extension, LPAE), which uses a 4 KB PTE table
> > but a 2 KB swap table because the pointer is 32 bit while each page
> > table entry is 64 bit.
> >
> > Maybe we can simply say that the number of entries in the swap table
> > is the same as in a PTE page table?
>
> BTW, as Kairui mentioned, you plan to store the PFN instead of a
> pointer in phase 2.

Yes, let's update the document then and only then. Otherwise the
document will be mismatching the code and confuse the reader.

>
> I wonder whether we need to switch to atomic64_t on systems where the
> physical address is 64 bit but the virtual address is 32 bit :-)

It is possible we need 64 bit for the swap cache anyway for other
reasons when we get into the later phases. Again, let's deal with it
later.

Chris

