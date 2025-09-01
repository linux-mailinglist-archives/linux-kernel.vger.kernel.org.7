Return-Path: <linux-kernel+bounces-793994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A5BB3DB47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950B217AD3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F6271451;
	Mon,  1 Sep 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEnKC/RE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A4270553
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712412; cv=none; b=QkhmcQv1VTFZjDsUf5zcJKgXFBvMzBF1dBmNgxZ0G5y0Agb1EviLxVN3US3xwttpP0jIbEIHpoXM3brDCgzlik+J82zqpweIrOuWJdLa2KEFAXtcRWx29F4niSFJ8hMydXz4Elz+ZHS9Rk6Mu0I+I5It0STUIHEI8dabnOnpLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712412; c=relaxed/simple;
	bh=8WIB6jBzvXtpOGzijwoI7D/TfYlx/JYFZ/Iag0qXF38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCHPP1HJejNzgLkb4FaHGOer+lW61hUHOX6BmfiCk6Ulh7ZqG3YZQHKC0o22+wrxx3yvS6+gYs5z11W1uZnNVWI/sEoZa781Dujkr/kQEX0el4WP4NiWfnCcYQochagwuYU6uedKv3fET0YeZ029FidMaoy76+o/+oUxDxv/QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEnKC/RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8872FC4CEF0;
	Mon,  1 Sep 2025 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756712411;
	bh=8WIB6jBzvXtpOGzijwoI7D/TfYlx/JYFZ/Iag0qXF38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEnKC/REMDosj1B7BcnHM+kNCqnDb6wBRNwSKiG6TUfFD0ptCgztLPVeGsshnGq4g
	 ITSfp7+Eij+2+WfFc5GyWSC3odpBENFtErXAgEXh2+DJSFDQD3+Jju3C+kh2GunBi4
	 PFo7Qydyj9p6Zje7U5tNG+dteTDf9J2HwLqs4iC0=
Date: Mon, 1 Sep 2025 09:40:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Janne Grunau <j@jannau.net>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: Fix OOB read for bit offsets of more than
 one byte
Message-ID: <2025090158-ending-definite-33f2@gregkh>
References: <20250901-nvmem-read-oob-bit-offset-v1-1-b610e18cdd3c@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-nvmem-read-oob-bit-offset-v1-1-b610e18cdd3c@jannau.net>

On Mon, Sep 01, 2025 at 09:29:43AM +0200, Janne Grunau wrote:
> When the bit offset is BITS_PER_BYTE or larger the read position is
> advanced by `bytes_offset`. This is not taken into account in the
> per-byte read loop which still reads `cell->bytes` resulting in an out of
> bounds read of `bytes_offset` bytes. The information read OOB does not
> leak directly as the erroneously read bits are cleared.
> 
> Detected by KASAN while looking for a use-after-free in simplefb.c.
> 
> Fixes: 7a06ef7510779 ("nvmem: core: fix bit offsets of more than one byte")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/nvmem/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

