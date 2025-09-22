Return-Path: <linux-kernel+bounces-827723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD929B92899
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308537A442D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55B31771E;
	Mon, 22 Sep 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec5LT41V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E023176EE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564197; cv=none; b=eHU7IwqfTaAZc1UyfPN5EhNjW4mkjKgoR4Q5dh6tF+osqXwGz7ZXYHQ0+hu/kpDWtyj6Exnxx0TUkpV+IQlttfdPUi9WV6usV8opOnXkPOIXEcJeJJYm0l7lAslqyLgGykmMfBdlAEM19DvKVjA8jrFurTtIpY+xI9iy4T7w7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564197; c=relaxed/simple;
	bh=6aXMQOcCs3mLvzR+Noqfshc4At6SyLDP1SSXE8VD35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXYm3ELnITj55cJFu4Q1Uodl926O1kSC5dqL7TX2tKjd+9bmw09GMg+JuJfOcl28QfFL3RhT5ehV5If43GYkxliPaaiTWhITlHc90nDBggptBU5pxoUq9u2Zng+atU8eQvTUggY+HLfp0AYAU1Hzglwb+PRdOYQjy0fA6b0Z9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ec5LT41V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758564194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eiGw8qndz230qKn8LjE5/t4sTzv4HP8ia3a14ARun1c=;
	b=Ec5LT41VpqVb98nEAgExKhePuZoPQFIoATBck6NVBOdYkdnHOY6+sfiTHSRvgbsi0ImpyY
	q+fN1f3wUlv01iVp6MX4bbis61D/3rkIzm0B1mKenC3uGRLIIkSAHXT785OvCdo4OnyG3j
	WYFfmlxqwGPjdxk8aqx/AV0oquSHVko=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-AySzYLSJPDK9AsUoTbxFpg-1; Mon, 22 Sep 2025 14:03:12 -0400
X-MC-Unique: AySzYLSJPDK9AsUoTbxFpg-1
X-Mimecast-MFC-AGG-ID: AySzYLSJPDK9AsUoTbxFpg_1758564192
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-827061b4ca9so852261385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564192; x=1759168992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiGw8qndz230qKn8LjE5/t4sTzv4HP8ia3a14ARun1c=;
        b=AkehGhSqdKfZiPkpt7w6adMX4LOPyduTla4Y/kONwnMUFqaJ8YFPK7meZFPX7y2oOX
         y2IgsIC1a10llJW3HSDMgDp5fgDxH0pZL3C5Vh3hpur4SiYMqfyL1pQE3PgzWNmDE/sg
         t5N8r8dSYQK3XyNHJNsRBUo07KJqemD8AxHGgB3qt+3LP8OeD43saEZKjGPyTEXcxZ3Q
         tzl1szYPO7e3JCzEKayIe6z7+3IxTcBQs9joCCl4SxbJQEw+LuLw3j93injYVT9FD7+A
         fI8G3mVbn+n91tMGMiyB8UVGyM80AYp/fvdFJCnVfpXPSodpPM5fVrNbA76k22cEDVTC
         KfEg==
X-Forwarded-Encrypted: i=1; AJvYcCVOpT8R0sBkNxjwKNUAfNb9cQCrJC+lxm44Ft5/uKl2eujlo3hSYFGM+8mUpH5yeKKnS/8p4oxXkxVoXHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpBEHakfeB6yFr+DTD56t+7Ek/mCCJ6CfIlvgk3uGe/W4PVAL
	8VSnEoOOBYcI6BQ60lDx9MjEZWx938fz3O9g5sXz2rLHDUaHXjfe29a26f5QG0Fo6zCgd/RSSwS
	/zA9ULi7C97QwZ0oFSlllbLjoUb0wUGtE5XVeGfoHhEs8eQCyfxz2a6VnAC4EdLIqzA==
