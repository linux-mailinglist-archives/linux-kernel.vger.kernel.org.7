Return-Path: <linux-kernel+bounces-792503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49BB3C4DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A37D1C844B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6627FD75;
	Fri, 29 Aug 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdIgCpPX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047B29AB05
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506687; cv=none; b=urQV4jaE/AVLEjQa+vjMRxhlmYaIbT58RMmLmOjAWRCyx1tZIjjHkeourwqDrv08pdfZI0Up8jqjv81RT8rLarOOn9lVy7RsBz7ZUid9mQzkqOAsmohIL61Ze+N38Wf7xf+t7T62ZXsgsCGhhMdCj+PYGS2Pu8B9CUG4bRS1qxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506687; c=relaxed/simple;
	bh=ABTnhbbS7L5HkpCGOSZTEM0Im5AWWxZ2DgMSTWPYRFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Kdx54gHDrfPbeiH4PO3qApoqPmVhbh9emktKcH2gyGx6ovQO1rnF0ENnWBBfledB1bzgnqtLXJMyvkLpBB0S6oWLAfua89Gu/r852oNyfw6YW6xnuFLuwKQhO4nTBSgJhx9yiEShPVsXGK+H+7eZUYvJ4ylhuVTSG7SkSUAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YdIgCpPX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f3fc15e09so2647889e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756506683; x=1757111483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABTnhbbS7L5HkpCGOSZTEM0Im5AWWxZ2DgMSTWPYRFc=;
        b=YdIgCpPXRFsuA8bZTTf50yN23f5FqtX1UBg6HaM5KywgC4l2o3LlCpUjp6uDQNpkDJ
         iOyDjpVnh7ssSE08Hsu125AVnJO+74c0Yru20zIT2jVc9HnjXRZqqChzw41Qp6YTRaRi
         CtjysG7/JmN+QF7bVapac2z8VpRtU3+SNRyvDrBzGjNg+IP64Pukmbbfp5mAd4wZLUCt
         nDmqrV8mHRsGVGYOsd1Ra31KLfMw5/dTOtPESfvuXUgGmDOQzg5Qq/Jfke+E1WFl/TII
         c+MV98i9LTvo6bz84MLw90ZEVxEKlLZcUNR8q83Hk/RDP4qf+X8XTjM4edg+LN9TO+fB
         g5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756506683; x=1757111483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABTnhbbS7L5HkpCGOSZTEM0Im5AWWxZ2DgMSTWPYRFc=;
        b=GR6H1ZX2bq9Xlss0bSFZivp9lThw8aMz1cO9ymCxSt1iIvx+BURhEe/SB4FNoB4qtV
         ixf4q9leqTu2xEOk5xSrWirc8NBm6YB3X40RR0wDdxIHgVDMk/ifoIheIpdiY8xNlBU6
         +pLe1zjfEX/sHiqZmTVkoPMS4AN4kkhgyNoCIwFqH0kMUxAaFpJ/FstTbCfR2kstA9ZP
         IKjx5hDlK4FoYwulg7MbDDGVTsbySxJYGVaVFKrSOTHx3yXr8yZPBHB4sJZRTLOkea2c
         xx4pvnbybIdfZ9cEepfABvRDyNhbUqHmIa5e4LLZeJFI3bUSjPOemuNk4bmfo8GIm7qs
         84vg==
X-Forwarded-Encrypted: i=1; AJvYcCXsn8k+vcy5AA2LLj6+RZIaAmxVC4aqQFw9XanP8N7nu0tf5P8x0ioRkzDuimE+Hx5KFee01VnxueHV/UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3Kr+UQj8yv209aNWluM/T4lDDqx/9tef6DSryRC5hB/xR0K5
	yODj0QMO509CZFHEsi1Nrhq8/oBMD8OhrgoUEaQus6dKecnPSrt5ittxdknscotCVcPOeHPBOCR
	undFqLvcwWyMa7jwYltGgm4xk9+WvMzjmePtGPj5nYw==
X-Gm-Gg: ASbGncunKVrQIlMHe1oLPxLMifDxqKSI3WIIKbXNp9Wzvt1wOIIyjRYL9gsGxgEPTYu
	4gXFy0oxWI54vOuMofXM+UfO8HZL/eTzejmOcRUYVlMRnP6DBFJZsPF6yzbjB/1RZJVNAuKFhan
	3/NfaCuSm/KepbV0cvhAx5XsvZvkvaFAERYE+03MUmtHCZczXVihJnn58nvzmp+/HLYqBde3jht
	2juK3I=
X-Google-Smtp-Source: AGHT+IGEsnYhsV7tsgFN84KPDIRoOPf0/B8DKbI7M0URReevQxuA0Bzr4lMQoYrnOIFpony13QSt3vd1Z/GbWsefU8c=
X-Received: by 2002:a05:6512:b06:b0:55f:34e8:b1a6 with SMTP id
 2adb3069b0e04-55f70a05aa1mr46987e87.57.1756506682752; Fri, 29 Aug 2025
 15:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812203337.731648-1-robh@kernel.org>
In-Reply-To: <20250812203337.731648-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 30 Aug 2025 00:31:11 +0200
X-Gm-Features: Ac12FXyB7pgkBvR7Aj25d5oehVpWxFIRJ4xjMg8x9Wn3iT-JlQETgMnYYiDN10o
Message-ID: <CACRpkdb9NKKeDT_b40aEHW7qZPsKA6omzw_OFp37zf9pF8dptw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert brcm,bcm2835-gpio to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:33=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the Broadcom BCM2835 GPIO (and pinmux) controller binding to DT
> schema format.
>
> The structure of the child nodes wasn't well defined. The schema is
> based on the .dts users. The legacy binding is a single level of child
> nodes while the standard binding is 2 levels of child nodes.
>
> The "all banks" interrupt is treated as optional following actual users.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Patch applied. Why didn't I do this to begin with, I think I was
confused by the gpio in the title and some stress :/

Yours,
Linus Walleij

