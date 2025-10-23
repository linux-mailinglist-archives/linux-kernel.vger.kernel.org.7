Return-Path: <linux-kernel+bounces-866455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311ABFFCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C73A5E00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B42EAD0F;
	Thu, 23 Oct 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jLVNH/t/"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83732EB5C4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206961; cv=none; b=uMW8r9yE26Oz8xAjEPyjmvmLG5NOoFyW8l8S8sfLMKiWTcXtPrueCLP0Zep1QT2Wk5potaOKGyesk4aLXFdtISpfsc2T+NsAZawHfnTSkEY6cGB6gktMGghrvsuuMLjxPYCYwV4qFOq3fHa3kJgc5o+217puu7tNpAMENUw1ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206961; c=relaxed/simple;
	bh=cIE2BOANhjWnyErhrHcjB1l2LG54rueKr0VnvQSaSKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIyi57uY5nL2Psxa92JIk3/ACOzitjrA9g14DVR8X4jbnPOe+Eqj5MYMbb2KFaLxFyGztLmMiIRTz4oplLBBJcU2YGc436D17/2HwojNj1qlzLbN2/c96HwG7NslZBGLHDmjuKQm+NOGmdgd8MwEdrqYAT53v6GXgCRZzSk+Cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jLVNH/t/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59093250aabso497082e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761206958; x=1761811758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIE2BOANhjWnyErhrHcjB1l2LG54rueKr0VnvQSaSKE=;
        b=jLVNH/t/R9H2AqlrjN3HzfoK+u7UvkEnjYg77gyNqZvxzzzIocWEX2VyALW3fT60PR
         aDCqnaz0lLEUinR2AW8XOzjRzTjXG2jB9fBXuHcEuIYGcTAs6zmTOe2QU+ncla12w/4o
         /Y3vqnBcIhgoD4BdTALMlpshNNVNfcKAz/Kge6Wx2rMOE9dMxLwovATqTZZm+AywY9Ac
         cILnR9wxyThrwBGk8OqpSx8WFVxfQIgA5GYysG8ExEYO4ka9fHT09RwmvXwXF0cXab0I
         L1jBklAmt/RfulacxFn2KSB/vITGc1x1EhgInsL8Fbwp2WGbcNlCHUUoWercB4JYslH3
         zoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206958; x=1761811758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIE2BOANhjWnyErhrHcjB1l2LG54rueKr0VnvQSaSKE=;
        b=ZhmFnk/KwbTAioYdCnEDIHQbXMptKNzNSlT/Oc9CIAtLlHjb5HNc4QuYHLB0ucERzB
         rTtVlda1tQgozk3uZnwL65VsUEb8H7iLUlPZQ3VXBgupPLpNna8uke0xOkFJ4VLAuj0W
         lY+60XGjHXs4EQsJW5SzveiEqx3eF67dnKqEygMAzVSFme1qRRxrjs/3KT2U4nyQk61I
         seWWQu4JgMAMoG2afohEqNhLCB91beo2XNQhxlaWeQvjI8thQGBv8xBYDKoTvxA+j1NJ
         /qvmcYMIJaXRUsev91TFDesaPQVyuldhw0NgI+s8GzhRdbahal6sg7cBQTD9fumucRMw
         QEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUyv+INayTE8ph3nzrkT2WDYBdmIK/RM4zymmR3UFuS+0OAnvEoF9b92YfsveTCs7tUjjjwhfxeHp+y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrr+GPtzYIoA+YSMbcfLxbsXFS2J57yu2hUCKBwuHOLtKRVxBk
	rWaG786YylFakyj0ROoxhmNrcFwlhA4yV7naAKoGX61L/2qzjw6BiWqG/AbkGh1EE2iA66zRer0
	rlS580M6WOtx4XiHdFPbpEe6CduNfbvJdHDtU3eiyqA==
X-Gm-Gg: ASbGncv0zZCCvgyDlm+VGP5kWWqzbFPCZJPYYBk4z3lsOqR9oQ9nmLGAOQOWY4wsdcJ
	m4zBL26DCqmAWAh6jCgoavNEU7Dd6qu4sCW6GsmDo18U2LQrnqw5XI/bSOQg4gpn6FKbZqq/irY
	vpbgE4OdxgOLi3WGWF/YWD+uxn/0RUlzBFulLO+rPe8GwWLyjxx0uhjWZB0exlEtBV99E7lCCpf
	QaEhfqhvbHobTNqsTRgdyHFtS8CM+N+PM/XtZDnI+7z0+u3B6Z7S7ba8okcMaH+Tprn5qWkg0E2
	of2n4hQPPJWGNEE=
X-Google-Smtp-Source: AGHT+IHpAQcjZODUzaEioAlfVYH5oA4wVJnUW+xVtFHsGPd3DzxXsAdk8vcOeE04cb8h1uH4ffB/8m/kLJJgPqsE+8g=
X-Received: by 2002:a05:6512:230b:b0:592:f5f9:f59f with SMTP id
 2adb3069b0e04-592f5f9f6dfmr471491e87.31.1761206957859; Thu, 23 Oct 2025
 01:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023070231.1305-1-vulab@iscas.ac.cn>
In-Reply-To: <20251023070231.1305-1-vulab@iscas.ac.cn>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 10:09:05 +0200
X-Gm-Features: AS18NWC5lCwUKbY2uEDzUsLAwFUB4d72Xri_gTz0_fKwL5iefNSV0C8DrUMFteE
Message-ID: <CAMRc=MekWJPnhwLn9z4=yqC4Pjyf2xd7teKCLTUEmnBCDLeROA@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: Fix duplicated IRQ mapping
To: Haotian Zhang <vulab@iscas.ac.cn>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:02=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:
>
> The generic_handle_domain_irq() function resolves the hardware IRQ
> internally. The driver performed a duplicative mapping by calling
> irq_find_mapping() first, which could lead to an RCU stall.
>
> Delete the redundant irq_find_mapping() call and pass the hardware IRQ
> directly to generic_handle_domain_irq().
>
> Fixes: c5a4b6fd31e8 ("gpio: Add support for Intel LJCA USB GPIO driver")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

Andy: this looks correct to me and you already sent your PR with
fixes, should I take it directly into my fixes tree for v6.18-rc3?

Bart

