Return-Path: <linux-kernel+bounces-873896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE94C15089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA32A643EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8621932E158;
	Tue, 28 Oct 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilq1sMQj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7432F5A2E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659865; cv=none; b=hi2Wce+Jj3lgIUdO7tOFlQokc7VlvIbfQqdyNHQQ5rR8kuCjQ0FLZnGsEz+qfh+Fm1tif9Fms55eCyc1/uBRESqc7mD3HnT8F6OCE282uV2GrxEY8dbDHZda7V+X63gvhHoWoGL76ufNbCcsDKF96H2dGYSuxTjotK7Ou43P0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659865; c=relaxed/simple;
	bh=q93XS7rxWX1d47F9BHW+z4FSVPJNGfsk3OO3XLSkxOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmlJcujGd88+GV7QhRzDduPpKYF6CW3FU0fPjq0eLfHf2NbOnvOWwOUn+MNJjTn6FsWJ3sL2YdMtJW4IJtwyAobML3x68cnGX63CuIrOJfkyoiZBz9Uzob5nJ0zKvrJ7+Nd8ufZmdiHgw3DFhFAI6JWrnuNOVsjOHv0O/n07oWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilq1sMQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761659862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hqcLTFSFJa32UdZBca8XVOOo6ca/YUGze1PkGPNkVo=;
	b=ilq1sMQjzDxxv0FTTVTpZ/G/WqzhAuiq5Vd/a/WjEm5evM8e1cACrPq7M3/jKyHqzsNlnT
	Dx/2+dy7eQqIUl123ctFjHeB4R8YJ1r6WEmOZLTo3nbsF2ai7WmLiZAfPEoEMzl7Nbll50
	7s7Z0jEVc1EPIKojp3Xj0ptk9Mck81A=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-q_Ll9y1FMCOdnAMxmvD9RQ-1; Tue, 28 Oct 2025 09:57:40 -0400
X-MC-Unique: q_Ll9y1FMCOdnAMxmvD9RQ-1
X-Mimecast-MFC-AGG-ID: q_Ll9y1FMCOdnAMxmvD9RQ_1761659860
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e3a044ec7so7974388d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659860; x=1762264660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hqcLTFSFJa32UdZBca8XVOOo6ca/YUGze1PkGPNkVo=;
        b=WMhRN+7a7u+GJYpXH2jln5X/qa7Fw8LNULnCDPk2VCYW5k1Y+Oy9ud725qMPxhz95W
         fjhfsncnB8US4JavXfccwTOw6uMDdHQ6RX4PFWSz2HVp0bd7xMhdZro1cHbiitZZ9wWp
         qZiFBdcddlk0Xh2+qUAcAsI0DTd6fSThsbEBYc0GogK+qHYtdBTutzkZlS8nLQn8Cury
         rPO94lt3M4vBnvDSlgDLaBvrhMyZW3j72FmgzU+EAZhJHN1pCPOei9LV966dOIY605br
         UW1sig1+3yskZ3BkDman+3D01gmvq0JwOpyKSQ9n4x9SY6qKePmQHoCgKNSheiMwRRmZ
         mNIg==
X-Forwarded-Encrypted: i=1; AJvYcCWTOh2whj00EQQ+c+LJMEqrI2zF1XaNQsO1CE7zC4lsJjZo+zGaf5K0fM4fbRWgHlHVX5ol4lTISxM0mFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SY0n4z8zfRfGCVrKxgh4HwVcBn6r8ZPaYE7t4TVaM0k2s5cN
	z/61d9WcgVxH5UcMjJT8ReF+t62OoVijzMTJHV+8HT2W/4S8idFrcGUIaMN4k056UOWNa5EmvF6
	ARWXRXAHF9OyL55TCjtzZwcmnJQiAmttfhKWN7jbCdmx9VQY77gYvwYEXVLYOO8NXLFDFj12/lC
	apw66GtaGQoJ/6McbhZ2Z6ajkTT45iaJgyAot/Jn7z
