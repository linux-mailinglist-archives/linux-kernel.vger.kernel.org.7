Return-Path: <linux-kernel+bounces-840196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516EBB3CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED753A5EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D430FC3B;
	Thu,  2 Oct 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2DMGCvs"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE42D8362
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405422; cv=none; b=mhiDazUfirIMemRZSC9bdQ7FiZlH22H1Ah9MIHH2rLFRFhH9MX2CeWR7FrMVwe2/K5bzBV+XqSJk91ZOA+l5VNgORDjkhvQUYADvBS25oV5ET75m7ibMsYPv5AdDFKSPXfTjI0RGvwLFEnyURlXUeNZVuLJjzuTae6uXuGqj6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405422; c=relaxed/simple;
	bh=mQfFH9dlJp1wY8DjH+FxPFbokocVbPKCKSkod2iQXeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZ1knNqsz0wRyIgEjM8hq1JJuqEw6I3EiLy41GEM0sBrPX6K81QkoxG2IuWMZafg/VymkPu04fZCdgZ4jGCpcqy3zECrjfkTUqqooFIvpKVIjQgkSfOq5rdvuwFp23Feh5Su6ip/bcJgc2SPfnkCaGIc4eNxbxHnod/CWs+M1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2DMGCvs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3349a142fd3so91059a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759405420; x=1760010220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPGwrtnmwO7ynHj83uEKbgoWVEyH11Eo31+uKIXnVKM=;
        b=c2DMGCvskVg1WNvg36gWoxlnKNn2hydXSi9XvCJsrYflp60ocIMwcVpJU7q6p2/6cv
         QVusEEzRjVpC1i/dDWT/QIpIpMi+G7RDYbhiAMOQg+DR9Uwyf82t1sVQ9XSzazUMqbKE
         b3jd30ljHa3THWNLwIC5yX3cy7J24AvSFeIRS2vg+SdVE5Y3CJybPdPKrupQ70X0RHAk
         ioLjMNOfWA6OYzbuoQty/51GgSOxU40La9CGWGQaqPptdRLCI7Kuc5l9jzNonm3cAFd0
         vgWxmFFBM/4uP0lEWGpwj5Zu2cRSXmg54Sc1nSrpgt7Sj21XeiCD4DW6TurwN667k40Z
         SMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405420; x=1760010220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPGwrtnmwO7ynHj83uEKbgoWVEyH11Eo31+uKIXnVKM=;
        b=Til92T05XOBI7FpvS2PJDSABXU8l7te5zNqjzjvzq2Bzmy1oNWCaUpFijOGoelA6da
         yTBrD3YIvnET8mUJ4nQ6Dknxby6Seau642Ll33bfIFlFsWYx/AgJNF0PNnLzDbRYq1oz
         ETQUXmzGVQ3nVW12BXtav/uFJwS8kkJk37yoFT2fKQLHmzO2TQ4Ovo+xv7ijRiNq9E9o
         +fVLxPumFLzIESFBRxf6KCqGJpy1Z8fTzSPiAMzkB8qJImuoxLytfWJD5Tnj11BgqS9H
         TFGsf8uxq4iIIoAyReD52bxouURopjbNhHp6hEkQnAWa0U81k6vijAd4Jb7rnFKQfnzX
         x8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRDogI9OyFpvIs+uMGy13DnLJ2zc7MKiOFnN6YC03uLFecjktTn1Due2Dw9+HD8kQeNx1K0kBAD0V9dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3x8ZnpTCdZo4TBNjhXKYfkOHT/fbWypsyLG0owY5NN5Zq8WiH
	RdG3g5c5ZGUNVvawETgy9HBvLPqQYbFwA7SFfTENX9UlwLqngXn1L6G/B55XETTrQ7vgUcdXz87
	wDfuPpqTy0ElSWeZyFgG+gU/HkYi8vnXRraCoqRfrOQ==
X-Gm-Gg: ASbGncvGAfrOxtPJNf90XNa/bO62fwE4pCZBdNxe75sRarlnzUKq9tVD75ZvNw+KTI4
	Q/D2QIwBMATV+T+XUMnCSFVhYT8qd2WZeTNbYna4LBrk3e5tDOheThs4sI7REGKlMkpVGsGJq2X
	EYPQRoshc6TX04Z3ewwu0UzVph4xi1d2e7f9I+47lkclSz7q6G6tF0nVzZQMYRInHQRRLhn2zl+
	KxWJVKOgzpuKk/yXnqo9/gEu3beBij4TQ==
X-Google-Smtp-Source: AGHT+IHcS+PZDBFklSeMqhkIhlvfggeUxgT2umZ0JZAsg1sGRTLRThuGm8GszRQtZPIo4KSErXn2dh0dbaFyqtNReGs=
X-Received: by 2002:a17:90b:380a:b0:32e:914b:f709 with SMTP id
 98e67ed59e1d1-339a6f3eeadmr4428470a91.6.1759405420125; Thu, 02 Oct 2025
 04:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN5bct_vDSzAfcnu@sirena.org.uk>
In-Reply-To: <aN5bct_vDSzAfcnu@sirena.org.uk>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 2 Oct 2025 20:43:28 +0900
X-Gm-Features: AS18NWDE982m00ruoRWCyOyxgNeTryWjfEhQfE9Z51q2R5vXRcc3l_Serfgwv0Q
Message-ID: <CAGE=qrp_vRvbnVCJ-OQQ3qspEEKqMUoDbGHpimYRBHH0NRig9Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the fixes tree
To: Mark Brown <broonie@kernel.org>
Cc: SeonGu Kang <ksk4725@coasia.com>, Ravi Patel <ravi.patel@samsung.com>, soc@kernel.org, 
	Linus Torvads <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 20:01, Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's build of Linus' tree (arm64 defconfig) failed like this:
>
> In file included from /tmp/next/build/arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts:12:
> /tmp/next/build/arch/arm64/boot/dts/exynos/axis/artpec8.dtsi:12:10: fatal error: dt-bindings/clock/axis,artpec8-clk.h: No such file or directory
>    12 | #include <dt-bindings/clock/axis,artpec8-clk.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[5]: *** [/tmp/next/build/scripts/Makefile.dtbs:132: arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dtb] Error 1
>
> Caused by commit
>
>    b176376991772 ("arm64: dts: axis: Add ARTPEC-8 Grizzly dts support")

 Thanks for the report, I already got message from Linus about it.

This will be "fixed" (not bisectable...)  by clk pull from Stephen.

I'll try to add some more tests for such cases to my CI (because
Samsung won't... ), but it's already a very busy machine. What I
wonder is that this branch was in next for two months and LKP didn't
catch it. Maybe Intel LKP cannot be fully relied on anymore?

It seems it's second missing allmodconfig from LKP this cycle (another
build failure reported by Linus for other pull request).

