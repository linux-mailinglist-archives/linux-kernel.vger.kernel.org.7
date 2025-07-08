Return-Path: <linux-kernel+bounces-721170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A268BAFC5A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776DC163BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330172BDC0A;
	Tue,  8 Jul 2025 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe3wdbQz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAD298261
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963395; cv=none; b=OMufnw4B2D8PyE+w1Lb+O0mD0+AKMR4+imcSbYOLZ0vKOfVOOajbS6WC7IGAZQBGXMcxHD5DAYyCKoio4CVdCuqMWonw8KcUNH3/j6tW2OLIEBQXrAVAOb9BRYElC0GC31jFX8WuQp7hufm8vve12/HwoGQp06IBVcs1885KeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963395; c=relaxed/simple;
	bh=f8b1mOQrjU5xSQhRUkpVtokgQw+ohhQEGyqThwLIRQM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVi8DNQN8ARCGylR6hbSa7Znj2qj5MtejQdBL4VaiJCzdvISvBDT+n6YTRIiIhMqKbV2YrcBqylRD/+HXGCUl+ShgtwRXCRforcXcTZtxezGdemJHewaIYND6uMdTeLO5i9oFnPZxNTBa5zkn9vUaQ2JkfXXnA/bN7IFRzLqGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe3wdbQz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553dceb342aso3579919e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751963392; x=1752568192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIMqnAPkWP+ME93BihsuuKLeNX+DuHUXURXep46K9K8=;
        b=Xe3wdbQzUnpNxgSF52W9GneZGR3Q32PcanXZHhynYCZtRu8ZcSeEjEm1FkDCcQFd+l
         YwYaz2ryF0BjXqf4hpXqC4wkf1vESF0aWhP3gG0Sp3YlCA9bfOWj3zz9fndI2KN0cPAd
         J4i43DaOhWR17NTz4qKqw2TS4SZWepRXBNMAfM1oGJ8d3wYxpXgXuazetuaULVMAuyO8
         5iPWzay3fSz9iAxngmZTKGxvBgLJHQlWqE4ttVRwvZIigvwNRrdK5YWR/RN9q235Elz0
         Ax30IBKzV3lAnJhQiSRU/vZzSKS0Aoqfv0zhwn1aQBs1qKwLo2BKG6+dqgtO05qAExQr
         j0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963392; x=1752568192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIMqnAPkWP+ME93BihsuuKLeNX+DuHUXURXep46K9K8=;
        b=npepdxap9aCXOtDnpxf/eMPmuzRBi1jNNj+A+ujd9LR6NQEKFxAbGv8YEUaqnlZhB/
         9VEdek8LMjrpoLlsIZAwxyc1GzbHiLAovHE2TEVVZQ3PvicZjYRbCy4H52BFBejxsO4E
         +67qhQIsdnRRvEdFBU5pg8onbEbcRYJLDtCkwCDUHT4CRlcsZBijvz5RqBYTNXWFwGoh
         MGcxU07HbklgH0qhboXRkB+uA0DCmYWBLtnIu0MU9tj0J/T/exl8DHwEvpKBgSRD7dKa
         urS1I+ntZ1etsvn8Cw1zsYalrH6uKRV0RyJShPHRdKr4DfveZBclksSc+fomUKcIG2ch
         lcOw==
X-Forwarded-Encrypted: i=1; AJvYcCXtPQR1UmI0dXoyh47eFU42NNgTCY3YMpvaEJG2Ci0Oc/owZZge4SaP4FSnwIEdi0jfqSI4x3lIRHgIU04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5grdY5GOW3jIlFAY1ezNWSz451T6BviLKSbRm6vQHAYdhubol
	DjaW8Ed9S1/RyhXkR+q8MPh4Us310UhmUjYWkPSXMkOgyRGUknHFLmJL
