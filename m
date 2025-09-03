Return-Path: <linux-kernel+bounces-799164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43048B427EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E153A7BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF430C353;
	Wed,  3 Sep 2025 17:24:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1411CEAC2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920288; cv=none; b=kI+UlxDI/LDnh1SLbXEcmXmtBFZOIZcs0kN5ovEvg4/oxSLb5ilkyF4DK0px3/GsgQDLOfmoHTePUewe6162PmrRaHU5y0tgTXdoB9nrtTHIytDBoMwfjndIQSwZWEiMY2WMyE5sFh2qhL+Rl11l6eZFw6W6PJCaRtWifzqwbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920288; c=relaxed/simple;
	bh=u8r5mk1NRYCHnUPFNu6amiKyTQ34ypyNFPgPTWkdfdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOPR7p7YCg0Vf6nkVAmREfAtZk1z4btCcVI6v+07dzG2UkQ5hLGZYANCOP5C/L0AizFEhNmDwju/QeC0SKBoRvagNO0wvH44oGnthC6aRlGA1lJ7kfRof/CHDFmhMbHl5oZeOlRz7P+9FgnDMuM5gOTjlYpBC+yNrfsDLE6gQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823F5C4CEF0;
	Wed,  3 Sep 2025 17:24:45 +0000 (UTC)
Date: Wed, 3 Sep 2025 18:24:42 +0100
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
Subject: Re: [PATCH v7 2/6] arm64: cpufeature: add AmpereOne to BBML2 allow
 list
Message-ID: <aLh52smiWpVMCB6v@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829115250.2395585-3-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 12:52:43PM +0100, Ryan Roberts wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> AmpereOne supports BBML2 without conflict abort, add to the allow list.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Here it is again:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

