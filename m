Return-Path: <linux-kernel+bounces-826445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D20B8E8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC16B160895
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68D28D82A;
	Sun, 21 Sep 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXHuVgdZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DA274666
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758493585; cv=none; b=fo8cqhnUy1ShGYQ+vzHXRr5qbiYkh0wrKyHAUohgoDrksPvZqX15RyYdTJbFoCvd7wv/ofluxyzAoZ4EzOj0DM+77ePGLZ67/kjAMNRlSI2lYJzfdqN+bmbOiX6YKzFCMRKb1ic90tR39bZjf+ChXcjE4yFWwTdGv9yuPhKyDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758493585; c=relaxed/simple;
	bh=XtVBwRWDivem4lFIQmFrqQLUjW9/5+IVgwmLguSshbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxsIKGo9/4uE3PwBvs6F6pVCYwl+k9wDWwNZ/emvYP/k54yQS3InEalXsOizYO84mdGZgvoKeW73Dv+s5ltOoI3N7TY57ZnNTLyNi2sXJiHfbGPqqCJjp3mjlPL2S8mmj/cY2ZZXlB5Kg6lsoi31reOIubpeURI1frOXBZ4rp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eXHuVgdZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Goc4fu4E5QtA9qLOcM+4h+EpWxYEBSIjsqPof2KABk=; b=eXHuVgdZPnG4LY9fvzsP9Thzot
	7SaWdtBpIJZJ+ZMtycjRH8f62jRq439I7bIDyx/lEVq+2Y10XLWKT4YXi7uMdnYZoofhXR7UdOOOB
	RSmpSUJ7igwnEk+/VRLt6W6jicEw9dEBpykWNOAi5hSq+cGm/noOLpvNUmbGliqToIXvQ5yXENXp2
	RhvcPu7pLZ1vqzz82SGYd/zFFjc43f6hYFhbKRjCSKqROT1b0A30axHs3tfmYRwL7WZZCmarTEiKL
	JkJqPsmNJcpyljqdklBvphzT8J935OBZoPhSuDwqpF7dZ38OGrRXbJC50KHrwCVSBrEm3TWxEt6d5
	dCR4URDA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0SVR-0000000COjD-2G10;
	Sun, 21 Sep 2025 22:26:05 +0000
Date: Sun, 21 Sep 2025 23:26:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
Message-ID: <aNB7fTesaVCXHB0E@casper.infradead.org>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917113609.GB1086830@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917113609.GB1086830@nvidia.com>

On Wed, Sep 17, 2025 at 08:36:09AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> > This series transitions KHO from an xarray-based metadata tracking
> > system with serialization to using page table like data structures
> > that can be passed directly to the next kernel.
> > 
> > The key motivations for this change are to:
> > - Eliminate the need for data serialization before kexec.
> > - Remove the former KHO state machine by deprecating the finalize
> >   and abort states.
> > - Pass preservation metadata more directly to the next kernel via the FDT.
> > 
> > The new approach uses a per-order page table structure (kho_order_table,
> > kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
> > address of the root `kho_order_table` is passed in the FDT, allowing the
> > next kernel to reconstruct the preserved memory map.
> 
> It is not a "page table" structure, it is just a radix tree with bits
> as the leaf.

Sounds like the IDA data structure.  Maybe that API needs to be enhanced
for this use case, but surely using the same data structure would be a
good thing?

