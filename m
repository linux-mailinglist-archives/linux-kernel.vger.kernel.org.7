Return-Path: <linux-kernel+bounces-842037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A4BB8D36
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 14:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106824E46B8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A72737E4;
	Sat,  4 Oct 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIT0QsS8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F220B7EE;
	Sat,  4 Oct 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759580947; cv=none; b=F93d6pGCBLPCOYZny4YGPpXMpm8Xdp27G16jgFcxsIxUwM6MVWomb7M420sNRI6dp9JhOC7y+N20Dtn4vAK5GJpjyuzUlPwIYCjCAeyXNnoSnBuQ8p+3AfZmi8vVSPU32e29yQXLd/cQJXf4JZUAXobGRCfDpRZkZGIb9Q/sDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759580947; c=relaxed/simple;
	bh=9Uqa4igeOXRbdC7N4zAS26I7Y+Q/wNuxNUGVmWyzUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suI2t1RqMjUzoHu9wy00hxAntVE4ydT7E4AlnsAmJT8YRgMkQBa+1YYQcALH+cirFlPXDZhyLK+uIvxF1Mk6kGwfS5aMkmAwkl5yN/E4TpIfiOHL/QA8DTTWndHtmCLcblJ9tO2w8QFZ0rduIk8flaEun9DoRixkzqOUNhzcEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIT0QsS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DF1C4CEF1;
	Sat,  4 Oct 2025 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759580946;
	bh=9Uqa4igeOXRbdC7N4zAS26I7Y+Q/wNuxNUGVmWyzUog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIT0QsS8AI1KnvbRzmlwubSwAl6HVxbQHkhgw6BKT0s+5yrfP+jg/+q1bDY6+2zLC
	 mBziejwTvyNcqOVgeIYugczSClL8f5chu8rWBx58GjBuvIYPNdhBWtpnsYl7hliD7w
	 4SSS4SkM3oe+LXmIH2OHiFRsOaF8v8hi9GLDvyNeB1mKlHJPSIuYtJ0XobS1Cdv8c3
	 PTOOwUcWgvEQuFCICXLJv0CIxb8MY2mTyrrI7vsPULYqmOoGrlVmR/ldcOtbLF5I9r
	 dwtY+sq9E2UZYWAILuzfKCYitBNDYhcnpbIQ+IlWQem+XfFBCIqTNpsi8/4D6ugOXg
	 Ib5MNRJaML73g==
Date: Sat, 4 Oct 2025 15:29:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shahriyar Jalayeri <shahriyar@posteo.de>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
Message-ID: <aOETD4GrSrQGkIAx@kernel.org>
References: <20251003092544.12118-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003092544.12118-1-shahriyar@posteo.de>

On Fri, Oct 03, 2025 at 09:25:47AM +0000, Shahriyar Jalayeri wrote:
> Ensure tpm_inf_recv() does not overflow the provided buffer when
> the TPM reports more data than the caller expects.
> 
> Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>

missing:

Fixes: ebb81fdb3dd0 ("[PATCH] tpm: Support for Infineon TPM")

> ---
>  drivers/char/tpm/tpm_infineon.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b8..eb6dd55ff 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -250,6 +250,12 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  	number_of_wtx = 0;
>  
>  recv_begin:
> +	if (count < 4) {
> +		dev_err(&chip->dev,
> +			"count less than the header size!\n");
> +		return -EIO;
> +	}

Please remove dev_err() 

> +
>  	/* start receiving header */
>  	for (i = 0; i < 4; i++) {
>  		ret = wait(chip, STAT_RDA);
> @@ -268,6 +274,12 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>  		/* size of the data received */
>  		size = ((buf[2] << 8) | buf[3]);
>  
> +		if (size > count) {
> +			dev_err(&chip->dev,
> +				"Buffer too small for incoming data!\n");
> +			return -EIO;
> +		}


Ditto
>
>  		for (i = 0; i < size; i++) {
>  			wait(chip, STAT_RDA);
>  			buf[i] = tpm_data_in(RDFIFO);
> -- 
> 2.43.0

BR, Jarkko

