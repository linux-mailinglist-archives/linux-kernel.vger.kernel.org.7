Return-Path: <linux-kernel+bounces-837624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2111BACC78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0F4321759
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAA2F8BC9;
	Tue, 30 Sep 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUrnJwZf"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A91B4236
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234182; cv=none; b=umtbPpxBS4lN6YSJUbHDRk4T31GaZCJx+p69o2fn5/4MLYpwxYau3y+KEWp0dSAvetTGgcEaXbkVQttO2SsZ0jF0G6r4yok6MfuU+r3k3ia/+jTLaUlNGJpDEA9uvG3y8ls6Yz2obh10W5u0b/S99d8SjhCt5pXN4DSxDw5w2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234182; c=relaxed/simple;
	bh=XWsHwcmhycoGa2HIoRG3LP4lfFRHaNv28AhUiYBFboM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VghcWYxv80ae2wtpwGOVvXTyVaOgcZpL8z4lYl+CoW6H2c250vtX4v4bas1y0DK02pHENKlUStsqh5L9cTu182zK0iaehNAVZmFc7FUJw87ZZOF1h2TelIR9M5Ts80nCJUTAS/RKlkkQjMEg5vQxBVzXQltHEyCOWFyEklCiArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rUrnJwZf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so7375238e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759234178; x=1759838978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAIE6N/ie1ZesaEiWPTQEN6Rw49R0R3rgXHZKFPMKzc=;
        b=rUrnJwZfqtftVQnfSpjApitQD1G077v+QuYlXV7ONLWsTOKBlUC3SKF7w2FFrCqEde
         evWnjFOWeJi9KqqBn8fyrO3UfweFfsfjAjL4lCM0F/EyhBwJWsv5ttOfy7C2l2gTRf95
         cxwa+tveVJt/mUG9mWPt+P1vlE1JuBrYoC6VS39AtrsTLqpX//p3ZaNht1TluoV/FE0t
         dnVttDP/iBmNQe03ptVMuOMm6oyuMVCyyo+rsxMCxYdDuVJzd8nMZyIw6YhSIC6Km9Ko
         xii5DK9lhfNRntyusNfEbduVzxKkBKauhXbt8mQYWmcTkazaPLObS/KiKY4E1j8CiJ4W
         jbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234178; x=1759838978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAIE6N/ie1ZesaEiWPTQEN6Rw49R0R3rgXHZKFPMKzc=;
        b=RcreoRQ4IY3u4gRnfp7YHpxpBhLvKehoC5cfy4jy56dvNtqDqH/+/nRE1+7s4VUUKN
         db5OkOcWr7F2eqc5qkqIjCtrSF8Oh0WraRfiBe/b7laWlGiOcXI7ZuKgsTdOF6nCcfw+
         lMPEYsboP8Rvpki+Y8eCyqIgYrqcIqmHC+bbO90f1R7mdb5o2Lb35AL3YeGTbrsACqEv
         dWqKy9cQwmzSmBRrjaEGoZNauQkB5mufch/PRcOJCU2XW4UPNIvfij2qfpCsYuTdn73k
         OvWn/7W9c7hEsnKYD4Vb6p5/aSdxv6r6+5a3AfBADmhWDMuALdasuIKYGOIjMqp3YmZl
         uEbA==
X-Forwarded-Encrypted: i=1; AJvYcCVoaP8iKqM//lMG0W1wPSG8a2KJUnWxojYPunuW5O5McLeoYrZfPTNc0t9N9q3zbjrIFfarDzCxaPplTvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFLJKAWUaiBPHnh/pkKTnck9sUaNH5oR/vD0VHmLS2HgdGCO1
	JV4USAv6sNSBZVAv/0je9xtH+iSLZ65XP0O9+aYUWYI26Ap2tJ8WbRIr3zqL1/1HkG2bNhNdzwE
	sLDOebow6rSdVaVxGF3wuUC71AAjahZBwfxoIUAz5WA==
X-Gm-Gg: ASbGncv4GjZhQtmSlSbXp0bwlqcLJlLcRbhE64ywW5OSnDzu8OiPpKRwAkK8rHdyiRJ
	USHqMwlqj2oE3GFC5wqdUhsmjQgOrc4M8TKOAHInqWJT0Gca5vVrSmmYP9np8zO4Q4YDdYILDVR
	OU4H0dEslrgc0vzAX0OFupEePNfuI78CczjRfSrzq2+FG2f0JtM51O1Ypey2C/uoM/v0h+QA6mS
	ngZm26LOCfOSUQcykTCAjp6QwqdTTtVaxpmka8FVA==
X-Google-Smtp-Source: AGHT+IFSwW9Wy1FU+esxU7n+NnGnwYqfKtouELxp+NZW+Pi9jueaReG4jfxbaQvtzn5VmiWlJbhIyO1LxFlQl0vytEM=
X-Received: by 2002:a05:6512:2c8f:b0:55f:64b9:3ab4 with SMTP id
 2adb3069b0e04-582d2299c9cmr6543141e87.23.1759234178520; Tue, 30 Sep 2025
 05:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Sep 2025 14:09:27 +0200
X-Gm-Features: AS18NWAALVNybg-tprH2AdPhVEMvREN5pHeE4UHKDbwJmi9lhCaGcWVtSNrYsTg
Message-ID: <CACRpkdZbwuf2Fgtq+jyqzqspb37-P6X4O9xqkG-mSb+afSjh3g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
To: Franz-Josef Haider <fj.haider@outlook.com>
Cc: linux@armlinux.org.uk, ardb@kernel.org, rmk+kernel@armlinux.org.uk, 
	ebiggers@kernel.org, nathan@kernel.org, rostedt@goodmis.org, kees@kernel.org, 
	dave@vasilevsky.ca, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:33=E2=80=AFPM Franz-Josef Haider
<fj.haider@outlook.com> wrote:

> From 33ce5a26ef08199625bc5bb01a176047bfacff91 Mon Sep 17 00:00:00 2001
> From: Franz-Josef Haider <fj.haider@outlook.com>
> Date: Thu, 25 Sep 2025 22:14:07 +0300
> Subject: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
>
> Fixes build for this cpu type.
>
> Signed-off-by: Franz-Josef Haider <fj.haider@outlook.com>

Please elaborate a bit on this change in the commit message.

1. What were you trying to do.

2. What stopped you from doing what you wanted to do.

3. Why did you do this change to the kernel to do what you wanted
  to do.

Should it not be:
!CPU_ARM740T && !CPU_ARM946E && !CPU_ARM940T
?

Yours,
Linus Walleij

