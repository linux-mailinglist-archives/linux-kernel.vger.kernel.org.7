Return-Path: <linux-kernel+bounces-827583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D43B92260
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7847D4E1366
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4F310627;
	Mon, 22 Sep 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="TQnx8Ydl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hi0s1aBr"
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095142E8B74
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557615; cv=none; b=MLSdgPSqJ1LNVibP4JyH2iYvYGLwo7qYUrrp2x5DTnrXwAB4kMYOyOZ6EPmFJbNTd2hV4Kz9L4fI3CDp6kNU8K0yzR1OCzRvNgum3ILyPI3gj9gePmnx9xGfWEuqiTXuJU4DZR0YvrC9BuEHMRd/oH8epEn/hu9Fof11hWIFFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557615; c=relaxed/simple;
	bh=UbYINqfr9M12tQLD6VtbEp4Z3iPBoHHDToP4tnR+KfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJSp8sJL3vniIVoIJcRJ10xroF5RhWb3fGGumtU/hhqZmA/7/JFGoi4FAjRad+/bwwGhP/wKyll+tDB3ba3s07OlZPJ4Ae0WRXy1i6GF1jPUQpPY1mqcdn+tvZ0Ukxcj1J1QwdG6xM8mcb1Lnmihj5F1UWT6306SpFlialuhfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=TQnx8Ydl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hi0s1aBr; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 2B6AF130096C;
	Mon, 22 Sep 2025 12:13:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 12:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758557611; x=
	1758564811; bh=dL1BvnI43qIxZyYhkmHSIoN6CjGw1NlqI0MDthq8w9Y=; b=T
	Qnx8YdlA4Bixu00SPEK/E8uvAGBG2ZuirkZjqZKZo/wDFN0WRIAnizm/yvSZF83x
	BmdlJ1RcJUGgsSjj5tzUcqK72WaHBV+mGoM5OxTBVe7bceH5j20FSqOice/U0oV7
	tZYQ1Ko5CkWnQVtzfn7WPvH/xo7CYZL7b7547T7LvGfS0DriblTobFRTN/ZotfzS
	VygQDe5ZZLfa85WItHWDmaBdXLLUGDkL8W4Xm2t1bm56HjRd6T4h58i0f8CQnmao
	f7qsQzt3/W4GLfKWViAGC7Co59zUGTHF2Wa8plaJY+lS/V0cDghQRSp1P00i/l3K
	BXBMkDs2RCFcwmPijizdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758557611; x=1758564811; bh=dL1BvnI43qIxZyYhkmHSIoN6CjGw1NlqI0M
	Dthq8w9Y=; b=hi0s1aBrjyLf7KpNYh61eeN/01oa41y0Twc5U6m79rDCb53AYb4
	EYQluMA77XCpQZEtclcH/mys9nSq3mE2eLvage7i9Lt5t9uW16XinFd40gSaFREL
	9mK6m6wv3FLanJ54jQl3rkqMYN65XZYphC+w6nXrioR/4UCuYTCx7sv1uneAWnFA
	QKq5vC7kRGJnDTn2wqHRwgGkdegNVPtt8CBiveOxIjkkDH1WPp2+MXObGUG4SG47
	VNUk8j/rdSWpXgZ8TbHdGTlJvgalTY/wfDmbr1cGIIHT8QMWHLHhE1qmdVr69+aY
	OSZU7yGdV4E96BM2+tEYdCgmWjWIZacaiGQ==
X-ME-Sender: <xms:qXXRaK5-PYvzCD-E4oS9Ik0F6FYumOp1szuHE9oykxxD7AxwsUSMEg>
    <xme:qXXRaBj_BoMm96RPO87hvhtaaQ1FadVMcam7rJGq8T0xnuwbqlZMtlrGi2k6gMc_G
    zYFWYtXsOml9aSULf7uOiQC5ypZsTaOSJ5iXAXvQNY_kNpmiWDu9Uw>
X-ME-Received: <xmr:qXXRaA2_gtxaz7-WQj2u54xSP0sG8CImf6lHFwbpocnBaEsVBXDTUe8sVGmI-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslh
    hinhhugidruggvvhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpth
    htohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghsse
    horhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggt
    lhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qXXRaPXSdJN4P154GrwvVLIh1WSMjw0ByeJs2_M-9ZHvnVz7bW_O8g>
    <xmx:qXXRaF2oCbgrdnQipG4V-EJDmcNAtLy5ujm7sjce1rHVBZzIwq78qA>
    <xmx:qXXRaIi-q8guWTWB33mTkkr8Rc5WfOmsH_jJntYH7t0pCfpYHv4BKg>
    <xmx:qXXRaNKajF62yjoOdyjGK-bBpSpiA3k19zT7_TB0fJf3AglwuNL7Yw>
    <xmx:q3XRaE7y_bkgd_zKul3O4e5ZFYOdeRkuQziAifMzK1YenzemQPgDJ5iZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:13:29 -0400 (EDT)
Date: Mon, 22 Sep 2025 17:13:26 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] mm/page_vma_mapped: Track if the page is mapped
 across page table boundary
Message-ID: <wnenjcqvr2lzqaqnxyc6tbtd7smv2hepajtjxl72kundsfaisk@k2mlxpzuzhbv>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-2-kirill@shutemov.name>
 <7qkpt4ia3qryjp2xo2ywy7qydav6nijghasr7biwctd5ah7dat@t3epq5dzt2sd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7qkpt4ia3qryjp2xo2ywy7qydav6nijghasr7biwctd5ah7dat@t3epq5dzt2sd>

On Fri, Sep 19, 2025 at 01:25:36PM -0700, Shakeel Butt wrote:
> On Fri, Sep 19, 2025 at 01:40:32PM +0100, Kiryl Shutsemau wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> > 
> > Add a PVMW_PGTABLE_CROSSSED flag that page_vma_mapped_walk() will set if
> > the page is mapped across page table boundary. Unlike other PVMW_*
> > flags, this one is result of page_vma_mapped_walk() and not set by the
> > caller.
> > 
> > folio_referenced_one() will use it detect if it safe to mlock the folio.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> > ---
> >  include/linux/rmap.h | 5 +++++
> >  mm/page_vma_mapped.c | 1 +
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 6cd020eea37a..04797cea3205 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -928,6 +928,11 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
> >  /* Look for migration entries rather than present PTEs */
> >  #define PVMW_MIGRATION		(1 << 1)
> >  
> > +/* Result flags */
> > +
> > +/* The page is mapped across page boundary */
> 
> I think you meant "page table boundary" in above comment.

Right. Will fix in the v3.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

