Return-Path: <linux-kernel+bounces-762813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D634B20B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A396C18C56D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C01CEEBE;
	Mon, 11 Aug 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBLXbwKf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB335971
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920829; cv=none; b=ekD1wnQWB9vdfYgcxyFs5MJ6YCoezkL+afwCyoBtHEG/wIIA8i/IgTEhJLHSEV5x+8+clXNRwi+UvrRoEN7pBZA9a3GdWburDzhgdxkIYvELQzu3WsETGzZXHwVI2yMM8EBC6T03ZMr4ceTFsd4z0wqUG8PDoUK4DFXkzGh8kGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920829; c=relaxed/simple;
	bh=8eRfwJVOXcU255XN6wwyRC5I2yoHv/qNeThXwc0+ZI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBeSRt42RND6Y7JYnHA8y0BMcK6MF9zxpAjQWKiMKkMEOA+NZsybAAdlmBbFcJrKVx2AmGB8hVllAFALd3JpyKN2NhBABXePlVgxIPndM1HtN/CoLmo76si4zMTBS4j2YlK1088PsjNkiWuLoq8JD99aN2ZvmXD55JZGlLhrVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBLXbwKf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754920827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lG6B8pei2eYuQuxEro82WAinqULNxMleyX0BHmMNsk=;
	b=gBLXbwKfhpQqpIAeF4VH3QUtWNqyoHqiH+nxjsitfZd5zlY7mlPAUC9eVsp/9gNq3dfmlj
	dYw3LCEz1S2/ZI0R5RgJq4wGAGkYYCNg5nTDSlBkGR6uRYvommXaJlcQWOiHZNc968Q78k
	QLL7adXhoDUgrv0sYFAQQbRaF+wteAc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-jvjLQmZ2MF-hrDE3ijexHQ-1; Mon, 11 Aug 2025 10:00:24 -0400
X-MC-Unique: jvjLQmZ2MF-hrDE3ijexHQ-1
X-Mimecast-MFC-AGG-ID: jvjLQmZ2MF-hrDE3ijexHQ_1754920824
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e4bd6510eso69677687b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920824; x=1755525624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lG6B8pei2eYuQuxEro82WAinqULNxMleyX0BHmMNsk=;
        b=D4CRYqi8ZrXi0fXc5HglEGPsAkUNjyxVB3nVuM3ROkZ34cHCOo1MYHVgrm2JRZx0Km
         B6k91l5ZXkaZ1Bs9kERatJp0Y+tu8xlLXGE7TBaJDm49FYSxzrFck8lhzarYURlfcbPG
         jg8PrWd2N+M6CkAIe42ZDwd+9cK625xrhjBEi15/VGwypw0bV4fiXaeLcLmN0WW27Ul1
         wnYHDRshw09xNOe8cR/k+X4xES8jDH3hCnbl8ypZVz2pz7id6AKutPWx4WGMgD2vTY/m
         Eh9pVS+yX6YCieB+Z+iYKGXzVuWfoIdYx5k9hNHcLi+P8eclVIiGeBseQIWi4oj3GfEn
         ZyxA==
X-Forwarded-Encrypted: i=1; AJvYcCX/cO1Uhp4UC/fPiyy28QY6OQTTpZvzUvgEIHkN8c3je65PeBCzjpua4Gi1V7C8ecQ7cWuNVByV0LAPh9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0KZoaEUeiJ4w4cvA9++H3GIbabS17rZI/Ro5LBuMgv9q1Jfc
	oX7ZtJnl3+QWzqzmpUMbpdmPZNUl/mQe/J4njX0LdnV21CuiKC2RD/5h2te0ZR7pRZHONBiafvq
	k6TDrlI2mFmnWNfg7EQfyx3BCmyx+/snTAnwz4KV31cjCIDe9BADJARRA86XfYeZvoQ==
X-Gm-Gg: ASbGncuG31rM4CNo89iXBcpBv5CqxFSblYvuLH2DL1uGQYc4JplGGLPwEyKKzyZyE5o
	CiauL+fSFfdZEumM5TeiPMdH59/tzszYGsBV6aJTA1C2BFv6InUtK8+Lnx392S+yngWovA33H7/
	E5TgXZ7vJbgt34qEs+Fk8ckKN/Cp/H6eIdmlO0OQ+KgUWVWLEi0OaF0Z8ly+u+t7M5PIST/qYdX
	QhjWxXbheIP98hqOx7cmVwc1kUpHfP7vIyV4G6kysaXOhQeJY7ILsxExbP0rfXzFg5HAv5ieotg
	tipjPsmVAweMXNT948B1n73xTRVFLkge
X-Received: by 2002:a05:6902:26ca:b0:e90:33c8:1b2d with SMTP id 3f1490d57ef6-e904b4a29cdmr12331028276.14.1754920823310;
        Mon, 11 Aug 2025 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGObVjBZuwdQ+dSw6tzVznx3yYM1y550DASu5Gp1CEzbUS3E9GPq/e/G9AAjaDuhhSGdHdGWA==
X-Received: by 2002:a05:6902:26ca:b0:e90:33c8:1b2d with SMTP id 3f1490d57ef6-e904b4a29cdmr12330859276.14.1754920821822;
        Mon, 11 Aug 2025 07:00:21 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd388478dsm9710327276.31.2025.08.11.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:00:21 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:00:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
	ngeoffray@google.com, Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
Message-ID: <aJn3Z3q_kZl4Nob2@x1.local>
References: <20250807103902.2242717-1-lokeshgidra@google.com>
 <aJT7qQzEs_p36yfI@x1.local>
 <CA+EESO64MOZaJHyY_mTy6Gqvaz=CkPLHgc-UZ1rg8FXcPyh0aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO64MOZaJHyY_mTy6Gqvaz=CkPLHgc-UZ1rg8FXcPyh0aA@mail.gmail.com>

On Fri, Aug 08, 2025 at 09:29:58AM -0700, Lokesh Gidra wrote:
> On Thu, Aug 7, 2025 at 12:17 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Lokesh,
> >
> > On Thu, Aug 07, 2025 at 03:39:02AM -0700, Lokesh Gidra wrote:
> > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > > for moving present pages. Mitigate this cost by opportunistically
> > > batching present contiguous pages for TLB flushing.
> > >
> > > Without batching, in our testing on an arm64 Android device with UFFD GC,
> > > which uses MOVE ioctl for compaction, we observed that out of the total
> > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > > ~20% in vm_normal_folio().
> > >
> > > With batching, the proportion of vm_normal_folio() increases to over
> > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> >
> > Do you know why vm_normal_folio() could be expensive? I still see quite
> > some other things this path needs to do.
> >
> Let's discuss this in Andrew's reply thread.

Sorry to get back to this late.  Thanks for the link, Andrew!

> 
> > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > includes TLB-flush overhead.
> >
> > Indeed this should already prove the optimization, I'm just curious whether
> > you've run some benchmark on the GC app to show the real world benefit.
> >
> I did! The same benchmark through which I gathered these numbers, when
> run on cuttlefish (qemu android instance on x86_64), the completion
> time of the benchmark went down from ~45mins to ~20mins. The benchmark
> is very GC intensive and the overhead of IPI on vCPUs seems to be
> enormous leading to this drastic improvement.
> 
> In another instance, system_server, one of the most critical system
> processes on android, saw over 50% reduction in GC compaction time on
> an arm64 android device.

Would you mind add some of these numbers into the commit message when you
repost?

Thanks,

-- 
Peter Xu


