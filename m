Return-Path: <linux-kernel+bounces-741877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A261B0EA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DFF1C80D07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7817219A9B;
	Wed, 23 Jul 2025 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1Fah8OQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A457523A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753249003; cv=none; b=GhY63WjgBwqR+IWqlwLQYGcsJrjNI6aNLdOuXecf9FlJT4B8s3K4vMTMH4HI8ECkQ5PZM+WljozOVB3JN6TzYfkm+mUOWo7sC8aBFOrA7bsRSWMEZ90ptbOa+9vb3bbs+HA2Pv91bwv9xyqSeq4li9zxJxpzU2bhvFTi4BbYblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753249003; c=relaxed/simple;
	bh=pOh6HAX5WXdcMDXnvHXu6ItbVCb/zUSxlocOG7DxtRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOOz9Xyl4Th5MIeWxYjf7xOkbzzGeP4L4c1/QjiKJRI6wWyqIV6K6xNLXYpju8lICJm1tHYOV0uoquw78e6LYv0oyzRBO85YTBexo47szZxSXC85dV2ujWf721DVr637JnLthtQzKQqlLb27dP3NNrPGABImgISpOoV0TuqL79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k1Fah8OQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lriBSHQn9T3/tnkp6FVPWjsBUy6Y2i0Py2+kWACQ1EM=; b=k1Fah8OQgen41BR0+0qCE2zg76
	nYycNUiXv8aREKUKtfwW7g6l8BOc3/rYwpkuRSgUq9QZxTrIvA6dqaS1pT7yrgAL0u56Zk2SxWwUY
	R4M0h1oFfF1gSJjuyhekU+CSeoEVCPomDrE8r90q+m/KtvYR0c/9eqp+qQpdVdrnUsJBZ9c4V4S2W
	kUPOUFNV1WgZDOFTYVkGMIm7r+9wYd+F1Bo8DZ0VteqXfubO2el+Hs5EVcRLSFWCKlhCK4GH1gbi6
	O445Sg+YZM7Z4L7PfPGsOqStOXZ71DBTPC0HKOuq/OMTB3hj/B4ANkannEIc1eMcTuuRqkQs8lti4
	WRMjlZJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueS9c-000000044LH-3hQv;
	Wed, 23 Jul 2025 05:36:36 +0000
Date: Tue, 22 Jul 2025 22:36:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: add further core files to mm core
 section
Message-ID: <aIB05LvNW9-VT82I@infradead.org>
References: <20250616203844.566056-1-lorenzo.stoakes@oracle.com>
 <727b5e89-89d7-4abf-a93c-8d6f2cb2c438@redhat.com>
 <aFDm0YrbSAvXc5Wp@kernel.org>
 <33c605a6-2b89-4b40-ba80-ed2ca665ef5a@lucifer.local>
 <bdca2e2e-acdb-4ea5-9017-6c1a58353452@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdca2e2e-acdb-4ea5-9017-6c1a58353452@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 22, 2025 at 04:22:59PM +0200, Vlastimil Babka wrote:
> It seems it only gained its only user in b739f125e4eb ("i915: use
> io_mapping_map_user") but reverted a month later by 0e4fe0c9f2f9 ("Revert
> "i915: use io_mapping_map_user"") all that in 2021.
> 
> Ideally i915 would be converted again with the revert reasons investigated
> properly this time. Otherwise we should remove the thing.

Yeah, someone needs to sort the i915 mess, and it's sad they just
reverted things instead of trying to understand it.

But until that happens the code is dead and should be removed.


