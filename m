Return-Path: <linux-kernel+bounces-842328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D0CBB9823
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 685003464DD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39B2877D4;
	Sun,  5 Oct 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DRFjrFoI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC113BC3F;
	Sun,  5 Oct 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759674198; cv=none; b=NaCiaut/6jG98WULiT5R3TdMP9LSMcDCZcy4no1SF94ASHlNje32Upd4bU5LM8p+SkiHje3Edk/0P6rX63mj7FuBalrhBaZ0NRJtuxE8GGMa76I7ICbIiAUCgxlhH3uYeaYf+WPbaAFHk7BrshhJTIM4emvAwoJCyGW3VtcEBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759674198; c=relaxed/simple;
	bh=ycU+8C97H70bHad571FcwXL/nRa2ctwxLVCZqgqPbL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cms5jXoAyeDxZ6i6rR5rVPVjfuZ0tIrJ8Tb/pTTLgwnuDgZbDsj9oJuKhwODUDc5UtSzTDui/+fsbK3bQ/RV5hkR6q9c0VBHpZTt7eUg5Rd6H+HR2rEAv6cJozslLuLjBkv0JDD3Gnmbungbl1Is9Sm5YcX362ogYoO9unRuAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DRFjrFoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB08C4CEF4;
	Sun,  5 Oct 2025 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759674196;
	bh=ycU+8C97H70bHad571FcwXL/nRa2ctwxLVCZqgqPbL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRFjrFoII/EJadQ2/Ma2vy7M9Axzz1TnBN93lHv5MUh9AHdukLiV+t+SfY9nTEPtn
	 xAZoHTXDrn2VoIbm8fzaG0kANsifK1WzYzrh0F/O/wkmQrGzp+n5GxGy1PHqjwAYT4
	 GSjQ/ZpLV3YxzkbewYrPpDqO69D3uLuzR9iQaYOs=
Date: Sun, 5 Oct 2025 16:23:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rohan Tripathi <trohan2000@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: clean up style in rtw_ap.c
Message-ID: <2025100552-everybody-outmost-8ae0@gregkh>
References: <20251005135525.314476-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005135525.314476-1-trohan2000@gmail.com>

On Sun, Oct 05, 2025 at 09:55:25AM -0400, Rohan Tripathi wrote:
> This patch fixes several coding style issues reported by checkpatch.pl
> in rtw_ap.c. Changes include:
> - Removed cases where lines ended with an opening parenthesis
> - Broke long comments exceeding 100 characters
> - Fixed alignment in multi-line function calls
> 
> These are coding style cleanups only. No functional changes.
> 
> Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 270 +++++++++++-------------
>  1 file changed, 123 insertions(+), 147 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

