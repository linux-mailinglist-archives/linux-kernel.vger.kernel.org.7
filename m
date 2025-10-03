Return-Path: <linux-kernel+bounces-840912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AEBBB5B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53D274E6F31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9613774D;
	Fri,  3 Oct 2025 01:02:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718C722EE5
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453369; cv=none; b=pzNst4LYMq8b/QG88Zjxpi9UCBTgZQ3s3IIREIukLEmhOi5yHawQx8+eE8dwEMyueouBEBOg/WBKswk/Pu5FYLpkqUYSmR4INr5BpVjdwKVPfU8ZcvennXVhe4lFrKnFEhpdQNqYuOaUuGIrJofVr5HRXCoA5+EDb0RfA1xqtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453369; c=relaxed/simple;
	bh=V3N6JPVTAJbFIPW0aA6Vkefg9rVrdmnnmo+rjMA5qWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQEdGeizxAkc3VI6Q6PaNDGcDlVXyvKqMLX47qBUO2Fi7gISKALkizZlik/CGn0t87g8NZPxJMIJTf58fVUwVhZMtYgYcZjOE7OIPXi4jjsBouCNESBdAdnCjkx3OWzV2MD7ZhPEFoRhxpE/3IgGGrpMMxPg3I6IQ11F8Rkuhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-fd-68df20ab7c6a
Date: Fri, 3 Oct 2025 10:02:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, gourry@gourry.net,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, clameter@sgi.com,
	kravetz@us.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
	kernel_team@skhynix.com, harry.yoo@oracle.com,
	gwan-gyeong.mun@intel.com, yeoreum.yun@arm.com,
	syzkaller@googlegroups.com, ysk@kzalloc.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
