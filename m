Return-Path: <linux-kernel+bounces-858149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A2BE9248
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5E6E5650AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A1E32C947;
	Fri, 17 Oct 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t+70u32i"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB082309B9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710563; cv=none; b=fRQCcdFx5Hrqq+LVLVEoX3VxbIwdLX5MCa74tjduZXlX/tCjuMAEvRMalpvwqnj+CbzzzYrCh0/iCI7wkD8Cdz+an2Uu8bkrQdgPg8rliQBWo0yKrjyZLi4I5RvLtnfVbZkomIFvxTbOyLD1Ge22JbrHJLwofUSZjMqx7tPRDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710563; c=relaxed/simple;
	bh=2G8z9ycDdBpwwaCaOrqOcCvA/BJQn54WCYXHIpv+j3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzF+MYF7hbbO+3F6REFQHz5B98ipHfVAsiGU5S/vZzYpNtpJO5RLxE3bqOg8ks2bWdTnHTQSSYnRSnx0bVGV9mtH9y1NUZ2d0aWER15YhMZRgOEV6wF/ktukSIcNA7Pjq4SL0h8q+vq0kIArStAeqnOk/Re6/nY7zWSX7VJfEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t+70u32i; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87c11268b97so32010996d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760710561; x=1761315361; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qVzUxOueMoe23PedV99GX09iPb7gK5CB+nvolBA9pVM=;
        b=t+70u32itKZymRnUAD3IfaezB2vGw/SIEGvJfdbJqItzyn2lTjO+0I9S/rTKpmPwnX
         Nj+0nGqejjbgrGskUtg0nUME5aJE34Nl7w0bQgGSgzc/q4L/56ibcEZ0R+rKihg6OpTy
         gAAltw2npH0SS2zGR4ba5jEAozZqeTREnb1lI7xHtxD1RAawkoczjzVelrzdqR5DHSX9
         LHIq8ea8M2IouHGz+E0B9Yh9skIpcVm+axS24gtp8p9gZ+xwz55b/UbjdZVstnbHE+xr
         w6i6xC3+Jz4SdUe6yn/l2TH2IOhZHVpNmpc62+ENEjKwPYpMtf9R+hymwa0YeIUsX4fk
         MOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710561; x=1761315361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVzUxOueMoe23PedV99GX09iPb7gK5CB+nvolBA9pVM=;
        b=j1bQe3x+G/g300LVeCbJV3BbAld20jWk0a8b5fOMv8XcwjJp6uhPb+mjfuJxeYlbQI
         QSaMmRjVu33SS/EZqbH3kVZ5hojhSbhU6XmZhD3tJtkI3yL5JTPGpkwcl74bx+w+A5Sd
         0ceJnZQfQZ2mW+UjQCETbb6ehVNDRKFp4TprCXtc+4rFwpSqiCMvm64/3rq3aWAufIin
         smQvObuLzY9VcdfKS6Xvref0Pwyca3AcB6wq8eb40SxMXBBVXngRp1scuNZYH6iimRJL
         loje9yIcIA+sd+JpYLZR8m3cZbN8khFyA3bV5qmB3AoeRos9P9zY9YI9tJYV7n02csWu
         kchw==
X-Forwarded-Encrypted: i=1; AJvYcCWzBXvpHPcBaozesY2LCF85+rayXiI+Oal+LQsiRBAnr70gpptRGwhr3L6TB8KKIYS10r7LEeHsmUbiy4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9c3tFtqyBLKHus/FhDOmPRaPOn0GMF8fSxVBItVjBDFNKofr
	mxtv1SvF1cKUGlX9oSyazhVmPNTnw3yuTU2LWdDaFdpaJf2Gn42Kxf8B+dl/aGnOfW8=
X-Gm-Gg: ASbGnct95sKouxC9mXvyJRuTxmKI5F++C4EORxxw7vgnhzRcaiMDZEvFkMQcEqyjBNC
	NNho6zO0TOOPaib4Phs5shaAZlwKtvrXMdlgILlNGVRV9RJhqlb7xQeT+zCchhQGIFNUIFR48vg
	tifNYcTqeF+7jFhC07N0Gli+yQgEljr7RuwreQ5+lMrn8/AK1aLQCTgFtnDl1FMQLo6SjQqoKX6
	seq9+kNFTBftY728Y2x7oF4s2HeShqx5UzM2R1siLJTRrpyPNNQcS1lcOnRz9tCG6Z8JQvzUS2P
	B4mpA/fbC7bKpSm0UbeozHAv94490YRLUTfBn1oEjeE/9V2R/srCTPUYO9FFPLSlrEb3Kd+Tp7P
	cZllgp8dgLogR22tik1pm485/PVIeuIi7LE+EcmXOiNlWS7zF3ZtCtSLvsqIxpFsFQbzVSGk7d4
	LXGKZp4gABkIbdcvbGmWyDuW9NKQUJnwKnW4WarHTWoTaXJ+6x8GJ8FBRPk7nAO/y9UBfuhQ==
X-Google-Smtp-Source: AGHT+IHYGMe/FQy2ELhyRR228KkbeZxsT8SFrCJQWGcsvds5mR5O+zJihPxkSY4vC4O8HUM03y5vTg==
X-Received: by 2002:a05:622a:15c2:b0:4e7:20ed:2fc3 with SMTP id d75a77b69052e-4e89d1fe50cmr43536201cf.5.1760710560578;
        Fri, 17 Oct 2025 07:16:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c8a219sm66162341cf.18.2025.10.17.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:16:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:15:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
References: <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
 <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
 <20250925162426.00007474@huawei.com>
 <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com>
 <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
 <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
 <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>

On Fri, Oct 17, 2025 at 11:53:31AM +0200, Yiannis Nikolakopoulos wrote:
> On Wed, Oct 1, 2025 at 9:22 AM Gregory Price <gourry@gourry.net> wrote:
> > 1. Carve out an explicit proximity domain (NUMA node) for the compressed
> >    region via SRAT.
> >    https://docs.kernel.org/driver-api/cxl/platform/acpi/srat.html
> >
> > 2. Make sure this proximity domain (NUMA node) has separate data in the
> >    HMAT so it can be an explicit demotion target for higher tiers
> >    https://docs.kernel.org/driver-api/cxl/platform/acpi/hmat.html
> This makes sense. I've done a dirty hardcoding trick in my prototype
> so that my node is always the last target. I'll have a look on how to
> make this right.

I think it's probably a CEDT/CDAT/HMAT/SRAT/etc negotiation.

Essentially the platform needs to allow a single device to expose
multiple numa nodes based on different expected performance.  From
those ranges.  Then software needs to program the HDM decoders
appropriately.

> > 5. in `alloc_migration_target()` mm/migrate.c
> >    Since nid is not a valid buddy-allocator target, everything here
> >    will fail.  So we can simply append the following to the bottom
> >
> >    device_folio_alloc = nid_to_alloc(nid, DEVICE_FOLIO_ALLOC);
> >    if (device_folio_alloc)
> >        folio = device_folio_alloc(...)
> >    return folio;
> In my current prototype alloc_migration_target was working (naively).
> Steps 3, 4 and 5 seem like an interesting thing to try after all this
> discussion.
> >

Right because the memory is directly accessible to the buddy allocator.
What i'm proposing would remove this memory from the buddy allocator and
force more explicit integration (in this case with this function).

more explicitly: in this design __folio_alloc can never access this
                 memory.

~Gregory

