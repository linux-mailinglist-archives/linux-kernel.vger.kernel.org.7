Return-Path: <linux-kernel+bounces-742466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F2B0F202
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935991C267D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7972E5B10;
	Wed, 23 Jul 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc8kElme"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78322E5B0E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272823; cv=none; b=igPhUEiGukW9De7JKxAx6YPXjtgS4LFq5wSq9tZ4IsYsh6J2vLd8tqS8vRhX9cz5/nsie2XxAJylJ8qDBYhMzcUN833KTMMYoUi4pvvuvOrbZNHOIJl4T2xGqOS+s2DJvr4XhWJF09Gm2/zVjPPierMgV0jrXwdYBFcOxmuW8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272823; c=relaxed/simple;
	bh=aForeX81ulBt1NwI+Vee+Ra/gfDdqthVsLYHjg1huzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsdb8ARYbKTTatEc+MgXCjtqUBHAWXuSsIhyMMASaG5h//2KgU0z77rPtLWGDsywpa+e7t3sA4S7qEoTGhzvUHd8X5nve2Z8B2ixnLdQdF2B96SRNL+HZ7A7HFi6TNHvaaRcQQvNB4rlNZ4UxJcCdNBoSNdtpq6lwLKe1WxdFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc8kElme; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e62a1cbf81so107356885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272821; x=1753877621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oDVKbfuzPoXEblaJbPogbvJRy/J8YBAAFt6Mi5hOyU=;
        b=Qc8kElmeDArRevBGQ3fIsfdU3s7tHZ977N7BbbySja6uGS17eVwK0p+ZsG8hhLj8//
         Uh3XtwvMA3roFZpbp5vNEpTRGxLjY3NkExVdfEFMYCeUbdlle+X+terAVOUivfLDlvsY
         WNsgBbpk/awfjMn7ilKPvmCKymAnYzKZ3p65xeU6rJTR2h9hMd2OXOOrxAFIDtcK/Son
         goCF3SJNZA3atfdjICj7wYTePkuQ64y7zIuPdeo3PcF3pCBwhOMltDULxyCS0Ml9cL95
         EosZ0z2fNxAjq3rAsWUniI9BxkXrZEKYzu0Y1z2NsNWQ/6DM5a3zFA9f2/CVHn61jswH
         VMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272821; x=1753877621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oDVKbfuzPoXEblaJbPogbvJRy/J8YBAAFt6Mi5hOyU=;
        b=F3hYVjDRk7jo+ag0nw2IsYISGlFAfPLYKdbHrTtrEEseBTW6i201RQCpYN6tTacdPY
         cx0jz14EjSM+GNP1fwL/OHYgxAzc3q+1N85wLasaMNUgIgWxT/Fwl5j/GqE3Yu2UB+Yv
         3L0iBMT5aQYcW+yYcISIcvT/8xnDZ8ZHkJp5hSRueqB05rBB4nNGt2x6yQkNxl7drnz3
         lCQY5peBCYu86n305Q187nJWSdJvrGzWpLzj1A/UFX6kmMVAT+n2A2L7/9zB5zENkqTD
         Z6yhYMI/wiitVUUUUhFNnxL4NVD1+MB372wbgYAPXO4buMLn89S7X8z6CfOZhXfsL0v/
         rXcg==
X-Forwarded-Encrypted: i=1; AJvYcCVbc9vmu9w7o7qxKKihJ3LGP48Jjm/PAFSUlEabmQKeFWWZN/cDnQyf9Vx9t27nsJeD6jghj70LEazUfG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlJhw0F5HR77N3OH3afv9QecdEzGGvjJcg0SrEcbRKx2Vj8hV
	XhAIvEp83ufaWYQZzw7MQ6Su3vfT7enI+A0MG5HFUI/i/JrgyoYud7uUu6HqMAE3
X-Gm-Gg: ASbGncvYdufqmtkD00CyTMeg8qZHkPWNwh8R7Fyp/DzY4kZo6OjkGCE+7PTbzIujc9A
	WCoMFGKfWKNiDGnp9A2oZL7gOuSEiyEbrDRXTDFYpr9LHAXBw28ZpUcWUqLsgeWF9bbxq6OwV8u
	uh3yN4V043I+QE+YCggD7wdc9uTggtQp9a9qbVwggIyIhIPb13+wqm70VIRxU7LOipOuu1hg+Rb
	Vm7mguJUUehBaU11gb3n/aISLumB0oJov5c7pUTBJLgbAcXGoMlsVWVLhy1O9QDoXKyRqEqyy/N
	7tjN+5fuu+VjEoFiCecdYTeHi+epeDtqQWKYC1Lw1XFyD252AoixAvDRlYzyk78hymoDND6+WxP
	gzOpWF8801Typel5d/w==
