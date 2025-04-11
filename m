Return-Path: <linux-kernel+bounces-599161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8ADA85013
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 01:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0A84A7EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C62135D0;
	Thu, 10 Apr 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aPFz77GS"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7685211466
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327490; cv=none; b=q/PrbgH6rug76XIamqCKAQJ208xeZVuoIA5E68C01O6I26Y+QeYN5/HD1k3llG/Sp2OcY/qjocCUfj01upW/DEJHQ4db3sevgWaMNGbtWCo5vA/MIya6eeoAZONwlTGEmJhR3oi7pbl7qH3GZ/UT1qOrDv1eLYtXybRZ7h4474U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327490; c=relaxed/simple;
	bh=OZpZpaf1IOF/M35h+LCD9gRTBKEaRi+sC8qqL/jw5zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ8O86vDVkqMqpVDNws8vTKm5u8axSunhYc7Sx/cXo0jgPqIgjuJwZ+INaMxYEr6NjZFyxxXpyQIEgXRtQzoARNeu0bF4a1gfPo6RIYSNP/BvomkWcAnrati55w0f11DqsnoFmirKHKVJ/CI+rwHRNzPcl8adman2ElXU6JebgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aPFz77GS; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf7e20a2-dc30-4940-9abe-bbf5ea1ac413@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744327475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfDA611tTl0VVHanpaMl22CcxRRwJdjeXnBQSXsdIWE=;
	b=aPFz77GStF9M4/xV7Zty5ZOmhOA6tbIY5wjC3QfHtHuIbYgnVOWB/udIJOsbgzhupOH4Qw
	Ngi8wUXmu6zbewQq140YE96qE3hRjmE/5Dd9PdIYdbOWZTEmPlKh/Y84xXejV6e9N9qeAw
	QjaVEiaF+VN2l3/NkD3L2BCLXibVkgk=
Date: Thu, 10 Apr 2025 19:24:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] crypto: api - Allow delayed algorithm destruction
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org,
 Valentin Ciocoi Radulescu <valentin.ciocoi@nxp.com>
References: <17f9af67-de10-4b96-99ef-3c5cd78124c0@linux.dev>
 <Z_SxYFdyBJTYe_7G@gondor.apana.org.au>
 <e3dd2f83-8451-47b0-a774-a697b861ceb3@linux.dev>
 <Z_XiPLmSVs8PGTZD@gondor.apana.org.au> <Z_XpfyPaoZ6Y8u6z@gondor.apana.org.au>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <Z_XpfyPaoZ6Y8u6z@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 23:29, Herbert Xu wrote:
> On Wed, Apr 09, 2025 at 10:58:04AM +0800, Herbert Xu wrote:
>>
>> What I'll do is make the crypto_unregister call wait for the users
>> to go away.  That matches how the network device unregistration works
>> and hopefully should solve this problem.  But keep your eyes for
>> dead locks that used to plague netdev unregistration :)
> 
> That was a dumb idea.  All it would do is make the shutdown hang.
> So here is a different tack.  Let the algorithms stick around,
> by allocating them dynamically instead.  Then we could simply
> kfree them when the user finally disappears (if ever).
> 
> Note to make this work, caam needs to be modified to allocate the
> algorithms dynamically (kmemdup should work), and add a cra_destroy
> function to kfree the memory.
> 
> ---8<---
> The current algorithm unregistration mechanism originated from
> software crypto.  The code relies on module reference counts to
> stop in-use algorithms from being unregistered.  Therefore if
> the unregistration function is reached, it is assumed that the
> module reference count has hit zero and thus the algorithm reference
> count should be exactly 1.
> 
> This is completely broken for hardware devices, which can be
> unplugged at random.
> 
> Fix this by allowing algorithms to be destroyed later if a destroy
> callback is provided.
> 
> Reported-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index 5b8a4c787387..f368c0dc0d6d 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -481,10 +481,10 @@ void crypto_unregister_alg(struct crypto_alg *alg)
>  	if (WARN(ret, "Algorithm %s is not registered", alg->cra_driver_name))
>  		return;
>  
> -	if (WARN_ON(refcount_read(&alg->cra_refcnt) != 1))
> -		return;
> -
> -	if (alg->cra_type && alg->cra_type->destroy)
> +	if (alg->cra_destroy)
> +		crypto_alg_put(alg);
> +	else if (!WARN_ON(refcount_read(&alg->cra_refcnt) != 1) &&
> +		 alg->cra_type && alg->cra_type->destroy)
>  		alg->cra_type->destroy(alg);
>  
>  	crypto_remove_final(&list);

The above patch didn't apply cleanly. I seem to be missing cra_type. What
tree should I test with?

--Sean

