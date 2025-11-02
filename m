Return-Path: <linux-kernel+bounces-881773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D736CC28E46
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 840B3346A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A102D8DD0;
	Sun,  2 Nov 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6WyvpWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B04253B52;
	Sun,  2 Nov 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083671; cv=none; b=EyZTNjl5s9BSWcdaO/XNtFTfIIT7GG7uDDbo3lrZYO2XVCk0loakELsmwCmG5m4yJTbOsXMjoARl8B2Ap9JFFRZfFM2PLPNNK6nVJeOrn3iu94f3TWbel5wp1A89MIhVpA6Hm571HPrsxmVYToBWXQFnlaFboKsgOeM8D8a2g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083671; c=relaxed/simple;
	bh=7Y2IuLJRtMT2L8zTsIwTSwa32kNtXQ3ENuF6e8GwQZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp710mpZVG72Mz0ORGjigW2tNAJ00Caxrpo77xOy79wAeplN3oC94qQ/I8ONfNYFkD7YlPAkxaB5blFqJuNWTbWdsorv8z/LyGvLHq3jT5WNUzyedIxYslPb5IifOnGN+pw2rYU2cvJCQlGc4quk4G6ltNM1LLT3YokGR6/sZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6WyvpWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE25FC4CEF7;
	Sun,  2 Nov 2025 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762083671;
	bh=7Y2IuLJRtMT2L8zTsIwTSwa32kNtXQ3ENuF6e8GwQZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6WyvpWBHni/fc57swCngaZNw6qvSPIqnov9TOBpnA763IgVvEf+Jt+W1VppmdCQt
	 Srlf+6sOH0U1BlNqDCfQVHTxPtpV38b3gy46roqE10DN/9dBvClq8OUAXw5cxSeeJs
	 /lHTyx4CH4SRs7l61YjfbDcDbkxCFlvGlxC3gvds=
Date: Sun, 2 Nov 2025 20:41:08 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: zntsproj <vacacax16@gmail.com>
Cc: johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: Re: [PATCH v4] Fix tiny typo in firmware-management docs
Message-ID: <2025110254-identical-tactful-a48a@gregkh>
References: <20251102113938.3116-1-vseokaktusah7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102113938.3116-1-vseokaktusah7@gmail.com>

On Sun, Nov 02, 2025 at 02:39:38PM +0300, zntsproj wrote:
> Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
> ---
>  .../staging/greybus/Documentation/firmware/firmware-management  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/Documentation/firmware/firmware-management b/drivers/staging/greybus/Documentation/firmware/firmware-management
> index 7918257e5..393455557 100644
> --- a/drivers/staging/greybus/Documentation/firmware/firmware-management
> +++ b/drivers/staging/greybus/Documentation/firmware/firmware-management
> @@ -193,7 +193,7 @@ Identifying the Character Device
>  
>  There can be multiple devices present in /dev/ directory with name
>  gb-authenticate-N and user first needs to identify the character device used for
> -authentication a of particular interface.
> +authentication of a particular interface.
>  
>  The Authentication core creates a device of class 'gb_authenticate', which shall
>  be used by the user to identify the right character device for it. The class
> -- 
> 2.51.2
> 
> 

Why did you ignore my bot's recommendations?

