Return-Path: <linux-kernel+bounces-774091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CF0B2AE82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC0458039A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D5342CBF;
	Mon, 18 Aug 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d8S+rRP6"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8E254B1F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535619; cv=none; b=co1B1rGXcJqHXNn4WrPbjvqQE+EOyl3XWm+Qvvr828ZKiFJMdnkmM6kCNVjDHf1UogXT2hKZVHDiMVItUrPB//S/h9TSF6IYLggWyQ+OEu993j1hvzZhbhPD29QjRWHLaQfD4RCDDvDRa0yEsV86NZfG/kLGWiD/QBmS7pkLOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535619; c=relaxed/simple;
	bh=DVdAcvQU812zZuC2aK78C9aO5ghtffFn7I5ud8+Pyxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN1IxRtNgx5p2jaJJsHRK31zaYYYFlcofjj3axIobK0R0G3m+4978AN2FvOFl1idOVJGB0lZCQQfRSZymmGvyVFg+09J1ZXSjM86CJZdwG/08cgSvNyiUZlZEOFrx2yhyX9myNIGF65UyYOIvM+KwEbDvugHDii/h4oqr07BRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d8S+rRP6; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce5c7f1eso3772000fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755535616; x=1756140416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FXyiB6hArPVvWf92xe0IOfWpU3yyicTL/mf5Bbgn5dg=;
        b=d8S+rRP65HP+Pi7ftvgP+e3TlRTCsniDceXGoJVFiUcVQE6YbAZvZpMwwCjun0+rpj
         dDpZfx7zK3fWeOelrlCx8S3tRuIAV27MMMYD5p61WGe/ixyKw4d3rUUt9oXQ6MVZqMfz
         Jeo0/+2sh/FbK4LZYqThVQlSR6w5cV3iWNLy10+Fs/QPiAsZs0yaWjtV6ilS2yv0LFnt
         AFAeuyT8eDjgZehWQ75/t+dV8KzgQ0ay4l2bz6ltUokB3g/8Ofcm9J6Q77l2tFlRwBZJ
         1BpQxxJMXXEq6JQcglYAF/jCjZbcxadvikVTRxamBgYcKBgFvrny7TD33LOfZXynIxSX
         tjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755535616; x=1756140416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXyiB6hArPVvWf92xe0IOfWpU3yyicTL/mf5Bbgn5dg=;
        b=oWkyt4TYq5YNXFQJ62FaJwl1ePjqtQhZEKy04TCUKt2gkysj6h2YdRYKXD4i3YnoSj
         WTCPXrAT37hjDS9es6P8EAnxDoY95BSuc4WZ76mQ3noJLHeL10b/0iFbKwqu+9PR8m++
         nkJkBAxQhUXb53AjrzCyNavXe2n/HRQK+HNw95d47PJ5gdF4aEttKlXt/5JIrMR5ak0o
         5Z0HdgXyyjsxZUDum18684K3zMYLgz/UHDXhAt4VyyAqCjxFzROdpDywM3OH4YllcyPu
         amC/32caSVQ4CB/arnoJ7mswv/Ozij9Rn/dNFwQnxObMRv7YmgbptcX1U9fktpQ+QNHW
         CaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjzm8nHKqsPe5raaaegSAbkCrwzBG9+2BV0s/ZH+/EZtiyJZz881Wp+7+QsPd8TMQgStxbbReterFVTw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSgyG5wVWcz7OQxdLjKTHhQNZAjDe6C9dGB9ljSitsAcgJYx8
	Q2VsNYCGoFXwXP7C2LBa1kTgdmsKven4Xjmcrc0owr/k/nSb5+sOLxaNmYjXTBV9V/trg2YKOgP
	J12sr
X-Gm-Gg: ASbGnct/w7wfeYvpo1ggq4CIGh6dUO1Wp0okmcL9Q8hwE87bBNO9wdJx785rChpEMmn
	nRyWXMg/APRdDnCMJv4f5gAwJplS2FbVmPlyUvuIvUx+oSXp2jdiSHMAjqrIJzILJsyn+DbayWS
	eG5xVXnqvjYKQwT8ZlJscNmOnPxUthDhCEbs8GRFu0ra83hfUyoRfHVQ/hrd+88aZ9qoC5h6Hj3
	oQIoSxp5sUVFTx4Q6IjkOmEh7/WkAcAs6ZPF5uTITnvyCChbV8R1mWPwqdzV56YHvBF6xayxW3d
	5XnJvZZBXV8HaauIGUBs1FSywCeqHnGO1CJZmOdcmAjBuM5/3q2vxHanF7505yX123rqKD47
X-Google-Smtp-Source: AGHT+IFvKK7UXZdTHshbJKUB2QVJXZtwhaBYoKAz5pKipDZGTWMsdrO+WMZc89+L2egtQ6zzR0Akiw==
X-Received: by 2002:a05:6870:cc86:b0:30b:ae4c:2e82 with SMTP id 586e51a60fabf-31108286d72mr194239fac.12.1755535616469;
        Mon, 18 Aug 2025 09:46:56 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310ab952d79sm2706690fac.15.2025.08.18.09.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:46:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uo30Z-00000004RPM-04Ii;
	Mon, 18 Aug 2025 13:46:55 -0300
Date: Mon, 18 Aug 2025 13:46:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/6] mm/mmu_notifier: Allow multiple struct
 mmu_interval_notifier passes
Message-ID: <20250818164655.GJ599331@ziepe.ca>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
 <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>
 <20250818160726.GH599331@ziepe.ca>
 <aKNT8GUu0r3i4Ikq@lstrano-desk.jf.intel.com>
 <20250818163617.GI599331@ziepe.ca>
 <aKNYUaPS0PiRk/yj@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKNYUaPS0PiRk/yj@lstrano-desk.jf.intel.com>

On Mon, Aug 18, 2025 at 09:44:01AM -0700, Matthew Brost wrote:
> On Mon, Aug 18, 2025 at 01:36:17PM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 18, 2025 at 09:25:20AM -0700, Matthew Brost wrote:
> > > I think this choice makes sense: it allows embedding the wait state from
> > > the initial notifier call into the pass structure. Patch [6] shows this
> > > by attaching the issued TLB invalidation fences to the pass. Since a
> > > single notifier may be invoked multiple times with different ranges but
> > > the same seqno,
> > 
> > That should be explained, but also seems to be a bit of a different
> > issue..
> > 
> > If the design is really to only have two passes and this linked list
> > is about retaining state then there should not be so much freedom to
> > have more passes.
> 
> I’ll let Thomas weigh in on whether we really need more than two passes;
> my feeling is that two passes are likely sufficient. It’s also worth
> noting that the linked list has an added benefit: the notifier tree only
> needs to be walked once (a small time-complexity win).

You may end up keeping the linked list just with no way to add a third
pass.

Jason

