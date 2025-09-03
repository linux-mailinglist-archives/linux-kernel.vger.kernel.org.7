Return-Path: <linux-kernel+bounces-798644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B07B420A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321DC1881611
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EE301483;
	Wed,  3 Sep 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIBjqdOF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2427A476
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905086; cv=none; b=cLD76N7RZxq9LU4PPEdoD2u5CqeBK4gaXccG23+0wvSqq1j/Uz1lQMCHrezCT4g9m0AcVLC+xeyhdrf0evtXWESUdQ7c5GJfIhcpTl4hsQozxwqilCPUc/kkcpn3bZOmDAfqJqBVD9YP92CZI3ZTQFxpMQ5HC88LZ/IUS5vg4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905086; c=relaxed/simple;
	bh=I1s1gYhulsEa8esA9nmPL78YuAvk2XOkyXrc3y3/8Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+cOviKmgmRw9Wt2GowTL7N3So9KjNua6yw0fhuDPMCTBtwNNUHqO5wplDjRoLCHbWGC1goJGVOfM8MkS3oeMqx5/DEC9v1rsW3HpG4B2ubN49b4ktAV9Tq6VZ9baUPJG0oaP4Te9zeYyzSfxXIWwx7AVSkKAtA0UKoUodAf4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIBjqdOF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b043a33b060so380253266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756905082; x=1757509882; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HclYStwOCOKmcMB/Tt8c6EjEFXgSd65p/VjuWOlNOQ=;
        b=dIBjqdOFOu7qTx08W2Avb08dwIA7UgcuTUHTghDZJUydq9XN144l/CAxR9WjANzJM6
         zDxFLNxZhFJQepWtwh997CsKAjQ7FPt3EFMqwF3oNsEn9jVaeEj8MY9PkzGzUO4/o6hQ
         tlJpQSSFuqGiW56hgAxjWO+AWqPV8xhDz7jX8kaRa2G+JGPJDltO3HqWKi/fPUEiKk3E
         O9IkHucyjSIH8BWulqtfWuxnk5Jw+0QRSSulxz3t+Tv5nXSiWII6sMWW4PFcdFkYxCI4
         HjuteEo6w3IfJCRQbor8Ggs1cigxbEjDW12PJw0/Rx3Jbf/uqkLnANSBS7Ig7tNCRtzd
         ywsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905082; x=1757509882;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HclYStwOCOKmcMB/Tt8c6EjEFXgSd65p/VjuWOlNOQ=;
        b=DqG9HIv7gPcRfgZG8Un5rMs01so1ImOgtNP2XvXpwi0gzwJoJSrhVd+7t/rCUQzLPT
         LifEV4kTK2fUmIthb1s7NgzPs6AX3V8XGwFKG9pC3tnXAsvCa6mHT4knHAtZgJ9SWeJR
         BhkJbqkxNX15sTdwI4+JYqdyZeYRgqk1gmDuh2Xn6lbmH+QEvNfHSRnP00FiY9lyKZ4y
         uNo3/Flf7NMyg6mdQLy1ZIj1E+Snh5YLgfkdW65SLSYSuIl2sKUEXIE+mny+aqLk1z/3
         TnqGG/ueBy7Vqp9RtFDTjSqFyaRhMP0VPJo4OjHXdl4VFzkSgeO0k3TQnphluTQzILCX
         Zbvw==
X-Forwarded-Encrypted: i=1; AJvYcCX9xmKB9ruHjWqBld3FJyvA2o+clqvtsHv/mKx7dUTXmUBV0tC/KKr61691ENaGhAbgY0UsCLarWz/AZ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEVfnPm93ATRHxBAgYqN/5JFNeYZHYzIQQX6PYXSOZdjY+np6
	+YmXeEDZ1cocJRIdy4KyBjMZjocQVLxar6JBgH6dcheJE13PvM+V2LZs
