Return-Path: <linux-kernel+bounces-751774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F36B16D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35FC3B0950
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CD28D845;
	Thu, 31 Jul 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPncY2p3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01DE55B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949522; cv=none; b=Mj/+pycRzAZQzjL4tJMUYT+h3mGPvBMUGJLdwFvPjPCyDyo3Rr14GC5NYM0t/cd52LVvH5NuvtfM4EGxXWOCrZZqiJevyPC+5m6Bc+IG2pTaMFwJOb/lyEaI/t4pHb/O4BCju+ko1qhBaXzYh1n+bM6iGLkGVBdxuS6u/xh3P2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949522; c=relaxed/simple;
	bh=2yNXa2RukZKWE0SmTpjfizPitbDZU+dGG4ELR3ktWIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r37rqrgnm2vJsytBtZ4DZgwsnvTBevq+MGZDGHzM5bGTqdPWzTYoOML4gCs4cBBdCIhOXgrDVmYJIxDLUspgf4LIO4OBgQPzHe51UCyZoMa2EMFINPztfRlj10fPDqYFqjkIowjirT4rVb/EGbkkp/U2ArPsoz56XcYai2oR6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPncY2p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F274C4CEEF;
	Thu, 31 Jul 2025 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753949522;
	bh=2yNXa2RukZKWE0SmTpjfizPitbDZU+dGG4ELR3ktWIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPncY2p3bWlnWr4mWTlHBKEAAww/U/q6CILyQQS2pEZJu5D9tMpbzjH3VGq5M79L7
	 yS3wDofJaFsOyBu+upPq+tfubmD9/3gpIM8Lf/gRTnLezRwe8Rwrd5MAAlTTu0Ju5D
	 Al2M6aZL71lPi2fPKJNs9x0ggPExQivQgggF2GVwxZKSwHzE4zYCndRBNzgHWR/p7z
	 ucb9WP6SHgH+pOh9j4wwEZ3l5DnGmQzW9B1n9SDmStgz2conKOIu4QcR/dw3aqP+gi
	 erUJGrQ/aeiXE8XUNIwzjB9nLailXZoYFz7tbjYRja4AXMwhSNQIQpdSrMzTvKbwIG
	 dtUdkx64ZeBFw==
Date: Thu, 31 Jul 2025 11:11:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix kho_test_restore section mismatch warning
Message-ID: <aIslTMp6RSxY0ZjK@kernel.org>
References: <20250731080007.2037366-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731080007.2037366-1-arnd@kernel.org>

Hi Arnd,

On Thu, Jul 31, 2025 at 10:00:00AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> kho_test_restore_data() is not always inlined, and that configuration
> causes a link warning:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: kho_test_restore+0xd2 (section: .text.unlikely) -> kho_test_restore_data.isra.0 (section: .init.text)
> ERROR: modpost: Section mismatches detected.
> 
> Mark it __init as well to be consistent with the rest of the call chain.

I've already sent a fix:

https://lore.kernel.org/all/aIiRC8fXiOXKbPM_@kernel.org/

and Andrew picked it up.
 
> Fixes: c2d288f7ab13 ("kho: add test for kexec handover")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/test_kho.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index f5fe39c7c2b1..aeeb693d0251 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -239,7 +239,7 @@ static int __init kho_test_restore_data(const void *fdt, int node)
>  	return 0;
>  }
>  
> -static int kho_test_restore(phys_addr_t fdt_phys)
> +static int __init kho_test_restore(phys_addr_t fdt_phys)
>  {
>  	void *fdt = phys_to_virt(fdt_phys);
>  	const unsigned int *magic;
> -- 
> 2.39.5
> 

-- 
Sincerely yours,
Mike.

