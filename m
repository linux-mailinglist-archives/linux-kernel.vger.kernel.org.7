Return-Path: <linux-kernel+bounces-728172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070AEB0242B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FF93BE375
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B082ED842;
	Fri, 11 Jul 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwgFoPz2"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218261DE3B7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259999; cv=none; b=kZgUyefftTJD4Y16J0h1LfmUPwwWRyHvjQAQzNx8Ki5yrDUcTZBxhkSW5Wae2CsZi2PHqn+ZUvdc8hIVN5VYhV8Jcuw1w0rUAQa9f9kQFVsHKb3Q6U4tvgaObUhYw7oA2lAHmAvDnJBM8xVEjebrZvzti9l+Tov+CDj28I82uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259999; c=relaxed/simple;
	bh=6oa0VmGb0K5iYELBtraMc+ym3sVQgZnaB1e6wip7Kyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPCKbtII4+uZCRWWYd+wfC4fTQqysele+5Uxh51XXQcmp0k1Ul/iiHGdW8MJxakJVp/fAoGHntnpLMGPmffkQ4ea+Z6CUoq4wSs/wtaurGZik6bCSusPkBYCrWPkOm7KVYyr6uU7/LMscWPv5OtCY3h/9aq24NUyHHYOO3d6jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwgFoPz2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e812fc35985so2152222276.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752259996; x=1752864796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnMNvTF+R8ofXhs9BIQ7FQl/jHKBWLPO/PBptuTPHgQ=;
        b=lwgFoPz2EVHuxJIHsoIfsNZnVcYxxE1kRoZhOs417OHb3eubPlOeWTiWEsmyI8XoYS
         uwjidk62k7FV1mWq2B9sVO9eamU+Ml+4r61lV4eX2gBeJnYCmr1v803RqgGEAMQB2MSg
         0S90oLmCea4CaQSFvjnK5/mi0g22cHlkIuQ9dhnf4Ipdz6Ew20xnjXzmZn6Y+cuhATwW
         OUTzC6ZUqeRi/V/E929+DrdLPqt1JNGMjnZL9l7fjfVobB1PXpXOjQW7jb2D4q8umDZU
         0+GjgJ9Qh6+SiTYCfASAypGLUy3ak2h97GkQSBNVUTpbE9fwBvHtZXK2vqUW5hpSQZVC
         SQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259996; x=1752864796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnMNvTF+R8ofXhs9BIQ7FQl/jHKBWLPO/PBptuTPHgQ=;
        b=h93g8/MlepGZYL/eCkHJ4QGJcZ4KAsxhdo3hleUnLSuGiv3dzNThxDmezuGJ3MidYb
         rshb9GCRISGVIjDjLWZsA5/rv4yv568YBY06pTzTn0OsOg00krUKi6oMuCGyHbqN9lSJ
         GD1qiH9e/kUgxHCpADcpR8TdCNGFdzo+z0ktynJkqeulgo+vR6bg+fW9oN4nrgm022EN
         uK3C1udwWNUdBB5jCOu4xmHMLJPf7wMp+EWHuSEm30d/RisXNhiSz9Vax74IIKTOBPTD
         DfjF5Tt44CHeLz3ENI8dEaexoZxTIo9Fl5XMYOLqLP1QWG5OvnFT6BKH2S703jZewjUJ
         UB+A==
X-Forwarded-Encrypted: i=1; AJvYcCXMUfGc71NjN/0JlGiBKvUiXWCD8Oq9QHez98z810p9JD+Q3jk1IrVHXzlk7DOVb0HSGrY0YCa3OAQi8P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MnXrGvnYUYAfeQ+vWFpBj3onKokGpIE+Kz6EXIz/Wu9Dfjgz
	E9m/1/s7VH2ECpBW9sD+1TKSXiPbi7c2Q1aIpXKnanP2XLnQ/wp4AyUlhuP5EUQAKuAFS02gohZ
	o2RXBkVFVboBlRTvQHuvEngXHPTofdCgZlQB/vx9c+Q==
X-Gm-Gg: ASbGncshYnO9gFdYU29iPaaJc+5oDH2nYseZLkzAnCKPUz8FGd4W05joTgTeyiL/iCh
	hPxybZ/i09U0SElroeeCuUyoDTTDdiAy31xICNMWU7/6VPRqj9Mi1B4yHB9dfoAdbG3W+xQRzE3
	lDiOttS7sMHl8FhQZC6uLoeuNa0xTLg2d5FUhIcior0+D7ZOPe7iLBeSvV5uy7ekSR9u6l0BnmP
	6xHOnCS2BQxdt9+2Q==
X-Google-Smtp-Source: AGHT+IHNGHaJapXfEwRUcTXNTWlTsMHXEiPIQ/b0KTpye4KQsUdp1sxBRmAZdNG++EC1bw7xLSQza58HYJgLAxUXYQU=
X-Received: by 2002:a05:690c:6282:b0:70f:87c5:5270 with SMTP id
 00721157ae682-717d5daccbfmr86777077b3.19.1752259996008; Fri, 11 Jul 2025
 11:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-hdp-upstream-v7-0-faeecf7aaee1@foss.st.com>
In-Reply-To: <20250711-hdp-upstream-v7-0-faeecf7aaee1@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:52:58 +0200
X-Gm-Features: Ac12FXxLjA7peUDZIWJhb4cndI_Q2FwVXxO2uVEd8E-6LJKHyzTLqNgXqkM6VhY
Message-ID: <CACRpkda9M6R_vi5FMGvo6PyThB8OJjX7PMMusHjjs5HcX0OF4g@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Introduce HDP support for STM32MP platforms
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:43=E2=80=AFAM Cl=C3=A9ment Le Goffic
<clement.legoffic@foss.st.com> wrote:

> Cl=C3=A9ment Le Goffic (8):
>       dt-bindings: pinctrl: stm32: Introduce HDP
>       pinctrl: stm32: Introduce HDP driver
>       MAINTAINERS: add Cl=C3=A9ment Le Goffic as STM32 HDP maintainer

The three patches applied to the pinctrl tree.

>       ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp13
>       ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp15
>       ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp25
>       ARM: dts: stm32: add alternate pinmux for HDP pin and add HDP pinct=
rl node
>       ARM: dts: stm32: add Hardware debug port (HDP) on stm32mp157c-dk2 b=
oard

Please apply these through the SoC tree.

Yours,
Linus Walleij

