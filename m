Return-Path: <linux-kernel+bounces-814577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13EB555D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A5C5C51CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9432A817;
	Fri, 12 Sep 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVeSEIT2"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEE326D54
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700447; cv=none; b=UMs8I7dLD5Ums6pcrvg1Dvrby60Tcxb3gZ8jX/2H7nFm+sgD901dh/k+VEmBQIKMU8LWLWQz8VTGapW6N2ilOpBo209SrgjjRXlKdtnBMygpfEf2j9X3aikEyhFhkCXSSp9MW4tqMHNZJZliaf9Zt2ubEp07YBqpWZ7f35/oZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700447; c=relaxed/simple;
	bh=91UL/ulcV/GEAp0C9VF8AE7Y05XM25NDQ/r3vu0cb3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGNqh7Is5D5/UzYNoPcGBD7AWqwjj7mtgMmhgfIshSz/xN4CsgudLISP7FnvfCXVly2v2nvahTBdN4wt0jWeoGPkTXZ/Xo2u2WPMdaZkFyOigoAbeJwnDziOSP6UlYKu8duA2mhlUyMUoy25tXeEQ+KAsX268gWuMTLpNy7YzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVeSEIT2; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-51d14932f27so958523137.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757700444; x=1758305244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cBY+4I9kDYtnwV9v/6I6ZDitcQUFaZn0asAaZVvZ68=;
        b=nVeSEIT2KoQ0Y0YA266Ke+/OUN74tNGk6x1QMOPi7vyhVFu7l3E5L18M9McO/VW7oV
         Qv4uJbzrx225Z2+dXCWAvCnI7xSodWAxU4q+ExCbsKSy6tW2sloRWKWzDeOX+vesm0u1
         D83C9sVybj3SrkSSKrD8Mz3uZbZuWeBfv4siFDYiDCQzGZjbpLc8dB0agNUwExLv8L5p
         b9aRQgbA9o7XYi3J/arO6NsOS0ZanMiA/MYEG83tZfdxnz20mTlAbGPpDUL63dpObt3o
         1tp78rCZsXi+jW5tygCqukL07uvbntYnVANpfW34UJiUQVu/qM0sbeT2f9McjKOWzSvp
         61JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700444; x=1758305244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cBY+4I9kDYtnwV9v/6I6ZDitcQUFaZn0asAaZVvZ68=;
        b=cbc+qxdoYJElEEi6dO9lBj7sJoOxHLvJft4P9LtfM5DCytPQPPSqqPsyxUp0MXLMJz
         8TAPBTT54P6FMnVt5yH5/VV6AigatrKL621uUFdvCPfpwxoB+VoRsMHeJrzGyrQdBbn6
         2XvQ1I7as3IhK4fxeI5KwwDuo2vP0zioAOthjLN92BQ+FUGSKRDYAZlVYoJzN904mp1y
         d5RwGgwD87CnXDL9TwyH0i3wpyKlDoUDehFMxrq1guWjNGAkoXiXKemKYA+NUQkSprW6
         FXuQooPIHyzSOtlu0MvwyTRwsSXT94wbCxQHPCNZz/9/Rvrxnpff66zTynmcFzNyBUuq
         DgNw==
X-Forwarded-Encrypted: i=1; AJvYcCXoooIf8doI9swY/Nskom7QuCSEdqKyOFYz+K55PJQjvNJzj+PthtmC0gsucXv4YlMH9tvuui5kGMl0m/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDv3jmxfCLrxVAi4LLT/Mm6/Fmhnov2iqShr9sKAA2s5dtJOPt
	NcUuD5p6DYIAtSLXX+5qrk9aekuS2tUABwu/W5V+jNmXA4zWrehA5gg84PKpthzY/+R8iEUbRjC
	rarubbaENFMg0HLm3WhniBH60vcQgWBw=
X-Gm-Gg: ASbGncu8AOgh1nuyJjY8lM90OQoPYYX1nc7F6U1gXZfQNtrBz6ALQp881ut3gohqY0Q
	jAWChV8HZ2LSNXkn57RfUsPe/B9qMjSmXTvKvh3spfa2CY+uFprsGmoCZn4UQFIzT8UKGmlfLPR
	SVDAtkLq9jIDCeMX+70u1/JKbvNnAY5cb8gDY0BcY6qK1YcClc14EV3/TcOHzzJgJBU3Y5sw57T
	a2H7F+ZzYboXDT3
X-Google-Smtp-Source: AGHT+IHA+4YE8uxdOY8mjzHAWOze6g0jysCAnLhY2/U0gcZe9QhNxJxuu1yw+kCWxTzyKi9VvCfDucHKBNGgGt12ZKw=
X-Received: by 2002:a05:6102:808f:b0:525:9f17:9e6e with SMTP id
 ada2fe7eead31-55611a64c15mr1928096137.23.1757700444451; Fri, 12 Sep 2025
 11:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
 <20250911-starqltechn_slpi-v1-1-93ebf951a932@gmail.com> <d95fc175-359f-4559-b680-36de87d75a40@oss.qualcomm.com>
In-Reply-To: <d95fc175-359f-4559-b680-36de87d75a40@oss.qualcomm.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 12 Sep 2025 21:07:13 +0300
X-Gm-Features: AS18NWCeZSM2Dpl4Jrn5JvaZJYtLfchyR4mokH5Ss7_O4FfKDP8nLezjBHbSzhQ
Message-ID: <CABTCjFCaOOJUOp-Cr+OifNTGFe7KUgoftLAhPzCQxuGACrsLmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845-starqltechn: fix slpi
 reserved mem
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 12 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 1-3:=
58, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>:
>
> >
> > However, kernel refuses to boot firmware with 15MiB reserved region.
>
> Why so?
>

It fails with load firmware with:
```
[   22.452709] qcom_q6v5_pas 5c00000.remoteproc: segment outside memory ran=
ge
[   22.453163] remoteproc remoteproc1: can't start rproc slpi: -22
```

I tried to debug print addresses, but those numbers didn't make sense for m=
e.
I updated the commit message to be more clear.

> > Increase slpi reserved region to 16MiB.
>
> It would make sense, given the PIL reserved range is now almost
> contiguous (bar the hole between spss_mem and adsp_mem.. you might
> want to check that one out as well)
>

Actually there's no gap between spss_mem and adsp_mem, adsp starts from
0x97800000, while spss starts from 0x97700000 and occupies 0x100000, so
0x97700000 + 0x100000 =3D 0x97800000.

Also, I noticed, spss_mem is not referenced anywhere.

--=20
Best regards and thanks for review,
Dzmitry

