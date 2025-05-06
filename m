Return-Path: <linux-kernel+bounces-635219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E23AABAA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DB01600FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072D2874F1;
	Tue,  6 May 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeYtJG+M"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FB27F4C9
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508119; cv=none; b=j8o7Qz8C+0dI3lF12xjV6OTl9hur4AEqAHYQYuEDM5wqcc24dHcDc/mTEMMcl2srpTCAoxIDoWwXhr+5i2kP3ZPmQj01D7T2caAavBU4Eatp0DqJDFAUZTJV7ZDcKQ5HTym+rMriCl+o9t+UN8ZikVD3RSjU+Zwtri14fhB5RRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508119; c=relaxed/simple;
	bh=rUsBS9Oa+C0VRUO/HZpkAD8ejfWfMt7BVTl5jvD7mZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6yET6/lXZnEKHaDdyb3fU5qa+RgtP7kXvi853tbAkYcewB6hwJcuBZsahiDsnmtCYdlbqdybkCw2t/gDp4V3jwLPuW/CsCfWHoMlt/mGpjnEJQIb05A/Qa3ujA5/ePKidsd914NJvuL/whOQh77WOuRBzTL2Bm9PDSnU2KEywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeYtJG+M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e1eafa891so101145ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 22:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746508117; x=1747112917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUsBS9Oa+C0VRUO/HZpkAD8ejfWfMt7BVTl5jvD7mZc=;
        b=jeYtJG+MZSSqtKmZPbzmlq7/N4upIBK5yre7j04KIS6ownbMsnnQlpd++8c+WGxbxj
         hFsSBhw9XmLNPB4/+UOVRWUoxbu8cmcM2FeAZb7/tWzFB1cERWFesIUFyKAF2yMy7z4R
         j4mFkofmfh1PTruqA7veDWeTP2rZy2OjNZUgV1+IBCMDuGzj+TDHT+8TUtKwJQuPcJQ0
         UKfdEK0WCO/514p84iYlrWlgQOPkccfSO5/NSxY9PJ2pGAw+eZfVm6L4f1bG0+4ShZQH
         bQNGhWsBLQ7dnV17m2c4g7aCktBMw5M52adpTt4nY7gsmcbZizJvaNqy3lwRD4K0PBfN
         J1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746508117; x=1747112917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUsBS9Oa+C0VRUO/HZpkAD8ejfWfMt7BVTl5jvD7mZc=;
        b=Mww39WHMt5UkEKvSYnD1i0tT8Qzszlq2rF/fqdKRkOXZCQlnhpGhWg2kSVFwD02KYw
         BdaaV53glV1kd+9uoBDg9c0Wn2duYboFoaTFyGAcW734j+gQ7/qlHZC3WXdrPHJ6kotI
         3L9BdW3zblOQH+Y5MyBrYR2CQOL/F5Q1l8tnu7+d0RDRNiFEKrsIcddregoCu5DbdxvY
         N6DU6h43JagZLu3gTBh6q01hvmwO5heCqY/EMRabYZSDwZmqEyAIT9wS5PCwNpHUQuXT
         gbru8J3kwkTM+y8YK3TEneDq9gi/LuYKeHKn13/MmbJNrkcGV59bKvA0t+clfvjVvWJX
         tzGA==
X-Forwarded-Encrypted: i=1; AJvYcCVqbgwRDVFWJsmBdmWjjHyNvBsOnvTpA3LvIZsURo02mdlD0xmaISlIOTc54RwPY1ma/E8Y4yymxKFGRkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVRkzXMl8/P9lAzUGjzaa1kWd7yFUA5FiBNDr7oLMRAkaZhoE
	9GqUmuev0nR4xWfF6sHNmndbnfrdUUhuFB2CqQt0Y1I7jhz9OzPkSb3U6tw0g6MatYKyKmS/4Nm
	FAUL0s6cVVPe5uuuu0CP/IhVP7Ir4hyJ5Sn1n
