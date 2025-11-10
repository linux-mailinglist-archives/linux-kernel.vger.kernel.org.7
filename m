Return-Path: <linux-kernel+bounces-893277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA20C46F90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DFB189215B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6530F939;
	Mon, 10 Nov 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQWMWyeA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5C3115B5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781933; cv=none; b=IEljLqQfwi+05T39H0XFUISCGOCUwwXeWiZ+by+RF3SQmwnhuGpUA0yQMaP+Fwi81UK1pIw3wTUtMl2EVehLA4N9TCRvis9h754USMVLFbJV9aol6PiNTDd/TdnNCcMB98e+3Yx0xTfc3OXaySVxBI1/cJO12SQbgcT0daTFxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781933; c=relaxed/simple;
	bh=ESpxzLjRIYApwkHxl6Vgj10zCasBSSNB54DbKubFwY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtFbieHhOORIVdWHwg0LYhsdpvdi/JNdq10shXTetqUUDr+R0TMyxdFf2JqbxGZZpOgHJg/G6Si8spnYNb4Oe/l6izq0kGcVx1cvB5EYG5ApwY713tlWvuFimkjQDeQyph/zqXHjPjOX7F2dFUojlhJj5vx23o2eRhjPudlCAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PQWMWyeA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ESpxzLjRIYApwkHxl6Vgj10zCasBSSNB54DbKubFwY4=; b=PQWMWyeA36Wa+X7C9sAPrQru6l
	ZH8kPCH899xum93FMK/P+W/guoOk3C07s17/t3ZB+VfNQNbWUkeiKf/+3IQeKpYLj57WjgglQwMao
	0aRS3BqQ0uTgr7qUgdBA8IzRaaBLylqYTEDAW6Zu8uBlpsPJiMJiiQJ19KA531Yq+BHC7oUSrJLUi
	itNxRLsDV0rsi+jrw/0HkwcxzPuiQMOp5mkg5gZ5v7TJGHf4hw6MsHMhk0xWjUwAY5VWex6KVOs06
	1ZUGmNcLJ9x+1J/WmfxUDbQaGUtNh6vm5IoGxXpks9RjbdcAQZW+dOaQEglBAngDQ2sk5iCgt+4dE
	2+YEy7vw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIS6S-0000000GI3P-2js0;
	Mon, 10 Nov 2025 13:38:40 +0000
Date: Mon, 10 Nov 2025 13:38:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, vishal.moola@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ptdesc: Derive from the compound head in page_ptdesc()
Message-ID: <aRHq4OdBCtC_V0eS@casper.infradead.org>
References: <20251110063725.3118037-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110063725.3118037-1-anshuman.khandual@arm.com>

On Mon, Nov 10, 2025 at 06:37:25AM +0000, Anshuman Khandual wrote:
> struct ptdesc (including all relevant helpers) support multi order compound
> pages. But page_ptdesc() coverts given page into its own ptdesc rather than
> deriving from its compound head as would have been expected otherwise. Just
> change the macro to fetch the struct ptdesc from the compound head instead,
> so that the same struct ptdesc is reached from all tail pages.

Please review
https://lore.kernel.org/linux-mm/20251020001652.2116669-1-willy@infradead.org/
instead.

