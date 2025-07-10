Return-Path: <linux-kernel+bounces-726184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A9B00925
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459B41BC70E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E477283CB1;
	Thu, 10 Jul 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEtRvr/C"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645512AE6D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166073; cv=none; b=sNom2zVVH8LhEp2Oci9H/L60iAll8RPZ5ZyAwybPFBzKED070uEkEm+KULSC0O4mHvG+pjWwqBY9BLyDo/pVwy++KlWOedLSWcyTrdy1+knaDwnhCqm/uZFIJjof5jMjHixycQQebP4FA2kSfxsINbrBJk5CpvPqwKR55x6F2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166073; c=relaxed/simple;
	bh=DQARo83LmNA18h2BbWwsm52cgl5TR9UUBYypToAbzI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GciFGjg5cAQvFjmcblUpc5DsfGopl5oA1XV8e7j+XhjhIL9rxOJ+aufQovRBoK3l5Y09Xq9Vz0/PdmkIQsPASh6hnQRw1xnBeKC0GrQHr7Aba9cddUdj7u/f4e0dOR1qhtmLxdf0SJQnkmTGfwIE++eqXM6ACrO/cl4UcTdx7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEtRvr/C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1976728a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752166070; x=1752770870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHZkcMH8sx/R9026fsY2+waRIL29Zzed0fPveArD9LY=;
        b=lEtRvr/CX2Q/WB7rNUAjk9OQ0+lhBIrgRwqZQwAQzfmPAvjqeXjVSC4c7YEXgO9Lal
         wbnZfO/1z20fDU0QfHteHAS1EpFO5mVuG9VT9SQVQ4hgiuhTXik8QYaDuwbSIFxrGfdi
         IDBMoYWOCM4YJhmkUYzuzEkLFNlexkDFUSSVs2Tq0P8Fc7ubRjjeDYAXqvLs5kuZZ338
         KsUjIl1mN8RR1/9PZHytdt5DelNQsFzgH/KpmbJlIFYpHionXTdrgeQi+OUIXN563FNg
         Tu+u9GiA46JurpX9OFeTROVczV/HcYuqWAcThyxIe70QsPlNl2T8eDcaCTKx081j7Ljg
         30sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166070; x=1752770870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHZkcMH8sx/R9026fsY2+waRIL29Zzed0fPveArD9LY=;
        b=Yz5CIS3Q1Wi7kcbL2dzlx977gWB0tGasGhrOQYFiCTUAr6i3PtahPwCbDA/LFAUoZL
         fC9KR7YDWCfumxt172EeV+DcA3gMlYoKxdIUz22f5Qp2ZdxxPr+JkE0JZEBDtc4oE6yT
         EQ+lR4ScFcRzJDuxkiGqTTRDGvSa+phGyHOlQkOJr+P2qe6/IArdOBpIm8mcjnIV1ezD
         XYMXBQLk9OHoVvrBY/w9WRNIH26tohdTXTNfLqSyXPLqwiYFvR1UuR9U8rh3JkwEGzcy
         9L58XezPPeY3kIaJHKAwsC8mOob+Dqqp9Ljh009MsCEdhVJAB/sn8B/9zjl8O3ZgYx6W
         Qudg==
X-Forwarded-Encrypted: i=1; AJvYcCVOppYqxzeMnbMu2V83OCrUEI6ySPKk/yPBGFa00BPbLo9tGe/ciDTJ2JTytmNsieKrr9Z/RL7iUWbu6UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCe0KEilfCj6jpmpDnjylFOA/50xfOijGZ+J9t3YcC1KLWx7T
	yiZDUuR2HRhzBOrR1lD7q7KyVYpWwnEIed4KFbDekYGDO3HoCjwfSxY=
X-Gm-Gg: ASbGncuwnQd30Q5TsxBASaGubSyiW/YisI+bvxlk9qNNHAiWc7DFF88PPo25PGpQlvI
	Trla+kMDxZPrEairalNcWFOEYWIoaxYJRECrqU1etDw7EKw6r+z6cACZMlQbVHX3MLkTi937+6Y
	r7Yo5HoYb04+lSwuy/nhbKaNyJVozUeMeybW1mcLBCTwn/obK1Q+FlB2BWpSR+yDNwCggpZOp2n
	iv9aL4Qbz4p/PjUc94sLiwBQZObOJ1T8z7UARvBD6wOPFKpqthq+ltR94jW5mgDel1GEF7RITyN
	xrz2X1xnmivmnycCwynXgW1EHySdRBJj8vx+StKchv9BJub6hA==
X-Google-Smtp-Source: AGHT+IFeQ0EEDo9OEyw10afKr5xDHTkATv5cOqD4U9bmNYvhHmx7imSEI5Q0A+I4BU2nWojpsDj/Tw==
X-Received: by 2002:a17:907:3e8e:b0:ae3:66ff:f922 with SMTP id a640c23a62f3a-ae6e713f6camr343713366b.50.1752166069492;
        Thu, 10 Jul 2025 09:47:49 -0700 (PDT)
Received: from p183 ([46.53.250.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264663sm157214966b.87.2025.07.10.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:47:49 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:47:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <1e49cfaf-4669-4b59-afdb-cc872dbcc950@p183>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
 <df9c25ac-c290-4c65-ac70-729cddf2aee4@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df9c25ac-c290-4c65-ac70-729cddf2aee4@suse.cz>

On Thu, Jul 10, 2025 at 09:35:41AM +0200, Vlastimil Babka wrote:
> On 7/9/25 20:10, Alexey Dobriyan wrote:
> > Implement
> > 
> > 	memory.oops_if_bad_pte=1
> > 
> > boot option which oopses the machine instead of dreadful
> > 
> > 	BUG: Bad page map in process
> > 
> > message.
> > 
> > This is intended
> > for people who want to panic at the slightest provocation and
> > for people who ruled out hardware problems which in turn means that
> > delaying vmcore collection is counter-productive.
> > 
> > Linux doesn't (never?) panicked on PTE corruption and even implemented
> > ratelimited version of the message meaning it can go for minutes and
> > even hours without anyone noticing which is exactly the opposite of what
> > should be done to facilitate debugging.
> > 
> > Not enabled by default.
> > 
> > Not advertised.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Could we just reuse the existing panic_on_oops? Would anyone want to panic
> in this particular without the others, or vice versa?

Yes, it is supposed to be used with panic_on_oops=1, otherwise lot of
innocent processes might die.

I'll rerhrase the comment.

> > +/*
> > + * Oops instead of printing "Bad page map in process" message and
> > + * trying to continue.
> > + */
> > +static bool oops_if_bad_pte __ro_after_init = false;
> > +module_param(oops_if_bad_pte, bool, 0444);
> > +
> >  /*
> >   * This function is called to print an error when a bad pte
> >   * is found. For example, we might have a PFN-mapped pte in
> > @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
> >  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> >  			  pte_t pte, struct page *page)
> >  {
> > +	/*
> > +	 * This line is a formality to collect vmcore ASAP. Real bug
> > +	 * (hardware or software) happened earlier, current registers and
> > +	 * backtrace aren't interesting.
> > +	 */
> > +	BUG_ON(oops_if_bad_pte);

