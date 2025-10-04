Return-Path: <linux-kernel+bounces-841940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F9BBB8954
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 593B34E5253
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFD262A6;
	Sat,  4 Oct 2025 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCGg71qK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E782566
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759551356; cv=none; b=Sy/Mk8Z44wQjdsTFvc3s2if6BDsBzXYH+VfYU9fEmcGjTNGy6bojS2ctuuoa3qTXApeQ7vfSSCRi/89iuuFu1B846OgDzklkCbHJwgo+qAyB87aSjIBRjaxmZ7Dm9aL0aPkEPSN07EDjJjSJiOAS9Ee7hKmClWP9JEsQtCMdjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759551356; c=relaxed/simple;
	bh=KX7OHZjAgWli4h0u38QCpi612gc5E9omvA+JKdosKTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvnm5AbB1dDYa7xDjr4ExwLcX4gTpZpV+4ekk+0Nfs56zhUOJteU1glYJZBobNl0/KKTwNCv0kpvN5rQkH7iRLCu+L8+cBPKLqoVpOH+RfOVN7bGXE+rZW2UgLLLiL8uxf8YlFdTAxA3CiT7cmmIKRpf84ggINSSaoAi7gUeiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uCGg71qK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4R2kyl7Ct8dUMzyD7ThtRGq6nDvxi8kOO1+mphzOkxI=; b=uCGg71qKRYSRr9ividiBKjYhW8
	nuMfElVLK3qIG2s+PJstHqM7896ulw4LgY7AnawLlEuZ71Cs+yeNKn5L0DSvv/XWD8ALvYqPOHwhU
	zDc0FEbC5O6IGS65HGSVDVSQCBhhWU+vDftoJNeGxnXN+rkRVhrv3tB8dQBhJI/tiCpvTWlDDZE51
	xY1K5E4qz7yVqG12b5G27NGumEQLQS4xQZUJ+JBtDQ5T0AK6chZ5Ke+oDGTubGIPpVWN3kxOQgtwk
	1GT56n6WCf8XVZXk78EBKhccLUaNEXcQJiVN0EQ5GRL9ha1bVTLYPCskn+3Ispgw93dAOLTy0DOxx
	0RzPhNOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4tgY-0000000DRX7-1CQl;
	Sat, 04 Oct 2025 04:15:54 +0000
Date: Fri, 3 Oct 2025 21:15:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/7] bcachefs out-of-tree series
Message-ID: <aOCferuW5V61WMQZ@infradead.org>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004020049.918665-1-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 03, 2025 at 10:00:42PM -0400, Kent Overstreet wrote:
> A few patches for out-of-tree bcachefs.
> 
> Since bcachefs was dropped from mainline, the kconfig tweaks for lib/
> are needed for it to build out of tree; they just give a few config
> options names, so that distros can ensure they are enabled.

No.  The Linux kernel is about in-tree stuff.  There are not exports,
or especially Kconfigs that make things confusing for out of tree code.
Just like everyone else you'll have to live with what people do in-tree
for in-tree users.


