Return-Path: <linux-kernel+bounces-780759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9645B30901
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34CE4E5B30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C922EBDD6;
	Thu, 21 Aug 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIaeyN4D"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F22877CB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814733; cv=none; b=PeGEXAzEZicXkt9Lw+aCvABLIDAxHI1FxmfH6NbL47xTkP6ialxAQWSUZGAEa+TPWOi5a58zpFVrUrJJpqOXc7JU7VFK+TBJW0Bt1snfd1GT38RXPnQSLTraPYPa9pegRP8YGz6hxJzJyWH1Slux4Bu8mWYE4kTrRcR2dG2hMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814733; c=relaxed/simple;
	bh=scDUFRtT56c4lGpfWuR+4hgZjMvH2DXiLmpfUNZTmfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJxr9++90+rLKl6vMGBRP+R3E1+zkbVKUIhSexeKlOFUB2PYqX1QoirLzIZspRKQPU4+xbJESq34DL0B6/uCEoThC6dYqF4o23xre16L5HSMjly2wQJqWNaRoq6SgCr5hYRy64D6iKo3KdWpYJIF1cj2RFsk/geiSZmRr/+j6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yIaeyN4D; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f92f1911so11129591fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755814730; x=1756419530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scDUFRtT56c4lGpfWuR+4hgZjMvH2DXiLmpfUNZTmfk=;
        b=yIaeyN4DTBXgzWZ2254SVr4t8tV8JOOUzkp63OIXvy1Y6JZlB2pP+bKhfkI6tcDmeZ
         2f7bPPAMNMw2LezTfll/F32Ew0ybERmAQPKsygYJ09GlwDWQXxS4e46OmTzPj7d+N6dN
         m3nRrkTCBEthccmF2E8Mbja7sJUimPsQTvE2y/1aC5BcFJink7RLnF9nnhfJMFmnQLkg
         ErZ/uG1UTe3rp+rWFKurAL5bkGFT5rJwFzRIltIfAnEhwRGeetyYO17ClZ3uGpav3rDo
         6DqLU3pVEbJimKqfPhtw7oUN2zpHk6Y3im7kiCqWs90b6T1zjgA0tZC8MhsU1R+QV1WW
         zW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814730; x=1756419530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scDUFRtT56c4lGpfWuR+4hgZjMvH2DXiLmpfUNZTmfk=;
        b=k7spmg2NoOEWmtQpvCPk2ABoitSXYieT7wIHAzKWSupsurmfS8uvSphy4SNCNo1iKY
         Hkrhofcul4eK0Mnrim6cXpuvFOyUVangMiAb1PKVJ9V9WRDqPGSY11Gd1yWiOCrXWbmD
         biBax94bJ7ErFpKdW/JF2dNvJF+HZe1+3cbkYqXF+CYPn8sizGnxtL1xUOQ1qh+r2rLR
         pnWIcOZzjsfis0gEjbx70VZ7qeodpC8NPQIpXBAEZrK/XSmgdSR0V9qeJBTSUS3GFSMW
         DXHtukqqLc6Ww6Hgu61xDeICfi4fI6djE6z8vnsKr7KIz4nBrVQMYB7e/ZbSvcJNO69b
         CVYw==
X-Forwarded-Encrypted: i=1; AJvYcCXuY3jHbrxfH4WNjPuKTbBtlPHLHVtv1vebyEYlKFrX2nnz2bdAjclMKjYDa2WAkIETA2L4i/rB6OyqwJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMDDtaB9hgPX5MjIrih6gEiPdQkeJmqwfEwydqrxaGXKh+Fs/
	l6Hh44W1wyFQlayH6UiHbMdHTIUK3AVo7ga0N7biHKFE9XKX+NWhHOYM9z5KkFxIjx0Jc5toB6i
	YZoyitdzZGg0HNcms+QaAie8XHR9qAl4GVo8N0ehLrg==
X-Gm-Gg: ASbGncutbUv7aZqO4zSACrgV895fgy5YgwS3ez0g0i6w8TA/P3WeZrd9CQpHx9dUhzJ
	KlMwcFO7gVDUsI+/h6VgKbDAWBbIyLBjK13EGcCdbu4adWVfFrG2QJJ+p2KmUHxo0M8GYL+UtvI
	o9YmDA6qpO8iUnpdab47X3mrwu4XlAiQa6ywvPPhInkGCL1XHOSTj5JGd3nHyo6jXBrKQHdUZ4C
	sm1WoI=
X-Google-Smtp-Source: AGHT+IHAuxKCdlR84mtO5drg2+gxJgeAL9QNmrcJAdYu2O7QcZlAuNtYHawQsJ5k3qx7cU6iNw0w7kfx2Two9+P/wtA=
X-Received: by 2002:a2e:b88d:0:b0:335:4478:171e with SMTP id
 38308e7fff4ca-33650fc2879mr2148671fa.44.1755814729566; Thu, 21 Aug 2025
 15:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821215703.869628-1-robh@kernel.org> <20250821215703.869628-2-robh@kernel.org>
In-Reply-To: <20250821215703.869628-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Aug 2025 00:18:38 +0200
X-Gm-Features: Ac12FXz-tpmz6Jl-OSCUAHGGbihqCF22CiiIXs30ksnT0lLjvQKZD3uLJLa_EZQ
Message-ID: <CACRpkdaG38-0-RsMm9zxhADBgVg6z3V5vOY0D1pR81Depfk32w@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: x1205: Fix Xicor X1205 vendor prefix
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:57=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> The vendor for the X1205 RTC is not Xircom, but Xicor which was acquired
> by Intersil. Since the I2C subsystem drops the vendor prefix for driver
> matching, the vendor prefix hasn't mattered.
>
> Fixes: 6875404fdb44 ("rtc: x1205: Add DT probing support")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

