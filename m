Return-Path: <linux-kernel+bounces-803151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C47B45B55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62BCA634AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E17306B0F;
	Fri,  5 Sep 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="VswTXrJF"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB118306B0C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084277; cv=none; b=hgwdrodatpTz1qvQdZxtJOZnb4xicVLJ42tfAeF0PHTO49c3wOnQOIOD3IZUolz3yFyhif4uLFur9fviFn3pPfYV8HZqKwFQkMy5cFGrBl8zhLJCBJXwPZDHDX4oOiZ5jpBW+m+8EehT4t+lIIXNoX0KdwVL12rVpsLCOzAa6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084277; c=relaxed/simple;
	bh=xlVV1qKG3XvKh67ijh+wuHIhejeOqsHuvlm3G+2ZtoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDo/sSrWtwp7K6hUw1xrY0iUU3hjzAMxMp9NjiPX76B/V0JUsCec+cvbRuqeIR7oGN4jQu9NnBYGxBe3oHQOUqkZ6Y07KHJmA/RFRrtRu/KaxfEg4MtEy46ytbRZi7I7uW5kJQvLsTpwLV1gvPZ6PjamPyqJpYq/kX/oTn395x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=VswTXrJF; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJKG21jHhz9tPW;
	Fri,  5 Sep 2025 16:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757084266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCjd9fq4iumbs8QsFB5jw1T46vIRHXwxOd4TSRtAVMc=;
	b=VswTXrJFVf3wRI7VVhbsbNn6Q6DYMdzl2Ffz06eHxQw9bXNzHiY/jbBNh+bta8vTs21IPu
	wRt2vmH/wa2qwkWbu+t4kcm3vdStLphRNEDp0CDSlkTw4qapRB2abtrfVpCI+PssbrDps/
	QhPFQ436JAFs55fZx0Ni2AYu3JnvRUWHydY2KBW7yGYpONIcdVATSA4IRuvaul2Hcuv5nR
	N7V5hDd1lvz9/di66IleyV7fMFqsAyEXQEoxDuaWQ6cY8hfaW8fhmrQnsa0z5Vj4Bgmdgo
	Hr8YYq4bu/MuxGmpKOsb67clLfJaExMEnxPU81dSe42T+KJcOXqoDfRvaImWYQ==
Date: Fri, 5 Sep 2025 16:57:40 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>, 
	Kiryl Shutsemau <kas@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <hfljftvow5dzmkfgh3cjuqmngnmg65o4r4mpp5u34zoixwmdl5@ohnv6bbqavyu>
References: <20250905131352.88069-1-kernel@pankajraghav.com>
 <aLrrQDCBzaMwwmA-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLrrQDCBzaMwwmA-@casper.infradead.org>

On Fri, Sep 05, 2025 at 02:53:04PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 05, 2025 at 03:13:52PM +0200, Pankaj Raghav (Samsung) wrote:
> > Changes since v2:
> >   - use page_folio(page) directly in VM_WARN_ON_ONCE_FOLIO
> 
> ... why not use VM_WARN_ON_ONCE_PAGE?
No idea how I missed that!

--
Pankaj

