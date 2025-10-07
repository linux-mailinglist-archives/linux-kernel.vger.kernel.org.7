Return-Path: <linux-kernel+bounces-844229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF33BC1582
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A240A1884AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4F2DC789;
	Tue,  7 Oct 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZwUNGnen"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930D2D97A4;
	Tue,  7 Oct 2025 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839531; cv=none; b=rCTkYADzMSOztNfh4yzfyGK3VCnx4KgrmX2J/xBuQ7uJDB26xkN/odNZEqhEvizy3k1q/YPS+/DYjdzWWwrcsIJRpTWxDS6bqTZKJWhrKuWUcMxtcrWnRLdx/HpF/RJvFXFDrqHP2FsTjUHaCJQGg71PHJe9O0cK0aD5urTsj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839531; c=relaxed/simple;
	bh=8Yu4vCPgZd0CN6i2wCLIeemidiBvWf6cKWMxtI3H7+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oipVN+qBtnXvg8jHAWJNaOSDk+MOm6QecLBcmZf0546kNoHUrZEFsfqNgI2QlJ+mZXTRWMNvk6wF7n391zvLF3e5iceYPiBiZBzE9K+0g4RH3fMFkhfGtAD4xfpFaIe/FrPSjYeMIIOsWKrg4uW6rXt4qRtCaVfGtva4qslJSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZwUNGnen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4372CC4CEF9;
	Tue,  7 Oct 2025 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759839530;
	bh=8Yu4vCPgZd0CN6i2wCLIeemidiBvWf6cKWMxtI3H7+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwUNGnenAxuvik3eFbl9RCaC2YIrBgaPfIa+tkt6LbJ/6Uk511sWR0Mu1U+EpDrSt
	 zf+ZZKCxrwg2KN5F7bbiLZAciXJVdl8dBIzJotW4p5/Q4nJsGbfSm9DXkN/d5BJ8YK
	 yok7WCQ6e6xDL+M5mJXaY99uym56vxtSBaHhxVUM=
Date: Tue, 7 Oct 2025 14:18:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Murad Sadigov <sdgvmrd@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix integer overflow in write()
Message-ID: <2025100757-proximity-unlighted-6ad4@gregkh>
References: <CAEuvNs2b-_Q=dazKjhUwJoZ5XUpjRsf-FrCOTR_j24T+EG-f=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEuvNs2b-_Q=dazKjhUwJoZ5XUpjRsf-FrCOTR_j24T+EG-f=g@mail.gmail.com>

On Tue, Oct 07, 2025 at 03:58:13PM +0400, Murad Sadigov wrote:
> Fix integer overflow in axis_fifo_write() that allows local users
> to bypass buffer validation, potentially causing hardware FIFO
> buffer overflow and system denial of service.
> 
> The axis_fifo_write() function converts user-controlled size_t 'len'
> (64-bit) to unsigned int 'words_to_write' (32-bit) without overflow
> checking at line 322:
> 
>     words_to_write = len / sizeof(u32);
> 
> On 64-bit systems, when len equals 0x400000000 (16 GiB):
>   - Division: 0x400000000 / 4 = 0x100000000 (requires 33 bits)
>   - Truncation: Result stored in 32-bit variable = 0 (overflow)
>   - Validation bypass: if (0 > fifo_depth) evaluates to false
>   - Impact: Hardware FIFO overflow, system crash
> 
> This allows unprivileged local users with access to /dev/axis_fifo*
> to trigger denial of service.
> 
> The fix adds overflow check before type conversion to ensure len
> does not exceed the maximum safe value (UINT_MAX * sizeof(u32)).
> 
> Affected systems include embedded devices using Xilinx FPGA with
> AXI-Stream FIFO IP cores.
> 
> Signed-off-by: Murad Sadigov <sdgvmrd@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c
> b/drivers/staging/axis-fifo/axis-fifo.c
> index 1234567890ab..abcdef123456 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -319,6 +319,13 @@ static ssize_t axis_fifo_write(struct file *f,
> const char __user *buf,
>   return -EINVAL;
>   }
> 
> + /* Prevent integer overflow in words calculation */
> + if (len > (size_t)UINT_MAX * sizeof(u32)) {
> + dev_err(fifo->dt_device,
> + "write length %zu exceeds maximum %zu bytes\n",
> + len, (size_t)UINT_MAX * sizeof(u32));
> + return -EINVAL;
> + }
> +

Something went wrong here, your email client dropped all of the leading
spaces :(

Also, you do not want to allow userspace to cause a DoS on the kernel
log, so don't log this information, just return an error, no need to
print anything.

thanks,

greg k-h

