Return-Path: <linux-kernel+bounces-732593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112DB06938
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF6D7A79EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322302C15B8;
	Tue, 15 Jul 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktuGjee7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAC25E834;
	Tue, 15 Jul 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618302; cv=none; b=UZNHFBCGS6uKhwYTe3WP/l1ky8P3uMgmMLJjGHCKuTGaqNH0FmGkYW7z2Rn+n6PHbntROm/cu9jvTGdCkpkGXIxJc4Xm/v8ERdLR6moj885zjIgqq90o9a1l8ybW1hXnWmQDdySLKyshjEndwbACPl13sl6F7Z5iPJFoSSthGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618302; c=relaxed/simple;
	bh=7Mss6DWaeHS4SJgNovhTEdBOiILUCumsbOG0XkgXs0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvDEBm3/F5Fz9y2XL1UAEOW6hUcK1BkAo8Nm1eg3xyT+lz0sUVyuYfq3jhz+dKlfROZgn5cZJ6lfLjKkkGFwXM/OXnmm+wmSWsyzXR+wX0XFuZvK2zhhDZ6cvPdBmMxNvim+7iT+E1JGr7L55/D2XZk54maMAOlJNODGqj3nTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktuGjee7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so10849326a12.2;
        Tue, 15 Jul 2025 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752618299; x=1753223099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5qGMtVB8P85XlMYqskFWHihLLlCdJwWv8lZ05HvJRA=;
        b=ktuGjee7qB/toy9/51XW4oBiW5YXPNUS9BIWu7oIv5lAwHmOiWNeYg9HspoI/XS41G
         nh5wNafiaJVJPcacgcyjtVMyLkfUs3/jN7Xmz/AhwBQD705N9NXD1LJPoB39AUmK/E/g
         IRRCF1JvzeAD7Obe5Cmu78lnDcbxGWe2//LgxmnrwAb/9wWxHROoLJ1m0UsiJXsF+MEi
         KiqQBGOW39KutGY4D0scetY79OmeSqSHGUkab9ibhVI5SnW+2S+rgN4CmEXG0Z/sk6P/
         0BMH7dzzDwjYjT+qViyl1GlDRu+LaWX9uoqU93hZV0vG6exJG2iCQhus4Raphz07HJgU
         J18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752618299; x=1753223099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5qGMtVB8P85XlMYqskFWHihLLlCdJwWv8lZ05HvJRA=;
        b=j0X7PinvcetRPZpnk+n41TRix4AHS9KaAFI+NES0WI7RNaq2qBEHkv1DXR5SX0eW/3
         EZmUXZBwLjdfiHcyI1VYKwrL9LC27n33NSa86w0qChahJpyfBbyz8pWVVdiB3jvvlWgO
         hmpttOS0F8dTWY6y0n9KL7fJvN2JcVhhMkUefOC4+TYvfOupiIrDGgwKjp77W7h3PFne
         dRsCDmGWzOUQnuDZeh1jpZfpqDxN9A80ABI8KoagtuCfRkM1ZJNLbjjUKVOjy2A0wu5h
         75w9Dnkf3Bzwb7yPmXia8epgKd7DwQQSzizrbYhRS6lLTsptP+T7M7chBDUWjTlKM9F5
         RsQA==
X-Forwarded-Encrypted: i=1; AJvYcCVDwhG1UWfha6jOyN5R5toMJzhuWmneDxseGz1bnYTRbVt7eElexCYOAXoKmbLwYbMNXWTRehfVVsWitHo=@vger.kernel.org, AJvYcCWIs3bsgYXb+wEtbG/y9aWs8VKHvZ1u731SehxDyqKqwC+rCfRwre+GD1rHrCvk5gOAHGYobpW4naga2YGyLe6n4kfCwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8K5XMRsJZ9gHRipU8v/k82V4kYsb3ob5bldCg+p7OKURb11st
	BlDvZQPEAIAt8tH8y428yTOfA8jkIwV5qPexDbYxxPwIyyoYFEhTop1IN3kjyg==
X-Gm-Gg: ASbGnctGtdwcOKyQJnlNgOxXm1O/GUM+zpNVcwYno5KYQPROl8Yr3MJIH8F/dVkG1ur
	KCnhFMLON1MgrwSmA82jeJN2ucDA5nMRxFPhHeA1RFviFrtpNYBRsycTL6LM3t40AAVB9eU42sB
	1hPdfkBvOtmdqU81ID0PYZSEMf0l8fJI+/fRZlH3QVGAjtY2R00Y8JTWfkoY9Tu6+msFLdfKlHg
	gCU7tDc1YJ3bb1rvlz8Mg0js/evV2+zzlcDXQFOkdZBnuWulgwrFewxfFIVX7RaGKF3Q/JpySsr
	vcJeaIyP07RCUyUvombSNlN9emzTkTrwN+6auRIKexzBoyXW/UZkVfjrLaGuG7oTFok7tKigsUf
	vkSdKkgrFU0e+rx5Zz3VrDnRuPfIiHlgswj9qzwxXE55ZBmsISzlk+vgs9J1AU9qvAAcqegz4wa
	WkH7pIDhVTaw==
X-Google-Smtp-Source: AGHT+IH0H9zSvxzKLxEHeBYmLm42abpcGN8vi6zvjLG6iKBrFBcjssAApv20szdw2BNtaSv89iRfaQ==
X-Received: by 2002:a05:6402:34cd:b0:60c:421f:1357 with SMTP id 4fb4d7f45d1cf-6128592f82amr313469a12.13.1752618298952;
        Tue, 15 Jul 2025 15:24:58 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95256d0sm7975770a12.24.2025.07.15.15.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:24:58 -0700 (PDT)
Message-ID: <a1a9543f-0707-4f4e-80a7-86164f96fc5a@gmail.com>
Date: Wed, 16 Jul 2025 00:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] platform/surface: aggregator_registry: Add Surface
 Pro 11
To: Dale Whinham <daleyo@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-5-daleyo@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20250714173554.14223-5-daleyo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/25 7:35 PM, Dale Whinham wrote:
> This enables support for the X1E-based Surface Pro 11.
> 
> Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>

Looks good to me. Thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   .../surface/surface_aggregator_registry.c      | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index a594d5fcfcfd..e08d029e0856 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -406,6 +406,22 @@ static const struct software_node *ssam_node_group_sp9_5g[] = {
>   	NULL,
>   };
>   
> +/* Devices for Surface Pro 11 (ARM/QCOM) */
> +static const struct software_node *ssam_node_group_sp11[] = {
> +	&ssam_node_root,
> +	&ssam_node_hub_kip,
> +	&ssam_node_bat_ac,
> +	&ssam_node_bat_main,
> +	&ssam_node_tmp_sensors,
> +	&ssam_node_hid_kip_keyboard,
> +	&ssam_node_hid_kip_penstash,
> +	&ssam_node_hid_kip_touchpad,
> +	&ssam_node_hid_kip_fwupd,
> +	&ssam_node_hid_sam_sensors,
> +	&ssam_node_kip_tablet_switch,
> +	NULL,
> +};
> +
>   /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
>   
>   static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
> @@ -485,6 +501,8 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
>   	/* Surface Laptop 7 */
>   	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
>   	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
> +	/* Surface Pro 11 */
> +	{ .compatible = "microsoft,denali", (void *)ssam_node_group_sp11 },
>   	{ },
>   };
>   


