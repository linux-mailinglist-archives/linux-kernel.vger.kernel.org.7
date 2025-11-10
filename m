Return-Path: <linux-kernel+bounces-893416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC10C4753D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 813984E920E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07543313542;
	Mon, 10 Nov 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrKtTsa/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9C31355A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786095; cv=none; b=jEA+KMY2HdGj02P+v7dVDMut66QM2Xds/It6be+B6GLGm8CpwlbrHFLkEil6VOuFleFphSSCxskD2n5ghWn6vykIRPQvxewClwWZID+fjhlTKkHEfsEeGozW4++q3LUZelyHqAyiFKo/LE+IVTZ/xTMAjHGgxshMrj7ETXc6VHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786095; c=relaxed/simple;
	bh=LPHuH34GPzz+FS33GWGiucjUVrgKTliQiQDa8mDrPto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivl7eDXXik1h1tiCQBKMoC3I4ipAs390xvggZULMKZf1V038wM3hPWQiY8fvBsApsVZq8xqp3jDpfRbMnN8qgSi0ZvG9G/RPI+I+5XF43rH/eTSx54wIdKYNHFffmnEnY49KRR77bd4UNuEjFdVaZKD7fv4W18FbCx+GD/zaAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrKtTsa/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so21251055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786091; x=1763390891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPHuH34GPzz+FS33GWGiucjUVrgKTliQiQDa8mDrPto=;
        b=mrKtTsa/Waj1IsC00cI2/hZIW3lo0cdVW7+7mKXNZtIH+0sINwOiud66lJSMlFl8Lu
         NSegLjc9zyP/bcP4NLVFR+4+B28aocJbymeEVpNYIbBcsutZQCOQepec8dkpVYrvGMMg
         vP+gWyegzSO6Zm46s12EwF/AS1aPcASDEhAbjNhtXu+VnvZIkkwucFIKSr53XwvFrGgv
         NB4YEX7XTSmGkCo646UzXMp1x9zuSfLEZxGD6WKGX9nyKeuh5fRJodobCLquBl+JTgPp
         wwdufxIdXyE5kBIOol8fdoGRNht5nrMPZLv/YUhJ44ekIqC0gx5/7SsFRRcZmrROyzsE
         0Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786091; x=1763390891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPHuH34GPzz+FS33GWGiucjUVrgKTliQiQDa8mDrPto=;
        b=p48yRSQdv8UiXGVkuHzl4c836rOAlTxpqc6Au/JfAVNOtqxpoTqOM9EVpZ4pUVgAXg
         EMS2dUr2acigg5F4nAPCVj+EB0mBSkon9qTo5mnVg393Jf3VnqKAtG0CK7qdOBLIr9rt
         mbz5AVaFH6ylW5dv94AjrM4EBmWvTde8RyFQXlXbvgG0VkntqWPehTnw5wi+uWNwL+rj
         UTHlRrQ40Cj5oGJvYLZ33gcZt28QCy/+4H3htuxfZz4wp4qi3yG9WfHw0y696oNypEN7
         IhMjog8yGIVpj5Zc/58JSJtgFPpO+o2aRE54ko/79ZTqJ7o03z0L5+STFXW9GYxyQczy
         /9+A==
X-Forwarded-Encrypted: i=1; AJvYcCXEURQGG8DBXCEMBnKeU2yZ9UQNnbrGggGlwmrmVzcSOQcza0UuD4APJxJnno1Kkm3E2T+B/kKTC8/lL0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UZu0oOIifRLBW2A2bK71YOCbiDY3dzaECmnsLWlqvqUCDle2
	F7j9D6bZjywsreG+uKp6YqZ10f8BpOTw1PK8M2AdHgVoch4Foy2ObhbF+Z3yrzZK
X-Gm-Gg: ASbGncuuCaBWF8piX9ZW2C4J4ojktgmVGRVsfI+cOCXiNXeNiXZCA9AeWm04AkiHKun
	/1l3VCSCZV4brxmBi1u3nFKriZousJ6QEFy+Cazjw2haOgNbwOYXH5KZ4SW2N5h3hMXYiirW6Zc
	m6clfaK/9UKMBJ5r8meqimmsNWi5WcApnYOXTDfx/52+mf+6A2aT16+GuzOSsLSfnG3R0A/1YXB
	bjaLnMEeHuZ7CZlP52i7aTP72qeJednOrcABc8agE1iGhGQ/ljfX1HO7Ss1nHg4v6YOrVrjlLhV
	CG8Sli+WZklddc228ds4Bhb9V1KYJhtP357ftbRBqEVPBCY4wMzdf+IExAtV2dGP2hmVgGnWA9u
	Booq/HctQmlqOIrkG269lEkiH5RwbCzr9bwc3EGB7XjXcQbnoKljjKhNIeUY4JCn76432YmNRXB
	cmvuU/6fGUPxrTpQ7yJQo=
