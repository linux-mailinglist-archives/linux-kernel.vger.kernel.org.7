Return-Path: <linux-kernel+bounces-838153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2ABAE8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F707320F73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5AF285CAF;
	Tue, 30 Sep 2025 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d96RJ5Us"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF81D130E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265117; cv=none; b=VLT+Y4xW0/pd8yWBx01d3aPWM1H1bU4Ez/XTGihWVvr8YQU77TqZPFDG76IUtQ7njoZS+Q+uOZ5yrKf92QmHJoHQa0FKSuUuoX44TmVApSnx3j0ljtjyYULQroYuOIAj3lO4kyBvHrO5x7NA0PmwxrJD+p6LK/4DqGq3+Je6+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265117; c=relaxed/simple;
	bh=MGjukSDb7w/b4fceM3SbdLkUr6dwT6r15Rgd5Lx65Qo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8oPk12SaR1pLCu9y+2jw5xIrrXs5cjLXkrbk+GlxJcuQvS2200LDBgbCizT9BAUx1+6b4yuthr9nxmTg1YxYRl+SjNtKAjuOC8BHIEJVfpxISQ0DzfOjTS7i1wT4DhQnOa5zWZgX8fH5VofDTVAKXqQ6YgtBEKaa7TH/a6XCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d96RJ5Us; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759265115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KhdHzEXScZ1ZuHAPb/984gxCrhf58t9oc3EYjkX9MI=;
	b=d96RJ5UsR11uW5DevxrJsHRkXk9Yj8e0zq92ctjJZEEJ93npVNqQp/ZvgJeCpa2yk5IcWT
	tdJnd38oPM2Tk/BaHzyT2ZQd+RtL22f5pExvh/kcvzKtLijzRy9FOz13PL64JfaHTu8PdO
	1VOlQEkz5EPh9+blU14ATM+PG74e95E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-eG1RCEfHN3-h-KPu2zwA9Q-1; Tue, 30 Sep 2025 16:45:13 -0400
X-MC-Unique: eG1RCEfHN3-h-KPu2zwA9Q-1
X-Mimecast-MFC-AGG-ID: eG1RCEfHN3-h-KPu2zwA9Q_1759265113
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-871614ad3efso190972685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759265113; x=1759869913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KhdHzEXScZ1ZuHAPb/984gxCrhf58t9oc3EYjkX9MI=;
        b=deTm01+xVvdjdhIfj1pycNuQGV4IlGQ03bslFU1si7bdPkFc7i3piX8/B51MyEU9S1
         Bh88u+3/bcI7WxLg/IeuqnK3Xc16D88VZDY/Ily+eGYrDKaXiHpRPdt1eGgoVnoInpTJ
         788gnNwemsOT1ho5G8qsdUm8AqgwnSTizL78AcH8FrkJpPHMKdGFylL8w+96rZzKJobe
         ZXzChm6bq+z4fZsTGJPTe3NU9avA/nOqvDuqyHDAOQ4acDCbNFoPOcjE7naI7cT2ZX8A
         XFRyXCQ5nlbcfQvNeAzaNh+m9LP9w/2s+zJ25wseH0zmjmvQYgLoDiS6WQV6Xve3G2n7
         eLqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlQKGwlUp2NAwP85iJrYZjmAukIeg2WD/iEsaTpg1Xq2ySQ9Z+lp+dSvwnSMX1QPQLXsIwIrI1MnMGzmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzete8c/ro0KayHzamF1rD78lK5qBzF8Rk6/8WfrWEtp+thhxnb
	3+w58yFIC9fvl1wM7f7qpft3EIm7Z5TOYNXtLjiTSAQy0+8gd/Y1hSyGc9EmRnkGJHQOTVfpNTe
	qil/CZqceUhwFUikWdX53wUBHQXFiR32DdMVt7CDiUzwVSV8geT+ZdFCS2h3xQoSFkg==
X-Gm-Gg: ASbGncudaMxXTB0S9qSyi/2cK7jY1M9GVr1iuHYB7eKKXf5ip9z2YBEqCdBfzcuOSlX
	/NcxdCwLa7r5oKw0L1D3mLZRlZi82zhrFbrC0K/Vsmf3WiqyEgXAziqk+ilXemUF72plPke+K4+
	Z6U9pL3NK1im66HweA3XvEWsgmIFqkhVDmxGZWWtTnsCm/EFHZBnAwBrvmDQvzLoordqm++gT+f
	Ye39Ldm+e9f1EFX+tor/tq8yRrEjRf0ZhjGGD8IY4gVkG2Bkqov38YOHWo7kMnxd+9tWd19muWM
	YpH/6HMOwezSBxpVdA6BpMTS5T45qJyZrUGL+Q==
X-Received: by 2002:a05:620a:4723:b0:82e:6ec8:9887 with SMTP id af79cd13be357-87371172610mr182019385a.24.1759265112723;
        Tue, 30 Sep 2025 13:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOUW1s4NzIrA6CcfA5cgYQ1iR+uPx4PZsCRjPXoXfqPRBxU2cfAJOj4iIKUlkfgDU9xy9dNw==
X-Received: by 2002:a05:620a:4723:b0:82e:6ec8:9887 with SMTP id af79cd13be357-87371172610mr182013085a.24.1759265112108;
        Tue, 30 Sep 2025 13:45:12 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2737848csm1124926985a.3.2025.09.30.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:45:11 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:45:10 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aNxBVj6Ya0FhvkS2@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <urtzlj3wwjmmgdon3goi2qopxlxrajewdxhhchzw72exz4of7l@vlmbjw3i3xth>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <urtzlj3wwjmmgdon3goi2qopxlxrajewdxhhchzw72exz4of7l@vlmbjw3i3xth>

On Tue, Sep 30, 2025 at 03:49:34PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [250926 17:17]:
> > [based on latest akpm/mm-new of Sep 26th, commit e612c80ae0aeb]
> > 
> > v3 changelog:
> > - Fixed checkpatch issues on spaces or typedef
> > - Dropped uffd_copy() API
> > - Refined commit messages here and there to reflect the removal of uffd_copy()
> > 
> > v1: https://lore.kernel.org/r/20250620190342.1780170-1-peterx@redhat.com
> > v2: https://lore.kernel.org/r/20250627154655.2085903-1-peterx@redhat.com
> > 
> > This series is an alternative proposal of what Nikita proposed here on the
> > initial three patches:
> > 
> >   https://lore.kernel.org/r/20250404154352.23078-1-kalyazin@amazon.com
> > 
> > This is not yet relevant to any guest-memfd support, but paving way for it.
> 
> It would be much easier to review this with the guest-memfd support in
> this patch set.  Any chance of including the target user?

It should be something like what Nikita posted previously here against v1:

https://lore.kernel.org/all/114133f5-0282-463d-9d65-3143aa658806@amazon.com/

I'll add the link into the cover letter when I repost. That formal patch
logically will need to be reviewed from KVM side after this patch lands.

Thanks,

-- 
Peter Xu


