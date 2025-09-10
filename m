Return-Path: <linux-kernel+bounces-809872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F58B51309
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BDA5610DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EA31197B;
	Wed, 10 Sep 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19cAUI34"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7C3164A4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497513; cv=none; b=rEf1qjLhAGeJl3MnSZgFUD0iFvEMHgEpFqL8VE6+jmlZk9mIJMlTJW+ytO6+9pL3gcNDe5iOhZZSQ0LaOP82UjUncoLXAT4AXiN82my6Ni8iinSRgyIjgusNtpBcCDpGLN0fXFiOZ3WowsG7EE1FVfKAB3lMBTHUEGdiZ+7KFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497513; c=relaxed/simple;
	bh=GCwe8Dko3jDOXji8AdD72nwYCErq8l4yfDoJj7Gnt6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFUV8k0tLALtn5FQ3vzutNfQF3tRvkyvKv8kZlwkjNGhFO9UsHtNcwwTt8blJiMVJDXdX/bkjURuNatv1z9mFyxyVpfPDuuFemP4QcbFZY/vQK4RBoVjmVddNgHNhMBa4MjGGlCdCCrpfLHS+kLWc3LNIutEpc/sFFQhMYBxSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19cAUI34; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso15535925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757497509; x=1758102309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1kBDy0sA3BYfIdWlr+hjUo0vDal9CsK0/fCdjzti6o=;
        b=19cAUI34sfYJbTjYGCPpJRZggcSidg2jKJyAfwr7F+ZoZW/Lw3KwWQ0bY09/mVtQ9w
         J62kIZ/tuB0k8gbnxeAUWphBf+O2khUq2WHWetIzKOaF/9yicq0NhPMngCcaLfjo5d2e
         P7BqpS6+509izV/NWbg8SSs2RpRrKkxKH20uCUGrvjI/NzxtjAeURVbL1r82lNJuuGzC
         6vuzcLe6q2NMkrOGjl52VML6yp+hbrAJrjfAHp9v07KPPSgL77T8dqg1e7U3Dpn5HRav
         gvMfgOueFK6H1mTGPTyQiSJqK6uyaWsjh7lzV9lHmOrI4Md825RoxNegkr2smqhdTTbI
         qPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497510; x=1758102310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1kBDy0sA3BYfIdWlr+hjUo0vDal9CsK0/fCdjzti6o=;
        b=DUo8HRp5j/tNfWRM9BIegYeGix41+Y5r+UFjQdzDQg8ZKk740v6GSwSHQTz5op25et
         YTUvhFWvPWM6NXlRfGl6ByO19VPjpxKRpI5wONqe/1FuFKsiss18womh5bM7IJUG95M6
         zUpfdzfY98I32ttm+mM9j8DP+G2LAgzNzMRAbSV+ZQOvEbCimLzHuUzPboOuTjiUPL4X
         URIEB7DRKm84aD3ko8h9svY5bi0EgflzJuOIyJUcObN74B9IAuP6/gDGQLM5z3tOmk6c
         Y6WvjFCl81cxsPECm2qmlAPfKGRJ2iQDd8Nu1v8nt0kgNPfnksX665+MuB2Va4W981dp
         xhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7rO/4XlIxVcbvFNNoiommhOFS3uuHuK3/tNtWdIOhUnHAwmc3eviP5dNKJC+w4k2Ywsur6aCrOgz2IUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnw/99KG+IYRi9Qc669woF7LL55mPICBPx48OH8Dzjoux/OygV
	A6rUkviHOwbJVfIAUewYzX4jUCsy2ixYalMjpK8WaPv9OtbKhDiYRLBd6qCq6X9RMg==
X-Gm-Gg: ASbGncuGQQhv9UbXzZrq1pkysxZ8jCqHniAtgDy45X/TvUKvx0ayx1kagU6CINuxuAw
	B+AFXiAXbeJ0v36Dxh1uJqayge8lIRNnkWw2uKhrXdciOMLFGhqk4DDeXIPclmsRH3t6B7JHISF
	Ba59t/clmnlpN5WCgLxBXLiQyWSeko/yIAoolXr5KBByOLdOps9N1bwC4vTAJA4zbbml0ZixVXZ
	hz0wgT1IzB7dA6NUmhJdVuuw+Ly3IX6lLilZGBEl20zOlMRUjThSCmPviL2vVaJHWYw9QkIa+Xm
	/hAJ8VckVbcIS2Sdl6S+YQnRORBxkV8zXpcTvZBbPbzoAYyI27g2uC9founcwHoQmcggop2hYF7
	h5BPSRrcvUr+YjLR+ksnzkqKz2OQgmG+Sv9qtDNo35jfVhR9F2pjHyOv3SFEJkhdhlQ2MwRKFVP
	z1lTcx
X-Google-Smtp-Source: AGHT+IENXjSZ9eYxIcTPb1KA8MslU7Gkmmzo6eN91GvxyARG/yRPq8gJbKV+SVFiPMHX+dA+S+OktA==
X-Received: by 2002:a05:600c:3b1d:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-45dddeba3e5mr124414255e9.14.1757497509275;
        Wed, 10 Sep 2025 02:45:09 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7532f90e6sm5750475f8f.6.2025.09.10.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:45:08 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:45:05 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/24] tracing: Add reset to trace remotes
Message-ID: <aMFIoY5yfQa2Mzgk@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-5-vdonnefort@google.com>
 <20250908193757.079aae76@gandalf.local.home>
 <aMAZMaZJ1_Eny5Ku@google.com>
 <20250909094028.3265b751@gandalf.local.home>
 <aMBSa29ev0BNgr5R@google.com>
 <20250909143948.420bfb1c@gandalf.local.home>
 <20250909145236.69192cd0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909145236.69192cd0@gandalf.local.home>

On Tue, Sep 09, 2025 at 02:52:36PM -0400, Steven Rostedt wrote:
> On Tue, 9 Sep 2025 14:39:48 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > But anyway, I think it should work for the remote buffers too. Let me go
> > and fix the current iterator.
> 
> I thought it was broken but it isn't ;-) I did it properly, I just didn't
> look deep enough.
> 
> So yeah, look at the rb_iter_head_event() code. The ring buffer iterator
> has a copy of the event. It has:
> 
> 	if ((iter->head + length) > commit || length > iter->event_size)
> 		/* Writer corrupted the read? */
> 		goto reset;
> 
> 	memcpy(iter->event, event, length);
> 	/*
> 	 * If the page stamp is still the same after this rmb() then the
> 	 * event was safely copied without the writer entering the page.
> 	 */
> 	smp_rmb();
> 
> 	/* Make sure the page didn't change since we read this */
> 	if (iter->page_stamp != iter_head_page->page->time_stamp ||
> 	    commit > rb_page_commit(iter_head_page))
> 		goto reset;
> 
> It first checks before copying that the data it's about to copy hasn't been
> touched by the writer.
> 
> It then copies the event into the iter->event temp buffer.
> 
> Then it checks again that the data hasn't been touched. If it has, then
> consider the data corrupt and end the iteration. This is how the "trace"
> file works. I believe you could do the same for the remote code.
> 
> If we are gonna keep the "trace" file, let's make sure it's fully
> implemented.

I was more worry about the ring-buffer page order that can be reshuffled on each
swap_reader_page(), making the page links useless in the kernel. Ideally, the
meta-page would keep the page ID order somewhere.

Alternatively, we could walk all the buffer pages to read the timestamp and
re-create the order but that sounds quite cumbersome.

> 
> -- Steve

