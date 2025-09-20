Return-Path: <linux-kernel+bounces-825882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2000B8D09A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5147F46050E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C027B32D;
	Sat, 20 Sep 2025 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/yRDD1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089212749C5;
	Sat, 20 Sep 2025 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399315; cv=none; b=UIHXCKdstJgnPjJRnAsUF6VIRMNdEgg8YlLcjsrloO6WkNCuBnDpg9Cda3WpZjJkAykJGx02tRR9QVr1DLaKYp3G5v9CqLcHThxwwb2F5bVNijw7myTSYr7B0uxiIoWewzoCAS+PnsGE8nBuQpEVYvMvg3Y/av8bIo+zD0QZmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399315; c=relaxed/simple;
	bh=p8GWNyTiPrRLq10UZXoXZeVU2CEg3/1/BhEweD1IdjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELvpT5utfGgU40xM+18d2nbHK7EgvDOks8Z4zyUMHLZ+yHYbu6g9dKcAx2c1xiXiZ6gicMtwdmh2VENK9HcBEFCeNyS92zN4TdJ0vsanetgn15FNO1ABx2E6Yfw5pT8ZVHMTr3AJsgLZGi8U3r5AbPnfBIJ5r8WhwEMNKInEUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/yRDD1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05288C4CEEB;
	Sat, 20 Sep 2025 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758399314;
	bh=p8GWNyTiPrRLq10UZXoXZeVU2CEg3/1/BhEweD1IdjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b/yRDD1AJFWz/kFXXr19J2/RjE9i4GaD6/nNrDm9kWDUwYvaV46gt3cBGRS3y1N/L
	 la9nK3L0voguX8KDDswI1IZm4S8P8ZUXdFw22R70SEckKv/f4tjG6g2SJvCA574x/o
	 7qQzRMnZhSRFISwwo1ngtfTlHgfrhXjye15N7rxssbHKzyrr9UzlniwV4Illf0KpFZ
	 STby39zuqWkgT88MuB0GiY2BbG/6e6Pbw06W1WS/xQ0+WrOiU4Or9SDoV9CJia+2RF
	 WOkhgVA/XSNUdxGc6wPkP0vFjeTwxbzfFTLAbLnMwqB/mTZwHInVJcrq2FlB6Zqbw0
	 HTXORrtf5Yw/g==
Message-ID: <fcd107c9-ff59-464f-aead-7b2bcc05dce9@kernel.org>
Date: Sat, 20 Sep 2025 22:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-lis3lv02d: Add Latitude E6530
To: Nickolay Goppen <setotau@mainlining.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917-dell-lis3lv02d-latitude-e6530-v1-1-8a6dec4e51e9@mainlining.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250917-dell-lis3lv02d-latitude-e6530-v1-1-8a6dec4e51e9@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 17-Sep-25 9:10 PM, Nickolay Goppen wrote:
> Add 0x29 as the accelerometer address for the Dell Latitude E6530 to
> lis3lv02d_devices[].
> 
> The address was verified as below:
> 
>     $ cd /sys/bus/pci/drivers/i801_smbus/0000:00:1f.3
>     $ ls -d i2c-*
>     i2c-20
>     $ sudo modprobe i2c-dev
>     $ sudo i2cdetect 20
>     WARNING! This program can confuse your I2C bus, cause data loss and worse!
>     I will probe file /dev/i2c-20.
>     I will probe address range 0x08-0x77.
>     Continue? [Y/n] Y
>          0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>     00:                         08 -- -- -- -- -- -- --
>     10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>     20: -- -- -- -- -- -- -- -- -- UU -- 2b -- -- -- --
>     30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>     40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
>     50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
>     60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
>     70: -- -- -- -- -- -- -- --
>     $ cat /proc/cmdline
>     BOOT_IMAGE=/vmlinuz-linux-cachyos-bore root=UUID=<redacted> rw loglevel=3 quiet dell_lis3lv02d.probe_i2c_addr=1
>     $ sudo dmesg
>     [    0.000000] Linux version 6.16.6-2-cachyos-bore (linux-cachyos-bore@cachyos) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Thu, 11 Sep 2025 16:01:12 +0000
>     […]
>     [    0.000000] DMI: Dell Inc. Latitude E6530/07Y85M, BIOS A22 11/30/2018
>     […]
>     [    5.166442] i2c i2c-20: Probing for lis3lv02d on address 0x29
>     [    5.167854] i2c i2c-20: Detected lis3lv02d on address 0x29, please report this upstream to platform-driver-x86@vger.kernel.org so that a quirk can be added
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


> ---
> Add 0x29 as the accelerometer address for the Dell Latitude E6530 to
> lis3lv02d_devices[].
> ---
>  drivers/platform/x86/dell/dell-lis3lv02d.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-lis3lv02d.c b/drivers/platform/x86/dell/dell-lis3lv02d.c
> index 732de5f556f83b4f91fbf174986331c02c2a5c79..77905a9ddde9dd5d44a3193d053fb3d4e319ceb8 100644
> --- a/drivers/platform/x86/dell/dell-lis3lv02d.c
> +++ b/drivers/platform/x86/dell/dell-lis3lv02d.c
> @@ -48,6 +48,7 @@ static const struct dmi_system_id lis3lv02d_devices[] __initconst = {
>  	DELL_LIS3LV02D_DMI_ENTRY("Latitude 5500",      0x29),
>  	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6330",     0x29),
>  	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6430",     0x29),
> +	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6530",     0x29),
>  	DELL_LIS3LV02D_DMI_ENTRY("Precision 3540",     0x29),
>  	DELL_LIS3LV02D_DMI_ENTRY("Precision 3551",     0x29),
>  	DELL_LIS3LV02D_DMI_ENTRY("Precision M6800",    0x29),
> 
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250917-dell-lis3lv02d-latitude-e6530-7c389cca4893
> 
> Best regards,


