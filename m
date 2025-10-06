Return-Path: <linux-kernel+bounces-842958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5CBBE0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56A53BA82A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6827FD56;
	Mon,  6 Oct 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9+U7GdH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2425783B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754475; cv=none; b=CFgTEQCBWdFWbIBBEGwYGD2dwiZArwkMB5wpPRulTT8DQvCVAgRT5QnQlXsuxPo6MdcP0gUIKlLJdoqpS6JQaHtb0sdYCO0SP0mUrBR4TAqJkAi8MTD5gIQr8w7Wvb2/NhbIxrvaY4Scm8Q9oMhBfnXGgn2Ioqrg3cBE3LvO5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754475; c=relaxed/simple;
	bh=1q+VIFZwiIkYLeXafY/FJdneXiBfYWG4ku3gvwDgztM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1++6CYNKjE+7/Gw+iWcALla8ykfZGzeu6hEWHm8bu71KmNjxnvKzijAPkIx52YIOaZlVV2xadYs3e1QVJKkNcBAboCEexR/w5ZzI5NaWHUxnJ50j6IXIV9486/rq1n5pdyQ2JRBeZ4hDEwqIYgfKsPp7hjIs+X4Y15TGs0AeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9+U7GdH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-271d1305ad7so73704995ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759754471; x=1760359271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1q+VIFZwiIkYLeXafY/FJdneXiBfYWG4ku3gvwDgztM=;
        b=Y9+U7GdHVxlxRcbLWgxFnJhZWjv0WuHwhBR1aJ5YyAcHU6lgYg8sy45faBEexJm6LT
         Sq99XY3WqRecXZ55MDt/PYIGkKgEzUkq3eluEd2aHRDCfzQrXhuKRaIsCJqx7jnAGe8d
         temHYUkj6XZ/Ix9bzJaaeY973feecNInSJ/4icGgRlx9UocHnrfQIpPaaE5Fedtbhqgj
         fZDp2hEvSaddKWIF3PJo4xFI3eJvt67d/BQM0w+HVmxGkpjQqlqGsSDt6pOieypeVleV
         F6bgM+8BlasNmovR2EZPlTgSx3s8qr8GWVQH+z4SJYkxijDRw+9A1kuz9y9F9F0btEVn
         qK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759754471; x=1760359271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q+VIFZwiIkYLeXafY/FJdneXiBfYWG4ku3gvwDgztM=;
        b=A9l3qQomesp//Ry7slGmZfFPHPb/74KX0uDGuItw5KUh0lcN+nDbFCwJ+NxlSPP+d/
         1q88wznXNPhFM/cmlwNVsLJUnS+bHv2UiGn7a14kmS/NKPrC+X9kKbpiikWK49x0mWee
         /Duu5EzD1SYj0TLWEsBLCH5oTEajEPe9y9KUTgnb+1tfJKxPOQooJoM159vo2oLfJR7Y
         HyIxDZ/kKrP/fZhvO8l1ajm3YxyRscbCVVVFGzUyrObVP44ilh8z8ECLKOZ622uyLyFF
         TlNuGaUQ21bv5Ajy6+9FjcHXhCeE4g21GZWdsxJ6GDpe3cyarJjkJQ25/1KsvLK5TnID
         wC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjE9vtVOITkAxYS5Ls/4EkEn1rOgSO7NJ2Zx4+s8JztVLT8Lkgsh2AdeMW1gcoi3vPJ/XFuZ4Q8T7nLwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylVJklBBBMz5NVYAlyZrnQcTD/wK2YIILRYRTd//8UbQPVEG0Y
	s1vTJZ37nK8fNZsTAyG60n4v3Bt4saolNN9MFa/Bln7PmWQ4VSek4Zt+rDvEnF7MU+FZ/4gN1ia
	cEPUPATN101RZ+MaHBkUtd7umCRJS2qZVyjrtHE42Kw==
X-Gm-Gg: ASbGncuibk1w/tu+cXvPv/6zZftxmEhTVvUT3PD/BIGuEw9xYmoZxD3IbGTP42e/0cz
	kWMPt+Gm96VwrH2GsLRL97KZUGeP8wj8NEtQYZWnGmoQrKmvJrUqPMxPRgXVSVfOacJ6x7hhmcT
	gGk7m6tq1kjWkMu3yYRL+TOWZ+PVusrsAxRoIL9EhoWgwc2UDULjoG8mOMdohbXac+oLuriJU2u
	pis+GB1NwDg0RMXcApT4+T/b092rwIJeITqaeheRAIVxe5TG7h5AyITQOT9CQPem2c2z3LmjISW
	mmq1rsVAwcR6fvijxeIvqqe+
X-Google-Smtp-Source: AGHT+IGsLKBTasVAqEZ4v4KXBEfDfTM9A9ENdzksSzZ7BVLlJItKpXfKx4hZJPWcb6hfrOA5/IrXwYs5mVLZOS99Jts=
X-Received: by 2002:a17:903:238a:b0:28e:873d:91 with SMTP id
 d9443c01a7336-28e9a6563f0mr137927955ad.29.1759754471396; Mon, 06 Oct 2025
 05:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
In-Reply-To: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 18:11:00 +0530
X-Gm-Features: AS18NWASLNw80j6ptJPPHIfrc8HYOqH-1LzEniT9J7aBBeWXoMD5tLZ1N6aS2Wg
Message-ID: <CA+G9fYsTz6WTetGeWn=NX0fyX_j6qRR9XA_ETmJiYWDfCwyHWg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix DMA mask handling
To: Guodong Xu <guodong@riscstar.com>
Cc: Vinod Koul <vkoul@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yixun Lan <dlan@gentoo.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, elder@riscstar.com, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 19:57, Guodong Xu <guodong@riscstar.com> wrote:
>
> The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
> was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
> of declaring the hardware's fixed addressing capability. A cleaner and
> more correct approach is to define the mask directly based on the hardware
> limitations.
>
> The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
> datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
> all of which are 32-bit systems.
>
> This patch simplifies the driver's logic by replacing the 'u64 dma_mask'
> field with a simpler 'u32 dma_width' to store the addressing capability
> in bits. The complex if/else block in probe() is then replaced with a
> single, clear call to dma_set_mask_and_coherent(). This sets a fixed
> 32-bit DMA mask for "marvell,pdma-1.0" and a 64-bit mask for
> "spacemit,k1-pdma," matching each device's hardware capabilities.
>
> Finally, this change also works around a specific build error encountered
> with clang-20 on x86_64 allyesconfig. The shift-count-overflow error is
> caused by a known clang compiler issue where the DMA_BIT_MASK(n) macro's
> ternary operator is not correctly evaluated in static initializers. By
> moving the macro's evaluation into the probe() function, the driver avoids
> this compiler bug.
>
> Fixes: 5cfe585d8624 ("dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Patch applied on top of Linux next-20251003 tag and build test pass.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh

