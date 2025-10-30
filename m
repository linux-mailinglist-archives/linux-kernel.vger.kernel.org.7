Return-Path: <linux-kernel+bounces-878231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5FC20128
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D4064E17F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8033FE0D;
	Thu, 30 Oct 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QquZYOSQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EB1A23AC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828380; cv=none; b=Wg7szWKSR0O9OJnU6maZ06xE9n296gQvC8w+xMclay+3gWO3FzMt9pkv9SSJktmaOx+ISenFKmXIIoVzQUwlhvSrqWaphVY73kO3yBUC0pkYpuAQ7IheSQDUDnki+JIGvWNJe4k5elJr9iRLM0zLhdn7hiyESz7N/97blHMzuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828380; c=relaxed/simple;
	bh=+HeyH+uBEjWpGdKmwcRMviD1ZBOfa4A/QaKdR76xW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/N4h1Oa1wJNaPJc1Eo+FT+1AxgvesmYn/i4HQTXwHn32/E/7cVTMJ1BDV4aOlELRP9q2QEs3h6dvQV+LJHo09rTMl+yJsemAKKb+MuElxlXa+jkO8sQx9ANWz0+8ZT0ckeLOx+pxMI0dJ5cqakJjUXX8OfUz3jdPR+cx/1uHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QquZYOSQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294fb21b160so4726595ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761828378; x=1762433178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aywFaym5MviV8j+hBaTBsO7fPrPlzSx1wz2Rl5oeL3s=;
        b=QquZYOSQ4h6pjUKbEIsgeSvtsIU6RjhAE/juhSICYCryCnNcKFQl5hFqRrwWFaDelY
         WsVpiW4c/IvWNuha6xsFLfa4NiKxWFF0++aBYK43i3yK0qKIVns2sF3JfpU0zdNHz9qV
         h/+s3fe5qaSpgb795hN+lmbL40EeHk9jpvwhcBc2awMYtK9rshU3XSBHof/i60uISAVu
         LwAzV1nrhxHd+smPWlLUyFICD/ABf2688E8EWFpG9MU6EHjBwYCkiIynH0FGCyqflfNO
         rLl5y11E+EHwRSFs1FuGpeVKl1MbIKCZoc3hJAlU4GNPwftVf+hTZpTvZcMD1eGYtAYj
         t/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828378; x=1762433178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aywFaym5MviV8j+hBaTBsO7fPrPlzSx1wz2Rl5oeL3s=;
        b=IBFA5ChdPJzh8J1ccXwhAJrw/43/noSkhCVwU1jEtlxrcME68lMKrYxJelAAwzCU2q
         xbcoOLBUQV+QT4vhC/N11cZqdfRPnJnWpP7cqAGMFaRMEEqUrVbkkt+EqDpZ751dFfXW
         fn6JHnrHcTf/8T8pOaRCP1qX+ldEx66T82qCFAdXIvTzIWd6kXvq6PxkJbXtgIew349O
         APyJhQAk0HhCTcq3h7BUTrEN07JS2qFJ9mVv8U6WDcfh5V1t700FZbHmNJ/wX6Vtox3N
         WRFXc2CaM3TQ+Q7j1cUVh9T60R2tItFVSPbeEdBb93OsZ9CoQNPBBNxW2XGHU/1DmC6K
         5Yhw==
X-Forwarded-Encrypted: i=1; AJvYcCWH4tISg3/4P++US6MCiGoXBomqmrR0AMiBepIJtkZu2/MiOSTdbzC/h6sFF/2/wpV+qBOBDNSzj0O68uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5wSKioYzqJ84SU6gY+sDzX4F3dhRogd/eXAhwYttqvi5zthP
	BeQJK4R9wv4ngoK73IssZt9HGgWp2s/cimEgfsXoMKlxWHFt5Tw+fIdB
X-Gm-Gg: ASbGncuQa4+/hk+DvDEY7SINg0DeLHEFBGAY7wRlUOwnJEv+tQeG3ysG5HyjvZwi5BB
	rm9w9RXCOGMj8s6ilqpux/3gYGH3plDiWBj5YCtK1ncG3yF3SWfQt1Hf4t7QqK6bDo1YWlR6yXq
	ePVdc1lgzPTddbdynqdYKAcS1y40MpAZzflEOJFeYTdSNyZAWeSsndnPG0o7S+Sb6YPURaeJTbt
	UGp5bTGULfXCBIxTHLK/UyceOxme4316MZXSmoGrmCVlpc5vpEnfHcWrZ6uLGQC6GRsNy7jciGb
	Wz8d+EPhlJi94/hn5yZpXnPhnXx0W14fTTknZ1N5oQaXR5NOqbHLIr6cViHQiwYR7sfGvzacwwh
	huR1zaGsele6xO4bADABIqJMFmis8FxkPrZWpqwztAGPQEzhCHALUcYTVzTOKxFiRNXdA6sAEU1
	jSHWnOSj19JQjQwkGokQ7EoA==
