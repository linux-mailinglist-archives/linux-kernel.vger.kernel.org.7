Return-Path: <linux-kernel+bounces-844404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269ABC1D45
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0094D4F6A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B82E22AA;
	Tue,  7 Oct 2025 14:57:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E519755B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849074; cv=none; b=UeZrM/fILv7gLQAcuC/jNnR2+ZGOL04JQ9n/LSvPGxrKGX3HyTMzbSlMLRz10njF6dbrJN1Cn3mWFuxJj/M3rY4VH5zu/yZjF7ERpbnGMxcKBK65ree15gK1ShJuBUo2XjDozaZZpgMMru2GVMfkpq5NQrr/gZICCbYOkROh074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849074; c=relaxed/simple;
	bh=o42ml0Q9auTtSXt7nYjujebvEkNgaZ28DIVud1c+eeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4O2oLdn8hzAm1WvN3A7GxkoElUuXEaP9ck75yYL1G1uf5NKbi+/ZvmK6T4uLFLs5tFZ364OxF2kvEemWw4f8yXhY9OfTI7exzwHpHfHkt94hixxxPOMdX+WaLT/NHgSPmprIMQn2F1ujA1Axnmv8M2rDCeeOb501ShO5IyJF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v698P-0006pP-4P; Tue, 07 Oct 2025 16:57:49 +0200
Message-ID: <254c82d5-81d9-4e23-9ed8-29cfc3f3c008@pengutronix.de>
Date: Tue, 7 Oct 2025 16:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] init/main.c: add warning when file specified in rdinit
 is inaccessible
To: Lillian Berry <lillian@star-ark.net>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
 Leonard Goehrs <lgo@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20250707091411.1412681-1-lillian@star-ark.net>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <20250707091411.1412681-1-lillian@star-ark.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Lillian,

On 7/7/25 11:14 AM, Lillian Berry wrote:
> Avoid silently ignoring the initramfs when the file specified in rdinit
> is not usable. This prints an error that clearly explains the issue
> (file was not found, vs initramfs was not found).

I have a system that works just fine without an initramfs, but now the
kernel warns me about it:

[    2.805602] check access for rdinit=/init failed: -2, ignoring

I suppose that's unintended and the code here should actually check that
there is an initrd at all before checking for the rdinit?

Thanks,
Ahmad

> 
> Signed-off-by: Lillian Berry <lillian@star-ark.net>
> ---
>  init/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 225a58279acd..e47984871775 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1592,7 +1592,11 @@ static noinline void __init kernel_init_freeable(void)
>  	 * check if there is an early userspace init.  If yes, let it do all
>  	 * the work
>  	 */
> -	if (init_eaccess(ramdisk_execute_command) != 0) {
> +	int ramdisk_command_access;
> +	ramdisk_command_access = init_eaccess(ramdisk_execute_command);
> +	if (ramdisk_command_access != 0) {
> +		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
> +			ramdisk_execute_command, ramdisk_command_access);
>  		ramdisk_execute_command = NULL;
>  		prepare_namespace();
>  	}

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


