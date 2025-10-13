Return-Path: <linux-kernel+bounces-850493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFBBBD2F98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5574F0EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F92690E7;
	Mon, 13 Oct 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBMizyL0"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFA274B39
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358686; cv=none; b=PF3Wk2Ub0rBt3yekDI1vFTfyxQYWJl526mRmE2Za1BVUdxp2YaMdosjt9NLc4SAcah9arbXod5eSecgRTIotEK1a+pZ/SE6P9jscr3AfJKDUiHIxy4/XFj5AHZ5U1eIw6Dt7hd0yIcd34zcvLCLZhRFoUwtfloAtygCHEGUsc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358686; c=relaxed/simple;
	bh=2ym5gY9xA9byPvmYe/LAnl2zuqmEeBpK22V+iVpRSl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvw4mltGbkKxH3YTPUH9se9xNwbuiYtQLBQBdY2JuZF6dsf1W9rTqyJbXbAmzyM3tQxw+T7anoOPWnNrWd8fOrI7qn0iRuJzMK2OWOdiO2i5vn9YZ+1XSjM+MeZ65Z5btVIQMxIEygEwYod5gbxzhgFsy7Wl25J2+mggsDD4LMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xBMizyL0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-367444a3e2aso43538941fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760358682; x=1760963482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ym5gY9xA9byPvmYe/LAnl2zuqmEeBpK22V+iVpRSl8=;
        b=xBMizyL0Yx4d+8V+t9wiLgRPf4qBDuLUoSk7nAy7nMVbSgvUM5u6sVw6tdW+UOA0uK
         WTIaGuK/YSQkX5xE1xkspf5Xa8gbM1P603nTohLUMWTaU0PMp/DgUZhus22CfaPt2+cq
         MaKmkZjnlRhLwtqsnNMi4HYh65DKMhL2kdvMkZWR5+8nM2R43uU4zYwwP7QDgPtgaCZt
         V4c37OkRydHs1F+K5HSRt+HJ1Vy+0DzwIHxwv52ibtuVYlnQYN/npAviapyFAIy9L5fO
         UUOcOoLkdBzTFAHTy41/cG6VBDJzAkrOAI3lAnyueZY64p90rNQa/8q80sH8i4GYdrWa
         CB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358682; x=1760963482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ym5gY9xA9byPvmYe/LAnl2zuqmEeBpK22V+iVpRSl8=;
        b=nfyYhQ67pQN2JEdQQrj4p952tmzGpj34iqrWeiTHDh5a0956nBWG9Ow9dKqzRyCM2k
         wOfA4o255HYfpjMoBkyXx4M9L7MjzC58Vbqfa2/jQxq0sbRSNDVfhTkKq6Q8JkFjH73G
         9dTiZFmdDuKY676/I17NzHCrEYMzG+1R2nlNuZPhy/KGqJLH+pKOyWNSF3nIgztgjIMP
         pd+BOey8eG9muDTc2/c/FO0lm6LD1xXXOqxeSIaJXcfYqwvyGHTGmUbRUId4qFJEoHYy
         QuS7YafqgplUQbAjnWwJ0tP3VkvRKToiTJQMSYf6Ft2dBfVDlZqVGatX416GyOB1VkMQ
         7J9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHQJ/C0d9HOKyCp1xXas1Cdyw8EGm2yPzvHJ4dktwTAMqubyBOZutsVc5tYkKBGg3C73wsfxNpbUaAXkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/lmqLzlCL4EU5qJjrKCSSJaaixXhQunMRdqpIA81RBeEuVwI
	T1al53UsEi6HWXif7g+ADbCml/VqDqAOLegbMS+Z7AOPuow0puVwR8sXgj9lCAuMbsaZtCqQw4K
	1TGMpWezIjeiRXZTH0pAIeF2/r9OOG7zPdi0+eM3yrg==
X-Gm-Gg: ASbGnctyHK97HzWS2DozrDQ96wnK0UBgd/VpcoeoBWlzhhaB2VPd3wKrHw1yDVK/1EN
	8iM3eRu8u0NdIMe1U6JXG4vbGBwAElq2QrP/Xcetgw0TITBmZFXnlBxRp6t/RbmtYAuBsCLeRLg
	k5yvd1/bmw6ZMN6jFxr+RVOZ/7kyhwoOgaxQ17ixn3VeR2xbo/dktakibvdZCLkV5IyA6cvonhF
	L/avwdycCg2SKuiPvUr/h+RUGKFQw==
X-Google-Smtp-Source: AGHT+IFhwWUPdXGLE0UdPh1E3Z3kooNDTKBbQ5Xa5NjbLWLHkeWPvOb7Esb2TwKqbW3L7KgA6OggyzZuCUYLfacZ1yE=
X-Received: by 2002:a05:651c:4394:20b0:376:45a3:27c4 with SMTP id
 38308e7fff4ca-37645a32d2dmr19358931fa.5.1760358681978; Mon, 13 Oct 2025
 05:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com> <072180743039027b8476525bfb3d04b3dd044be1.1759824376.git.mazziesaccount@gmail.com>
In-Reply-To: <072180743039027b8476525bfb3d04b3dd044be1.1759824376.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 14:31:10 +0200
X-Gm-Features: AS18NWDff60qRd91QHkSir_vcs0VB7YoMwPxzCmgcXZWdg7IkB5T6vF1_imU3OI
Message-ID: <CACRpkdYZ_jdKZWEBbb5muJZkUfd=nh=j4ffQQEoDJuEjoGzLgw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/13] dt-bindings: Add trickle-charge upper limit
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:33=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> Some of the chargers for lithium-ion batteries use a trickle-charging as
> a first charging phase for very empty batteries, to "wake-up" the battery=
.
> Trickle-charging is a low current, constant current phase. After the
> voltage of the very empty battery has reached an upper limit for
> trickle charging, the pre-charge phase is started with a higher current.
>
> Allow defining the upper limit for trickle charging voltage, after which
> the charging should be changed to the pre-charging.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

This is good stuff.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

