Return-Path: <linux-kernel+bounces-788440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFFB3846D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 878044E0F33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE2353356;
	Wed, 27 Aug 2025 14:08:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACB1C6BE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303684; cv=none; b=cC48J82xqpd3ULRSHN5V5wnlgLPpb8gzApqTNIm1sGBIntiiZviBy+OKrjE90YvPb7C2xQ4+twmVMm993PR71lvln0dE+6nNWl1Dyr97OaK1DFDAyZyDreBk+M0dQ5lwNJzP908F5HsxnNKLlweY65OrgXhEJkumEZnFsup/q20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303684; c=relaxed/simple;
	bh=q1mVpQNuoOWSfKd1xb+ddI8Hu6aZaNSoHsuxmcDj1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+rVrBnr/sjXblKeL+RVfSRjH1k3FSviWhB2bGn4N7rLhiuQ1IVNeKocRx/DrUyaIDJnWTUbiHxUk8UtbZB/wPRE2308HW6gm/XQoFyT0DLyJY08I6QuqzWruLw6RF28juRvRMf+MDjnqqQQK4mmkQtzvaEO0i5JmmSKURkfe2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF39C4CEEB;
	Wed, 27 Aug 2025 14:08:02 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:08:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 6/7] arm64: Stop calling page_address() in free_pages()
Message-ID: <aK8RQCvXKPQVEccl@arm.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-7-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826205617.1032945-7-vishal.moola@gmail.com>

On Tue, Aug 26, 2025 at 01:56:16PM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

