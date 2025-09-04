Return-Path: <linux-kernel+bounces-801152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F26B44088
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA93165D90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04123B62B;
	Thu,  4 Sep 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="TwxRUM2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JY1atfuu"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD518DF80
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999580; cv=none; b=j4KuEK5nZ58KYdAhkpxrlXWyas/f/glfGZvn+u96cA3RQecmeQuSIiyERQ/Q7Txet5T6HIfaY/4HodF3FHyXDa+7DmNUXrD/CEcvsWep0iOW5iTMnKHmL8s1D26VMocO5VxNL0ovOCq7EwKFjT1b7Q/DczUPVd/rU82CLqz5dDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999580; c=relaxed/simple;
	bh=34NPjI51TUXJcLgkwOqQfkqd0jTkD56jHHMGLG/K1nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVjKwPnQ2hpMU+ZyWBJWAJ2HpJsDDwv0tpsHkGcekp9f5VQdg3P7mWZ54JEDRmzbBYl9O3AUNi4QnS4QvM+PBInPfCgcj9Ydq+vAW6sT4wFj39lErjppo/txEroJIHFHBYOvlTFXorgTF0ul2IT0GzDYZoboKBECTd+3RGC04Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=TwxRUM2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JY1atfuu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B0D80EC00DA;
	Thu,  4 Sep 2025 11:26:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 11:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756999577; x=
	1757085977; bh=jC7LQ/mmOicbI45GOht/juWrWam2IipA0I2zNWPuuhI=; b=T
	wxRUM2QaTVTlnBa/ZJcF4rY/bJM3SJWhhweyChEn/HLKlYHBEHffhLxLHXdifdtS
	/ba24aWFNHJk9gCiQWhzBB9VOrfbs8LKih90j2f2UIRTd4a8AyIcb5iUrtxtw3Ij
	rmAO/hw3a73ZImmJErlxXtn8NP+KiD6mq+bnRgznIymFhz/JwTHMYWewDjm4YgKU
	55yRTam1GX43hHM5fFbN71kHVbNGBOw7DEkR/OwB1hN0pglDGVSVK7aUMPOm/ysX
	7LqoauChBMGHnrZX9LTmZRsk5CQMVFrYz95j/AL2NItK/4fuB7AkhDlEM+k5lct9
	XJXmOtiI/rdInQJdFY1Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756999577; x=1757085977; bh=jC7LQ/mmOicbI45GOht/juWrWam2IipA0I2
	zNWPuuhI=; b=JY1atfuu+QwAu/e+ni+j63Vk4tgUxsBL+2ZYa3Oy6Qi+zClA9ld
	l/3rFBqXfCVcb+yh4TvCDElXnOmBQUtCIP+OXQs9UYJmt36AKknCvifY3SB3aJzO
	JFdaIQw58Fy4IyNbRZ1d2NkFZxLfkuAgurzYuStbuo5O7OMb0FQdrLqBztLVBqWd
	t3gS8Ieezh4KVK0hDH2Q2VkjJtDmmwuBtRVm2tgQDjE1YjQrMBPTfcAqcV+U3S2w
	CpF15RojmHbAB42jrwfPVLQ8n7KH1T3JnBY5I0g/vhhvBSSKrDWVQ42dCDgrOaNy
	HRKVIviNhPbvBOAlHACQ+qpU8UJlKrt/i1g==
X-ME-Sender: <xms:mK-5aG5Q7Uo5m_Tc3R2FnfcmU5IDBxKQDOXpELOgJzt2-U6eo1Qt_g>
    <xme:mK-5aKuk7nXDPS-rEolkmae89IsLZ9bhBPVG2WJ3X6YrmEiErmnQ7WDBJe6tnMuTk
    wi9NOA5YGcTguPMTro>
X-ME-Received: <xmr:mK-5aDuLWYiJdKBDO7E3WbL6nUJJ92sa8n5AHWXpJ4zcsCnCoixBPMyrdqtn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdeludfh
    feefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeefgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvrhhnvghlsehprghnkhgrjhhrrg
    hghhgrvhdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphht
    thhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphhtthhopegurghvih
    gusehrvgguhhgrthdrtghomhdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghs
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopegsrgholhhinhdrfigrnhhgsehlihhnuh
    igrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepsggrohhhuhgrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:mK-5aCsCgw-2hundynXjOa1ffohr3kP4X4rv4RcdFHZ5ZUDXrURv_w>
    <xmx:mK-5aD4P7nvpZS6ODvdsaI9eRk3WGR5m0yKv-ufabLl-OXFEBDmylQ>
    <xmx:mK-5aFB8FII5kC9Wfg8hsNjVMkicxIYZB5KgY3NAKIzTl4hIOfbOGg>
    <xmx:mK-5aDvqfYHOM9-5ntiRug9-vd68Z7oRilFCEoBQPv3K0suePfKNDw>
    <xmx:ma-5aNUso35o-4sP0Do-5MeUQcSGi9iH-0D9xY5lDcSMhkdh1VxKp3A3>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 11:26:15 -0400 (EDT)
Date: Thu, 4 Sep 2025 16:26:13 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, willy@infradead.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <2psecfvsd4lbgcm6aflifi2kc6gof345txsvk7wtsytre5ehqt@4wyru36aaeel>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904095129.222316-1-kernel@pankajraghav.com>

On Thu, Sep 04, 2025 at 11:51:29AM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
> 
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.
> 
> Make all these functions return -EINVAL to indicate failure instead of
> 0. As large folios depend on CONFIG_THP, issue warning as this function
> should not be called without a large folio.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Acked-by: Kiryl Shutsemau <kas@kernel.org>

Just curious, did you give BUILD_BUG() a try?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

