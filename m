Return-Path: <linux-kernel+bounces-824968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E80EB8A977
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D895A2D11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6F2512F1;
	Fri, 19 Sep 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3+qTFoG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA106253954
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299848; cv=none; b=LEa9gikMDhEnGAxnqSXG8losAvLXEIm1HamcFuSg3iTcwtjXDI+QErnu0Vo9m9Wi1K8tc+gD2fjqbwXH1jCpDEODNtNd6jeAKykbNQk/atcVGsdD7hQ2bh8rMd86d0xMlnt15Tt9qMImsRfw/51O9Pq0zC/35QSMiKIYqFlgGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299848; c=relaxed/simple;
	bh=9uoHymsF5pX68JAjo3GeIAUB5sUaex0VrFvZfKwQZ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi3Z1PdmsEVKTzmXPpv0MzMK6u5MoHiLDE5KpYmZrkT40s0zrSO5hLMYQW7I1YSy+r8xe93oJfk9qRvRiQbDsYyi33krhCG10zPTLMycV7LmwbMs/JsttyCJnqMHGcn6hcMulCPBhoaUyhyOCvzJmbtrhMiWYd8l2Gzx5tP2FCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3+qTFoG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso1382781f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758299845; x=1758904645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/knhkAXouYA6Xl6JtvTXAsRE/iUR0XbPvcQV+3XkA0=;
        b=v3+qTFoGfh7ct5EmaNPLFc/HXb/1CKkEgnWzEM5nU31v3gzmJyQ14VNkJr8UqFnZuv
         hs67aI3JXi00LEwCnlIWeKv99VJigwSQr4GAiVhrABZfNyQ1zp/zWTk5k3WqqcEurU9l
         FHJ08GXmawfr6gpFAdfb/WaqUn6bBdKAgJeCZOYKOWoQ9+w6bzKXEdVRBnljKqIDBTDM
         Fc67CK/6F7aqoT1HXLkS/hldE7TLpKzWenR9AXNwzknbcTKFS+6Vp2Lc03vl2YZMsIMJ
         IivUfXhprRiyJR/oXv4Y6BSCGIxmh75JNBrcpS5s+0cf8xsHG5GJZdNsqCrH+mtpw4qh
         blfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299845; x=1758904645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/knhkAXouYA6Xl6JtvTXAsRE/iUR0XbPvcQV+3XkA0=;
        b=Uc2P1YBpKI1NzWeILexGP580ZgCGBH1NcqETDRc0R+9xgNWf7pYJgbUFd8Gb9SAZhd
         Hu9M8rpyQERRG6QahaeLKhxAAHg9tC+00iex6ZzKxvUTmftKbAzm/eqEizxHLKSYJAVi
         FbNCaH+iaWuSEzqQ6w9gPx76Qh3/8BWwf7cHJHd5EmA3f4A1IUuvl4+uD5e7AGQHc+x4
         mzyGRhtws8u5BD/uPDX4DSZRPNmrfYWtimG0O9KW68dmciJY202d7QUuBhOcAS+Owk0H
         w8zfuotwBkgskwOg/04sIIoqBIiBxWKP+3hEnvdAXf3IPTMK2tcOw6JpWNrKs7I024aY
         J3zA==
X-Forwarded-Encrypted: i=1; AJvYcCVlKs7t/2xbvhiIGtds/JJ/Z9wDj1zcUi2a/vHANLY8XOlL3r633btbLaJYRo4X+UUSaaVYB4eym9V3DJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfU6gUnMjOF8+9m2jc9ioPYMF2wggpFe4r+1UpOVUXshrdZHub
	59k4x6rOfOEpDCHYj6PQCpGI8iTZP5ne7OPYuSOFAjPWwQhLjM8rYPuS8P/sH7aujYw=
X-Gm-Gg: ASbGncshUxua3ND4VpfYezMqgTx6GwawmycVp/WsSkmBHeCRfY3v29T9HRuj6ddGxbO
	JGb3cASBxLBa4EmVg2gfTY4iZLAqa1tLzpmilqXjt8uHlExhDz8w1CO6DAmz3vKzk8hkd5Ud1dx
	CgCWNBkxYMOW/puuL1AtLVPYQATuNL2MFdalNLj58EDiV1t0Spf+AhG722JwScWo+TV/k9dZwJJ
	DIi032uO2gHVPBKO3avmulHza59GBJJ4ApPD6cW1pI9wafZWpB4SGvNxfRN8fRcCQ7n9lzR4I1c
	wbH2ld5bvQcUvegeJgqdjQxbIfJivFs6Lb0HVi8r6XV34pdT/Bd5pacMWl5Q6uDDTMte0QylD4I
	8lBTQDYXOQhsJx2go02bGliZ7QLZemCSBlRrKBn0NbMEHJqR1qGq/53fy8ukED6JovJmlNTNM0u
	o5yA==
X-Google-Smtp-Source: AGHT+IFLCUqUgGD2nd4xyiWXNaIfWMF8JqHjk07IMJDtnkFYT6wdV7TebvWGMsqzX6eS0i+DvItVtA==
X-Received: by 2002:a05:6000:1ac8:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-3ee16600969mr4237445f8f.12.1758299844844;
        Fri, 19 Sep 2025 09:37:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7478sm8450648f8f.38.2025.09.19.09.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 09:37:24 -0700 (PDT)
Message-ID: <71ad53ba-7b72-481f-9b62-1b268cbcd912@linaro.org>
Date: Fri, 19 Sep 2025 18:37:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] thermal: renesas: Add support for RZ/G3E
To: John Madieu <john.madieu.xa@bp.renesas.com>, conor+dt@kernel.org,
 geert+renesas@glider.be, krzk+dt@kernel.org, lukasz.luba@arm.com,
 magnus.damm@gmail.com, mturquette@baylibre.com, robh@kernel.org,
 rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org
Cc: biju.das.jz@bp.renesas.com, catalin.marinas@arm.com,
 devicetree@vger.kernel.org, john.madieu@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 p.zabel@pengutronix.de, rafael@kernel.org
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2025 19:01, John Madieu wrote:
> This series adds support for the temperature sensor unit (TSU) found on the
> Renesas RZ/G3E SoC.
> 
> The initial syscon patch [1] the series depends on has already been accepted.
> 
> Changes:
> 
> v9:
>   * Remove driver-specific read/write indirection and use readl/writel
>   * Use devm_mutex_init()
>   * Switch to syscon_regmap_lookup_by_phandle_args()


Any more comments on the patches ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

