Return-Path: <linux-kernel+bounces-768208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC08B25E39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C6518827C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801042D97B0;
	Thu, 14 Aug 2025 07:59:21 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CE28507C;
	Thu, 14 Aug 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158361; cv=none; b=AFyvkkFgtS+Ss24gmtWaoRfbi/6Tm+uDGfxfipOfFiuk9vffHBJZ7mDs4e4gDIfMjMSeBI95Vp/2f4gookO8tRCU3SG5kvvINH/ibCwaU8gDERs7NuRGoqB2EVaeUGOYLODSBOWS9YZJy8XT13WbPNdqSCKxxWNVZMv6aX3nwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158361; c=relaxed/simple;
	bh=VpKIa8LgibfoJADpoNgeGgl5dJ2VMP4Uoi/rmo0dahI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4Yfjhns1nidDun4KgN1mC7BLoQOyyiEOLwfykE4MCO0VLpncw8j9E8KjSYBEqwqmegnD9JIC84b44Ag99sG1mA2oTEWbT6encyUckmY5At/zmTTqn1tj2lj7m/jdlU34GFuchC+QGyFYdCjlICn6HjK7egXH5AMydulSRkP6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-50f85c8a9f8so299058137.0;
        Thu, 14 Aug 2025 00:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158358; x=1755763158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+i7bCdgaRO4PJGywSV9WTbQBb+KITW5yzAKza8+ctg=;
        b=COTVNTCmDmTO3knbHgIlvw2CMLzxqrCCHrQ6JrZo5dR0FfDGQ5bMRgUPxuRSbw4ZmF
         NMHe8BFayCj8Ihgaa/1gmmaxYMpblRPyD20fmV70xDaz5igrtoZ+TDIlqzfjl0MIAwBY
         LYx95SOI/pAX7tkMEPY/L4AvSY0zdW00iJY3hZQtWUVndEtgvG5DL028oTWoBqCAgrN4
         XRQkh7d8KZV3mbD2dWKuflBqeL4ehBSz4xsrqiRQcyKCBDguyzKX8/ECkuPMm9CX/wUK
         oozxXfFdO0EZC3qk62qZju9tx6KJZY//XZxZG8utcsCIIt3j2gQwXYIZ8JHPLcQT2Df2
         jPeA==
X-Forwarded-Encrypted: i=1; AJvYcCVRMeww72qXYk6BwadZn4JphXHVl8Jip79r4GsLDHCi8HB+uEjGNjR+NjfLCMuXvKhkjyuX/23UOT2xNtfY@vger.kernel.org, AJvYcCVtoDfuUWCVsO8EDkzBE3BWqVmVXHaPWX4eO5UsE+BoeX782802yxL828i8+/b8WyMM2ueLhZthhibZ@vger.kernel.org, AJvYcCX8vE1evbpRcPBtWDGy+6cFoTjPm20duc5t1kWi6rY8F1stghuk8X8CXynZHwvD2LbsstkqTdlkwjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziovdvA/UY5O30Tb3Ad4A6rOWy77Fff1u1gR/xeAus7qOEj/Nr
	24750H1TX6h6tNqvgKL9M3dqSvELhJBbeNEmXALsV2ff6Ub7Lin84Xw4bt8eyBZe
X-Gm-Gg: ASbGnct+NhZ5UTaDVzR8w18GYExkrcAjNIe+6JqJuw9uujGN7T6CR2gGk2aTxw4H6iX
	jNV+YVh52dK7O4MsrfHBw0d/P9ozSIyAj2XsBoAOxNL63EVf6cUUF5pR+xkFnyk3ahmJNjqaD49
	LlRa8ZHBA68vlp6Dn/eXRLhmwjj1SiBME906bTMfTz7a28Ftl5XJbRGEOV3JGq0QPWoB5KjsVIT
	BuwxkJCblzGnKI+wtf7ewCrSrBGnogntSneNjX6tpPDJ4+2uZeLU2L8Hi7zTheCV7NlXOHe8tpb
	zmqu42NeJqiweDCvZsBgza76x+3QBBH6+4Iob6k2swBMMwrQ9+kh5a5Y9RPRVeVDWfnBo+dmLRt
	gu0p9gUDCHvIcK3RsbjC6HaR8yxTPpC/DyiZEXAa02y7MpCD1W/LHoPEJ4Z2j
X-Google-Smtp-Source: AGHT+IF5wDRcyJJTbcWVBTGepzlQ+jHSOzM0ZzXPaBfNAzOnorpFF17V6m+dbGBuxcb3lj5HuL3l7Q==
X-Received: by 2002:a05:6102:2c1b:b0:4fc:e6f:2e20 with SMTP id ada2fe7eead31-50fea2ba3b8mr739598137.24.1755158357806;
        Thu, 14 Aug 2025 00:59:17 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e0293141asm3152928241.17.2025.08.14.00.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 00:59:17 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89018ea8f7cso357780241.0;
        Thu, 14 Aug 2025 00:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXhMrSg9QzL83M3nPhbAwYbtNC37ediKreTuaLoejxipWl7ulKHrtpROr1KkHuAPpMFUCeCTEjJhHb@vger.kernel.org, AJvYcCWk1z8a9xaISQ/Cz342zJ/9utIkjv0v9NwuP1pr1+vZyAX4Za3q+Rf4rqAx1zZei88F0AtSvnsCJvc=@vger.kernel.org, AJvYcCWx0sZUDLROw56X7pRH8LiKjDi4jzukjOAcTBAV0PN372jStxDxCVpEbwElw2p/95tWOkcdtJQ1pLWq9DZF@vger.kernel.org
X-Received: by 2002:a05:6102:4192:b0:4f3:1731:8c01 with SMTP id
 ada2fe7eead31-50fe9f8ba91mr647723137.19.1755158357000; Thu, 14 Aug 2025
 00:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812104154.42289-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250812104154.42289-2-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 09:59:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXz60tBNh3DemVOmdYA9YT+aLGfKR-AGp7OT72gGkNOnQ@mail.gmail.com>
X-Gm-Features: Ac12FXyFisZ5qsOIsDXr4nfrcLgkkLJm5dx-Z9otnKfuIczkkZJm2xxpNDB0tU8
Message-ID: <CAMuHMdXz60tBNh3DemVOmdYA9YT+aLGfKR-AGp7OT72gGkNOnQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/process: maintainer-soc: Use "DTS" instead
 of "devicetree"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 00:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Devicetree is a data structure and it is a bit generic term, because
> some treat Devicetree bindings as Devicetree.  What the SoC maintainers
> profile is mentioning in ABI stability are the Devicetree sources, so
> DTS files.  It is also more common during reviews to refer to these as
> per "DTS" instead "devicetree".
>
> Clarify that by using "DTS" name in few more places.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

