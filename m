Return-Path: <linux-kernel+bounces-741823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EAB0E959
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8BA1CC0361
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469920B7EC;
	Wed, 23 Jul 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bK+KGqnT"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A951E04AD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242708; cv=none; b=avBH9xV101Ih3ygjadUapDQd1UEc56fkALSauUONbUQNhT8bz8fYgaMcQIsHedoO/IyvZP0kBUSe/ehTOlgMIJO4ZJBP3J5S9A7WnYgIxdj51eN+7AFWH6sdygvFqa04wWbuzE7i7Vuj5AvhHOeQGvb+HCPwOT3ul56D9p6jUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242708; c=relaxed/simple;
	bh=g1D4R+y8GTymFwV80C1L2cx2UaXGlgshC+EanWWy6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaKax4nNZ6rwFIme0ykRAmBT4+loeOGxfl/4XrT7A/pBMun5sbBcQbP0voLTafpfEz6MtQrDamqdGJxt1X4JMq2FU5s+1nCvyaoIyN0xIHso70o4CKbgeh1oZS/SigZPPpSfFiwM2wqT214uTiDLIq/jNkus2aupKF8Jyo02U7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bK+KGqnT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748e378ba4fso7245727b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753242706; x=1753847506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0yhqhfmgcWd4Boy+yEMxc9KNWgoVjI2gD67+Le01vg=;
        b=bK+KGqnTFcD4sTo+Dgf3WduUx90IevQRf0znLXgpwsQmPuI2jrGxLhZ2QVPrRiwf0/
         A2tNrTZ4Y/EtNmc2dDexDyL72YAt3zOXcC2wHP1KV6JGKrHgCF3DQjeW5Z3LZzWGOHTr
         BLVi8auTwZxt5tMZi7c2Kkpy+nSfOzyxDsVQ0I9xWiOdkdZuaLFg575sXlnHLcUhWbH7
         ylbvtO1q+Cr9mq9dpKSkaWM0F/0RSB4U4JRGapBFL7tRHAkcjiaQ+9HY+eoUOoJnpURw
         9OnnGtseFciEbQvC3FAzvnClMwB23iBBOdXusupZkarPfWdPETS+Nyujvr7RrNHKeRM0
         dxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242706; x=1753847506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0yhqhfmgcWd4Boy+yEMxc9KNWgoVjI2gD67+Le01vg=;
        b=fgeKy2/ESwZl1sO6LDQIiSBr/9a/f7t47TKrsHe9lth4dnOSy8pKJbnZvsYTEOkgRm
         3sG/azazI5A+aX2I+kdWSkupr+IJ1YKMn2pZBkFOMJeMXnb0G1YEkPSJjE8fvZwEqqLG
         0+aSo1xTx/zTlHzMnWn3YPX3/bUxBJ+FyhLWVakamvDy4HuLNSLEtbwxHQ1+CWN8kE7h
         5/z0j3zSx2KfqXZLnyYzyE6A+8OLzSNEGbIGCSDhAvsjn8DlckWOhp12cYsr+H21E5hg
         DZKfrEs6OA7ijO7lrVT9DmomrS2+J3Fn22nKez0zrrm6Ry+BMI1TGaVQy7lTlL0BJGlH
         +izQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcWLkS+t12ASNJe3Oy0Mi9/f7PQdwZ3dhYTM4VBxryd2BM765D67TlSXa+TjFaejqW4xi+mqv7zcv+uoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9Rhj2EaUG2SQYbpRxfivpugKNG2jvOjdqonY3IFf9OsEq4+M
	vY/SD8TxwssEDIdRYQHPjThuqu2YtMrHz5KRMuaisrC1bDZZ/WMcJPWD0Ctnnhm0NCw=
X-Gm-Gg: ASbGncumYIaeA0EeevpociZo5Jt+RPYQM/1jveXSHjx2nDbgcRALhrRb8BTGxLqb7ak
	MogXrP8M8LW9pwM9zjmkqyQchwLveY649bkjoHN96DZm+YrA9ndcTiQPvvBZEfDVmeIwlVTBi2c
	RN5ci64PpDUpBuCMnjWeZs1RVRUtnls7grxWGa8oVqM0bZcpDZrnrTnBdXiiwtAt8ZZN1l8lskf
	gskzZhNq183gOHulPo+wsZ9Gpev8rkE62SSjMLTfiGd1BHx77u1GfiYNxgc31K4SsdovIM5CxFI
	l2jUMcN32d7cJodI9VbllnW5tqKLlBX1sphusr5lPxZuB9MsKeC0XQOpwmDDYajaKig1J8yFp24
	JdvUJTznu86sJcfNniHH1XfnHDhKOnXd13Js=
X-Google-Smtp-Source: AGHT+IFhuc9YoswnVjbx+w6CW5AJc04rjosHA7fJ9MRqxxtRH8l6eukiOU6gxLlrv7CiSglvAulz8g==
X-Received: by 2002:a05:6a00:1491:b0:748:f406:b09 with SMTP id d2e1a72fcca58-760367de539mr2440550b3a.23.1753242705935;
        Tue, 22 Jul 2025 20:51:45 -0700 (PDT)
Received: from ziepe.ca (S010670037e345dea.cg.shawcable.net. [68.146.128.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3190sm8518497b3a.39.2025.07.22.20.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:51:43 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ueQW6-0003Fi-CT;
	Wed, 23 Jul 2025 00:51:42 -0300
Date: Wed, 23 Jul 2025 00:51:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <aIBcTpC9Te7YIe4J@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>

On Tue, Jul 22, 2025 at 10:49:10AM +1000, Alistair Popple wrote:
> > So what is it?
> 
> IMHO a hack, because obviously we shouldn't require real physical addresses for
> something the CPU can't actually address anyway and this causes real
> problems

IMHO what DEVICE PRIVATE really boils down to is a way to have swap
entries that point to some kind of opaque driver managed memory.

We have alot of assumptions all over about pfn/phys to page
relationships so anything that has a struct page also has to come with
a fake PFN today..

> (eg. it doesn't actually work on anything other than x86_64). There's no reason
> the "PFN" we store in device-private entries couldn't instead just be an index
> into some data structure holding pointers to the struct pages. So instead of
> using pfn_to_page()/page_to_pfn() we would use device_private_index_to_page()
> and page_to_device_private_index().

It could work, but any of the pfn conversions would have to be tracked
down.. Could be troublesome.

Jason

