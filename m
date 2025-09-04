Return-Path: <linux-kernel+bounces-801333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FBAB443CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C961C86F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBA301036;
	Thu,  4 Sep 2025 17:00:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077C2F5306
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005227; cv=none; b=cgcxF+Y1xXTBS+jFcYdANalfsWXDc0XuYtrFjJc4YjXOd/zDZX5a/DLhxysOBP9ZmSg6U1+vM2jflM3SBmwbBCSmo1PU4Cm03VFa6xAi8RwrVvQMxs9i5V+WRd3mAnXigE+dq87dwVEYbDL7zXPkoH2Y/sPKByP6QLE0fVrdSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005227; c=relaxed/simple;
	bh=JvkXAzz/nLBlBP9BtuZSkizdzvY/C8ZAoqPy2iLWXXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/a946Z8MGAwyGX7tVt3N0uAM+gTXzpqJSo1PK3Qhici74Ooyw/UFBZ/g/y6MRIP6H41m/JaYri8PgBoU9TkGeDxyvBWmh9VQvmT4EsU5j8HkFb8bUMSTbTDbCD7ITR/o3/AIZkMSE2Wc1fWQnEyQlmWGI0JsTQkhGuMAEGLnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E4CC4CEF0;
	Thu,  4 Sep 2025 17:00:24 +0000 (UTC)
Date: Thu, 4 Sep 2025 18:00:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 6/6] arm64: mm: Optimize linear_map_split_to_ptes()
Message-ID: <aLnFpndf-XikPPFf@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-7-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829115250.2395585-7-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 12:52:47PM +0100, Ryan Roberts wrote:
> When splitting kernel leaf mappings, either via
> split_kernel_leaf_mapping_locked() or linear_map_split_to_ptes(),
> previously a leaf mapping was always split to the next size down. e.g.
> pud -> contpmd -> pmd -> contpte -> pte. But for
> linear_map_split_to_ptes() we can avoid the contpmd and contpte states
> because we know we want to split all the way down to ptes.
> 
> This avoids visiting all the ptes in a table if it was created by
> splitting a pmd, which is noticible on systems with a lot of memory.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

