Return-Path: <linux-kernel+bounces-858738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B165BEBA20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7071A6606F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44CC3321CC;
	Fri, 17 Oct 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="m20+4tFW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F130F803;
	Fri, 17 Oct 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732416; cv=none; b=d8D9gy68dJmpy3/TQ7CYe/KAQKeG9/UEbtmM9O/SXpm9q2bEn1+kjPUd/0FhFZvtgKV4oxmuk8ekIk14hEK6ngE+KQNFUUiIqFO1bbmtS/KTPjSBcSBSXYJ96pXAhkcIRbuZdTaoungwCuhBYmYbR8etsSk4ihpSavKlbALLjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732416; c=relaxed/simple;
	bh=lVxo7gpzo9tLZUsK8z0AhiQwbHsKn7Y4N5YA5m8Tc30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5vDU2waOD7X28fZEDmhP1ztOLzeLcmZRgMhmx/CxtJF+3FOc1ypKa/MNIz/m+EXOU/WZGinCvKHGf/i/e6TzQU0zxnt9mdi10uKoMa/tA+kVYQFF/c/tq6+93HHGzIWL2VjMODSzRYUGV8wYrhitrwHr5jErRK193vIDfG0WrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=m20+4tFW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DB58340B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760732412; bh=gKNyP3PkTBwfQLMgcJn8O5cidAK7WPYBk+zGX9Nl70Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m20+4tFWbFdjib2qVxpgeTKBIhvHFQUOAchkGYXIscuWxTcGosAg7mMh3T7/RNtsX
	 1ReGUX6jhBJHwcnFOdC6elDK8JGaWwLDh83qTLnuP1N2UtoyDjprJ37HfI+ZPkijC6
	 SxqGlBYBJKG9lkBTkaghDOy1jJpZFSykbLabEwoT80ydM2ioKE0qTlw6WWsqvjdRwY
	 vyfhWOECECVSVRDueqWtDK7cALmJMHR7uyQtM3hn5e3qvuR1Ilh73TvXQUQqH0ymy/
	 rvrsJZFpjJY9YmNEI6Wr9XL4xL8ATTOcTRXaBUx/2lrRwwAFIeQzsGrM95cB5KtyUC
	 DFTHQOcCMNRZg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DB58340B1D;
	Fri, 17 Oct 2025 20:20:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yohei Kojima <Yohei.Kojima@sony.com>
Cc: Yohei Kojima <Yohei.Kojima@sony.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: Fix a typo in kernel-parameters.txt
In-Reply-To: <edda15e3fcae13265278d3c3bd93ab077345d78f.1760498951.git.Yohei.Kojima@sony.com>
References: <edda15e3fcae13265278d3c3bd93ab077345d78f.1760498951.git.Yohei.Kojima@sony.com>
Date: Fri, 17 Oct 2025 14:20:11 -0600
Message-ID: <878qh91ds4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yohei Kojima <Yohei.Kojima@sony.com> writes:

> Fix a typo in the stacktrace parameter description in kernel-parameters.txt
>
> Signed-off-by: Yohei Kojima <Yohei.Kojima@sony.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..f29ba44b5be2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7150,7 +7150,7 @@
>  			limit. Default value is 8191 pools.
>  
>  	stacktrace	[FTRACE]
> -			Enabled the stack tracer on boot up.
> +			Enable the stack tracer on boot up.

Applied, thanks.

jon

