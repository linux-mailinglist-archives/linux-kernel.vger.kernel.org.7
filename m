Return-Path: <linux-kernel+bounces-877199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01352C1D6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE994E0524
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F931984C;
	Wed, 29 Oct 2025 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw6GEiTV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A13195E7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773038; cv=none; b=c6d+YJIeM1J91wacy8mq3dAyIWq334kM0CWMIHxxRO59mhAFrjKhcSnKyOtp/ezvaNZsqF9jejSwgnXnDRLA7wyn2CdfhxhC1Z0TxfM5Vmqt3tlQ2GZOh4YxbfQyk567g60hEC/ZoobcXOBzw7utyT9e4v6vg/AVDC2DkydcrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773038; c=relaxed/simple;
	bh=YxJkHaOGqtmtID7r7jgJwxwqavOG8btDMZK73zs/svk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR1ru1nIbm8+B/X1Q6JOHTav7MHHUy70p0kkPsRvhprdaKYgOekqMkQsGfNnC4sPsLC1evN7jQIleaowtzZHy1vVG+Nt0+cVBLuWa47bOOGcWE8y/F5Uj+gdCzEjHbje5ZM79p2TUxerMi5k0Ptz3FJDtHcKM5v1EBRl+YutYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw6GEiTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761773035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxJkHaOGqtmtID7r7jgJwxwqavOG8btDMZK73zs/svk=;
	b=Rw6GEiTVBkuB2nHXgtik9wM5cnaKJAciRp876yxsZb98ITDsVDKh2u8+6A86v32Wv4gyTm
	4iGqqlFA1FiZuGwwd3DUGm7qzvel4xWMpOctyVQDIBAVkbHvg78okToEE/IA3Kk16Eu8Tx
	l22sUBw++PLeKR6XASjHdPEcS8W0kCk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-th7f2HSVPlqRjvXIG59TKA-1; Wed, 29 Oct 2025 17:23:54 -0400
X-MC-Unique: th7f2HSVPlqRjvXIG59TKA-1
X-Mimecast-MFC-AGG-ID: th7f2HSVPlqRjvXIG59TKA_1761773034
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-785c4b8a18bso5200627b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773034; x=1762377834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxJkHaOGqtmtID7r7jgJwxwqavOG8btDMZK73zs/svk=;
        b=l68OIrsTvDw3Rjcs46eDIeku738Xnl9YlSYzzSW9Z7xtTl5tYtTrnT8WZQq6lT4TSc
         svdZnfcChsHGZiRxkMh843NqptP7+t6wPXMUq3T9noC9R6SM6nExv0FyxnXc3q2JTRga
         CEikMHkZ12nM1+J7aa4VoMuuVIBoVlRhB1Zs9eV3BF87rJ/JvOvkcPTnW5NXrdQ2mXba
         pGfiOfEdurFURArqIPOd0cfM3VMFDVNLqpXAxYw5w0s+idTt1tiyomjJ7C5VwB0AWotu
         SoWkugxY9DnqfTowkvC/e/Uny4TbbbJUtj3ShcJTe7zDFoGC/PQF/xiPogWXvwATd/Ty
         QbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiv/RrAVueWZtjVtqJfk7osyByCjCIBKMCiGWTI/0zPeHUUq1xFEH3GnbD2WRMu18G6cIf48qzqPZChWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fNjwqT6Jea7uQdpq/YQ+BrFARzXi0pPeHUMKqv54KiqGNNrn
	0k5S7xYq3DOl4z8wC7hR1FqYd0UYdgBUC6uZWeg3+YMssE5igt+FF4XDE3tD1xhq6zepK5Wz9cO
	GjFjqiuaT/6yvpa8kFGYZXMLALsIUM/GAEL+3WCgJaFmZNIXMcI+j2ReImHBrccW4V3nFg9xPQ/
	B4SUNInvVIjJuhyTmnFePMHnPkgc1uR8TSgfWa7Kxr
