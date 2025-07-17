Return-Path: <linux-kernel+bounces-735455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0737B08F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77261A66684
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3962F7D10;
	Thu, 17 Jul 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JhKZv/5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82662F7D05;
	Thu, 17 Jul 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762843; cv=none; b=LAadNGz8U+xtc0tblSqyEgqtPb4uVXAlUbTSJy9N7j7Teu2KqQYDf1lFLE6XvFjDgcDQC/X4qxm2RsrPJqYKDcFAiKlB2J/K+UqYDr+IHlXojdake6ar1oS7HMzDnsAUprVCckT4VfWAWt6YMxMV6bp/L2DV425+9xbIreBIIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762843; c=relaxed/simple;
	bh=8A9SkO04vSlkUUgqPcEfm6h1PCREc7of0CLjr3qR6yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBTYBtua+tqDplpJvu8fMXb0Ts5KB7YImubhO/n3wVtxvPK+sFcJkzxZE9+Ha2sKpqw11kEoeGhhPF6fAwGNNhmK20Hqk5Zp2kC8eS43mZ8Y/EG3jETr96evLljcOcm1lykBEoGhhLSmuV6ywAY3JGLBWnYn3sFkFUYeiyVgy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JhKZv/5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92079C4CEE3;
	Thu, 17 Jul 2025 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752762843;
	bh=8A9SkO04vSlkUUgqPcEfm6h1PCREc7of0CLjr3qR6yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhKZv/5Dx/s5tmeTCw2NNzWAPIGbN+1/aVfvwRbYN4DjwX/jfADJYq+OMa1P7mkXh
	 0Ad4aaC2GMn8bEnLDKv9gXllVWqLVhYEQb9Y/BwA3gLD/xcr/h6MeTwYIfBf2nm9qM
	 W0Dfr9i6KBSFF16qYTViw3HOTsOUIwo/omN0S0hE=
Date: Thu, 17 Jul 2025 16:33:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] misc: ti-fpc202: use new GPIO line value setter
 callbacks
Message-ID: <2025071750-emptiness-ambiance-3275@gregkh>
References: <20250717130357.53491-1-brgl@bgdev.pl>
 <20250717130357.53491-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717130357.53491-2-brgl@bgdev.pl>

On Thu, Jul 17, 2025 at 03:03:56PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

