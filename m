Return-Path: <linux-kernel+bounces-842608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D30BBD251
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DB3B3A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1241424E4C6;
	Mon,  6 Oct 2025 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnFq2d8f"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5831547EE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732608; cv=none; b=hFrOrBC7kX1baIVI/LXL64gfJJbUR533EPWQDgcL2SYsru79tCr8AsB2y9oX+AmFnkVkI1O7pxZJSmIGBAq+DaPVL4u6TSFfzIUDprVOAGp/vAHPgdtPjdq4LG1y0ziDJTO04NGvDQHaCQ0VpSzcffEU97JwT7F5hGp9e0VQweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732608; c=relaxed/simple;
	bh=v7EGOt8ZLtCdYqfpKtBHBaHqHtPw4J2BV/cWIZdOPiM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aU+vYZYi1wfAr8ktyqbSoQ27jxT+a7j+x3KJBtw4XsKyIYFWvO7WfIoL4Y2PTGMW+MskehHn5d8lioC8PhneOHnhHgGRJTXyQ5+qxhkWVFUtZZMe0Nc46u8CaLRJszyBY0in8UBcrE4Mvz+BgKTA8ugb2BKv2YCXZSIfw2slhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnFq2d8f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso844701766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759732605; x=1760337405; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzTTmtIJjh3pMYClCRnAXuDxLMNpIfi6xb344NjPp7s=;
        b=qnFq2d8fz4ITnwUhUM3R2/ujVED4JHngHZSmUSq7tlvbzWUftfJcwSWdxue60KCD7v
         nKAAX4EIJRyiUQEYMh+71iPBWxnVj/EJhGfmngPe952eSTwvhwODkjsW3FGJ0SMA9eap
         PTs+MDPMTLIHMSL/GrNyrRE/GOeRXFHg5EfgslWUtfrR7VVCt64X9BHZUYewtRIE4MgT
         oE/L2x1CXuZZfoIifWSCtxAhQ1xNS1bqB0cyDnVLKS98wdt+OGg++odVkCpfTw6c5JDw
         G45IWXkj/Vq5aooevvEPqHoKM/bt/G7dMSDccl31xqWGOQbqGnuEfnzQM0qteTpnyEDa
         lZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732605; x=1760337405;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzTTmtIJjh3pMYClCRnAXuDxLMNpIfi6xb344NjPp7s=;
        b=K/847jicwkaAB0H4ErfcLGAL8x3s+EVI7SoUTnXwpiEWZSLaFie8qQapJbtZOLcswB
         t2U/fXe+hHbZNV6SVQO802bY1uC5iqr8ieaFYJOu7o0WoL4D6pIFTP6LLk6Z6iFz7A/u
         9NIwlhNSL0J9ltS4Ler/P/kRymhHZU74vCGWQ4pSdl1qp+cHNaLEhMOWiTsItgXdI/c0
         +YuXfnLYNSe82OSRNg/CuqKgB3RNyj4Lz4PDxtYy/6apH7GFpnWhk7hjSogWx3WuaIoo
         RfGX7K/2U8E3t+sewSLKtU2LINAepUGI2kEGOwV3QHbPqofh8C2w+NaZqIOKYt+2dGqc
         39FA==
X-Forwarded-Encrypted: i=1; AJvYcCU5eyhzV2Raf7qcP2xJwJ628ODbe+eCH2tIGmz/IlhSF4YIVuHhNp2z/qdjJ+pbyL2Pwnz+KXmvi1LxA4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzaYgfOcL9pX4fcomdJpTI10wS6UjcQZwnXFPwvWIRwLnfMx/
	QQlJuNZixEZ5tiPT4gyND3qT/5W9M1pQMj2CUUq4SMnGMx87BDI5dj2f40ZKWIeQ5dw=
