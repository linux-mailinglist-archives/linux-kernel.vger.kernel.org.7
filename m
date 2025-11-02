Return-Path: <linux-kernel+bounces-881770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB0C28E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754C03B0D9F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4F2D879C;
	Sun,  2 Nov 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2/FYwdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEB12D1F1;
	Sun,  2 Nov 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083173; cv=none; b=iuhaVCqDnS7/vCa5ArO8PlB/l0Ywg834KvLK236vSsF4W+ETZKDpvQNcJqdjAJgEEh/alNMNVk79ReUyE8oTIP44qnHBonG58y4EVyXGKuWsfICs+b3fB1gywPdNjFpRoSKCGmSlyR8efgV1OBc3OTLGRY58IHJfuvEYLSL2uRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083173; c=relaxed/simple;
	bh=c09UBpO7d7MkezvfvSoY7wZoQ2kHuE8Zm3NboeqeMyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsuFJroImeQm2MhW842ilezbbQgwDFdYd8lz7i/CRU3TZf2n8iD4rHRUbBPas7skBmIMuDDU2DxwQbA5YWdsl+9ic6SIFXXaAgWvErG4MRPtH7FJTqpfgLZXxVPKMk+xBA8tzMDMHoQpMM1cDPVFKNtr8QYtwH0XVL25SmQiY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2/FYwdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC168C4CEF7;
	Sun,  2 Nov 2025 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762083172;
	bh=c09UBpO7d7MkezvfvSoY7wZoQ2kHuE8Zm3NboeqeMyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2/FYwdhVvYZSVK+9mi6qk/Sd6TKPYScT3YiUtpbgvtborSsWYj3m7nD+yVTV2UMs
	 X8Y8O3VJOgHXnw6GBTTjo4v+DLWKzqGVLGK+QRAIjigPKhX8MhNIWXurm6HPPzwQqo
	 /E6GEiBk7n6q6HSJBQrUZMZpEptIm19Hk1VMAuxs=
Date: Sun, 2 Nov 2025 20:32:49 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Chang Junzheng <guagua210311@qq.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fix various code style issues
Message-ID: <2025110215-hacking-sauna-a29d@gregkh>
References: <tencent_08373024EBB5D2D03BAB7518F6F51D212907@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_08373024EBB5D2D03BAB7518F6F51D212907@qq.com>

On Sun, Nov 02, 2025 at 03:42:15PM +0800, Chang Junzheng wrote:
> Fix trailing whitespace in rtl8723bs driver and add missing
> newlines at end of file in multiple staging drivers.
> 
> Changes include:
> - Remove trailing whitespace from rtl8723bs/core/rtw_mlme.c
> - Add missing newline at EOF for vme_user/vme.c
> - Add missing newline at EOF for vme_user/vme_fake.c
> - Add missing newline at EOF for vme_user/vme_tsi148.c
> 
> This addresses checkpatch.pl warnings about code style compliance.
> 
> Signed-off-by: Chang Junzheng <guagua210311@qq.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>  drivers/staging/vme_user/vme.c            | 1 +
>  drivers/staging/vme_user/vme_fake.c       | 1 +
>  drivers/staging/vme_user/vme_tsi148.c     | 1 +
>  4 files changed, 4 insertions(+), 1 deletion(-)

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

