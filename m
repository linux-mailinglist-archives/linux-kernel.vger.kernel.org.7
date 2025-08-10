Return-Path: <linux-kernel+bounces-761351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732BB1F8AD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189BD7AD360
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610622A7F2;
	Sun, 10 Aug 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLGYQVTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1605A921
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808787; cv=none; b=OgwYqBG69ULkpKlfeeTs0G2Hj8ftxiklmFbGXye8YCS04kls4NGFgjPb/buZc6BcfDLpCdrTSvCY//yLXbJVztUAhiHf7MAGoJpTdi4BuI6nLxhc3PFeAIPGeSQh7/08cnuClhhXUM4JySSdLVVFuIbPW2fdVqpEAxRVvU26sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808787; c=relaxed/simple;
	bh=itTBfLbVYy8jf6XRitO41dqZmRXiVD5UC8u1zxDdm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5AWHiVjX/dVVLlxF4+gt1hTiybFFVkZop6JOfR4OLMFTd0OwkJwYyblurEOxWHO6saBzpbkhPAbYzPqOwPQM9xVRGR3Y9zYk6S1i5CWDX0qqqModN6PatYLJx9CGu7BpVm7jZ9l6CaGIwg8v4yeh8sL0MhsVaJLq5rmgnJwZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NLGYQVTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B64C4CEEB;
	Sun, 10 Aug 2025 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754808786;
	bh=itTBfLbVYy8jf6XRitO41dqZmRXiVD5UC8u1zxDdm4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLGYQVTy8OW33D4bdq4yNMigjgzvOeOCC/fMX5ywbzoGK6Ugf6C9xVq8QsgdKm7kp
	 +qLiaXzKjl/iRAdlqzO3AmWmqDTVcaiOU29xV7UdjoRlaLTvRPYMczJk8XksruYhZG
	 zBlVAPx/9fheNISx3m7H4R6IESKJvV51BpzZ9z6o=
Date: Sun, 10 Aug 2025 08:53:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wajahat iqbal <wajahatiqbal22@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: ds1682: fix out-of-bounds access in EEPROM
 functions
Message-ID: <2025081032-aids-matrimony-1233@gregkh>
References: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>

On Sat, Aug 09, 2025 at 08:54:57PM +0500, wajahat iqbal wrote:
> Found a couple of issues in the ds1682 driver while reviewing the code:
> 
> The EEPROM read/write functions don't check if offset and count exceed
> the 10-byte EEPROM size, which could lead to out-of-bounds I2C access.
> 
> Also replaced sprintf with scnprintf in the sysfs show function for
> better safety.
> 
> For reads beyond EEPROM size, return 0. For writes, return -EINVAL if
> starting beyond bounds, otherwise truncate to fit within the EEPROM.
> 
> Signed-off-by: Wajahat Iqbal <wajahatiqbal22@gmail.com>
> ---
>  drivers/misc/ds1682.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
> index cb09e056531a..4cf4b43e5355 100644
> --- a/drivers/misc/ds1682.c
> +++ b/drivers/misc/ds1682.c
> @@ -92,7 +92,7 @@ static ssize_t ds1682_show(struct device *dev,
> struct device_attribute *attr,
>   * Special case: the 32 bit regs are time values with 1/4s
>   * resolution, scale them up to milliseconds
>   */
> - return sprintf(buf, "%llu\n", (sattr->nr == 4) ? (val * 250) : val);
> + return scnprintf(buf, PAGE_SIZE, "%llu\n", (sattr->nr == 4) ? (val *
> 250) : val);
>  }
> 
>  static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
> @@ -163,6 +163,11 @@ static ssize_t ds1682_eeprom_read(struct file
> *filp, struct kobject *kobj,
>   dev_dbg(&client->dev, "ds1682_eeprom_read(p=%p, off=%lli, c=%zi)\n",
>   buf, off, count);
> 
> + if (off >= DS1682_EEPROM_SIZE)
> + return 0;
> + if (off + count > DS1682_EEPROM_SIZE)
> + count = DS1682_EEPROM_SIZE - off;
> +
>   rc = i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + off,
>      count, buf);
>   if (rc < 0)
> @@ -180,6 +185,11 @@ static ssize_t ds1682_eeprom_write(struct file
> *filp, struct kobject *kobj,
>   dev_dbg(&client->dev, "ds1682_eeprom_write(p=%p, off=%lli, c=%zi)\n",
>   buf, off, count);
> 
> + if (off >= DS1682_EEPROM_SIZE)
> + return -EINVAL;
> + if (off + count > DS1682_EEPROM_SIZE)
> + count = DS1682_EEPROM_SIZE - off;
> +
>   /* Write out to the device */
>   if (i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM + off,
>      count, buf) < 0)
> -- 
> 2.49.0.windows.1

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

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

