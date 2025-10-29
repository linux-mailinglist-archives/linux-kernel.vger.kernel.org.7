Return-Path: <linux-kernel+bounces-876329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68913C1B8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B20AC5098A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9925A65B;
	Wed, 29 Oct 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNNBHgiM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A525B2FE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747490; cv=none; b=BEx9paRS1U42OBFUEjohugQqmXUYBZYsnyEJivy9n7NxZ+rg77fVallEWUmioOX5aBHt8Dt94ajpTXWxMWsaBpqBQDnGu5BvuVUOjdqmTuhXBqdCMY7PkTOOSJhkggRGWkQwqKWSVUIlWcb77fpKnoVIQ/K3QIZWUzsslORc8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747490; c=relaxed/simple;
	bh=frTWN0cj1Au3rEU4gpiwgwDW+TjseVAAzDE0208pNEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOmquFuvZtNSJ27xGB9hl58ofMuMPI2sEQFNB2bEY89fw8gQm7Ii6WsnjfMIW3qgXKe0Q8QoU/yVOn9CiRGyce0+wDbweLLt1LzxNTMp6jmPEY5aOT7Gux9EIbDdY9DUZuk4tMVWJA0KEaQHABk6GgKDBYZJxUqRiK0lzs71f7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNNBHgiM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-376466f1280so107273541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761747486; x=1762352286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frTWN0cj1Au3rEU4gpiwgwDW+TjseVAAzDE0208pNEM=;
        b=fNNBHgiMNI0TIlvEx6R6wRfbghAfSTazTR3aa08KdX5HGuHK8iWNWJCjUpzUuBXaR6
         yeQjhRM8DHkD+vh4DMZLHWCxMsWrj1twIaM0jL8JmhfpU2WvBpXYXSRWZJrYwgzpoVc2
         7m/Cz0PSY8P/KI/yhSXivQIdTCdLOAzX/vjVKuHaI/nGZ7+riZq6LKuDnwrtH6IK+GAo
         mubYsufFVqczHa5FdZk57qwU+oyQGqsm5pwnNgCxATNyWpro6XFhX8FTfLg5zWlJ0mHU
         ZXRdy0DRfuSxFtLmvXxe8A6Ym4EYdIyPG6mtzFvABxDKnrEu1KGIVju3KeVhi5/TcaIs
         nWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747486; x=1762352286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frTWN0cj1Au3rEU4gpiwgwDW+TjseVAAzDE0208pNEM=;
        b=u2UyNiifwtneE+gL4gVhMzOWGaGvYRFln9N28IGS88UcN2lz28v0x/LKD4/UJrJpWF
         ZW2hqfdQxJJsiks2NvZkgaE+BGeKomOEqZa7p6ZIwHHu6xEVJ7rGqW87W61Wu0yz59Q4
         H78i/OI6OPzSIOd2rRpNE5tw8tFuWdEj13tfH4My9yvXC09RF/Y0VoXCcUO5m0O/eJls
         Cyg5NMn1REU66MvQZ2Dz7Ij/O8BUaFNjA+5OUJdtJBF10QsXziRjWMtPBzvolZ52tj3y
         41ppYSpVt+6BwM3JpXOFfBbplYHiG871bMdfeNq9UeZelFbmLLXA14mrz3yEJIMgzrh/
         rr7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCM4fqLeqVVm3n2Kwe8BcsJIIrnrsiVsQoEzX5uqYsNjl+8EvQ4w3B84wyBlXbcZnlxhIKR4Zqh3ixNcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchnQl4LfuiTGNHJM5Ffl8jwC3zpG5s78CDGpvztWDfGUn4ZF8
	hHJ0HdXr9dhVaGlV+rLD6XEuY4tCjnWf8NShfVV+5FtRiQ4DHxFpiVtVc596ohFBC8AQnnwi1BF
	20nPA8mX/wMXpPTCj4tmy+F6fiLl3KTYwQc8A1cq5xg==
X-Gm-Gg: ASbGnctnR6nheKF+DPt0ZT4nW2Nif486zwS7LDQ0hYMJM8ChIo1OTsEmnZuzp/ex1no
	ZZYkeCU7pn/LC/0Y3BUUZYrQ0HI2p9vVdj2etYH/Ezd19qtnR+DYF3MCm4FekQdw0n2VAK1V4pV
	bPSiO/2yf/iJufWysTcUD2Ugexexh1BiVeimy+Dp0OWXxL4GvyT/4SQlyT0Qy0cggzPl6S/+Wit
	gU/t9IfvZyrxKmBvekrnBvM4kpqO+qdNhOEGI4lKgc6LwiVfPZGhTAcL2yqqcmRmjpz18c0Qs2R
	EJssXQ==
X-Google-Smtp-Source: AGHT+IEZ48qPNDXi/VZK0viwyJMlNZCVVeDAAKNtz0dWhXoCt8yrbWYQfSCBbIwkB65d0mwMlwxIaale+Ln0IHl2XVM=
X-Received: by 2002:a05:6512:1253:b0:55f:4efe:42df with SMTP id
 2adb3069b0e04-59412c47659mr1221054e87.40.1761747485600; Wed, 29 Oct 2025
 07:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761576798.git.dan.carpenter@linaro.org> <82a8a4b206ec02dd27a119d7f05d2bd6c8d2d3fe.1761576798.git.dan.carpenter@linaro.org>
In-Reply-To: <82a8a4b206ec02dd27a119d7f05d2bd6c8d2d3fe.1761576798.git.dan.carpenter@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 15:17:53 +0100
X-Gm-Features: AWmQ_bkpWoC7MJl6ilguYr2pkMyaF1lhvihQmCr9qcCK8P7laPbsgsH7ZdH72KA
Message-ID: <CACRpkdZMQh2ozd_YTjRgUvVwdAwHpDz9G+ZYYHBQ456GLjPZZg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl-scmi: remove unused struct members
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> The ->pins and ->nr_pins members are not used so delete them.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied!

Yours,
Linus Walleij

