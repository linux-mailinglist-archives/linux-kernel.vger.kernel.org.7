Return-Path: <linux-kernel+bounces-725490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E60AFFFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77495A4F99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060F2E0B64;
	Thu, 10 Jul 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYNHFa70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88462877C1;
	Thu, 10 Jul 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145159; cv=none; b=fw1+2bDs/LxQBZtFOIN/Le7CrHyLE13ceG2MmvOudr+tW8CLfTc6VMcNlFikyLj9BztG9k4w/XvKVw/uOnSPifUOuOt2kZgcm98rSxYbihWJzrghmoJxS96sqvIGgoxC/w8tDmIp4iZVYRfuF4mm5wICmr2yPmoUScs0Zv3bJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145159; c=relaxed/simple;
	bh=+9Aiaj5Zj4iemiwWv8ITBr4HJpVztCAHhr9QST4AMpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szbwSuLfYociy5OcU6D1UwPELm0y3BVO8y4j95jjH1t8yWEkFreTXNRKbuICIOHNOeTnvOjscPu6zyCAs/x65Bfi9MIg97go1tdpDiAf7DXqT2ryxG+m53yxrHGAUfO+BMRczHoqvJNcKI53yaO2LwfHOlkT7oZkbYTWV6BmF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYNHFa70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18449C4CEE3;
	Thu, 10 Jul 2025 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752145158;
	bh=+9Aiaj5Zj4iemiwWv8ITBr4HJpVztCAHhr9QST4AMpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mYNHFa70nvJ50iL0uCKjVAMeHVhRxcAByGoCreYB1OOp3FDxAgj18gj/ArF19YSCY
	 rfC9xCmDPyFvE3H32en0cVmTRA1Tpzgzr01k8K2bXxpv8UB3gecqtB6h0zYx/Lesuz
	 ws9IQkzBfoBYuHsps28B4NHdktVFPwACRAF47jULOSaWQ+l/5qfAdlZU++HuUQFfvO
	 Y45AY4AoH32nhwtXeA2aWKohzAcZhOQPEPXu4LEJCwm51H5PRfjr2m77WIUSsxVKk8
	 /USo0wB7j1g532G0k17lWxSr6djiN3MtrSURwsnbONHi/NS4f58v80xNMAWYxM2Yom
	 uI/X1Rgqq5gsw==
Date: Thu, 10 Jul 2025 12:59:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250710125914.41fe8cf6@foz.lan>
In-Reply-To: <20250710123155.1045831d@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
	<20250710091352.4ae01211@foz.lan>
	<20250710101931.202953d1@foz.lan>
	<20250710121033.42db5ef3@foz.lan>
	<20250710123155.1045831d@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 12:31:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 10 Jul 2025 12:10:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > From the above:
> > 
> > - It is not worth applying patch 12/12 as it makes the code slower;
> > - Python 3.13t (no-GIL version) had very bad results. It seems it
> >   still requires optimization;
> > - Python 3.9 is a lot worse (140% to 190%) when using list append;
> > - when there are not many concats, Python 3.13 is about 15% slower
> >   with lists than concat strings. It only approaches str concat
> >   when the number of concats is high.
> > 
> > With the above, clearly str += is faster than list append.
> > 
> > So, except if I did something wrong on this benchmark script, please
> > don't apply patch 12/12.  
> 
> And I did: I forgot the final line at the concat code to get the
> result as strings.
> 
> For explicit list:
> 	result = obj.output()
> 
> For implicit ones:
> 	result = str(obj)
> 
> Yet, the conclusion is similar. With Python 3.13:
> 
>     $ for i in python3.13; do for j in 1 10 100 1000; do $i /tmp/bench.py $((1000000/$j)) $j 1; done; done
>     1 strings in a loop with 1000000 interactions, repeating 24 times
>         str +=       : time: 41.42
>         list join    : time: 127.33: 207.42% slower than str +=
>     10 strings in a loop with 100000 interactions, repeating 24 times
>         str +=       : time: 27.15
>         list join    : time: 39.19: 44.36% slower than str +=
>     100 strings in a loop with 10000 interactions, repeating 24 times
>         str +=       : time: 24.84
>         list join    : time: 30.70: 23.57% slower than str +=
>     1000 strings in a loop with 1000 interactions, repeating 24 times
>         str +=       : time: 21.84
>         list join    : time: 27.85: 27.50% slower than str +=
> 
> Explict list concat was between ~30% to ~200% worse than str concat.

Looking for an explanation, PEP 509 and PEP 393 did Short String Optimization
and Inline Caching. This was applied Python 3.6, and Python 3.13 came with
extra string optimizations.

On the other hand, lists do more memory allocations, have some logic to
extend list growth and has an extra concat loop.

With that, contrary to popular belief, it sounds that str concat are
nowadays faster.

Thanks,
Mauro

