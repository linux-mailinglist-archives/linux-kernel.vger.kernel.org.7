Return-Path: <linux-kernel+bounces-835882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA7BA842C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC243B2347
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914692BEFF8;
	Mon, 29 Sep 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKcv5QVm"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828202BEFF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131377; cv=none; b=Hfs6/Pqu+qi/2cseT7VRrgNgIeZuONihEcJFAs+fJ8XjYm03Elw1NIMLYynRHsxrcHyNYpz1ZA55dbUDIrGMUdzuag9XqUql1lzJ3BvJ1m5bK9P0JR4B4NYNxco0znMExbs4bi7AZ/cXtVCfkAC9ARV5wdHQ61i3DTpaLXVi3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131377; c=relaxed/simple;
	bh=iI5dyLH2jL82quewevun1RJ+cRuVB4TU0GIEvBc+ppw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVo5uBRC2pGGvezFLtrcEnQS7Yb7XU1QrYzi5+Ee00Jk2ql9QBZ1nlz4sk3PpiWoWl/Uct4VdEB5VuE9tY6zH98yl++x7TGe0+txGqoLEBLsksSuinadFxelkXWcmzZELi5nJdCHNyKcIaaR4u/T7ZboY2BSIPlCBPJB921eygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKcv5QVm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b523fb676efso4193864a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759131375; x=1759736175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtpldhRDbRzoGsO+8pMp+y65v40hHUOFZZcRghWlbXo=;
        b=jKcv5QVmUNfgz6zP/NqcX1zRgPKHHscG77wdCIg/wYQTDeLophx6v6zwEdol5z/Y7b
         F7JSlvHazeewAG9GSOhVpsre5vuuitAqWyL7SlEEeVpj4rkXaTjxFkvLmccDjs3t4ik6
         6Zu7X/siZwYP9LsE+4R0Lm4BukyxGDNY6uCobb6pEEtXAF3+edHr9mSOIABVOYBBphCo
         tXzQt/WkBGcTH+5TsfZfY4/VN24cJ/mh9LL4mFNza37RKPEQA1by7mXFEbRaL/bVaZvP
         SjMMC4/K9KZjJWOK5W68KqD70yb14Kq7umdR5lmwDPbD8/7kWdIbml4PlIBeS4Qi7CSj
         Co2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759131375; x=1759736175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtpldhRDbRzoGsO+8pMp+y65v40hHUOFZZcRghWlbXo=;
        b=GN706utiQPXFaktR8BIJrJoWvY3UwP29OZ8zsdlNk8rzCnWG77aZI+7D+hTOKD4PtD
         EbBeTAlml4p3HUBiYY00FGBy2LeeS+L0VhB8MJt+wko8REAjB0Jhxbyb0MzDPf3Xa/Vh
         USTXqYZ2WUV3mGe54YQKz5bGW0mqACXMN0fW8YHlwYQB0R8JnVyziOaMZaPsRMvoTZ5n
         gE8UR/kVmvMeigDMGmTOYsaigQQAEpDtSNVK32/Son7axGUGyd83aDZTyRiqyP9IaeaG
         wjKD1gp5+nAjZMyghPnyxuA5fSbW9PcclJikZ/64BGCkoI/emydIvcC8n6a6sR4BcOo+
         9uvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW87nnaFmI2Iy1Df/HUE3lurxPZOQvYDpOviWmHxaXry9PqwdecOvV83B10yigIpo8AjsYcyhSmPBY6nrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnAe9mzc/SrABCq6s7J7gbKYCZyfYIsjT+ZtM4iQ94i89sccX
	USJUdrZrWWacmIV815cHoDMqevU+fBmsgNxeQQCOKU4D/nqT/d2hpaAO
X-Gm-Gg: ASbGncvj7+1II08IQ5TTs4xexxERHq/VcHiTj8LrcO2RQIeJISF2vf/KVsrCMT7XqU7
	ZaWDwxCqJVOUKUAtOAGZa0jLlbs0qN4mrmzxKr8HJ5BmDLfREFRSxJwV4lAubpl0eKOAwGCZMtH
	nWRl7lSvJpUIEHWy50l1F3T/rHCp0G0zaCaLyCENn0x+zEUKDfitrX6hPUJDh6IYAAcujKe/vLH
	ZeIOcF1nog+NB2L/sq9cKhvQHQNIOYO894ugiGvDqWv4NCTpibMQTF6Cd/3MCCK9FXxjy0/PGtX
	aPOjXUss4+4Eq2oRj/2BpP5Mqrg6bxxxTNN1z08s8OSNB+uRgWJVLP91TFWdLR1bM00nm9zcssp
	eoXI1T0BE8yvfMqZ5T0vectDC4ZROB2IvsycEhN9PK3dcCoBmATdtoMyBkPwqszGlVhZOsNCJ70
	FM
X-Google-Smtp-Source: AGHT+IEWeCcdaLlQLuxHrfc5zv7vJMgw2RSY5WHEZHUZu8lif8TvLDvdNna1pOwRzpAobj4aitc+pg==
X-Received: by 2002:a17:903:110e:b0:266:64b7:6e38 with SMTP id d9443c01a7336-27ed4a47150mr170404685ad.46.1759131374689;
        Mon, 29 Sep 2025 00:36:14 -0700 (PDT)
Received: from [192.168.68.63] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27eec33b775sm92844965ad.12.2025.09.29.00.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 00:36:14 -0700 (PDT)
Message-ID: <5658a127-617c-464a-9651-5ab114161f84@gmail.com>
Date: Mon, 29 Sep 2025 00:36:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Heiko Stuebner <heiko@sntech.de>, "Leonardo G. Trombetta"
 <lgtrombetta@gmx.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
 <175856183851.499898.2147562889507523573.robh@kernel.org>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <175856183851.499898.2147562889507523573.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>   Base: using specified base-commit f83ec76bf285bea5727f478a68b894f5543ca76e
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com:
>
> arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: light-sensor@48 (sensortek,stk3311): 'leda-supply', 'vdd-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/iio/light/stk33xx.yaml#

Thanks, addressed in v4!


Rudraksha


