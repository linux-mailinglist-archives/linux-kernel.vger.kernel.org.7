Return-Path: <linux-kernel+bounces-893896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9AC489BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4764A3AA409
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3862E62C4;
	Mon, 10 Nov 2025 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CihK0FPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714F18C26
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799695; cv=none; b=KZ93T2aY1NTl0NkZGCFpfKGYpD9lKqY+JKfWvk1YT7Zf3cqj6t5DX4+uR5ATztbA6a+j5X9oh5NFEEkFDpozy1Luuk3ImY/wjL/at2xwPkyaoHbqFQPpdKwmJ6SO8ZqdmES6kuCg530TrzehKKos01T09W9avgxzuR1tgclVDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799695; c=relaxed/simple;
	bh=FQjzy3ZKmgutMS5buIYRozIFCGNCd/pVylb5uaoZKQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy1T6StyGaQIgjY0/nkfQY2I/rgjEKi2fmTmQ2OZutz0ONKbforg0fE6fsevNBTih9KUG1Gofp4wHQ9CSHIxOBWBqCUiwSWL8lvEOVoyjtQaWtTp4u8MaiqlgAMcQGmpdVGEAMa4N7KScPJbtoGV1QKJnY/dx/N9GTZNrKzhfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CihK0FPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6488C116D0;
	Mon, 10 Nov 2025 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799695;
	bh=FQjzy3ZKmgutMS5buIYRozIFCGNCd/pVylb5uaoZKQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CihK0FPjPD1VMDZ2iA5q9fLWUD+ajedl3qWXAK9vmc92x1+nvCH1jtiC04/W7BU1l
	 6ZRyz9Ve4iGH/jFMw08q3FJqmnZNhXFgpGkViU9Em2lvtFXqXf0lif6zzO9zpUEdvA
	 Tt6obIDeIlS7E8Ks32yfM3q4BaKp/e0PE2kArqXiTpEDM4laHWCyTq4MuH3AIq7FUd
	 pEtPkOFl57dB5ITtBYjz13stwHOhBr3cf7nRFw7w4VNaUQ3pBhPNoTqIEGV6kOWQHD
	 a81ehbRobuFJuPdZK1ZwuRCa4+w/6xZ4B1vPdsZrUWHBH/jde9mXFtcC3HEvy9zU0M
	 JwTPCO/DWYUlA==
Date: Mon, 10 Nov 2025 20:34:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com, pratyush@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
Message-ID: <aRIwSEF8Y0I6q8Cy@kernel.org>
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110180715.602807-1-pasha.tatashin@soleen.com>

On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
>
> Subject: [PATCH] liveupdate: kho: Enable KHO by default

No need to put a directory (liveupdate) prefix here. "kho: " is enough.

With that fixed

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> Upcoming LUO requires KHO for its operations, the requirement to place
> both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
> by default.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index b54ca665e005..568cd9fe9aca 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -51,7 +51,7 @@ union kho_page_info {
>  
>  static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
>  
> -static bool kho_enable __ro_after_init;
> +static bool kho_enable __ro_after_init = true;
>  
>  bool kho_is_enabled(void)
>  {
> 
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

