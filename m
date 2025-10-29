Return-Path: <linux-kernel+bounces-876446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D9C1B829
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B7C1891EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C62DC331;
	Wed, 29 Oct 2025 14:52:31 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417E5478D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749550; cv=none; b=UwlIRNLBGSopkwwgxMlFgLW9ePt7/SzW7e93wCXEqBCFixj7tbFrzDB5BO3Z/1kSUEUjhg/yK7Fcor8mEs3yHvPM7m/65V3eyLBWvSyKPBH75rBXl0El/hQKGGo808gGruEKXkneqcHNjDLw1Qw8O97QEiBdMWGbrR6rFRPvOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749550; c=relaxed/simple;
	bh=lfiaCy81o+Yc4E3VYzi/mV8FENlkKHuoO0aA7zcUcY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWhquJr5RXh5MqcZCf3JhiA1DWBOiJvk97yaEJ0lWp25xIguonRhTIreZcYaJgf48BvomZndq8x+fThnNfMT0oSn9YExB42UN8PL3gCS/IL239ziiXugwJrvwb+QYlDxjYbO5o03Oa5FsNu7ZSmLRN8Z14ybvMtbmg1Mj4SQp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so11817137.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749548; x=1762354348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FLpuySnjEqiS9qmBmDDye9ClI7f1GY+eT111Ebu1EY=;
        b=akvB6jCAg5Gz446gQUt27PYOmjsUkj8pzRJJnYTyhQI6k5YbMzhcrvtakdNugq3pWN
         aw4W2Ct+g0pFRdr1fxsYSbaFni/i5J90PeWXa9cB3mgDEHjBoXY6ha8LFjh4bdQcrbWq
         9956Ty7vb5RNA3QfdlJ1bR5kzuMVIKiu2WzTVkMY64j3fqhuxc+IGxQ28CB0uREaB81L
         65yGzn6Q/5GpSC/r5KRVhTe7i2hxa1SThbYNRpQHC3gMzvEajYRbf97LmCeGMZfNEfIw
         VHbW9bDoObRXwy986qdtA+lO0Zu1YPEeJGcUD2AfWHVL24wUrkjS8bRyd8sowVHusayb
         8S7g==
X-Forwarded-Encrypted: i=1; AJvYcCUinkEA7MphWNnSQ6FLismAnhVh3HOeN5xa63KSxR+wK0Azy30VO6dhZGORtCw4NC3a4meS0imrJPLnh04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTl6WsroQ/7qEftloz+HaGXda2uCZiXsmCTrj2hp4oEfAY1chC
	Lyu3WnLyhYf1Z/X/bTTCFBuX+MkDRgi6y942x8veFfA39DHYwy/BZhGiugoSHrZx
X-Gm-Gg: ASbGncuR1AGxXK+dF8AZHacT6vtnmK/JcIXiCtUL7V0xWx9v/OWAwZpUcasatZOOcmQ
	McZnzbNdJZtfT4iK4dMedOA0CPyL0rvkSxcfnQkHyXNWEuywCL4K1tLsRJlGA8KFWkuWEGOBtmK
	MTQKB2uI1ML9V1n8oEynoD4jGdBzprODAqEHYDj3iNYWqLOdwVKLFdc8n/h1ivw1qmJsBGEnieh
	NePy3Bm4YMF3qF1fgsO0ywT6ceUtWXGov4/zA/wOfDh1Iv366TDtkYFjqGLD77yYZlMBCO0IA/C
	RwEv16CqkLIwCCUurTjbFEoAIe0qNPi6+y6ZVg/SIsBG7ywolKXl/1+uIhVW4GpdO6pBH7akq20
	JEaJPreP7dsXIQdKRizEY0Wyzbg9uFziIAM0HpaP0q4ZtewAywmnslj8KJOSXdQpreKJMc6Jb5U
	drHbkoxUPZekGVSfUP8+GB0sUynh+clEQXfjApTxVDtg==
X-Google-Smtp-Source: AGHT+IEyyRN+sL1ArS4Wc/6dI/cA70LjsNS2v1TNGAOrBLgchOW7TG8aGyRHo5ZUCkFNOwpbQ0F59Q==
X-Received: by 2002:a05:6102:18d7:b0:596:9fd8:9268 with SMTP id ada2fe7eead31-5db7e0ae09amr1940589137.8.1761749548045;
        Wed, 29 Oct 2025 07:52:28 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c4050425sm5369866241.9.2025.10.29.07.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:52:27 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-932c2071cf5so991516241.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM04d3RMGjgHKzECqHf7exKUyCjjgK3RbgS1lkDRdSxFzCy9y+EYHQ4j49qJR5DXzh9KfJ8g7mGKxR1fI=@vger.kernel.org
X-Received: by 2002:a05:6102:2c06:b0:5ca:714b:2dcd with SMTP id
 ada2fe7eead31-5db7e20592fmr2373437137.10.1761749546310; Wed, 29 Oct 2025
 07:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org> <20251027211249.95826-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027211249.95826-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:52:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2Kr4WcYRERHCYR1zGAh0n2N3D=LYbRSYLJnRTYDB4+w@mail.gmail.com>
X-Gm-Features: AWmQ_bkKsdjAWwO1kVg5eGvvrllD1NL0DkP6oF9YOfmHIHPrQOIMjaePzAGpSiU
Message-ID: <CAMuHMdV2Kr4WcYRERHCYR1zGAh0n2N3D=LYbRSYLJnRTYDB4+w@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: renesas: r8a77960-salvator-x: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 22:13, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on Salvator-X with R-Car M3-W.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

