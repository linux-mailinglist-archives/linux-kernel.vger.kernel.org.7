Return-Path: <linux-kernel+bounces-834781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6CBA5826
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D57C1C0555F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F519922D;
	Sat, 27 Sep 2025 02:29:11 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F71A267
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758940151; cv=none; b=OM/uil18Ej2PpBl07v3U0vAIpG4EPC3xg/r3n6q4lC9oszOeKICaJlmm+3++FwW6dlQRZHVs7qTEmintZh/ntaqNwdH217zt+eBC2prclVa4fVdm2D0YQwt1Lu9hZB1cT6MdTkhShYxwJSfbS+QExcK2Alma+7OD6pWKQrzNKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758940151; c=relaxed/simple;
	bh=GIPnusP700J5lEYYX7UIiuxp43JikbB/9frzCsSPEbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kP14wawASB3pS0GVzRmfa3+G0AfJk5Wf5YsoAQ9Jg6bYH8U6ha2xGdSd3+ucPfQwMT0Z0drzDdm7sbs2MOPMJP2hA4EsIukWowRjgX7BSxDr2ylx0zwIuAxbkM0965OzjeogwV2kBHmVlUwD+/JDaMeFdkBmDuJwF+L4y/FeSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f4a8dfadcso4859795a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758940147; x=1759544947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DevKPTwMgnfMY33tLxNP7YJQ+kh/p8Il+2rzMT1+A4=;
        b=QOHG3w/JuKqpbtpKULjYjitdHXnuRhhdzACKfKrdVhcs/g1sWQZkFH5YdIzG4BLv2W
         FMJHLlDxAqGfOav0NlrFT9nc4BQ/Vs0xUr/3UCCLmomDnoy0Syny77u+Mw3iEP16mCcf
         8u9imT1Suiinpxxt5KiOLmnlbogEjsPO9vK0YFsFRpS+LviLtDSQA7y3wvn4FfCJMKb/
         xkx/+5+2WpOqgKcja1aQpfJt/KbNrVcoxc/372cbWnfd+qkzdoNfj4L9JB5dVmzwyfvh
         g55JF3iGsIh7yLeS2eJ5T2DPsjWOGdc6ugDMzdo8MUDV/fUb/OnkeTyg90AgBXFnRWi7
         qXMw==
X-Forwarded-Encrypted: i=1; AJvYcCUT0xEO0IUmAU5MXcHjAI2ilaxGclI+/GPOE/Sd4wm5D0QhSML7i7fHmLf5e7p92zMVpHhr9iiFOOQObyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZDcN2KOm7fadAlcNWvR7G+Bs5yftZPPSO1jKR6Pv4h2HBpzO
	yltpw2vWydp8ftFsunO3PMlPMl2fPEl88K+LDnsmMIlz3Q+4OzNZRe+raGgXrmPd
X-Gm-Gg: ASbGncvqciGMFau44LckhZI1/F6LXvLTChgV2gQW5DT2O/Pf1r9fQTVvD3MVy+IBP8a
	v2JVDpeujiMiCjawuV/9m9q8//VcHKakUY3VE3vu8pWoZ9A9z5qxJQm/LxHBxJsWORVlBLAzRWo
	ZqRigyyqOKmAg2Xu4OL7QwUuV73pJOms6yh8bZF4qz8CA5MCfXGwIst0zXEbcEN7aOh0EZftYtP
	iXNFnTgQ0RVU+kr0Q0nK8iwjR3DuNI9k5gbRZjm4nEGohU3hWw+LM5bduR+RTs1WTf8YbcRi2EX
	8ZaNs5eKisLzN02xha5Gbot96oloQyomqtLfUIoIdUlApjz/Bd0F/+51l04ab19DdDCsT3jlrlI
	z4Fe05z2gA+ZYhJ1rSG309GISXy24tkDRLfUJwQi/BvASpjVDGtJdrHpzgGDM6rj8N6aNcwzeoF
	oymfmGqaovSuiMYLJ/TuA=
X-Google-Smtp-Source: AGHT+IGBkrmIk6yja1HYDQBh9yMk/lnE3k1RzP18jMFychgaw6kXpxTxyrGcz99xso8Yjd+FEPju9g==
X-Received: by 2002:a17:906:46ce:b0:b35:3469:49ff with SMTP id a640c23a62f3a-b353478953emr818248166b.25.1758940147266;
        Fri, 26 Sep 2025 19:29:07 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fd0a7dsm479305166b.83.2025.09.26.19.29.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 19:29:06 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b2e173b8364so452384466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:29:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcqn/yXfs5jjO8U2HXeoBGaRWatw3qi8i3MvmGSzraeLavfxJvTK4Ze9jOMmYPJftseHpD2KYhCE2lD5s=@vger.kernel.org
X-Received: by 2002:a17:907:2d1e:b0:b2f:963:1d2f with SMTP id
 a640c23a62f3a-b34bef98b74mr1061773766b.51.1758940146614; Fri, 26 Sep 2025
 19:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
In-Reply-To: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 26 Sep 2025 22:28:30 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-+dK+Weixf1iP7hn6dt_CXWTYraA=TSr=rMPkyoJVHbg@mail.gmail.com>
X-Gm-Features: AS18NWD9i2Ce3lSv7X8ID-5SK3bN9ENqRcod81yTbnB7Qdrfx1pZRHR_ctdLGks
Message-ID: <CAEg-Je-+dK+Weixf1iP7hn6dt_CXWTYraA=TSr=rMPkyoJVHbg@mail.gmail.com>
Subject: Re: [PATCH] mfd: macsmc: Initialize mutex
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Lee Jones <lee@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:33=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> Struct apple_smc's mutex was not initialized before use. Surprisingly
> this only resulted in occasional NULL pointer dereferences in
> apple_smc_read() calls from the probe() functions of sub devices.
>
> Fixes: e038d985c9823 ("mfd: Add Apple Silicon System Management Controlle=
r")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/mfd/macsmc.c | 1 +
>  1 file changed, 1 insertion(+)
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

