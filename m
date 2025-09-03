Return-Path: <linux-kernel+bounces-798531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58AB41F54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F23482897
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD72FE071;
	Wed,  3 Sep 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSszTjOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064712E9741
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903107; cv=none; b=E9s2yrSTN2htx4fiEHitEahItlfH7NNbVNQwj15gn6OnPfnvZZ4W7xH9knBQk/d41zxsnbZdQ3Yw4ihrIGORQ2VNDKGR21B2B/bI+f/D/fObSSyJqF9d2ryTg1GfdJGsIFKg1HxkII9gCNWGQCDQ838u4S+ZXYlhpIwFqfb3pV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903107; c=relaxed/simple;
	bh=hmSOyYRu+s3djfAIJd5lEmNaJAxAqO7CVhqERe+3Vys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEj9wQgANDhaniDFvN3Y4dWmRf1qqH8DBRVCFbV4B1rbg3g+OS5r242fNyTqU2DCYElq9rnAU6DUi17RmUQmskH4mvymp5iinIJclyxjHQkFrPOvVIdO1az+iFFJohKYK7k/Ite2nhCqjsnNC60hPEfRv9pT8Lw6Wmwv+T+G4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSszTjOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691A5C4CEF5;
	Wed,  3 Sep 2025 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756903106;
	bh=hmSOyYRu+s3djfAIJd5lEmNaJAxAqO7CVhqERe+3Vys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSszTjOiaE8dGS+q/YsfQXVh7l6NuVOWsQaxejUuFlSAZogW6g5hzfeW2JOTU7V6e
	 OkAi6awQFJCLIP+dMqz8SR76YDaWivgGKPEiV3m8R/wS03ORRAkmjD9qLlur9UTMMr
	 J4CtsKZLEdiCO1kUYUCaHIS8hhG76QsOselXDaD58HLvWwC+7EGGzNZqwsd5wZm926
	 jLWj/h9OBUc3a+xb+RqyjKdIqryjoTaS41LwvtTMY180mXOUhjp4MIVGYhimOCS45n
	 xkFkWmjtCp/zK+jHIZulMnHIJDyDV6A3rTgeHz4T1Dn6cTi+tPWxz8JiibEM45TwhN
	 8m+tw6fQLf39g==
Date: Wed, 3 Sep 2025 13:38:22 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77705: rework interrupts
Message-ID: <20250903123822.GO2163762@google.com>
References: <20250831-max77705-fix_interrupt_handling-v1-1-73e078012e51@gmail.com>
 <33eb49c4-aacf-46ec-a7c2-94ec8cba0243@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33eb49c4-aacf-46ec-a7c2-94ec8cba0243@kernel.org>

On Sun, 31 Aug 2025, Krzysztof Kozlowski wrote:

> On 31/08/2025 00:13, Dzmitry Sankouski wrote:
> > Current implementation describes only MFD's own topsys interrupts.
> > However, max77705 has a register which indicates interrupt source, i.e.
> > it acts as an interrupt controller. There's 4 interrupt sources in
> > max77705: topsys, charger, fuelgauge, usb type-c manager.
> > 
> > Setup max77705 MFD parent as an interrupt controller. Leave topsys
> > interrupts unregistered, because currently unused.
> 
> Then you should remove them from the driver.

Right.

>> drivers/mfd/max77705.c:89:37: warning: unused variable 'max77705_topsys_irq_chip' [-Wunused-const-variable]

-- 
Lee Jones [李琼斯]

