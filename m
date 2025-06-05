Return-Path: <linux-kernel+bounces-673960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55BACE814
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 03:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9317A461E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 01:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB21BEF7E;
	Thu,  5 Jun 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wwquhIMJ"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442981BC07A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749088718; cv=none; b=Wye4+mJdZ0jPzITDTJU5FhchqQ9pNszHj63T7I78Y4td3DCNbJTKBSptx7BQg4o8wKkUyVW+smvieFFPLzI74PycDXhGvHlhDQn0JAZCRlSCt5oRu8i6y0QJj3yBW3QSHmsPbaPDWUyAE8YrhyNemq7rpX+vU/eFcDut5U6Whkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749088718; c=relaxed/simple;
	bh=HiMqOMogaPO00WEmzbxR2t2alShtYY94hveqXZdKB7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8eJoSQZMxjxwBQq8qVC1HNJ6iVDdu0451QT8ZdsgjHCTfHcgBWm8LcmMc1GqCbn4RCB29vN3+JhQ3YIHDXsIu20qKactQgy4yXzyR8I0014zL8SapsCEf20Opvgm8qhlSotMnFzLyuU1KRnnLSPiEEWIXI+ZqKFFrYYg/o/SHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wwquhIMJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Jun 2025 19:58:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749088711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pGp4RUhvoSSPmBY1Hz2PrPlipkQlVMkrKAc4XT96CM=;
	b=wwquhIMJ7FM57vTLu/RXHpLjlxsxYpGlyC3XNARi+m8ScB9uB1FsFNUxXyNiA1vFVajdv7
	ejoMFixztDMCnVky0yjU0c9/CFesDsirz8N5DSgIKwDPnUQQXRi/WTgf4+HGhEddwEbyNL
	Fm+dxrCbcibtjsCt7MzICQ+EIa32jWM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kamel Bouhara <kamel.bouhara@bootlin.com>, 
	Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
	Danilo Krummrich <dakr@redhat.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/4] firmware_loader: expand firmware error codes with
 skip error
Message-ID: <b5jlh7ngl64aqrm7b2hkpafvfk6rmuyhwshzogxqozpal3owmj@u26s6bpwbax7>
References: <20250529-v6-10-topic-touchscreen-axiom-v2-0-a5edb105a600@pengutronix.de>
 <20250529-v6-10-topic-touchscreen-axiom-v2-1-a5edb105a600@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-v6-10-topic-touchscreen-axiom-v2-1-a5edb105a600@pengutronix.de>
X-Migadu-Flow: FLOW_OUT

On Thu, May 29, 2025 at 12:08:42AM +0200, Marco Felsch wrote:
> Add FW_UPLOAD_ERR_SKIP to allow drivers to inform the firmware_loader
> framework that the update is not required. This can be the case if the
> user provided firmware matches the current running firmware.

The changes below look fine, but the commit message is inconsistent
with the actual changes. The commit message should reference
FW_UPLOAD_ERR_DUPLICATE instead of FW_UPLOAD_ERR_SKIP.

- Russ

> 
> Sync lib/test_firmware.c file accordingly.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/base/firmware_loader/sysfs_upload.c | 1 +
>  include/linux/firmware.h                    | 2 ++
>  lib/test_firmware.c                         | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 829270067d1632f92656859fb9143e3fa9635670..0a583a1b3f4fde563257566426d523fbf839b13f 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] = {
>  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
>  };
>  
>  static const char *fw_upload_progress(struct device *dev,
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index aae1b85ffc10e20e9c3c9b6009d26b83efd8cb24..fe7797be4c08cd62cdad9617b8f70095d5e0af2f 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -29,6 +29,7 @@ struct firmware {
>   * @FW_UPLOAD_ERR_RW_ERROR: read or write to HW failed, see kernel log
>   * @FW_UPLOAD_ERR_WEAROUT: FLASH device is approaching wear-out, wait & retry
>   * @FW_UPLOAD_ERR_FW_INVALID: invalid firmware file
> + * @FW_UPLOAD_ERR_DUPLICATE: firmware is already up to date (duplicate)
>   * @FW_UPLOAD_ERR_MAX: Maximum error code marker
>   */
>  enum fw_upload_err {
> @@ -41,6 +42,7 @@ enum fw_upload_err {
>  	FW_UPLOAD_ERR_RW_ERROR,
>  	FW_UPLOAD_ERR_WEAROUT,
>  	FW_UPLOAD_ERR_FW_INVALID,
> +	FW_UPLOAD_ERR_DUPLICATE,
>  	FW_UPLOAD_ERR_MAX
>  };
>  
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 211222e63328f970228920f5662ee80cc7f51215..603c3a4b385c849944a695849a1894693234b5eb 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1133,6 +1133,7 @@ static const char * const fw_upload_err_str[] = {
>  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
>  };
>  
>  static void upload_err_inject_error(struct test_firmware_upload *tst,
> 
> -- 
> 2.39.5
> 

