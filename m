Return-Path: <linux-kernel+bounces-841950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3ABB89A9
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D884EA37C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F522068B;
	Sat,  4 Oct 2025 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V0HtQyjl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD022069E
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552964; cv=none; b=S2lL621l9ueWa9YxnhW/3pHrMIbP+u0c12FJjc6yP+J1T729+69iQjVqlhM9j31h9/8u5dEnlulvTRfKZetBfF8+vmfzwcCR0+DqBJ1LaFrXd81AgdB4cIN0XduxkeKSQ9vzVaBrTFlBVxBkATmRe8CwMIROygnjqjTmDyElMkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552964; c=relaxed/simple;
	bh=COlSqSk+GP3pDExGIJpq8RCn0bVLUvbAyvoI2H3wCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBEuT1dcWyKHXg7CUTliS0FlB3GopyaZC7FNusabiJQ3TIypwBWKI/HyoLdZtFnkABUzYc1Yv/z1HZE0MPf4fbd2AGYG1+SricTbZxarQJ/HigQWR5pYdTPHAvdzT6E4di2Ge29Wt0+yQBwBwGEnk4kAGYwCmchfP2vJFjOpVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V0HtQyjl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B2rX83wSvogEIoSKlftiJiNsNFl38Jb7n6142/8y/mo=; b=V0HtQyjlx7mp1QwzuTShQAynL1
	cA7VkTnp9GA9Is7gUHCM4YfpKh6CfExqoWJ/92npYIJHuycRMvNdxnJHjySEsoYLaE6LhANYlICHh
	H4vx0/qlB6feNQOAnS3EOR5kr+BwzilFbo9vXWYq9hHkGmCDsJW3jhBF0k9bTffa0BntMfAE0pMhe
	qabA23NZ4OGqT5lwKPTrfLPU/ivRq+7+757/VgJN0pSfuG4sb5hOLcm/SKvi12s9Y8WkjMnXgCtyF
	6YKOJzhtBi1HJa2MC+0FA9ZUSvvpaKELOf8eW28xmSzvKx3HoV1MWPqZBoijeAc8d9s9M2X14bSpE
	IO8y6xwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4u6T-0000000DSho-40RH;
	Sat, 04 Oct 2025 04:42:41 +0000
Date: Fri, 3 Oct 2025 21:42:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Message-ID: <aOClwR1pOQodIBwC@infradead.org>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
 <20251004020049.918665-7-kent.overstreet@linux.dev>
 <aOCfLTDYR83WS2CB@infradead.org>
 <73o2borvbdhb7j35zigv5ua7vgjjtt4pohbb77eolflgp5q4zu@bawkl5ykytce>
 <aOCjWdfGG3QiT1QX@infradead.org>
 <ri6hb5q3i4t5jdfahmyp5wox3fqlyndnu3vfpsiqr7zbci7j6f@un5xm2rcokld>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ri6hb5q3i4t5jdfahmyp5wox3fqlyndnu3vfpsiqr7zbci7j6f@un5xm2rcokld>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 04, 2025 at 12:37:21AM -0400, Kent Overstreet wrote:
> On Fri, Oct 03, 2025 at 09:32:25PM -0700, Christoph Hellwig wrote:
> > On Sat, Oct 04, 2025 at 12:29:15AM -0400, Kent Overstreet wrote:
> > > That's been the primary purpose of the lib/ kconfig menu. The current
> > > language is no longer quite as explicit as it used to be, but here's a
> > > recent example:
> > 
> > It's not the current kernel where this got fixed.  If you find others
> > instances, we can fix them as well.
> 
> The current language is only slightly less explicit, but the underlying
> purpose remains the same.

There is no such current language.  It is a non-selectable symbol with
this standard help text used by all CRC helpers:

	The CRC16 library functions.  Select this if your module uses
	any of the functions from <linux/crc16.h>.


