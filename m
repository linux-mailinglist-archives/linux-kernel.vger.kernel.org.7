Return-Path: <linux-kernel+bounces-772094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC6B28EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05217B012F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD92F533C;
	Sat, 16 Aug 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="eD458XLx"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE72EBDCF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355950; cv=none; b=hVbF0cTtI34CDSabeid+B7ZFc5QBhc6b79q9un/KTGY06kl4QvH7AQ3vBe4CH+cyFCTYIlj4AgmXMpPpgvizjJPcRBK5mL21Rl9Iz7Ce6AcwIJP7BepKXo6iInKY0WAf0oLvLdQ95WWqk0fXxFCYpwliV1c60SVfUNQgEnb33zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355950; c=relaxed/simple;
	bh=hmzW4H3AWUgvL3r/p1KNaUH09J3yAUFgK3NLW+3pfHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHu5CxmC7Arq5Hn1I1oSmKh2Sz/TtNd6krcMh6CoTPr9S8gc5dQhVvhO7M1oAraKZqqUBiI0gkA41qnkrqDjcQTSUGSf5aLlBJ1SDkJpu3I3ccisguP70GD+oE6IrISo0G0oXsKG8g5I/cX4EUFxs2B+xr5C98Hap5fIbehrFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=eD458XLx; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355415;
	bh=hmzW4H3AWUgvL3r/p1KNaUH09J3yAUFgK3NLW+3pfHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eD458XLx2LBkdfgwRl8zBBDqjV12Xg37zRYe6lA7oE+r2YQ0ZCQ0w00loYUWJN+Bh
	 dbh37uQMDdzWaGJBw5tyqCzCW6b/jqTSu1YXWDamIPCvA7rJ9JtWMTvzYGMUcKUD3Q
	 JWuMs7imJF5mKl5OIizg5SXd2dcuehleCpqmLZJW6WVMIm4gWJpBQPYytTp4/Vx3Xs
	 DX9ivWoMcRaf8BisPqkys10MZZzWrYzz6zVm3YsDLfzy4p3zYIzBLu+N/NdODfnDAR
	 Q9WMU6cvgHctp396lJvL5yPLxMUo+tzcXefWnbadfDi2SshsRibws5ne9B63qUfBUD
	 Y9E1zhDabe8xQ==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 889A6200722;
	Sat, 16 Aug 2025 14:43:35 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id B411CA0094; Sat, 16 Aug 2025 16:41:43 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:41:43 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] pcmcia: Use str_off_on() and str_yes_no() helpers
Message-ID: <aKCYp5NayHmfNy2J@shine.dominikbrodowski.net>
References: <20250411084434.7178-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411084434.7178-1-thorsten.blum@linux.dev>

Applied to pcmcia-next, thanks.

Best,
	Dominik

Am Fri, Apr 11, 2025 at 10:44:29AM +0200 schrieb Thorsten Blum:
> Remove hard-coded strings by using the str_off_on() and str_yes_no()
> helper functions.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/pcmcia/socket_sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
> index c7a906664c36..4eadd0485066 100644
> --- a/drivers/pcmcia/socket_sysfs.c
> +++ b/drivers/pcmcia/socket_sysfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  #include <linux/major.h>
>  #include <linux/errno.h>
>  #include <linux/mm.h>
> @@ -98,7 +99,7 @@ static ssize_t pccard_show_card_pm_state(struct device *dev,
>  					 char *buf)
>  {
>  	struct pcmcia_socket *s = to_socket(dev);
> -	return sysfs_emit(buf, "%s\n", s->state & SOCKET_SUSPEND ? "off" : "on");
> +	return sysfs_emit(buf, "%s\n", str_off_on(s->state & SOCKET_SUSPEND));
>  }
>  
>  static ssize_t pccard_store_card_pm_state(struct device *dev,
> @@ -177,7 +178,7 @@ static ssize_t pccard_show_resource(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	struct pcmcia_socket *s = to_socket(dev);
> -	return sysfs_emit(buf, "%s\n", s->resource_setup_done ? "yes" : "no");
> +	return sysfs_emit(buf, "%s\n", str_yes_no(s->resource_setup_done));
>  }
>  
>  static ssize_t pccard_store_resource(struct device *dev,
> -- 
> 2.49.0
> 
> 

