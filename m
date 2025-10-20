Return-Path: <linux-kernel+bounces-861177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8223BF1FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D274F6AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF695234964;
	Mon, 20 Oct 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tEkH2GlO"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728E56B81
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972763; cv=none; b=q4Y2tr2WmyQf6DjsdznByXXVR+9Q6hwwAiPC3cyIyVFXTye2Ho+vICAz7EHhVYRJ/GPyayq8PAvKvhrLDGLyGjFnNEDm09ZxcT9GFgLzrZvAX3aAbgn101Pwvn6jB840C9MuZRV64xzs1n5+PSkzEjhlcGM5CJGve+oIsVm3aHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972763; c=relaxed/simple;
	bh=VHxPn5JqPitYnMupUsRfQ0j0wrNMZeZMTDOxIXzZPb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8yAqRxrPh6ZAH89Hzy7H4nGGqtUV+rWybYEhCTJU/90/yhhTXA9MRCNf3/R4Tc2kTd/ixmXYz7GkBoGFVHO6ZLk65BbEyeZaxct2roRuaB6xKmvj5zzbxw3U05kQZzpPFSmi5Mtr94fBalva55z2IleyK57Z5joQVfTN5equ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tEkH2GlO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87bb66dd224so61745806d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760972760; x=1761577560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1mZfa6PPfYiWQUvQbwihX13IYOS0TbObq87rU2SWyc=;
        b=tEkH2GlOa7gvA5WtajwLQJ6zIlg9vAcC04aQGse47NPaSx3QbUAp32WFfpoB3W4Cxj
         FJW80SDQxzY5/bXLRfLH2xYBJ+oMAlmPj1/O/gwyVAqGps/Pts0sXDqommpph0HTt0lD
         tNKNMG3hO7EYtJ4cBD4RcNdHHjp7Ad0QmcmcWMNNK1qpMDbGjNCybdaY1BveD55IUAjc
         KBd2SFtQh7sjOX2a1HPlZIhmxSPwWg3jP8xAlX00h1HtqqEfTvMC+U4r4K8eV23KGEQ4
         aB6Qgo1PqV7FADmLxM+Lna+3C2D+wAy2iveltqPrxPQi38rW/J+I68s9aLLUBWi6qp4U
         D16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972760; x=1761577560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1mZfa6PPfYiWQUvQbwihX13IYOS0TbObq87rU2SWyc=;
        b=XBQ8HLbyFgGmvh7vjmg6VF9Ce0BBoSzQarFqLbzdUfZWYx2EA1s4BiObnz7Je1nTVd
         bil54yT4qp7OCCT8mnqRWdMHuWnaGAIKY4K1EETpnb/BleKBgSOMlW3EuUxn/LuqfxQP
         s8J7pfs3JtKQK0NfoJX+Md0/EBPQMnrVjulruZxtR02BRTY7PJFd8TU9nlBYMIADQezT
         p3nlT03lqrEqftEzS7HetDttMDIrsmjGpURpVECXDafcj+++xxXxuMZ8VNoVN51Ch0y0
         GXTARvMou/GrDStEgRToYAudCgKD3u/41MG5DXRON03JIZ3GFhE76DypfstLtRsMVJkF
         vT1g==
X-Forwarded-Encrypted: i=1; AJvYcCXvzla/YwoYjSppW9tTrUgKoUJVQAlK0p/tb+5Is0GxOCPVvnHPQc8ggcW9a4P3yLa14NEKwBGRxejAOJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGtgxR6XlHMTDrEwnJrGr2k15SMnz0qPQpiyapaXZ8Rwd5T0Q
	/Z8tNx9J+aZF4tdfO5VQLzUpq6+4Ov1hkCGTio5aWpVBxsNNzWxOal9oVt1NwpHD/gI=
X-Gm-Gg: ASbGncv8RQ1o3I2KwexfySp82oSOyeGdYZ9b+uDF074mFdAM5vFQRd1u2OlLOKco5f5
	8vju2P443C7cTpvqlbDv8mQuS/fJrSGeFHLlf7GKl9AptHjqPD9/4nhQX9wYehK+em1A3RupLTk
	WEZoh6N8jpXY1SvjNEMxcTvX2uLRx8MnpTYJx1OGCCm/1PiMxCtf841m8vGQtplgeF5l09GoX+F
	R8LuMBo7e6dMynbqavK2H1+fgQTTxRuzNsI5kbGqrY5SXgGeOyz68YlSX+Qku6LULl+BZDSm6SP
	DTpl6Y21zpdbTkkg2pFs3qPkY8Gn8bVg77g02E6R61txt+aI+LPtw9F0zGhwr1S1d0xMw6zaBLX
	k+f4V7/ko7+dOyWZql3CwKk0Pz9G2Pvvvk5lGYO4KUwNzJzAjQnGRTRZmTZ1nFavNe5EukUnuWB
	15MYmDGh+9nfyTSsVm4klmb9j/DqMpcsItdQfPoqSbrGdpPj1Ao19RRUWh9fQ=
X-Google-Smtp-Source: AGHT+IHi6hTC/FllE1Hp/tmAHDAJqxkK+nzpm+chWs/vbx/HyCSGCja8fWvNBZvZG6WZVkt7B3u62A==
X-Received: by 2002:a05:622a:1820:b0:4e8:9459:4f61 with SMTP id d75a77b69052e-4e89d355d9fmr163821891cf.53.1760972760160;
        Mon, 20 Oct 2025 08:06:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8af0126a9sm51384451cf.12.2025.10.20.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:05:59 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:05:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
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
Message-ID: <aPZP1eb4moioEOhc@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
 <CAOi6=wS6s2FAAbMbxX5zCZzPQE7Mm73pbhxpiM_5e44o6yyPMw@mail.gmail.com>
 <20251020152345.00003d61@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020152345.00003d61@huawei.com>

On Mon, Oct 20, 2025 at 03:23:45PM +0100, Jonathan Cameron wrote:
> On Thu, 16 Oct 2025 18:16:31 +0200
> Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com> wrote:
> 
> > These could be good starting points, as I see in the rest of the thread.
> > 
> Fun problems.  Maybe we start with very conservative handling and then
> argue for relaxations later.
> 

Not to pile on, but if we can't even manage the conservative handling
due to other design issues - then it doesn't bode well for the rest.
So getting that right should be the priority - not a maybe.

~Gregory

