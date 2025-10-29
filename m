Return-Path: <linux-kernel+bounces-877193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB2C1D667
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCC8188D027
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448F319858;
	Wed, 29 Oct 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1DbXeuC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E93195FC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772485; cv=none; b=c7B0mdMZbhKPKa/ZdQtlWpOVBenS/KL9BUjUSXpOGMD+t4LOWycwi/O4ju8hGBHFLhAUL6SZjgwh6fAnuO5Mc/Cd5vSz3a3l5lNTvGyEu/aE+AZ99AbUZiMPpheMr8+Kqw39Q0Smrx9fZ9t6ZZd5WhVjq/8rWN1BnKU0Ao/29b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772485; c=relaxed/simple;
	bh=uA4o4s1QUU1aUgd+6IuizO22+dL/AjztreXwnzDIJOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLLnihi1oPnqolLPz5O+UqYco/+ioxh1PDAUaar5S1E2y+X6Ymra3a7g68ut1TfG3IrNssgjmre7qDGi+1ao6ZoV7Ac3mimLAb8YRZq90nIhfoZQmmttaegkYOOhTV5zMh3H8RlzO3gFz5GEM7Eppmhpq3w1FlMLmsJ6g6m7qVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1DbXeuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761772482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPTTtw8BTZD1fn+qIBXIK1gjHXor2Nf0ItE5USDfdEk=;
	b=E1DbXeuC6tFAca0iR9b4vjcYrkMSifmOxcPwg1evTydD2Acwre//YK3hLNyBCrlnM3y+g6
	GetOqy+PHo7vHq7Or6PtgeDoMs1y1HPwws/aBzFddmNGf7fx8C7T7bBXxUtU3x5SQJJ0Ys
	bCFREHAolTigBwuPHW5XgXme+iptwFA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-VOiDk6jQMxyTquANgzv2xg-1; Wed, 29 Oct 2025 17:14:40 -0400
X-MC-Unique: VOiDk6jQMxyTquANgzv2xg-1
X-Mimecast-MFC-AGG-ID: VOiDk6jQMxyTquANgzv2xg_1761772479
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-36d99707249so1040571fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772479; x=1762377279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPTTtw8BTZD1fn+qIBXIK1gjHXor2Nf0ItE5USDfdEk=;
        b=mqishxQP5c9JQWS+gTlh/jy2Z1OPg2blsPK5oiEkqlcUJspT+dJXfeqWGXDzJyDiHO
         Sp3QNt44fgF+Y3djsY07L1Iv+n8GwD5ISNUbJ1tnkzq53PEcYY2WgTDttPhayWr5tZE0
         XfWQYJomOy7cAFLY7x4lMg3ITvKcZGIy/WJrRZXTzF6CPMnSGqDHR+ShYbK32iqEIgSB
         sof1lOg+mmH+QBXFF7+arieIPDQD4pIswzyeiRmPu3ol8ckfz60d8efRS8+rNXmxdE7H
         C1ImibQyG2s2ixoXtIDsqLK3MANudlKLmrT09ES8brqdlPD2D83eLeZUu8b2L8jEiq4z
         zrhw==
X-Forwarded-Encrypted: i=1; AJvYcCXRnw72khZ/Sb8vW8hnDNS87DP0Q6lwpbJiP4orSk9GnjOs7Z+bHlbWiFMDlZQAfa0YZEUxOxhFRR7DvdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTzKbgve5n/vZYv+KSOGz/6QkyyAodXb2k+vmwRJZGwmJyHRY
	e18IIWbQ+Yufl7Taec2LS4cRU9PRbywdLXZ4T0pewK0vKy0cy0eb0KhscGNaDXAfTsOM/3r/HGC
	RM7QjClVK77nmiOfscDhKpeorXt2sBEGEemKs+y8YmXgegCXw/Tg2N5aUUWs3HRvWayGKKKExvk
	nqRgKZh0dMJEpBB7qaNiNaeUk/bxNqi4sa/D85SObA
X-Gm-Gg: ASbGncvdcZ8wMdwrWV8aArRtvhdtp/D4Xu3tdq7JsPf2es6tXuMm9MBtvILSh3dui6/
	gH+d3IAYFTkukiEG42BcN7wRVCUERGBJHpI2mJA9e55CUXLhofug/p/D0UxDE9mZeOcr5TNZUTD
	56sEnQgPRDsToP8VWmEx8y8D7oZrII6jUClmAKERfbLSDPMAbZU87zSCYH5BS4yGVGx4eBoQ==