X-Google-Smtp-Source: AGHT+IEvRmYJQjM9zsdRjRuGkl5/4rLc5vedFqdmF6G17vimj/rMcxhyJAcG28c6I/7w6VVDK2TG4g==
X-Received: by 2002:a05:620a:2708:b0:7db:93f9:b031 with SMTP id af79cd13be357-7e62a0b2e66mr370412285a.17.1753272820486;
        Wed, 23 Jul 2025 05:13:40 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c3e36fsm639736285a.66.2025.07.23.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:13:40 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:18:03 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	robin.murphy@arm.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <xksn2q2mdvkb3fhgdbss4tm72agq7dlyvreuhh2x4v6fqxpvt3@jd3tqca2hyxv>
References: <20250722131117.2739-1-ImanDevel@gmail.com>
 <aH_RWQ_YqlydOkKH@willie-the-truck>
 <fvq3h4mbms64vzyqssy4xli2sudzpyimbacg74lkdgrzi77oqy@4yywt5fav7wi>
 <aIDN3pvUSG3rN4SW@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIDN3pvUSG3rN4SW@willie-the-truck>

On 25/07/23 12:56PM, Will Deacon wrote:
> On Wed, Jul 23, 2025 at 04:28:54AM -0400, Seyediman Seyedarab wrote:
> > On 25/07/22 06:58PM, Will Deacon wrote:
> > > On Tue, Jul 22, 2025 at 09:11:17AM -0400, Seyediman Seyedarab wrote:
> > > > snprintf returns the number of bytes that would have been written,
> > > > not the number actually written to the buffer. When accumulating
> > > > the byte count with the return value of snprintf, this can cause
> > > > the offset to exceed the actual buffer size if truncation occurs.
> > > > 
> > > > The byte count is passed to seq_puts() in latency_show_one() with-
> > > > out checking for truncation.
> > > > 
> > > > Replace snprintf with scnprintf, ensuring the buffer offset stays
> > > > within bound.
> > > > 
> > > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > > ---
> > > >  drivers/iommu/intel/perf.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> [...]
> 
> > > Should the check of the return value in latency_show_one() also be
> > > adjusted so that 'ret <= 0' is an error? I couldn't convince myself
> > > that the string in 'debug_buf' is always null-terminated if ret == 0.
> > > 
> > IMO, that's not necessary. 'bytes' can't be less than zero that's
> > for sure (AFAIK, scnprintf() doesn't have any case where it returns
> > a negative number).
> > As for being zero, in every scnprintf() call, 'size - bytes' would
> > have to be == 0. (or size > INT_MAX, but still you get zero, not a
> > negative number as an error)
> > 
> > In latency_show_one(), the 'size' is DEBUG_BUFFER_SIZE, and
> > 'bytes' in the first run is 0. So, 'size - bytes' == DEBUG_BUFFER_SIZE.
> > Since 'latency_counter_names' and 'latency_type_names' are arrays of
> > string literals, 'bytes' is guaranteed to be increased in the first
> > iteration, even if the rest become zero (which won't happen, since
> > they are smaller than DEBUG_BUFFER_SIZE).
> > 
> > So, the case of zero is impossible, unless you want a bulletproof
> > check for future implementations where the function might be rewritten.
> 
> Thanks, so that sounds like the error check in latency_show_one() is dead
> code in which case dmar_latency_snapshot() should just have a return type
> of 'void'?
> 
> Will

Well, there’s only one case where dmar_latency_snapshot() could go
wrong and return a negative number, and that's due to integer overflow.
It seems unlikely and probably out of reach, but increasing the number
of string literals might trigger it. So, I wouldn't say it's entirely
dead code. We can change it to 'if (unlikely(ret < 0))', or if it's
too out of reach I can send another patch to remove it and change
dmar_latency_snapshot()'s return type to void. (or a v2 including
both changes)

Seyediman

