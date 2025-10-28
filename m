Return-Path: <linux-kernel+bounces-873334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C161BC13B74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA05C4F0C17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CAF2E7F39;
	Tue, 28 Oct 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlkHqxJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33F2E7BAA;
	Tue, 28 Oct 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642334; cv=none; b=r4ILxRJn3ELIts2/6aWX2NxU8wNYyGa8hzaTYya+KVB5ftYCryJzVhWoGtSSuMnidg7PrmDIwNHZguq+NfsYnwkvCx7F83mJ/NRU4CCThFxdPe//1jO4/+DJKrAz1oAlZXdXssZr/uH3nHg9vAWXgYrB/15JHSi1qauussf0WvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642334; c=relaxed/simple;
	bh=psR1QMfqUdCm4AAMIXHI0ZlmBAB22bLGX7YQBzfzuqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJbdz+HjaILODKWNaCX0w1J7L6L0V12E5mjIrsZHJDnueqoBv4cAjlVSHwSQT5EbcEgzs59SeyiULHQw3gtR+F4jyfyJ1y811DUjVk5Ep9t7rFllB+bS9GvSMbH72i/hNaLlubTizolIOW9OTar33tjgP39pV4+MR0JqgHoAgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlkHqxJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D061C4CEE7;
	Tue, 28 Oct 2025 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761642334;
	bh=psR1QMfqUdCm4AAMIXHI0ZlmBAB22bLGX7YQBzfzuqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zlkHqxJ50AccVB5Uw5W9dMM7a1tEHrctq9IhoWbk9TSIQ7IJTq1dg/yKgsxUthHN+
	 4w0+x/Pk3508KGgkwryyLXDWXZubSVtOwutE2R5HZ/bxQ00I47XMzTeo4JiWRD6QKs
	 +35wn2xPGni+ZZUfl17xDfjLJNP7SQLVcgl9d5c8=
Date: Tue, 28 Oct 2025 09:45:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, wesley.cheng@oss.qualcomm.com
Subject: Re: [PATCH] xhci: sideband: Fix race condition in sideband unregister
Message-ID: <2025102840-bagpipe-ammonium-eca8@gregkh>
References: <20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com>

On Tue, Oct 28, 2025 at 01:30:43PM +0530, Uttkarsh Aggarwal wrote:
> A kernel panic was observed due to a race condition between un-registering
> sideband and creating sideband interrupters. The issue occurrs when thread
> T1 runs uaudio_disconnect() and released sb->xhci via sideband_unregister,
> while thread T2 simultaneously accessed the now-NULL sb->xhci in
> xhci_sideband_create_interrupter() resulting in a crash.
> 
> By locking the mutex before modifying sb->xhci, any thread calling
> xhci_sideband_create_interrupter() will either see a valid sb->xhci or wait
> until xhci_sideband_unregister() completes.
> 
> Signed-off-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>

What commit id does this fix?  Should it be backported to older kernels?

> ---
>  drivers/usb/host/xhci-sideband.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
> index e771a476fef2..74a58f759cee 100644
> --- a/drivers/usb/host/xhci-sideband.c
> +++ b/drivers/usb/host/xhci-sideband.c
> @@ -481,10 +481,12 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
>  
>  	xhci_sideband_remove_interrupter(sb);
>  
> +	mutex_lock(&sb->mutex);
>  	spin_lock_irq(&xhci->lock);

A mutex and a spinlock irq?  That just feels wrong for the obvious
reasons, only one should be needed.

thanks,

greg k-h

