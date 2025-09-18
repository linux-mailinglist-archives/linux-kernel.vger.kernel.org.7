Return-Path: <linux-kernel+bounces-823686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43404B87319
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0779B2A60C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C42FA0C6;
	Thu, 18 Sep 2025 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sk1hzzV1"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072124E4C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232755; cv=none; b=n5nrsaUXEciZTouE7789sZ35g6qg4hg+SL8AvF9tS90pQ648vOEHpgrZR7OpwYodOHCc/JWSWxGBjDdqbqzngxc5CGoKMLZ4cHr4Fsmz1v4odSfB1FpphS5uo7x92PrbbKkCtau9Py2xU67c9OlTfiFdpJeqG9WeCP8aqos5zW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232755; c=relaxed/simple;
	bh=2OiKmYY2Mab94kFiYXTmD/Tj7kOjaE6vWvMUuO7bYkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhPPhCL0cOuVWJKT4KSQFDZR7/t3H5OWZCuSJ87XA8JzHnFA0fRcGjwYQxOMCFV+NdNq0ZrbS6oI9PkvOVZgm4zQXyB6zTRU5XUFeJiI04y/C9ZL3z8sxPOw4wwUhdVS3dPStMeExsqoJQrWTGgaSQx0jGc1A1MFVYd7s0BpWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sk1hzzV1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Sep 2025 14:21:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758232740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yV2xHUADIUVgzf3tVjzFgnathlyFhibAgpCijuTGhQ=;
	b=sk1hzzV1vpw6seiRIzauAmhjW9Wv6WImdrBjKPjkWSHvd0sCttC6o/4qulnF+/TLMfXiSs
	ilhFLgfEqC+Eozqf9GcAAHh2nnqg4/mAeKxJSXv3Fp0ufGnacyuEV5atDFYhyAAfgZxO32
	6sVM4RfVhqUJ1aA47p11qdnJrY9z1m8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, sebastianene@google.com, keirf@google.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Validate input range for pKVM mem transitions
Message-ID: <aMx351jkCPIv_j61@linux.dev>
References: <20250918180050.2000445-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918180050.2000445-1-vdonnefort@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 18, 2025 at 07:00:49PM +0100, Vincent Donnefort wrote:
> There's currently no verification for host issued ranges in most of the
> pKVM memory transitions. The subsequent end boundary might therefore be
> subject to overflow and could evade the later checks.
> 
> Close this loophole with an additional range_is_valid() check on a per
> public function basis.
> 
> host_unshare_guest transition is already protected via
> __check_host_shared_guest(), while assert_host_shared_guest() callers
> are already ignoring host checks.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 8957734d6183..b156fb0bad0f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -443,6 +443,11 @@ static bool range_is_memory(u64 start, u64 end)
>  	return is_in_mem_range(end - 1, &r);
>  }
>  
> +static bool range_is_valid(u64 start, u64 end)
> +{
> +	return start < end;
> +}
> +

I'm being unnecessarily pedantic but isn't something like [-2MiB, 0) a
legal range if we had 64 bits of PA? Looks correct though so:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks,
Oliver

