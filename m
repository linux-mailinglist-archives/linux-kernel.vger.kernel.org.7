Return-Path: <linux-kernel+bounces-861171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF232BF1F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6180618A1465
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AD223DD0;
	Mon, 20 Oct 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zmk6PInW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED38EEBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972603; cv=none; b=RQeMtvcIeWPn38fYDVJTBAEI9RjmoYMppAut3m3hx8tt1kinjUvZ/CGft9MZvfYgaeSKK5EBWtUjYCKkr2JrO7PcveHGoqIlB3F01s4a/JkA5R5VsMIqnYel+TKLX96MGF3l73GtEecwVyhcWB26EeQ5zgcKgNRRfWD/ng2EHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972603; c=relaxed/simple;
	bh=Eo7pLM5///tsJx+s+lL8XjzKp9xGdxTEzdfo4sL5+I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvMj6oC4q2eBNLvhjEHEbbRK+zKhSQFufLREfv+DIdYCX4ojVPg3lEhhswfeKtVGlY90kH4hnmORChxcZqF+l+DTOnIZgiR9WS/HnlfKm8ySxJV/YQM9zvdnsbfiMzxcyrUHWwxuwvn8jkCEjMROAriQCYP6Ct+NiDWnATgXUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zmk6PInW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N8X8pqUQUW4Z+Rt7QOkygcvaKaPAI7KjzZiv/eMUcOc=; b=zmk6PInWIWOrOjmPEOCrrS5Otr
	f/gTxLZIzY4thlVzcIT2D3tbmi/H0AZHklJh1ePUo4OKBNP0hGgjaJGPIKb13M5AjZF9xRqK75XeN
	lWqQRfMXW8pYjpotsQ1NpDD1z0AM4LWSEq5Z6SPAIm5FPpoUFwxYX/pQaZEC3yL1sHtFpJouexaiD
	c5PpRUe6IWUefB/338ZDp5Xr9PQ4KyaTg9qW66EW8opvvzDJIWssD3QiLH1+vatFMxPPwm11Q3wTg
	2yVbZnEF3wSGZ9fIzh7c2RWq95NYGPHn1jE4YoyuFa4rkbBG2OQd6B2L4YBlkpWm754Ey1AnwWmFy
	kzgzrQVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArPs-0000000E36G-3MFU;
	Mon, 20 Oct 2025 15:03:20 +0000
Date: Mon, 20 Oct 2025 08:03:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux@treblig.org
Cc: akpm@linux-foundation.org, hch@infradead.org, terrelln@fb.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/xxhash: Remove unused functions
Message-ID: <aPZPOIfOSUamfyzH@infradead.org>
References: <20250716133245.243363-1-linux@treblig.org>
 <aHezAgl9CE5RBPxE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHezAgl9CE5RBPxE@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 07:11:14AM -0700, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, with this, xxh32_reset, xxh32_copy_state and xxh64_copy_state are
entirely unused now, and with that struct xxh32_state as well.

