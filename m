Return-Path: <linux-kernel+bounces-738102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609BFB0B449
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2391188C749
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540621D79A5;
	Sun, 20 Jul 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ngxp6XtW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6F2F41
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000559; cv=none; b=m5g415wq4TBrk13vOPFb5qA/9xNejekuWpcC74IuNvi0BC4fIhLPDY0iIHss3/ujQ1SfM9o4Wi/sXiowtWWXuKwk/MqPaLrM3gCDfvRYOOToqNMn5HMDxnzGFWWChdm5KoNSEF3ya1rl1hzxsUlCHryrCUBBY9/IDoB9EpYWf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000559; c=relaxed/simple;
	bh=8GvBBuooBz3GGtAm95vKLVmfdbtyytky/MB1HY9f4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV0+HgvSCXhCRG/JB8y4DQHFD1q5Sg59P3KGQ+pKUjrwCRt19pI6k7bMWPFzdTA39weSjl1OUwyfFdBf3ZrpGego03IfjsE83pfJ3UZ044aDPu6lgK0Guds7LsdMykByMEKrHvUCyuQtHzYNnDnmX8pjOcX5xN4iSyCuuc+4bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ngxp6XtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F67C4CEE7;
	Sun, 20 Jul 2025 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753000559;
	bh=8GvBBuooBz3GGtAm95vKLVmfdbtyytky/MB1HY9f4Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngxp6XtWPh5SU/ODx84DY5jTYZQE+9Mfkq2QP1di9OkV0mJUFPtzK9DRPc14KfqOn
	 xkDXsTmak+qnzE7mA4a5g8tKCJFIRa5yCILlcatf0GtQDTL+Ip7gap/xUP4rW/gmJw
	 tVYZYm/n25KIMbEZJe+JVxA3TiNx0VnsMSDSN/3E=
Date: Sun, 20 Jul 2025 10:35:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com,
	linux-kernel@vger.kernel.org,
	Super User <root@localhost.localdomain>,
	syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] [PATCH] comedi: check for NULL get_valid_routes function
 pointer
Message-ID: <2025072008-stubbly-imbecile-0d61@gregkh>
References: <20250720073350.22251-1-prabhakar.pujeri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720073350.22251-1-prabhakar.pujeri@gmail.com>

On Sun, Jul 20, 2025 at 02:33:50AM -0500, Prabhakar Pujeri wrote:
> From: Super User <root@localhost.localdomain>

I don't think you have your git setup properly :(

And look at the subject line, two "[PATCH]"?

> The function get_valid_routes() calls the low-level driver's
> dev->get_valid_routes() callback directly without checking if it is
> set. If this function pointer is NULL, the kernel crashes with a
> NULL instruction pointer dereference.
> 
> This patch adds a check to ensure the callback is present before
> calling it, and returns -EINVAL if it is missing.
> 
> This prevents a kernel crash when user space invokes an ioctl that
> results in get_valid_routes() being called on drivers that do not
> implement the callback.
> 
> Reported-by: syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com

Was this tested?  If so, please provide that information.

> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>  drivers/comedi/comedi_fops.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 3383a7ce27ff..2b8cb280287b 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -1302,6 +1302,11 @@ static int check_insn_device_config_length(struct comedi_insn *insn,
>  static int get_valid_routes(struct comedi_device *dev, unsigned int *data)
>  {
>  	lockdep_assert_held(&dev->mutex);
> +	if (!dev->get_valid_routes) {
> +		dev_warn(dev->class_dev ?: dev->hw_dev,
> +				"get_valid_routes() not implemented\n");

Why are you allowing userspace to flood the kernel log?  If this is
something that userspace can trigger, it needs to be handled much
better.

thanks,

greg k-h

