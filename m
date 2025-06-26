Return-Path: <linux-kernel+bounces-704313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91CAE9C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C90817F79B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB27274FFB;
	Thu, 26 Jun 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sPFYl5n0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEF1F8AC8;
	Thu, 26 Jun 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935814; cv=none; b=XWCOvsXnAErDHVa6HQMyzFiWbENcqrkrFQsKB3en/06PesbSvysjV7kVoi24ydmzBi0iU/kx0FSLOhel7EyR7kGsIseMLsd5kq43p18MnOS6ckINEQ7KHIFqf4i70pIvI7AHDoMIylP8mncSKVydf7Yo8mrSPHHFD3mvn4SFkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935814; c=relaxed/simple;
	bh=8SWKWbCeObm6T7AxYpjb3BdUjaMzqKZQxgnJpk7Y1vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6eM2aep/RVvBhlD94hcEmJU2s3/alfqyCP+7cwalVHEjRiO/F8Z2BkPerfd+N+7sk96nDy9fzuxxFfMgxlel6Qu5A12Ps7W30kinOOuOlJBuw/FGHJFF5iLFpmsh9/aYUVNC1sNpyOx64l1uEDbJR5ie6RONGAFzlJbYbkMM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sPFYl5n0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KS0iNFVOu31sofmGRRytyZ8biJ/eKk+8GSRwQRUQH7Y=; b=sPFYl5n0eeIn2zyznSTkt7UFEf
	uxfwhmPfIj1VzKRelUUHDHTAc5OEHBbdY9kYpRZdYJk4VvM9UAX9ZbqOhEBpRFx4vzVap5WHz8tDp
	gnfKIts9PPhIDDKdQdbwJRZlPJqjNDMdxuj7Bz52MDlRqaDldW9yvUsRcv6hVHwCTAwqG5aJm7qUr
	GYxUrLCjyoMWCy1lXP4848UJ6fDj1re5dFNgLPktwOfNEXw2dLgOH86r+7kmdFhnKPsIAy6WkXM0z
	DDtROb7r6OPrtdHisrugkdNWpq/1OvazwTaOA/j/nUT3qPFAYuYoLsh10H4tOiet3hXmNfw9V8V68
	qyT3KhaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUkOC-0000000BLyK-0jqp;
	Thu, 26 Jun 2025 11:03:32 +0000
Date: Thu, 26 Jun 2025 04:03:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/5] torture: Remove support for SRCU-lite
Message-ID: <aF0pBPtzNxmJNWUm@infradead.org>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
 <20250624161400.867880-1-paulmck@kernel.org>
 <aFvmG2lT65Ido1fq@infradead.org>
 <167ab1f0-ea85-4a0f-8a19-1d74e2fa7439@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167ab1f0-ea85-4a0f-8a19-1d74e2fa7439@paulmck-laptop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 26, 2025 at 03:54:06AM -0700, Paul E. McKenney wrote:
> How about if I add this to the cover letter?

Sounds good.  But please also have a very short summary in the
actual commits.  As-is the commit logs completly fail explain to the
why, which is the most important part of a commit log.


