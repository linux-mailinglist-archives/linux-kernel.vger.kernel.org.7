Return-Path: <linux-kernel+bounces-834403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74EDBA49F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A671BC69C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77412EF651;
	Fri, 26 Sep 2025 16:27:50 +0000 (UTC)
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD825FA13
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.68.200.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904070; cv=none; b=Qwfd+iTbKF30xWnFT9F3egAoFBI8Kjj47fXvOH/ARfmTBb6LiiYScnLUrx32w6g1uK67p+3kE3CugXft/6913Yx9Z+BpWTRckLub2SdjTIbE4E1tg+ly7qdkhDuzpExDaoZYYgujEwe8cimK75k1uB1cicHuCY+Au3Sbt66mtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904070; c=relaxed/simple;
	bh=i0hHmX5hmr0PwDF6/z1PRh8wKozvcnDvyGM4Yn3EpBs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XAeIQ3nfeUShHApRnKHnVymgzZMaSswEhZcSH7aPBZV2Ramh8Dpn3FTUKfJN5krcgh8ielA/VGNv2zf6Ai1ygVr3gkRfPnZM3kzmaelrUv75LEuqVWB0T73TlHGUNr2rWjgMMWuUrcdb+JtXRlXcMSFwvfCVDPU2QveP9E5FmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ash.works; spf=pass smtp.mailfrom=ash.works; arc=none smtp.client-ip=64.68.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ash.works
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ash.works
Received: from localhost (localhost [127.0.0.1])
	by mailout.easymail.ca (Postfix) with ESMTP id 47BB463231;
	Fri, 26 Sep 2025 16:19:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo07-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
	by localhost (emo07-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iq-9U9agRJGq; Fri, 26 Sep 2025 16:19:11 +0000 (UTC)
Received: from messages.easymail.ca (unknown [172.17.13.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout.easymail.ca (Postfix) with ESMTPSA id D1F4C6322D;
	Fri, 26 Sep 2025 16:19:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Sep 2025 19:19:11 +0300
From: alex@ash.works
To: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>,
 alexander.shishkin@linux.intel.com, alex@ash.works
Subject: Re: [PATCH] intel_th: core: fix null pointer dereference in
 intel_th_irq
In-Reply-To: <20250825174554.925679-1-darcari@redhat.com>
References: <20250825174554.925679-1-darcari@redhat.com>
Message-ID: <61a6cca8379529c49a031d51f90d2da6@linux.intel.com>
X-Sender: alex@ash.works
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-25 20:45, David Arcari wrote:
> In certain cases intel_th_irq can reference a null entry in
> the th->thdev array.  This results in the splat shown below.
> The problem is that intel_th_output_enable() can modify the
> thdev[] array at the same time intel_th_irq is referencing
> the same array.  This can be fixed by disabling interrupts
> during the call to intel_th_output_enable().

Hi David,

Thank you for the bug report and rootcausing! Can you please also
detail the sequence of actions by which this is reproduced, so
that I can test my fix and not bother you with a back-and-forth
over-email debugging and also add it to our regression testing?
Doesn't have to be a shell script (although I wouldn't say no
to that), plain english would work in a pinch. If you have the
time, I'm also curious about your use case for intel_th.

This has eluded our testing for about 10 years, so I'm very
interested in the reproducer.

> BUG: kernel NULL pointer dereference, address: 0000000000000304
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:intel_th_irq+0x26/0x70 [intel_th]

Yes, this is absolutely a bug.

> @@ -715,7 +715,9 @@ intel_th_subdevice_alloc(struct intel_th *th,
>  int intel_th_output_enable(struct intel_th *th, unsigned int otype)
>  {
>  	struct intel_th_device *thdev;
> -	int src = 0, dst = 0;
> +	int src = 0, dst = 0, ret = 0;
> +
> +	disable_irq(th->irq);
> 
>  	for (src = 0, dst = 0; dst <= th->num_thdevs; src++, dst++) {
>  		for (; src < ARRAY_SIZE(intel_th_subdevices); src++) {

[...]

> @@ -750,16 +752,19 @@ int intel_th_output_enable(struct intel_th *th, 
> unsigned int otype)
>  			goto found;
>  	}
> 
> +nodev:
> +	enable_irq(th->irq);
>  	return -ENODEV;
> 
>  found:
>  	thdev = intel_th_subdevice_alloc(th, &intel_th_subdevices[src]);
>  	if (IS_ERR(thdev))
> -		return PTR_ERR(thdev);
> -
> -	th->thdev[th->num_thdevs++] = thdev;
> +		ret = PTR_ERR(thdev);
> +	else
> +		th->thdev[th->num_thdevs++] = thdev;
> 
> -	return 0;
> +	enable_irq(th->irq);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(intel_th_output_enable);

This is indeed a possible fix, but I believe a little bit of
serialization can be employed here.

Lastly, my apologies for tardiness.

Thanks!
--
Alex

