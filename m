Return-Path: <linux-kernel+bounces-854164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BBDBDDBCC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E465450612B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F532319850;
	Wed, 15 Oct 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l5XR9MT4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FD31770E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519886; cv=none; b=Tw1W+3olCkNE4nFs3ABFZ5pfGnMsFci/niyX0+/WAMlYkoddhxVBaAlfZ2oj1nNeM56mFFBWKih6lqZu7byjjzszees/jI+HHXwYLn7Gxfaf22o5dusUBeIc7lKZl/XGhVaYvACXq1XPpTGe8WizLDPyQa9FPL8LaMCJCZUr1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519886; c=relaxed/simple;
	bh=jKxQf0hF4C/D06KFBRoa6ExSnxwQZ11G/ArpmS9bbOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK9cItHVPWds3nHXnxBJD0qQrORsw4tO+bJXThnzJt3B4a0UkCgxd5B90GQbR7QGyxO8EUjAkBuI20zOPofY4mw1mUATknbLEo2wfRnF/2VdfPTFZ9w/vo+BlTPtwhpkuNVAgmexvRGTsH9TvKPRi1HTKZR/PhaRkvoieVhJTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l5XR9MT4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ocXe8d/2qJ7Ps/m5n9rsAQBXqAEtVFKHQ45kjAt8+g=; b=l5XR9MT4BULrsZvTrF2yu1IuVm
	hVip8c+/7bNcH5i4/AAi8mOOdSdnbHEtRpJvvB6trNSf2MxkLIWA2nDwPGhc9TfPN4tpdVmluiCgn
	QSjpZQEZo7LIZPvwfER/s8bxcrp6B90D+U6XLA31jsuyg8VAkWpIOJTuXF27TKqZ2gZ0Cbk8bjcWa
	pL8QGtJpH5hI7x1Ft4yufLtJVvAtzup2Il2Ha02m9DC65m2JcXPSNNFUyBeEmJDV3MVGhslEqzT6g
	X7hXATlnEKopiWXirKJfnmCfgBocfEQO7QtCcfLUFDvOWY0pdrsIXXAKQsC4eCU3MboFS7yLKdHHP
	Qqvn9TFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8xdv-0000000Bws2-2d5N;
	Wed, 15 Oct 2025 09:18:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC68B30023C; Wed, 15 Oct 2025 11:17:58 +0200 (CEST)
Date: Wed, 15 Oct 2025 11:17:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] objtool: Fix typo "teh" to "the"
Message-ID: <20251015091758.GA3419281@noisy.programming.kicks-ass.net>
References: <20251015090106.4037-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015090106.4037-1-yangtiezhu@loongson.cn>

On Wed, Oct 15, 2025 at 05:01:06PM +0800, Tiezhu Yang wrote:
> Obviously, it should be "the end" rather than "teh end".

Was not in fact type but interweb slang:

  https://www.urbandictionary.com/define.php?term=teh

