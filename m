Return-Path: <linux-kernel+bounces-736504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB3B09DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953B01C42385
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF1820B7F4;
	Fri, 18 Jul 2025 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wxAi4bhi"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54921D00A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826886; cv=none; b=I31nzpntakE+NrBIwZxeWiHO7MWLn73g8LdibzWJvwAwP31wlwJheDGefdPdHmEKk2IdiGqf8tqaGgGtbM3oTE2lCWzTyZOpxPz64F+zCdYutcvGdkFr25gRXQiwxQacnl4ySAtsoGYFIKZOxoVkcu8N1T9xwn1+aSgMTHTQI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826886; c=relaxed/simple;
	bh=ehBRfidVMiTgGu4yqitjDYf9E4aZ2H0XQi7Akm7vD3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2Uu1kN/PbR/nuIJ8nmhR6WLSsIga7cxw76LNDfKgjsSKoFXqGLLb+6IVdrWVbtcP5jViVr9YG92wbTTgMo2pr8QIrZkd/dofR2RS9mQzGJCP4TPrzx+6zwYBxCAGRf6qDiSPXIHMgxk1ri8N2PgfJUntB6YGqINCpDlF2Kl5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wxAi4bhi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-555024588a8so1733511e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752826883; x=1753431683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehBRfidVMiTgGu4yqitjDYf9E4aZ2H0XQi7Akm7vD3s=;
        b=wxAi4bhiOUU3MfYunI+AG6YzRVV5pig1KV5XWgiqVH1IylauN/Y4U23DDUspwOYm7g
         7a5MDJfIL4N9CF5gJSO8bANSbpRvslHuGmzXsAv6TDRnvpWAdIfJfGEN/Ks5nQJhVFHE
         daOqV5rncYKJC0TD+sUVY8K+HzWvZm95VHTe+JfW2Zj+wj6lH2ZPbyJcoIrN5JLDeXCB
         owYeSXbP93Yusw7+8QXWjd3+Gxz4iqngm9UrnhHgKw8ZgeF8Ef318qNNdUKiSzqAe5K3
         rZzONZge8NT424LlrteslQ//Mkkc8YbL/y2/CBdJ4kvaf444DUZYfaCDHLb+EehCfXO4
         yKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826883; x=1753431683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehBRfidVMiTgGu4yqitjDYf9E4aZ2H0XQi7Akm7vD3s=;
        b=b4o8fOq8autgp9hJG6vWp5jaNKob4tlMMuExQaKIMlhTPGEhyGUqEPQeE3derLNGWV
         LLS6GkpCUVQZELDnUNG3aFsgGmravF239QrxD8fxD5dB2TvHvtNfB/RKKyf5RPHAlgh8
         lXOpGWypFM1Msc8jdAeIK0uu3jymL/lfMUPDb2ai4dhqcmLlsgf5izwYm/hxSbG8fR7q
         qLq3laT8RbDux4xoZR5IpCVLsBXNfkwIYQT3PkNKIgVkUcXcW6Ajs4vbKScM1CxJt0Ib
         7o/NGgh5qpcFQhBVTaCRlTi5cPwldQRXqJ/LB5vOVoCZImFhIMt/LVHWlWNyaChQPW9d
         6+kw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7qbjh3oUOkvIKHNH4k/P4Md+2JUhSoeeCPOK8xr2skJS8r5dmg18LLVaIdeYH6LLst5q93Dpq+xUWOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtg4vvH6Pdn6bZ8KkVrPduma5ld/taTIxoxzMNEukHazYTPf2
	R9BZvTNgApy0bheSkb0kJxPANWbP7Td2ePBp/+Ceghe9JRXnW4h0u+U/R13+Utypf6OZHfxjUwl
	rxX+iAhBQzi2y9+Hs/ZeFQ8s4pR6MP8sE9APKssWxog==
X-Gm-Gg: ASbGncv+1O57QIFIQSVh1ufW9/FzJBVfxGiCU8a+OmQ+0a7etbmebniecoqra65U5Pf
	RM594Ufiqf2wT9IciLzP6avkeLOgj3hyrf84/xM7SJ1s8IEf6pbYI88EkR1uK9PEHWN8VH9334U
	FrIiXVlG7eo8Tm540GxRD48WEn/aZKic7Aaibr7ygfx4z98Q/ikcTmkXqArZpYU1T44DlmNoDzR
	s1aoc2ZChhumPYFYM9/i9oeVKUCajl0YkD2Nw==
X-Google-Smtp-Source: AGHT+IEaWSG03ounh8FuQGPFdYkiUPh2qNisS32R9MoEM8O70oPinE1GtqhwtKAZTDuOeWMM/l/IcLkx1x4qZ+HIn40=
X-Received: by 2002:ac2:5616:0:b0:553:a2c0:da70 with SMTP id
 2adb3069b0e04-55a23f563eamr2309934e87.26.1752826882698; Fri, 18 Jul 2025
 01:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714202829.3011298-1-robh@kernel.org> <20250718101147.4906bd60@akair>
In-Reply-To: <20250718101147.4906bd60@akair>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Jul 2025 10:21:11 +0200
X-Gm-Features: Ac12FXybEW0KgacJXEKotlpT_ULwdNJr0HEMAnGR1ZlrBw7Vllv0nLHyyPwCvSw
Message-ID: <CAMRc=Md_r2J50EWFMyr=j+JU+LqcBZQ2z8SR8EbK3pkD_xQkEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: Convert ti,twl4030-gpio to DT schema
To: Andreas Kemnade <andreas@kemnade.info>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:11=E2=80=AFAM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
>
> Am Mon, 14 Jul 2025 15:28:28 -0500
> schrieb "Rob Herring (Arm)" <robh@kernel.org>:
>
> > Convert the TI TWL4030 PMIC GPIO binding to DT schema format. The numbe=
r
> > of #interrupt-cells was wrong compared to what is in use. Correct it to
> > be 1.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> Thanks for taking care of it. Now it is in, but anyway:
>
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

No worries, I updated the tree with your tag.

Bart

