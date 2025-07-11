Return-Path: <linux-kernel+bounces-727049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E640B01463
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BE31899548
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D715221734;
	Fri, 11 Jul 2025 07:18:40 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A51E833C;
	Fri, 11 Jul 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218320; cv=none; b=Lp+P3C4oqMhjqO9HYFD2IenXF+qqg42U65/vU8RyGwkebDARANf5AkxBRBEFdNnwZH5uqZM45QV0xEOl/cLKumsfXGh8ZabZYGPXfcWsKJ7H5holEzAuB5zQbJiQErikNycXrd4OP2O4fPiSsI5LVObLa/2T00msWpAoUFsGswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218320; c=relaxed/simple;
	bh=BLnNaiDazGnT0Faq76fYjHlwJwtfYmvHHgph24oHKuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0v+io8knuEutXFaquuJ8F2iQIL65ARPzUqQKLAZyi+xFVXp3XokvM8JEsZ/3alvbvQ/0VnL+y4TQQGwuA34hxDD+e/oBLQ4kKayQJ1DHE5rQP/3bL9cKGvNa4g1sVCQuI8XCbDMxkkF+LNdxSIYfP/Iy5RLrnJV2RNklH5C+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.196] (p5b13ad99.dip0.t-ipconnect.de [91.19.173.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 487346028825F;
	Fri, 11 Jul 2025 09:18:22 +0200 (CEST)
Message-ID: <f2e0909b-0dc2-448c-bbc9-d7dfa351412c@molgen.mpg.de>
Date: Fri, 11 Jul 2025 09:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-lis3lv02d: Add Precision 3551
To: Jan-Niklas Burfeind <kernel@aiyionpri.me>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>
References: <20250710190919.37842-1-kernel@aiyionpri.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250710190919.37842-1-kernel@aiyionpri.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jan-Niklas,


Thank you for your patch.

Am 10.07.25 um 21:09 schrieb Jan-Niklas Burfeind:
> This marks 0x29 as accelerometer address on Dell Precision 3551.
> 
> I followed previous works of Paul Menzel and Hans de Goede to verify it:
> 
> $ cd /sys/bus/pci/drivers/i801_smbus/0000\:00\:1f.4
> 
> $ ls -d i2c-?
> i2c-0
> 
> $ sudo modprobe i2c-dev
> 
> $ sudo i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x08-0x77.
> Continue? [Y/n] Y
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                         08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- 29 -- -- -- -- -- --
> 30: 30 -- -- -- -- 35 UU UU -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: UU -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> $ echo lis3lv02d 0x29 > sudo tee /sys/bus/i2c/devices/i2c-0/new_device
> lis3lv02d 0x29
> 
> $ sudo dmesg
> [    0.000000] Linux version 6.12.28 (nixbld@localhost) (gcc (GCC) 14.2.1 20250322, GNU ld (GNU Binutils) 2.44) #1-NixOS SMP PREEMPT_DYNAMIC Fri May  9 07:50:53 UTC 2025
> [...]
> [    0.000000] DMI: Dell Inc. Precision 3551/07YHW8, BIOS 1.18.0 10/03/2022
> [...]
> [ 3749.077624] lis3lv02d_i2c 0-0029: supply Vdd not found, using dummy regulator
> [ 3749.077732] lis3lv02d_i2c 0-0029: supply Vdd_IO not found, using dummy regulator
> [ 3749.098674] lis3lv02d: 8 bits 3DC sensor found
> [ 3749.182480] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input28
> [ 3749.182899] i2c i2c-0: new_device: Instantiated device lis3lv02d at 0x29
> 
> Signed-off-by: Jan-Niklas Burfeind <kernel@aiyionpri.me>
> ---
>   drivers/platform/x86/dell/dell-lis3lv02d.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-lis3lv02d.c b/drivers/platform/x86/dell/dell-lis3lv02d.c
> index 0791118dd6b7..732de5f556f8 100644
> --- a/drivers/platform/x86/dell/dell-lis3lv02d.c
> +++ b/drivers/platform/x86/dell/dell-lis3lv02d.c
> @@ -49,6 +49,7 @@ static const struct dmi_system_id lis3lv02d_devices[] __initconst = {
>   	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6330",     0x29),
>   	DELL_LIS3LV02D_DMI_ENTRY("Latitude E6430",     0x29),
>   	DELL_LIS3LV02D_DMI_ENTRY("Precision 3540",     0x29),
> +	DELL_LIS3LV02D_DMI_ENTRY("Precision 3551",     0x29),
>   	DELL_LIS3LV02D_DMI_ENTRY("Precision M6800",    0x29),
>   	DELL_LIS3LV02D_DMI_ENTRY("Vostro V131",        0x1d),
>   	DELL_LIS3LV02D_DMI_ENTRY("Vostro 5568",        0x29),

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: Just a heads-up, that you have a DMARC policy set:

     $ dig txt _dmarc.aiyionpri.me +short
     "v=DMARC1;p=reject;"

I believe STRATO enabled this for all their customers, breaking 
deliveries for addressees enforcing the DMARC policy, as you do not have 
any SPF entries for example [1]. I recommend to deactivate the setting 
by selecting *Keine STRATO-DMARC-Regel* [2], and to look for another 
provider, as their support was not helpful at all and did not even 
understand the problem, and hasn’t replied to my latest response in 
several weeks. (And I didn’t get the initial emails informing about the 
change.)


[1]: 
https://www.borncity.com/blog/2025/06/06/strato-aktiviert-automatisch-eine-dmarc-pruefung-fuer-mails/
[2]: https://www.strato.de/faq/hosting/dmarc-bei-strato-aktivieren/