X-Gm-Gg: ASbGncv53IBcS6OOfrMohiWnBu9+60bTEdQPwKMuorq2qK6wt4XDmO925+xWmitbjNb
	EZIqhauKkCkMUn1WCSiwgviKeGJ4+MkRhmROroZnjqm501JqkdgCMgvpTegH4Idpq+b7mreiSVs
	LQ531lTYQgkDo0Bf7rlZapi3zSziiNGNd74tHH/kN+0HWDmt/NeRmpr6x5wflbxrf/6rrkBHFmv
	ZR1e+IdhIcfgLS3P1ZlbegwASodZJBe7GaI06xf4GIea/oqIYi/jORpyuUJPI4wbJe7DRMNbaS/
	e6eIS/sIQbp8yv2lTqNod94TBh3izEn1
X-Received: by 2002:a05:620a:832a:b0:828:aff4:3c03 with SMTP id af79cd13be357-83babdfcf5cmr1258673785a.61.1758564192014;
        Mon, 22 Sep 2025 11:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu1SuYkWfMcMDPsDrtqIfPiA7Bh/dZJ/L5fKT+blbHI9wKKzeXLIdyTxlnA7RLV9KO2wzu9g==
X-Received: by 2002:a05:620a:832a:b0:828:aff4:3c03 with SMTP id af79cd13be357-83babdfcf5cmr1258653385a.61.1758564189826;
        Mon, 22 Sep 2025 11:03:09 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630481f2csm826194585a.35.2025.09.22.11.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:03:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:03:07 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aNGPWyNpVbsN71R9@x1.local>
References: <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <6a6c8b42-ed13-4fe2-9ef4-5641b81ed2d1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a6c8b42-ed13-4fe2-9ef4-5641b81ed2d1@redhat.com>

On Mon, Sep 22, 2025 at 07:20:50PM +0200, David Hildenbrand wrote:
> On 18.09.25 20:20, Peter Xu wrote:
> > On Thu, Sep 18, 2025 at 07:53:46PM +0200, David Hildenbrand wrote:
> > > Re Nikita: If we could just reuse fault() for userfaultfd purposes, that
> > > might actually be pretty nice.
> > 
> > I commented on that.
> > 
> > https://lore.kernel.org/all/aEiwHjl4tsUt98sh@x1.local/
> > 
> > That'll need to leak FAULT_FLAG_USERFAULT_CONTINUE which isn't necessary,
> > make it extremely hard to know when to set the flag, and comlicates the
> > fault path which isn't necessary.
> 
> I agree that FAULT_FLAG_USERFAULT_CONTINUE would be a very weird thing to
> have.
> 
> I was wondering whether it could be abstracted in a cleaner way, similar to
> what you described with the "NO_USERFAULT", but possibly taking it one step
> further (if possible ...).
> 
> In your reply you also mentioned "whether we can also avoid reusing fault()
> but instead resolve the page faults using the vm_ops hook too".
> 
> So it kind-of is a special type of page fault, but the question would be how
> that could be integrated more cleanly. And as you also point out, the
> question would be which other users it might really have.
> 
> In GUP we achieve not triggering userfaultfd by not setting
> FAULT_FLAG_ALLOW_RETRY.
> 
> But it's rather that not allowing to retry (drop+retake locks) makes it
> impossible to call into userfaultfd.

Right.

> 
> So not sure if abstracting/reusing that would make sense.

Direct reuse is unlikely.  The current semantics of FAULT_FLAG_ALLOW_RETRY
is very specific, meanwhile handle_userfaultfd() actually has code to warn
already when it's not set..

In this context, jumping into handle_userfault() is already wrong because
this is about a request to fetch the page cache without being trappable.
So if there'll be a new flag, it'll need to bypass handle_userfault().

But then if we'll need a new flag anyway.. IMHO it'll still be cleaner with
uffd_get_folio().  It then sticks together with the uffd description of the
memory type when one wants to opt-in with MINOR faults, which should also
explicitly invoked only in userfaultfd minor fault reslutions (hence, no
chance of breaking any form of fault() either..).

Thanks,

-- 
Peter Xu


