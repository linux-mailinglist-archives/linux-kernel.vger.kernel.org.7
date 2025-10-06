Return-Path: <linux-kernel+bounces-842964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37477BBE154
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF981886E20
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C896281357;
	Mon,  6 Oct 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RgglGhGd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFE1F8755
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754804; cv=none; b=jsdduqOfNBec1ZrAKc0FHAgeEqauHOu1Fq+FWqfxoK5XAa15YTenyMAP7w8ZRnYN2Av2LNg2/3n3M9aj/3rhpcxWLEoul1p+kZHln3WNcyCY07JYYMDtH868PTeuCFXQ27mqH058PUxi+asNXlxAvbZDfgYllVY//1jrkPxsjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754804; c=relaxed/simple;
	bh=V5uOzCDRsTqKmQtEECBOJ9TTkN2NQyreXc33xeNWooo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLYQlTCjT5SMkQWXd/v+0knXvUs2zR4OWq3i+zngl6t4o/7ZL37n2DAPCrjioTM1RHUTnlSyDzmzvOw3FIgHwYWrKTwb6PTC7tNkHVx9dyL+Hom3KcfUNgXQbl2irWK61eOLngJIjNQwRJJjMYoLYG15p+gAZkn3aj76l06IoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RgglGhGd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SKIfkEuRoM1ksrm9lNdfsOLR0kjGqecAsFuMqeyGJgA=; b=RgglGhGd5Bv4QEARFDm+h+rLNv
	Q0sb1Kt+Z3j6EYIwZ9YCiSRFUcGdbwpL+uc2yS/Oto59Y7hemGwPlbZCc5eefemRkVGP7j3efWKim
	zsyspHqZJSjNqvFslUodsbJyIRkwJJyK9/Y7SOtFjr8JIT3MoUXeTkuW5JM5QdXQwdHQc8mGch1Tf
	pG6LoBNPJcX8D7EyYvYTugQydCZqWAPNsqW1gZJu8j8GQRI+A56cvTgRJjs6vtjz9dPE99PLFvGG+
	m05NsNgbWTfYKs2MmRFHeBOz9+141Ccqos+3e+5XnmfDNK29t209VGgU7wuC5cJkOMTyNuwaYTV+R
	nDJKS2ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5kbf-0000000BnwF-0Sd8;
	Mon, 06 Oct 2025 12:46:23 +0000
Date: Mon, 6 Oct 2025 13:46:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: Remove redundant __GFP_NOWARN
Message-ID: <aOO6Hk079NJMTg9c@casper.infradead.org>
References: <20251006014948.44695-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006014948.44695-1-wangfushuai@baidu.com>

On Mon, Oct 06, 2025 at 09:49:48AM +0800, Fushuai Wang wrote:
> The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
> 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
> remove the redundant __GFP_NOWARN flag.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

