Return-Path: <linux-kernel+bounces-738115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E3B0B48D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D097AC837
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F851DDA15;
	Sun, 20 Jul 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="F2/XllA9"
Received: from smtp123.ord1d.emailsrvr.com (smtp123.ord1d.emailsrvr.com [184.106.54.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AC2AD0F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753003007; cv=none; b=UA5JLuD4BME8wEX1P6c6yzM+wlXgaeMbSRuIy8uLtd9QEyMW29/0IZbvP0y23C45ZZ9QmhC/GYYxdsN2L+zMLR5CIodO/GC1mVM+QuJeUsjeAdhIsCwdInWfdAFttDfjZexauWQEK3vbIpfJKRLteFk9DiBF0ya3mtGpo32vet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753003007; c=relaxed/simple;
	bh=CdefaXMgrKDMmBBNjQA/ADjXFeAJTprj6Ac9Te8aAHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QR59tKj9uymb9Nd6M3zfHoXPBf7+QXnLlLM1SrDxMdn2SlxN+aprY+YtSR7fYPDqSDU2FqnrE7yAZWvzhDyCmQBCterVnlY3xcy6Bg/zmJdO37J0HxMT3CLnGaUPAhY0+vTVHtcDjhy83NpXOi4GqtCF0dDaJY2DQVmp06X0Rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=F2/XllA9; arc=none smtp.client-ip=184.106.54.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753000820;
	bh=CdefaXMgrKDMmBBNjQA/ADjXFeAJTprj6Ac9Te8aAHo=;
	h=Date:Subject:To:From:From;
	b=F2/XllA9GV17HLusiN//tfj+LEcYbVnYvl85j1buGOGJVhnl4z67x5d3h5dZdl21l
	 RnsIUUAREMiJQxmR0m7QXr5OTQmePgHJHVQwQckNCmbfn3SxN8HiWPg94qyDIVdbbb
	 hGO5AYy46+FYK/WkEDndYgMjB7G6Ul8SKr1MFKyM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 908DCA010E;
	Sun, 20 Jul 2025 04:40:19 -0400 (EDT)
Message-ID: <a79f5854-a28a-4793-8ff6-8886f8292191@mev.co.uk>
Date: Sun, 20 Jul 2025 09:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] comedi: check for NULL get_valid_routes function
 pointer
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>,
 hsweeten@visionengravers.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com
References: <20250720073350.22251-1-prabhakar.pujeri@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
In-Reply-To: <20250720073350.22251-1-prabhakar.pujeri@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 388f626b-35ab-4ea7-9a2a-71301c9cf9fc-1-1

On 20/07/2025 08:33, Prabhakar Pujeri wrote:
> From: Super User <root@localhost.localdomain>

I don't know why you added a "From:" line, but its details are bogus.

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

That's a reasonable guess, but the callback shouldn't be missing.  If 
the low-level driver does not set it, then the 
__comedi_device_postconfig(dev) call in "drivers.c" will set it to the 
address of the get_zero_valid_routes function.

> 
> Reported-by: syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>   drivers/comedi/comedi_fops.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 3383a7ce27ff..2b8cb280287b 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -1302,6 +1302,11 @@ static int check_insn_device_config_length(struct comedi_insn *insn,
>   static int get_valid_routes(struct comedi_device *dev, unsigned int *data)
>   {
>   	lockdep_assert_held(&dev->mutex);
> +	if (!dev->get_valid_routes) {
> +		dev_warn(dev->class_dev ?: dev->hw_dev,
> +				"get_valid_routes() not implemented\n");
> +		return -EINVAL;
> +	}
>   	data[1] = dev->get_valid_routes(dev, data[1], data + 2);
>   	return 0;
>   }


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

