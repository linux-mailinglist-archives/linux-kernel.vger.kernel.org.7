Return-Path: <linux-kernel+bounces-889168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85409C3CDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016051883FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7034C98F;
	Thu,  6 Nov 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cT49hAf9"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C933254A6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450454; cv=none; b=pso3uFVaDS1s/1p5Pqc609UKeucka6zPQcLGhmdOnIT7SSQ1wYUZdkRsGyuwbIn4S6ipHaadLpVJlayJ5q1S/5S4W0timSKrHsXiA7h8VF/DJ9bdtl0XvcE518sJQZwsN2yQz8ojfGMoY9mn0KB8xDD8oV+PJ8RCpeel0TecxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450454; c=relaxed/simple;
	bh=xC5jpduGSYvNExHOxUniHoKwme79jjzk7c0JLPQ4BHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scl4Qa/8b9xfv1His1QxgfmrwxYKyxLwTI21vFhj27lDNqLiHNb2LjNS4xb2jZD4PQLjXfA9H85A1OgN/Y4nDEBtSG4ykcU+WQVuH3YmqNzULBAdJ5cNnNnwIAv87YEesAolYYZen2883Upou2bgOE7nffFMY34CkbykrRQqsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cT49hAf9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1589247a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762450450; x=1763055250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVFA7b5QNQKKgbY4Sgbk0fAZQJ8jQ8t0W8uUVANJyQ0=;
        b=cT49hAf9OsKChazElePsEHJdxLafiAKnO3sIjrgG2uAZ6zG0QHHn2dceIli1N6jOxY
         AhyqskzfAUTwWzLb6iEcjpvwCevjyaaGcVBEgTIyzVjDQCjOWYoKr5VsyUvf8TM7qPKk
         9SzeRIzoFqqy9jh1VM9mOsVLtBT16iObKdEJdqClkcGPMhE71Y4Rpi8vvmZe6T78F1A5
         Gwi21+LYrextTTugG+qIZkcfLlJQoNrUExdsDFOuF2HWiV6zeQn/tDZTDRcnTHFwfgLp
         vSnHhpjLG02FgdJYnWYDuzhNyVL/b+/2SLf0INoX+exTOOR3ChpuNucRIzJ6UG/QS04j
         tI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450450; x=1763055250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVFA7b5QNQKKgbY4Sgbk0fAZQJ8jQ8t0W8uUVANJyQ0=;
        b=GqCuVtEdV5LkG2/zlEDMR5lXdZXV9TkDh17YaJHE2gHs7uQdPgM+WpP/iwc3iRHQ5q
         DHCZBx00FlCdtE1rbSA/cM98jvbD3BPTmyVZmGIQcy4urtXhpliAaWYKOleOPEroyGI+
         mLXHUQ1IccTs65n1HAsuNkokytYUCE6p2YURgixvBx0NB+4b9EJNdpOySgaOaIbgVW/i
         Lf0usnZnlbKH5pDvbuM5vZc6iQl+9y/1/YWVt7A9EjM/HLcXK080um0dldibDhI0r3hC
         bmd6SqJV2p3JkJFsddo/ZGLU5VTkgIV/Q863Wug1j7LNBDaI9BWvIc18Ydx8PXWl/cr1
         jHHw==
X-Forwarded-Encrypted: i=1; AJvYcCVHdzP3s2TY/ZIiBINyJFjIkdDEpNykqn4TgRGcNDHQYjZErAH3HSieWejjEw2d31Iij43eGOGeaInsikQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRs5LePM5jno7IRrkLiecCINkPFFezavCipySEq2XFwVgL330
	9lw8ntg9EVT9sO8nn2xRUOIokwPPZgh6ob7HydqLsffQ/AksUBqJGR5x9qQEmpTfEqBfdUbnVMm
	2sEWT2AOew27RI66SzUIoaMnZK3q2wTJecfQIaaRqRg==
X-Gm-Gg: ASbGncv1NdiMn+f2AKoLtiEatMYCf75Ka6n5kGd9qk1kY6g0qJNWP6envEI+CoyNZtd
	lKunT2RPgeiXcLkMHg8fGGvoeDBptDs7Hbc0SnOgLm4DJzveI6g4VMZEUUJJZp26/8IRljGgvch
	oZq+D4cjiwrP/YpXv45MO7/3ZCR3ri5ndunVr9EKRRBRMx8VR3TQiEzIpNIjawXlP9ReoqIYXaK
	8cJXjua0nBHiyUnj/psbq5UN6cewr1bBy46ojQy3l9AaIFvN/MOe7afn6pYSg==
X-Google-Smtp-Source: AGHT+IHa3dttDqTITgV3tGTkp6TSuSmsFY+1K88280Yqh8YjVvfMj6OJH0DKtk3h1bhQap8rFtBGhpjoLqExb/O6Ijo=
X-Received: by 2002:a05:6402:35c3:b0:641:3090:cba3 with SMTP id
 4fb4d7f45d1cf-6413f094b4amr145941a12.37.1762450450078; Thu, 06 Nov 2025
 09:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022174309.1180931-4-vincent.guittot@linaro.org> <20251106172312.GA1931285@bhelgaas>
In-Reply-To: <20251106172312.GA1931285@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 18:33:58 +0100
X-Gm-Features: AWmQ_bnxeRp9L3wzoigXubjMbIkUdPeZ-SXfzJV0HZAKsvwmODUh-S8pANI5ZcY
Message-ID: <CAKfTPtDn8r-YfgspLscd=4oE0GukFg6tORpsUqd7fUs7DJqnLA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 18:23, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
>
> > +config PCIE_NXP_S32G
> > +     tristate "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || COMPILE_TEST
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on DesignWare IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCIE_S32G must be selected.
>
> Did you mean PCIE_NXP_S32G here?
>
> PCIE_S32G itself doesn't appear in this series.

Yes I failed to rename this one.