X-Gm-Gg: ASbGncsvaw4L0iWS3xFOTxKGmgHNdNy15DzWjyKzpHTmkL66tNW3+hnqKMqrwkZAt1O
	+mi3MBukETnrkTIgU8TRFFCUo+xE0ilZhASsJnv1FJRF50578wuAbRY5eRAvS5ot3TctF32KwCC
	/LM4Ak6+92ERlqEP3EgYHvfhZR8AXTWn5eR3mBBUsPZCq/9OuhkP49AJA=
X-Google-Smtp-Source: AGHT+IEkmVHrS+IeESYp9Bj0DUHQ0GCYSuq6HTfd9DWzMVCD5BSFldlOTCzMt/mb/B9tNXB4lUPvZrR+FyGxHBMd0tI=
X-Received: by 2002:a17:903:32c1:b0:220:c905:689f with SMTP id
 d9443c01a7336-22e3b2cf6a1mr1180265ad.25.1746508116581; Mon, 05 May 2025
 22:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424030033.32635-1-yan.y.zhao@intel.com> <20250424030603.329-1-yan.y.zhao@intel.com>
 <CAGtprH9_McMDepbuvWMLRvHooPdtE4RHog=Dgr_zFXT5s49nXA@mail.gmail.com>
 <aBAiCBmON0g0Qro1@yzhao56-desk.sh.intel.com> <CAGtprH_ggm8N-R9QbV1f8mo8-cQkqyEta3W=h2jry-NRD7_6OA@mail.gmail.com>
 <aBldhnTK93+eKcMq@yzhao56-desk.sh.intel.com>
In-Reply-To: <aBldhnTK93+eKcMq@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 5 May 2025 22:08:24 -0700
X-Gm-Features: ATxdqUG39x19IjwosYztIXaovUZ6HU5KeKyPyCUt-tTIluSky-qf1VEpEVHS-Wg
Message-ID: <CAGtprH9wi6zHJ5JeuAnjZThMAzxxibJGo=XN1G1Nx8txZRg8_w@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, rick.p.edgecombe@intel.com, 
	dave.hansen@intel.com, kirill.shutemov@intel.com, tabba@google.com, 
	ackerleytng@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, ira.weiny@intel.com, isaku.yamahata@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:56=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> Sorry for the late reply, I was on leave last week.
>
> On Tue, Apr 29, 2025 at 06:46:59AM -0700, Vishal Annapurve wrote:
> > On Mon, Apr 28, 2025 at 5:52=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com>=
 wrote:
> > > So, we plan to remove folio_ref_add()/folio_put_refs() in future, onl=
y invoking
> > > folio_ref_add() in the event of a removal failure.
> >
> > In my opinion, the above scheme can be deployed with this series
> > itself. guest_memfd will not take away memory from TDX VMs without an
> I initially intended to add a separate patch at the end of this series to
> implement invoking folio_ref_add() only upon a removal failure. However, =
I
> decided against it since it's not a must before guest_memfd supports in-p=
lace
> conversion.
>
> We can include it in the next version If you think it's better.

Ackerley is planning to send out a series for 1G Hugetlb support with
guest memfd soon, hopefully this week. Plus I don't see any reason to
hold extra refcounts in TDX stack so it would be good to clean up this
logic.

>
> > invalidation. folio_ref_add() will not work for memory not backed by
> > page structs, but that problem can be solved in future possibly by
> With current TDX code, all memory must be backed by a page struct.
> Both tdh_mem_page_add() and tdh_mem_page_aug() require a "struct page *" =
rather
> than a pfn.
>
> > notifying guest_memfd of certain ranges being in use even after
> > invalidation completes.
> A curious question:
> To support memory not backed by page structs in future, is there any coun=
terpart
> to the page struct to hold ref count and map count?
>

I imagine the needed support will match similar semantics as VM_PFNMAP
[1] memory. No need to maintain refcounts/map counts for such physical
memory ranges as all users will be notified when mappings are
changed/removed.

Any guest_memfd range updates will result in invalidations/updates of
userspace, guest, IOMMU or any other page tables referring to
guest_memfd backed pfns. This story will become clearer once the
support for PFN range allocator for backing guest_memfd starts getting
discussed.

[1] https://elixir.bootlin.com/linux/v6.14.5/source/mm/memory.c#L6543

