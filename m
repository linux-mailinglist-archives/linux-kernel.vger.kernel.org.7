Return-Path: <linux-kernel+bounces-899787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B4EC58D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E168F360915
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C835971A;
	Thu, 13 Nov 2025 16:19:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593935970A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050753; cv=none; b=HuAh1dGGHvc3Nuo5XXZI0l1pRHqB+DokRVasv1jqgoSbDnNkO+dac0/VQ4XqXIDSc/3YX5ovHMil72/grYehe42qkkKVW9W1jYnMt10FwhkOeLnGbVVYQF0qfOwDnRQ3cMKASXu2lcw+sqSGtns4ntSRAHTzWTwtp1HpP2Lgzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050753; c=relaxed/simple;
	bh=c/02IqZqX5D26fffDnfRKqnAE0R1uRwe9oUFQK+yNDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGPVS6ODI3aBruiu6/4W1F9Yd7PJwOYlzGTTC3qSb2kpCiJOW2PYA+hxicVaq/dOOX5gk/DE4yUfDvt9ixuv6vpPS+klP5kx2sHZJAEgUhWXPbBgABwBJs7Z0nDzPY6D3mH54QvFjwsyN9BbVyHO2h48OpkwgofI6o/eFW4Wv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E22C4CEF5;
	Thu, 13 Nov 2025 16:19:11 +0000 (UTC)
Date: Thu, 13 Nov 2025 16:19:09 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Add a fallback stub for pgd_page_paddr()
Message-ID: <aRYE_Z-x_RUKkqUS@arm.com>
References: <20251014110633.304961-1-anshuman.khandual@arm.com>
 <aQoORmgliayA0s_a@willie-the-truck>
 <e660e033-6300-4deb-b034-4d26746d8d01@arm.com>
 <aQuDdE_Tj3di7q3P@willie-the-truck>
 <044a6526-d6e8-4ae0-9279-8cc42bff5aa0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044a6526-d6e8-4ae0-9279-8cc42bff5aa0@arm.com>

On Thu, Nov 06, 2025 at 07:29:55AM +0530, Anshuman Khandual wrote:
> On 05/11/25 10:33 PM, Will Deacon wrote:
> > So my question is, would such a user compile today? If not, then your
> > patch is pointless.
> 
> The point is this macro is not visible outside #ifdef PGTBALE_LEVELS > 4
> where as similar ones such as p4d_page_paddr() and pud_page_paddr() are
> always visible via their respective fallback stubs, when PGTABLE_LEVELS
> are lower.

Yes but we needed the p4d/pud fallbacks to be able to use them in
functions like early_fixmap_init_pud() without #ifdefs. We don't have
such a case for pgd_page_paddr(), so I don't think this patch makes
sense on its own.

-- 
Catalin