X-Google-Smtp-Source: AGHT+IFyyPGi2h2HdORU5Y7qZAm0mzvGdm657Ujj5pRLIdfkz1ikPx4AlWnK/vjsN3l+QNuYFG0dhA==
X-Received: by 2002:a05:600c:a30d:b0:471:ea1:a460 with SMTP id 5b1f17b1804b1-4776dcbe68cmr86535255e9.11.1762786090588;
        Mon, 10 Nov 2025 06:48:10 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2e052f32sm15817388f8f.17.2025.11.10.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:48:10 -0800 (PST)
Message-ID: <5e0ea52e6a77a1d6af861ba5aaeeea5c3d514705.camel@gmail.com>
Subject: Re: [PATCH v1 0/3] iio: adc: Add AD4134 minimum I/O support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, 	Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, 	conor+dt@kernel.org, corbet@lwn.net,
 cosmin.tanislav@analog.com, 	marcelo.schmitt1@gmail.com
Date: Mon, 10 Nov 2025 14:48:46 +0000
In-Reply-To: <cover.1762777931.git.marcelo.schmitt@analog.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 09:44 -0300, Marcelo Schmitt wrote:
> This patch series adds basic support for ad4134. AD4134 is a very flexibl=
e
> device that can be configured in many different ways. This series aims to
> support the simplest way of interfacing with AD4134 which is called minim=
um I/O
> mode in data sheet. This is essentially usual SPI with the addition of an=
 ODR
> (Output Data Rate) GPIO which functions as conversion start signal in min=
imum
> I/O mode. The CS pin may be connected to a host controller CS pin or grou=
nded.
>=20
> This set provides just one feature:
> - Single-shot ADC sample read.
>=20
> [PATCH 1] Device tree documentation for AD4134.
> [PATCH 2] IIO Linux driver for AD4134.
> [PATCH 3] Initial IIO documentation.
>=20
> There is a driver by Cosmin on ADI Linux tree that supports AD4134 in wir=
ing
> configurations suited for high speed data transfers. Even though the mini=
mum I/O
> support was initialy based on that high speed transfer driver, the result=
 ended
> up becoming entirely different. Also, because the different wiring
> configurations are likely going to use different resources and software
> interfaces, the code for AD4134 support was split into ad4134-spi.c,
> ad4134-common.h, and ad4134-common.c.

I'm familiar with the odd way this part is implemented in ADI tree :). Ques=
tion is, are
you intending to support the high speed bits? I guess so, otherwise having =
the above split
would not make much sense.

- Nuno S=C3=A1

>=20
> With best regards,
> Marcelo
>=20
> Marcelo Schmitt (3):
> =C2=A0 dt-bindings: iio: adc: Add AD4134
> =C2=A0 iio: adc: Initial support for AD4134
> =C2=A0 Docs: iio: Add AD4134
>=20
> =C2=A0.../bindings/iio/adc/adi,ad4134.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 209 +++++++++++++
> =C2=A0Documentation/iio/ad4134.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 58 =
++++
> =C2=A0Documentation/iio/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 9 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 15 +
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/iio/adc/ad4134-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 200 ++++++++++++
> =C2=A0drivers/iio/adc/ad4134-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 132 ++++++++
> =C2=A0drivers/iio/adc/ad4134-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 287 +++++=
+++++++++++++
> =C2=A09 files changed, 913 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad=
4134.yaml
> =C2=A0create mode 100644 Documentation/iio/ad4134.rst
> =C2=A0create mode 100644 drivers/iio/adc/ad4134-common.c
> =C2=A0create mode 100644 drivers/iio/adc/ad4134-common.h
> =C2=A0create mode 100644 drivers/iio/adc/ad4134-spi.c
>=20
>=20
> base-commit: c5411c8b9ed1caf53604bb1a5be3f487988efc98

