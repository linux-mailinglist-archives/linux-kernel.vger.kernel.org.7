Return-Path: <linux-kernel+bounces-851215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E8BD5CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2CB54ED377
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE72D8383;
	Mon, 13 Oct 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3S0CgIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F152D6E57;
	Mon, 13 Oct 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381582; cv=none; b=kT7LDHVPgZObq0khQ5TqvziQrDUbLtkhvVXSUGzwxFBHTAHs2ioQkECvPWqNjdzR3SSKdV/aX2iLI+XKv0iDo9L5CcqG8PlxgdDp24/fFvyyu8WqnONsS96NK9N3J1F+I9GS4x328FlXwmsC+biLiwNnkef88Scle8b5nz0fBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381582; c=relaxed/simple;
	bh=uZ0T3U4MLfM86jTDHwPqp45qG8oLdFAZ41EusrR5BJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWD7B2rG5SFgiV/kxesJbHFtRY2CspD407XSQ6XVnlNwEvWmOtoLh++ztRxWpxs+ODGLnoRahEhtTPAeroBRkOqJw+IaegLu0FbQYuMMUv7sqLZQRHpM11B/X/gy+mmGOzTKnP7bQByB8/BXTOimzaw7fgbvXPWjdfrLA1fUpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3S0CgIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C7EC4CEE7;
	Mon, 13 Oct 2025 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381581;
	bh=uZ0T3U4MLfM86jTDHwPqp45qG8oLdFAZ41EusrR5BJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y3S0CgIKVGWcXiH5juFyv9Ge9nsVz7JbWGBbYW1rB9gcewjY/avZOQOymvhU24a0D
	 y70E25454byZmxv64aBJ+DGIP5RC2Zdrbl1jhY2lfQJ8E6eF8BnA+RPL8A9pa75EKf
	 OvulAC07cHwC5FB1asm2di0HWkSV6BgMWfgJE0TeSky1UZawLgitzuJfaf5410oC3a
	 mIKIFAA5LNK4o3o2WAWEDT8suJXkl7QOaCb7M09bvWEF4bzTysjWyD30fAM9n2bj1j
	 gwhu9ZACeTtTk6Tf++8wW8fgsZAmZqZb5YZur4M1TBoFmeC1SaQk8MdXcuOm1geozO
	 +hw1Nu+QKukPg==
Message-ID: <49aa0662-ad1e-4d9f-b288-8f193c5241bd@kernel.org>
Date: Mon, 13 Oct 2025 13:53:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/amd: hfi: Remove redundant assignment to
 .owner
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: perry.yuan@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 jserv@ccns.ncku.edu.tw, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251011063837.2318535-1-visitorckw@gmail.com>
 <20251011063837.2318535-3-visitorckw@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251011063837.2318535-3-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/25 1:38 AM, Kuan-Wei Chiu wrote:
> The coccicheck tool reports the following warning for this driver:
> 
> ./hfi.c:509:3-8: No need to set .owner here. The core will do it.
> 
> The manual assignment of .owner = THIS_MODULE; in the platform_driver
> struct is redundant. The platform_driver_register() function, which is
> called to register the driver, is a macro that automatically sets the
> driver's owner to THIS_MODULE.
> 
> The driver core handles this assignment internally, making the explicit
> initialization in the struct definition unnecessary. Remove the
> unnecessary line.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Build test only.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>>
>   drivers/platform/x86/amd/hfi/hfi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 5d5d2cf23a75..83863a5e0fbc 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -505,7 +505,6 @@ static int amd_hfi_probe(struct platform_device *pdev)
>   static struct platform_driver amd_hfi_driver = {
>   	.driver = {
>   		.name = AMD_HFI_DRIVER,
> -		.owner = THIS_MODULE,
>   		.pm = &amd_hfi_pm_ops,
>   		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>   	},


