Return-Path: <linux-kernel+bounces-750093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9CB1573C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A8B3B72A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA071DE8BE;
	Wed, 30 Jul 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HcIUVfRu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05A7E0E4;
	Wed, 30 Jul 2025 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840404; cv=none; b=DaGmiq95in2Ru///boYl0CwXPkczB2pLb3Wp5z+jE9cyVwtjAKaMqKyZ4H51URJQAAAegSFs05+nQ8Q5DyMrzxpjLm5cnf8z/Et3oKg6zNNxRNIZwHkXXP4RqKde1n0N6m9ZiNTLRQEgrggtUlFbHJHPu+8dJDMirW2lDMF4LlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840404; c=relaxed/simple;
	bh=MbevhLJLZZVcRGBlOkzhU/9EDSdDrwTOH3ukDEeaPpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzsyE8KGx4tOXMwgRNc3EIvB4QhUipG5preecUnDgRQcXI5/EEe29wPnUhs6CrFouGThpXQO3243zP1a89OXU7VdJvbS1265WyPtV3+8FgvIoPOGLvCVOme+oEA2e9Z7khgNz11bWdUwz8l1cfdS6DGgEBjfKZ/ERVdbEr1UMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HcIUVfRu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NygeRnfCY0oBxJ3XVGkqvf9s8LTdUkkjjW96dSx+rJQ=; b=HcIUVfRuV/GIiPUzkgM7lBx1Qx
	HCqHmsWDHcdBySI6ChwUqehlYJQt+FkPbA6VEGDooRZf90LxDBxCXiSyZ/diJHaVtow2W/TKareS/
	va6+L7VtjEJ8dRqp5zsiuLvsg71pnGhz+fLGbjttwFPZOfqzQ5M4mANCP2ZYf5nAwHUcTsKtqx8hD
	ivNFoNclCT6HI9RGGLStDe1BU31oogjzXkxqGUqvJe6NpkeD6U2x2uqwe8NxxHLcjcBZkMFVQMQhu
	pt0rfmNquw8f2uV7ffyFxqG1/KdaBv3/e9qVXErAED8+5D8ewlNRfM0NuHDxPHalupnKmzYAVi0tb
	VTk2V45A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugw0L-00000004KJl-0hQT;
	Wed, 30 Jul 2025 01:53:17 +0000
Date: Wed, 30 Jul 2025 02:53:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Documentation for 6.17
Message-ID: <aIl7DKlKcy7vauos@casper.infradead.org>
References: <87y0s81lqe.fsf@trenco.lwn.net>
 <aIl3j8klCw6xWyH3@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIl3j8klCw6xWyH3@archie.me>

On Wed, Jul 30, 2025 at 08:38:23AM +0700, Bagas Sanjaya wrote:
> On Mon, Jul 28, 2025 at 07:35:53AM -0600, Jonathan Corbet wrote:
> > The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> > 
> >   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.lwn.net/linux.git tags/docs-6.17
> 
> Hi,
> 
> It looks like this PR slips through the cracks (not merged yet?).

Patience.  Linus will pull this at some time during the merge window.
Probably by the end of the first week.



