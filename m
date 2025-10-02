Return-Path: <linux-kernel+bounces-840851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF6BB5946
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B093AD99C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C71275AFA;
	Thu,  2 Oct 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y1B9H9KP"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5618027
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445918; cv=none; b=WOPIHxc5H1rC3jPPhG21ioJ8nVHZfHIUSO3d92tMG8SFKfwI0ZCl2LzR5FqJCBX8kvC/o+FLYmh7Bm8uHU5X/J3OM8KHL5zI3BksYYZ4Q1QAbIjdS5+QjwwRoUlBKPAkdkzUxY03y9EZQsIcBWq/sZ0gqgV6iOLxZam7LlssAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445918; c=relaxed/simple;
	bh=Y7ngC7HojWm7IUs9PGbu+/f7WUp+fPvyjflZvuNQEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht7qk0Dl5195cC5IBsWUwI+L45caE3CnB5yQjwOUtSQl+ymi1FdHHYKkahfBdSDcJdpHUspKKoY8uH3JQPpDsmDUrKNLYkaPwLX7MZd2zU3PPPFJoGAZLNI4ExtyjTHIs7iyAcoQQ/EGRDYjjYyZk/PbJH/pfqtYtPxP0Bznbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y1B9H9KP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-86302b5a933so140134585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759445916; x=1760050716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BD70i09QaMORHOgNG1NIf1k6EzR92nb/hgxntasDR3A=;
        b=Y1B9H9KPzBsc9x27fk9GwXw9H1m5QjH3BKU1EXbMgiaN8d7680NteoWx2ogLvkrFTj
         ZbrzcoKNq+9OqtT38zPxVI0ONd903t/kyime6+GgBKC0rRWsCjsSWHg2F7dYmauGcVKO
         tC1PzPmdk8n3/3dAfifzwLemichGWZ1AFTdzqLAltwug7e0i5N3CCO1SBaq+HVL9YUnR
         Yq6tBn0d3PXhXNLBJELZXeR6VPG+0BHbvv8V4Tlt5ypsg/vH2AOK7nQThYVfUKmv5P/P
         aOUSLx1mvxXAh2HQd91iOAj3h2DN0khnwnCSPlzh6V7nunEamsndZ4Gll9qMJJpIrY2g
         Qv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445916; x=1760050716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD70i09QaMORHOgNG1NIf1k6EzR92nb/hgxntasDR3A=;
        b=G6ESzRWMzEKBmseRElLXiCLhSG4TW/0z9YPI+5fkNZ4XSSFqBgAKdZXEGiwO5lv/Ou
         PgE7WFWvmTsy7ypf5KnwSx5KsE4eg0dKgSgE+XKr3AhlXj4cI4tLqxwKe5YyIT5HUyzN
         9L8WD5Mw2UIzbNqIc7HACr2PSgXOZdeqRoa3ZmSKInY+ylPIBsQQBDk347pXRbWP9jRy
         6qj4vAvRcf5TXnHdEEnQXHYJ0taPNDpj54gUPLXqnDugSiJzC4WlV28W+fIegEm2VunY
         xfI8LY2EHuTlCFmHZbQEGAah+4gBOoQr4jyHBpxwNV3QlHmGN+1pdwF8/UByIfU4858M
         lomQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJBkPuobYZQ9f4u0zrOTXLQnZCrIWzsf7JQkx9S1ARs4WFM+BeS9Vn97RT9DO3qUaeMpWvm5SG0F/fw68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmGpwq6sDGW6rQCHEe6fqzd1aqvWXvETxFa52glCDmqazKH8t
	HvGxsfq3cZP1oN5hJs/qqQn3kfoWF0ApPZIlL9pAPJ0rLyn993fY10VrtoOwD3IeXURMC0NVyP3
	su6IUZ1U=
