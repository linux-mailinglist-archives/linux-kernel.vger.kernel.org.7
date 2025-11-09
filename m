Return-Path: <linux-kernel+bounces-891829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50035C439D2
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD665188B00A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14061A9FA0;
	Sun,  9 Nov 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZontPJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15D8287E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762673501; cv=none; b=Gsv1Wy6UvGIWGa99UrMVlfoFVI+l2x5ZKGXQeKd3GwlAkSJsdRPrZ/aylpTC8VqLildNomL94GmQcpyKIS00hCVWvBLWoD6B86Lvd6w7om7ZDkDpxW1jFrGoag1TFJX3vPfB8VfuuvMNVmQm4aQar9YFo1Ovk+UYxesTFV4hSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762673501; c=relaxed/simple;
	bh=7DqEHCeqS1xGa8GegeWUZP4LFVgKnIB0Dv0EsIJO1Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbYFpiL8vyVhMeLpFGb5WK9BarGf0eib1g0N4QUue4pXz8SOSVonkawI19vvu0rxOwChdjO2v0IlRds0+OynjbeTQPwdxIAJovdxEMzq2eu5zT2KBZE1sGTBUqtvJ1ui9qS1VZDLv+f0l6Ekwt6Yj+IVDRcgJetQCEljKoiQmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZontPJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EEAC4CEF7;
	Sun,  9 Nov 2025 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762673500;
	bh=7DqEHCeqS1xGa8GegeWUZP4LFVgKnIB0Dv0EsIJO1Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZontPJPkPYCIdi+5VQmQhqNqY1ysdg3DrEwbQZUca9ddTzNzaHPKEibsgVNYWgEC
	 4jeHIEeHWqS/GCn/FweRN1R5+rvD7uiD29Vk0HT3oOzLaUNOR2bsAOgoLzHJow78Zo
	 LtSHj3lqLqfL0q9sr9dffxv+BCHr1XcK4xBeKUnIzoSwlIBdc1eF/7xJzbSP4GQ7KU
	 MYLEzCi6PioXg5D8uDGBLLdWVow2lZJJDuDMUlLFMZO51WK/hCS94TpcuctSZQgo6X
	 r+Fa90kkklaBYAkVmH63SE9w3V1O97V8XqjRcGg9Cybzg1RrdHsWfDFOvThpfSKdiS
	 KN1uypl9Xgo0Q==
Date: Sun, 9 Nov 2025 09:31:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, pratyush@kernel.org
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
Message-ID: <aRBDVkQbEDR4KILs@kernel.org>
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106220635.2608494-1-pasha.tatashin@soleen.com>

On Thu, Nov 06, 2025 at 05:06:35PM -0500, Pasha Tatashin wrote:
> We must check whether KHO is enabled prior to issuing KHO commands,
> otherwise KHO internal data structures are not initialized.
> 
> Fixes: b753522bed0b ("kho: add test for kexec handover")
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  lib/test_kho.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 025ea251a186..85b60d87a50a 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -315,6 +315,9 @@ static int __init kho_test_init(void)
>  	phys_addr_t fdt_phys;
>  	int err;
>  
> +	if (!kho_is_enabled())
> +		return 0;
> +
>  	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
>  	if (!err)
>  		return kho_test_restore(fdt_phys);
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

