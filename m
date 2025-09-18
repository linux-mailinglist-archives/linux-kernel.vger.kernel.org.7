Return-Path: <linux-kernel+bounces-822366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E0B83A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5949217FE06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575092F7446;
	Thu, 18 Sep 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCfzMNEC"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BA1E32D6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185947; cv=none; b=Y5mkf7zaNRh+o2u1zTEJeJVQCkQnYxmX95yzuEiJsQXkeF93GpPgN6h/antAZoaRBp+riVVGzLwufABltPeFrD8xKhzdJgf2gpwvV8QceigF9X+rZFLSf11hihOXYAgJ192g8obpN0GSnaguLdDjDnICxvx7dvHil44yRMEeEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185947; c=relaxed/simple;
	bh=3YBijHHPgjAyl07nG2F+4O+IZKa9So+D2+79Hhyhtjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuxf45QXmCvd8lkzvkX+Cin+vLNxs/eN/r7YFn1g8M7q1CNz4nWz/iHb/RKFPHyLoSgp8ZMTIi9x/CzzlFEghgi2O0ljyxX0aSh2ppav5jfltpK2aEw7MeBErBI1A2mOj5xiOQ+tx+dPuNGpb2FsibCdiPMeT5/r2H6Ok6i5sPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCfzMNEC; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54a30c66258so188986e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758185944; x=1758790744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YBijHHPgjAyl07nG2F+4O+IZKa9So+D2+79Hhyhtjs=;
        b=QCfzMNECjPUgyFa2EJtP3I9kskdycH6zpaKCRAvSJ/YbtadYpn7lKz5N976AZlpQeO
         1kCNcwIuw3avw2O3+60arZWBCKfAJKitv4CEEMIRVJM1u8M0cGQGQq4Ll8y/rK+ZhW67
         Tp1np4F0gLtIRs1G0EOg/IY1JEn3Qo/ruQyEmIT/tFD+flidgcuhzO4hiL9T0oafZtQm
         W7AXQzTLgpq/8BeO9aftTLamuW13GLis3ZxpyJ3QWrZlkq9oY+mFbifBHC0GvitbcsmG
         SH0tZDSVHN7BLwqO5G/7mwo2vbMXest30TyOaFQvpXxJadNZawqePXUNpaHInVcGLABN
         9Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185944; x=1758790744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YBijHHPgjAyl07nG2F+4O+IZKa9So+D2+79Hhyhtjs=;
        b=MqD7mnR53IQBpsqT8CKi5EXdAJ7cj1sZ0ZBtExOSibKYSynRdZMVKRSfNjnZXbDxkp
         XoaRsiHD07jN8duPPpZT3qjaFJwBCJ3ln1mMFjUPyrGEqxlSlvJE/mvhskcywGYn+NKV
         nhuar9CvgPADzQ1QBRujGglztobkCqSVecGJEqTJ2cRT2WyB1/rqY9Y7bXbqRqNlMLE4
         07zWdk8Brz3LLt6wfBGTZMQgCduUtfxx7DiupjwzZJtfxvz/G03MMn3B5eBnZld8mRW7
         X+zJt8J5GKgnEBdZas6BYLRul8Qjes6+h6cJS/5/Y9jpleZufBQWVtI0ZuwXd37gVLvw
         K2fA==
X-Forwarded-Encrypted: i=1; AJvYcCUDwpZZV85r7V0g7w5C8ZEX9lzAQjW5Xe3h1stToAJ3piXjzXqmXxCHm+1Rrl22k0wyQGukTu5dVQR1as0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMAVpwmaE6fw0Y9Nlcwfo86sMb0eWvxvOdx2L+SfqNDFetpEI
	2hJmfv/0eMv3LerwjGYyyZsdE+nEHfSjB2QtV252qk7ofitvGN7LbCJE9sPak88oLHxWm5/HoaB
	3+bBm18Oe5JekVZ3902s4rTndAPuDMj4=
X-Gm-Gg: ASbGncssKjZjjQyt051gcjzvjqubdLQdJ2ZkrsMI3HX/Zq2ldYBLTt0pywefEuKdpIu
	7BE3RuzIlgzMUZbHkWlCiCK3WI0zmX7fGY2g07w7ZEM5RBtlGgWbbstX3eIP2cseKW8I7pXKmRf
	0uVQf6wv/SWJnO47P8Xn2qHcUJAcdSwS21bfhJw5t0OPy3mKOqF3543d6bg1TmEQgsEq1LUVaST
	Tnsqe3uqxHt1XXzoffmzoXYTuWjtAxBhWMruMtRmMkN3CCzI/ArtOSFOKv8
X-Google-Smtp-Source: AGHT+IG9PAZlU5wX6CfCuIPG52y8YmCpl5qUjiXZykbS1/b+bgq6fwmzpG5T/XrmW/++davGQcBL0s5sdx3isOtSuHA=
X-Received: by 2002:a05:6122:2a16:b0:54a:71f6:900f with SMTP id
 71dfb90a1353d-54a71f6bfccmr745397e0c.0.1758185943888; Thu, 18 Sep 2025
 01:59:03 -0700 (PDT)
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
 <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
 <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com> <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com>
In-Reply-To: <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Sep 2025 16:58:52 +0800
X-Gm-Features: AS18NWAo-ti9La1j-oEkjznzIVvUZ14li7XE3QDuXeP6to8aA2ac4MfnZt-xdbk
Message-ID: <CAGsJ_4zmkibM_Ex7kGMsr2sni85H-cnxQvh0XwkWiALNQy+zAQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Chris Li <chrisl@kernel.org>
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

On Thu, Sep 18, 2025 at 3:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Barry,
>
> How about this:
>
> A swap table stores one cluster worth of swap cache values, which is
> exactly one page table page on most morden 64 bit systems. This is not
> coincidental because the cluster size is determined by the huge page size=
.

I=E2=80=99d phrase it as =E2=80=9CPMD huge page,=E2=80=9D since we also hav=
e =E2=80=9CPUD huge page.=E2=80=9D

> The swap table is holding an array of pointers, which have the same
> size as the PTE. The size of the swap table should match the page table
> page.
>

I=E2=80=99m not entirely sure what you mean by =E2=80=9Cpage table page.=E2=
=80=9D
My understanding is that you=E2=80=99re saying:
The swap table contains an array of pointers, each the same size as a PTE,
so its total size typically matches a PTE page table=E2=80=94one page on mo=
dern
64-bit systems.

> If that sounds OK, I will send an incremental patch to Andrew.
>
> Chris

Thanks
Barry