X-Google-Smtp-Source: AGHT+IF8NS6uwddW95Ca4xNktUaEfkbRjObW0ncpiYiEzKkJbcnmXQc940NhU/wMgWqGrjJSyPjeDA==
X-Received: by 2002:a17:903:32d1:b0:269:8edf:67f8 with SMTP id d9443c01a7336-294ee0a300emr32024455ad.52.1761828377626;
        Thu, 30 Oct 2025 05:46:17 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2 ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41159sm185118455ad.91.2025.10.30.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:46:17 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:44:26 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ksm: replace function unmerge_ksm_pages with
 break_ksm
Message-ID: <udw3ecuflmfmjvfwubtss6ky2kx2g3d4hlhfyl6xlxjkk76asz@x4byag532ooc>
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
 <20251028131945.26445-4-pedrodemargomes@gmail.com>
 <bf832253-0052-4ab2-b664-33bec3837c23@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf832253-0052-4ab2-b664-33bec3837c23@redhat.com>

On Wed, Oct 29, 2025 at 03:46:36PM +0100, David Hildenbrand wrote:
> On 28.10.25 14:19, Pedro Demarchi Gomes wrote:
> > Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
> > an address range. So replace it with break_ksm().
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> >   mm/ksm.c | 39 ++++++++++++++++-----------------------
> >   1 file changed, 16 insertions(+), 23 deletions(-)
> > 
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 1d1ef0554c7c..18c9e3bda285 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -669,6 +669,18 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
> >   };
> >   /*
> > + * Though it's very tempting to unmerge rmap_items from stable tree rather
> > + * than check every pte of a given vma, the locking doesn't quite work for
> > + * that - an rmap_item is assigned to the stable tree after inserting ksm
> > + * page and upping mmap_lock.  Nor does it fit with the way we skip dup'ing
> > + * rmap_items from parent to child at fork time (so as not to waste time
> > + * if exit comes before the next scan reaches it).
> > + *
> > + * Similarly, although we'd like to remove rmap_items (so updating counts
> > + * and freeing memory) when unmerging an area, it's easier to leave that
> > + * to the next pass of ksmd - consider, for example, how ksmd might be
> > + * in cmp_and_merge_page on one of the rmap_items we would be removing.
> > + *
> >    * We use break_ksm to break COW on a ksm page by triggering unsharing,
> >    * such that the ksm page will get replaced by an exclusive anonymous page.
> >    *
> > @@ -1077,25 +1089,6 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
> >   	}
> >   }
> > -/*
> > - * Though it's very tempting to unmerge rmap_items from stable tree rather
> > - * than check every pte of a given vma, the locking doesn't quite work for
> > - * that - an rmap_item is assigned to the stable tree after inserting ksm
> > - * page and upping mmap_lock.  Nor does it fit with the way we skip dup'ing
> > - * rmap_items from parent to child at fork time (so as not to waste time
> > - * if exit comes before the next scan reaches it).
> > - *
> > - * Similarly, although we'd like to remove rmap_items (so updating counts
> > - * and freeing memory) when unmerging an area, it's easier to leave that
> > - * to the next pass of ksmd - consider, for example, how ksmd might be
> > - * in cmp_and_merge_page on one of the rmap_items we would be removing.
> > - */
> > -static int unmerge_ksm_pages(struct vm_area_struct *vma,
> > -			     unsigned long start, unsigned long end, bool lock_vma)
> > -{
> > -	return break_ksm(vma, start, end, lock_vma);
> > -}
> > -
> >   static inline
> >   struct ksm_stable_node *folio_stable_node(const struct folio *folio)
> >   {
> > @@ -1233,7 +1226,7 @@ static int unmerge_and_remove_all_rmap_items(void)
> >   		for_each_vma(vmi, vma) {
> >   			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> >   				continue;
> > -			err = unmerge_ksm_pages(vma,
> > +			err = break_ksm(vma,
> >   						vma->vm_start, vma->vm_end, false);
> 
> Move that all into a single line.
> 

Ok.

> 
> With that
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks for tackling this!
> 

Thanks for your comments!
I will send a v2 soon with the corrections.

> -- 
> Cheers
> 
> David / dhildenb
> 
> 

