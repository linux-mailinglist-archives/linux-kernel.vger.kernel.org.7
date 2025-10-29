Return-Path: <linux-kernel+bounces-877128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C6C1D450
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB2E54E2E89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083372E6105;
	Wed, 29 Oct 2025 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhjUqb6m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370A1805E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770771; cv=none; b=ifs5pLMjuf3dZgEKeNz0x4zlSq8keAv9OTfoefmsMiKlsgOHBf2iFFND3sgK6WLpIH9LI/bJk/oQHrS7LIhupTlxrXnOCOgF2tU4k7ibuderZPOy3il4knZgcAS3jN6vBptnPbbN0fyPS9B5uavsV2iSFZZBnDeDZkyzShLZoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770771; c=relaxed/simple;
	bh=Oc7TviWFReNwMnSXKOGb/n3L3/gUc3bxbMJqDDekPOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bho4Jsrn3S9EIHjhXhMreb44Cl06lq6dxBJDgWi96ju/na8sBd/xbdcFo4fOXJqGFrs9vvkxIOCLCwTIgG4LZ62LeWndowdIrIDWMA0GYhQCbYDVEUjiBI2Vo0ya2qKZHMRdv4vAMbUCTrhko0tW6XLGQEqjDYWm+Lnsak+T/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhjUqb6m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761770768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc7TviWFReNwMnSXKOGb/n3L3/gUc3bxbMJqDDekPOM=;
	b=dhjUqb6mg0S1cykpQw2fBRWlpR3VEz/ZswOPNMZ1NzaUfycq49TqZSm2rbcF5rWLC+6968
	u8yCJTSMLUwqwCaaK5kBDxuAYhik0GOnO559ub8WxtTmazPpTI1Zuox9M8dUZ4hOPLczSF
	0G5mgIucCMTFfkvSNahlE0NyNHURZsU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-rFJysklqNQW7N9pmq-_Nyw-1; Wed, 29 Oct 2025 16:46:07 -0400
X-MC-Unique: rFJysklqNQW7N9pmq-_Nyw-1
X-Mimecast-MFC-AGG-ID: rFJysklqNQW7N9pmq-_Nyw_1761770766
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-592f6f0a15eso115146e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770766; x=1762375566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc7TviWFReNwMnSXKOGb/n3L3/gUc3bxbMJqDDekPOM=;
        b=hd8xRzldvx9XxlXeKJm+Mq1YGmX8Sil2bmCkYxN1zKX2xsJCYP7hCE/JQ6cKEZEc3s
         UxstIivlAYGFq+Pfjm9NENgVqwS1zjvJoxnf3+ifxiiX4C+fLXu/2KWwgHFXlfpFp78A
         RKCwL9NP4LNuWOKpNgKo6N5ohIRlFygwGwOeadnvPs2QJOHYxq41lqpCHlVizfCvOR+7
         2Fdf0UxA7p+WMFJZPdToJHCUXNoLtr1CR0Wgs78HJh/sPW3UaX9GS9hQWXWT350u113V
         OOZXyHynNGuYDxLcj7SO21Dt8Y7xPWd1usrd6vbNWwELbM3UYDaj1E/2grCv1Xqd6xAu
         gC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAw0SNl7mS8RnUc3M9+aoO5HVOsben3yR0NyZDd8ipIB6jIxDEE0vkmPSy8xn/SeyPw4kqKxWBizFStKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IDrR7Mbqaqgo4/Nw/yXXxI0MwWPQpIQns1ZxOe3aQRoLR38X
	luIqlWplHuYznTeNtA3l3OuMTifbii97NfKDqIcKwj5/pRMNY2mhDVHzEW7bP+Iy6qt4xNkZ23d
	ncr7+I/y/cQXKLfSJf2dFD3bA4GIqVdTiUzgT29EteZpmxA/TEZJs8zCcC8eHMB3MVSReYeqA1T
	6BrAdI1wfw6R14EZYIgjm864wYnz/pg/7ckAbTEGU7
X-Gm-Gg: ASbGncuJg15RTqFE247Vo6b/1biFmo9C1cd5KtKsz2ChRWITXmlfKTkcCrDbUEFLzMV
	/EEkSm6jwkET1/wXKFTi+IMG9cIxpEMBSrwRiTeH5Knf7aYmHcOx1jgoyF4uFWJhChi2COnzukY
	LcFXUVJKYMhumjRtZDkkQ6d0F8/Mex7qCiYoUpctif9z0nabUg4yUA+i9d3KL8BuywNhkIxw==
X-Received: by 2002:a05:6512:b20:b0:592:f263:a8be with SMTP id 2adb3069b0e04-5941287135emr1435968e87.17.1761770765593;
        Wed, 29 Oct 2025 13:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESQyEgec9ex4Rpf1NItxvzspecqCkRicn0v9c5QWtVC9BBjbVp+t2j6z7oKTbm0IWm6xmKhy+0SdXD0hdMpZU=
