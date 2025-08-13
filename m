Return-Path: <linux-kernel+bounces-767551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E023B255CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E9B5A0412
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336733009F0;
	Wed, 13 Aug 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvCjV1Ea"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7D2D1931
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121569; cv=none; b=XnSBTADuazZa+9BBbpno3Oil1clOYPuOvjmY9VDXTI5c2kDq197pjwRpJJ5Pdf1AFomUVF/HCb/HCD/8P6CiKHkFzuWQNrM+Q6nkkek8Ksc+6yRnJOJxInrervjlVWXDhjLfp8puTg4D06EncrmPGvCMrkxrmxZ9jln2eV74c+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121569; c=relaxed/simple;
	bh=jIwjqOg+sbjIc/EUA4O97i+3hThQAkP3k3muI8lHGFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuqBSCfnhwYtoNUeCLkWAVgvlMuFSVNtMuFFB5B/hlXYGDBztneIMdNfeGWYHFSXNeDx6BayLZV8nv1UX3hKKg0ZbnMLvBs7rW59O5vc15xrGIG96df1fstL4E5LAhYrkmfUygDHJI77fWJZUBq1AZ85GAThGHRRtpBJCGyoOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvCjV1Ea; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cdfcc0ceaso1336141e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121566; x=1755726366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIwjqOg+sbjIc/EUA4O97i+3hThQAkP3k3muI8lHGFs=;
        b=gvCjV1Eaf9kHCwIQio0EcRp6nPFL4Y+M2vK0KkUW27s+SDeMAzQzR1992y4TiXQP2J
         Ta4O84hBOkGYm9DhRznkiP5/LfzXCjnlpL6/xbKKAFPzGTVLkj99JdQIxnafJv4BL6FV
         BNLjn09Z6sMTC15TRnsbYh8WzVauswaiv7iYc9BDjPLPEv51f8iLoKZ402yBzwH+T2jJ
         NEGxl7XOuy8MWCQ+qRwHRYU5zHFOFfeZHxJbCAcqU/Sbh19R6EzUumBMCAJKcYS9smu5
         KWmNs1VkY5hyY2UDH1+0DNSiFRdF+dPGacYQ20T00TD2e8BPLr3ZXnro5TNUy5ircRJH
         i0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121566; x=1755726366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIwjqOg+sbjIc/EUA4O97i+3hThQAkP3k3muI8lHGFs=;
        b=PNX57SOZM1vGR86LAI8bfn4vIjVOJdSA1BaCOkxDf2l6UVNnlzQgl6nIlJR6HcVZ/3
         hH9tNykRPYhHLFmj2sebHsYEJ77M40ygXVV6Sh+FwLX2AJuewdClv4YmnoppuUmGSHgk
         mgMboWxvrF5PKVoiw1csFaJ/cav354Y5K8zcpbNbHtsyzS2QVtbS7HDqwlbTdb8NVmFK
         riOQjD7MI6mtO7PmKnTWWUjqdhUAot6DbvnCL1usVLY+bPr4wx64xdjI0CxRhex6k0hY
         mQx7mqoHjc2vjMT84GKKiIHO52wCezwU+HNukm5x0qlGc2ukfvSmbKD21s8cDvdzuf5s
         86MA==
X-Forwarded-Encrypted: i=1; AJvYcCW8z+k7HO1DjJnbuOXPcBdfZ51EQ6lzeBRNUsgLBS+CwhnX9A+ptvtsCyka24T6dJVBkSTRzizBQ2s/f8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DXy/FxmBUAAdLj6IYcCDKADvLIgEgMQRV6lguJzcmL+U0RmA
	16mQCZvlkfKT0+JwuWdeQCzIMsEWm4j03xQ5uDw9OjNReT4xMBQxRwIqonuVWHK1+Nv64nreM2r
	oE6qY2D3QMEvsoWT+Bm4O9arJP9dSear29GXZ0iATZw==
X-Gm-Gg: ASbGncvPdWrDGMMKq59O6heig9BXEAgX4RrKSRzxULs8Bg1+i5Zi27j//MHjaRvXfkz
	MgHjUJSvV4R9qJevpdyY2tpMLb489EkYeL2dsf1oknw3P2JJGyy0YQ2pUOGZ35nDrkIR6vOUbdG
	DwnMJfCoTirigakHeY1TDNOQhTn8PjktUEcYnJwfZGcTaF7yA71QPOZh9c/alGk/WdKMZlROOOP
	j7julLGo6Y8
X-Google-Smtp-Source: AGHT+IHPpLfNI72JEnkJ72QqK+MH5mMI6L6pUf7fP52T1h64l8fKj2i3STMxyB1QGPLj5fBohjsdNLTKE30239bPghM=
X-Received: by 2002:a05:6512:401a:b0:55b:886a:6a77 with SMTP id
 2adb3069b0e04-55ce626221amr118620e87.6.1755121565870; Wed, 13 Aug 2025
 14:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811135114.70119-1-brgl@bgdev.pl>
In-Reply-To: <20250811135114.70119-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:45:54 +0200
X-Gm-Features: Ac12FXzRt9FsRkefIOG46I1xe1PWl2a-MXzEb8BiCd34oriZUEGjbeWDN64AFtg
Message-ID: <CACRpkdZC-_bsM-M=g6SPKd0wFE2Uf=g1hhQMXb-exE74hXdOiQ@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between the GPIO and pinctrl trees
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Richard <thomas.richard@bootlin.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Please pull the following set of gpio-aggregator updates into your tree.
> This will allow you to apply the final patch in this series containing
> the pinctrl driver for AAEON UP boards.

Done! Thanks for dealing with this!

Yours,
Linus Walleij