X-Received: by 2002:a05:651c:543:b0:378:dde4:7987 with SMTP id 38308e7fff4ca-37a05332c83mr15015261fa.28.1761772478981;
        Wed, 29 Oct 2025 14:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT1rpy4gMrS8nShcIS4YGFz4w4G6pxRpfpNR82D/AUm8kkZFUHf+ArcjvP3FnX+a05XWhgXcWN2srFJMdzGAg=
X-Received: by 2002:a05:651c:543:b0:378:dde4:7987 with SMTP id
 38308e7fff4ca-37a05332c83mr15015071fa.28.1761772478459; Wed, 29 Oct 2025
 14:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local> <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com> <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com> <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
 <b1f8c5e3-0849-4c04-9ee3-5a0183d3af9b@linux.alibaba.com> <2ab547d2-584b-48fe-9f43-7c14caa7ab05@lucifer.local>
In-Reply-To: <2ab547d2-584b-48fe-9f43-7c14caa7ab05@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Oct 2025 15:14:11 -0600
X-Gm-Features: AWmQ_bkBHBsKVE1DM6K6PiXjxwYzk9VLBdKL8XAwMrrsQLZy0gtm_M8PLuoLaxI
Message-ID: <CAA1CXcA1nqt_f+zSOF66eTNWJACCE84hSQn4uNF8CjcBUZ_1oA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
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

On Wed, Oct 29, 2025 at 12:56=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 29, 2025 at 10:09:43AM +0800, Baolin Wang wrote:
> > I finally finished reading through the discussions across multiple
> > threads:), and it looks like we've reached a preliminary consensus (mak=
e
> > 0/511 work). Great and thanks!
>
> Yes we're getting there :) it's a sincere effort to try to find a way to =
move
> forwards.
>
> >
> > IIUC, the strategy is, configuring it to 511 means always enabling mTHP
> > collapse, configuring it to 0 means collapsing mTHP only if all PTEs ar=
e
> > non-none/zero, and for other values, we issue a warning and prohibit mT=
HP
> > collapse (avoid Lorenzo's concern about silently changing max_ptes_none=
).
> > Then the implementation for collapse_max_ptes_none() should be as follo=
ws:
> >
> > static int collapse_max_ptes_none(unsigned int order, bool full_scan)
> > {
> >         /* ignore max_ptes_none limits */
> >         if (full_scan)
> >                 return HPAGE_PMD_NR - 1;
> >
> >         if (order =3D=3D HPAGE_PMD_ORDER)
> >                 return khugepaged_max_ptes_none;
> >
> >         /*
> >          * To prevent creeping towards larger order collapses for mTHP
> > collapse,
> >          * we restrict khugepaged_max_ptes_none to only 511 or 0,
> > simplifying the
> >          * logic. This means:
> >          * max_ptes_none =3D=3D 511 -> collapse mTHP always
> >          * max_ptes_none =3D=3D 0 -> collapse mTHP only if we all PTEs =
are
> > non-none/zero
> >          */
> >         if (!khugepaged_max_ptes_none || khugepaged_max_ptes_none =3D=
=3D
> > HPAGE_PMD_NR - 1)
> >                 return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER -
> > order);
> >
> >         pr_warn_once("mTHP collapse only supports khugepaged_max_ptes_n=
one
> > configured as 0 or %d\n", HPAGE_PMD_NR - 1);
> >         return -EINVAL;
> > }
> >
> > So what do you think?
>
> Yeah I think something like this.
>
> Though I'd implement it more explicitly like:
>
>         /* Zero/non-present collapse disabled. */
>         if (!khugepaged_max_ptes_none)
>            return 0;
>
>         /* Collapse the maximum number of zero/non-present PTEs. */
>         if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
>                 return (1 << order) - 1;
>
> Then we can do away with this confusing (HPAGE_PMD_ORDER - order) stuff.

This looks cleaner/more explicit given the limits we are enforcing!

I'll go for something like that.

>
> A quick check in google sheets suggests my maths is ok here but do correc=
t me if
> I'm wrong :)

LGTM!

Thanks for all the reviews! I'm glad we were able to find a solution :)

-- Nico

>
> Cheers, Lorenzo
>


