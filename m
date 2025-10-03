Return-Path: <linux-kernel+bounces-841664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED47BB7F18
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D23994EEBEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3F2DF121;
	Fri,  3 Oct 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEQ4i5ks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E91F19A;
	Fri,  3 Oct 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517913; cv=none; b=NsnAgjjDBnKTBdxvOKuaIRWTKWTpEe9LvvxiVXDbS/oRBeDLDyq932eH7OMP0/KMffxmIxuSd5nfVETBE7EaW6p8ltYkDSR/S1yENnQ0D8FjoOQ+3FSaZEDUwbxo+wyJ4zj3HjXE5EjkDAlvHB7wbU0bpE/L+r4sXoC5EtpPRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517913; c=relaxed/simple;
	bh=7qUTv0t5UIC3+YdH/RFFOjztbT8RfgDPSrUUUEF1VqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAGgKSn4FdR+WYWRBeGHfn0V7khwH7FwhVLtDXMeOkm67DA8P97A64BbHr6Q0J80FvQ7jBNRcNGAZd6kkz/s1ZgdUYuWyYYFZRUrzD6OV0hThGBHmszpHkDWhGmtLzzbMC9+F+ukDfmyL/wM6mxRAOXYpHChA+taxqOoX6vv74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEQ4i5ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9308C4CEF5;
	Fri,  3 Oct 2025 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759517913;
	bh=7qUTv0t5UIC3+YdH/RFFOjztbT8RfgDPSrUUUEF1VqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qEQ4i5ksG9s1JpqvmYPWQ4ubE1zu5X0aE2lCfPd3+KI0UK1pniJrasatL8y4u8fsH
	 3mgNJa5iggmQSK1ThA2XgZ21So8medLnD0gvKNIlyJhJUPQGeRPi3wWqahmAtcGmlq
	 eDS38JHjMnwXlibTkYMKEosjgkXiMRKwVDLZQa9utlPzTDBp7dHsBZRodb+wDruKIX
	 9CGMDjS0k//mQgmVSxJa+8VlK/D485WqPRU4DN7GMes4zTnsvljl0A5TBxOWqG7of9
	 M8FLE3USpoQoDCzjQ9vDLXPdZIoS4F/Czc01xg0JJRHgQxcjrtUtB2c90S0BH0SC2R
	 Np8lk1NGrvySg==
Message-ID: <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org>
Date: Fri, 3 Oct 2025 20:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>
References: <20251003184949.1083030-1-benato.denis96@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251003184949.1083030-1-benato.denis96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Oct-25 8:49 PM, Denis Benato wrote:
> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
> DRIVERS" as suggested by Hans de Goede and Armin Wolf.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Link: https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 156fa8eefa69..81bcb934748d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3841,6 +3841,7 @@ F:	drivers/hwmon/asus-ec-sensors.c
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  M:	Luke D. Jones <luke@ljones.dev>
> +M:	Denis Benato <benato.denis96@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  W:	https://asus-linux.org/


