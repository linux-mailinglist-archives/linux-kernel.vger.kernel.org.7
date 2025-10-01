Return-Path: <linux-kernel+bounces-838687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086EBAFEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3401C6E39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0A28EA72;
	Wed,  1 Oct 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4umlesJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182D1275111;
	Wed,  1 Oct 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312510; cv=none; b=eQxkilqwfRT11YdR6q90+2gIRPuw2clcp/aibubu/66p9KidMtrpGMd5p4ZeEPvK5RATku37mLW3wAYxzsVio1L69VGsyeCHThphhkgi3E0Dw7Hbirm6urCFErc6a7KFyQSXh2CT1+g5RwyAJfxpwZMUqh+5+Qcv8u3aC2nQsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312510; c=relaxed/simple;
	bh=PAz5KZCakaH6blQgPTUwrjY5KswO8oPPVquLLzUwrWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sywhkhdkOwNo1niDcfUormV/sHIMKrn3Y9XKhalATt2FoIseo25e1+9KNYX2OU65sdzYXQERn11/n7jByXXgQwUdWjjhIdAGo2kTVbEKXpa0SG9/T9/j7Sxh9ZdbM9GK+Gdl3uzKGWXEdwhH6hULiDCfCQ4R4fiZEr5L7/ugigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4umlesJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173FBC4CEF4;
	Wed,  1 Oct 2025 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759312509;
	bh=PAz5KZCakaH6blQgPTUwrjY5KswO8oPPVquLLzUwrWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4umlesJDbhp1coun+usR8fLKjFFq2kxBHQaR/MI5k7t+gOqLTzCr93XMqg7i0LYp
	 +elgc1BqQGJRb6RUFSl843hIY5riP7KH6yjqODJCkmKVOyn964UQ9FS2fwjXXKDqf3
	 0teQsVcyIAsBeVuY6neQWYaoyQa9b+0y7ki/Lg5GgfAJAUR7rFx58yHWVvybA6zQJ5
	 Xj6fsBCgkqG2WzRFJnJ+xlp4EKLHCwmRGRwHlFgwvSbV8amZKDDhI7HzHBvVlqnTPQ
	 DxEYPV745cMzrtjdlx8QpRaVRkLapiKW5DSaXcH8XpzG10KbcbQ6LiKRFrtZZBGeGQ
	 fnmxQetbwMuAg==
Date: Wed, 1 Oct 2025 10:55:05 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>, Neal Gompa <neal@gompa.dev>,
	Sven Peter <sven@kernel.org>
Subject: Re: [PATCH] mfd: macsmc: Initialize mutex
Message-ID: <20251001095505.GP8757@google.com>
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
 <1bc9a4b3-7a8d-4bcf-9481-36fdc76e066c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bc9a4b3-7a8d-4bcf-9481-36fdc76e066c@web.de>

On Sat, 27 Sep 2025, Markus Elfring wrote:

> > Struct apple_smc's mutex was not initialized before use. Surprisingly
> > this only resulted in occasional NULL pointer dereferences in
> > apple_smc_read() calls from the probe() functions of sub devices.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc7#n94

Provide some context in your own words.

Don't expect others to click random links.

-- 
Lee Jones [李琼斯]

