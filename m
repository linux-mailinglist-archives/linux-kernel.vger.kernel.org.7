Return-Path: <linux-kernel+bounces-845308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99036BC453B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6B404EEDA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98B2F39CB;
	Wed,  8 Oct 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF531aTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6F1D7E41
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919587; cv=none; b=mf+MYbP18xQ1fUWPlEXeRTCIQTWejNkJ5uh0ycI39VM6TmYCOu1tWVtVgJY8B6ibMCWZI60C24LOZL+ujGdZNxeNghmXG3FiGy1zH/mCp4o6XYiKDy4pQjVVjQiWCZ0F0E1CVKCClCODOradvGjZ9CfDW/5a1JTaMraq3PcPSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919587; c=relaxed/simple;
	bh=ebKkEsnGtJg9BHiElx4TZYX6g1+ZOgVHkaaIq2OEWwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAa4oECXn+Q560aLOShigCtxhJxmN7+dEslDLy2Dox9L9E4TWbnIygRupf3YiFDvRPyeFywzYX/GfV5kYVgcI9ZdDOiYrL86bsnsIae3ImSpdxbyY37ECJmNLZW7piACnWhgYYLEY0wDfP5NYZDBTJRUsVeKcxwf6tJSqjvAEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF531aTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD38C4CEFE;
	Wed,  8 Oct 2025 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759919584;
	bh=ebKkEsnGtJg9BHiElx4TZYX6g1+ZOgVHkaaIq2OEWwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LF531aTP1JbJUOxrESg6EEYoDCVJUrdTfLI+S8rMdHbE77jCm9TPFnAWvHKMMxUN5
	 npaQ//6cqqUHZhTBaM1c7W1l7ETAm2ulGJRQrUYN8FVcUBKeWTbSejWubh/vtEHyUf
	 XujqXckawG3p6Eg7Kh5cIIN4q/vn4rlybGCHfYYDLDNtXtD4zwSfZ6R02SNj46mgrc
	 u9SyYsJwF55TtANMzQZea1KYbEnvlh2h1UTjk52l1uQ10MzZP0SJjNrh8oy+EbMDRg
	 qKanU/uEyfrHQ8fI44LjH/HsfafjxlLrQyicuZ9JoaYKgl9bropCP+hTIc1JgaA9d3
	 tfQcKtFaAzIEw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D48AEF4006A;
	Wed,  8 Oct 2025 06:33:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Oct 2025 06:33:03 -0400
X-ME-Sender: <xms:3z3maEPgXEJLz2KM41mvujuUPTcYRX6iiSpBjDCMRxygDNtOSlFeLA>
    <xme:3z3maDwe3-HOGSY4do_Gqb7qN0Jo3uIoyw4ZNz2m-kYUMX-r7Z5hlM15zwzZyCoKe
    ZIK8CMsMxD6GCLMMSZ_5nwBsqnoS7RDOQlz3_LwZodgSNEueAuiAU3v>
X-ME-Received: <xmr:3z3maCOCToqIh9PXwKLy6Z6olts7GiYzL102t3BreEgBWIXZyMCiPYIwrdNrdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeftdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugesihhlvhhokhhhihhnrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehshhhikhgvmhgvnhhgsehhuhgrfigvihgtlhhouhgurdgtohhmpd
    hrtghpthhtohepkhgrshhonhhgsehtvghntggvnhhtrdgtohhmpdhrtghpthhtohepnhhp
    hhgrmhgtshesghhmrghilhdrtghomhdprhgtphhtthhopegshhgvsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegsrghohhhurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrhhishhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3z3maGQQEIn_9blyobQI1AT6SA-kIjq1QWm2DQ2Hcg4V1T1YeLICvw>
    <xmx:3z3maFXKjvvo7oqtsl0v32XslPUruNAv8C7amGimTl6qXKpC2wLmww>
    <xmx:3z3maPRmfX_CmQaDOSbs0ExcLsL50UPU2l9c5ix32X8XrdPQoypueQ>
    <xmx:3z3maAtPNXOaxJHYTTGUhOyWXPRRtpTXg0G7WlMMNCjcAxigVG5ocw>
    <xmx:3z3maAao22rxt42G-lDKVLKVh12lCW6sJLhSETLJ_B9JqMPneYJplngV>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 06:33:03 -0400 (EDT)
Date: Wed, 8 Oct 2025 11:33:01 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Message-ID: <x6u2afqqwqpoabtpq24n64owlwagolt63csvaibg33p6t2ywuf@beayabw66enb>
References: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
 <20251007195313.7336-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007195313.7336-1-sj@kernel.org>

On Tue, Oct 07, 2025 at 12:53:13PM -0700, SeongJae Park wrote:
> On Mon, 6 Oct 2025 13:25:26 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > __mlock_folio() does not move folio to unevicable LRU, when
> > folio_activate() removes folio from LRU.
> 
> A trivial opinion.  So the user-visible issue is the incorrect meminfo, right?

The user-visible effect is that we unnecessary postpone moving pages to
unevictable LRU that lead to unexpected stats: Mlocked > Unevictable.

> > ---
> > Changes in v2:
> >   - Rephrase commit message: frame it in terms of unevicable LRU, not stat
> >     accounting.
> 
> Yet another trivial and personal opinion.  Adding a link to the previous
> version could be helpful for reviewers like me.

You probably missed recent Linus rant on Link: tags :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