X-Gm-Gg: ASbGncveOBKVvYXVZ/uQ3lbYW0oz/xhFC0jy2d40tF9JRmWTktUVG+UVNtiCKc7nlHY
	4AL/6LKKPW0o6eor2hsrW3uyhifaSyGw1riEpjwZ7CebEwS7/c8WU3odYqx/dp5F4Opkxyd6jdg
	AvtDXe0mp+SqVIVxOdu5HVsUjwM8gtiWTU+PZKvTgtuJsoY8lplMK3UPlAU/XS5zte416PbQ==
X-Received: by 2002:a05:690e:1517:b0:63c:e930:e37 with SMTP id 956f58d0204a3-63f6b85dae6mr3191160d50.0.1761659860170;
        Tue, 28 Oct 2025 06:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7wQtO7p9XKAJbsCFFUBPJozNFYSEBLszufJXdBbxLP1xoSCnNfIuAIoiYmgpey11vqdoL8hFkGT/3VWWSKMQ=
X-Received: by 2002:a05:690e:1517:b0:63c:e930:e37 with SMTP id
 956f58d0204a3-63f6b85dae6mr3191107d50.0.1761659859403; Tue, 28 Oct 2025
 06:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local> <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
In-Reply-To: <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 28 Oct 2025 07:57:13 -0600
X-Gm-Features: AWmQ_bmAeiF43OuC22PnYol5XtlIdWxaxVwsbCB3sXR0PVz85j57-tCDcLiOmdI
Message-ID: <CAA1CXcCvOM+ddk1-d=8d7aFG0ZZ+shKhNCa6ppewSxS8BHW0OA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, david@redhat.com, ziy@nvidia.com, 
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

On Tue, Oct 28, 2025 at 4:10=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/10/28 01:53, Lorenzo Stoakes wrote:
> > On Wed, Oct 22, 2025 at 12:37:08PM -0600, Nico Pache wrote:
> >> The current mechanism for determining mTHP collapse scales the
> >> khugepaged_max_ptes_none value based on the target order. This
> >> introduces an undesirable feedback loop, or "creep", when max_ptes_non=
e
> >> is set to a value greater than HPAGE_PMD_NR / 2.
> >>
> >> With this configuration, a successful collapse to order N will populat=
e
> >> enough pages to satisfy the collapse condition on order N+1 on the nex=
t
> >> scan. This leads to unnecessary work and memory churn.
> >>
> >> To fix this issue introduce a helper function that caps the max_ptes_n=
one
> >> to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scale=
s
> >> the max_ptes_none number by the (PMD_ORDER - target collapse order).
> >>
> >> The limits can be ignored by passing full_scan=3Dtrue, this is useful =
for
> >> madvise_collapse (which ignores limits), or in the case of
> >> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> >> collapse is available.
> >>
> >> Signed-off-by: Nico Pache <npache@redhat.com>
> >> ---
> >>   mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 34 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 4ccebf5dda97..286c3a7afdee 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -459,6 +459,39 @@ void __khugepaged_enter(struct mm_struct *mm)
> >>              wake_up_interruptible(&khugepaged_wait);
> >>   }
> >>
> >> +/**
> >> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for =
collapse
> >> + * @order: The folio order being collapsed to
> >> + * @full_scan: Whether this is a full scan (ignore limits)
> >> + *
> >> + * For madvise-triggered collapses (full_scan=3Dtrue), all limits are=
 bypassed
> >> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
> >> + *
> >> + * For PMD-sized collapses (order =3D=3D HPAGE_PMD_ORDER), use the co=
nfigured
> >> + * khugepaged_max_ptes_none value.
> >> + *
> >> + * For mTHP collapses, scale down the max_ptes_none proportionally to=
 the folio
> >> + * order, but caps it at HPAGE_PMD_NR/2-1 to prevent a collapse feedb=
ack loop.
> >> + *
> >> + * Return: Maximum number of empty PTEs allowed for the collapse oper=
ation
> >> + */
> >> +static unsigned int collapse_max_ptes_none(unsigned int order, bool f=
ull_scan)
> >> +{
> >> +    unsigned int max_ptes_none;
> >> +
> >> +    /* ignore max_ptes_none limits */
> >> +    if (full_scan)
> >> +            return HPAGE_PMD_NR - 1;
> >> +
> >> +    if (order =3D=3D HPAGE_PMD_ORDER)
> >> +            return khugepaged_max_ptes_none;
> >> +
> >> +    max_ptes_none =3D min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - =
1);
> >
> > I mean not to beat a dead horse re: v11 commentary, but I thought we we=
re going
> > to implement David's idea re: the new 'eagerness' tunable, and again we=
're now just
> > implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
> >
> > I'm still really quite uncomfortable with us silently capping this valu=
e.
> >
> > If we're putting forward theoretical ideas that are to be later built u=
pon, this
> > series should be an RFC.
> >
> > But if we really intend to silently ignore user input the problem is th=
at then
> > becomes established uAPI.
> >
> > I think it's _sensible_ to avoid this mTHP escalation problem, but the =
issue is
> > visibility I think.
> >
> > I think people are going to find it odd that you set it to something, b=
ut then
> > get something else.
> >
> > As an alternative we could have a new sysfs field:
> >
> > /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
> >
> > That shows the cap clearly.
> >
> > In fact, it could be read-only... and just expose it to the user. That =
reduces
> > complexity.
> >
> > We can then bring in eagerness later and have the same situation of
> > max_ptes_none being a parameter that exists (plus this additional read-=
only
> > parameter).
>

