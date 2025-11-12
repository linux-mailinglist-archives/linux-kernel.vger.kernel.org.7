Return-Path: <linux-kernel+bounces-896530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C388C50987
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BAB3B2D17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB92D73B9;
	Wed, 12 Nov 2025 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgpcX++O"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D51F09B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924588; cv=none; b=GvHAVB1LOqI9m/iOHgyrtT/43hPlr59Y9GCWVBqnaaSt9hTKuixuSwZcN2/CbKEYG0fbgTNE+eRriXHA17J/5+ThDO4F7HutaaS3yHqP4S5d76IQUvoIwIXjsnFad6gkr07rEPChGGzsffu9eumI60/DGaXxWjpb3r4QIYyKBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924588; c=relaxed/simple;
	bh=2ES5D8Lrz7NcCBiuzlnwPnPLQqDtrbT6pR/t3DnoUvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmoIFeRUzqM/uuwdrShh8kAB4p1b9X0kd0LdlHXA1Gl9K3hmxVo3/31MgeuCMwUqhy4CsrZQfmoIG/33B4+5+PAtKTFxgAlftb6jFB6rhh4k14ffTru0RtuepF7mrxB8K3BVK++tr6VIaeEhjIu0iYmrSUHNxfnfceCYIQm3dYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dgpcX++O; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso319469a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762924586; x=1763529386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhp9WztXVzcfj91SAG1PnTJUC4+cBVLBbRZgiqHWwK0=;
        b=dgpcX++Ol426P9wsRqB9R1pMCECbVVjtokfYMt99kg1gZJYzAHABSWv/u5U/LuhpLd
         Cwi32hPzc2EjQPLJMnWQTALlOGCohV4UGfdG407Et6dRh0JYUBILQnC0nE9Jo4ipPxs1
         nk+x7RGm8Gq7EnV5m2lUxibp2zeA0N0BrIFYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762924586; x=1763529386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhp9WztXVzcfj91SAG1PnTJUC4+cBVLBbRZgiqHWwK0=;
        b=ikLDiZ0bfGdbzxXAlv0UbPYHdw2pFJMACvODPA1dDg4+sD+E7jV6fmmJm9dvMN5p/+
         /N67gkCrmqk33zjQlXpsFyHHWQvu6rKnZmyTfSWwp34h9gVpua83FStbT+NcxIaTlPIm
         8LnNdfOA6UFO8AGw+M3a8jDHXEUSs5HifTdwZidQ0hRyZO0bT79Ky7ebbIwwJQ8sjqr6
         ijuPr0sXZF45arROL5oAt2cVByZi9Gn7RKOtA0Jtoyrf9JaV2FxhP46/5lXG+fZq/vqw
         9MANC3Nei6vllvE8UQGwe4yFEkbEv/x2VaFZCoNXTD6jkCGhWQKLY9gRn/VCAjdeuVRB
         Ex5g==
X-Forwarded-Encrypted: i=1; AJvYcCWoScpf4zfrIsHfgHN/95sQCoAdYiZKM0PGot7BwX97iNLNDvxtjmCJ7YBCdprnBYCEpEwa/rcZCNABkUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzazto1gd6Jt7exiS25hErs/cmCHl+RVJnI+lE1EJw3YzlbIFu+
	yO157abkuvajpp3xg2e5rLDuOUlbfusqzZ2fijN4gYxU2OU/LTHXd61/a2u36k+VYvPaqFIQ2el
	9Lv6bhA==
X-Gm-Gg: ASbGncvZIQKhWstf0cjEYlL644QnlzBpWcfil3I08nt6Ab7xco8OxBCmwukP0ivlRBL
	5/e7/x/u6iK7INE4MiIHlr9K+Tsmq7zy1ZeHtvE38iE9hpE3a8SnWUtM3rwo8uhT3NF+Dw2Nda5
	0XAhnL3BiYU8050MEyBHGeUGgWd3xK7eLnYkBaTc1nAU55UpDbtaSApT9Z/R3IVCjtRpfurrbaq
	xiIvOQ/HbXsLoLhGtxZbKQ0KDzk7StdKv8M8T8KVjvrolQ5nez6/y23uJYxv8R/9GJ/k1zjYeQ1
	Tq5QHJjAW/ZCd7Ll8XlqPMlrD7ewSuuKoDOoEqnWf2CkB3eWtp3n3tAuOmzar3ec1mn3eFU6t3z
	oHbl9mwq64vQ4gY2D4ymjcA7z4ea7ay9/VH4Y59oylm1HjVB/0eHfPZWJlM+21wB/MzKV9+2Pj9
	kjwt3v
