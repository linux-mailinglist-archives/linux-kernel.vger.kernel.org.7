Return-Path: <linux-kernel+bounces-845526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B83AABC53FB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AABC34F5DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717728688D;
	Wed,  8 Oct 2025 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBcbjOBR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4D285CAE;
	Wed,  8 Oct 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930825; cv=none; b=FQL9m9Br+0iH7NqNaghUKKVtRgRbJFU8qYTKS1RZULUZXbYIlBfMpX5t3GuXInZGZ/4TP01LoLO5TZSBi9BN2BIjvomIp5u8MotwmHfR+GZckU9IEaRYhockUYyKqN7OsawalNKS2kVbt2cEacUyPc/VGx2CXWcevE2q4cBfLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930825; c=relaxed/simple;
	bh=gHADV8HsikuF0mjbOGzY/svo7rZ6VJOBPJdv1nScmLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6fCj0ODGfpROgde8I8hAoa5znfcSd58GMPwXeMA79Yoi8OgCPzJrVy5rNR232M4FGpJPDaZJL2/Vv/DhXtHlesAdhfN62lesRoFRICHuOLb0SiBcA51S5KSkohqNjHPXxABDAtD3bEoimtHFWhI4gq648wbMOgITK/VST89FbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GBcbjOBR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSR+OAicaMJG7hAOQdZGFYmQwq4m25NNDfS7Fm4FF1A=; b=GBcbjOBRjpqcrTolR56nJh8rzY
	yWqLurKTHGY7dnX/f1klPuUKfN3G7Al+8qWBSQwWjwhFFtCYwTapWKcfGEtEjS0GkF8HwFxg1F+hD
	HNYiwuvhwlOG98YBjchx/OCD/xFUWhMKltbqtP7rqbIgS+eavY+zM6E13GqkaiG5eDTvuII2B7uVg
	DznQMKemRqpDeWyUVu4qtobekFIItRHUANiz4OGms8xyeG4kl4aaAwWAGzhtJqdlwVukcFlmtVAtJ
	2yTGjOX8w73JyzRF6ijRJ4d1u7e+wCmvDRvV5l75uwkGJPtNbAEX0FjJ6pP0EkQyTatslFQG1o5Ki
	kiwvdtPA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6UOv-000000064WR-2h34;
	Wed, 08 Oct 2025 13:40:17 +0000
Date: Wed, 8 Oct 2025 14:40:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, linux-kernel@vger.kernel.org, acourbot@nvidia.com,
	airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
	linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] rust: xarray: abstract `xa_alloc`
Message-ID: <aOZpwUD50MwSBycB@casper.infradead.org>
References: <20251008124619.3160-1-work@onurozkan.dev>
 <20251008124619.3160-3-work@onurozkan.dev>
 <aOZhS9nTDnH3Zh7N@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOZhS9nTDnH3Zh7N@google.com>

On Wed, Oct 08, 2025 at 01:04:11PM +0000, Alice Ryhl wrote:
> > +        limit: Range<u32>,
> 
> The Range type is inclusive/exclusive but xa_limit is
> inclusive/inclusive. They should match to avoid confusion.

... and xa_limit is inclusive at the top end to be sure that we can
actually allocate 2^32-1.  Or does Range handle that by using 0 to mean
that 2^32-1 is allowed?
> 