Message-ID: <20251003010230.GC75385@system.software.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <9a586b5b-c47f-45eb-83c8-1e86431fc83d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a586b5b-c47f-45eb-83c8-1e86431fc83d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXC9ZZnoe5qhfsZBrcfKFnMWb+GzWLXjRCL
	9Y3r2C2+rv/FbPHz7nF2i4uv/zBZ3F/2jMXi+NZ57BbX1x5lsri8aw6bxb01/1ktvvVJW1yY
	2MtqceRNN7PF7x9A8blfDC1Wr8mw+LJ6FZvF7KP32B2EPdbMW8PosXPWXXaPPRNPsnl0t11m
	99i8Qstj8Z6XTB6bPk1i91j4+wWzx4kZv1k8dj609Ohtfsfm8fHpLRaP9/uusnncvQ5Udu5a
	H7PH501yAQJRXDYpqTmZZalF+nYJXBmTl31hLdgrUDFv/XX2BsbfXF2MnBwSAiYSJ++9YO1i
	5ACzP0yzAjFZBFQkXi73AKlgE1CXuHHjJzOILSKgIbGpbQOQzcXBLPCOWeLoilUsIAlhgXCJ
	6e3nwGxeAQuJMwsusYLYQgKZEqc7ZjBBxAUlTs58AlbDLKAlcePfSyaQXcwC0hLL/3GAhDkF
	7CSmf/oKtktUQFniwLbjTBBXnmKXOPmaDcKWlDi44gbLBEaBWUimzkIydRbC1AWMzKsYhTLz
	ynITM3NM9DIq8zIr9JLzczcxAiN2We2f6B2Mny4EH2IU4GBU4uH1KLiXIcSaWFZcmXuIUYKD
	WUmEN2HFnQwh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFIN
	jF43p3C5u1+dvMFPL8XH816PKa/ysydZ8ZZWZjPZTlgv2SxqYTVDaKWjerX5rA+MUpk3A94t
	N2J0Wqjyg5c/b9oEse+lstoLlLTeM4T4ucx529iwds7ixM+SJXW3mQwqL26uaHU48Pm0xA2X
	/vqWeXk7rt670//RSq4sZcH+U/PncHI9VhTcoMRSnJFoqMVcVJwIAChf3JzUAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsXC5WfdrLta4X6Gwbl9EhZz1q9hs9h1I8Ri
	feM6douv638xW/y8e5zd4uLrP0wW95c9Y7E4vnUeu8XhuSdZLa6vPcpkcXnXHDaLe2v+s1p8
	65O2uDCxl9Xi0LXnrBZH3nQzW/z+AZSc+8XQYvWaDIsvq1exWcw+eo/dQdRjzbw1jB47Z91l
	99gz8SSbR3fbZXaPzSu0PBbvecnksenTJHaPhb9fMHucmPGbxWPnQ0uP3uZ3bB4fn95i8Xi/
	7yqbx93rQGXfbnt4LH7xgSlAKIrLJiU1J7MstUjfLoErY/KyL6wFewUq5q2/zt7A+Juri5GD
	Q0LAROLDNCsQk0VAReLlco8uRk4ONgF1iRs3fjKD2CICGhKb2jYA2VwczALvmCWOrljFApIQ
	FgiXmN5+DszmFbCQOLPgEiuILSSQKXG6YwYTRFxQ4uTMJ2A1zAJaEjf+vWQC2cUsIC2x/B8H
	SJhTwE5i+qevYLtEBZQlDmw7zjSBkXcWku5ZSLpnIXQvYGRexSiSmVeWm5iZY6pXnJ1RmZdZ
	oZecn7uJERiBy2r/TNzB+OWy+yFGAQ5GJR5ej4J7GUKsiWXFlbmHGCU4mJVEeBNW3MkQ4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYCzJfXo+Qd+W68oF
	OUtTRkXL5W+uqspK5ZsXV1m0nbbiim9JOr/z46ZHcmEbjktPORXE8G0iZ3f3jfU/ODaUKhfe
	Wb02drl+/kaF09x+qu9ZEvPec28tSj7QZbLK+3PHSwPh+vWH7SMFLhavLObaktz/ydFeiusA
	s3t6TUQ+w+oXkiov94hyKLEUZyQaajEXFScCAH4UmxC8AgAA
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 01:38:59PM +0200, David Hildenbrand wrote:
> > To simplify the scenario:
> > 
> 
> Just curious, where is the __folio_start_writeback() to complete the
> picture?
> 
> >     context X (wq worker)     context Y (process context)
> > 
> >                               migrate_pages_batch()
> >     ext4_end_io_end()           ...
> >       ...                       migrate_folio_unmap()
> >       ext4_get_inode_loc()        ...
> >         ...                       folio_lock() // hold the folio lock
> >         bdev_getblk()             ...
> >           ...                     folio_wait_writeback() // wait forever
> >           __find_get_block_slow()
> >             ...                           ...
> >             folio_lock() // wait forever
> >             folio_unlock()      migrate_folio_undo_src()
> >                                   ...
> >       ...                         folio_unlock() // never reachable
> >       ext4_finish_bio()
> >       ...
> >       folio_end_writeback() // never reachable
> > 
> 
> But aren't you implying that it should from this point on be disallowed
> to call folio_wait_writeback() with the folio lock held? That sounds ...
> a bit wrong.
> 
> Note that it is currently explicitly allowed: folio_wait_writeback()
> documents "If the folio is not locked, writeback may start again after
> writeback has finished.". So there is no way to prevent writeback from

Thank you for the information.  I was wrong then.

That means we shouldn't allow folio_lock() but try lock, while heading
for writeback end in terms of dependency.

	Byungchul

> immediately starting again.
> 
> In particular, wouldn't we have to fixup other callsites to make this
> consistent and then VM_WARN_ON_ONCE() assert that in folio_wait_writeback()?
> 
> Of course, as we've never seen this deadlock before in practice, I do
> wonder if something else prevents it?
> 
> If it's a real issue, I wonder if a trylock on the writeback path could
> be an option.
> 
> --
> Cheers
> 
> David / dhildenb
> 

