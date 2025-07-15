Return-Path: <linux-kernel+bounces-731239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A5B05188
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23BD165F04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCFE2D3A93;
	Tue, 15 Jul 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vlsoBRYW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C325C81F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559746; cv=none; b=hhwLcjVsbvG5a5+3si0X7WVojBqOedm7F2PcEn+scvA0AkGRg3AmxxyGEQlaWSEno95Wsh4S3XPQnxO5MEVA4bfAjtLYKMSa2KFpNPSYiX+cnTo+Jb/9rTwxxNBXHYttCSpL0fAVd1RNu1R2xnUGHqm3Tao48nUdGZrvT58jlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559746; c=relaxed/simple;
	bh=cUfZaH7K5rkON72wYTsEjzlkkxKAzps92VniQYTWdUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFw6Bm68UlZdRQwnDQhcqOtpqa/4EPIDC2icwCyUjd1XVxka3lXrRZXSRojfY3omkFtwUFdoGiIpYAcX4nauc1K7Zj5W37HPyPloHLCa6xGXUuFTlJiNpuSNf1npEhSQXUcTKOwIkr7H1mYSDU3C7aDhpOi2j/2HhSUDPOUXTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vlsoBRYW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oG+tyInimIZAVic5TXi1PtfzVcuPNgx1Yy0cLCu24Io=; b=vlsoBRYWJGQJjIzLLNCxAEfme4
	n8jzJ/IfgWna6bThp/UxjBWeKwhTbapQQM53Fy2b4IPtoBwHzQbvOYyxOSJTXJ3a+6MPWO51E6qx3
	KtI0FJ3mBdPHCekHahD1icIjHGivq2lbNv4+3f2lWI5w0XLmbm0AlR+J7pejv7YhNODujjR9ECwTT
	Jg9W1V18EpPjpQXNk1pwe5lJhkck8i8LIFw6OTeqcPweO5Ak3bxFJVy3yXIHH73/0pQ0QPNUQbmiG
	X6FAXqg2/1ZpC2JXGdOowxwIkvEa+LP4PlAA+jb9CIUw6lHkVWRvozNFRx6+7Vd9/Z9mkcIC5jI/G
	ZdZ5aUDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYqd-00000004BGK-3dTn;
	Tue, 15 Jul 2025 06:09:04 +0000
Date: Mon, 14 Jul 2025 23:09:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux@treblig.org
Cc: akpm@linux-foundation.org, terrelln@fb.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/xxhash: Comment out unused functions
Message-ID: <aHXwfyKRvXi5AZZT@infradead.org>
References: <20250714000927.294767-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714000927.294767-1-linux@treblig.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 14, 2025 at 01:09:27AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> xxh32_digest() and xxh32_update() were added in 2017 in the original
> xxhash commit, but have remained unused.
> 
> While I've mostly been deleting unused functions, this is a general
> library and I see erofs is using other bits of xxh32, so it didn't
> seem right just to delete them.
> 
> Comment them out with #if 0.
> (Which checkpatch rightly warns about)

Please just remove it like all other dead code.  The same argument
that folks can easily look at the git history to resurrect it applies
here as everywhere else.

