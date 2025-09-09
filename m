Return-Path: <linux-kernel+bounces-807596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579DB4A6BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388F64E7AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B627C162;
	Tue,  9 Sep 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mkz7ypUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93562741C9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408830; cv=none; b=N3MTPe2LvJW8LB0ch0RZgZr34+eCBKboECmiguq79CUKP+x3oCepUuIRHrCgc/nkjCiqpWc0RvVM+LnBgAyyrfZStQWMjZObNAhbMMKZ7S4VKPzw6fkb1UvKUIFWqBiTpm8UqARS3Twx8ExQkavpVYYfJbpTdEyOcJYapUsY4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408830; c=relaxed/simple;
	bh=icrN9E+vBn4oRMKzaj67R3vlSkBnEses3y8/4BjFba4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/2gWHzUAWQCT+CRb7d9XFYIMCU8NUiQQeMcRFlUqiC+wWd1E2YBJXEu5O4+kpCzku2SdkLyHjT50cZPImJYg3VUM0NYByRDaD80Aif/3Xe1+LEiD/okWn9fwSLznsnuVDaOBioqXsejwhXVmQW3Oe77W8AVVYWF8jmoK0LXU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mkz7ypUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1A2C4CEF7;
	Tue,  9 Sep 2025 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757408830;
	bh=icrN9E+vBn4oRMKzaj67R3vlSkBnEses3y8/4BjFba4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkz7ypUVro0EyIWY9BGVqTHC9Jcx+G7tsLySw+PEGuDIrVdi/zkaQ0VlqI64R916n
	 Zv+LjTlz/W0GPM1UzYT2vLvTqO+Pn2m2PJmgRLBeNwEFt5Iiox96PTUTN3fSnQgKr6
	 AH0eNKAEEJSQE0c0bbfUuR8iQ/Keo16RliG281Ts=
Date: Tue, 9 Sep 2025 11:07:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: Make the code for allocating minor in
 misc_register more concise
Message-ID: <2025090910-tactile-devourer-1070@gregkh>
References: <20250909085835.2784-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909085835.2784-1-zhangjiao2@cmss.chinamobile.com>

On Tue, Sep 09, 2025 at 04:58:35PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no need to check the registered misc dev in misc_list. 
> If misc_minor_alloc failed, it meens the minor is already alloced 
> and the misc dev is linked in misc_list.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/char/misc.c | 32 +++++++-------------------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index a0aae0fc7926..fc2f5e8b2f95 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -211,6 +211,7 @@ int misc_register(struct miscdevice *misc)
>  	dev_t dev;
>  	int err = 0;
>  	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
> +	int minor = 0;
>  
>  	if (misc->minor > MISC_DYNAMIC_MINOR) {
>  		pr_err("Invalid fixed minor %d for miscdevice '%s'\n",
> @@ -221,32 +222,13 @@ int misc_register(struct miscdevice *misc)
>  	INIT_LIST_HEAD(&misc->list);
>  
>  	mutex_lock(&misc_mtx);
> -
> -	if (is_dynamic) {
> -		int i = misc_minor_alloc(misc->minor);
> -
> -		if (i < 0) {
> -			err = -EBUSY;
> -			goto out;
> -		}
> -		misc->minor = i;
> -	} else {
> -		struct miscdevice *c;
> -		int i;
> -
> -		list_for_each_entry(c, &misc_list, list) {
> -			if (c->minor == misc->minor) {
> -				err = -EBUSY;
> -				goto out;
> -			}
> -		}
> -
> -		i = misc_minor_alloc(misc->minor);
> -		if (i < 0) {
> -			err = -EBUSY;
> -			goto out;
> -		}
> +	minor = misc_minor_alloc(misc->minor);
> +	if (minor < 0) {
> +		err = -EBUSY;
> +		goto out;
>  	}
> +	if (is_dynamic)
> +		misc->minor = minor;
>  
>  	dev = MKDEV(MISC_MAJOR, misc->minor);
>  

Does this pass the new test suite for the misc code allocation logic
that we now have in the tree?  Or do we need to write a new test-case
for this codepath?

thanks,

greg k-h