X-Gm-Gg: ASbGncvuRDx5xhPw0LjvZyxlTluiuq6KlGCJpRwfWwJ5D0TL3VaaKdsWREuElfT0vf1
	9GcUFd5HD+1xrvgZJ0Z2hahS2vTAFRyPuLZGKkX254rEBP4XOg/+txjpKdXptC7Zbiqtv5jXWr2
	iVbreNhEAc2QaszxJ2hpHo+Edwtx/mqKc1td1Ievz9/CSjxIkPujY3RfOy9Yu8ssXave5hAAySa
	TX3m3Hx7Y56j7MoBtTa85yf1rhcXwjYZUWB4GJuiSItg21PIRRGUy62gP2QFAvcnwREjQZdSjaA
	ZP2oM78pPlfIyC9odrWSxfI4O14q
X-Google-Smtp-Source: AGHT+IHAkjYUgvYuREFNuq1/uzTXv+D++CYIo1Q29V9d8H1P758gISwkZGPcfy2i2YvTvYmUKB0xcA==
X-Received: by 2002:a05:6512:3b9d:b0:553:a5e0:719c with SMTP id 2adb3069b0e04-556f2758357mr4399346e87.51.1751963391837;
        Tue, 08 Jul 2025 01:29:51 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383bb6eesm1602893e87.3.2025.07.08.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:29:51 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Jul 2025 10:29:49 +0200
To: Adrian Huang12 <ahuang12@lenovo.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [External] [RFC 1/7] lib/test_vmalloc: Add non-block-alloc-test
 case
Message-ID: <aGzW_dyANoI26qxQ@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-2-urezki@gmail.com>
 <TPZP295MB00136CCFA28CEAAF7E11B840B34EA@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TPZP295MB00136CCFA28CEAAF7E11B840B34EA@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>

Hello, Adrian!

> 
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf
> > Of Uladzislau Rezki (Sony)
> > Sent: Friday, July 4, 2025 11:26 PM
> > To: linux-mm@kvack.org; Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@kernel.org>; LKML
> > <linux-kernel@vger.kernel.org>; Baoquan He <bhe@redhat.com>; Uladzislau
> > Rezki <urezki@gmail.com>
> > Subject: [External] [RFC 1/7] lib/test_vmalloc: Add non-block-alloc-test case
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  lib/test_vmalloc.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c index
> > 1b0b59549aaf..9e3429dfe176 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -54,6 +54,7 @@ __param(int, run_test_mask, INT_MAX,
> >  		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
> >  		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> >  		"\t\tid: 1024, name: vm_map_ram_test\n"
> > +		"\t\tid: 2048, name: no_block_alloc_test\n"
> >  		/* Add a new test case description here. */  );
> > 
> > @@ -283,6 +284,31 @@ static int fix_size_alloc_test(void)
> >  	return 0;
> >  }
> > 
> > +static DEFINE_SPINLOCK(no_block_alloc_lock);
> > +
> > +static int no_block_alloc_test(void)
> > +{
> > +	void *ptr;
> > +	u8 rnd;
> > +	int i;
> > +
> > +	for (i = 0; i < test_loop_count; i++) {
> > +		rnd = get_random_u8();
> > +
> > +		spin_lock(&no_block_alloc_lock);
> 
> Since there is no shared data to be protected, do we need this lock for serialization? Any concerns?
> 
> It spent 18 minutes for this test (256-core server):
>   # time modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x800
>   real    18m6.099s
>   user    0m0.002s
>   sys     0m4.555s
> 
> Without the lock, it spent 41 seconds (Have run for 300+ tests without any failure: 256-core server):
>   # time modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x800
>   real    0m41.367s
>   user    0m0.003s
>   sys     0m5.758s
> 
> Would it be better to run this test concurrently? That said, it can also verify the scalability problem when the number of CPUs grow. 
> 
It was added just to track the sleep-in-atomic issues. We do not need
that spin-lock in fact. Instead we can just invoke
preempt_disable/enable() to simulate the context which is not allowed
to trigger any schedule(), i.e. sleeping.

--
Uladzislau Rezki

