Return-Path: <linux-kernel+bounces-817426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A4EB58207
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B3B4C1D90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831A2820BA;
	Mon, 15 Sep 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GDOqjrTk"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620F27FD45
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953695; cv=none; b=bhG9GkAK7tABvKnH+Tj7Wk8Ob5urq/R6xBDQU6aMZLd0C79dvyFmM65h6svsH+x2VrE7Mh4JZRlMnPnU2Yo0NubH3tkkCItpkhtq1jUVl4DDHFIyIkfMEYQH6JTthJEVqywYjRUhpx1M8em/ndlR14cyf1nI+tY6gbLcGAv2UkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953695; c=relaxed/simple;
	bh=12n9Pb+yXcwNFTqQGEMETuHrAQlt2tUiKpfSOPcrC3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro/zSjHKC5VltnPlAQ1EuSMZ7I3fbYi0hq3quZ3KIMxD1jf8SkNYmDZc9eymFv5EEd2LltHdM68K8GvImn2SHth8leW+I4sfaOb1vYB0bbuTHF0ezkGb5Lz0HammH0nNjHxyiaR2N3xe91V8hifiGhU4OcB9bi6WtAAK0vuXBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GDOqjrTk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-78325a3a5d7so8999486d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757953692; x=1758558492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDAemr4/lmLhb7KTewKWDzn1cjfqOTzFv/5msg8t3TY=;
        b=GDOqjrTkOH1ZRQ873O8kaLUntmw00zBcmkb9m+596Ev+HbRjgKBt2LiCqXjQ5Zkn92
         rJi/jWlEIU2yLmrVOjUhumxevqlZ+xhVfzLxWRemCHZwBfq87i7KQJy5dAsL4IgyLzK2
         0y88BiTpRw7KNzWaXRHSY6lXBXQUHx8xHoo0XBi4+YZ35XJEo/HOyGz0yxgxB6FTKEUl
         kZ1XFylzBH9kI4slTP1njcuvDEsSRZC82EMnKUu/JTrZUckUL88qu+ytHLyAjTvlpF+/
         MMtEAJExiAwGbJiEjcfe1Qr/r1XwYBCTqzuMSuPwjLwytSASzSQYGsMJSdxupbzjP/+7
         TkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953692; x=1758558492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDAemr4/lmLhb7KTewKWDzn1cjfqOTzFv/5msg8t3TY=;
        b=DExV58rZ8vn4ne3gQ6002ueI2p94G1J8L5gkd7v5/mOWZ6N9XBLVCDnNpebcjrtcyK
         ShskQKcCpXwMLYw1QosYV4XsY13s5UjA8ic5m4GcogO4MxhU5frPRh6bvh+svCaok3mU
         Kg7sCYaGNFE0Km52qYnsST/ATItvzTv8FWUw8I89F1wxX/eT9zsOx2vNCJxarrJ8Mtic
         ZGKW5Ium3tXKCoIh/0394tkpgjC+NlTZAC/wOVvodLUM1AbWCacjMi9Z1surBixdgW8c
         PketaBrqWkQXSn7+K/g8jWh0IE34A/Er4KUCqtq9JZbHxTBQe3gIjV89enoO/J9uBBk9
         n+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkxx2WxxOG0OC/YNj/ykDtNJADu0fvb7v3BjDW3ehGOfHf9P0lWImdpqg7TOUZroJ0Wbmr2aH4AuNekVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaUzwWjVfs1kCG5o9AehtHVMs7PA9AbPLnH93UVVBLqG2Ve0t
	0YwBeN4HHr9+eJqfWkJLA2JFSGFR+nbrmgSf3Wf8qV8itOTb8Fv94Zktu77JsUQP7+Q=
X-Gm-Gg: ASbGncvcXvzZ5sB9wgw/9Bbt9zrQtaxV2H8a1OmpSm2zoPXCigDblprLwftHWh9wBjW
	Qs410Df9A7I5COUa825Tzlt4EVGInM3tTHiVjXGKC13hJyjeBmGa8kmEQ5eEqmZNTI3VsjNvttg
	fcZBCMJ3dZnUY1ihEtcwoj1LFy4lZNuMiFKBpUlrlLRMs0WjKFwGQucWDH9xvbf+ewXurFL9+Qe
	PPMJtma4UBhxnyJ1ZIoPUlajkGSC98fGusAYeI+0Ww+plg2MmZNUwQ+32PtSSqedSdJL+yjLzVu
	B1Wsy/E0hrxs4vcXeAJdF+9q2DsIIJYMAMeaiwQiH9jYXzHh0bk3LeZVkQlO4jcL3JlaUQjwh27
	w0a6PrEUsuiTJastwuw==
X-Google-Smtp-Source: AGHT+IHXUa+XyZ1S/pis0/NjQwmdYj7V5DxWg4goJxyPrDTodTnzzzbHD2bc6ZPRF/QWzQoUXXlmuQ==
X-Received: by 2002:a05:6214:21e7:b0:784:4f84:22e9 with SMTP id 6a1803df08f44-7844f84232emr43875496d6.18.1757953692165;
        Mon, 15 Sep 2025 09:28:12 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76e576ee0fcsm55860646d6.69.2025.09.15.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:28:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyC3m-00000004TCU-1UNv;
	Mon, 15 Sep 2025 13:28:10 -0300
Date: Mon, 15 Sep 2025 13:28:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Message-ID: <20250915162810.GI882933@ziepe.ca>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250902161028.GC184112@ziepe.ca>
 <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>
 <20250910141547.GD882933@ziepe.ca>
 <bb4c3f0b-06da-46e6-9769-efe3dc00e9fb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb4c3f0b-06da-46e6-9769-efe3dc00e9fb@huawei.com>

On Thu, Sep 11, 2025 at 10:08:55PM +0800, Qinxin Xia wrote:
> 
> 
> On 2025/9/10 22:15:47, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Wed, Sep 10, 2025 at 11:20:08AM +0800, Qinxin Xia wrote:
> > > Ok, I see, my colleague Wang Zhou also released a version of io_ptdump
> > > a long time ago, which is implemented in smmu debugfs. Will recommends that
> > > io_ptdump be implemented in a way similar to CPU page table dump. Using
> > > debugfs to expose the data and using format-specific callbacks to implement
> > > specific data dumps, I'll talk to him about this as well.
> > 
> > I feel we should have a iommu subsystem debugfs and per-iommu_domain
> > directories to dump the page tables.
> > 
> > The smmu debugfs can report what iommu_domains each STE/CD is
> > referencing.
> > 
> > This also needs RCU freeing of page table levels as a locking
> > strategy.
> 
> Thanks, I'll add RCU in the next version, but there's some
> confusion,

Please don't, RCU is quite complicated, I don't really want to see
attempts to retrofit it into the existing page table code. This is why
I've said debugging like this needs to go along with the new iommu pt
work to consolidate the page table code.

> Do you
> mean to create a directory for each domain? like：
> 
> /sys/kernel/debug/io_page_tables/domain_xxxx (xxxx=domain addr)

Something like this could be a reasonable option.

> tree domain_xxxx like:
> domain_xxxx
> └── group x
> │ └── device

Though I would probably not include this information..

> └── DebugFS file: /sys/kernel/debug/io_page_tables
> └── Operation: Reading this file triggers the entire debug information
> collection process

I don't think we want to dump every page table in the system in one
file.

> Do you mean that the interface in io-pgtable-arm.c is directly invoked
> during the process of obtaining page table information without passing
> through arm-smmu-v3.c?

Yes, this is what iommu pt brings.

Jason

