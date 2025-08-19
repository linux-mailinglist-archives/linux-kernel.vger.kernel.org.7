Return-Path: <linux-kernel+bounces-775510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBFB2C008
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89AF1638B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1744326D52;
	Tue, 19 Aug 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLgQYOyH"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9E259C93
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602086; cv=none; b=H4NkgfuqLUtSwgEHrjtkf19ydcyzjBM+OxZgUQpXe+tODC44iFePL7grZ9DeghX6JBIADCat7TeX7r8nusGWeHq14MWctqtPNajD5ODdD8qloubEuIUh9kyzezYueWgP+wtjb1Uj4CqUODF3vPVXqCiT7T2xBDNc5z7r8X2P0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602086; c=relaxed/simple;
	bh=XiCiLZMTMIGVYEEPZg0XLJLdgFbKzAwyMzXWKKNIwBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuXvhtwHbgYYBLqGYHnSA3qk/nOUpThLh0vH/+H3tOEj889PTXcRCrO4Fx5dCvBWj+XNr/XhEB01Y0e9YOfPrakfZE3ljm4/WJmT0EBf35t29CdmhWBrIJhRq3MIbFqDZIUwjfe9S/Idp0Fe10cA4eKTHd4mwmoTMSPQuUT4lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLgQYOyH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce510f4f6so5479522e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755602083; x=1756206883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiCiLZMTMIGVYEEPZg0XLJLdgFbKzAwyMzXWKKNIwBw=;
        b=tLgQYOyHxVg9gCeL5SAJBVCYbsiQosbF5VhZ74DaomUHactUDQ1RpHDXpQ3xFS0MN2
         coRAW1ZGbRZd4k0sIBjqd3WZIhQXD2NXv7U3Ai+V8Fu4Qf3atrq1RVoA0ynReq9b+gcH
         HeLQX3VqUiIfjegDnzjBu2J/rzjJ1g0ZvH8FZOIKDeqz3ntwL9zxxiLYzRuZSsaDcQx8
         meJ7wryAFew9Qdut4FRNo/MtmpZC5O5cAI7uuelxD4wXKMD89OKC0+IMiEEP9Brxu8XF
         JUdPdUGFR9R7MvqmLH/+6KmUdx17JqmUXD2urrt5dN+WRA4+CCSzGhLDlnQt31YTyH4q
         I9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602083; x=1756206883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiCiLZMTMIGVYEEPZg0XLJLdgFbKzAwyMzXWKKNIwBw=;
        b=jl9ODiqAW6yfH1JNvPMrLQ/APyg1ac7V734H9QyrwFsFX5x2wOYDAUZjJBite0YaNa
         g7EDxg7pPuJnJEBsR8rv2rQxK7p/XVUqe3Au85zswK8Qjq0Q8ddqI/etJR/U215w4mz5
         LZ5qBQngQ6US1mqYBOn0ekKySIgREv40P2/tfFqU1uRSG4Q8uj+M545RHdwSkMr27TU2
         MErQnFqSsgmD30f3q9B5k+UN9wa4wogr27U/KZ/sTT4ADF1nOOdJlT9BoP/q3795ds6A
         bphU1QyovwVzGHlFHEWyWXrUw7o1GKvxBuaFdkRlAwSjB2sbL+HZS8uGEK3k2qNzYArg
         rLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXytahoPY/mZFdGlb5/SaxQuHiFHWFB0rXu0KOpDNkYb5NIUt6A7X7s/OfZC/YMLqVxTVF91Ti3TTZh6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDRNktpyHb+Dh0WsjMml9o1fECymhePy6xFAw7GjXAdTt25Oi
	DfftcroQULyDmnvpwmkR5y1VnP7NOKgmX+RKCuqchdDWPXfdYYKB2XHUsAt2whtxo/too3fipGK
	IkwQemclEnO7TYfjaoWUXxitEmdNSgoQOKF5/gzuTFg==
X-Gm-Gg: ASbGncuK3EgLMGE7HTz+QAn99PQeQ8rYsZtVD2qE+JRUI15WplTBAY3bl/tBqJJUc8P
	OOqGciyWrQVkR+fEyO9l/+0heiEw/6TeehlAJQDROqEOepIrEUddtMM4qUU2cIXxrjr5xzVThWq
	AXGKLdyIajDMDM4rfCgk/eQQabsis3hJMWNX7V88pFDkA+jkSKk7fCxCynrftEiUoWgkxBg8CQY
	BBsJEI=
X-Google-Smtp-Source: AGHT+IEcNJsAoRLGIYk1O31Tn3tYAXlZSESSNuq0103JoREB2oE7y0pJlyv9CebmjIKG2ZunE2wkC6ewDUMk7VOPWhw=
X-Received: by 2002:a05:6512:2289:b0:553:a4a8:b860 with SMTP id
 2adb3069b0e04-55e006d9a7amr646510e87.0.1755602082715; Tue, 19 Aug 2025
 04:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812092618.14270-1-andrea.porta@suse.com>
In-Reply-To: <20250812092618.14270-1-andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 13:14:31 +0200
X-Gm-Features: Ac12FXxil8YtjsTlhDzMgU8jUOtSCxu9rddHrXDKIc4MXQ04x78-F2JvPaqcPxY
Message-ID: <CACRpkdY4ReSDB6p3a1yQSAsEX60tt41+syyXEQrs2SLkKMcV-A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rp1: Add regmap ranges to RP1 gpio controller
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Phil Elwell <phil@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>, iivanov@suse.de, 
	svarbanov@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:24=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:

> The current gpio driver for RP1 shows only the very first register
> from sysfs, e.g.:
>
> $ cat /sys/kernel/debug/regmap/1f000d0000.gpio-rp1-pinctrl/registers
> 0: 0abe0000
>
> Add the correct ranges to the regmap configuration.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Patch applied.

Yours,
Linus Walleij

