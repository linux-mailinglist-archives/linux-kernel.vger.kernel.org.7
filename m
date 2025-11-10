Return-Path: <linux-kernel+bounces-892857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6EC45F57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A17D1881C85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6937301034;
	Mon, 10 Nov 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExuiExjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FA23D7FB;
	Mon, 10 Nov 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771029; cv=none; b=YLEBkbGSNmoZGV+8RKoKYo3YI7MZrk6aFxhyTdfd6H+mmWX8ILPdIWVdzuSU60w+TyNcyIL965WDf+NFXkfMBViYygC2mE3L4suDT0rbVIrPHQMCzAmMiDvEToASdappZwQDK3QAc11HR8mrwqOACETjhO1bd0VN6yBuloVt6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771029; c=relaxed/simple;
	bh=c21XxuCvXG7uNmvnZVpcQwEPPEygi6NBh1nPRti0jxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1e448GDtO/CqBP0nMAJcs8JirKlMKbaGNaD+v+7tLvrNXj7mf7wgkteW1I+up+aerfY6YPyea53pZaPu+K57qtuBoePravvcIgVh55gCC2yPEWXLWllC7Hijrk65UoG0qL9Rhhev2XSt4ZMyplI1RYx+zdpOFt8WUyJgjrmwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExuiExjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660BC19425;
	Mon, 10 Nov 2025 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762771027;
	bh=c21XxuCvXG7uNmvnZVpcQwEPPEygi6NBh1nPRti0jxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExuiExjnrBqFMgF3VY++M5kTuwdrLQfgN86BIkL3uQ+hJMLR41IdyPXKcg7gF5qOo
	 ATnPx0PMLy+MxgS4nx+6lB96GOCz+J3QyQg9jOZnK1N9AOJlSxc3shC7rRK5BHn9AP
	 55KBj9Jj3rfEcvf1IztBzn0LNgYQKzqiKQkZz0wA5OlNPuBzhKxWNk7DKiWXVQUb5A
	 HeLaUz0cBLRedVQz5DIibLQX5u/+MDql/ULXmRAnPMU7rcrcJ3SFzh1aAgTWOO0PL2
	 hX3uinOxpbSdB5+e1jUKVg8i4Vsh7svHDIqkBmHeTVfzuT+Gd09TQ0TbypFemTGJq8
	 2Klr2FvEDbh5g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPGm-0000000013s-0h2f;
	Mon, 10 Nov 2025 11:37:08 +0100
Date: Mon, 10 Nov 2025 11:37:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] gpib: Add build rule for gpib to Makefile
Message-ID: <aRHAVCxtOBNIDlk5@hovoldconsulting.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
 <20251110102507.1445-12-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110102507.1445-12-dpenkler@gmail.com>

On Mon, Nov 10, 2025 at 11:25:07AM +0100, Dave Penkler wrote:
> As part of the destaging of the gpib drivers we need to add the
> gpib rule to the main drivers Makefile.
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 8e1ffa4358d5..d275b1526cdd 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -150,6 +150,7 @@ obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
>  obj-$(CONFIG_VHOST)		+= vhost/
>  obj-$(CONFIG_GREYBUS)		+= greybus/
>  obj-$(CONFIG_COMEDI)		+= comedi/
> +obj-$(CONFIG_GPIB)		+= gpib/

And similar here, fold it into the patch moving the first gpib bits out
of staging.

>  obj-$(CONFIG_STAGING)		+= staging/
>  obj-y				+= platform/

Johan