Hey Baolin,

> We all know that ultimately using David's suggestion to add the
> 'eagerness' tunable parameter is the best approach, but for now, we need
> an initial version to support mTHP collapse (as we've already discussed
> extensively here:)).
>
> I don't like the idea of adding another and potentially confusing
> 'max_mthp_ptes_none' interface, which might make it more difficult to
> accommodate the 'eagerness' parameter in the future.
>
> If Nico's current proposal still doesn't satisfy everyone, I personally
> lean towards David's earlier simplified approach:
>         max_ptes_none =3D=3D 511 -> collapse mTHP always
>         max_ptes_none !=3D 511 -> collapse mTHP only if all PTEs are non-=
none/zero
>
> Let's first have an initial approach in place, which will also simplify
> the following addition of the 'eagerness' tunable parameter.
>
> Nico, Lorenzo, and David, what do you think?

I still believe capping it at PMD_NR/2 provides the right mix between
preventing the undesired behavior, and keeping some degree of
tunability, as the admin guides suggests max_ptes_none should be used.
I would be willing to compromise and take this other approach until
the "eagerness" is in place. However, I do believe David's idea for
eagerness is to also cap the max_ptes_none at PMD_NR/2 for the second
to highest eagerness level (ie, 511, 255, ...). So in practice, we
won't see any behavioral changes when that series comes around;
whereas setting max_ptes_none=3D0 for mTHP initially, then adding
eagerness will result in a change in behavior from the initial
implementation.

With that said, Lorenzo, David, What's the final verdict?

-- Nico

>
> Code should be:
> static unsigned int collapse_max_ptes_none(unsigned int order, bool
> full_scan)
> {
>          unsigned int max_ptes_none;
>
>          /* ignore max_ptes_none limits */
>          if (full_scan)
>                  return HPAGE_PMD_NR - 1;
>
>          if (order =3D=3D HPAGE_PMD_ORDER)
>                  return khugepaged_max_ptes_none;
>
>          /*
>           * For mTHP collapse, we can simplify the logic:
>           * max_ptes_none =3D=3D 511 -> collapse mTHP always
>           * max_ptes_none !=3D 511 -> collapse mTHP only if we all PTEs
> are non-none/zero
>           */
>          if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
>                  return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER -
> order);
>
>          return 0;
> }
Side note: Thank you Baolin for your review/testing of the V12 :)
>


