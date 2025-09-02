Return-Path: <linux-kernel+bounces-796562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1A8B40279
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD81B22AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936132D6E4C;
	Tue,  2 Sep 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0YHo9Ca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55552BDC17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819052; cv=none; b=JI9UBRy5k2BcEgRT3U0+gZVoPSqROb4LjwXwCqXn1ZrIGA+VEIUiZZD5jhKGPNcBUmxBJQ0LnBr8qxBt5gXKCiNi/Ti36MXqZP54iLcfcwcseolfJnX0np2Fx1NYOWfX8cOpRSmzFynJOZjJLiNrLo82qeY+1w6I+m2FbjhInOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819052; c=relaxed/simple;
	bh=P4DRa5JyII0VmmjBaXPWBiaM6z9yrS48QrKnGh0SnUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6fimvYtOKR9unQKTvwN4QLLOEdz8wr8nu/x13W2uUmfUiD44LcVy0BXGVZ77LR60bum75E1cAOdbu06KPPhJH4HvCabPKsOPmpCeZSP5+nz3U3JvqMTU3MDuYBnT0pkKs1SGPVPYuDuOF4JycTP+qmuvKntP+GL/8yk1+3HeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0YHo9Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF71C4CEFB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819051;
	bh=P4DRa5JyII0VmmjBaXPWBiaM6z9yrS48QrKnGh0SnUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0YHo9CasoNdIWBnC6ZWofH+6+jqufHWP1dOSTmjkDrgktqxjbx7FfSye145xBY8e
	 pE/N5HwOFiIwYrkaJTcy6Scp3N23RjmOUqQhp2n0JW1m5sqaAjOi//5ivjAxt3LdnF
	 bMaSRDh8LY53loUz3hBh28yEdX9viNdSxeYRd5X1U1Z6FSkQmGmU0gNbWcpIwmO6fg
	 5bSpDsAOnAdZ5q7jlK1NRGsWpRpWAn8WnnN2fe1PNpdP6l1D4hToGGvJPZmbuGwHsC
	 CVuh88KrE96N84P2Ul4Kutwqv49prfq28tLqn8hOS5VNeDyeuEr7cvnOCTbnDGEuO2
	 lI5euodoUpW0Q==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-723ad237d1eso4355727b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:17:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAj8gu/hM21WfaPofc1p1zpW7sInPSAsaNCQJMeGYlCKkLdHPkVYmEjF+mjN1v0DVDbAUJTR29Ci87Fbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7qI/TbRyP+s7VTlV8gTxbXnOph/9C4zaoOFESYX2OCTVzBO4
	aBIQpWl8hSAXp/W1njFG92sCmrXs64J3+3PTBBEbW0nkae2Mq9/5KBAcZBGhxbD3He20XUvk+7r
	2c1RWMdddnXT35pO/OmHwXyuyBq7PiTO0gYHiwq6oIg==
X-Google-Smtp-Source: AGHT+IFyG1TWkVu49fYJr3rP5UGefFT3fiTlrwpJwWSaLn5aykXeZnUeAYEc1mU7ovusljsHKcgHt7hBrhUYRP9VA5g=
X-Received: by 2002:a05:690c:6311:b0:721:5b31:54c4 with SMTP id
 00721157ae682-7227654f437mr124374017b3.46.1756819050786; Tue, 02 Sep 2025
 06:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
 <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 2 Sep 2025 06:17:19 -0700
X-Gmail-Original-Message-ID: <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
X-Gm-Features: Ac12FXxDy3IryjPOmDhEZr0Uxc_iBeLDxMwIVpiY5RAprHfkS2MuWTBmDS4qd2I
Message-ID: <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Now swap table is cluster based, which means free clusters can free its
> > table since no one should modify it.
> >
> > There could be speculative readers, like swap cache look up, protect
> > them by making them RCU safe. All swap table should be filled with null
> > entries before free, so such readers will either see a NULL pointer or
> > a null filled table being lazy freed.
> >
> > On allocation, allocate the table when a cluster is used by any order.
> >
>
> Might be a silly question.
>
> Just curious=E2=80=94what happens if the allocation fails? Does the swap-=
out
> operation also fail? We sometimes encounter strange issues when memory is
> very limited, especially if the reclamation path itself needs to allocate
> memory.
>
> Assume a case where we want to swap out a folio using clusterN. We then
> attempt to swap out the following folios with the same clusterN. But if
> the allocation of the swap_table keeps failing, what will happen?

I think this is the same behavior as the XArray allocation node with no mem=
ory.
The swap allocator will fail to isolate this cluster, it gets a NULL
ci pointer as return value. The swap allocator will try other cluster
lists, e.g. non_full, fragment etc.
If all of them fail, the folio_alloc_swap() will return -ENOMEM. Which
will propagate back to the try to swap out, then the shrink folio
list. It will put this page back to the LRU.

The shrink folio list either free enough memory (happy path) or not
able to free enough memory and it will cause an OOM kill.

I believe previously XArray will also return -ENOMEM at insert a
pointer and not be able to allocate a node to hold that ponter. It has
the same error poperation path. We did not change that.

Chris

