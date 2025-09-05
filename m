Return-Path: <linux-kernel+bounces-802497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D41FB452D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5BF1CC16CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FB2F746F;
	Fri,  5 Sep 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="kslJTM8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TefHZ+pH"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257227C150
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063603; cv=none; b=PE2hwv1BF50ROR3DgY33BWLA1hBCTo9+xrT4Ue0LIrPbxxMeyi3q892AOyfwAFovd+Kqu6+VPNZrj+uUFuoxYWQ+Xglm5mhAtobdmBzRK1u1GhBriMV/xtcxrOha3B5au42lxN03E70bGYXcO+p1Ip+3kVPBtC0YNBXYKvkQTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063603; c=relaxed/simple;
	bh=U2n2hrNml7C5JhCbWDE+jZVV7HONGv87QZitAZWOkWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSfYqaOEN+pcI9mMTW2FpoB1DbKH+FR+zknlqA9YUR8UpDGbx3dPxTix0ASm3AK3Hk1HuinDIvrLq1XclVEZLrDvMkST00p1W7wxtGLyPAeITu+qkgqcIDjZ92agPEMt6l0L6zN9T3OMUxpvmg6ODL/jU4N9zHSjsgdOBNiiPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=kslJTM8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TefHZ+pH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1474114001D4;
	Fri,  5 Sep 2025 05:13:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 05:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757063600; x=
	1757150000; bh=zvW/hg9ERJRbmThtCLmqLLOoe41n9axYJsJRtI2T5qA=; b=k
	slJTM8mM/EtG3Q0W5/9/HaJQiPhlky4EZ5azB1v4Xi01lgs8RkyOK1BAmiOQZ30Y
	QvnHc3zZULYIYjzWnCwsbcUSMYO5JYBkgNY7D9BVz8baDRYOUGEoSu20O4IA2x32
	lbMM1L+Z68lGRb8WuHhfRU09EDZ7RCViCs32X0EJ9BsT+s+glSvaBfHwkyqfjW2p
	zbGq7fCcvYahdE1oymVXEo1pcJ1TJNWfCuE1Ps+Mr6CF0RUPFOS2qvlpOfjyv3Vi
	l9sBV9ueQCmtbW2vDyeBT+e5jIco6bE9ZcYlNcl2Moyse7eoW585cA4qGanlISFk
	UaP+LT06v3sgI9loBoIew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757063600; x=1757150000; bh=zvW/hg9ERJRbmThtCLmqLLOoe41n9axYJsJ
	RtI2T5qA=; b=TefHZ+pH9cAGPWeyqK8FSXoqcoFVZWwXXvIj5435CMtdFXipY0B
	K4XbSfIGnuGwq6d54CwiDoqfCOmA2jGINcbstNcdZ8Rvzx7792le8bvkTJeMNgCZ
	GmZ4lhtmHyh4SwTPq6ssio9Xq6X2Do4EXt95ZuGcTgEZfXUs26IWQto6dmlAAKy9
	HGq35AE0wUJ0thCeSD31Gf9N7EYIjzfETHqJbt0GD8r78gGX3gU7mcvz9YHU3XNQ
	jxCbCDKkZaG+2+Y61GRZZ0I0I4bXmz19brRakk3xaZZ0YME7vgUsCA0OuINXNqtI
	L06Ahk5WtPEzw5URcHr7xNwD8T7WOzfsBig==
X-ME-Sender: <xms:rqm6aNJEB7QAafjD40tRcith5kLIZGOfgFDIwLFI-qPFAfsoQyhcSg>
    <xme:rqm6aD-LvYvtECUsa47R3tata_5zB__gvOIEN4k3qV9PbfazMils1D6nnx8bkKZsg
    rEgtzQ0Iv-xvPdRoOA>
X-ME-Received: <xmr:rqm6aD-wCp2n4lolg1AGQNDDKBXv6ddhMWMIKDt9LFsGTDb4AFJWTDXDcAkt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekhedtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:rqm6aN9c4Z0hpq8qkIPnU83Ui4u24jcHGp6ts-mA73TJ5589Qma0qg>
    <xmx:rqm6aOJliJWVRrfu88Vkl6niWCz9YoqCeXBGFJO6PuIWd2mYY8KESg>
    <xmx:rqm6aCS40ilsEHq5qw9DF_lZsStTSXvXzxhvL_sz0wFDCYBe3bJeaA>
    <xmx:rqm6aH_brdZ_N-1lWlXXBrebaPFwcAZOVHv9C4WlpJ3WAUKqIdkscw>
    <xmx:sKm6aKNdHmCUGuMNUDId2EVBAgnksRZ-fNPx2a_S90qOgSTjKFc3z_e8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 05:13:17 -0400 (EDT)
Date: Fri, 5 Sep 2025 10:13:15 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, willy@infradead.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <uw7ullt3ztwxiibsdffvphehi7r5g2nxqepcggilgalhv77gso@3h5uqgwodzl3>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
 <2psecfvsd4lbgcm6aflifi2kc6gof345txsvk7wtsytre5ehqt@4wyru36aaeel>
 <e8d5eafe-db58-4b78-b029-de6a59fc4fd7@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d5eafe-db58-4b78-b029-de6a59fc4fd7@pankajraghav.com>

On Fri, Sep 05, 2025 at 10:13:05AM +0200, Pankaj Raghav wrote:
> On 9/4/25 17:26, Kiryl Shutsemau wrote:
> > On Thu, Sep 04, 2025 at 11:51:29AM +0200, Pankaj Raghav (Samsung) wrote:
> >> From: Pankaj Raghav <p.raghav@samsung.com>
> >>
> >> split_huge_page_to_list_[to_order](), split_huge_page() and
> >> try_folio_split() return 0 on success and error codes on failure.
> >>
> >> When THP is disabled, these functions return 0 indicating success even
> >> though an error code should be returned as it is not possible to split a
> >> folio when THP is disabled.
> >>
> >> Make all these functions return -EINVAL to indicate failure instead of
> >> 0. As large folios depend on CONFIG_THP, issue warning as this function
> >> should not be called without a large folio.
> >>
> >> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Acked-by: Kiryl Shutsemau <kas@kernel.org>
> > 
> > Just curious, did you give BUILD_BUG() a try?
> > 
> 
> Yes, I tried BUILD_BUG() but it actually fails the build because truncate_inode_partial_folio()
> calls try_folio_split().
> 
> It won't be called in runtime because there is a check for large folios before we call this
> function. So a runtime warning is better in this case.

If truncate_inode_partial_folio() shouldn't ever be calling on THP=n
kernel, it also can be BUILD_BUG(). Just saying :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

