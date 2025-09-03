Return-Path: <linux-kernel+bounces-797982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F14B41805
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549633BF12B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F92E54D6;
	Wed,  3 Sep 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOMd+ClN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F52E6CA5;
	Wed,  3 Sep 2025 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886866; cv=none; b=AifADRGnSWcggVlWE0K2Hby2d0PJPy7ekCIeIESZAvg6YAvEfA33RFYQRLWtWQCV13cvS3VDxS3HZiht4bgKmKD9qPXOUAXzjIdJM28nQOdCL0x8C32WdvoFS04McbxUfb01JM0pH2d4tUuZSF6Qnv9tXoO8o2a46R0W1eNoMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886866; c=relaxed/simple;
	bh=oylBBl4uKf15Rl0dYmoe29/A3Jm+GijZDxeRqxsoIuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8rkjFgkqx3+l2lbymLv6YvP6mwzVH+TlML1GsvplzYUZxcdwqmXk/mONd+QnOasy6YO/9VbceADvASgxrNv2iY1ZxZf+W4wks+nu8QLYOrV7wZM819NOyMw7BanmB6wXW13hqFv3nYecLyMhDb2UX/0lTCUkmVLz4zBYpyrUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOMd+ClN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FBAC4CEF0;
	Wed,  3 Sep 2025 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756886865;
	bh=oylBBl4uKf15Rl0dYmoe29/A3Jm+GijZDxeRqxsoIuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOMd+ClNOmVD1CadlRsVv0U/kNNM90vCdRtGb6WjRtylHsNfhk4PSkXUKmwOkDR/C
	 vK48IXNSmvJhLfUAgQPZ4/Y3gTzF25nlGstPL81xMIuO/7arwJ3LmTesSNWB+nttjK
	 Ea6DUGKQxzQIFZv+bWSFfZZxF0Xl9yYk0DiPAaDFm/SVZ7gKl7jCHYView402MQGca
	 kDy41ZypNz7JVgrDCl3LO1M+UUCKtCC2YJO36/Rk4Di2pPGL8W6e+VPhPjqp8sNzH1
	 th8NXA9hTBowv0+eWIwYAV4IsxdLsWDBYykKOEV6FUNl3jIMvxOJrKr9BcIaS8YEiU
	 xTiHdPu2j49Uw==
Date: Wed, 3 Sep 2025 09:07:41 +0100
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
Message-ID: <20250903080741.GD2163762@google.com>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
 <175680785548.2247963.242433624241359060.b4-ty@kernel.org>
 <CAMRc=MeWnrSPrLOq7yH71wpw4vP6RJiLnuLCpwXogZn0yugFgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeWnrSPrLOq7yH71wpw4vP6RJiLnuLCpwXogZn0yugFgw@mail.gmail.com>

On Tue, 02 Sep 2025, Bartosz Golaszewski wrote:

> On Tue, Sep 2, 2025 at 12:10 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 11 Aug 2025 15:36:15 +0200, Bartosz Golaszewski wrote:
> > > This converts the vexpress-sysreg MFD driver to using the new generic
> > > GPIO interface but first fixes an issue with an unchecked return value
> > > of devm_gpiochio_add_data().
> > >
> > > Lee: Please, create an immutable branch containing these commits after
> > > you pick them up, as I'd like to merge it into the GPIO tree and remove
> > > the legacy interface in this cycle.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/2] mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_data()
> >       commit: 14b2b50be20bd15236bc7d4c614ecb5d9410c3ec
> > [2/2] mfd: vexpress-sysreg: use new generic GPIO chip API
> >       commit: 8080e2c6138e4c615c1e6bc1378ec042b6f9cd36
> >
> > --
> > Lee Jones [李琼斯]
> >
> 
> Thanks, you haven't pushed out the changes yet so maybe you're already
> on it but please don't forget to set up an immutable branch for
> merging back of these changes into the GPIO tree.

No, I actually missed that.  2 secs.

-- 
Lee Jones [李琼斯]

