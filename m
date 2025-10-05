Return-Path: <linux-kernel+bounces-842458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4FBBCC39
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC7C1893E4E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B1299AB3;
	Sun,  5 Oct 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWfA0YLf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE341662E7
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698770; cv=none; b=dSs6R94zui4G4nHpzA7BIzGtHn6C0KDkAbx2RwQ5YaIJlAFf/cfsQHR3C+djmLULE1stRxzTTwPw9lK0+/9HK2Ty9aDwSLuzqw+tlGOcHHEh5iubMNwNW0H9kI1cMcYwOonsBK5ZabdD54pQQmaBAQz5zyIbTKxEjzYw0XZ0hJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698770; c=relaxed/simple;
	bh=VNiZ3S0bbJlDNUtROeTZVfZv1Yb4chcFYYFoXviApz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3v8IwWM5NaQL81d/ddhwgX7P9OpkPuXgTB4GM7LzF6du+R2MOoTpUogqWyREfki/uvTM7LYs/bCiYzLgaeIWkEDnNqLAIhsI9SlXSmWUlZoghj6YZt4mwT0I7QWW4QsK+/b/zMRi7BK1zIxONmn9E98ZSbtmRjvA9WPwDP0PC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jWfA0YLf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f5fInq7i/nyNioLFzjHE98L6f06svbweNidQJNV3B60=; b=jWfA0YLfpAp0oO6VrDm70DEDj+
	oYwXh90lhU+Q/x5K3EMCmGeYLfQPPuoT2GsmYJ5alL6yRUNoDa+GjgsUGl7JzqilVlWpyeMhY5pN1
	k0QTFsbezIqfsZJnYvt9civrinMQiJWbNO24Qa5TB7T3J5HtQPj5loDdOhHmjy3Ozvb0Ohi+WX7rc
	/roTVt50HpOLeyOjnzvK5a3ykNsyFiaGABHDsTiKT5Jdx334tpNsArlccgsxuBD/P2jbhm8E6WtRU
	UETA/CcQluUJKvE7io2P9Mvm7Nu/QuDXlaxet0sK9HPsazD3tn1h+HhVlvlbNw4pyl6uvuAFXTNWs
	R/Ul7KSw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5W1q-0000000Fzvc-0pDl;
	Sun, 05 Oct 2025 21:12:26 +0000
Date: Sun, 5 Oct 2025 22:12:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Remove redundant __GFP_NOWARN
Message-ID: <aOLfOUgoEskd8jyE@casper.infradead.org>
References: <20251005124329.28708-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005124329.28708-1-wangfushuai@baidu.com>

On Sun, Oct 05, 2025 at 08:43:29PM +0800, Fushuai Wang wrote:
> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> -			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOMEMALLOC |
> +			GFP_NOWAIT,

Please just remove the NOWARN.  There's no need to reflow the other
flags and break the 80 column limit.