X-Gm-Gg: ASbGncv8dF06/5i36NdAnCyTX7dPwurIaYvdl+i5peF/oqnnKbVQLGuxdXJNVE6nA2l
	jh7iaYHdOn9uhpLEXSovn53iRlJdspU6wOP79N/DO4s3LUrLZ+cHg9XGYcIcb3cSPtzPjw8SsaP
	xc+fPNRYY4oJD8oR2bp6EPv+o5oUdUF5eWpp4wx9D+n/dVGTb0cAPxchhZD9XkwTK6bbqQlO5cx
	OnjjbO0PWcBy807l8qc/z1Zz+1Twm7kmEtxjvj+9hcome5th9HXlOYAbXzIvxGqAV+kztoCNc+7
	8jvNw3OV9NX+uMnedEvFGS88lLVkSUXGBE+aHpomy/yn7VYUJjvPsKSwohvj9d5Hl+noF0b/+ZD
	sNcKfQYKCkoDPIEa0QYOE7Mm7TcUA/BLyLP1Z
X-Google-Smtp-Source: AGHT+IEvolQ0TZapG8a9VwnXAMFKX6vFBRt9OPxFXx9ScLuFAy8TDm0fNdRCVyXZA4v1mqzngETARA==
X-Received: by 2002:a17:907:a48:b0:afe:c795:9ad5 with SMTP id a640c23a62f3a-b01d8a32186mr1345554866b.2.1756905082215;
        Wed, 03 Sep 2025 06:11:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04709b3effsm79021666b.5.2025.09.03.06.11.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Sep 2025 06:11:21 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:11:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, kas@kernel.org, willy@infradead.org,
	hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
Message-ID: <20250903131121.eq32tcuswgiossgi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903080839.wuivg2u7smyuxo5e@master>
 <0a52cb54-5633-4374-baa5-199194dfc2e1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a52cb54-5633-4374-baa5-199194dfc2e1@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Sep 03, 2025 at 02:45:28PM +0530, Dev Jain wrote:
>
>On 03/09/25 1:38 pm, Wei Yang wrote:
>> On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>> > Currently khugepaged does not collapse a region which does not have a
>> > single writable page. This is wasteful since non-writable VMAs mapped by
>> > the application won't benefit from THP collapse. Therefore, remove this
>> > restriction and allow khugepaged to collapse a VMA with arbitrary
>> > protections.
>> > 
>> > Along with this, currently MADV_COLLAPSE does not perform a collapse on a
>> > non-writable VMA, and this restriction is nowhere to be found on the
>> > manpage - the restriction itself sounds wrong to me since the user knows
>> > the protection of the memory it has mapped, so collapsing read-only
>> > memory via madvise() should be a choice of the user which shouldn't
>> > be overriden by the kernel.
>> > 
>> > On an arm64 machine, an average of 5% improvement is seen on some mmtests
>> > benchmarks, particularly hackbench, with a maximum improvement of 12%.
>> > 
>> > Signed-off-by: Dev Jain <dev.jain@arm.com>
>> > ---
>> [...]
>> > mm/khugepaged.c | 9 ++-------
>> > 1 file changed, 2 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> > index 4ec324a4c1fe..a0f1df2a7ae6 100644
>> > --- a/mm/khugepaged.c
>> > +++ b/mm/khugepaged.c
>> > @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>> > 			writable = true;
>> > 	}
>> > 
>> > -	if (unlikely(!writable)) {
>> > -		result = SCAN_PAGE_RO;
>> > -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
>> Would this cause more memory usage in system?
>> 
>> For example, one application would fork itself many times. It executable area
>> is read only, so all of them share one copy in memory.
>> 
>> Now we may collapse the range and create one copy for each process.
>> 
>> Ok, we have max_ptes_shared, while if some ptes are none, could it still do
>> collapse?
>> 
>> Maybe this is not realistic, just curious.
>
>Misunderstood your concern - you mean to say that a parent forks and the children
>VMAs are read-only pointing to the pages which were mapped by parent. Hmm.
>

This is one of the case in my mind, while what I described above is file
backed VMA.

Since pages are mapped both in parent and child, we would count shared ptes
during scan. So max_ptes_shared would decide whether to collapse or not.

To play with max_ptes_shared, this is a magic to me... Probably, there is no
optimal value for all scenario. And if it do gain much performance after
collapse, maybe it is the application author's responsibility to use hugetlb?

-- 
Wei Yang
Help you, Help me

