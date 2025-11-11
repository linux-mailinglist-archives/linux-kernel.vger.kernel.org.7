Return-Path: <linux-kernel+bounces-895068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE4C4CDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC707428308
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FD3009E2;
	Tue, 11 Nov 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRER5GgK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575B2FC017
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854890; cv=none; b=jwOdWFEVFLZy5vutEDF3H4scp28a+05bX89MQhIJUWZmyQUyFHcYdAB7/YnAdpXg88Kv0oZMRVmIXnIljyUCVQ5e5ThBlxDshpAdAfsp4jJH1AkHJc/8goXxW3e8Lp5PhxC7qURwlhpbPs31hbduQ/Q2KaoKXtzeAPkgFkS2Qaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854890; c=relaxed/simple;
	bh=6hIAa1F3h2vVQLHe6m7uqIEc1S0H5QunNyCs4fI6Obk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8C8kfmFWoUKQckslj6Zf3JlVSVmqpQV5EkaWHZdhH3j9ysTOJefHOrZ1/ptTP7mj8iNfJkQ/iVpJ5kC+S1yLAH3RxAJfywx7MdgBjbBFE/mG1z/PKaBwqfSRTaxZoGaLhJYEf71+vlnBcJUsUwBNDPOh7gp1mvQ24sG+fxskCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wRER5GgK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pgszA9hLFXwALQU3C2Cqvlsv/7VQh0ecvm7aOAtxH+Y=; b=wRER5GgKuR3f1ESHmkMUsnPnD/
	tE9XNDp+YMKQeo1GzpemLmrn6h0CtgufAz+07F7ZpGSbP8RKPyZMxCu+/Cp8YfM6r0icYLw1JBae4
	oAthfG4UlyTMSAWo5FJcGlOcPnEpeqALLdDVH4jYxkelQXJawPZUHJS2ks0m9OB6qksxexR0s6fP7
	fDUuJSkPfHZvTJlKPcsmgWTgThZBcYV1wJ0PhfeElUENR4PzmJzlKnh5GDlcZ+0rU2IFwUSyYylg8
	tH96LGIyZdeEpKm7bioiRF/y6SVVn1db0ki+7c5Jxnb9WEq3fbYWJLHZgymkW9Mp9twtsJvvYjgPr
	GVOrQY0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIl5H-00000003457-3fF2;
	Tue, 11 Nov 2025 09:54:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1F28300BD1; Tue, 11 Nov 2025 10:54:42 +0100 (CET)
Date: Tue, 11 Nov 2025 10:54:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kees@kernel.org, acarmina@redhat.com,
	jpoimboe@kernel.org, mark.rutland@arm.com,
	torvalds@linuxfoundation.org, maciej.wieczor-retman@intel.com
Subject: Re: [PATCH v2 10/12] x86_64/bug: Implement __WARN_printf()
Message-ID: <20251111095442.GF278048@noisy.programming.kicks-ass.net>
References: <20251110114633.202485143@infradead.org>
 <20251110115758.213813530@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110115758.213813530@infradead.org>

On Mon, Nov 10, 2025 at 12:46:43PM +0100, Peter Zijlstra wrote:

>  #endif /* _ASM_X86_BUG_H */
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -102,25 +102,37 @@ __always_inline int is_valid_bugaddr(uns
>   * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
>   * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
>   * static_call:  0f b9 cc                ud1    %esp,%ecx
> + * __WARN_trap:  67 48 0f b9 39          ud1    (%ecx),%reg
>   *
> - * Notably UBSAN uses EAX, static_call uses ECX.
> + * Notable, since __WARN_trap can use all registers, the distinction between
> + * UD1 users is through R/M.
>   */

Maciej; you were working on making KASAN emit UD1 instructions, right?
Where are you with those patches and are we conflicting on the encoding?

/me goes find the emails.. Yeah, I suggested UD1 /1, specifically:

	ud1 xx(%ecx), %ecx

and that does conflict. How about I switch to using:

	ud1 (%edx), %reg

for this?

