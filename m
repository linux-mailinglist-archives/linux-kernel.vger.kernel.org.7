Return-Path: <linux-kernel+bounces-680037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C3FAD3F26
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B07AA4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F024293F;
	Tue, 10 Jun 2025 16:38:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C224167E;
	Tue, 10 Jun 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573480; cv=none; b=WoY9Wc7dIIh5I1HeIRvEHJY9iBzUkwBBN2cZ1FGa1tJSHCF3PpTn94sZ+pCfx7jXtX5rU1UyuzRbNvmHq5f3kQMySnH5N9j6qooHwcf7MspCJpvVJwabCW0SYgxqbh3upSl3p9kha33bSjaLIOkzjSbFX1CifFAHOnE7pLky+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573480; c=relaxed/simple;
	bh=WivjkEw1xb5ZMPU3ukq3n+FkyvysB2igPVe77PWbbg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSS3+3CFGrm3IMvLLwbZpfpyDhQQ46/bpM896313qye2LnFB4hP17AAUqaZBDelh7Vkjn4YmYF9vdO5+VxTTjOGjSmWIUJveDFb9L8RXSdHHJIR/Y9db6niCFZ4N0J9mH+zf/qewrSAnSxnYhd0J+jfitJXWgQPPVLEjmoN/kuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD72C4CEED;
	Tue, 10 Jun 2025 16:37:57 +0000 (UTC)
Date: Tue, 10 Jun 2025 17:37:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: will@kernel.org, david@redhat.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, mark.rutland@arm.com,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: Restrict pagetable teardown to avoid false
 warning
Message-ID: <aEhfY2D-njOEBFst@arm.com>
References: <20250527082633.61073-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527082633.61073-1-dev.jain@arm.com>

On Tue, May 27, 2025 at 01:56:33PM +0530, Dev Jain wrote:
> Commit 9c006972c3fe removes the pxd_present() checks because the caller
> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
> a pmd_present() check in pud_free_pmd_page().
> 
> This problem was found by code inspection.
> 
> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())
> Cc: <stable@vger.kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

