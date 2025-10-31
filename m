Return-Path: <linux-kernel+bounces-880238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4EBC252B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C33A46317A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197A34B1BD;
	Fri, 31 Oct 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuWmANOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E932548D;
	Fri, 31 Oct 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915928; cv=none; b=rFVtl+rSy0FbJhcyNQjva9pLuIPmyY+HlT5N7zrvdkNVgHAdJ0cRWovmMEY9Dy9eyaFGgZi1VDqOoFyawcIaFC4l+KYeSy/SOnU6/+Lw+OFk3DXJKr1+qamzHlYzJtu8YLNpj5mk2tzVph0w01FdEvlMzd2Me2yPkdMQ8kQ3958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915928; c=relaxed/simple;
	bh=d2k8BDYCwAf8v+dGV9tcaTrmfQ4UjRPuay0/M32F87w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3SgSQhyW/X2fJwq0Uuw4tquaME6y8SbnRxdea5LfFgoT5g6ftQvEP7liyIK7Z8+q0P2wyoLA27GZCLmdMNwq+BrqM3kS8zTKOkrkXSjsZ1UIzKBs9SLD/0tbPL5qy7mnVXS6akzcd+kyEcQOj4ygtIbE3gPED1dehO0KDeXZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuWmANOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5338C4CEE7;
	Fri, 31 Oct 2025 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761915927;
	bh=d2k8BDYCwAf8v+dGV9tcaTrmfQ4UjRPuay0/M32F87w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OuWmANOxQyavr2OndYJ4s3kbVDHfKfszLhmIgVZKhHzwjBDqzGTubQ2YBAqu1rGxT
	 urxkoJBdqH1PYxSlKvzMPdcgEtBKR5biV0TAQIWLQKobGNrpYa/Dv1F14VthpK/dlJ
	 eObnmE2o8jK0A6/AHnHwrLoI1CzA1Qo1NnO4e2Vu43c0wNGKDUK5wmEDalNoWlv94l
	 mhcbnmHRPH44Us/d4K2hu6TErPnmo17QZLj2rzxcpcgPL4GTRlPSJOPq7kT9LO4GiP
	 CnzKCaxWN71vt8Z6SZtqm8kkeV0N72WKRzfjCih97B2qpiYqvZTsgLeSIncB+GsXFA
	 ZVa5oSOiGoo5w==
Message-ID: <a10c7757-567d-4312-b72d-159ab0c41ece@kernel.org>
Date: Fri, 31 Oct 2025 08:05:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] platform/x86/amd/pmc: Add support for Van Gogh SoC
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-2-lkml@antheas.dev>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251024152152.3981721-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> The ROG Xbox Ally (non-X) SoC features a similar architecture to the
> Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
> this support was dropped by the Xbox Ally which only S0ix suspend.
> 
> Since the handler is missing here, this causes the device to not suspend
> and the AMD GPU driver to crash while trying to resume afterwards due to
> a power hang.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Having seen that a few things were tried for the idle mask which don't 
work I think this patch makes sense as is.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/platform/x86/amd/pmc/pmc.c | 3 +++
>   drivers/platform/x86/amd/pmc/pmc.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index bd318fd02ccf..cae3fcafd4d7 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
>   	switch (dev->cpu_id) {
>   	case AMD_CPU_ID_PCO:
>   	case AMD_CPU_ID_RN:
> +	case AMD_CPU_ID_VG:
>   	case AMD_CPU_ID_YC:
>   	case AMD_CPU_ID_CB:
>   		dev->num_ips = 12;
> @@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
>   	case AMD_CPU_ID_PCO:
>   		return MSG_OS_HINT_PCO;
>   	case AMD_CPU_ID_RN:
> +	case AMD_CPU_ID_VG:
>   	case AMD_CPU_ID_YC:
>   	case AMD_CPU_ID_CB:
>   	case AMD_CPU_ID_PS:
> @@ -717,6 +719,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
>   	{ }
> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
> index 62f3e51020fd..fe3f53eb5955 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.h
> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> @@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
>   #define AMD_CPU_ID_RN			0x1630
>   #define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
>   #define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
> +#define AMD_CPU_ID_VG			0x1645
>   #define AMD_CPU_ID_YC			0x14B5
>   #define AMD_CPU_ID_CB			0x14D8
>   #define AMD_CPU_ID_PS			0x14E8