X-Google-Smtp-Source: AGHT+IFho98A44dYQmBzRJFEzURybon+j1FaW7jn0iPAop/8QKKhvf7Z8/ur2Ft8vMS29vyNafxipQ==
X-Received: by 2002:a17:903:22d2:b0:295:7f1d:b02d with SMTP id d9443c01a7336-2984ed496ccmr24732195ad.22.1762924586274;
        Tue, 11 Nov 2025 21:16:26 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca17ffsm15788105ad.71.2025.11.11.21.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 21:16:25 -0800 (PST)
Date: Wed, 12 Nov 2025 14:16:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, axboe@kernel.dk, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, 
	richardycc@google.com
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <3enjvepoexpm567kfyz3bxwr4md7xvsrehgt4hoc54pynuhisu@75nxt6b5cmkb>
References: <yv2ktkwwu3hadzkw6wb4inqzihndfpwb42svuu25ngmn6eb7c4@hclvcrnsmvvk>
 <tencent_B2DC37E3A2AED0E7F179365FCB5D82455B08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B2DC37E3A2AED0E7F179365FCB5D82455B08@qq.com>

On (25/11/10 15:16), Yuwen Chen wrote:
> On 10 Nov 2025 13:49:26 +0900, Sergey Senozhatsky wrote:
> > As a side note:
> > You almost never do sequential writes to the backing device. The
> > thing is, e.g. when zram is used as swap, page faults happen randomly
> > and free up (slot-free) random page-size chunks (so random bits in
> > zram->bitmap become clear), which then get overwritten (zram simply
> > picks the first available bit from zram->bitmap) during next writeback.
> > There is nothing sequential about that, in systems with sufficiently
> > large uptime and sufficiently frequent writeback/readback events
> > writeback bitmap becomes sparse, which results in random IO, so your
> > test tests an ideal case that almost never happens in practice.
> 
> Thank you very much for your reply.
> As you mentioned, the current test data was measured under the condition
> that all writes were sequential writes. In a normal user environment,
> there are a large number of random writes. However, the multiple
> concurrent submissions implemented in this submission still have performance
> advantages for storage devices. I artificially created the worst - case
> scenario (all writes are random writes) with the following code:
> 
> for (int i = 0; i < nr_pages; i++)
>     alloc_block_bdev(zram);
> 
> for (int i = 0; i < nr_pages; i += 2)
>     free_block_bdev(zram, i);

Well, technically, I guess that's not the worst case.  The worst case
is when writeback races with page-faults/slot-free events, which happen
on opposite sides of the writeback device and which clear ->bitmap bits
on the opposite sides, so for writeback you alternate all the time and
pick either head or tail slots (->bitmap bits).  But you don't need to
test it, it's just a note.

The thing that I'm curious about is why does it help for flash storage?
It's not a spinning disk, where seek times dominate the IO time.

> On the physical machine, the measured data is as follows:
> before modification:
> real	0m0.624s
> user	0m0.000s
> sys	0m0.347s
> 
> real	0m0.663s
> user	0m0.001s
> sys	0m0.354s
> 
> real	0m0.635s
> user	0m0.000s
> sys	0m0.335s
> 
> after modification:
> real	0m0.340s
> user	0m0.000s
> sys	0m0.239s
> 
> real	0m0.326s
> user	0m0.000s
> sys	0m0.230s
> 
> real	0m0.313s
> user	0m0.000s
> sys	0m0.223s

Thanks for testing.

My next question is: what problem do you solve with this?  I mean,
do you use it production (somewhere).  If so, do you have a rough
number of how many MiBs you writeback and how often, and what's the
performance impact of this patch.  Again, if you use it in production.

