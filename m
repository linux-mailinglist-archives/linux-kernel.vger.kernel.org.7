Return-Path: <linux-kernel+bounces-840955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F1BB5CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1035A19C383B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FA2D47E2;
	Fri,  3 Oct 2025 02:31:34 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50B2D3A9D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458694; cv=none; b=g+8Ik5CvLM4M7JxF0r4p2pndowIpRlZy0FENt3sGaj78VWtPh25xwVkcMcz3nyUTfzEPqFR18uEIwbrgrntodjTSXW2pIErwj+iVUvllkA6gpEg/DrSZjVxA/qGsRlUGuDkNxU2w+SsBdGv5LGV/zpXzTlt8tN4vr9SVfTh39jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458694; c=relaxed/simple;
	bh=9MqdsOYnzNI6LbgpUVMyBmakykkewjahkpVUC9MdEj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTFDMFpS7HrexVPNJcha8BRB5qmtETj19EPxZw9biqNNfkQ5t8Erw6HCUKcJ4H2NU6y8q9sHoprxgcEVCkMZq9WPtg6rZybegsIuglP/koQLZgQnoP7IVhTDvN3IZxjn6nP10QTcZVnUe0In5sc2AON16a66KBx886/7nYbwRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-f1-68df3579b3c0
Date: Fri, 3 Oct 2025 11:31:16 +0900
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
Message-ID: <20251003023116.GB29748@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsXC9ZZnoW6l6f0Mg1OLLCzmrF/DZrHrRojF
	+sZ17BZf1/9itvh59zi7xcXXf5gs7i97xmJxfOs8dovra48yWVzeNYfN4t6a/6wW3/qkLS5M
	7GW1OPKmm9ni9w+g+Nwvhhar12RYfFm9is1i9tF77A7CHmvmrWH02DnrLrvHnokn2Ty62y6z
	e2xeoeWxeM9LJo9Nnyaxeyz8/YLZ48SM3yweOx9aevQ2v2Pz+Pj0FovH+31X2TzuXgcqO3et
	j9nj8ya5AIEoLpuU1JzMstQifbsEroyDb1+zFNwVrDjycRlTA2MvTxcjJ4eEgInEydVtzDD2
	mYdnWEBsFgEViftt+xhBbDYBdYkbN36C1YgIaEhsatsAZHNxMAu8Y5Y4umIVWIOwQLjE9PZz
	YDavgIVE+9Q/YLaQQKbE6Y4ZTBBxQYmTM5+AxZkFtCRu/HsJFOcAsqUllv/jAAlzCthJTP/0
	FWyXqICyxIFtx5lAdkkInGKXON48mxXiUEmJgytusExgFJiFZOwsJGNnIYxdwMi8ilEoM68s
	NzEzx0QvozIvs0IvOT93EyMwbpfV/onewfjpQvAhRgEORiUeXo+CexlCrIllxZW5hxglOJiV
	RHgTVtzJEOJNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBo
	t5XpVJTr48tRjoLbam90xLE0M28937Rq/9bMFm9zHd9+9mvlWx6KV7D/2Jmg+MdsSpCCpl7c
	WXfR/4t1+38ZmfxZLrzFdkLMZdmACqFbNSf9PlxYKPHM2a2S6aNzT4+UduGN/+nc6dPWJr4P
	yVkkoXNDz1+yw9O+obHbd5Ghy67ZTzTuZSuxFGckGmoxFxUnAgD+MoZN1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsXC5WfdrFtpej/D4GanpsWc9WvYLHbdCLFY
	37iO3eLr+l/MFj/vHme3uPj6D5PF/WXPWCyOb53HbnF47klWi+trjzJZXN41h83i3pr/rBbf
	+qQtLkzsZbU4dO05q8WRN93MFr9/ACXnfjG0WL0mw+LL6lVsFrOP3mN3EPVYM28No8fOWXfZ
	PfZMPMnm0d12md1j8wotj8V7XjJ5bPo0id1j4e8XzB4nZvxm8dj50NKjt/kdm8fHp7dYPN7v
	u8rmcfc6UNm32x4ei198YAoQiuKySUnNySxLLdK3S+DKOPj2NUvBXcGKIx+XMTUw9vJ0MXJy
	SAiYSJx5eIYFxGYRUJG437aPEcRmE1CXuHHjJzOILSKgIbGpbQOQzcXBLPCOWeLoilVgDcIC
	4RLT28+B2bwCFhLtU/+A2UICmRKnO2YwQcQFJU7OfAIWZxbQkrjx7yVQnAPIlpZY/o8DJMwp
	YCcx/dNXsF2iAsoSB7YdZ5rAyDsLSfcsJN2zELoXMDKvYhTJzCvLTczMMdUrzs6ozMus0EvO
	z93ECIzCZbV/Ju5g/HLZ/RCjAAejEg+vR8G9DCHWxLLiytxDjBIczEoivAkr7mQI8aYkVlal
	FuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MLZsuqQfb2GRoHvSu23p
	vy8RV+dpv3Zdc7JzXbGbsIHYwsDU1C9Pm5j36MeUhXtVHv24/fa2rQfuy/TvNWKfpf981rZH
	DR2b9KtU3q6R6LK+oymidfpYX779gvDw3I4p3q/7zVfHvGux/ekhePrThOnHn4ZviOhfXlXA
	e/PfHbnZsTFStyt/n1JiKc5INNRiLipOBAAgnFyIvgIAAA==
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 01:38:59PM +0200, David Hildenbrand wrote:
> > To simplify the scenario:
> > 
> 
> Just curious, where is the __folio_start_writeback() to complete the
> picture?

ext4_end_io_end() was running as a wq worker after the io completion.

DEPT report can tell that the following scenario happened with
__folio_start_writeback() called far earlier, at least, before
folio_test_writeback() was seen as true, but unfortunately DEPT doesn't
capture the exact location of __folio_start_writeback().

	Byungchul

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

