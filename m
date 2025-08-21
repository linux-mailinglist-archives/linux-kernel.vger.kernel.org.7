Return-Path: <linux-kernel+bounces-780768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8CB30920
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1726AE889E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F082EA463;
	Thu, 21 Aug 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOoHi0Ui"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB21202F93
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814901; cv=none; b=BL4Xy3iXoEyIJHj6cUJCqCl+rNJdQ7NdY0t1Powktm8rOic2XjuBJDN49YFbZUt1b/uv3vDdNnwA1u6V2GGCztd46fTtaezxF+lx019L/5RxtXaytnpe5CWNj6I3FUc4SBqYfknBTpZWSKFrjGCCgIMQIK4CEhq7GjnJZcgA3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814901; c=relaxed/simple;
	bh=UnLbFeNqq7avzDTdoROz1tobjhAOKS9cwykmPx2ktUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCxn+DOwuDqu1DhMYBsGrBXZ75bdFNOxnkTN8n2Jd0RP2eLeK8S8t/j0GLIPVuZn1MlLlP50n8JN3znC8loUIhS0x8BMXPn/rw1pdKSoBCYV8pK18M7uBt7CW4dQj2cv9U6LNBwJZDf2s5T3HxtlV20+66BGw0KkhhBFb9o6rhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOoHi0Ui; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f918d71eso10706701fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755814895; x=1756419695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnLbFeNqq7avzDTdoROz1tobjhAOKS9cwykmPx2ktUA=;
        b=HOoHi0UixxikYGIM53Wfyvnv2YaKUSYz5YLi1wHsj3zl05NSXHoRuJra3wXwYEG+bq
         6P6vuIyfvFkBl9W4J0bD+4caFmMQyXAAgO8rSKhadgN3o92KkzRAhKbbFQkRlcVthI2v
         Z+oxV75Al7p6/lZZLQ1bYxwuFAldhqsM7wwqWtMXMG3EqmhYY3oCuug+FyNArHmQ97N3
         mIpSLRnRtrExhKMQcgajGl/WOYpvvOUr/cnjTp3ezEq0OCZ4u7szarVn45AlqgSQglKD
         UOT3JWFhpISF+uHsZ0oHs3QTeYQTH/R8jiNE9uFtq6NkGOvD+mN0mXcUbyH9ywhCGJ38
         HwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814895; x=1756419695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnLbFeNqq7avzDTdoROz1tobjhAOKS9cwykmPx2ktUA=;
        b=T1Io5qWqfhIs4iHKQ0E5cO2gMMAg4OOJXT9UcxKXor22nn41Sj2lRBSOL3FrsFtdlG
         5bN6iI76HGakkK8EfRBsrbjS6nyGOWJzO3cBDbi0ITQ7jKevdpbXzd8R1HaLO8cAEY3b
         y4+vBCaNWVk1CRoi3sS3UKlhQGOqZQgpkpsIopBjGcbUx65neEZDm/280htbFUWEDGpt
         CSe6Hi6tuLUYIyvoMEDPPZYdtP5eQ5QAw5VjROTG9PIBH9Y6Z3aMSClt4ZQl8HLAEkR4
         E9EF2IrvD7q+zuwHdfToBVSKOhfZcdeZ6SCLPfcD6eRFcN4Y8C5H6WdMzg3sPXoE1B92
         zETw==
X-Forwarded-Encrypted: i=1; AJvYcCUbhbASJ4BiZMGvs3zfjhPHObYLDw1bGwwbexgsLPTLMd5G/0D1IdDnE6bNjeJcoxVGHQ3tElflBr0gpug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqbewbHTllS+rl3SVUB+mD6i7HLq6cMUVhzH4ODFXl0dz2tOm/
	CZ8CNVLRrrd9V5RGQLxr/5M3eDDLOzX99vaR3sAjTF3XpOBnT4e6JYXu5u/x3k43LzvV3fFaCXQ
	WH53DJCzyvT7hC0HIafRkiqCUXXRa00LsaKpdOHhWBQ==
X-Gm-Gg: ASbGncsfkLd92M4hmNX3wy+ixwolIQwcogoYYNfRxK1fYGnAv19q/W7UgDLErPoPnJz
	1Ogh2DsoYkbWwyK253ka6GMinqJp0zZrTK6C2HuliK6kSzeaKtH0aY79E+yOCHq+WqDIHxy9Om3
	sREUjBFHaLhpaItrfqgYpt6oeE5jgl5qFGrB0VT52amDgFqN17tTvs9rnfron7EwjarFYkgGa7y
	AvGbbQ=
X-Google-Smtp-Source: AGHT+IFS/hjiAZsrBtop5XCFciJi9eFP3IedOZuSAiBE+UQ71ZhxAO5GJMkg1G20lNwT1ii0tPrNlXvDS1ipWk+clGI=
X-Received: by 2002:a2e:a018:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-33650de81e9mr2119481fa.6.1755814895432; Thu, 21 Aug 2025
 15:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821215703.869628-1-robh@kernel.org> <20250821215703.869628-2-robh@kernel.org>
In-Reply-To: <20250821215703.869628-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Aug 2025 00:21:24 +0200
X-Gm-Features: Ac12FXzKWiHUR0LNVTk-WVKUiLjwlocmimUVt0NrbbhUZa5VeD588kLhYF24RU4
Message-ID: <CACRpkdY5Oi6sM8i2OQFkSYUQ-Wwi4FTD3Q3uQ=C6BJyTo8FPKQ@mail.gmail.com>
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

This should probably be tagged for stable since there is
a device tree using this (correct) compatible and it doesn't
probe right now.

Yours,
Linus Walleij

