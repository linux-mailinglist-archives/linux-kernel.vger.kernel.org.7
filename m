Return-Path: <linux-kernel+bounces-857388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20326BE6B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A64C74103C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3130F55B;
	Fri, 17 Oct 2025 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jvaQLBcM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8E30F546
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682397; cv=none; b=HsQCGM+aD7Hp6Y39NHlro3uTklpLQ4DPSihjGiRnlbp607IbnPF9CjIFn5s2LaEFc0Y3gdN+vhrCkJGnvKuSY58saPrUuEB2UYampUfb5nJCGXoCKCyZl09zrL31hXZ4OkgtBU16QeExa9SHU9zYjdVJskbEct7K+mKAjMV8YJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682397; c=relaxed/simple;
	bh=gO0EQRqkrVqNRhjkGDZP0iXsm7XVhqjAb3B+vJcWFz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guqwSsEGAeezxahM2cWuj3ewszJCyu30kjLcfgoXoIln4LonhREn6UOPQZgpzXCxNRlL2Byk+PhyImYslJHcDz8naSRc7qtjR0z6w2kTsljWJyPYfR8sAUnFmOa+tPDCqSRACqB4hcefay011HeDMC+llyzy+5/NGikv8cYvxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jvaQLBcM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rU29rjhtuTpWekoIYN+zSQ9GeojelStKrMZNJGlnzGE=; b=jvaQLBcMCFAn9BZ776Qg3ylVkv
	/ur/W4ohFRJ9O41BfXUukw70dG1wES0rRElz3ekgbDWgHCQ6bXLv/9PXnKnyAbIjz01N2ZiiGmVMe
	RMbpEKKbcyWESGUfJzYHOFUBg+54MqVZu/dZDEtA2dL0sEvHXF2FqbWJQS0WIUVEIFfGuMeUGp7lq
	8sntHIJZH/JJyllv0r/aj7gLN3dFZ39JAfOxlP7dl/c8SHBJkELUA1TLNVGrPyhVKWhy+EIAz7aYd
	MykAzaDDp3qOB+WOIn3Hijpmzu3Xdkg/ubp+GMmYJxM6MGqQl4M6Li38ajagYzL4oJ2uEn3GYGYyM
	EeCepZ3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dv9-00000006lzn-49l4;
	Fri, 17 Oct 2025 06:26:35 +0000
Date: Thu, 16 Oct 2025 23:26:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Support RT workqueue
Message-ID: <aPHhmz1C7d9vt2x8@infradead.org>
References: <20251016102345.2200815-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016102345.2200815-1-jackzxcui1989@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This seems to mis an actual user?  Did you accidentally only send
patch 1 of a series?

