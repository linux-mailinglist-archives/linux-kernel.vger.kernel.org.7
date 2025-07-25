Return-Path: <linux-kernel+bounces-746356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D2B125B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722D2AA3B14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B525BEF3;
	Fri, 25 Jul 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IjL/ly9Q"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612A25B2F4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475934; cv=none; b=bK+y/I3trdz7xUrmvcKtodY8BBPnuhMATut92Jc7HUjODhB96S6aifOa4jDoZO6jlXdZ5wWBmRWwe/54FA1SYbzV9vhvo9Jiu/gZs5SOr9FGFzu4u7u56Jy5nc9EDqjvwojwCc5Z3HOaXPw+59PYDPTn6rg5pT36ItNb9wbkvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475934; c=relaxed/simple;
	bh=W8Ufcc8Bd66gD5HD98fjyH2vLAXDQp2S1Tco5bbnzRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH/AcsgBt7HcHrIGq15KafLkvSdHwn3e4nzDYL7JG0CStAUyvXdom8CttYnsjEAX4KhNky1mDk1Gc0Nwv5jTO+H7UCcm+XDh8G/hIDEZdDIVm8tjQxoXqYwuR5Ta9bSv4ZYE4+StK5bWFnldCguD592fxONrsE8Eylimfm7liCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IjL/ly9Q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0dad3a179so414945466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753475929; x=1754080729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7Mj+7lyG9KXDTt3ibbkYCjc9m9DMRrjMQO9xMw3kZo=;
        b=IjL/ly9Qr5nGXVTjGj02RMdUgWHrv1SMdioyMp8b/QuXp/a8+5ALbPK024CjxkFbQ7
         bRzkDmLXEHLRl+7tWRsJ2esiLMGudDxZCRuchhUV/ruQWVgebcQu8gV1llOLpM7FF3wi
         ph68jIr8InwaR0LtRdomvZlritFDrHQ8dUmBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475929; x=1754080729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7Mj+7lyG9KXDTt3ibbkYCjc9m9DMRrjMQO9xMw3kZo=;
        b=rY3yUJpYsZTSBmfYEJ1vQRRU77hBtd72YMIMMm9wQkVhFN9UHmELEVJE2DaTlVhF7R
         NLVX0Vp5U8YUxlZHhcIwenF8PHw76QvV7pY42al26VqdGVtamtUZyVfPow2LgAqwl1Qt
         7dSTvRppJ12SJ+uyRdqslgtf5ISbE7pQvjTCkuujyQkvgVOpJUrwB7JT/qRh1KuvmoE+
         QBnX+tBIdPO29G/jtfXvIGfTm+0cSq1MMNq6Ai8YHGJ/0acLf7uUZqUKFaOwZFKIRtSw
         uWNqNLIV5lRTEHKAHxFgZ91h0gCNxMa2WNlIl896F5JFXinqPBlkZszwl/xClOY1OiwF
         dmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH/568olLHZoTwVB8GBc9SdD8EPMFF/GpK1saR/8d5q7ChHK3m1K9zUK4nEhtFZ1Yz+UYbaAENMCKh8RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6S2nW2VSqQxTVgOvcpNLHB+j9ygJYE9QlYp6q53aXctWzevZu
	zrJQjVK/0PTjEcyomcusGMwkAoZZzI/viP6vl3e6EcsrOPKZ94cveyzLj+5XEjmATijSXKVVXq6
	+UB0oi3w=
X-Gm-Gg: ASbGnctW8xU9qaEF/MO5/ozUhn9OegddL4afK6KgiEIgyBOXWcL9Cqby0okldZfAcAy
	65vAPCSYYJ59Jypp5jY796HiyLLnyNTp9nCAFzuSlsbIfvneHZ7Vv7EVFTD86teBB8Vko0vgtje
	7U7FWs28wC65iwKP0lDQofi6iwvFrhogNMGQxBVffwZGVH1FWkbF0NUocjMMUVnfFa7AVmVkW3Z
	9TvTjnEOYIaqrDflDOdVSqHTRrAhp0Yx5eiml7P+hErK9ILeJrMItN4whNzAicJesrEo3F2v3J7
	HioN6NcA7jolq1+6oBdeCY5Fcy+OXwLapvHbLCw1awjl+xh0TWv7ZwU15/+c/jbwgJczWscNH1n
	KR9HajQ7EsmHwyEtDydD2wVKqt05Xb8ipwj4kqjZ2VtEY+hkTAfKW5nTAwZYzqO7ljRY0TpV+
X-Google-Smtp-Source: AGHT+IFCdC9Fxe7NYo6KerrTSdHO6/8SgvIU8LH7wS6/eg7HwsMBGRThhv6U+J0NBSDd7mTWMCEZmQ==
X-Received: by 2002:a17:907:97cd:b0:ae3:6654:c0b2 with SMTP id a640c23a62f3a-af618f02dc2mr391762566b.28.1753475929310;
        Fri, 25 Jul 2025 13:38:49 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff5asm43240366b.11.2025.07.25.13.38.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 13:38:47 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso4940126a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:38:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTZjbZnrS2/6m7tR3A6DVsmrJH/EGYn0154Qwk7H6MoocW6KeKprci1QZLoj301EvyT6/wREE7PGi9KhA=@vger.kernel.org
X-Received: by 2002:a05:6402:42cf:b0:60c:3c0e:52f8 with SMTP id
 4fb4d7f45d1cf-614f1f59100mr3273421a12.32.1753475927258; Fri, 25 Jul 2025
 13:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tx6TmT-qQO+MDV5GXCbUbTASh2Ly=eLMJb5+rB6MyJWVA@mail.gmail.com>
In-Reply-To: <CAPM=9tx6TmT-qQO+MDV5GXCbUbTASh2Ly=eLMJb5+rB6MyJWVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Jul 2025 13:38:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMk9nCfOJeSKJFWNQ8ZE94ypw4NJOfLycNLR2z1tnt0A@mail.gmail.com>
X-Gm-Features: Ac12FXxWkw8_cmU1zPXR_ImGnykkZvBbZtTJSu5vdZlEAyy9LU5PqKFRhWuTNwU
Message-ID: <CAHk-=wiMk9nCfOJeSKJFWNQ8ZE94ypw4NJOfLycNLR2z1tnt0A@mail.gmail.com>
Subject: Re: [git pull] drm fixes (part two) for 6.16-rc8/final
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 13:32, Dave Airlie <airlied@gmail.com> wrote:
>
> Okay this time hopefully in plain text from the start

Apparently your weekend muscle memory theory was indeed correct.

                Linus

