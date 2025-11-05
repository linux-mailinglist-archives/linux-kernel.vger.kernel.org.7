Return-Path: <linux-kernel+bounces-886479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022ECC35B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D284C189BA66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317C3161B1;
	Wed,  5 Nov 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tO88aW2X"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF53148BE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347210; cv=none; b=dTBDJFJGC9OHuodaFq9AFTVTr7+qcThl/eLBpOMMeGNoBZyk0DHREcFSUFtmgDMk+NPIeLUjM09fSqFiK5fPztwCuLphgK5kzHq/Bw3b1D6atKub3JpSHiZKHHc8Jia7eQJ+M7Axr8tybEyw9+gAlRE63gya/UdpfEvY+p7zeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347210; c=relaxed/simple;
	bh=+ZOOz+bd9i752tRldCuS12aOoHVwIBWiXPKmP/KxxI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO7i4dMqGo+THdr7OooB7jMY+/thwa0vhxoM8UFPYTIcv+csQgPWefH4awVOMUm+h2VSgRuWHrqNO0p8dg6ebJ7hBRgAfPos0dv04GSM0a1siWRVvvMHUJMEuUFbgUsdq4kLw9EXzZh62A2BC2Cdb/CjxPAGBKPBUm2j5oJst3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tO88aW2X; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso6327025d50.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762347207; x=1762952007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jssj8tcz0aY4xx9zjyBXJVY+CGYy95sOugmtidwxoNQ=;
        b=tO88aW2XEymmZlg8+1B+OhDnem5E2e+1wEdhZf6Qt7stm8/6vymVy2KvLgaRtacbsT
         IpGU+0SHBDJiCo3Op8nJCoL6y0se97A+TqZE0hXmrg5pO5cXmwdMLInAjD7/uzPwb5yJ
         Do5WLMB5Ir0zQL3oAG+erHu747Ox3Nyh4IUEdrWcRG41KTcLboXr0WdtNfSgshRr35mR
         zhZn+/+B82GjS5HZe2S8yB4CSeE8KcQF5KN3Y8MJkj7+bSQOqsa91r5S1Yx44g9kKjU5
         2eaFJMXlzbpjv7CXr+HzSpY9ziYh425irVZol3XlkXQCUTpeq1qjA6RzlFBPAwVxtFIy
         hpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347207; x=1762952007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jssj8tcz0aY4xx9zjyBXJVY+CGYy95sOugmtidwxoNQ=;
        b=YuzRfXU+yhdAkrR15D68cvPC96A6adH13IEU2KDf694Ng5te6sMeO4Xg9UrwvtI3dL
         wYHpbbEt6ncosmbhgNIB5EdKyWBvEWRqj3CtB/PgZqCo9j2eQd3eYITjXPjfT+R8lHwo
         4VLKsSHg/Mb9DPtThusKZoVdi0XqsOZXlU3f/JUXyL+0Og00sG6o45Dk3Pu3sMjIsgww
         l+0S6Tunr7zg+vam9Xvy8j2dsJ627lWa++tm0rX9ekt8rtwIFXjMPaLxOFlXJYf6uOTL
         xBQXs/i5AE7wlL+18S6zMLkhmpVaDM20dcmLZjJljKjiECqFAgOJnwWtZKq+o0HSqG0F
         bEmQ==
X-Gm-Message-State: AOJu0Yz0uMUWi9BWET5JjgO60xJCk8Ofq2mDHZOmhSRTBM2aZXzUAlRH
	2b7MNbnZtWNOSHzQGJ43jSImtRKCnVFEguvn2I0sRx5BYv1xhjuGYtF3jqZhhOvsvt/YGuhOrGv
	XCfquoYiLCbqxoAW77ShVbaYldHtqyVBeyv7Ig0KzKg==
X-Gm-Gg: ASbGncvZgjptYXQfFH2Z6OFcr0TGyImAlob+xGJfZ2HjVH7LljU7cbW0gIkVffecBzi
	drarPyIMXAP4b+SOAA3HAen6FrB9qlaGsWFtsZY69nblmumiZO4D3Y3pfXBccNdNEk2TBata161
	f2SzpqairYbyhC3OVcvcKn7F43J973KB36lDXuewN6QQfp9v8EHTQtKiwBkxktqaA1qIK0d9MDX
	ECyMDP3tuU5wMZ8by1HNYAbeCc9SlbFxdmC1Gx4nEJB6ZjYMcoEIvnhdmsHGA==
X-Google-Smtp-Source: AGHT+IEfE0sgdiFVkZmKF1dZxXig2jTxj45vJSC6LxMQVNg2FzDnEW5ajmYQgYPmXHM9+L5zmqyzIeI1NXQMsR92k1k=
X-Received: by 2002:a05:690e:15d4:b0:63f:bca7:fff6 with SMTP id
 956f58d0204a3-63fd3571aadmr1876951d50.36.1762347206857; Wed, 05 Nov 2025
 04:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031183309.1163384-1-svarbanov@suse.de>
In-Reply-To: <20251031183309.1163384-1-svarbanov@suse.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Nov 2025 13:52:50 +0100
X-Gm-Features: AWmQ_blullTpT8Nfe-qMS1ztFmCY1ERew4O3PuDztRrqUvx0BImetke1Cxs_hWE
Message-ID: <CAPDyKFqHizQKSDCuPopNBWtt1mNCNuWegv9c=PcXEEVaUaP3cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add watchdog support for bcm2712
To: Stanimir Varbanov <svarbanov@suse.de>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>, 
	Willow Cunningham <willow.e.cunningham@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Saenz Julienne <nsaenz@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 19:33, Stanimir Varbanov <svarbanov@suse.de> wrote:
>
> Hello,
>
> Changes since v2:
>  * 2/4 - Use maxItems instead of wrong minItems in else clause (Conor).
>
> Comments are welcome!
>
> regards,
> ~Stan
>
> Stanimir Varbanov (4):
>   pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
>   dt-bindings: soc: bcm: Add bcm2712 compatible
>   mfd: bcm2835-pm: Add support for BCM2712
>   arm64: dts: broadcom: bcm2712: Add watchdog DT node
>
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  9 +++++
>  drivers/mfd/bcm2835-pm.c                      |  1 +
>  drivers/pmdomain/bcm/bcm2835-power.c          | 17 +++++++--
>  4 files changed, 55 insertions(+), 10 deletions(-)
>
> --
> 2.47.0
>

Patch 1->3 applied for next, thanks!

Note the dt patch (patch2) is also available on the immutable dt branch.

Kind regards
Uffe

