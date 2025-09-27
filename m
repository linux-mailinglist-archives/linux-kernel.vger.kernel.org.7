Return-Path: <linux-kernel+bounces-834817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD0BA5965
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD9DE4E01F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA919242D8A;
	Sat, 27 Sep 2025 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1EXZNqO"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58CF221F03
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758952232; cv=none; b=KhCVjCfSckNdPZJ4thR+gPdFPHC1ZP85H+xSy2Tu/+eP+yUxd+mbjZkIgu5ZeCF6HstSL6HUvLAHaiI0AAahC8Ms43+AMcpnl1h8IhiDydhQHQfJGg0emzAY3obD/RCoHTjFhQhnenJKHqY9Cr1dy3+Y2EQjkHnUf1oE/SgaNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758952232; c=relaxed/simple;
	bh=sKE/bbfJdVEWPyhD5eS+eTMe7Xb6pi5Gx0cFcMY2Gck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccmpEaJVq2ee07fe1Vf32oHDou8i1I9BL/5JkIEjj8GLZj7z5GVQFYVGhLN2ZL3jFe14jQKOzH03MqaYsEHDeSbO9yNrWrwmcNAzVCTIW6yi3fXdCndXgbEnsx4+IRp32pCSmoVt8aRzdzGMkDRI9d2WWaqdewMgVPh0uP2oH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1EXZNqO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so4286404a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758952228; x=1759557028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zEfXQ2GNoTNAAQgKz5N/9OLSNIZ34U7YEC6QsyWknEg=;
        b=C1EXZNqOGqAjlc2/v19KN8vFinsJ2thvgYqFZfWZy0htrCk49sb1b33pmZ5nQZiAFn
         mzaKvetFH+MZ+5ILtNOw+Y5JeU2FOmJdtKqWCTAIel9BFIzdkwqKcZM1iOwPHbIrgRN6
         zwq3MXIJlMBc6f/BhsAB2O66II+LBmm0tM6SlsmZ5CXlnD7IQqz4qU8G9LDejY9BVJ/J
         RprOs3xoe24e2jDi17tDTtOARAtsG4tUfimJKJrDmm9mpylMDhECqdGx4glncDnhA5+s
         cf9pMFmz+VkT72TrB7UBl0BqGYsB2hNQZb9jhvvWkCFgeZ+gt3Sdr7W9kFQJjirCEqil
         R10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758952228; x=1759557028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEfXQ2GNoTNAAQgKz5N/9OLSNIZ34U7YEC6QsyWknEg=;
        b=U9YnUvZosl3FeNU2ldRpi/5y0U4GR/So2NK9RSiz3L5n2y2KdxG/vA4L+WD7IvjqCq
         LTbhbbzY6EEf5Xou/ocJgCw6fDmSBTuomWAMTYj8sYBTo0DbezBZXG+2IZu/3nZh+iXo
         Vqz1+ltkSeRiZzSezkRqp1QNMJWgdV2ua1GXRXPQBexGEm1dxU2jKjoV0FI3MOK7fyuL
         O4ccB6dXfi34Ry0riAaGN1ES7jD5Si8xyWPU8/Ah2Ub/Q5qM+6ByEhzyep2LTJvisruh
         2xjPUjSZKvjmnj66TNVCmsenkJWfoIAmdSHWOhZatMZ05IJUDsC/qZQnN7gRFKq0YNUh
         zbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJGPRLk+d+5mbVtYgeLg0K3gMBZITS2m+se0BiWUKk4Os4iyoHi6OKlGxapm5Bpw8EK9fClLUUcQL6L5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRSlUkDNDEKhoCwxZZx1Ds+IYnlU6U+PInF4/Hr+ZQ6SwnJ0G
	+dZhFy8qVFcqygMuDjQBmbkwmztsWSkWmUVI6CPiAsZ9KRgoVCL54MtlFddddzMgUAVIVPuWjHM
	G6VqRsV+ExGqgPaPEMqOul5D8B2CjhBE=
X-Gm-Gg: ASbGncsuAs7BaX7jGH9+FOLlSbiJ8It3n+GYTxMtU7aTRySs72XVy2yYIwF5DMlJKMj
	WWr2QlJR1JrdxlourWHzzmYEvjAwxvN6N1ttrMsGCFUGj+M42JRhLyaU9Xzl3YypgybzyCoUVBL
	BcIF9j/K440k5VjUnsPfCOTTzCcRtaHBC6BbSY8f7NWjz8c/L4/igxxSIIbsrJGpbiXRoMu8quK
	Ub4K/JlO+E9bPJX
X-Google-Smtp-Source: AGHT+IHPM8Sokkajp1U+gg4rjWNklz+uhVuqd2/uPSxPNqSrop7fWSnbP+GYFsIWZgAeYS05o11hVS/32kiqXJYUOgk=
X-Received: by 2002:a17:907:9716:b0:b04:74d1:a561 with SMTP id
 a640c23a62f3a-b34b86a1164mr1228466666b.25.1758952228009; Fri, 26 Sep 2025
 22:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-3-linux.amoon@gmail.com> <aNbXdFPrDr8V2a+1@lizhi-Precision-Tower-5810>
In-Reply-To: <aNbXdFPrDr8V2a+1@lizhi-Precision-Tower-5810>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 27 Sep 2025 11:20:10 +0530
X-Gm-Features: AS18NWAnMv2xvEsD19fF_Ap9-aFut3prDdiovARFCjhoGCTCY1ku8kU0ydS2DCg
Message-ID: <CANAwSgT3inDQZ40uFtXwFze2m4hZUvnyKTek3PQ9jb6picgi-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Frank,

On Fri, 26 Sept 2025 at 23:42, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Sep 26, 2025 at 12:57:43PM +0530, Anand Moon wrote:
> > Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> > the clocks individually thereby making the driver complex to read.
> >
> > The driver can be simplified by using the clk_bulk*() APIs.
> >
> > Use:
> >   - devm_clk_bulk_get() API to acquire all the clocks
> >   - clk_bulk_prepare_enable() to prepare/enable clocks
> >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
> >
> > Following change also removes the legacy has_cml_clk flag and its associated
> > conditional logic. Instead, the driver now relies on the clock definitions from
> > the device tree to determine the correct clock sequencing.
> > This reduces hardcoded dependencies and improves the driver's maintainability.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v1: Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() with
> >       fix clks array.
>
> why not use devm_clk_bulk_get_all()?
>
My RFC used this devm_clk_bulk_get_all() which could work for all the SoC,
However, Jon recommended switching to named clocks, following the
approach used in .
but Jon suggested to use clock names as per dwmac-tegra.c driver.

[0] https://lore.kernel.org/linux-tegra/8fac00fe-2ad4-4202-a6f2-c5043f7343f9@nvidia.com/
> Frank

Thanks
-Anand

