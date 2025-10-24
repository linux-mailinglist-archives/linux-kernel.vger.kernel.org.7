Return-Path: <linux-kernel+bounces-868316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1BC04DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D77719A4807
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24182EFDB2;
	Fri, 24 Oct 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ARlSQO47"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AD2EFD90
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292402; cv=none; b=V4ft+7BV9cZ+I6w0PqSTF7FHOt1pAC2J3iKhtM/hLdtsvtWoR38UnUEFuEKmYr8CgRfHsmCHx8t4VhhIeswmbnrDMjfP16B6hawlVHZQc0+ORSL7lY6cFF7P2H9Ozi5O7xRQcsMWw8d7pfICMRPtOJRMhHWEyz8Dk5+z82p/wCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292402; c=relaxed/simple;
	bh=baS/xmN1afHN7ZIoN6Jk+mJZv/3sAIH9J9qIFzyXYT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJBZwa50Y33imjOqV5BUEljD4ipW0z8HCz9SM2dxZfZTALECR5AmYOFeDGoGM4BIup6hYCqu6hEIyq4DhvDdZ/spgYOYC469dd6KQhVTN3LtnSOefS4Jujer1WH24DH5Q/8kTGLtHo+WJTEcsDi/3XYSJpIJ9QYiUfHDZ/5YQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ARlSQO47; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso2245992e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761292399; x=1761897199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baS/xmN1afHN7ZIoN6Jk+mJZv/3sAIH9J9qIFzyXYT0=;
        b=ARlSQO47Kx2JULorLWy5YGjcpS0MBv8nZs6fN8fmP93zXy9glLictG87WBsE3V9rlA
         ksYqAzidh8y4z+1A85vA3ItbvnFYhNLPCwPupbp0H/WpS3aA5M0KhSMm/uCru3RBehYI
         YR7vepYolPTh1tmg0TS3ygrnxs2ETQ0DktTLcyxaklT36WjhGWoBCCu7O/oWr8RZ6NPJ
         VVxNl7V1huUY9IzaoLeP70uLfXwtbpGRV9TkGIGyL94HW15v/ikVnAY42VfXNr6fXdQ9
         P+sRIvscDPEQI9nHqllg+7QLpercjDanllewfNKB8pjclC4mHtpCYtVWBgTXEG7C/D35
         b4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292399; x=1761897199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baS/xmN1afHN7ZIoN6Jk+mJZv/3sAIH9J9qIFzyXYT0=;
        b=vXzycb1LVBnQbivTH7oChPatbEBh9ai+0QJQYpYxRIua5a93IDfjF5N/SxBxkvkIRy
         BhvIVxj/oRUvGw9GWW+CweY3Y4LNnrGG3c9hQkPojzeZ0PnLzIOKbLp8bhn8GX8Vspxo
         b2QNrTeQN394/oN7ZDQOl8fJ9+R9hKcmKaeHL6sMRydEHYAD/2lQmiZkjuXg/tNQ/PAO
         E9vmPqMKNuQ3OVZyVCWgPAuXFsQa4Sa3+c2l/yNj+3p5iVQisC1TyO3uM9Ada5QSd22c
         TpmGH4xyi6pLMQQCNuOnOb3rjWZaJ7M0I7Q3KG97tiaWmAQepdSu5gaYnHb1VMbknmY5
         ts4w==
X-Forwarded-Encrypted: i=1; AJvYcCWo3E+qs5nHuntyss6MfZlYZEoVelb4XCOFBozR+Uj+OHuN17qAWFNSL4ei7Ka6MhgJf296isDpd3uSQMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnThfY6uFUJYu8Bv6ga+2EZ8pJOJi527wVvJU/CMM8FXiRD1j
	GnM6ja9/dr+Z1+PhqRWIdnT1HAgJjqSTSXtCuu8pev4rTIkT+dVkul8Ua6RG2sfbuz5oKZIr7gw
	dKOl60er5uUkMYoLYVYXftu/7rmYmf1EUwIR/qwojkYszq2zay7acwGk=
X-Gm-Gg: ASbGncsOdUlKY5HCcm4C4j3D0SAHqpYRU2TOXe19j1mvayfZDDtlHvo+Uc+WHjVaCZW
	B6xhhFmSI4eFBrN/uRJBMCKtQ245m6DhNvi0zrr3wmQMqpvxVDcBoQ+0Xo5ehNf2+tP2ShWYXij
	YGx+xhMG4pxCnBG7+R50my8j3DciivJiglptKqy1kjuK3CCeS2SEeOhpEZhCLj5huu2Qu8vuyqr
	VP84AYhjcTR10I/QfxxP+FA9W9Yy4dA7eWqZ2KWhnEW5oHngkeLOenXluQN/8b/aSxGDdET3g5Z
	Y9QU4lhfZFkrWKE=
X-Google-Smtp-Source: AGHT+IGLGk0fXn3vmGVTBNK6NoSKgzCV6+Rz6vUlmj77EUkh410dDNGZpOHVJgO4AhXqGRzonzBZhJr/uIBSFcoY0zw=
X-Received: by 2002:a05:6512:63cb:b0:591:ec83:3183 with SMTP id
 2adb3069b0e04-591ec833258mr3106674e87.57.1761292398605; Fri, 24 Oct 2025
 00:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org> <20251022-da850-reset-lookup-v2-1-c80f03831f63@linaro.org>
In-Reply-To: <20251022-da850-reset-lookup-v2-1-c80f03831f63@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:53:06 +0200
X-Gm-Features: AS18NWCoAVoOc4wSbv14WvrOoWzTP2HkTyxVK6IjolfhpkHHqgTJR2dj3PrvuxM
Message-ID: <CAMRc=MeSQnEv3uz=nbz8m4cTKN4oCztidsqYfZE+zrXjzQonWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: davinci: psc: drop unused reset lookup
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We no longer support any non-DT DaVinci boards so there are no more
> users of legacy reset lookup.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Stephen: if you're ok with this going through the reset tree, could
you just leave your Ack here for completeness?

Bartosz

