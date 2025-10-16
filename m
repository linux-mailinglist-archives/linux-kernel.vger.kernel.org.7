Return-Path: <linux-kernel+bounces-855731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1CBE2228
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BB0581090
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD0304BBA;
	Thu, 16 Oct 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUqcMiOp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A4303C8D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603024; cv=none; b=dGBgMXFQg0yXfkcgfx+ZcZVXAw0ZKMEwCJ8U7LJa25lVkqr3+b0lmX9yfrSu8Q0D+HWeuNOerGB3E2R0dt8/CyAS/IXjMOHXeHPCo1+Bw4dAO/KuK28IsjwoLRR0aq6sjuGOPmmPX315dn+ZFUODhXmgRRztGqj/0XymKyiHeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603024; c=relaxed/simple;
	bh=zbBU1GRxOkLD2pr5cIJcjpIKGOaE5sykVLD2xdcq+os=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csXPhC3vP8d3JoSuOCzSQrDx9nHyWeb7PTEa0PgV6+7W6GT4SEhVsI9F1exvzxWMNVk4Xb1zClPbTBQtKh59Ew7B2Hiyv8jUBSEegdRaP4OBT2Ub0wm7wvaTZBdBWdhOUvxBqWDgHK1TTKQeICLVZa4Y7yG9UE5dWulunU8mMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUqcMiOp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso613678a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760603021; x=1761207821; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbBU1GRxOkLD2pr5cIJcjpIKGOaE5sykVLD2xdcq+os=;
        b=pUqcMiOpen1dP2tO/C1PaT5vDhHChyax9i750TmMzYSo6zLf5D3o4RvAdLhGXwcXwf
         vnp4AiFfpumaIyXxfEp2SNr0fD7MWKma8BU3EenDAz2h3FaYLIWBBprjiOGFJfZt3np9
         QEA5gUIvsrpdYyVfZX6fAzHtSeKhQXFD1gZWVZ9OgsGFNYu/qU2RP1QmzpeMKTdbVw2W
         nuWvtiPl4efZKHmHvF6vIFP1q/dogIMugjtqubsh6+xG8oU2rlGj8ZuXvVdV9yMtZ+Fz
         m3iyfs+Pl3Ynfo6BDizDs1RriVQiJ4ZzU6TGZatnZxRkfXgegBpZTJvTinxXtgrWAhbZ
         Mnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603021; x=1761207821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbBU1GRxOkLD2pr5cIJcjpIKGOaE5sykVLD2xdcq+os=;
        b=CYSUH7plGDPEfrlV/a6I6rB6oahG6VkC4v3NFgXLFz0XVG5IJQkK6lGF7iCdM1OJAz
         4Wnav7SviJ5kS6QgBF5535ouGifOZX4AyYD0ST8Kk/+JpspbPd9gdNTAJx/uV/SaRpe8
         T9oOOHcvN9k1nlKO9f6Qvn9pljN7lhL0bhJq0j5awe3K34I5/u9NANjAxrqmonUrgoE+
         6Z3sZtrvMIdJ8sX9HWBKeehnkH0RakB09HofuaYo8TAdq1dxG1kEmcGSds7PixsumY2F
         RZ86jbGt6S3+Vg+O51nNn7QgPBYZol7wRZpbJzhWPjLO7DIr7NbEravZOd7pSmnLOgL9
         ExFg==
X-Forwarded-Encrypted: i=1; AJvYcCUEEZ8maLX+aT/mE19vIL1ypJAOt34Pd/AO6QIP4bqDASoYZDKdP5f5PzpnqCCwzp179Sm/ngFaZ2TWyEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NrcqejrWoPrAVHv+/6irdQvLdjZ71s8CwpoCSxIvKcjOJ+zQ
	DbEqqneIN9/PXmaJkYR62UR54OEAxcAwdQKz0X/Sh3ivxCpjb4PqIgyc4ElkS+tMDKk=
X-Gm-Gg: ASbGnctR/xcCIzhv2jmt7qgd+BPpiYJrrz/yiSM1SkSNYIv3pGT2hhLBoDFFNQUszd5
	gXn9A3gvAenkJyWZvHg40tji9jFeUiRV1V3f2jhr1hItCnwcYEgYYe4qc98fbUCznbwjYjdFiUi
	1sEEv5HM/pwfHqg6LDLjb+Hkxn8fCYR6c6yQ1G5006B2fAJzTPfpFxnHudYyG+aFiFdjkJJk2Mj
	2eqjIjidr5KdDo4mzMwFc/jsaumC+yMr5GXjNDsyPmExGFErCw8hMXHhds7PbjVoZU0uGKED5ba
	8MFQWiX74r1iWlXhFV8oM/MqdvYSQw8nHQmnDH9iGcuLWgg5BSpIjc2sdtOvDUt4w7r1GRuoaUF
	nKKtRgIaW5QjWvrHX3Vz2xF/52I1H1DceOjPK+pAd12eow7B23jHn3O8ZfXlGxDf0jaq29RghYw
	ZTcDvDBkE=
X-Google-Smtp-Source: AGHT+IHxUnUcoHUcFtyP0SeT8nrAVOhELQzl+mJmkJlg9L09uwKru3NwHd6GyQw68Ab0pvVWTAq0+w==
X-Received: by 2002:a05:6402:26d2:b0:63b:f909:df50 with SMTP id 4fb4d7f45d1cf-63bf909e210mr4148941a12.14.1760603020784;
        Thu, 16 Oct 2025 01:23:40 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b7144esm15099610a12.23.2025.10.16.01.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:23:40 -0700 (PDT)
Message-ID: <17643995510406a50157a808ee4191488f24f97f.camel@linaro.org>
Subject: Re: [PATCH 5/9] arm64: dts: exynos: gs101: fix sysreg_apm reg
 property
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar	 <alim.akhtar@samsung.com>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sam Protsenko	
 <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, Krzysztof Kozlowski	
 <krzk@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, kernel-team@android.com
Date: Thu, 16 Oct 2025 09:23:39 +0100
In-Reply-To: <20251013-automatic-clocks-v1-5-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
	 <20251013-automatic-clocks-v1-5-72851ee00300@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 21:51 +0100, Peter Griffin wrote:
> Both the start address and size are incorrect for the apm_sysreg DT
> node. Update to match the TRM (rather than how it was defined downstream)=
.
>=20
> Fixes: ea89fdf24fd9 ("arm64: dts: exynos: google: Add initial Google gs10=
1 SoC support")
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

