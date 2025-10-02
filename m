Return-Path: <linux-kernel+bounces-840455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3248BB476E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5623A0574
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463524679E;
	Thu,  2 Oct 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM+LeLbC"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4DD2459C9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421712; cv=none; b=SnfR1QjaQ77PSCc5oRnPN8AdzyGyNk/AnW8HU3L77TKbtyHBcJnSvRyIFiw7Gx51Ce+2BYALlBcBJ6A0KQxTIaCHmjppnyJIOAFD5DX/vD96smnIA7z0VikKkTtkIJgC5cReuyG5McKZDGPf5IJ507kYtCWqGGtpOAHXNymD5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421712; c=relaxed/simple;
	bh=l5OAi7HzDsDRfIL/UoL9RRK/6kinPrW4yzeqvaZDp5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmKZrctEkMCgyZ+Ujue2t9964tO00tHKvvESMBu2njf3rt5vaiB7HinwsJMg9d/gZaebif14Q/kHwUIPqLqi0zsshK15v2xprhZD7POj7loFfgcqVnq00+/33mMNFSkvfA42VlJzEnlsltY4b/UPJ6U/rh3vqOSZIE8uTNrr/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM+LeLbC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1235650a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421710; x=1760026510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbCJESHJ8jqO/tcwMWV6sW/NG3xdKaEr0isON+x8Jhs=;
        b=bM+LeLbCFBvZJuWdwS82NQ85eyhROqbgwavD/nx2IQ/E6ZP/s9zhKcfKFotyvSQVR8
         Y+IvgkQVodYtLJ2g+uJHNokxI4eKZOCp73m/7dqvb5Nr7ksOZuUix4D7CmtTZfoOaucj
         dYJ3+i85k3sTcxkrTT+BjWi+qCDrEQmCYRCdlvoH1mO3m0hEhsZcD8oW7nbbLnw8ZP4w
         DI3qcue8a80vSlhDMiudweRt0ftUHWWXBqYrIUvuujY0Swhv5XtQ/swW3KeEA/VZ4MVe
         E5MtPGewTghQIqZoJv/ex47GZtKc+mg6k7pOxBni5CnEiiZHg0YyFuq5Dgx9jzKwPQr2
         S6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421710; x=1760026510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbCJESHJ8jqO/tcwMWV6sW/NG3xdKaEr0isON+x8Jhs=;
        b=vBLZCi7WKPkHKhlOUpPdLKumXAioRwosfliCJTUKE5x8EGYx7Tmx3LgZQpMo2iqDpA
         1PuM9FxIhuCmm1mQGgABNh4vfrdM1raSUiFICLJCbsEzgDRO47tEp99DpQP23sGPtK9B
         oD8lEAounOD5QAWwySpY8goWjE6ELvlQe2ukhZTnQ9h9zRmc+N3/yBTISAl0TglZRvDz
         qMK35OoxHul8IZqIoDRDr4S0iYnatURUpnev8SvH0PiI4JBHyqPVOHm7AxkIVAuV2GFL
         y9TN5zJqKU02Yx7xf11h1Aylo0+JNg2CrXT78aJIHOdX4Xwyd1XbprwzfO/BV40An4pt
         EH+w==
X-Forwarded-Encrypted: i=1; AJvYcCUi3gHSem1Sx1CfhEIRw4XapQqe5eXM1iRdPXEm/LN+eSGdTqrCgcXBrmhVj/XeGm+FexlSqGAg7yBIIuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdzofyx5dAgvH9zSF7Wi47xE+kJt5EZCtfHiXFuTGULFvSXIU
	chp3XZw01twlTXe2/Zf0f3PxtrLGrVqJUZKzy4/CJug9HB8XMVdTwkXH9+QpeZ23xmyf73M7QKn
	42TBGDWcgr8ZXG5gOZCjLK4LrTOv7okQ=
X-Gm-Gg: ASbGncsKU1eCOKag5D+KtMSQIveDjbyljczU0M7A5tSNEA9bIvXN57EVCMloqnz/8Ov
	kHlVgwx6k9hb8RYLf3I0RexwsJhcvM24Co6HE5PBQZSyvofxWswo/sgoOolIaJwHz9/HFcFjssi
	g5yTaAGhP4O6ZMVPm2LMtv3yA+woVQsxgwbdAQhBJ4QFNdRlrlL0XF7bXao7vUzO/s5QcVPpkkL
	bAhZVDYv5Py0QlSrfGbjU4l8aMydQQ=
X-Google-Smtp-Source: AGHT+IEf/mVaOwfwTajphWCRjS6OZaY41dyU0wDwW//TvmvlN1jWg/44MGVLKIueiWV72E2HWtd5YlRbRRes8q78y1U=
X-Received: by 2002:a17:90b:3ec3:b0:327:f216:4360 with SMTP id
 98e67ed59e1d1-339a6e749ebmr9175147a91.8.1759421710377; Thu, 02 Oct 2025
 09:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>
 <175589097127.178922.52729764188594464.robh@kernel.org> <20250825115939.4c1ed3b7@jic23-huawei>
In-Reply-To: <20250825115939.4c1ed3b7@jic23-huawei>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:20:07 -0400
X-Gm-Features: AS18NWBZEPufzTSyN91BU_EyEGNa6W6EgE6V8aWkwSThLDVcbiogsfNGWk9PRA4
Message-ID: <CALC8CXfG1XrK4-HMP=8pRYhEHNY=A+J-s5rKr29cDXNNAUMkJQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup
 in example
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Kim Seer Paller <kimseer.paller@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Russkie, you are a raycist

On Mon, Aug 25, 2025 at 7:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 22 Aug 2025 14:29:31 -0500
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
>
> > On Thu, 21 Aug 2025 10:31:51 +0200, Krzysztof Kozlowski wrote:
> > > The DTS code coding style expects exactly one space around '=3D'
> > > character.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> >
> >
>
> Applied. thanks
>