X-Gm-Gg: ASbGncujvE1xwCR6qpVtfIV6FJ+x8ZNGLl7BmvEzFWd9sZc7HDoXi50/AsACzhCShXi
	NJrZRItl7VZCM22JC2ARnd980QNDDqd2W4+bQk0olxyUow46ooxQKTTEYLLJq7lWJv1+DIUDOC/
	hUz2Wb0mKS0CmvHDrSm05dhdxeOIPGkzPO9taLUQyYNPsl+27M9xlzhWhfxXdX0Rk3cozZqjIAN
	v64O9MbJSFxXZpSjzkQSw0hcT7iPznfDhY59USB7p66aWaqwJcCt5oqwjv+nh0bP1wptpb3aTZJ
	H7DjAaVoms1DX+tS8Nmfl/ZfahBW+cCWrSw3KYHGnBNB/8wdz/kg8iYpcXYmEIcF6golXAiRod3
	1flmg/7BvjQO0TxvSWzJljzAlsFUi3nOJjh4A1w2KGlkPavGolmKM7SPkuFH23wKiGzNg/yFUfb
	h4ZsB/tiR7EjmPpEwj
X-Google-Smtp-Source: AGHT+IHCc1FLv00zZuPdiNAyfYYP5u1gSaWvc8oyXsbkG+278vuif9Ukg/t+3FfiMRq3Nh5J7YH1Gg==
X-Received: by 2002:a05:620a:1917:b0:84c:65bd:2835 with SMTP id af79cd13be357-87a378d2e6bmr165704185a.42.1759445915598;
        Thu, 02 Oct 2025 15:58:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777112966asm293725985a.4.2025.10.02.15.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:58:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4SFu-0000000E1CO-07w7;
	Thu, 02 Oct 2025 19:58:34 -0300
Date: Thu, 2 Oct 2025 19:58:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002225834.GJ3195829@ziepe.ca>
References: <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
 <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca>
 <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>

On Thu, Oct 02, 2025 at 05:30:53PM -0400, Pasha Tatashin wrote:
> > Maybe finish is too broad grained? What if each session had a finish?
> > All the objects in the session are cleaned up, invoke the session
> > finish and the memfd's in the session unfreeze?
> 
> All sessions have their own finish:
> https://lore.kernel.org/all/20250929010321.3462457-15-pasha.tatashin@soleen.com
> LIVEUPDATE_SESSION_SET_EVENT
> 
> Each session can go into a "finished" state independently. However, I
> am still thinking about whether a dependency graph is needed. I feel
> that if we require FDs to be added to a session in a specific order
> (i.e., dependencies must be added first), and every subsequent FD
> checks that all prerequisites are already in the session via the
> existing can_preserve() callback, we should be okay, as long as we
> finish() them in reverse order.

I don't think it is quite that simple, like "finishing" an
iommu_domain cannot reconnect it back to the memfd. The only way to
finish it in the current sketch is to delete it.

So if you have a notion that finish is disallowed and when it is
actually finished maybe the order doesn't matter?

eg it doesn't matter what order we unfreeze memfds in.

This sort of assumes that something outside luo is still ensuring that
no disallowed operations are happening to the objects. eg nobody is
trying to ftruncate a memfd.

But I don't quite know what other objects besides memfd are going to
have this special frozen state??

> There are two issues:
> 1. What do we do with LIVEUPDATE_SESSION_UNPRESERVE_FD ?
> We can simply remove this IOCTL all together. Stuff can be unpreserved
> by simply closing session FD.

This is for serialize error handling? It does make sense if some sub
component of a session fails to serialize you'd just give up and close
the whole session.

> 2. Remembering this order on the way back, and since we are using the
> token as an iterator, that is not going to work, unless the graph is
> also preserved. However, now that we have sessions and the token
> values are independent for each session, I am thinking we can go back
> to the model where the kernel issues tokens when FDs are preserved, as
> each session will always start from token=0. This way FD preservation
> order and token order will always match.

You could just encode a preservation order numer in a seperate field?

Jason

