Return-Path: <linux-kernel+bounces-721315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6186AFC79E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970751893234
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F53F1DDA18;
	Tue,  8 Jul 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7pb8QyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A007255E34
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968753; cv=none; b=BlJUoxGuacb5hcNwg2iGPEpvWVb6q6Amn569hwh83Cbp1EvDu7K44vhHajaZSgIu4r6jAW9aVoM1yOIMKvhnWAkZ7rDMNCl3GljE8IXEf5DmGm3PN1DaoBzlJaEX2wk035y25dM7C0GOSlnpDcx33fvE+ac5yssl/YQdxzXDkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968753; c=relaxed/simple;
	bh=6eHlk+CFHypLn+/JBLuUu+a5vbblojk3P1wA+j0Nv/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCmDjb1myMeppJW5rcWnyfRk/+4kJwVsyJjEa4y3BPHylKxPqhvzwJymelVNx86rqUVNdTtmxbrOYWyRdSU4ckkU9nbCS/v+r5BpWo7ifb78k3WkoANVYVA8EPv99Rm6F0G5P/o42vP2LbZtBASKLyq09P2AA5B1HhCb2PRHGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7pb8QyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F23C4CEED;
	Tue,  8 Jul 2025 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751968753;
	bh=6eHlk+CFHypLn+/JBLuUu+a5vbblojk3P1wA+j0Nv/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7pb8QyDQrI43uKFdRnsAMXR4ou9R+Dry28H7+1GAe5w9AWYJLWZytqmOamo0h/Zu
	 ein9STzjP3R86Os9/JrzPPFmb92a8b2D3qHezb1KVIYWoYlR+TbrJPjjVgmWjIhNdC
	 WD1yv5xOm+nrx89C1oJwcNsMq/FRkPY1pYOJVxCzqHmuHnw/jbMA9TprcDmBerOSVv
	 LSOWaIqZ8XYTEa2Z4FwS9WK5vTqyB60uTb9g2iLh6amz2pFBeXxXp1iOv+g3nfvCZf
	 hYx4subZTb21lxkpUDBA90tisnSTlxneg9LYsNOG5nokrdlthQ/lIKFSczBuP/exwt
	 n96d8FBTjUaGw==
Date: Tue, 8 Jul 2025 12:59:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: fix OF node leak
Message-ID: <20250708095908.GE592765@unreal>
References: <20250708084654.15145-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708084654.15145-1-johan@kernel.org>

On Tue, Jul 08, 2025 at 10:46:54AM +0200, Johan Hovold wrote:
> Make sure to drop the OF node reference taken when creating an auxiliary
> device using auxiliary_device_create() when the device is later
> released.

I'm probably missing something, but random grep for the
device_set_of_node_from_dev() callers shows that none of them are
calling to of_node_put() explicitly.

Thanks

> 
> Fixes: eaa0d30216c1 ("driver core: auxiliary bus: add device creation helpers")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/auxiliary.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index dba7c8e13a53..6bdefebf3609 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -399,6 +399,7 @@ static void auxiliary_device_release(struct device *dev)
>  {
>  	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
>  
> +	of_node_put(dev->of_node);
>  	kfree(auxdev);
>  }
>  
> @@ -435,6 +436,7 @@ struct auxiliary_device *auxiliary_device_create(struct device *dev,
>  
>  	ret = auxiliary_device_init(auxdev);
>  	if (ret) {
> +		of_node_put(auxdev->dev.of_node);
>  		kfree(auxdev);
>  		return NULL;
>  	}
> -- 
> 2.49.0
> 

