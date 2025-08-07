Return-Path: <linux-kernel+bounces-759355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A95B1DC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE07228DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073827381F;
	Thu,  7 Aug 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJBLOTXt"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03426FA5A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588300; cv=none; b=SaJ039bhRMxz9pFL/DiCWAnx9C1QgwQhj/67eOYEckSaBT/tFUFAcSxRzby5IjnHaZKJmAr9mWxI4w3rvVF1kwWk6DC4eTOVRQJEVXgFcjHGIaVhO+MPwG2VPKLGmcdOiK9z+JgRzzVmIgBWoTUkllFTXqkCFNJ2kXHkcakQxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588300; c=relaxed/simple;
	bh=q/Jq0GgttUlLfhZ00HgngnqjM1aNEj36/CvvVjcMf0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tccjMhJBAloXWiAtzot+HzaSbMdFJHcZf9R8bzY3H14U894Z+QoRJIiX9J6rIbCzab+I5Ak5Un5VF/eO7HzbaNK9LconDTSsBigZLvagW0BA1eLf/l3ZDo/zeLcacNycuMI43BgIDEXsDd/IDXgoZuGOR/s21s8LdWFitpLTl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJBLOTXt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso942a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754588295; x=1755193095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7q3Q6iUm+lHnGSyrlBHDosOzs9eiv0aa0pxVcHH9CQ=;
        b=XJBLOTXtO2llI8FuTRq7sLT/qoGH6prV/RDFiqgPQhPpeeFpFsJH9Whmcj/Pr/ZMzk
         6DVGhMeT0aVI/XKJkCcROnXSH+JVneC1+MKhroUt6/UVj8ReGgkSsYZX6Jk9hHNGysyD
         f87EkFRpCHvLe7iJ9nEi8+PrXhlZsZzURpZZ/QqeqnpS9oeLjDOLHxxa2Tw31dRgzYbW
         gjt4DXRVOMQgU4qs91oCGFwmPY67H5d674d/hpwOXiVKRJqWL4DtIHqqSEADl4mj1N4K
         I4eNCi+dkodcl+gMfkdv8guSkIDWx86pEY4NKpHsZt1To5wbUeM/cVFIDG3hnpa3w+YS
         7exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754588295; x=1755193095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7q3Q6iUm+lHnGSyrlBHDosOzs9eiv0aa0pxVcHH9CQ=;
        b=p/IhhMfq2fLoylAw4Nr4Sq2KgJ3w/SVZx/i6SBmU75VEDBilsGVdnQL38Mb9tiT4Bv
         z7iBvz1tPaonpGhPQzCyul0jlGSCoxSx/EK+Bakk2mIGXQTlT0/IpspsPGAPS4QyNiPw
         g0CeT+bkAcF/LbSX0AyyzoXK1MKXcbX9iIWg58mtwk7HGF9AV+Rqem8xW7HKLKu+u/N/
         d2s8EzmK6FGwLqpMEJ62g/ILpR/mx6JHt3xrA6JKpZTrpM9yFG5qLzDsZE1hyANoRhXw
         IqdiaYa+CCRGQRKRp5SPFOIWNZM7SIyqzhChsDdSt7RNfQC1S5DxTsCFA3suud57tSb2
         GfYw==
X-Forwarded-Encrypted: i=1; AJvYcCWolrpeQUs5bLecGjrOp8NVf2HG9DTMhVWkDXM6s8y+gRFWVSq7tpL6+aJ+2HiYCisLeaIzfbjleXNk6x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JP2DJFldPtm7lhNnR09KtK1gAwM45afCqTVvciSaNlpbnDVh
	bxt4K/274VToeeszJpHiSjW6btioNtIaZXWdYrZUz84TCgdxfaGPa47/WRVKioOAlBnM9yv998L
	jcXpFfiWzaKGSpo9GZ82XsB2s2mduOVBPZKSTzJPc
X-Gm-Gg: ASbGncsSMfQeF+f9+KV/W3bNjK+ReFXm7Ebo198csF/xcW/Tr8EMXfElNxYd7LLbY83
	N6TUEhvlzfvm9Izx3/Qd2vRb0+kPwvTL0WAZClCyO5yg2lLbtyZxZjhlGMNJll4s/jsdUnOj7mc
	jZ0vS0jfwlVSep+1mTeZcMwniPtNKD9ozJkX/8oZ6kyGjlrFYLjPLyb2PY01qbGBEIF3xwFxfoC
	sRxn//P1EVi5bJ7VwkNG94+ltCqiqZk7Y4=
