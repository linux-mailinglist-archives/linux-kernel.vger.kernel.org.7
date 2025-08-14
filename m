Return-Path: <linux-kernel+bounces-767900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7BB25A43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B75586FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1619B5A7;
	Thu, 14 Aug 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QbCQu5rX"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118E79FE;
	Thu, 14 Aug 2025 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144187; cv=none; b=ua/9HZOgKFWKLQIwNyovjImUXcheKXD4xcrZk6KT38pRqJ+GK5rNb61jI3u2AmU94vMNvTUCjmRFBufn59gh+WW/+b+dMHRwij/QDoM/xzIP+R9/m/KK3YnfqBVgxcx53TbJ8aGuGbSXkGCpAlSoccnxFOSYVFNrigY1omKmRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144187; c=relaxed/simple;
	bh=KP6fMqvPICmfnEPfdhrHE/kSSO/1Eqjeywd83LICFKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RkFRk+b9OU/DB58CbfviIpgeAsZPJ6+8XEHa7nTEQ+ikBacWTYKDCaV0E8KvFjE906BQoSeoCvAp0jdf5c5GTXKD6v5AF9z80n1iKZgYGpiRZ1zF2Hbvym5o/2MhedICmHeCSChgAYPhpVHqq2KHFET3mLa0YPIf0sAXaiqLnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QbCQu5rX; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57E42thg2222677;
	Wed, 13 Aug 2025 23:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755144175;
	bh=rWL1oQqSxIaAHJO6HOoNdyoDTllnJzkAz1ZHedm1Jfc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QbCQu5rXjlb4LAYjyhYwiNZ3bq0JWu5C2JtkNVqTYsYvQnFwaChqXgjaa6hUlvLMO
	 rY1wMtfy86PT2QZ5AxhJ882HQ3P7zIvEPkDbks8rilmfDTq6DU1y5UxpZx7Xm8hDhE
	 m3KN3lBZ9kqdlL4xGvJ4RQfnVVTh2Ykl8BD2nlLg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57E42tgQ874082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 23:02:55 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 23:02:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 23:02:54 -0500
Received: from [10.249.145.16] ([10.249.145.16])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57E42nxv3013204;
	Wed, 13 Aug 2025 23:02:50 -0500
Message-ID: <5ea5626b-6e01-47d9-985d-16eb6e3b782f@ti.com>
Date: Thu, 14 Aug 2025 09:32:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: it66121: Add it66122 support
To: Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>
References: <20250813190835.344563-1-nm@ti.com>
 <20250813190835.344563-3-nm@ti.com>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <20250813190835.344563-3-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth,

Thanks for the patch.

On 14/08/25 00:38, Nishanth Menon wrote:
> The IT66122 is a drop in replacement for the IT66122. 

The IT66122 is a drop in replacement for the IT66121

The part is
> register compatible with what we use of the IT66121. The only relevant
> change being the PID is now 0x0622 vs 0x0612. Add this extra PID so
> probe does not fail during the PID check with these new parts.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Note: checkpatch --strict reports:
> CHECK: No space is necessary after a cast
> #45: FILE: drivers/gpu/drm/bridge/ite-it66121.c:1643:
> +	{ "it66122", (kernel_ulong_t) &it66122_chip_info },
> 
> I chose to retain existing style - let me know if we want to clean this
> up as well.
> 
> NOTE: .id = ID_IT66121 is explicitly used as indication of reuse of
> existing it66121 compatibility.
> 
>  drivers/gpu/drm/bridge/ite-it66121.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index aa7b1dcc5d70..329fa47a5701 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1618,6 +1618,12 @@ static const struct it66121_chip_info it66121_chip_info = {
>  	.pid = 0x0612,
>  };
>  
> +static const struct it66121_chip_info it66122_chip_info = {
> +	.id = ID_IT66121,

I think better to create separate .id as done for other chip_info structs :

.id = ID_IT66122

Regards
Devarsh

> +	.vid = 0x4954,
> +	.pid = 0x0622,
> +};
> +
>  static const struct it66121_chip_info it6610_chip_info = {
>  	.id = ID_IT6610,
>  	.vid = 0xca00,
> @@ -1626,6 +1632,7 @@ static const struct it66121_chip_info it6610_chip_info = {
>  
>  static const struct of_device_id it66121_dt_match[] = {
>  	{ .compatible = "ite,it66121", &it66121_chip_info },
> +	{ .compatible = "ite,it66122", &it66122_chip_info },
>  	{ .compatible = "ite,it6610", &it6610_chip_info },
>  	{ }
>  };
> @@ -1633,6 +1640,7 @@ MODULE_DEVICE_TABLE(of, it66121_dt_match);
>  
>  static const struct i2c_device_id it66121_id[] = {
>  	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
> +	{ "it66122", (kernel_ulong_t) &it66122_chip_info },
>  	{ "it6610", (kernel_ulong_t) &it6610_chip_info },
>  	{ }
>  };


