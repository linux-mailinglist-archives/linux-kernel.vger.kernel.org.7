Return-Path: <linux-kernel+bounces-830817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6CB9AA37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFF61B2754F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783D3126D8;
	Wed, 24 Sep 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lip7kLZB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F53126D7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727481; cv=none; b=kykmWNhRexJynpwiiwXL3MSGzsN7ACtHHDFW/y3cJYpQFMMFqIks07NHSVBU2DCqWZl6dlKUPdiQfgFLvJ6sIdbHu09MMxVbQ2plF62gyeiTjFb7ZFyZU0FhXEKV30uLeJJVN7QPLpGeQw/qD5+tnjG5HOkvHD4Ktob2hP+vWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727481; c=relaxed/simple;
	bh=0BPOAm9dP69JEhXlTRE7Dca+7rydr7eI9CX+nU9juPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uD756Os5wkFrCARP7SIehH3394u3UHsfNFc/wI03ZStA+VVVtniAQBRJa+IcPLcjNbpNnC3mZyc2EV92kJMDnJH/yFp1gGcrZKTocCEqB9oxwsu/JiHo9urkPUB2rbzKMlHGL2pbQnhaTmOQEDNH+y6+RRawuh9bYv3ZqHswZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lip7kLZB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso51187775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758727478; x=1759332278; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYxSqnIQ3qjG/8iu9AExs5DpSEa0GvyoBl784AP7Qs8=;
        b=Lip7kLZBNZZO5+kG+pahRHh6A3oZVmPiqtyNkxxQNuBRTGe9d4m0QxeE5dZ1RGHkHM
         slcN68FUApI0/qXfiYnM6hb+4ix8pZq4UCd1+Ob72sutGaL7yt1j+wizz7gWAHuAC16J
         SFqiVVhWy05YkkURJHfR2DFQHsBnMvnaUp3kAk+U9SoVw4tETMQd+U/R9ZCGrS/NusM+
         wDgtGNOHecQPpn/8J8zEJR0Wn6LrVlzgGz3HHsNJIx1GyniBANOc3WGvU4Wvr0Uyibk+
         W5fKRrCDEV3NIUI5BK7AQ9GI2KvXrK3UYFgC6lnj18mOddqspNKHpIRE4RAd9HvfwL5r
         EkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727478; x=1759332278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYxSqnIQ3qjG/8iu9AExs5DpSEa0GvyoBl784AP7Qs8=;
        b=Kv3z5eKm5pSVl96za+4YKBCPpwcQSeN0FTNyyJ251SUU4aZoGzTU5xdPYymTHsV6va
         lJimcu6FdFEL8CMjNAZ7Lxo5zE7bU7bGK15QKEFF4SmDhcLuSdMvOVqJnIPaHO13Wjx/
         GMu3iPyCYUHyqZ5omR+/DsK0Au1x4x/SnZPk3u8QGy581zAiUxOehS7RzIhcTD7Gmq81
         QI22pgUTgzX5avKG/cHWLIOh0gROTp0yQGT4azGui+NsZPXzyyT3Ht6mUmm8u/Lyes3d
         U5nDKy5zRFS00+N48B6Rd1pKq17ljf4rYcgRyHQLndFdRUOL8eMVca6/FOjVEqYjFo/Y
         R0cw==
X-Gm-Message-State: AOJu0YygaBY167No2nR25WnICsegAPMbhr3/PenHgwKoW3vmqkvuYYlY
	Ha4roqtjiy0VzWsNdU2FY7CGdMjSkRmzGiT1WonO4vVPAOHaPu/QhTWSOnPEOJ51D90=
X-Gm-Gg: ASbGncvaCG4ZMsCLzyOMBgBOLcsVDvAi88c0YMOpy7An/t0esaCE5WCVQvK0Y0K1XFh
	AVua+abS2aDvWbFFXNHQNTl5r9217YwW0PpMGY6rfLgU9hPU8RZpjnVtL/Hd64YecyETDzSx9WX
	HWvsi5FUQejKDA5FnLxrft3yU4GSQwkL2jMdVFGumH2xfiPOaY/fzynwnL8dPODCX2YMlPb+6YM
	VXn8cLKS7F1O8dpCSO9jH8+1o4Vob+e5YgAuEvz1cyU7qYaV+VCE6+u9zV8D8TUQxPdyCv2YgNX
	thI3ZkriVZxmovLYqfXGsS9qJ4r7EszuTkaVX+9nNTnjE81rxlv11U7AwOonkEQov4wy1GWviZ9
	uOyv70Rvnb7PePoBswDmmbe1NXA==
X-Google-Smtp-Source: AGHT+IHSVtQc0PcF907T9ysNH9gXQFv1R4nZa4WXYglWRwMrUQrvL7l25ij/5cog4d6UrbB58i1fUQ==
X-Received: by 2002:a05:600c:3583:b0:45b:97e0:22a8 with SMTP id 5b1f17b1804b1-46e329eb144mr2418835e9.22.1758727477928;
        Wed, 24 Sep 2025 08:24:37 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac582sm38510685e9.9.2025.09.24.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:24:37 -0700 (PDT)
Message-ID: <03cbad1f4f311727b4dce9c969404e2bc138c556.camel@linaro.org>
Subject: Re: [PATCH v5 2/5] firmware: exynos-acpm: add DVFS protocol
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas	
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
Date: Wed, 24 Sep 2025 16:24:35 +0100
In-Reply-To: <20250924-acpm-clk-v5-2-4cca1fadd00d@linaro.org>
References: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
	 <20250924-acpm-clk-v5-2-4cca1fadd00d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Wed, 2025-09-24 at 15:11 +0000, Tudor Ambarus wrote:
> Add ACPM DVFS protocol handler. It constructs DVFS messages that
> the APM firmware can understand.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
> ---

[...]

> diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/incl=
ude/linux/firmware/samsung/exynos-acpm-protocol.h
> index f628bf1862c25fa018a2fe5e7e123bf05c5254b9..e41055316bb578bb8250a1b11=
77f1059eeeb2611 100644
> --- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
> +++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
> @@ -13,6 +13,15 @@
> =C2=A0struct acpm_handle;
> =C2=A0struct device_node;
> =C2=A0
> +struct acpm_dvfs_ops {
> +	int (*set_rate)(const struct acpm_handle *handle,
> +			unsigned int acpm_chan_id, unsigned int clk_id,
> +			unsigned long rate);
> +	unsigned long (*get_rate)(const struct acpm_handle *handle,
> +				=C2=A0 unsigned int acpm_chan_id,
> +				=C2=A0 unsigned int clk_id, u32 dbg_val);

Everything seems self-explanatory except this dbg_val. What are API users m=
eant
to put there? Maybe some kerneldoc could explain it?

Cheers,
Andre'

