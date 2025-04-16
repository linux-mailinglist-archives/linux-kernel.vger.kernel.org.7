Return-Path: <linux-kernel+bounces-602755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4189A87ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0221762CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157729615F;
	Mon, 14 Apr 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ImWuw5to"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787114B945;
	Mon, 14 Apr 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629298; cv=none; b=HJmItzj3nQQjQMSABP+eBsU7gK6OhnZC2XYaRgv2ZeLUpc6hwaCGwrOIiS/GuF5EXLoBstke1OUkkP2breb6G6VqVfDZv+UOmesDuZUl0h40v7WXqgU0IanLlWDhKdisHb0Myz2xCLgYWXQX/io6WcSXAdHtuJUMDTZ+cLqEM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629298; c=relaxed/simple;
	bh=flJqvMobFZh3FwTRoPTH/ez/ycrQSv+CBOYXYJORcwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBtA+3q3tT4pXLLqee1IvEK8gMm7Ig4pf/BY9W56gJdraDNHm9/+oM1s0yC6wB02KU73Sgh5XQ4hx6cI3vbUWHlrkYcbGlXHTnzI1UelEJVdSbdo9GIgVTRoWoi/rBch12oVl5zDha5fQ6ySZe5daRbb7YBZd1DtShIX6tW980c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ImWuw5to; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lA6D4wDYrR943Y2TW0Vrd2a63WSSLIFuyBx8vVO5YVE=; b=ImWuw5ton6/yrgizFFj3QaX8v5
	7K57dEB4sx1+BYkDJYezdEJDy9qEUJHkVC6ikkbeGHhQUeGxG+awz5Gnnr8+iDUS23nUyawWwQFvG
	gWTqjhlupO+6xVnm4W0vI6OlvF+tsGWLuK7AGOAauk+8VnhkLixA7Z1EQcKoArBNlG5fPqR6gQ31w
	6Z7Rd2ugyioYNo1wEW33zosyZPDXCuw5ULELZfaRCWVGep3hlRzD+CtLi2r9gq1z601cp6hQRZ2AS
	f0VqlUqhJEIGRC7i3m1qFUz93vdO6/ve0HxaeZUuVWgX3aiT0XLnLiF3XjN/mzvrifAiY1loyxFJs
	agw4J5Bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4HmB-00000001iLS-2PsR;
	Mon, 14 Apr 2025 11:14:55 +0000
Date: Mon, 14 Apr 2025 04:14:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] dma/mapping.c: dev_dbg support for dma_addressing_limited
Message-ID: <Z_zuL6tIjeTLTNKK@infradead.org>
References: <20250414110647.3294017-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414110647.3294017-1-balbirs@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 14, 2025 at 09:06:46PM +1000, Balbir Singh wrote:
> +	dev_dbg(dev, "might have lower perf due to bounce buffering\n");

I don't think that's a good message.  Report the actual observation,
i.e. "device is DMA addressing limited" and not a guessed conclusion.


