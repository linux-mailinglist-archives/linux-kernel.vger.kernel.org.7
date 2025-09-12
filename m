Return-Path: <linux-kernel+bounces-814330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D2B55282
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F816AA452E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A53128D1;
	Fri, 12 Sep 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXURIzoL"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CD311C03
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689127; cv=none; b=enWGGtb/kr+Ad6MJkHYEfUJI8Twfkl3slClGm7ldR639RmBJRqkhum4ERLHjWiu6qQE2vhbf1+L3+F8zaDkten/UgtNHcxzD907Fr4OVn7/IaOt3ygzgNYvEsAUhmUnYTAoMSneXK9+U48l+yoOKSBbnQOu/iuoPN1JdxfNkqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689127; c=relaxed/simple;
	bh=28JpikhNh6hlI5zzwVP1Kei7jvxlx3xsZ1bRu7uJFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrQ/vflQvQRddUedZhDq4LRfA7HrsVnZhtTQdk0zssj0BJh/m7ze4aaTfFhw/uZUXQxw4T7U7g4uKTUvyL10Y2SCAw81AUPLFZ+p8SxwaicsCin2sfwLG7YIsUude3uKjt8qObtcpLVbhpB5Ouw60MHpGfjW5oZqjYkG83QqUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXURIzoL; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30cce872d9cso1505145fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689124; x=1758293924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28JpikhNh6hlI5zzwVP1Kei7jvxlx3xsZ1bRu7uJFZI=;
        b=vXURIzoL6WOeHy68epWap3ErmNrC29xtLmfmt/5OszeFvCcBTXd9+e7funIXOiH1WE
         jQUlydwxAqRRUSzjNPsX5gHuXQRClfjIzGBhA1yVFh8Wx4E/I2eHgAZNB8gnsJJlJLrg
         qpBiAAef9FKGxqxnPsIVZKvBhTOvvs8z3RgusIBTBMpSwtYTpf/8kKvzhTrifkGV7O4p
         9AHcCNNXS6KaIAkWvORPqfSTlRn1bEMfa6TjjUBZgHMd6weNK2Z3E1BXVucskAbhRmzp
         vShp0Ug9U0wvKqbVBEcUFK5PfpEtk3+tUyoDXK1MFVj+zJWQSu9R6TfhZ1BRbhdWdqog
         wv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689124; x=1758293924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28JpikhNh6hlI5zzwVP1Kei7jvxlx3xsZ1bRu7uJFZI=;
        b=LY3YzBvFQF93Sqa9aVrqt+G8o+5FPVw3nKxEKJPFXBCgsOGB5kFWZAkNc4S7U98cd0
         heRdmV7CV/AkJr9wvpdUI/E9kOln5xX8yNlKmNgWJkhj8ipkRFx7iKpp/zyNtj8+w0J/
         Qjiv6O+Tb/KAEkE4yzY7BPcDYaCRXP/usQQs7Ncmgdhb5Enr25FBLX8tVvS8nrpmtTq1
         6LSyuLjunu+sDwWiOy7vH4WDnGbjT8uC2Lj4XgxZ5HNkNkx6EF/2sWQaCRfGeybXRWD3
         aOP6o3JV2zkW2RHsuhNrCUlMT93aJC4qQNWHFym4JFIpFsyDPYboBD20e0YsmZ04RMzJ
         mleg==
X-Forwarded-Encrypted: i=1; AJvYcCU870kDzJHbDPcvhYUUBceh1WBYaFqIWZq2ok/TLYWBsor61nlpjR/bvEwwbGGL+/70xefe0WwZUgCvyG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+4psApSkiU8AvwBZNOAP75ui5vjKGUM4QD0hGOCp+3ZV5N2K
	KmE6T53KnbyH7NzdoiuAZpH3wSICUC6uMIoTwSFeBYDWO/eadPIJsvZo4CqwZKv8KTbIMbkeaxU
	zswsq5Nx0IEQXGxCtft8Fu1MfLsfz6D8Ki4bvBxzX2A==
X-Gm-Gg: ASbGncup5sV75vFWniBFwNVYVWODoxEHlw0eFO1HVHoyGziLYMVd7IWROK+EMhV2ASc
	EhP+Jjapp7Ghuq4s8kKQLG76VSRSR52valInGWY/9CqEkyjr3O7vQ2DQ+eq8fiQHXIscjJ4o0vl
	Abb2EIaDPqgdKmPFkUAl5j2uRU1LhxdzHQCXVgadNMOVpLQRDJ3j7s0aBi3vapbftnaed8AKnSU
	mPhuO6GSQR/BI91yQ==
X-Google-Smtp-Source: AGHT+IHAJ42BGc4DV3+A7HRXSgNpI4Ckz1R2zEcxWqCWvdlWoM2kBfvVDgKpueHQzqgzBraygif8YB0P1rDNI9gE4qo=
X-Received: by 2002:a05:6870:b907:b0:315:3ef4:eecd with SMTP id
 586e51a60fabf-32e553a280fmr1618278fac.17.1757689123738; Fri, 12 Sep 2025
 07:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
In-Reply-To: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 15:58:32 +0100
X-Gm-Features: Ac12FXwxoqn3zsYfC0T8IDf20S9zDpzsxcpDfKlZfpZdk1czNZgS3-vJNTlzLBQ
Message-ID: <CADrjBPo8L=P2bHKTFvYOj7i0u6pA7vs32d3y+4Ho+82Z1mRE_Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] exynos-acpm: add DVFS protocol and clock driver
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	willmcvicker@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 14:13, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Dependencies description:
> All patches should go through the Samsung SoC tree.
> The acpm-clk driver (#4) depends on the ACPM DVFS ops (#2).
> If the clock subsystem needs to merge the new clock driver, it will
> need an immutable tag with the 2 patches.
> No dependecies for #1, #3, #5.
>
> The Alive CLock and Power Manager (ACPM) firmware exposes clocks that
> are variable and index based. These clocks don't provide an entire range
> of values between the limits but only discrete points within the range.
> The firmware also manages the voltage scaling appropriately with the
> clock scaling. Make the ACPM node a clock provider.
>
> Add support for the ACPM DVFS protocol. It translates clock frequency
> requests to messages that can be interpreted by the ACPM firmware.
> Add an ACPM clock driver to model the clocks exposed by the ACPM firmware.
>
> Thanks,
> ta
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole

