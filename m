Return-Path: <linux-kernel+bounces-796993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A54B40A82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E347A6353
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F5532A825;
	Tue,  2 Sep 2025 16:25:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6162DEA64
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830334; cv=none; b=f87MazezONgOAHV50AXpdVFdWnmHeDaCbZAkEUdjSaqsmFpXsIVBETxQBtyU9BjWPF4J72LBM8H4kSrmUHWBVqjB/LkiZGgy8etbJx0Rqf4L2SpycUZoT8AnvZ+TEIIorAi1xYc7A2qHE5hUnnvoqgqCQWFH7bMUtwmmkeT6pXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830334; c=relaxed/simple;
	bh=8b6nYwPTRAUOJjdGZnpnYDNqNkwBHQh7Pr+ARHYFy0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt5rEcjIgdoP4JWzi0l5ntUKdhXnFZXZEWe3EhDafjqjdhKyxB5Vb2Q3MsmR4xfFKstjl53N3Qc7Pm+1gRmjf4dvvuxoTvJpcPFN/nbjV6qlr2ilM93wKZUrOdeGtGVE9EAIFz8QfpmelLO1Nj9Fbq3oUoJ/SPC/sESUrV2GPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70636C4CEED;
	Tue,  2 Sep 2025 16:25:32 +0000 (UTC)
Date: Tue, 2 Sep 2025 17:25:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] arm64: tlbflush: Move invocation of
 __flush_tlb_range_op() to a macro
Message-ID: <aLcaeosv1G9uyWCP@arm.com>
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <20250829153510.2401161-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829153510.2401161-2-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 04:35:07PM +0100, Ryan Roberts wrote:
> __flush_tlb_range_op() is a pre-processor macro that takes the TLBI
> operation as a string, and builds the instruction from it. This prevents
> passing the TLBI operation around as a variable. __flush_tlb_range_op()
> also takes 7 other arguments.
> 
> Adding extra invocations for different TLB operations means duplicating
> the whole thing, but those 7 extra arguments are the same each time.
> 
> Add an enum for the TLBI operations that __flush_tlb_range() uses, and a
> macro to pass the operation name as a string to __flush_tlb_range_op(),
> and the rest of the arguments using __VA_ARGS_.
> 
> The result is easier to add new TLBI operations to, and to modify any of
> the other arguments as they only appear once.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

