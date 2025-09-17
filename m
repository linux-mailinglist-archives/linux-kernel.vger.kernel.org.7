Return-Path: <linux-kernel+bounces-819995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D670BB7D722
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807677AB5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EBD239085;
	Wed, 17 Sep 2025 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSWd2DIu"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31172614
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086526; cv=none; b=BA+WWvwEuZaLp+pImyL9eI7jWIjs72bN0hjFaH2v0VhQ49j0VIBf/c0RGmIRzjlPdGByK1idDXdLROHiRnrW+IuXb6I3CAIh7GWm5VRfnAtW5pKUtrwUkoDPD3hqGwL+eI3hPGQ0SOxEcrWq4C7YztgXQN/jSLbsN0fiXHKmGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086526; c=relaxed/simple;
	bh=dqrWe/2xfQwHLFK2ix/zztwdYgeBIp9cIEOVTTMML3I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+p7AkCstbow8JAMk6E+5kkohsUV4zbGVB9FmXmF+IvsG4pi0yXaAxDoUDrk831MAeIkDol4/7kGPkDPAqE3Nu8KTlzskU5xdFi0pESDCF6PHn5hzerVlnhkVDeEO+mpagideJbxUh05UabqoaX8Bw+BXISTLHkde6+utM9i3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSWd2DIu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f74c6d316so6284964e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758086523; x=1758691323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4V0oPOiHcQlvz8Wl1Te3jqJzsEZTBdcCgGtgXa655o=;
        b=TSWd2DIuTdJNyLwP7TfdETDVAIEWIBtLNYbYorUnOph8jBEMd8Wne9D3F7tR0pyb/S
         XUQi4egj5VOZo6EU3McMSMedtA2tPf4bds9Ld4EoKOflooe+SNK/dzsjItI9pZxg3+Cc
         KT44Ecl5I6L9z/cJ5CuPBwfCecwRvxRTFRd096Yh9UcwNwvsqAIjluIZV3vsfZsZ5mFJ
         Z64X/1MXQRwxS2W+Tt0erzMdAKD651oXmlNTpgtCjG0qA37WnyFOe+0/pe8wSFJ3cvfu
         5uP5smUwT+TPiiZpgA3eCXz/pv9WdcazZvtkKXvwKZfYK+GmvQzTeagIJCrSuSfTqHLz
         WbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758086523; x=1758691323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4V0oPOiHcQlvz8Wl1Te3jqJzsEZTBdcCgGtgXa655o=;
        b=t032ufLmKAqLS9IYsuWasF7lylJftii68EDRmnBCSOW7qDesHv5kI34H+wDGcbHxz0
         GzffNUkA7l7syeKk462kNZwwBtV8Xlc9PBgXJ+NZvEUNQVYHtQBUDI5i0Z2Z7Df4KjTd
         Ic2wpWTyoY3QWycOxdFCih4ce3/FZdJWx1Irq+v5wIALByGGIavkIefutca6msOEdFzn
         /uoTAEwsxt3rgYsyGQ6YZj4CeTvKKf8mgtSXSNONlAcWTSkQcR5nWLxu8fW10fqHtvMU
         aEh1hvExnFhtnTHktSDTwMQt218mBZypcshePaMj9Vw8ebTlug6pS5gd+hs2ueuKqQhU
         +tLA==
X-Forwarded-Encrypted: i=1; AJvYcCWl+VpaY1pQ18DqYrlZb6EuD0lOEPn+WrMSEUxDcg7K1Njr/50rhrZFEZ6EyZf8t0kgF/HvPkyExMC3I50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrTtHzKz8KGtWJWxSuyVcouq67gmIodSqk5EADjxMxDZiTMkc
	/P5MmKxfKh/5CBQjLbGljaQ94MxRdcv/P+8N1oRh88TC3fBZ3BGPMXTe
X-Gm-Gg: ASbGncuLVFz3Ov+ATFgHO7j3Lenr/U89uREBdB4dbhzrZc0d0mIolz8gbffEmqzFXP5
	Q06yiKZrioTx2XP5g4zTrKrP4d2kZSmnfJ7NZ+QYNFR6iSom9QZaHxHWEN5O7XQ712kggs2V/yl
	8baQHqiNJcPd/lahUVWu6aUJ9sqKhNUB+phwognBFHoc4wydAuaj+RqltqaviEKEXuwRi8/hFyq
	z3m9BK5lBFCvqvzExEydE2bgbz42PoL+1jyAcRNe66Ol5+1Kh2eAZ1D3+7mmDsWeBYOPAz/4cjs
	p6hryjTH2dd0KvRZVd1qKKvfmDp+NG8lr2y+9MBFJPyzqCRifoi5+L+xvuWnjoTX
X-Google-Smtp-Source: AGHT+IFTd55XpTxH/s8Wj4Dy8CPAx1rIWPrgzoIlER18h3np+V8WcEqUMNnWPJgXqpr93S+bIj9hGg==
X-Received: by 2002:a05:6512:6382:b0:55b:8afb:e638 with SMTP id 2adb3069b0e04-57799ea77b0mr164452e87.28.1758086522911;
        Tue, 16 Sep 2025 22:22:02 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5779b5d6928sm233405e87.131.2025.09.16.22.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 22:22:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 17 Sep 2025 07:22:00 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] mm/vmalloc: Avoid cond_resched() when blocking
 is not permitted
Message-ID: <aMpFeIANuJGRc0vO@pc636>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-5-urezki@gmail.com>
 <aMhIv3HfRMyjlSec@tiehlicka>
 <aMmCJOJFMTuCXH3m@milan>
 <aMmnkm_E7hDO_yN0@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMmnkm_E7hDO_yN0@tiehlicka>

On Tue, Sep 16, 2025 at 08:08:18PM +0200, Michal Hocko wrote:
> On Tue 16-09-25 17:28:36, Uladzislau Rezki wrote:
> > On Mon, Sep 15, 2025 at 07:11:27PM +0200, Michal Hocko wrote:
> > > On Mon 15-09-25 15:40:34, Uladzislau Rezki wrote:
> > > > vm_area_alloc_pages() contains the only voluntary reschedule points
> > > > along vmalloc() allocation path. They are needed to ensure forward
> > > > progress on PREEMPT_NONE kernels under contention for vmap metadata
> > > > (e.g. alloc_vmap_area()).
> > > > 
> > > > However, yielding should only be done if the given GFP flags allow
> > > > blocking. This patch avoids calling cond_resched() when allocation
> > > > context is non-blocking(GFP_ATOMIC, GFP_NOWAIT).
> > > 
> > > We do have cond_resched in the page allocator path, right?
> > > So unless I am missing something we can safely drope these. I thought we
> > > have discused this already.
> > > 
> > Yes, we discussed this. I did some test with dropped cond_resched() for
> > !PREEMPT kernel and i can trigger soft-lockups under really heavy stress
> > load.
> > 
> > I prefer to keep them so far for consistency. I need some time to
> > investigate it more. As i noted in commit message, the vmalloc()
> > path only has those two resched points. Probably i need to move
> > them into another place later.
> > 
> > As for page-allocator, it is in a slow path which i do not hit in
> > my stress-setup.
> 
> OK, so the fast path can trigger the soft lockup? If yes please mention
> that in the changelog so that we know why this is needed. With that
> included feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
We, in vmalloc(), also have a slow path. Those two points seem to help.
I will move them later to alloc_vmal_area(), after a slow path serves
a request.

Thank you!

--
Uladzislau Rezki