X-Google-Smtp-Source: AGHT+IEvIyaewpd1z50G14jfP2i5jSv0GcxRpXNr+oXtWD/QgpMt2hhkcUb0kWVZEwAn2vN3hoIdh8YmyHA5+kYPcBI=
X-Received: by 2002:a50:aa95:0:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-617e152e274mr1175a12.2.1754588294999; Thu, 07 Aug 2025 10:38:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508071609.4e743d7c-lkp@intel.com> <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
In-Reply-To: <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Aug 2025 19:37:38 +0200
X-Gm-Features: Ac12FXzlXycSMR6_C9Cle-BO1qGA01-IsNhuqseD9fQKbf1SHEDGINCkLu6Sek0
Message-ID: <CAG48ez3=8f3eShjAe9hrvivP+Dvyisw=X_Tr_phc-OX_4MzeDw@mail.gmail.com>
Subject: Re: [linus:master] [mm] f822a9a81a: stress-ng.bigheap.realloc_calls_per_sec
 37.3% regression
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: kernel test robot <oliver.sang@intel.com>, Dev Jain <dev.jain@arm.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Bang Li <libang.li@antgroup.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	bibo mao <maobibo@loongson.cn>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Lance Yang <ioworker0@gmail.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yang Shi <yang@os.amperecomputing.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 10:28=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Aug 07, 2025 at 04:17:09PM +0800, kernel test robot wrote:
> > 94dab12d86cf77ff f822a9a81a31311d67f260aea96
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >      13777 =C4=85 37%     +45.0%      19979 =C4=85 27%  numa-vmstat.nod=
e1.nr_slab_reclaimable
> >     367205            +2.3%     375703        vmstat.system.in
> >      55106 =C4=85 37%     +45.1%      79971 =C4=85 27%  numa-meminfo.no=
de1.KReclaimable
> >      55106 =C4=85 37%     +45.1%      79971 =C4=85 27%  numa-meminfo.no=
de1.SReclaimable
> >     559381           -37.3%     350757        stress-ng.bigheap.realloc=
_calls_per_sec
> >      11468            +1.2%      11603        stress-ng.time.system_tim=
e
> >     296.25            +4.5%     309.70        stress-ng.time.user_time
> >       0.81 =C4=85187%    -100.0%       0.00        perf-sched.sch_delay=
.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> >       9.36 =C4=85165%    -100.0%       0.00        perf-sched.sch_delay=
.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> >       0.81 =C4=85187%    -100.0%       0.00        perf-sched.wait_time=
.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> >       9.36 =C4=85165%    -100.0%       0.00        perf-sched.wait_time=
.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> >       5.50 =C4=85 17%    +390.9%      27.00 =C4=85 56%  perf-c2c.DRAM.l=
ocal
> >     388.50 =C4=85 10%    +114.7%     834.17 =C4=85 33%  perf-c2c.DRAM.r=
emote
> >       1214 =C4=85 13%    +107.3%       2517 =C4=85 31%  perf-c2c.HITM.l=
ocal
> >     135.00 =C4=85 19%    +130.9%     311.67 =C4=85 32%  perf-c2c.HITM.r=
emote
> >       1349 =C4=85 13%    +109.6%       2829 =C4=85 31%  perf-c2c.HITM.t=
otal
>
> Yeah this also looks pretty consistent too...

FWIW, HITM hat different meanings depending on exactly which
microarchitecture that test happened on; the message says it is from
Sapphire Rapids, which is a successor of Ice Lake, so HITM is less
meaningful than if it came from a pre-IceLake system (see
https://lore.kernel.org/all/CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7=
Xr-w@mail.gmail.com/).

To me those numbers mainly look like you're accessing a lot more
cache-cold data. (On pre-IceLake they would indicate cacheline
bouncing, but I guess here they probably don't.) And that makes sense,
since before the patch, this path was just moving PTEs around without
looking at the associated pages/folios; basically more or less like a
memcpy() on x86-64. But after the patch, for every 8 bytes that you
copy, you have to load a cacheline from the vmemmap to get the page.

