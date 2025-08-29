Return-Path: <linux-kernel+bounces-792506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F7B3C4E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA9172B93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A5529D291;
	Fri, 29 Aug 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBNs5hfY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3E2773D3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506799; cv=none; b=g/9mhIeJ+yP9060H3RcaS136j+zok9R3QZ1jde/MVVf7fbwA7j88xRgQRSFD6x6gSHagzs/3us/RLxADtiWbd/gT8jU31OSMbmNULIN6NOUCRjYvXnxe3viIGZRhVSDtYh9D74gZAuDJ+FxkNKZ49wF/ytzeQ4X31jvCXJgsVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506799; c=relaxed/simple;
	bh=0wxY1cewY1ZvhfXpTsBk4/4b0JZP8Tsxj1w3A5Y71M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bhr1TxfrImU1Cqr2Rwpy0TTe62ISGzCX1d1wsQInPgzlhmjTVwoIHWYX5TgF3WsYoONJcOVBqTOM9pYdNIxW5Occ55MPU40If2z5cRnWzoSwTx8i0If+2GwXua5wzZh1salSUsdaXFYuNw2h/lFzk9nKmDJFzhb8UYUj2QFQCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBNs5hfY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so1137286e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756506795; x=1757111595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wxY1cewY1ZvhfXpTsBk4/4b0JZP8Tsxj1w3A5Y71M4=;
        b=mBNs5hfYK7pq+Kxceuu7QUq19RuooOofxBlQzeNFRYnDSccW5GOSZ0z0F0d0tcrBeD
         cLyaZdnVb3IBWK0dDSpKffWDKvbZ7MDKCllsx+/rRX+n8+qmeV1KW+lJ+9kEzL68UUBR
         BOXL6fqf3q2Pz68tGDvI2fRG0bSO0k/TeBPk2yp7IAo+PJlbeQrv+y0YSNtlWB2U0a8G
         hBKRvY4E2l4b8ruSGNFBogxRZLMpukNp+MR++UBDIOmlCto0Bhvr8M1j9Luy65iaLkOc
         jZstn58d/HaayudmBxnrxzm4vCjV0CnNZTvZ4tV/sa0cHp+pe843Xo0NzhGD7DVMRfp+
         5RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756506795; x=1757111595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wxY1cewY1ZvhfXpTsBk4/4b0JZP8Tsxj1w3A5Y71M4=;
        b=fiCOQHX8C04Rf7JdxXtxqG1aQT/hWFtdoxRnwYNLNmOZ7+iGx3ad5o7O7YgNqrjBJm
         VSlTaQ8HFPUsYfjOyqx06t4khDbuRFyn8yEPeLUz9cxHAElXIczMLxfmLcDJLFWYTsPY
         IY3xEG91vRJTHO0pFFQ8J5tW+PgUqVPvRcD2+KxVSawOxpvNTkoiFZ0bbhcwzCq/U0Ff
         EgDhHZH1tpNcG8NevMcJw5ObojopIRzCvFlTM3//CGmJlBX8SuEYgy6eR5rzWtxlsCNb
         XQ6wWGP2ETY9sn8A6uPZlQt68JIrM4lDzEulsYq7KJGxrstWEN3aNkem00JFjpYiSpyj
         q6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/H5/rhu0usd1W1cz+PYjMgSyMGQs3bHtqUGzLiKLoAUS/G0JYAXKaawpKeDtnWGS4oOPPnC+ut1OhzcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUc7YBO6BowA2KllIpFSDpuXpwfbACIYEWuub4HTahCbIrntxo
	U8NiZfMiWQTGh3ZLfS1EWHhNqlLKSOhmrdHioDPVqLxIIUctv7hlD4yEy2zUQQK7WHXtW/NeKXJ
	znO7REe5OdJ0UTRaeMh0rmykbqzdIow8J7PgDY3V+MQ==
X-Gm-Gg: ASbGncszyPpU+rNr1RBkeeihf8AeFaHOnSwBkfYmgifL4FWEninqd6b6CWEG6L6Mu1u
	JHsXPgVX6IwfuYYT2JVOkjx01Gq6JUCm4i8lCMxVvNJiG4xuQxDInc/QYBDgrxjBQrMEaOdmJNf
	h1TlGb9dqcMpN6tVkoMueJo84Vbu1YX+x3FPieOFm74krZimm7cdY4QeLOjmbmGQMZTohHDW9et
	be1FRJRfCOxb2QjOQ==
X-Google-Smtp-Source: AGHT+IENJM3W17UfBxfWGD1X5J/SIfSe06hqmxkOMnpEu6fQZ9gf/LIwxzd5H/mcgzry4Ih0SpbYIZZoLdjS+5OjaVc=
X-Received: by 2002:ac2:4e0a:0:b0:55b:8aa7:4c1e with SMTP id
 2adb3069b0e04-55f709889famr48796e87.53.1756506795467; Fri, 29 Aug 2025
 15:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812203348.733749-1-robh@kernel.org>
In-Reply-To: <20250812203348.733749-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 30 Aug 2025 00:33:04 +0200
X-Gm-Features: Ac12FXzWrFcRGoOx38Qv15P8o1KozyPxEQDiElCEqh5pWjzn0dOAl2Zk_kHqKx0
Message-ID: <CACRpkdb4TFRReKSNadeJKy29XC1qGGOO=H0G8WLZjB9D9FjTbQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert brcm,iproc-gpio to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:33=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the Broadcom iProc/Cygnus GPIO/Pinconf binding to DT schema
> format.
>
> The child node structure is based on the example as there's not any
> actual .dts files with child nodes.
>
> The binding wasn't clear that "reg" can be 1 or 2 entries. The number of
> "reg" entries doesn't appear to be based on compatible, so no per
> compatible constraints for it
>
> The "brcm,iproc-stingray-gpio" could possibly be dropped. There are no
> .dts files using it, but the driver uses it.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij

