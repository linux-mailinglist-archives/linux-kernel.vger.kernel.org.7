Return-Path: <linux-kernel+bounces-891943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B91C43E04
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BC2F346989
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E32ECD06;
	Sun,  9 Nov 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM+BddcS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215362ED15D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692601; cv=none; b=QTo/QneLeXCS7g1EToMStUKkUEBniweD1+1eD3hFHG/vTS20Av2rzV7A9IZYcErxnN4u2X6u0zWu84PuaXcukTB32D4DEcLNCZzFGTyqekJgWLg0e2bwXb2LdIeJM0TrJYFcobLe69LAFLa7YKiNe9gWDpCN1bqd8P6DCMtz+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692601; c=relaxed/simple;
	bh=RWsh0MNVHHOeT+2llJsTwxoFnM5p6UnPIPtoFkDeVgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUoI75KG9g2c1cZR0idEsWQ1hQohCqIjZ9Vlve7UZO8ABMhe5kExQJ4Gd6wXL2bq0So7kevMWcDMpv7w8M3fceGki2ueb0DyXQqA1/qgad5G96JX0RoUk6aNJ17LRwGk3QioquNQg/MwxhJUYiqYrS6SS13Vf6UKwPQVUYRhYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM+BddcS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so3443546a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762692597; x=1763297397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3uCPMdMXg41Vg12Apli3BT+126wRXMTBjult076Xbo=;
        b=mM+BddcSrPO4Ff3Lxyd4Awuwj0dTiUnDLqiFoUqaFWTzSBZCtkQg9W5WOo/cSrzDlE
         io8ZKsjLtfXqvlHfZuY90IYMn6nNmcjv/cWT8ErAW4fmkqFVMmRSZ+y5itJUU3Jle2t4
         PCmdXXjRIyC1RoCe9eWSuoFTayWUadJY5rrjSoh5tMLLj6wd6I1vYk4FDleM6J6MrVBL
         w0qhAmEGukwif5uqjcnzAJigPcpXK68zz1V6Xxb5T6yLdJ1N22kUlXfudmgOquipi8Yw
         2fd2Ipsr37h2tvI0IuoGWOdMrhJUri4N2TvG3bzrg1g4v5PQzBVvN5BS6asHi2BEj6RD
         UEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692597; x=1763297397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3uCPMdMXg41Vg12Apli3BT+126wRXMTBjult076Xbo=;
        b=qB14TtOtl8CkTXWnMlo0oKs5ImyKGGMQuYcgRyNVI6bkPNAJXLuTj7aqcZkj3/4iKx
         EsRePEGXGzoChd9fbnGdWN7FtLxz9ndRToJeo24Lui8+0k0gy+QA2QJIhN1urq5FJGKJ
         PajX+e/d17JkPkHtDgUbedNZVTKkL3XiuHmA0g59/jz5dBClyPNA5DSbgt3WvV5PHU4n
         25AiNXkcS1O1lRO0IQOTrRhOFtmdQ1VduBOzwl5a/tTd0LObCHnhabqoLGiLKAhmX58a
         tjsLR1e01oGu5sbGJEmNipJHwJY9deGZ9a7+W4zMq45yJ0rI9o/aOp45XA6MtJtsQkOf
         2tOw==
X-Forwarded-Encrypted: i=1; AJvYcCVyT006ZVO/AbDywb+84niXI6frnnFwnFpppY56AyCwDl7jm/6rN6dmNg2a14MyOGYDVvV5t84b+PznKVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7Je2db0MIAuhKMX/0j7QXpzmhn3gMlMIPZ6sRfiy8w9GHnEi
	LQgdafKCPnVmKlPmgWBOJbDt1laV094f3vPQg78mM3gGm/saEm6F6xbPvTc6kl7azVE=
X-Gm-Gg: ASbGncs5YRPWsE4LZUTOJbrK07cosGDMW3FeWrai3hdFP5D7r/CCn6Z9+GNW3oR+cUU
	M3mO2kK/AFR67slFs6lC0cZIbt/Nse2B5PDjvhc7TufcTHx50bMn/RAkXSrNkX6uyp80hQKsN0R
	j5lFnbkSv1ap1x4rozBx9a+raXVsP9gBfi+BnchXRXUeDSF4wM8oXwc2WhdgYh7Zf9vBr0pBTv9
	lmGgIXhcsdKIzk4zyoPqe3R0d0C2CwauprVi5WN2bjq+VDYaJ6lgbb6WQnYYesi7cePq1HoiUYZ
	Jq87DksAyAdm3PPnF8K+F8L2WwO0GngyUBaGpdZ9ddZTZ+d8vc+RF6VdraumREIOHwqFYhdcS9E
	EVvHe6aT9dgAVO4tH7cBIFv8ZspguzQNLokhSJLtEJsBC1wyM+oGOSefu1avSj/YuguXNGRo/Bl
	PtjJYRCAWHY303QeS6MumbUY0bddEo+shGTD4FDicAUM3dCtB0hIla3S35UI3wGQ9mj2xsiirJL
	6opjrhmY793uR558r7Gb6svpSgMRYs6ZCIA1H0zI2JlZnBOPRfN1gnd76AYkqDPWZYrmnvW4+/o
X-Google-Smtp-Source: AGHT+IHq3tipKWAq6loGNwoQe1tMCrBPSrk3SZF+kU2pkM50gqp5iIGyhpBDk7dlni6/awXeEtBrLA==
X-Received: by 2002:a05:6402:1474:b0:640:9b74:b448 with SMTP id 4fb4d7f45d1cf-6415e813d04mr3914452a12.30.1762692597394;
        Sun, 09 Nov 2025 04:49:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6418b54a888sm611277a12.32.2025.11.09.04.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:49:56 -0800 (PST)
Message-ID: <0390ae7b-8f56-4ed3-a3f9-616e7c74adbd@linaro.org>
Date: Sun, 9 Nov 2025 13:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] media: camss: Add support for C-PHY configuration
 on Qualcomm platforms
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> # Short summary
> 
> This patch series extends the Qualcomm CAMSS (Camera Subsystem),
> including CSID and CSIPHY components, to support C-PHY mode configuration.

Awesome to see this actually working after so much time and prior effort!
> 
> # Background and motivation
> 
> Modern smartphone cameras increasingly rely on MIPI C-PHY rather than D-PHY,
> thanks to its higher data throughput and signal efficiency. As a result,
> many OEMs adopt C-PHY interfaces for main (rear) cameras on Qualcomm-based
> devices.
> 
> Until now, mainline Linux lacked C-PHY configuration support for Qualcomm
> chipsets, preventing bring-up of primary camera sensors on several
> Snapdragon platforms. This series closes that gap.

I think it's worth being clearer here that this is only tested on 
SDM845, and will only work on sdm845 anyway because of the lane 
configuration.

Additionally, with Luca's explicit D-phy check removed, other platforms 
won't error out if someone tries to use c-phy without adding the lane 
configuration (and whatever other configuration might also be needed), 
so it might be worth adding a proper check for that.
> 
>   - Introduces C-PHY configuration support for the CAMSS driver stack,
>     covering both CSID and CSIPHY blocks.
>   - Successfully enables C-PHY operation on the Snapdragon 845 platform.
>   - Tested on OnePlus 6 and 6T phones running mainline Linux,
>     using the Sony IMX519 main camera sensor.
>   - The new configuration allows other chipsets versionsto enable C-PHY by
>     simply adding corresponding sensor driver support and csiphy
>     initialization data, following the example set for sdm845.
> 
> With this patch series, mainline Linux gains working C-PHY support for
> Snapdragon 845, paving the way for improved main camera functionality
> across many Qualcomm-based devices. The groundwork also simplifies
> future enablement efforts for additional SoCs and sensors.

woohoo!

Kind regards,
Casey (she/they)

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Casey Connolly (1):
>        media: qcom: camss: csiphy-3ph: Add Gen2 v1.1 MIPI CSI-2 CPHY init
> 
> David Heidelberg (6):
>        media: qcom: camss: csiphy: Introduce C-PHY
>        media: qcom: camss: csiphy-3ph: Use odd bits for configuring C-PHY lanes
>        media: qcom: camss: Prepare CSID for C-PHY support
>        media: qcom: camss: csiphy-3ph: Use sdm845 C-PHY configuration sequence
>        media: qcom: camss: Account for C-PHY when calculating link frequency
>        media: qcom: camss: Remove D-PHY-only endpoint restriction
> 
> Petr Hodina (1):
>        media: qcom: camss: Initialize lanes after lane configuration is available
> 
>   .../media/platform/qcom/camss/camss-csid-gen2.c    |   1 +
>   drivers/media/platform/qcom/camss/camss-csid.c     |   3 +-
>   drivers/media/platform/qcom/camss/camss-csid.h     |   1 +
>   .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 165 ++++++++++++++++-----
>   drivers/media/platform/qcom/camss/camss-csiphy.c   |   6 +-
>   drivers/media/platform/qcom/camss/camss-csiphy.h   |   2 +
>   drivers/media/platform/qcom/camss/camss.c          |  24 ++-
>   drivers/media/platform/qcom/camss/camss.h          |   2 +-
>   8 files changed, 146 insertions(+), 58 deletions(-)
> ---
> base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
> change-id: 20251109-qcom-cphy-bb8cbda1c644
> 
> Best regards,


