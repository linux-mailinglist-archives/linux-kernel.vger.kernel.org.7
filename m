Return-Path: <linux-kernel+bounces-890179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC01C3F677
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D0794E1346
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00B30497A;
	Fri,  7 Nov 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHKAUit7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880E303C8B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511098; cv=none; b=FktBQ5FPbU62dlMAqPHUR4V634ga+fIGpr7zi1dvjRZnyOq38KJgq2/YfrGMnjhsOijy2vm+2NO2Vf2Q3kjuXZXyh2OKijHeszpUbVXgX7taD5lynaebR8HaBCeHWWpQ8pEI4gMNUN90x2oy6gG3lLjdQAkRlu6mBBXCdHWf9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511098; c=relaxed/simple;
	bh=N/bCvCGjWmD/PbOgspBiiy0+tZE0wHLdpwBlXhL6rTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmut7S+XDqiMjbYuuQPdQl8aWL6aQFUHlwrjq6RqK4qOCpS7iZG2qVfH+gdWVncbibDL2j2lEN+QJTwZhr3QqtnZn8AFst34RTohulI5SBOhrKJt9peKXcFuNoIx6sKg4OUIW1wdDPYAW9YOTX1Ix6RowFqHRTcfJy63PXdTaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHKAUit7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C1FC4CEF8;
	Fri,  7 Nov 2025 10:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762511098;
	bh=N/bCvCGjWmD/PbOgspBiiy0+tZE0wHLdpwBlXhL6rTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IHKAUit76/jqpfWIZXIuB2XUYGmzC5SCrm9uOv0Qw6KGUeJprlHvRSbAOmOuVeWUv
	 aI/BynQlBvBYWaxjnW5HY91zQ+FTYeMV3sFGnX5E/cn/1OI5xzKsnD87qEBWLzOurS
	 iiCQtJbFeEP1oS5yL4oq+LCgMxyzbc3FE2n/e6YXfFnE9UqVoF+HWQKtDHWDSFI1dt
	 tcHiAT3JjYGnh3VA3X84DE055IT7DvftFcyiif6y0GOLembjnxT+/YsHcjOf/raSSp
	 EaVasd/ZmAbYr+CudIZJA9b0w8SWrNDQaHTeJCzM1+Nio1ZVKQOKc8lgsZE4ccGjKy
	 4wuPpf/VsGELA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  rppt@kernel.org,  graf@amazon.com,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  pratyush@kernel.org
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
In-Reply-To: <20251106220635.2608494-1-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Thu, 6 Nov 2025 17:06:35 -0500")
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
Date: Fri, 07 Nov 2025 11:24:55 +0100
Message-ID: <mafs0cy5ub0nc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 06 2025, Pasha Tatashin wrote:

> We must check whether KHO is enabled prior to issuing KHO commands,
> otherwise KHO internal data structures are not initialized.

Should we have this check in the KHO APIs instead? This check is easy
enough to miss.

>
> Fixes: b753522bed0b ("kho: add test for kexec handover")
>

Nit: these blank lines would probably mess up trailer parsing for
tooling.

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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

-- 
Regards,
Pratyush Yadav

