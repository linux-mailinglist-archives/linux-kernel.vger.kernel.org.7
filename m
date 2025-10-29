Return-Path: <linux-kernel+bounces-876452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF2C1B925
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50FE66540F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B922F60A3;
	Wed, 29 Oct 2025 14:53:40 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDD2F7465
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749620; cv=none; b=ZJbC9EfdqfQi2wlkdNcnXLbEuKx9xdEg1EY/0SD5A3H0b/Q604kU1USvbtRti4loBGGgVDZA6+AAPftY8+2Fz5X5JcIXk8A1vn+nAA7OaOJsc0+l9eF0IkLZq/r+mXnibcY0ax3K4eOlKO7/xdItRY8bObKLvuKcV+D0JG7to4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749620; c=relaxed/simple;
	bh=lRTzqMm3C1CC3agOInFaKAmL647Ck5UdtxGzBQeuq/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMNWLkT0XGgXLaSbM9zvq43vrT3WJbzzQ91Mz6zeUunh7bsHpntI+Lh9aFSWrHNqoV5eyxs+H7keB57BdGMNnzXDDeSdzIu5yK/TsYbkJHZYr3SZOjgBesWeyNKFTBlOHfFOwVetLfL3kKfk1nZ4mGYhc6dfaB4fFiJ8j6yR34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89019079fbeso2667782241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749617; x=1762354417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQw8srW8sZp+NW7sFJ0wHastT8WjOnxgYbS0cHBnNRA=;
        b=j8WoZg+Sgoytlxl8oNMPaoiptutzWla7nUBc/7urT0rXrsImNulnLEdv2GhrBJ49NG
         Ysf6ytdpmohbNac8G1vgqP9wcwe95cLtu6Xnux68dDNmUVLFHqXb0ElpK9LykUMS3ydX
         0uJJvJPBEuzK9RUxUf5LRZA5/gPwVYy7nnLCSQxKAPeDT4V3A4FpE/IBL3UcnbUt/ZgF
         PTj6m045kvEaU5ZkFWwITPtM44MKqj7xXdUz5OcP6CUfvcq8L5+T1IZjVWYQjmp6ox2i
         KLBRlevlj3WI0KYiqlLxLms/4D9ToUpuxrph2w48uKapDt6ZClwoSQA0xewTIaDxiL4T
         2Iig==
X-Forwarded-Encrypted: i=1; AJvYcCXHD/RCWAHOjmcGYfIHSmfIRlQ21KsFJapzMyl9kkv0zCRYZYNsLqx9IMWL+vzv6AWQFY/vYrUD77DSvw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAssdNlTgT+lt9jJbrCC3XUHth7tAuSJq8Z/yEmUemS19DPhv
	w/jZrQI81Y93PXpqUWOnVUKw/YGWtIWuFAx/uqv6lZJwPGq8JmWIBZMICQXgYbYS
X-Gm-Gg: ASbGncsL7xSeK1/2P1i2Yr3qGYM5yLImIiSftwsUa8TgIPEu5H93keaNM6DJAPHI/yU
	+63wBqsF/YRI5HuRoGZHMaMYOvpuDm1J8ZK45Vry2BVB3Pcq218bpqh8IIlydmfyW8n8ipaiJl0
	mXOpJliL7wbuTqTdum2xo2sd4YclNgwqfmLKuQN2SIPoLoEGdlhKyPuRwdL3l6JCWVEogPyNsco
	kWsA/yl+2U8ly0WXfPa4Yocc/fZb1z788zrh13YVuwMXYuVQiFGYjhAFLaD2AI2WImc4ljDpc4a
	7VUeYQJxrx4g9gn0QpCCNmr7q+2NgIGasrIPq06LETNbu9i4VTlL4kiXYEo3kAOXebJmGKty77A
	JydWUMNEC2+1LPRyRhm+EpbcoDUxjRidx5bE0Y4bSN5+bqPeeMTuVEQD5gJciNJfiIigxjYIUqm
	vur8B1Oq6j7OLv2tEvsLA64SlVlYrtNLL6oD61BZ6v4cMdXD3qJmLs
X-Google-Smtp-Source: AGHT+IGiZj2bq3/Q+wSAhoH0g6pk92OJGFNB8RoEmkzXergY3tOAWOa85pU44Ta/2RFm1tgPRuyKSA==
X-Received: by 2002:a05:6102:dcc:b0:5db:37d4:3625 with SMTP id ada2fe7eead31-5db906baf73mr1065555137.34.1761749617489;
        Wed, 29 Oct 2025 07:53:37 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c4098721sm5283329241.12.2025.10.29.07.53.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:53:36 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d6266f1a33so4635067137.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVytC6V+H9e9068SYwBmcCQgnkRt0ZB5HmIouA7ryYF8UyNue9Al+s0q28XuQ2N9vkb0PLFgDAN3yYSQ3c=@vger.kernel.org
X-Received: by 2002:a05:6102:1491:b0:5d6:6ce:9675 with SMTP id
 ada2fe7eead31-5db906e35a5mr890070137.40.1761749616368; Wed, 29 Oct 2025
 07:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org> <20251027211249.95826-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027211249.95826-5-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:53:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpkbFGFuYA5qxohU_P5trfdrR8=OE4bOFZusuax_4M5w@mail.gmail.com>
X-Gm-Features: AWmQ_bnTzLRSdC_rJSCH1WOHi3pChMPMBglo5qebVwVc_9tsiGfE_PRGste6mmI
Message-ID: <CAMuHMdWpkbFGFuYA5qxohU_P5trfdrR8=OE4bOFZusuax_4M5w@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: r8a77961-salvator-xs: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 22:13, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on Salvator-X 2nd version with R-Car M3-W+.
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

