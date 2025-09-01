Return-Path: <linux-kernel+bounces-794669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A91B3E504
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACED2000A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB3198A11;
	Mon,  1 Sep 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Icl8e9Vo"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208915C0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733469; cv=none; b=QY4lRKxlfjSiuMk6wI7gd7ErMpfrUj8//XxF5XQbB2MRAkQXtYdMoEibA32wLQwdux3jSgImGhEjRCnPounjCMiSOtHMola/9KTGDMkuPI2ihob6BgA4pP/+XeWds90Lst/47xdj0jNDdj/qUSgobvctxBnMe5CVzq95IEoojas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733469; c=relaxed/simple;
	bh=lCpYxwNZ0fd3/4JdB2UP6w7/TzeFfxBQeM/QCFqRP3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCKmD9K6TwZoqzVk8v+4kxhvTfPJeTncY6ZUNoK7T41gR4lAqyBzTwr+YHUsK97uecB1xZiit7IHB0FZn5l0ugXnk+uvtddsBD2HK1gPUFRdHLHJGWiBmwBd9gFFr93B3dT8zxsDfCa60ek0imXB7MbXtyVRdRSIwgrO3iHM99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Icl8e9Vo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e8706a55b3so13442385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756733467; x=1757338267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCDjZSgl76mrff4NwHQBbFuq61Q1zOmaA8xgmtQ4BxM=;
        b=Icl8e9Vo+CCN/HQsblT8Yxly/YK+mCbUaDsBQQjUzAAexLHAq8Ex7Gi9+SQfk96woo
         SyDiTYWOfclLgdO3amCVcIuEWTs9BoeB/0IEcjlGjyRZfM9ZIb79v83al0hXgSxZLmCo
         EtcqOsOkY5wVS/WA7ERT4Y2TmvZPUcgu1JuVwhPswGeOU8yc/2qI6dG2o7c1aj7c74N8
         FmSVqJmWCGBUVhytDEXI6rVzazGlrU22FsGJoJKWkvhFhA6OBdRkOXxBpnGISHBo4xUQ
         sl4R71ejjgQtG0nGqu1yV1vMLQBdi1m5twNnn4Lb0l2X8yW9vO+LDsAmp8RGP/tgyETk
         i2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733467; x=1757338267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCDjZSgl76mrff4NwHQBbFuq61Q1zOmaA8xgmtQ4BxM=;
        b=whlChrqoWJwGE5CmsKm4CJNDkDm6niW8PQ6xTIy+z1i0Gxsv5XNY9/V7asuvGUV07c
         fSM9pSJ2bT1Gi7ui1jIBgTaaRtvzxykOusF4lM+o9OjG6BZKORcOTMl6DzcjH4YLPp4a
         Cp0+uPAk9M0L3JjIMGh8MB1cW0FgqpDm7+1eOgimyKuxPdMfNiB8EDOpdyqtdE6DdLX1
         BaKVUAFooMR8OKEAQBJbpZEnvSjm1ElUH3ShoTVQYfHrZc4eVsSJoqyeZ+uq9q3IPXiS
         u4Xs8hFj9NQWb15e357+/QTjwW/YXqwy7P/xOU/qtms027VUCC5p38qc7cZc3eIPKs9E
         iS4g==
X-Forwarded-Encrypted: i=1; AJvYcCU8y16L/RXUJ8eyfc0R9lH0y06J6EmAI8Ur6uQgzdH/AnTLWd7RdLSegVuI6ZlrX7Cg8RTngKo6QFElvvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2VZq0XrFXiXdA4F8JiyWFg0jpwt2781AkPUX+ztisIINo33l
	fqyNY+m+cuNQ0VYMw7+YaFjltLnFC0QAURo9TXT5LcKR7tMf38qSBDDdJs6UsFHPOOrhP2k1QHR
	+BTn4ZyJtPAGEf7uUM64Sw8ZdeQzJYpWcBEulfQzzcA==
X-Gm-Gg: ASbGncsRPRGsefipIgAHYqekGPS2rgKUNVf7MvdO4q4CinkhkdrQ/t+Dy6kTD0bbPHi
	SDoWNkU0ACbO9PTubFczwnB0S3fh81aHC1sQOzWqq1hxNq8wzxMNmq0aNNu2aaTCTffWFQIwBhO
	dow/pUG/0MORG6Noclzii4xJjzgNvsjVSjWuDfbJAkl5YLE9HNNuS0RhbA0Dn3udCEj7C5c8CDy
	Ntjg/+hm4cF2VkEH9nYT6KkKYU=
X-Google-Smtp-Source: AGHT+IErB4PfzzopI14tCGiVeZs7a9//buOSDYOobMbsVWlDMHk7o0uJw941KlS7WlEBD+FlW1zvW/7hPA+tGMwbVWE=
X-Received: by 2002:a05:620a:4495:b0:7e8:5bb:b393 with SMTP id
 af79cd13be357-7fd808341d0mr758728985a.4.1756733466773; Mon, 01 Sep 2025
 06:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827230943.17829-1-inochiama@gmail.com>
In-Reply-To: <20250827230943.17829-1-inochiama@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 1 Sep 2025 15:30:55 +0200
X-Gm-Features: Ac12FXyONJJHG25VQtRqcoXABg35o0Wz0jSFgjK27pZDOrhzFTzQjZ7eUFY1fUI
Message-ID: <CADYN=9K7317Pte=dp7Q7HOhfLMMDAfRGcmaWCfvOtCLZ00uC+g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Chen Wang <unicorn_wang@outlook.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Nathan Chancellor <nathan@kernel.org>, Wei Fang <wei.fang@nxp.com>, 
	Jon Hunter <jonathanh@nvidia.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 01:10, Inochi Amaoto <inochiama@gmail.com> wrote:
>
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_template will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
>
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
>
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Any updates on this?  It pretty much breaks testing on linux-next for ARM.

Cheers,
Anders

