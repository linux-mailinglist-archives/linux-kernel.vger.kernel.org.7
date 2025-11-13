Return-Path: <linux-kernel+bounces-899401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6CBC579E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28E13345E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7D351FAB;
	Thu, 13 Nov 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPpjVZ3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F332FF14F;
	Thu, 13 Nov 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040009; cv=none; b=Wn/sXbuwn/wXrcopCtmzkp6qrzkFiorLb9Anz2PcoyDmjp1hJq3NFUELenGfKpJhgXUfONAU0QA/t8KFUc6tU83rYfcvtj25AKH/Cq0l0hpa7ZCbXN3Lsxbg2F99qP7voCxcvjRl7NbiGKuIYn2YLyzqQldsR89R8y/XzIAm94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040009; c=relaxed/simple;
	bh=ekjGudGOri5L0SYWYsS/gxUuyFFk1MVNHVKXjFcCVeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwxEyJ4ewbNhlqFwyIoetfjAKvPyfskVxcVgU1JzyA0R7RPsrzl/75gnaoUXcVgfegckPiZLlKEDchgGEnjAsJr72vdAG5ldxdbAmc1Ys4m+miydDgCO+/ypw/iV467mVtsfApvj/ZJt9YY9nEjkUznCIxCcLStP3mZ2f7DNmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPpjVZ3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351FAC4CEFB;
	Thu, 13 Nov 2025 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763040009;
	bh=ekjGudGOri5L0SYWYsS/gxUuyFFk1MVNHVKXjFcCVeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPpjVZ3kFE4ilb4q6XM7C6ygRZnFpk9yWF0MwqG34xkFybxa5G0+3b9S/6Md+jcCC
	 QVCorVSCoVJHKcofJJYjZKgh7aSpt0BEeZlnr4WFS5pvVfOw2LjNftEI0qaZvTiId7
	 Mt1zMSehkiDL1kZBn7yH+s1v6e5u51+S/U5Mbrv8=
Date: Thu, 13 Nov 2025 08:20:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chang Junzheng <guagua210311@qq.com>
Cc: outreachy@lists.linux.dev, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chang Junzheng <guagua210311@outlook.com>
Subject: Re: [PATCH] staging: greybus: audio_manager_module: make envp array
 static const
Message-ID: <2025111341-attendee-ferment-262b@gregkh>
References: <tencent_7710B04B6BEE52903BA2F56376DB9D18A907@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7710B04B6BEE52903BA2F56376DB9D18A907@qq.com>

On Thu, Nov 13, 2025 at 09:01:46PM +0800, Chang Junzheng wrote:
> From: Chang Junzheng <guagua210311@outlook.com>
> 
> The envp array in send_add_uevent() function is declared as a non-const
> local array, which triggers the following checkpatch.pl warning:
> 
> WARNING: char * array declaration might be better as static const
> 
> Change the declaration to 'static const char * const' to improve code
> safety by making the array read-only and allow for better compiler
> optimization. This follows the kernel coding style recommendations.
> 
> Signed-off-by: Chang Junzheng <guagua210311@qq.com>

You sent this twice?

> ---
>  drivers/staging/greybus/audio_manager_module.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
> index 4a4dfb42f50f..ca6a2cd0bc4f 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -159,14 +159,14 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
>  	char ip_devices_string[64];
>  	char op_devices_string[64];
>  
> -	char *envp[] = {
> -		name_string,
> -		vid_string,
> -		pid_string,
> -		intf_id_string,
> -		ip_devices_string,
> -		op_devices_string,
> -		NULL
> +	static const char * const envp[] = {
> +						name_string,
> +						vid_string,
> +						pid_string,
> +						intf_id_string,
> +						ip_devices_string,
> +						op_devices_string,
> +						NULL

Why did you indent this?

thanks,

greg k-h

