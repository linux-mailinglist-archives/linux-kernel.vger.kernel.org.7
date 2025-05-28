Return-Path: <linux-kernel+bounces-666249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04DAC743C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E601668E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A49220F49;
	Wed, 28 May 2025 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ieCAWUje"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA94A28
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472982; cv=none; b=iPilHX67I4DXzZ5OAiUnlKV/TQz/fdyxl2YNRvgGSQ7h+eSsT3c7meAm3MeHLe74szeoYScHkna4bfG55U/Kx8uYw+CW3ODawxFr6Tafb4snWwpo7lYwbtd20cxGWudbZtJ3vXAkOJZuyNb2TpuewY30q9Sa4zKW70RlBq9PvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472982; c=relaxed/simple;
	bh=7DQNhTREekjlgxM+5yXfaLTsh0P14mKXyK172q3zLVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGxRxUdXVL/js2nK123Ln9NchlLAeHUlCbWQfu82z3GYpFLC5MfAjsCkY/ksFcFupu3wqZ0fDg20Mu0KwMMzMg6Nzd6VG36Xxh4JLeHLnRhuVZEAA5Gjwx9kdZ0a5xJoCy1FraAXYA+4W+kx3dTb809Od8mXIVxHPn3oNDUxeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ieCAWUje; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9mVYSomClwkuW9XSpB17kuYPC62FLZMq5IEqmVZkEdI=; b=ieCAWUjeGPxpBEAwBfSBWn4Hz4
	d8GLRld0643srXL6C+PzeKx67BEsXCzM/8oaH+/IeQAcZ+HysNwvpq2iXqvVm8mCY2Qd4V7k4gk3t
	yTxy5ZBlFcZruXqFB1g4BenYXZrGziBXeck7ALUCErgWIJqPZk+1Rwq5sk/bngflVzSpvWHZZik8e
	KhhgvzAk1oAb2Rec1v1v7uXlKfzoyxaphiGcQelvSRT5260vFNmRlz3kRa4dtDobEcPV+imXdCUpi
	X+C1wtGRf87CwBk0ZAMAilDMWu+DPB/4/ivjp8ClGiOkmmhjmSOxTuhU9hyQOwXYkFxAuB94Sn0EC
	N25IX79w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKPh2-0000000EAe7-3cB4;
	Wed, 28 May 2025 22:56:16 +0000
Date: Wed, 28 May 2025 23:56:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de
Subject: Re: [PATCH] mm/hugetlb: convert hugetlb_change_protection() to folios
Message-ID: <aDeUkLGM9l_twtT-@casper.infradead.org>
References: <20250528192013.91130-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528192013.91130-1-sidhartha.kumar@oracle.com>

On Wed, May 28, 2025 at 03:20:13PM -0400, Sidhartha Kumar wrote:
> The for loop inside hugetlb_change_protection() increments by the huge
> page size:
> 
> psize = huge_page_size(h);
> for (; address < end; address += psize)
> 
> so we are operating on the head page of the huge pages between address
> and end. We can safely convert the struct page usage to struct folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewwd-by: Matthew Wilcox (Oracle) <willy@infradead.org>

