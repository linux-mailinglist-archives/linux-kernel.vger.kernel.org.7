Return-Path: <linux-kernel+bounces-855634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF238BE1D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA9D04EFDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B72F6188;
	Thu, 16 Oct 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwyNz677"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9772622
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597879; cv=none; b=cHE7QPFtMeqhpwszFjw8qGThXhtPpPW/U1Srbr6P4cY41QOUZV7IYOeKaCpg1pTTfwbj14vLzNuTDrW9DP4HYFc5Ex7qwENLAWzWjkYtCz2UWZblitqiPXShxnUNJUo+Ay2XahLXBYFgGxk8J8yW4r1Qb7Zl3h+2vCrlxmLIJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597879; c=relaxed/simple;
	bh=DeaL/6/F0k+KE8VbkyHWhazA7jLhm2TroeTY3arghKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2yUwOArZ7pxtsyVdzL3acxLHMppoDN/wL+Wk7a2SgqAk+6mrxNzU9itCivyQiQreoF/Vb8I+mvSjDr14ghx8hPaWTgCpQ2plqgjB8KUM8vscw2WcUg1jqvFCfJIfvOvPMQH5XSiSv9ZzAaRJl3mcT+N38K+wjfWfWqKZFbhWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mwyNz677; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XulptzeQVjTI81nNpea+p6XosaJr23PZsPFoPrIZ4hg=; b=mwyNz6772Xgh7BHYCFzvQ8vofC
	NsU/Rl6gg7qRPAZ6e+l6eUSz34kLtphlFUNzqTj1f1G01M8rhzmsJv0HGTyRKLHkgvzUYFWZbadCb
	DTfD+6n67nczeFjaH1syiGV33BN+OVfkQWkiPECnrpp/vnDW/tDpFbk3NKisCF6XvUUVQl9Hs7Mnv
	MsifGu9JU+Hxv/KM+MqWuXyugbykFgbFlWPBMvxhAb1vHgWi6ZkXGW4vfgK7+sQcXQW2asSn+Kycr
	vQUzGPsyEihrPwShYdq/hYe0HH3jR91OwHSiKVwLT1JuCWfnmrPoR7IkDhJxathjRm7AeMFLHMegG
	EpGWCt3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Hvw-00000003hfD-3e4n;
	Thu, 16 Oct 2025 06:57:56 +0000
Date: Wed, 15 Oct 2025 23:57:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPCXdDPlBMdfFQgK@infradead.org>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO9Z90vphRcyFv2n@milan>
 <aO97BjvNZNh0UV3u@fedora>
 <aO-Wxj7al7I-IadV@casper.infradead.org>
 <aO-k2hBimow9oYuR@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO-k2hBimow9oYuR@milan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 15, 2025 at 03:42:50PM +0200, Uladzislau Rezki wrote:
> Agree. We do not want BUG_ON() in split_page(). I think it is better to
> control this even though nobody invokes vmalloc() with __GFP_COMP.

Please explicitly warn and reject vmalloc calls with unsupported
flag.  The fact that many flags get silently ignored or dropped or
could lead to behavior in gfp_t based interfaces is a constant source
of problems.


