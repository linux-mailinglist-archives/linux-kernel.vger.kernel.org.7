Return-Path: <linux-kernel+bounces-761471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8CEB1FA80
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A183ABBED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64209185E4A;
	Sun, 10 Aug 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/xnyZpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDE27462;
	Sun, 10 Aug 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836920; cv=none; b=Tu0XSs24281xWSrJDs0b594Y13yNHdTbT+iQaWPkwQLV4HNzwywowLbSwJxKBTCcK5SgS4SLjkdcLRyi1n3tVNPNezgmDyD8Yi3ogmoYrZ8MtRgUT8Fc4OjOZ2aw5YomgQkApH2IsY9jGC9jHtBMiB/t+RLCtwzs70Leubglpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836920; c=relaxed/simple;
	bh=HvT9pror921pOe5uMwS3gIoavtbqAOFDqoQIPnEJHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/yvIqOWhvmUAMr5Y4tkYKLY9jjjZB75MbkDFpI0xct9KNDLOlyOyg6feZFVGnnJt+ykwPQo6ZnHHcc9IlDl5UrvG7udupqnBW+8zQ0xuAhZtK0ZYAWL9ZkEJVBty9Duj5XsaD4jj4TUXiAXDvMFXRRw0pt+F8wMB7GkGnVGkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/xnyZpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE255C4CEEB;
	Sun, 10 Aug 2025 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754836920;
	bh=HvT9pror921pOe5uMwS3gIoavtbqAOFDqoQIPnEJHPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/xnyZpz28bXCvkvD17Uid9feY/x5ZhfeAAchkwqvnyBJuR3ufsjjBzOFiK1nx/jX
	 xrvY4Q6Btg2rJRUvamHVEKQzya0BePGHc9guqHd22BRh9/GJDgvh2s97YT2frVZUo3
	 d7fAFbDBFRfN+3+NSbpp8Mm1BcIdqjOe2SmXEbds=
Date: Sun, 10 Aug 2025 16:41:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: axis-fifo: use unique identifiers in device
 names
Message-ID: <2025081035-encourage-lend-0a15@gregkh>
References: <20250808204831.2618122-1-ovidiu.panait.oss@gmail.com>
 <20250808204831.2618122-2-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808204831.2618122-2-ovidiu.panait.oss@gmail.com>

On Fri, Aug 08, 2025 at 11:48:31PM +0300, Ovidiu Panait wrote:
> Axis-fifo devices use physical addresses in their name, for example
> 'axis_fifo_0x43c00000'. This is generally frowned upon and it does not
> follow the usual naming scheme that uses unique identifiers.
> 
> Therefore, use ida_alloc()/ida_free() to implement unique identifiers
> for axis-fifo device names (i.e. axis-fifo0, axis-fifo1, etc.).
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 06f7cfab4c6a..27e12af25bc7 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -107,6 +107,8 @@
>  static long read_timeout = 1000; /* ms to wait before read() times out */
>  static long write_timeout = 1000; /* ms to wait before write() times out */
>  
> +static DEFINE_IDA(axis_fifo_ida);
> +
>  /* ----------------------------
>   * module command-line arguments
>   * ----------------------------
> @@ -123,6 +125,7 @@ MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing out;
>   */
>  
>  struct axis_fifo {
> +	int id;
>  	int irq; /* interrupt */
>  	void __iomem *base_addr; /* kernel space memory */
>  
> @@ -698,10 +701,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  
>  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
>  
> -	/* create unique device name */
> -	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
> -	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
> -
>  	/* ----------------------------
>  	 *          init IP
>  	 * ----------------------------
> @@ -737,6 +736,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	 *      init char device
>  	 * ----------------------------
>  	 */
> +	fifo->id = ida_alloc(&axis_fifo_ida, GFP_KERNEL);
> +	if (fifo->id < 0)
> +		return fifo->id;
> +
> +	snprintf(device_name, 32, "%s%d", DRIVER_NAME, fifo->id);
>  
>  	/* create character device */
>  	fifo->miscdev.fops = &fops;
> @@ -744,8 +748,10 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	fifo->miscdev.name = device_name;
>  	fifo->miscdev.parent = dev;
>  	rc = misc_register(&fifo->miscdev);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		ida_free(&axis_fifo_ida, fifo->id);
>  		return rc;
> +	}
>  
>  	axis_fifo_debugfs_init(fifo);
>  
> @@ -759,6 +765,7 @@ static void axis_fifo_remove(struct platform_device *pdev)
>  
>  	debugfs_remove(fifo->debugfs_dir);
>  	misc_deregister(&fifo->miscdev);
> +	ida_free(&axis_fifo_ida, fifo->id);

Did you forget to call ida_destroy() when the module is unloaded?

thanks,

greg k-h

