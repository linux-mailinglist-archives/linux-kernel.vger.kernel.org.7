Return-Path: <linux-kernel+bounces-624653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3770AA05EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CBA4A098F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 08:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7328A408;
	Tue, 29 Apr 2025 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="n6RwMuSp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC927FD70
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915950; cv=none; b=X4BbiyqxXfDd16ShyoUXWFpiCKDbm6t4jp268/8wfyXpayJ37t3lnidfIEtIGHmRTRa1VSQJie+O8xCR0FriwAEFlliA45VqTAOPL7ltDiJfiG32HT2tIbS0dWaNqIZLF36D2Megs9qn+fJmIEGjSx5WLfyP8A+LKUNZgwKMHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915950; c=relaxed/simple;
	bh=UXd6ZBRFfyXJOZgQdgT9dBLzGRXvPHd03emOjSyDqxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szR5H7NylxzVYpKGGvrZZEhAnEttF7ycwNYj3CmIbC0nq4/YYhR4w0o5jkmf/dKjd2vVUpgOeMTcrzu00VLXO5gKa60l6aI/UN6qqkTm671YxXdVjShj66mOzL2EO/qbjTB5Mew6Jl+WQwQuiFclkNO3OKwzCHy8RpwQhtHaCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=n6RwMuSp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d65cb6e8aso7354994e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745915947; x=1746520747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXd6ZBRFfyXJOZgQdgT9dBLzGRXvPHd03emOjSyDqxM=;
        b=n6RwMuSpP6AkmsI/2yevJMtpE6g9Kd1dNdZ5AVb7T6G+NJ1G+k7Az5ONBmmtpDYHf0
         Lzo5QA7fdy5orVNAn/hh7qEXcM0PtI3wh2pIbqMPfC66nbwABl1K5/ymMnhv8Q+X9Kq8
         3F/uJf3JrHg/VEhbX4Ms92lbZ3i6O0lo7M2w4AwmOLBcmRg1DqQj6wbGZC06XwQj7aF+
         Mr6/3/cID6/FL18dwlqIXcHxaCCakrTxmksKWAMfTZtp3iDLpCqqOQOkfonYE09MVKi1
         BShVXIDgLWRbclOEoRgb5lPPLlYbr3hZmhqwcc0jVjTfWF4/dA6fYY9Z7Z5He5+v1eWf
         9rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915947; x=1746520747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXd6ZBRFfyXJOZgQdgT9dBLzGRXvPHd03emOjSyDqxM=;
        b=mg7rs0CeBXrWo18GuzJltoHYmYwg5882i3SNFWHqOk5U56Gonkjy2t+AbtOgHhK6Ei
         4rwaSr1rr6RtfPUoh2dr0UqrLM3yfCSzT3uBSJThKPTlI0XJPEQcFGk4Cx4G4zwxk/Cd
         H5a/n7xA2R010lDBJwOr8JRMzDeMZQOWbezgPVUKypJ2aZQgE3TmcQZndNzxk0eEyc1l
         R5FHvOPABc4lgVxOx6A6nAreOuIEQFiykxb3+/4Gzkaz8GemBXZCBtB6wj3Mh4tfoXKP
         BaDcTy0SJ6YWEzUwrjxYxrF6Dy1y4/kwSbYEXx/FjNvPWMDJ0RdnkFvlPpj33elwlQp3
         KXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXtX4wzq7HSj4zOh5Lf9aoeDDjkKDUm2YggE3gdocvWmwuEpcoMHfvN0fPbp6jz10WOOzYfUKxdxtTJUf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFeFBko1XMfIcSvHcHXdsPcH/aL9jf14Azigd/cbxZJaPfi0J8
	88Zz6NrgJrnADnvttprVKEe/ZGe0OASc5xwBZLTnSdMK+8du2FvF8Vn8U6N1iw09LxHyd3w+Pw0
	UQSwBjEtS9jVJJ5RMtilZMfS2XgB0VHtDK+ji6g==
X-Gm-Gg: ASbGnctG7qOaeI6ZT0WV3HjiFGSene8IXQalxpP4fW6K0+ddr8TqMsNBrBzvQbBPq/o
	2JBgeMRDwgriFhY/hxFOraGKTMP1ptS+0L9+fqHVe60t3ok/2PgQRE5FybbdRggyCevLdFygKa2
	nMtDE09uCHXEVlQouATYLf3E3NqoqVsAoz7nGkvoknM/ZPegJeGCSgQWZcnTdEB/Tx
X-Google-Smtp-Source: AGHT+IENnVjqUwXNLAYDfTiNrsEIWwNs+6d+NpV5FHnYd17iK45VPUqKM3XyJFL4hddosaZTQWV2RnYYV/NteWYUjPg=
X-Received: by 2002:a05:6512:400c:b0:545:5d:a5ea with SMTP id
 2adb3069b0e04-54e9e537c34mr615854e87.3.1745915946982; Tue, 29 Apr 2025
 01:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org> <20250429-max77759-mfd-v8-5-72d72dc79a1f@linaro.org>
In-Reply-To: <20250429-max77759-mfd-v8-5-72d72dc79a1f@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Apr 2025 10:38:54 +0200
X-Gm-Features: ATxdqUHQUcFHUAFI3-nZJt5a9IRI1ekBnea7Lczn1CqKEhZ8m8SpsIrkkBLDoLk
Message-ID: <CAMRc=MeizZec6YkYhNDEh4kE4hRO_wJccE=iy0-PKu7uX52u1w@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:22=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

