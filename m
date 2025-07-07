Return-Path: <linux-kernel+bounces-720331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD41AFBA62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23854A55F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC3194C96;
	Mon,  7 Jul 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e041tUKA"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2622A4DA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911781; cv=none; b=nEZqrML4YvKV6k6A1GSu9Vpdc/DwzNUb8M/uqQaEbhYIAkBzpJJABHvG+mKCpU4verOwyU2PCz+hZxlrUBkffLsOg9fULI3CtE0TKp8WqmoxYU4e82SPMn5qirxpsL04RI6gPhpk92LR5FehszHpCvxN4E3D7xG845i0SLGHoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911781; c=relaxed/simple;
	bh=PXvVCyvgHb0eHBfQ0bThDfdbXMaikQlhmHXanhLrTdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK9PYfOe2KxB57CA9CXY6e/fyoSSKMr7HwMQaiATFlfN3+1Jq3Dq2SLVJVtGDS9TL3QKflIAmOVeVfGjQVGbfq++kRmv64kI5oTxDGR8J+1RE9dw62zUvAy9UD2+U1fv9+G7xhIU9EZhzeUTPwN9hYq4Uae4BqOYEyVjTDV33dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e041tUKA; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e812fc35985so2835762276.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751911777; x=1752516577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXvVCyvgHb0eHBfQ0bThDfdbXMaikQlhmHXanhLrTdw=;
        b=e041tUKA2RUHgU1A/PX4XENmCCATfpqbwVkWm5XRnZrNUQer4xIieucZloUvC3yi3A
         66c0RhmtEP1awHOlmIF4N/bdUm/Qz+lPEHL17Wrc6JLDnr+p6ZGR8ID1TwV5JqvS/krG
         FKSn7LUMkBvY3kUMdciO59x/1JjG6Tk4KJji+Y2z0lzFu5K93LTbzBfU9IecKiT0UGOJ
         C6kzP4haB/GassxPnZQVNqlOqc2PVE4SExdpFdM4iMZbDCymhfxERzB+koaMivXipUNM
         PsIQryNkN+T3PA2V0rlaFpe0NIOP146z+bIZrR68DDeUAfY0htR3YnLX5zcDu2t1bVqH
         ovoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911777; x=1752516577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXvVCyvgHb0eHBfQ0bThDfdbXMaikQlhmHXanhLrTdw=;
        b=R9cmNSs7i5PaA0Vj7wnZQsCbISvK2gusQw0WvzZ7EMC59uzPqpt57Y+bE2sjf+/1nI
         06GRHBh41WEioY58VkJK2/fm/8j1Q/LKFlGpY1VC60a4WeX4iDQQFhCJcCJrWcSxPXw/
         52Jvd0Ng/rZ6B7rYkau+VtC9KZhHFvOb37Mrii7U/wRXjOmFfCwanWaVFPGG37xR77fb
         pNienCyYu9tKjwmTia5RSZRYSdz/qdO+Dz7qtw5icIk8gJxmCYp1DSxAl2Z2e5LhYR4h
         s3j+r5kTIDI8TDGL/e9sLiyFkz9xfLXOzSk/GUqZoOe7bPrg4MTCC01QLCnme4XrXREL
         slYg==
X-Forwarded-Encrypted: i=1; AJvYcCX+10JF1wlzakb5Tj0rILRgXEAARqPpvh25v2IvFF0IeB/AXhJ4utcn9rmpF1KFROVdLcrUit3uSLK7R68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYdrhq9KXfd6ebPNhmsu6cOmat325f1EIqEtRtmdG/5cA27QQt
	5HYlH4qRaHpaCNwKNZwrscgPBdhwHCqGlwlWcsS04G8ZAmw//hw8o2KF4hB8its4xt10RIAxXTJ
	W+DAC6oeJqMRXYNtvNl2x+giEu4SxmUivxsdB9H1s
X-Gm-Gg: ASbGncuj8DdVjfpBSmsTQO0GUYy036GMgPeA8eq+XoyDhGOtM3hPo0yDKzmGYrTX6xJ
	VOxt9iOwFemiFzEG5LCIW8fP+aSOs55hzxNDUpSQPFyUDpSOH7kQ+Gq9cxnqd0Wo5xJnW9ydGpT
	sSWYAmnTT5mjqkTFFVaecqUz8V7bPr/KEn3DRmq7Rbu521nOW41AEZR1HQkHRMG5iUO3S/bR5KZ
	Q==
X-Google-Smtp-Source: AGHT+IHw3HaZiyB/1y8CtGslDwQWQzV0+e50NJs7lEmDy5dHXsDu2ggjTmBQ1yT/1DSW6T5pgUsirP3gLE9OKHg0VWE=
X-Received: by 2002:a05:690c:941c:b0:714:583:6d05 with SMTP id
 00721157ae682-7179e42c376mr6996117b3.32.1751911777302; Mon, 07 Jul 2025
 11:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <782bb82a0d2d62b616daebb77dc3d9e345fb76fa.1747264138.git.ackerleytng@google.com>
In-Reply-To: <782bb82a0d2d62b616daebb77dc3d9e345fb76fa.1747264138.git.ackerleytng@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 7 Jul 2025 11:08:59 -0700
X-Gm-Features: Ac12FXwKcvqRRUd0nsd7X92g5DnBajTeAMgxLisNdzU_VSoAb0b8Kq03tT52h7g
Message-ID: <CADrL8HW-vMqkocOxWURRB5vdi+Amx5QE6sNQOJx4hpD5L2rp5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/51] mm: hugetlb: Cleanup interpretation of
 map_chg_state within alloc_hugetlb_folio()
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:43=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Interpreting map_chg_state inline, within alloc_hugetlb_folio(),
> improves readability.
>
> Instead of having cow_from_owner and the result of
> vma_needs_reservation() compute a map_chg_state, and then interpreting
> map_chg_state within alloc_hugetlb_folio() to determine whether to
>
> + Get a page from the subpool or
> + Charge cgroup reservations or
> + Commit vma reservations or
> + Clean up reservations
>
> This refactoring makes those decisions just based on whether a
> vma_reservation_exists. If a vma_reservation_exists, the subpool had
> already been debited and the cgroup had been charged, hence
> alloc_hugetlb_folio() should not double-debit or double-charge. If the
> vma reservation can't be used (as in cow_from_owner), then the vma
> reservation effectively does not exist and vma_reservation_exists is
> set to false.
>
> The conditions for committing reservations or cleaning are also
> updated to be paired with the corresponding conditions guarding
> reservation creation.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: I22d72a2cae61fb64dc78e0a870b254811a06a31e

Hi Ackerley,

Can you help me better understand how useful the refactors in this and
the preceding patch are for the series as a whole?

It seems like you and Peter had two different, but mostly equivalent,
directions with how this code should be refactored[1]. Do you gain
much by replacing Peter's refactoring strategy? If it's mostly a
stylistic thing, maybe it would be better to remove these patches just
to get the number of patches to review down.

The logic in these two patches looks good to me, and I think I do
slightly prefer your approach. But if we could drop these patches
(i.e., mail them separately), that's probably better.

[1]: https://lore.kernel.org/linux-mm/20250107204002.2683356-5-peterx@redha=
t.com/

