Return-Path: <linux-kernel+bounces-733261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C115B0723B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E6016A52A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4212F234F;
	Wed, 16 Jul 2025 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnyiDzi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FB22A1E6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659669; cv=none; b=u3k1+NcUYIl7mWqYK3df7YhtO1UXO9UBKQyzEzWzzMY9Xph0MvXuR+UlxmixGxhxxqXPbzOFw9IcNdNADyPogDt2xmPjrZw00jYtEfluhyT9OB/FFSUhnCvE1UKfqu/gvBoq+EqQ1xif914IHZ9Ou21oPy+X3xlIqpIF3tfkUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659669; c=relaxed/simple;
	bh=AAlSMrt7X05IcetxRmTOp47BMwnYQEh57TaW9WdB9FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nILU0ick/o9EXfuUuasMnYyFonHUXAGNuAwbbLYoa1yL2Xczm+m2w1hfV93iL2miOM2CeHTI9cy8aei3eIRo7yjHa3rYSy/mpUnus8KH9OVanXiDOPKyfyz41Oo0H3ZUUsxI/B/9fu9gnafJ2mx/UrFYi804YA5LD9BffjLYgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnyiDzi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16749C4CEF0;
	Wed, 16 Jul 2025 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752659668;
	bh=AAlSMrt7X05IcetxRmTOp47BMwnYQEh57TaW9WdB9FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnyiDzi5h+nHya3h5NA+r+ILJHud0Lmkw7uUYSJEvgsenk2c96GwENY8djcM9qtyD
	 7CKv99024wffhrqoOImuyvzbTbuyZueIlPzttvit20K5g9SOhcDXtP1UzNuSIS+f5K
	 K+cWIU4dBPTIh6/Xikq7ggNVmoEGFTqT+HIKdXms=
Date: Wed, 16 Jul 2025 11:54:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v3 2/5] mei: make char device control its own
 lifetime
Message-ID: <2025071601-squatter-lent-4260@gregkh>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
 <20250709151344.104942-3-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709151344.104942-3-alexander.usyskin@intel.com>

On Wed, Jul 09, 2025 at 06:13:41PM +0300, Alexander Usyskin wrote:
> Allocate character device dynamically and allow to
> control its own lifetime as it may outlive mei_device
> structure while character device closes after parent
> device is removed from the system.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/main.c    | 36 +++++++++++++++++++++++-------------
>  drivers/misc/mei/mei_dev.h |  4 ++--
>  2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 95d4c1d8e4e6..5335cf39d663 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -51,7 +51,9 @@ static int mei_open(struct inode *inode, struct file *file)
>  
>  	int err;
>  
> -	dev = container_of(inode->i_cdev, struct mei_device, cdev);
> +	dev = idr_find(&mei_idr, iminor(inode));

What keeps the device structure in this idr after it has been removed
from the system before the char device is closed?  Does the class device
lifespan outlive this?  It seems like it really isn't saved anywhere,
but the release function accesses it, right?

Or is that a _different_ device pointer?  How many different
pointers/structures are associated with a struct mei_device now?

confused,

greg k-h

