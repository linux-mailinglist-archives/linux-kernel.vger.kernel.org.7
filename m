Return-Path: <linux-kernel+bounces-895103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC739C4CF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FF74A0277
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F67342144;
	Tue, 11 Nov 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZinXmRZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E8340A44
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855516; cv=none; b=IOsddE9FbQMh3gZsSYU3qtf7lk6rJLmjKlsNaokR8bXPJRgACliB3nu2gKnBxLUZugdY6CQCx5XWolK9dfqsHn8Ppoldw6+SFG9RvStNzGm99Xyni0F1yNEe9KGkJRu+slMTbY/0UjeYHatH5whWS0yXxAjN+5X98aWJSqaeecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855516; c=relaxed/simple;
	bh=SwY69HX5+VyJGypqI9OgmzagGzzfnjk24hRcW5iGh84=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKMn2jVHfoI0nL09HTZkCHJXBpj/s40H3UOSyXE4kjW+1yCPtDML+TVWYuY1A6DM2GWQ/gjFcl2BYOoQupKUbGAO73DQ9FwhYImqPQs8tN23fOCkLT8ZMAcp3ACQrFODW4sTBPn14YHZ7ARHetkuO7XX1PPTJHI7Y00B/4zbNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZinXmRZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E745C116B1;
	Tue, 11 Nov 2025 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855516;
	bh=SwY69HX5+VyJGypqI9OgmzagGzzfnjk24hRcW5iGh84=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ZinXmRZQK3QA863duST9CN8mQG/mCA8r6mYuOdmlL6KZ7dld0KrJ9fwEMzM2nc6tJ
	 v0KemDEcB4Ng5aonY3wcZ3kIseZOeIaxndeuS6j2qkqPuK9RollPoXh+2ZD0aavIeQ
	 wzcX1wyiP/EPerloWZJwQ0dwuhNHqWSTWqMLZFDj17+SWm9tNLK3YfDy0psKJDV0bu
	 UMXS9G6IN9b3jUYQGQOefsNxSYaiKfGXspdEKFB6AkSXnUYseUZ3INd88RBXLHoh/I
	 bX/ZMR1HnxHTlXewIiBRYs0EJ+API7Q+RzJ7TnSd6l5fAjblN1ElSUsjJr+FaWqJHo
	 yomewFZj8FEGQ==
Date: Tue, 11 Nov 2025 12:05:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aRMKUoB/nc5A8ZMf@kernel.org>
References: <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local>
 <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>
 <aQkUwbx7Z4q1qcSB@x1.local>
 <5f128cbf-7210-42d9-aca1-0a5ed20928c2@kernel.org>
 <aQmplrpNjvCVjWb_@kernel.org>
 <mnjrtg62qh2rd353mbudryvs3neukt26xtovyddm5uosxurmfi@lldnrp7a3666>
 <aRA-se6hJPzHD3mA@kernel.org>
 <ulpftgdk6hgorwsrbtv2tv47b7usn3cow362knuxlzq2az2cl2@krwo6e3zxryn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ulpftgdk6hgorwsrbtv2tv47b7usn3cow362knuxlzq2az2cl2@krwo6e3zxryn>

On Mon, Nov 10, 2025 at 11:34:59AM -0500, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [251109 02:12]:
> > On Thu, Nov 06, 2025 at 11:32:46AM -0500, Liam R. Howlett wrote:
> > > * Mike Rapoport <rppt@kernel.org> [251104 02:22]:
> > > > 
> > > > It seems that "as simple as possible" can even avoid data members in struct
> > > > vm_uffd_ops, e.g something along these lines:
> > > 
> > > I like this because it removes the flag.
> > > 
> > > If we don't want to return the folio, we could modify the
> > > mfill_atomic_pte_continue() to __mfill_atomic_pte_continue() which takes
> > > a function pointer and have the callers pass a different get_folio() by
> > > memory type.  Each memory type (anon, shmem, and guest_memfd) would have
> > > a small stub that would be set in the vm_ops.
> > 
> > I'm not sure I follow you here.
> > What do you mean by "don't want to return the folio"? 
> 
> I didn't get this far in my prototyping, but if we have a way to service
> the minor fault for the memory types then we could use the function
> pointer as the way to change how to get the folio vs passing in a
> pointer to get/set the folio.
> 
> > 
> > Isn't ->minor_get_folio() is already a different get_folio() by memory
> > type?
> 
> Yes.  If you are dead set with handing the folio to the module, then
> this is what you do.

uffd does not hand the folio to the module, it gets it from there.
We can make it even clearer by changing minor_get_folio() declaration to 

	struct folio *minor_get_folio(struct inode *inode, pgoff_t pgoff);

-- 
Sincerely yours,
Mike.

