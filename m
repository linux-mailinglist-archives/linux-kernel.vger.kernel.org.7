Return-Path: <linux-kernel+bounces-756563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200CB1B5F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5473B2C60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED5200113;
	Tue,  5 Aug 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="njyPRPiA"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69841CF96
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402970; cv=none; b=KIyXeOuORjnjbrQbx42/crt5+9Xu1+4qXwsPfnXVsIakwj653TKVS4U9MV/98C6tabWRSy3ZbLG17nBThSkoK9XicZE359jFTciY9+TX9uPpQQWbr/Q3xuctVLHtgUJwVoAQ5YZQDCeg4zmukW9RnkXDM6DUbVQf+Tdbd6AKc6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402970; c=relaxed/simple;
	bh=320HJNn3ZyIhNHt0qLcttuzPG79KlsmiYoJdg+13Uio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZEOZBz8rrVhw1SQiuopRpG8GGS89tRRsg0PAjooW+Dcys46+Vm0/1n0J1d2Rdx4MDwYSCASgmtS34U2lAbrhddiSJBnEQjdd0QuIMQsE7KN7O/e2ycraEQTAghVQbPOnBrOa0yx8NwCL1lzOOguBkftwZN7Gmg3wKdhBmz4JrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=njyPRPiA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0619a353dso20422501cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754402967; x=1755007767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzAYIR/shPSYacUrOQJo0K9+jh4P0UFNjUkTluGngLM=;
        b=njyPRPiAKf3bMRCuA/9e7cisDO/K2qpF4agGRHzziUCskjsL+wPH7okJdOeR+kAc3F
         H2GjPUM4bpaxPfU21xnd5Y0giX1AIu1nngIplnhNzWXSm2X+73kladYgX6jeuW3Tsg6A
         1/5VnZuOGrK9it0FAGirZHhbO4sAnsiCbfWFkEdhBSVWjgZIF7hx25L14ISklnHu9a9P
         uu1YRYWBMKWSVKwDklL6Dj3hCPp+EWT3hKiwfkNFtBRcQZptFhccOe/m9Uxp2qvbMYb6
         f6dk8ZG96UDMXug+vY/CCb8SViNPUeNh3Pf1RrVvakzdyujzrE0U11cNffKrkEkrTIK2
         5dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754402967; x=1755007767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzAYIR/shPSYacUrOQJo0K9+jh4P0UFNjUkTluGngLM=;
        b=jIg/7ECYvDrLqcftnOlDuHsl6c4yI/2s6uFCsM1J86UTyWI+lgWm3aNLzuxlL7jaUh
         dMqyRrs8jUsvWWgzg4jMUVoaHnh3lehU/jRVL+thwMUNa6h7PdIxLAepeV3f4FclGRDx
         X25oZTuq1ue3B56pvCM+vON9ruOVJRDyDMnJ+PO7fr8wbsEp4zYY0CJFbkVnOAWmyVED
         R4WKDdoX8pNyX1S2LlR9mnmec1XLwOo7OlwQmakiRh2p+Kls5z5lUKG6OJ8+fs93b2+g
         AWPAjWwekgxhOEh7gsDBnU08/PY1nnjzaH99pJu6QeF9ABZse/3dey8YPgBXx/POtPEW
         I09Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDTlnWiKov0cE/8TquiOj7RD1cNwN8WOpuKXgYx8t02popaOViQkweIGxJmjOI24aoQUU/xRJOBelHUh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOn5Kd/c+UoKZPg29AeBkWGTyL5R6LbGyQBP9htSXrW4bJ7277
	MmcqC05NLrUSDhqtzleG4ebaQhqPK8n8VGsbipGqZgHky2Q+5NsFE1vrFlDmVrn+XfQ=
X-Gm-Gg: ASbGncu5n0gmhUlCjU8iOMvzvHVSXC8kuQpC51ewuhVybAjXcvNPT+zQF5JjtYH2zcI
	1Y+OpZYAuDTQeRfSYQF57eKDL8S4/1IWgaVaCcVBcqztOSYipErjDnckyoBZNrDOIzgoK1srh8P
	Wo0IPpH8RgK0CruXhVYeH5sQ0kl7G2e5Q47oK+7TcA1YNbQCBTuWkhV+eDeGymbSKZ0bRLSbNJw
	3FAmy6scp2lVqdIZ3Zna5SSeBrybt3gmub64loWQKumuRq3My4YiECIRdlhW49N/LWz7R4hGWuV
	1ca51zhiveliUOWBzvcN4YvWbFPKwCrJ0GsyYjpl5lCOiMalh8VJzjjlNjhDHw6KTIIEdwSYRZt
	gmlZO9yCQCQqHN7FCKAUIJsS/UwlaOprs4y+dUczauFnLuzNdy3L2G4qrUnvwompRwe9mHcTVyV
	RDgaE=
X-Google-Smtp-Source: AGHT+IHL+J4sqP2SxcyYA/bm344OksrCpi3leJPwTfOOG1s5eCheuA6YOXSpbD6tw1CHk8ksExeFwQ==
X-Received: by 2002:a05:622a:4a14:b0:4a9:a3ff:28bb with SMTP id d75a77b69052e-4af10a1abd0mr240543491cf.25.1754402967223;
        Tue, 05 Aug 2025 07:09:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed669c0sm65687951cf.33.2025.08.05.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:09:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujIM1-00000001XVj-3WEg;
	Tue, 05 Aug 2025 11:09:25 -0300
Date: Tue, 5 Aug 2025 11:09:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>,
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
Message-ID: <20250805140925.GO26511@ziepe.ca>
References: <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
 <20250801164058.GD26511@ziepe.ca>
 <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>
 <20250801165749.GF26511@ziepe.ca>
 <vscps6igy42u5limiigiok6y35mjx6acawi3qmvzbrpvltp4qp@mkydml7lz6fu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vscps6igy42u5limiigiok6y35mjx6acawi3qmvzbrpvltp4qp@mkydml7lz6fu>

On Mon, Aug 04, 2025 at 11:51:38AM +1000, Alistair Popple wrote:
> On Fri, Aug 01, 2025 at 01:57:49PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 01, 2025 at 06:50:18PM +0200, David Hildenbrand wrote:
> > > On 01.08.25 18:40, Jason Gunthorpe wrote:
> > > > On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:
> > > > 
> > > > > The only issue would be if there were generic code paths that somehow have a
> > > > > raw pfn obtained from neither a page-table walk or struct page. My assumption
> > > > > (yet to be proven/tested) is that these paths don't exist.
> > > > 
> > > > hmm does it, it encodes the device private into a pfn and expects the
> > > > caller to do pfn to page.
> 
> What callers need to do pfn to page when finding a device private pfn via
> hmm_range_fault()? GPU drivers don't, they tend just to use the pfn as an offset
> from the start of the pgmap to find whatever data structure they are using to
> track device memory allocations.

All drivers today must. You have no idea if the PFN returned is a
private or CPU page. The only way to know is to check the struct page
type, by looking inside the struct page.

> So other than adding a HMM_PFN flag to say this is really a device index I don't
> see too many issues here.

Christoph suggested exactly this, and it would solve the issue. Seems
quite easy too. Let's do it.

Jason

