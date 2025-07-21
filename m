Return-Path: <linux-kernel+bounces-739114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087FFB0C204
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7443B2AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168C293C6A;
	Mon, 21 Jul 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ3EYNJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397B293C62
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095423; cv=none; b=DrrtVdLrscG46pa/OQ1qQjlId8Xwo1/vw/sFcspd+RB4JE7MKf2heKXReIW9OnLUpl6khBnooq9BC4SoZIkCjPyga0zkyE1koVpz8ZyYSH/W5GHkODXPKTe+Maz1mg98YUXKKAUGC4qbIJ4rqAFg8uORETVaAF/Vrr5sOcaU15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095423; c=relaxed/simple;
	bh=G4P6/2JTGrggH0efUzuDB2Z/ZXbJ0SjII+o3EJPGz2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+eFEZ08B6fuNpMg7qrNu7/15SGeCPGR0hDypHOqjYkOx4fCyGdEKTF8alt34frptlEFYYxgfP5Cct8jnMFGKuoTpV/gSrwAwDBJmfhlaH7522NaUgMjVEUCgzwF07qk9Ds5nRdqkSFrKVjieqmCEjdHMIOTwexPLf3ZWFLtBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ3EYNJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F39CC4CEED;
	Mon, 21 Jul 2025 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753095422;
	bh=G4P6/2JTGrggH0efUzuDB2Z/ZXbJ0SjII+o3EJPGz2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ3EYNJnCZsdoKuUkT8rs31DLTwT/e6QucWVHW/x4X+RyHAEW0wl++6/dbugAqXdJ
	 QFD8+wE5KYraHyjzq3HmYqD7sPfzooBmkfY0ViB3a5H4wIiJEU3R2mxOFOuIO5jNBO
	 zv/sYKkHSg9/lkngYDcsMdXXxH2iIsf9/o0P2xVPjOlEfvzcTthnjzX6ochIw8RLIO
	 xim3moRP8OZiWMpfuMR/dILib1YoQWJS8nT1dVEg88mp2V76p4gpT+JO6iH0B3OXYB
	 tVYoj9XUSZ19aIfr6q4ctqUWOhWdoGFm5sbfmZsic5AA35NTirp5uFfsTJhYY7aNR9
	 /bUj5GkI9GOTQ==
Date: Mon, 21 Jul 2025 16:26:57 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] drivers: tee: improve sysfs interface by using
 sysfs_emit()
Message-ID: <aH4c-bAN28Gmq86k@sumit-X1>
References: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in>

On Fri, Jul 18, 2025 at 09:00:13PM +0530, Akhilesh Patil wrote:
> Replace scnprintf() with sysfs_emit() while formatting buffer that is
> passed to userspace as per the recommendation in
> Documentation/filesystems/sysfs.rst. sysfs _show() callbacks should use
> sysfs_emit() or sysfs_emit_at() while returning values to the userspace.
> This change does not impact functionality, but aligns with sysfs
> interface usage guidelines for the tee driver.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/tee/optee/core.c | 2 +-
>  drivers/tee/tee_core.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Nice catch.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index c75fddc83576..ce44e3498d37 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device *dev,
>  	else
>  		s = "user";
>  
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", s);
> +	return sysfs_emit(buf, "%s\n", s);
>  }
>  static DEVICE_ATTR_RO(rpmb_routing_model);
>  
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index acc7998758ad..944f913f8592 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -977,7 +977,7 @@ static ssize_t implementation_id_show(struct device *dev,
>  	struct tee_ioctl_version_data vers;
>  
>  	teedev->desc->ops->get_version(teedev, &vers);
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", vers.impl_id);
> +	return sysfs_emit(buf, "%d\n", vers.impl_id);
>  }
>  static DEVICE_ATTR_RO(implementation_id);
>  
> -- 
> 2.34.1
> 

