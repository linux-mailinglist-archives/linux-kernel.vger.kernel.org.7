Return-Path: <linux-kernel+bounces-727112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432E9B01533
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535207A2E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BC1C5F2C;
	Fri, 11 Jul 2025 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0EYSHf0R"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE041F12F4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220313; cv=none; b=C5iIyHbpR7UyO2YLZgJliNZvXzkzwHelca2uTGzpjUNjvCpYkEXoIXsd+UwzuyYPjm+eyQc5EnC2DV6JieoyqHlB6qzR+mhfrAVGheyN5H2xOnR+Q9dWDX6CtFZsmqvrVOCTHQs1Vot99xpWDHFAh35q2HEB37+gZPGJPaV0XrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220313; c=relaxed/simple;
	bh=xPBWnGeT+ZkowyBG+TGuWUGOrJimbpN1WNzJXeQmpqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAF5xeV0imQXxmFr/eysrPLIwJR2k/vhtAH5SSEHY46PDy37sru3oqiq5eqVdSXAywhC+k2oF5x9MqyH/H79JD5lnEHJhYv+su5BeCWCY+5zw3iRo4ndIZm7r/7ewVyKezst++llhdjr9oReN+nZSYKUf3kdsZQQX2GZV5WSDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0EYSHf0R; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b584ac96so1782609e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752220310; x=1752825110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPBWnGeT+ZkowyBG+TGuWUGOrJimbpN1WNzJXeQmpqs=;
        b=0EYSHf0RK26TIXN5nXPLeMqiNndHySiX3asGO19cLnTiOjrdN/ewzDEqwxdKkzvIZC
         XJ+x4qnBMVG4GmR6ootSLjZH8NpDqUJuJfuMf7oXvddLn1rUz07atY+UubP5ZU3gZusI
         AzLGZFQJ8rPQK+zTfHuxUN1U4/04WBTkcx5/4T+KrO6oKozM4/z0vmtF7RsFgy0B7ddp
         uWL1zQjDQQgy1S/lm3et9yiGfVJEh2UR6KlKXoRjJKC3/eaSc9EUYJRzQH378njuT+w+
         kmo0jnZl4DuzhTcLXLKG7C0qYjMH4DJdQQ2MfHv9DpCvDHbs60lSpJSnu3d4nng7rEBG
         UCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752220310; x=1752825110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPBWnGeT+ZkowyBG+TGuWUGOrJimbpN1WNzJXeQmpqs=;
        b=n67h9UlctsIOKhpJQFq1CNAI9j2MKsRq377frH8tXPAaLnZwf2jD59LXmHFdUeMXIX
         fO/QEEtmIHWfqwYL6ZBTYCJNK4o6YoLoTpUb4MaqXy13yvm2PnRKC725Tc9CuCv55WEX
         UD1ZxDYXHuyTpLAAIwHUrUR6JSNUuCLmch2PzIU3p5+AYczScX8YB/XyKnMi6kYb7+Rl
         oGzgv9A06pYrpaR0w0YYlpLuaL1QZhMB12R7rTTkML01wkDE4NV1EbjgE2iywtWfJ4pp
         0aJugyh9/h4Vdbckf+D1oKGSY/OXgZ5rQA1+cO6+kkXWZ+bvRVUGqac9APYGD7gYaXc5
         XC9g==
X-Forwarded-Encrypted: i=1; AJvYcCUIOjTQAT72I71i775UNq1xizwzMmPnxMtbcPrrYiB0ci/v2rLRkmJ9SJQNNdHAhT4f11d++XU47dgAASA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bAkOvL+r8kOqKy3DJxjK86RivfKc5CHXLmBICtGynboNeGX0
	tjUdXN8bTkkiPi985yKSoCkK8mRhyplMi2bRevrAsQw87om8pwkTiAO3PLFd6O9TAYcDVT+NVnF
	aSAv5LTKi84B9O7GWxwZl0/4KwkX4g6AFtCtWShpQDA==
X-Gm-Gg: ASbGncvGDW/fZXu/h4ZpdDIz6dRtD19dShw/dZUAlUei6X6YV4tjcIVOOumgdzZkXQ2
	655WVrQNL6Dvpsb13RWZMrNAVtRjWlKOwYNPoEBq0rSf1/RAgorJERFtxJVqo7FNC2TeMPGQDdr
	Eh1mkczJBIIU9TSp0fm/gmfSsUWlmd90r0ZS1FE77CqadvZvqfBUBVmYkgO/bu3z8nC68L76r/a
	9b+IKyRQS9v0gFQSk4Rihm7e7sEu9sC/vJZXA==
X-Google-Smtp-Source: AGHT+IGPyUWmLfi01YzuGstUS2Vbkw4PQMxBgxEyG73Fs26b9n6ZiV02FI5SvQ43Jmygm3NL3xJAyCrUFc/JGRtIixg=
X-Received: by 2002:ac2:4bcb:0:b0:553:acbf:e003 with SMTP id
 2adb3069b0e04-55a057dc13dmr388356e87.13.1752220309800; Fri, 11 Jul 2025
 00:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625152839.193672-1-brgl@bgdev.pl> <42dd44ef-cd6f-4dce-bd40-6f5cb32c5fbb@oss.qualcomm.com>
In-Reply-To: <42dd44ef-cd6f-4dce-bd40-6f5cb32c5fbb@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 09:51:38 +0200
X-Gm-Features: Ac12FXzYGxuxHuUsoBRUpadwCLcatnVpepQxQPlM_RsnnT6km9D2BJ7BVbgWLlk
Message-ID: <CAMRc=McshVar8j80CbSTyQTs0MLdX9JCHyVu3xTMZQc36-6ugA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: add debug UART pins
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 5:09=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/25/25 5:28 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We should not rely on the bootloader to set up the pinmux of the debug
> > UART port. Let's add pin definitions for uart4 to tlmm and bind them to
> > the relevant device node.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

We're late into rc5 so gentle ping, any chance we could get this
queued for v6.17?

Bartosz