X-Gm-Gg: ASbGncslXYsI7gsD2hqFtzpaXZ6P6V7Ow0l+h0TysWfy48CVgxJDvn9J3TyOLVQA2ev
	xIyGVegJT4kaWtijG48wYBsHl5C5y1z/pQKbWd5soRtWY1EdMkKqOvrAwn8kVbMgU67heKMnczd
	b405rRsqXZNaDdhcstCBF/sc6aydXdhbFecV2qGx0Cg18jFsUmO3CuM/nsnJsJxuz4e8jqxg==
X-Received: by 2002:a05:690c:6701:b0:783:6943:f530 with SMTP id 00721157ae682-78629002465mr47289457b3.63.1761773033725;
        Wed, 29 Oct 2025 14:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8yc33v52nQ6YPYjNybWuYm4cbGSVVsczrtKKNT1ij0PL3hQrawg7LmLb9r6Fd2P+MKYkK8oJ/nx9Rz6pq4gs=
X-Received: by 2002:a05:690c:6701:b0:783:6943:f530 with SMTP id
 00721157ae682-78629002465mr47289077b3.63.1761773033204; Wed, 29 Oct 2025
 14:23:53 -0700 (PDT)
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
 <CAA1CXcD1YDAbYzdYfchOWbmUasa3tN55AYroOLJb2EqoQfibvw@mail.gmail.com> <02a72419-bc89-481a-ad2a-a3c91713244d@lucifer.local>
In-Reply-To: <02a72419-bc89-481a-ad2a-a3c91713244d@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Oct 2025 15:23:27 -0600
X-Gm-Features: AWmQ_bnwjuOd-l21r_gYz6uTD3EwVnE8ezkHiJEP0hwQdGdZ9Dom1N0UNfRsm3E
Message-ID: <CAA1CXcDR7pe1jKvPOBv-WVYObYtZNNx0w9vESaUsLe+BPR=Dzg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
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

On Wed, Oct 29, 2025 at 12:59=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Oct 28, 2025 at 08:47:12PM -0600, Nico Pache wrote:
> > On Tue, Oct 28, 2025 at 1:00=E2=80=AFPM Lorenzo Stoakes
> > > Right, well I agree if we can make this 0/511 thing work, let's do th=
at.
> >
> > Ok, great, some consensus! I will go ahead with that solution.
>
> :) awesome.
>
> >
> > Just to make sure we are all on the same page,
>
> I am still stabilising my understanding of the creep issue, see the threa=
d
> where David kindly + patiently goes in detail, I think I am at a
> (pre-examining algorithm itself) broad understanding of this.

I added some details of the creep issue in my other replies, hopefully
that also helps!

>
> >
> > the max_ptes_none value will be treated as 0 for anything other than
> > PMD collapse, or in the case of 511. Or will the max_ptes_none only
> > work for mTHP collapse when it is 0.
>
> 511 implies always collapse zero/none, 0 implies never, as I understand i=
t.

0 implies only collapse if a given mTHP size is fully occupied by
present PTES. Since we start at PMD and work our way down we will
always end up with a PMD range of fully occupied mTHPs, potentially of
all different sizes.

>
> >
> > static unsigned int collapse_max_ptes_none(unsigned int order, bool ful=
l_scan)
> > {
> > unsigned int max_ptes_none;
> >
> > /* ignore max_ptes_none limits */
> > if (full_scan)
> > return HPAGE_PMD_NR - 1;
> >
> > if (order =3D=3D HPAGE_PMD_ORDER)
> > return khugepaged_max_ptes_none;
> >
> > if (khugepaged_max_ptes_none !=3D HPAGE_PMD_NR - 1)
> > return 0;
> >
> > return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > }
> >
> > Here's the implementation for the first approach, looks like Baolin
> > was able to catch up and beat me to the other solution while I was
> > mulling over the thread lol
>
> Broadly looks similar to Baolin's, I made some suggestions over there
> though!

Thanks! They are both based on my current collapse_max_ptes_none! Just
a slight difference in behavior surrounding the two suggested
solutions by David.

I will still have to implement the logic for not attempting mTHP
collapses if it is any intermediate value (i.e. the function returns
-EINVAL).

-- Nico

>
> >
> > Cheers,
> > -- Nico
>
> Thanks, Lorenzo
>


