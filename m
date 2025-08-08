Return-Path: <linux-kernel+bounces-760071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207CB1E623
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBDD7203F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112326CE08;
	Fri,  8 Aug 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgcelrCS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB74188A0C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647730; cv=none; b=Q1V42ybiBzKOh4ZZ3pELgBp9i4pJNhNktDG1j+hZhlmEGxC2xfcMH7/YRZwLMMatqwnkUi7c25B2G12zReFmLseNGX932tWDOD/D1I0pTbKeJOzYmiRJ/JnGFAVClybwh0D+k5ZGRmpRlQI8OqrZXLRiwOKrSVVUqhaiwCmUupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647730; c=relaxed/simple;
	bh=g6rZ2YFkfGDuFwp/K6kGjVvQIuwMBg6U4uuF2Ge9e7w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuPdS8YCraba8xa2UYRG9fsDzdSjaOHrGziLHaWQPmi5Cmz4DbgfDWrrplxY30mV6M0Sx1wH9X2tosJMBgdhIIu+dIEBwhk/UrhV9jXavcEc4/KR1tas50fe5e9rxfPNMQouI4pmJ0LvTjYkTb3p8IHy2NNj7/tF6YDngRB0nWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgcelrCS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b827aba01so1867633e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754647726; x=1755252526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbxY0Jg1r6x7C+hh+rgf9m7gK/9hiurboFkbpVtd5c0=;
        b=dgcelrCSt9iBB1I5TK0Tgr6CRMDQBfZk1uKpVXplxtwqrBV7y/tLtsCUj56sG5jJI4
         tjw6sELPd9ASKTMmDTfQrKWmoNskGKyNEXPwzgW2Gpnl4dSlXsO4miY7uNMKBog6TFwN
         LVCE1p5IhSz/R+Ec2fFV3cdSk72Lxrgz/RCn8JwjxWLzwNmHyio0UJ+dqxrzAPhaA63U
         MNcpxXHBtv3tX0tDs1rveTFt8eZPFNWzCwCJbO757VnXwtSCUxtYc/eo8A7hHnJQOZAF
         DpRMS4pch2T2yDS+ztbdMDw7HYkr5tz8AAHVFvP+3fZUQbhc9kIY8l1yotMqrFE26crh
         MD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647726; x=1755252526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbxY0Jg1r6x7C+hh+rgf9m7gK/9hiurboFkbpVtd5c0=;
        b=A1RuV8q8Udrwr8Qq1UJC9M/38pXrxa1CCIxsbPmnliUo9ykq/dJ7XOODKe9ogPw6lE
         lv352YfSRvppHJuIWbzupEqnyBLDBk3liVNgoJG5MRsSfscabhDfCrFn2zA3R0O7qG61
         ta/MeYk4LQ+nmIPZcP3arfFd5htqSSKz8myL19zbJ1y32RhJZRJpOopA+xlQv2sf1gGf
         5raq9vfSPPyLhlTpK06xZXMZz5UKHI/jHroEvO8EudYkmRUBNWjwIHNwjae330kMuSTw
         RP1WO6/n8Za0H57U4AcsReDJZF6IUzHNUrL9Q76tbL3q9xkMobGuJy1FLkecGX2Y0QYo
         gPew==
X-Forwarded-Encrypted: i=1; AJvYcCUU4R+HFXEQ214+7YzUKkTgfHMBzoB3bQufpV/NexdPn+xAL62GFPqEZlWwu1XqdOUwJtkm/btY53+oK78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDpPPQ1N7W1/uv4bw6CXWHCbP8zbtUqv4nveMZxnuOcxUH9nl
	AI5+NnSkyUyLnqah1qmMf71g26la69sWaJ42+StO0gjhyM/LnlGT5K4t
X-Gm-Gg: ASbGnct9tUgpcWMQjiwWuZ140URaU8qGNsjOQEMKP8FtMHU11XbNVgTqgvLuaIxpTmE
	c3vq0OSND2jCk5tPGJkFLvtb+pLaG2Gs0UY1PtbvBJYbbzo+J0tFETESTlBJI5QsLti0GtHSXqy
	c6x2GBcEFy4w+/CeIS8GuuMwJGkiaUf6R60+oW5sobl7YqEiP7O05ecRNCiZf/XD9CwQYbrp3/N
	asVXZycPLcx5d/5Iw6+acBwmMKdgiCR7pLKorrYvjYL4U7kBmgIIAUWxwVTb3QEW/FCsNM28y+X
	+AM2rtgN7HOipyItx57UPftQWf5axwx+XgFcH0rLKDUrNYLNgaRONYiHkbsFNWwgBHA+CiB/KDS
	rb3bhq4nyKuxKDVvpz4xv4F2IrA8PQbkIdjYmymrBqpG9IYY2ww==
X-Google-Smtp-Source: AGHT+IER+HryXfx9J3vMYmF3WW1vWe9m9Xz7yhLgRj00Ua6ih0RT29yWBMSZcOV/UCV8juhmCPA/uw==
X-Received: by 2002:a05:6512:2210:b0:55b:861a:d2cb with SMTP id 2adb3069b0e04-55cc00da448mr500044e87.21.1754647726257;
        Fri, 08 Aug 2025 03:08:46 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98ab8sm2960265e87.79.2025.08.08.03.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:08:44 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 12:08:42 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] mm/vmalloc: Remove cond_resched() in
 vm_area_alloc_pages()
Message-ID: <aJXMqrVCcdLBsMGp@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-5-urezki@gmail.com>
 <aJSMfJhBOltRiSUh@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSMfJhBOltRiSUh@tiehlicka>

On Thu, Aug 07, 2025 at 01:22:36PM +0200, Michal Hocko wrote:
> On Thu 07-08-25 09:58:06, Uladzislau Rezki wrote:
> > The vm_area_alloc_pages() function uses cond_resched() to yield the
> > CPU during potentially long-running loops. However, these loops are
> > not considered long-running under normal conditions.
> 
> To be more precise they can take long if they dive into the page
> allocator but that already involves cond_rescheds where appropriate so
> these are not needed in fact.
> 
> > In non-blocking
> > contexts, calling cond_resched() is inappropriate also.
> > 
> > Remove these calls to ensure correctness for blocking/non-blocking
> > contexts. This also simplifies the code path. In fact, a slow path
> > of page allocator already includes reschedule points to mitigate
> > latency.
> > 
> > This patch was tested for !CONFIG_PREEMPT kernel and with large
> > allocation chunks(~1GB), without triggering any "BUG: soft lockup"
> > warnings.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
>
Updated the commit message. Right, it can take long time.

Thank you!

--
Uladzislau Rezki