X-Received: by 2002:a05:6512:b20:b0:592:f263:a8be with SMTP id
 2adb3069b0e04-5941287135emr1435937e87.17.1761770765022; Wed, 29 Oct 2025
 13:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local> <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
 <9a3f2d8d-abd1-488c-8550-21cd12efff3e@lucifer.local> <e2a89e74-1533-4a83-8d0f-3f4821750e25@redhat.com>
 <64b9a6cd-d2e4-4142-bf41-abe80bf1f61a@lucifer.local> <dc002ef9-53ee-4466-b963-baadfd5162b7@redhat.com>
 <a97780ab-6256-43b7-8c0a-80ecbdc3d52d@lucifer.local> <2d8ed924-6d06-42e4-a876-381fb331f926@redhat.com>
In-Reply-To: <2d8ed924-6d06-42e4-a876-381fb331f926@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Oct 2025 14:45:37 -0600
X-Gm-Features: AWmQ_bm4p9MBC5sUu8O6J9Sn0293VN6CpobZZzMQVEnRiyb3Ke7AEB3M45KqdEg
Message-ID: <CAA1CXcBi8N2a3b4uEKQ8mzGWTiUEVuPDXx3vonDyBDakjd9bHw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:04=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>
> >> No creep, because you'll always collapse.
> >
> > OK so in the 511 scenario, do we simply immediately collapse to the lar=
gest
> > possible _mTHP_ page size if based on adjacent none/zero page entries i=
n the
> > PTE, and _never_ collapse to PMD on this basis even if we do have suffi=
cient
> > none/zero PTE entries to do so?
>
> Right. And if we fail to allocate a PMD, we would collapse to smaller
> sizes, and later, once a PMD is possible, collapse to a PMD.
>
> But there is no creep, as we would have collapsed a PMD right from the
> start either way.
>
> >
> > And only collapse to PMD size if we have sufficient adjacent PTE entrie=
s that
> > are populated?
> >
> > Let's really nail this down actually so we can be super clear what the =
issue is
> > here.
> >
>
> I hope what I wrote above made sense.
>
> >
> >>
> >> Creep only happens if you wouldn't collapse a PMD without prior mTHP
> >> collapse, but suddenly would in the same scenario simply because you h=
ad
> >> prior mTHP collapse.
> >>
> >> At least that's my understanding.
> >
> > OK, that makes sense, is the logic (this may be part of the bit I haven=
't
> > reviewed yet tbh) then that for khugepaged mTHP we have the system wher=
e we
> > always require prior mTHP collapse _first_?
>
> So I would describe creep as
>
> "we would not collapse a PMD THP because max_ptes_none is violated, but
> because we collapsed smaller mTHP THPs before, we essentially suddenly
> have more PTEs that are not none-or-zero, making us suddenly collapse a
> PMD THP at the same place".
>
> Assume the following: max_ptes_none =3D 256
>
> This means we would only collapse if at most half (256/512) of the PTEs
> are none-or-zero.
>
> But imagine the (simplified) PTE layout with PMD =3D 8 entries to simplif=
y:
>
> [ P Z P Z P Z Z Z ]
>
> 3 Present vs. 5 Zero -> do not collapse a PMD (8)
>
> But sssume we collapse smaller mTHP (2 entries) first
>
> [ P P P P P P Z Z ]
>
> We collapsed 3x "P Z" into "P P" because the ratio allowed for it.
>
> Suddenly we have
>
> 6 Present vs 2 Zero and we collapse a PMD (8)
>
> [ P P P P P P P P ]
>
> That's the "creep" problem.

I'd like to add a little to this,

The worst case scenario is all mTHP sizes enabled and a value of 256.
A 16kb collapse would then lead all the way up to a PMD collapse,
stopping to collapse at each mTHP level on each subsequent scan of the
same PMD range. The larger the max_pte_none value is, the less "stops"
it will make before reaching a PMD size, but it will ultimately creep
up to a PMD. Hence the cap. At 511, a single pte in a range will
always satisfy the PMD collapse, so we will never attempt any other
orders (other than in the case of the collapse failing, which David
explains above).

Hopefully that helps give some more insight to the creep problem.

Cheers
-- Nico

>
> >
> >>
> >>>
> >>>> max_ptes_none =3D=3D 0 -> collapse mTHP only if all non-none/zero
> >>>>
> >>>> And for the intermediate values
> >>>>
> >>>> (1) pr_warn() when mTHPs are enabled, stating that mTHP collapse is =
not
> >>>> supported yet with other values
> >>>
> >>> It feels a bit much to issue a kernel warning every time somebody twi=
ddles that
> >>> value, and it's kind of against user expectation a bit.
> >>
> >> pr_warn_once() is what I meant.
> >
> > Right, but even then it feels a bit extreme, warnings are pretty seriou=
s
> > things. Then again there's precedent for this, and it may be the least =
worse
> > solution.
> >
> > I just picture a cloud provider turning this on with mTHP then getting =
their
> > monitoring team reporting some urgent communication about warnings in d=
mesg :)
>
> I mean, one could make the states mutually, maybe?
>
> Disallow enabling mTHP with max_ptes_none set to unsupported values and
> the other way around.
>
> That would probably be cleanest, although the implementation might get a
> bit more involved (but it's solvable).
>
> But the concern could be that there are configs that could suddenly
> break: someone that set max_ptes_none and enabled mTHP.
>
>
> I'll note that we could also consider only supporting "max_ptes_none =3D
> 511" (default) to start with.
>
> The nice thing about that value is that it us fully supported with the
> underused shrinker, because max_ptes_none=3D511 -> never shrink.
>
> --
> Cheers
>
> David / dhildenb
>


