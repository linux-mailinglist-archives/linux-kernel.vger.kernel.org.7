Return-Path: <linux-kernel+bounces-720599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728CAFBE1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709E316F287
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D7428A1EA;
	Mon,  7 Jul 2025 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ja1XJnJ2"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361BE264614
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925985; cv=none; b=smLG5lKXRWmq7SkmHVmO8ZURu3wmdieID9VdDR/OdmcOWg5rRuUciW4Qi2hBYQVv2CTXQ20BUSc8lV1cKHQY9nr3SZEH+DL3Bynkn5P2gY1D0YuFID7RLm+vE4uTmpKHHCjeK+13tLHS54dcfEbOXhAHx1tAHsKBEBC5rDHlK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925985; c=relaxed/simple;
	bh=yjlbsiWN61ToX4aXR1qNhD8hMvkmfEPy9H2+13XQ3xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL6UP6zvIAceXQOIspvXm8KxZ7sElmFiyypRCPjs147D4Fc3gVVBC5qDtCs4cY7MCbeWSPFJ/rPG/C7bk9hZiKH31ydhTz5p5rBy5rSUeAwq2qvo2Hv3LHHz/hoxa3s7SJ2ngCDz8c8r3keEXCFEjB+HqIKOL3WfzKjQCV+0nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ja1XJnJ2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=24ui3t+rwKJxfbKwDpGvCDr0arQyBRc+57B4RFBPe/I=; b=Ja1XJnJ2vgxfuDJnWCze+C7vVN
	XyzH1yg4YjS0a0urFlR8LVUnvAmeq2y6NQ+ap2EdGeqkpqc9aGbcj1TFzT8qakjZIiFq/pdKmExOa
	XvZThPHGLTMWJNElJIpK7OJO0Ka1EgbosIju/yfnKUAINHGpB+2l7QJYLicC6XJi02QXjX2kNmPlp
	FC3BXhZgPoF7N/t1CVMUFS8WJQw5KHzWz3IdnR4UPTajah2j5zgIoEifeFaIz9Zr2RdyB8WH1yh1P
	DIV2KCDs0bk5V3/T+RwyrKl07P2JnQc5Zdlw0CRaOqTjeVPWp1k/+6og3xcikX8mZO4xYvKlyskwZ
	1oJRF9CQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYtya-00000004AhP-1kZQ;
	Mon, 07 Jul 2025 22:06:16 +0000
Date: Mon, 7 Jul 2025 23:06:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	usamaarif642@gmail.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
	ying.huang@linux.alibaba.com, akpm@linux-foundation.org,
	senozhatsky@chromium.org, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com
Subject: Re: [PATCH v1 1/2] mm: zswap: Per-CPU acomp_ctx resources exist from
 pool creation to deletion.
Message-ID: <20250707220616.GN1880847@ZenIV>
References: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
 <20250707201315.9497-2-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707201315.9497-2-kanchana.p.sridhar@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 01:13:14PM -0700, Kanchana P Sridhar wrote:

> +static void acomp_ctx_dealloc(struct crypto_acomp_ctx *acomp_ctx)
> +{
> +	if (IS_ERR_OR_NULL(acomp_ctx))

Ugh.

> +		return;
> +
> +	if (!IS_ERR_OR_NULL(acomp_ctx->req))

Ugh.

> +		acomp_request_free(acomp_ctx->req);
> +
> +	if (!IS_ERR_OR_NULL(acomp_ctx->acomp))

Ugh.

> +		crypto_free_acomp(acomp_ctx->acomp);
> +
> +	kfree(acomp_ctx->buffer);

Just what are those IS_ERR_OR_NULL about?  Is it IS_ERR() or is it NULL?
Either has valid uses, but mixing them is not something you do without a
good reason; there are valid calling conventions that allow all three of
"address of an object", NULL and ERR_PTR(-E...), but that's not something
you do just in case - there should be an explanation of what's going on.

