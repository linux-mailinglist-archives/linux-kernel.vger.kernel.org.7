Return-Path: <linux-kernel+bounces-819413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9984B5A05A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BDC7A5C84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726142C0F87;
	Tue, 16 Sep 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPptwNAT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D547288C3B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046466; cv=none; b=Pu8gmtrng0XU4HZto/1OeKm+oKjB0AmwhB8zCRrNiHFOuWkXll/a/ljbEM4908IHo1eaW9wtgJ63YbwF3RiVxymm7iSAdGOqNi7rQkgbW1i3/bBi+BDGuEN8j9v+uYPeFkzAukf866qBWV/LLtXQqzTeyd5uKhgacXxcTjkH7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046466; c=relaxed/simple;
	bh=2i6fQUpEXrYsf2ddY/gQJ4Z5KqBaRcGFzRpKksGaMjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL0xaVOtQozWVIpFciFtJ3FtAkSOz9Yv/M2JCBV5KLZ5cZOEcvwR0XfpA1NEW6Uozskb+g7UGcCvFpvsgoVrzOLN9joVfEonhpJzYTJgFguvpOkyvB5CZ9B+6ftjxx7vyEfX6uuuIK9urBLYTdz0rcEQCDT1cjQZFoFXnxEZB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FPptwNAT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZV7El7YGxmlz108yuF8N3muYpMbWywieV23Vjsw9B0=; b=FPptwNATr3c1vKuLLVIxeSk5FE
	poxZ6Rh1dvntHrkbjN54U04RbWtn+QIHQjEuhzBGuCFu4QFLlHX7J3BHAqAhsykgyDrpdUVpQVznu
	ONkmZXbrTlJemrlaKzfpL4ZKcSDuzz4apP3CfaeXkge45UXAa9Dyb0W1ue50BbTBN343R2ekH2ymC
	qSryiQJEaTX/1y+YlbMdpp/PnKipYgyIZVEukrAXvKG8Ng+zuzWapTVrY9oR860lM9RaQzWGM2o6M
	aZhb2eOQ0R5pKZKUYyuoY7igXRcKblMD1RuRiNzs0g3TYeGucnypeWGnis9X8vFJVx3Sj1g3Ml5/G
	mHaoM5BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyaC6-0000000A6m8-0zbY;
	Tue, 16 Sep 2025 18:14:22 +0000
Date: Tue, 16 Sep 2025 19:14:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Longlong Xia <xialonglong@kylinos.cn>
Cc: akpm@linux-foundation.org, david@redhat.com, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/ksm: remove page_stable_node() and use
 folio_stable_node() directly
Message-ID: <aMmo_oXbKsed--QV@casper.infradead.org>
References: <20250916080533.2385624-1-xialonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916080533.2385624-1-xialonglong@kylinos.cn>

On Tue, Sep 16, 2025 at 04:05:33PM +0800, Longlong Xia wrote:
> The page_stable_node() function was a trivial wrapper around
> folio_stable_node() that had only one call site. Remove this
> unnecessary helper and call folio_stable_node(page_folio(page))
> directly at that site.There is no functional change.

I just sent a replacement for this patch as a reply.  I've been sitting
on it since last December as it didn't really feel important nough to
send, but if people are going to try to do this kind of thing, may as
well do it properly.

