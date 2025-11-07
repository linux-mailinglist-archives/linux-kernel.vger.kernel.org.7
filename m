Return-Path: <linux-kernel+bounces-890569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD33C405BD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF2614F2126
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4E32AAC6;
	Fri,  7 Nov 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaP1BGy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87E283FC8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525634; cv=none; b=LWkiiy6BZZa8p7nx72RqjJf9tJYNmxx9/PKnsPcTYno4cTIb5+kWAk4qz3ywNVQMqrRpeS2WmXMF5FO19XwYcnKwjRaNJ0zB0bFVMlFQkVNcS8D63vx67eJQvOGkrouQE8t9aIyWGDF3GncQlOJhRPdBr8O23opAmPaWWRAHr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525634; c=relaxed/simple;
	bh=Pzo7tfIaHjLpftx/B0TKs+rcupOkEug4Caccn3F0lig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlhz1M+bd9tZB6tG6OPp4MoYYhtCjRvSh5R8Q0ujhgMxw5U7cD9gLlpAHmxb/CSHM8e/QLXxb5XgI1PVDZZMeCN9Nd6iqtYczQpOn+vSZy8H/I2nkUJwMKjBkIkSGzHK5FgMU7DxdxbZ6bHINztY3GpFL38I1k65nNhFX8kRJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaP1BGy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E6C4CEF8;
	Fri,  7 Nov 2025 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762525633;
	bh=Pzo7tfIaHjLpftx/B0TKs+rcupOkEug4Caccn3F0lig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaP1BGy3T71n9873EJJSuRsl/8HamSIhcGxLlMEM0oxVZB7oBHT+ZDHodCwwmy5QN
	 DCxldO4nQ9daC9l32//xRryV5Nk1BoS8ftLL7s/8CYGyMD7T5xChQPWZV06n5SuIGI
	 NtozWcoRwGAnRWWDPRDzKbrxW1d3P8rewz7tokQpyHWyuB8S7A1frE4cuiQUMNB3tw
	 fq3um2ZF0ht/mFb7uYoIvUuz2vP2X2pvXYxKPqAX7mlT8146hQ2DuPIKuVUPtLX48K
	 2zw6KcbsQMXXrEs2uOJwvqU8f8tUaww59+KVzFKuzpUcdr4Rm1elTFkSGdMlpY6GMu
	 7m87AYHK0nynw==
Date: Fri, 7 Nov 2025 14:27:09 +0000
From: Will Deacon <will@kernel.org>
To: Dawei Li <dawei.li@linux.dev>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH] arm64: Remove assertion on CONFIG_VMAP_STACK
Message-ID: <aQ4BvRzFWP7rKLqi@willie-the-truck>
References: <20251103152345.175463-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103152345.175463-1-dawei.li@linux.dev>

On Mon, Nov 03, 2025 at 11:23:45PM +0800, Dawei Li wrote:
> CONFIG_VMAP_STACK is selected by arm64 arch unconditionly since commit
> ef6861b8e6dd ("arm64: Mandate VMAP_STACK").
> 
> Remove the redundant assertion and headers.
> 
> Signed-off-by: Dawei Li <dawei.li@linux.dev>
> ---
>  arch/arm64/include/asm/vmap_stack.h | 4 ----
>  arch/arm64/kernel/sdei.c            | 4 ----
>  2 files changed, 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

