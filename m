Return-Path: <linux-kernel+bounces-733601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E5B076CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C03B584669
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C131A3167;
	Wed, 16 Jul 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0Al1cZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15215E5BB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672115; cv=none; b=otuDepckyc/ShY1LXKlSeY2Yhu55KmS7SQx33qyW9ih4siVn3EWAFOyTlAxDia7tsdf192wTMerIXcnFiBgNVt9LZHlVD9+32iQisc5flUfLur6h2gE8ItN5PO4VXRw8AJDF+30wTI3FWMzCHUrduNVXHo88kfg/6wGbklM2/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672115; c=relaxed/simple;
	bh=I9mhJvZjmMLRfJhLtW+djnXSuVofN+f8i7sojOsj1w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ySS8SiNUAiej/sRC6E1+vVtbCaudvtTZFBSvGMXOsk8YIUeYB5SG2XwGekaJgCfU2lQIfGjdIa+lKa+k7QjhqexfNhp+MVCbn9aDhrv1Gd1XgamYWvtfSHQbeZnUUJ8oW5dDvGDyWCYx5gP4i++/qmX5hSe8bd12gAd8FZs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0Al1cZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE2C4CEF0;
	Wed, 16 Jul 2025 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752672114;
	bh=I9mhJvZjmMLRfJhLtW+djnXSuVofN+f8i7sojOsj1w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0Al1cZu0E0E9IkwW/bcHr0VmaMg6wJbWS+eFOMNrLIWt2AURvkaM1EUmFEsfhRav
	 +Qccc54LJ9YpJrtA+EmKBUGaq+u2QG4yt5be7IOv6UeQByOe4IrrgyEae9D4si2wJx
	 8JNBvfXaGNR5DcZwTGNUMjRWKRSLQ4gzH5sHhAJI=
Date: Wed, 16 Jul 2025 15:21:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-devel@silabs.com, Alex Elder <elder@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [RFC 4/6] greybus: add API for async unidirectional transfer
Message-ID: <2025071626-doorknob-coastline-b85c@gregkh>
References: <20250705004036.3828-1-damien.riegel@silabs.com>
 <20250705004036.3828-5-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705004036.3828-5-damien.riegel@silabs.com>

On Fri, Jul 04, 2025 at 08:40:34PM -0400, Damien Riégel wrote:
> This adds a helper function for unidirectional asynchronous transfer.
> This is just for convenience as some drivers do these steps manually,
> like the loopback driver in gb_loopback_async_operation().
> 
> Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
> ---
>  drivers/greybus/operation.c       | 52 +++++++++++++++++++++++++++++++
>  include/linux/greybus/operation.h |  4 +++
>  2 files changed, 56 insertions(+)

Shouldn't you conver the loopback driver over to use this, so it's not
just increasing the overall code size, and we can see how it will be
used?

thanks,

greg k-h

