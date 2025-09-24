Return-Path: <linux-kernel+bounces-831332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAEB9C60E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A37AFD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E65299AAA;
	Wed, 24 Sep 2025 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEZ4LpWl"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026892857F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753710; cv=none; b=TYa4iSUgypFLiB9frs+KVf7emeXy5VQLjnHGaLzbwzzYSSAmyZqu2WLfTDSEBR62bzIyX+wr7KGBFG9EqbxkEKImKGFRxVIhovK3crn/MpTyRANVAKJnKuZM0DXzs0olkR212P9I1Ajzjen74a6SHAZJodIgodAXBRfWVfrE4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753710; c=relaxed/simple;
	bh=qZAL+k6XR6suqjqnIHWZgbpTt032kyc+8wEcjm2cTi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZBSrTPnWnWfr26yM5wV2e0//wDrzHrXMdcuec9xKTa/Mp+o4ZsWXfPycb5lHTRYPmcij5W2aPGqYzIqntE+I7SeXL3NRcHnwAftY+5X75TaTT4EJCbNVq2Q8+EiFkrdK/q61kyOFnPJmB3TEna6Ay7ALV6Nu+FuC3aFNg34Pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEZ4LpWl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7810289cd4bso84566b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758753707; x=1759358507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTLuHAgen/gp5eor0F//xJbqIEJ5qUIL+VXfFCSnxP4=;
        b=AEZ4LpWlddvyIyh4nq2QhXqnoNEfgYaA2+IwPAkcqf+ZSAvl09iDhhMC6DDXJYHbKV
         y23VytLuryadMGKYZlhNvWYCIMWwuu/x7B1VggS5cEd9L9/uQ9S9oE73nlrXbjtlmlpk
         pQLZgTXW8ltYVhVDC4JulKBBaRtCiJvfKaSqeNahVrL3UYUIzbpIiPqaTFgVzDKquRQN
         d0xAyUuJjwblGVHTtKq+lgW1UJupEhRYo68u/1J6ZTvLQjHbwyybmOm/906iUO1+6AZK
         G6P/Jqj7QrZrV/oQnw3/okE48HJMx7lpovk+peZxFm4k6cuRXVbu6aMPadDaPXATThjh
         3oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758753707; x=1759358507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTLuHAgen/gp5eor0F//xJbqIEJ5qUIL+VXfFCSnxP4=;
        b=UcN7rohFmYdduyZVa9MuNqUs4iQzz+2yobWSWtu2D5WP1P0FKuA5dSvCb+lxA2W+KC
         +Sxr8HaLLIGgXpKiz/CLKpEL4BWGxu2cpYv5SEM2U+t13hE7bKNTCBv5nvAIlKZpBtNM
         fGCOumO19b2crx/829rcZ3cONbAfZ5U8pi8sZ/YPkzwRbo+6lttjJy2wHJ0psBLRx7ZE
         ApQUvu7KVEhhyznEAB4mfQFQlLKCIyK0P9Yfigb3xJb7eTjsc5A15xiQc9IuUVZZrRit
         tmC1x9+AfTAXTJYXV1MhWIs73ZFeBRZsweoGvC6hhPVud541UbfjZO3KJRRiLsahdsV6
         6cYA==
X-Forwarded-Encrypted: i=1; AJvYcCVj1zu/KXOBI6gBmpX74NDYfJzcWpitk86aeg8bMKQP11/v/eMKPBvcIR1ZlKLN5QZT5HwhGifnM9L81Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFco1qT7sT5mJdRyr+pHwH40I9w+c7SIV4oG56V8FU8uc2Z/R2
	QcyetJQ5Ii+ev2M0e0J9CnOHT3RNwdPbYRlXtNVpFPTJZknLgRQQeG+/
X-Gm-Gg: ASbGncvu1Yl1Rh+rdLX8ORP6DiHGqsGKwt+20Xw/Xo1aa6QGoh6OPVZVDCVO8PjlCm+
	sPZdyenvaxkykqZ0Yz5RPdDeCc4bSBBTKQJg7yb4QDSUKrbl0qyjhE82/j4iF8E97wUNs3/lEAn
	V49DWckRrMzhPpvVxczsc69BRWX1Yqt9sz+v/odICIdjgn09Oegi0LPEhckyxWiAPtc7X0/fE5S
	VPVC6O8Sn6fwawXD5jyV8E9fME6n3C061ibqGqLYP+BVeBv/qbyd4/cylLnL1K2XZp+tQL6KVvR
	hjWXDCgHzF25Ws12joE4apICRZMNWaIgP4rsSqD+NtRiIZn2j9mnSTm2M1xor05Y1YAYgXZSUP1
	Wg1E1v8BU8Qb2SZQVty4kS82seSSXDXDMVdtroswGSWZPjyAx/YIGRh11GvZOv9ZTS/CwcHDGtc
	8vvg==
X-Google-Smtp-Source: AGHT+IHQCCQBioSY8KFD1GNYyzOiguG3uokLQMUGixJtVIltlICVidMMUGysWt1PhXp8HG366QZOOQ==
X-Received: by 2002:a05:6a00:180e:b0:780:fcae:de6d with SMTP id d2e1a72fcca58-780fce9ffb1mr1628610b3a.18.1758753707259;
        Wed, 24 Sep 2025 15:41:47 -0700 (PDT)
Received: from ?IPV6:2804:14d:4c64:81ec:d0e6:1b41:e7f7:c7b4? ([2804:14d:4c64:81ec:d0e6:1b41:e7f7:c7b4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c0741sm130527b3a.26.2025.09.24.15.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 15:41:46 -0700 (PDT)
Message-ID: <95e8d8ee-fb8a-41f5-91a6-746ab56540e8@gmail.com>
Date: Wed, 24 Sep 2025 19:41:40 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: iio: proximity: Add Lidar-lite-v2
To: William Breathitt Gray <wbg@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, conor+dt@kernel.org,
 mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250824102324.427517-1-wbg@kernel.org>
Content-Language: en-US
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
In-Reply-To: <20250824102324.427517-1-wbg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> 
> Also, I`m quoting the driver author about this binding due the maintainer ref for it.
> 
> Dear @Matt Ranostay, I`ve noticed you were the original driver author.
> During the discussion about adding lidar-v3 as trivial [1], we noticed that
> this HW is not actually a trivial due other pins like power-enable
> and mode control. We are considering moving v2 and v3 (which was not documented)
> out of trivial and this is what this patch is trying to do. 
> Also, we need a maintainer for the binding file and I`ve quoted you there.
> I would appreciate your comments or suggestions over this topic.
> 
> Tks and regards to all.
> 
> Changelog:
> v2: creating an initial binding for lidar v2 and v3 (fallback to v2)
>     also, moving v2 out of trivial
> v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/#t
> ---
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> new file mode 100644
> index 000000000000..f49a1c365f3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Pulsedlight LIDAR-Lite v2 range-finding sensor
> +
> +maintainers:
> +  - Matt Ranostay <mranostay@gmail.com>
@Jonathan, in this case Matt didn't "ack" this and looking for other references I've notice two different emails like matt.ranostay@konsulko.com/matt@ranostay.consulting. 
What is the best approach here regarding the maintainers ref?

Either way, I'll work in a new patchset addressing all the things mentioned before.
Tks and regards.



