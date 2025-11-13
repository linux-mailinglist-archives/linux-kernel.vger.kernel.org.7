Return-Path: <linux-kernel+bounces-899448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DCC57CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C20134B64D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4981A9FB7;
	Thu, 13 Nov 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E89QRwJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82235CBC6;
	Thu, 13 Nov 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041564; cv=none; b=RsLXHvyOygjURZxEadfG9yvhtRruFJ5/WiiRdEaPsKfzjGauu9caOuaMnzioAYNV9NKufb9WFV4LMCfm6VvOi5of5LhZvIySCbj0tGhDEKhrKeVPwpBK0ZXcngBbBcdIr4m9bT29m2Gvo8O/ZsPlYBZKsUyFl3zytRbbBhnO6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041564; c=relaxed/simple;
	bh=tbmShB58/A4V/gyp12BMzsTR5XfUTVWVtUcByvJPYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ7b671IYsaW6Hdpwhm+UL/psZktWoCWRu6/ZBPdV8ur+i4/XCms8bEHi36FOH2YAZ5V7ThHJ+0s1EQLDpGUHlAzBxpMMFLCtyk8B2MI67SxlmZAPwc89IF3MQ5FTtR00RZRv34QbIaq2bo7aLsBrZ7hz5G4OGOaey+wl5sIbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E89QRwJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD7C4CEF1;
	Thu, 13 Nov 2025 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763041564;
	bh=tbmShB58/A4V/gyp12BMzsTR5XfUTVWVtUcByvJPYIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E89QRwJXX642yqpxb+10seEAGu8mLzKzLQs7ffB5/lxZguXdBHZcpMj4HFjXWbcsp
	 XFFsTfbBKQUqNZd0qMYdBRSziFDWySHsS2qY1WTNYL4AOYeL22U5y2gLfxaGIHBaXd
	 f+gwIj3iL/6tkHeGGYbg+Itmk6G0q+XaA3s7i2M0=
Date: Thu, 13 Nov 2025 08:46:03 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: cjz_VM <guagua210311@qq.com>
Cc: outreachy@lists.linux.dev, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio_manager_module: make envp array
 static const
Message-ID: <2025111307-deafness-uncrushed-ee56@gregkh>
References: <tencent_7710B04B6BEE52903BA2F56376DB9D18A907@qq.com>
 <2025111341-attendee-ferment-262b@gregkh>
 <tencent_27A546C0D8ACEF4B7DEE94D65FD805769809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_27A546C0D8ACEF4B7DEE94D65FD805769809@qq.com>

On Thu, Nov 13, 2025 at 09:39:54PM +0800, cjz_VM wrote:
> Hi Greg,
> 
> Thanks for reviewing my patch!
> 
> For sending twice: I apologize for the duplicate. After the first send, I realized I had missed some greybus-specific maintainers, so I resent to include them all.

Then that should have been a v2 patch :)

> For the indentation: You're right to ask about it. When I changed the declaration from 'char *envp[]' to 'static const char * const envp[]', the opening bracket moved to the right due to the longer declaration. I added tabs to keep the array elements aligned with the opening bracket, following the kernel coding style rule that parameters should align with the opening parenthesis.
> 
> If this alignment approach is not preferred, I'm happy to adjust it to whatever style you recommend.

You did not document your change, and it had nothing really to do with
the const change, so I would not recommend doing this.

Also, please do not top-post, and be sure to properly wrap your lines in
your email client.

thanks,

greg k-h

