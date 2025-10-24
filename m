Return-Path: <linux-kernel+bounces-868911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8963C067AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 470454EA2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968831C587;
	Fri, 24 Oct 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M1knhzh9"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275902DC78C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312314; cv=none; b=P6qrZNVBF1PkKpb1lkquQKcPQ06UC8ZYSywip90XaqYM3Nv0uFow5t7TjYAINiX7qRAe0u86OUr9T8tETbGcgOo0uFkqxThC/asWd1CsmwPxjkilmsw52vOs2LGh7fHC/YrcDTyhu7hYkYGPCBKBUYbLqRRT7V501s9PA+R4y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312314; c=relaxed/simple;
	bh=hg+k+hXZjREUNqlY5D9HdwDqBHKx8EBqmD5V/A3aSd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKWzIwzTn7tOfV+yTHg3YY0AHdKABZmxK9PWzRW9K0DDNW0rvPvhhO11A3ZCZ/WmWuYvVOlcq0ilNYI43BrGtIp7bVW3DnoPV2XywVz8ViQ4ajGFeQkCxSBsGBba7vzSWYSo0Sv2b5ikuM2b6RVn1XNNwveG8pYsxwXy7+ht0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M1knhzh9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-89e7a7e0256so29121785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761312312; x=1761917112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aj0SeoWC7WJCm+N08s/eNnhLHbhk/Wyc57uRWO4wNWo=;
        b=M1knhzh9V36Pd5IWg0mX27gwis9ueJgHp689DSb4ZkTfA1bZCE4v/VCHm512AFuIF9
         Q75f34Zw45kry7YL7HQ5fvY1GcsyNfY4icq+1S6MZnLy+ok/jkP9Tn/+1+NBjmlqlTY4
         XkoTYRID42HdiPkwi2W0d+bvAB5C/VzMplDzSyhccVgT20HFIyeZWZWhYyd75/HHtLiR
         hdaN9W/TC1Mn2p0vFRlUZlBL8nSWxudQ6jB4wzEpC9/t+yOe/U+mlNPlOU7nQ9lU3mQZ
         Wf+zPh8K6WYtwBzbkY2koVUhHGz3fOsNfDKDu8qKN6Aiy6eLehCRzEB6Gi7Ai17Fg1zO
         1bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312312; x=1761917112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj0SeoWC7WJCm+N08s/eNnhLHbhk/Wyc57uRWO4wNWo=;
        b=QJx/2lh0ZGRP0pwaZOqlPg3b0aa2O66cu9yve+yJLzoXJ8QPv6Z2kK8PEI7JeLt6gk
         sf0Z913Pvbfxkvxbx0JE9zVpiy9z4zs3FgxxBil+zWGSs2sj8xdUW2JB906aXmm9qYSx
         hHjlLXnjOJ8oMt+DDVlLSnLxMh/4WDXeap+redutuanJBfPLkrtukTOuUlnkxE6tes0c
         J4lP5ba42w99Dr8MOI/KfQxWEFBTouimWOh+o2wqy1jc7aMq49ViJjqUCVdW5tMBmy6U
         Ahwzp1G8gB1DHgHC3048gOo/B8EWOHnOf6XM6yx95cbe9qBYGFELilWOdkFquecF3O/8
         qeMw==
X-Forwarded-Encrypted: i=1; AJvYcCUOs+fb1gakeh79mAQYt+nwj96sKhdlwS9uHZvLxeL2FeMsq8ny2UYQojZ79INaylivFvI3HIy3zb4fQPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJST+hl5GWn2bot4OTadHSeSb1Q6v/DALz6URs+/HffMbiEpD
	MnUYWCxJwZQs95LDa6u9pGDcr/zPwhuOUCi/Tq0x/erRsctoWL6r93AGplDiCSQKdxw=
X-Gm-Gg: ASbGncvCBahYtZKh+gkD+Vl2BEFD/H1Bsi8vjrQim8zDE09rO2nZ2OGUwtJ3cwBfil3
	B3wjJVmqa7YgQpjC2c1e9DcJYZBTZNIVXoTY/fA4gcpmbrZ05Y4K52dKriiv43OFIsi7ogjZ6gg
	O6USYEkmPHNhZk4ksiH23gmK/Ak6LgPq/7GAuGCcpgyYZtvM9gppEQFY/aOD3X8Bwh3SNF4VFkF
	mFINezAVexefU1j7Ng7SQftzA/YMqY/Pcy5il/88JXT1OX0yUnYS6yek8o6QIBqLEHRQUblrVuO
	wicplWj4DYXE9ylNxl/RvsQi0xie6mi7rwyLV2MxZI6RAJns1HqzHVkTTVwCf2s5EC1DOF5sy6Q
	ISRZY9FbomHLWIiox8kAPPK0n5DOTC/1xMmoFjnzOWSCLSwpX8k+9MBRM2+j9mtOi6UcOIe875p
	wx6+znxCH9sRKVufqtcl2lNSJSkG8t7OlaCfZlJC96Xxm6DtFhWg1R3RuL
X-Google-Smtp-Source: AGHT+IEGAyhhTF+yO14yTGLloo3cDyt5954pwwnLoAEIBQQ3wHdpsngyLyG6oHWxHD+JOdW4oxag0w==
X-Received: by 2002:a05:620a:178c:b0:892:eb85:53cd with SMTP id af79cd13be357-892eb855743mr2323365185a.42.1761312310446;
        Fri, 24 Oct 2025 06:25:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c12352ec2sm381880185a.52.2025.10.24.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:25:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCHn3-00000003hrr-0bw7;
	Fri, 24 Oct 2025 10:25:09 -0300
Date: Fri, 24 Oct 2025 10:25:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com,
	glider@google.com, elver@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <20251024132509.GB760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
 <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>

On Wed, Oct 15, 2025 at 10:19:08AM -0400, Pasha Tatashin wrote:
> On Wed, Oct 15, 2025 at 9:05 AM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > +Cc Marco, Alexander
> >
> > On Wed, Oct 15 2025, Pasha Tatashin wrote:
> >
> > > KHO allocates metadata for its preserved memory map using the SLUB
> > > allocator via kzalloc(). This metadata is temporary and is used by the
> > > next kernel during early boot to find preserved memory.
> > >
> > > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > > randomly intercepted by kfence_alloc(), which services the allocation
> > > from a dedicated KFENCE memory pool. This pool is allocated early in
> > > boot via memblock.
> >
> > At some point, we'd probably want to add support for preserving slab
> > objects using KHO. That wouldn't work if the objects can land in scratch
> > memory. Right now, the kfence pools are allocated right before KHO goes
> > out of scratch-only and memblock frees pages to buddy.
> 
> If we do that, most likely we will add a GFP flag that goes with it,
> so the slab can use a special pool of pages that are preservable.
> Otherwise, we are going to be leaking memory from the old kernel in
> the unpreserved parts of the pages. 

That isn't an issue. If we make slab preservable then we'd have to
preserve the page and then somehow record what order is stored in that
page and a bit map of which parts are allocated to restore the slab
state on recovery.

So long as the non-preserved memory comes back as freed on the
sucessor kernel it doesn't matter what was in it in the preceeding
kernel. The new kernel will eventually zero it. So it isn't a 'leak'.

Jason

