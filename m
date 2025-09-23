Return-Path: <linux-kernel+bounces-828822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE92B958FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E5F3B44D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72D302147;
	Tue, 23 Sep 2025 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghCaaNco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAC182B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625555; cv=none; b=uaLmS7+gc9yY7xl05EbWzQm7ZR8sBFfP9HqpODUV9ibhnV3uOYWm2RxW0d1x0NbqlBMw+ivrEOgpDAayFRsN3yrcIP8vdmvoW0j1zOvL8VCzqP8jew4LaYsOVN+uzuNA61Kwfmt4laJ7j9UBtC0ubiEMg2NB3Or+7l7a/kTL/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625555; c=relaxed/simple;
	bh=Jl9yWrfXoB6HlRJDSGLShBUSmOenZSlIlpw7U8A9fFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2a9Sc8PGwko9n+5H9PByY7Xl+F/yuORyARnkJOeeEJDIw7GieieyUX8MokBKAoU+FQUKKYCM0ab8wR8GXOvPY78JFdkciDL+pOU3+hIX4HXxMatnNmTWbeplrxIQjqLTZFqpPIwk0K1WBnimDLAMJ2Vy/+Dzuaecp1iUMsk/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghCaaNco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D4EC116C6;
	Tue, 23 Sep 2025 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758625554;
	bh=Jl9yWrfXoB6HlRJDSGLShBUSmOenZSlIlpw7U8A9fFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghCaaNcoasgWBRkkO38YKDVV2t7HYq6YsOSQeaYxAZ2NhckZBPJPlzf0JNcbm8HHN
	 sF8HuK/99OD72EmMIPkoMKKcvesFaJbBs25wYqe2+A4XHS3jc97cEoRh72CpxCZuwh
	 g4Jq8fK3sA0oAYVxShrMtnxVuer3Rc44NeqEGXqTKPM7uYPblut6BLo6r01JofuLna
	 bsqLfo/vOo9T59GILqXFmhnKOKtnzMJPjwob2aanduSqcxf3rOWwqb3Vg/yk1lebmi
	 9VsebxiInsdYutLYBDK7Q7+IPM6V61MvQ5AtoR0gJWSSVhpxneF1VZgzTKR53lqKZQ
	 p8lTeOz+3F9Rw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 40CD6F40066;
	Tue, 23 Sep 2025 07:05:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 23 Sep 2025 07:05:52 -0400
X-ME-Sender: <xms:EH_SaD_bPa34wZwW6SB56jNGFxlcoKL61cGJyXGAdF2gCG4yMYp2oA>
    <xme:EH_SaNWuBGQldEPI23LVFadfsgN915x9zH_lvvoaYZ-3TDUBys0YmOtrGTcFpAACK
    Bk6sf5E7JFb7r4_C7omfaBTIviI1to203sPe5Wganzehq-VCGHdDps>
X-ME-Received: <xmr:EH_SaIZgpnxTpBRlPzesbWUGbIINDVfwnOOrjukRtTbhs4gAPMAkgt2oGOqEyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    gurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehhuhhghhgusehgohhoghhl
    vgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    hvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopehrphhptheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:EH_SaHpJP4990kbtI5C9lLDUcVfz54a0r5GBKKtK-hvqp8--E_uTuw>
    <xmx:EH_SaP6cVWwHKLlVfFZ9IGcxzlRs3PP8AaHXAnuvUXt1aAU-PhJA0A>
    <xmx:EH_SaBWNN-1n0jEBLUCb-JvET_rybhIUuFWQBZEZk0o95PYDg9eUVA>
    <xmx:EH_SaNs6ojkFOtdu5f2LeXoFJtE0yBg5w0jEGgmMtonDe6Yk6mBqiQ>
    <xmx:EH_SaGrtLDQc9kCjrNzR6ti5Q6ko_Ll3z7XJU2ji0vGNoJOUFD94lQXQ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:05:51 -0400 (EDT)
Date: Tue, 23 Sep 2025 12:05:49 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/5] mm: Improve mlock tracking for large folios
Message-ID: <rdq4t27mqjmgeqhzv3iweihgtxsapahg4yyjcdt46kclawm4vp@agmxwna3lbrj>
References: <20250923110310.689126-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923110310.689126-1-kirill@shutemov.name>

On Tue, Sep 23, 2025 at 12:03:05PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The patchset includes several fixes and improvements related to mlock
> tracking of large folios.

Please, disregard. I missed one patch on submission.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