X-Gm-Gg: ASbGncsn5LPI32Zdk7Lg6hZy0kyvbr+mnxtI3nDL9AU9tsF+duZxOgnMez2+gB5m+nE
	iwWUSV6vasj9ra2GrfxaLAhN5o6c4fxZlB1Fa5/F4FYCHhGHLFokTRA+yJ4D7lNdxyYjJ5TQM3y
	mmU42FSTlRZBO80iBU4lIzfAzr4uocXFL+/7nW5HKa+q7ACladtn28WJfm+YKYBrHhB0npGG0xs
	j3d0eLollle2ooTUb2ZVENHi5EAFvvyTrmyRdRqWKRio6i+NcBgS1e7BwNtZWveol/XUMIk+3Iy
	wv9qKo6ZSSx+O1tUjr52wvIgR0YCBAOPAbOLwtTYSFZlI8xJ/4CdVC+bmj0LoMTxwYnQymngIJW
	x2MCh5Sup9wTcsNpqcFQLuqTPfJiffg1MYMVvGjL3hAkESe/ynxxqevrMekZl4lXf
X-Google-Smtp-Source: AGHT+IG80rNfNGj9kfBjq93mBxn3Pfh0reoh1uDQlKY6AnzLdS10YY2DqrfDOY/hXPnRQXKaKWtLjQ==
X-Received: by 2002:a17:907:3da0:b0:b41:4e72:309f with SMTP id a640c23a62f3a-b49c393b428mr1271205966b.50.1759732604856;
        Sun, 05 Oct 2025 23:36:44 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865986a9dsm1090613166b.21.2025.10.05.23.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:36:44 -0700 (PDT)
Message-ID: <a09b6b493b41bff39000df61dd14693af8b0f053.camel@linaro.org>
Subject: Re: [PATCH 0/3] soc: samsung: exynos-pmu: gs101: avoid SError for
 inaccessible registers
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Peter Griffin <peter.griffin@linaro.org>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Will McVicker	
 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 07:36:43 +0100
In-Reply-To: <CAPLW+4kAzXmd7mv279wMJCT0gVP5A+2Xe0q3MgX1OENH5PC2dQ@mail.gmail.com>
References: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
	 <CAPLW+4kAzXmd7mv279wMJCT0gVP5A+2Xe0q3MgX1OENH5PC2dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sam,

On Fri, 2025-10-03 at 11:59 -0500, Sam Protsenko wrote:
> Hi Andre,
>=20
> On Thu, Oct 2, 2025 at 5:33=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
> >=20
> > Accessing non-existent PMU registers causes an SError, halting the
> > system and rendering it unuseable.
> >=20
>=20
> I wonder if this issue you describe here is similar to what I'm seeing
> on E850-96. When I'm trying to read these files
>=20
> =C2=A0=C2=A0=C2=A0 /sys/kernel/debug/regmap/dummy-syscon@0x00000000100200=
00/registers
> =C2=A0=C2=A0=C2=A0 /sys/kernel/debug/regmap/dummy-chipid@0x00000000100000=
00/registers
> =C2=A0=C2=A0=C2=A0 /sys/kernel/debug/regmap/dummy-system-controller@0x000=
0000011860000/registers
>=20
> I'm seeing "synchronous external abort" during regmap operations
> (judging from the backtrace). Do you think this series fixes the same
> issue on gs101?

Yes, but for the system controller (PMU) only.

On E850, it appears to be the same and there are many holes in the PMU memo=
ry
range. You can confirm using debugfs by manually skipping invalid ones, e.g=
.

dd if=3D/sys/kernel/debug/regmap/dummy-system-controller@0x0000000011860000=
/registers \
   ibs=3D15 count=3D1 \
   skip=3D$(( 0x28 / 4 ))

should give you register 0x28 without SError.

while

dd if=3D/sys/kernel/debug/regmap/dummy-system-controller@0x0000000011860000=
/registers \
   ibs=3D15 count=3D1 \
   skip=3D$(( 0x4 / 4 ))

should crash.

>  If so, I'd probably want to adapt it for Exynos850
> later.

+1. Note though that a custom regmap is used on gs101 for the PMU in the fi=
rst place.


Cheers,
Andre'


>=20

