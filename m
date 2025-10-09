Return-Path: <linux-kernel+bounces-846852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC7BC93BA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379B83BAFD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318B2D5946;
	Thu,  9 Oct 2025 13:17:22 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D015CD74
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015841; cv=none; b=EqIk85Ti5F50aFF+jXP0iGCAVFW2z9FQhmhBt4bjNcQ9C3mJ/Fnj3iwtzdU3mWklh8uweeYpCTj6rPYvzaC6CZsbBRgg8DaQXunUPujo4LkvKDmdQmwIGdo9Bry7A7Up7RMu5tIL0TOwYpDLD0WFZUG8XoXKBZsJlx36VqjdmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015841; c=relaxed/simple;
	bh=fy4GsUvEqRkI/Ft6pLFNEsAJ9bVUkKA/yCVuL3Yg9xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVSGE71x7ai4HQvKFbzTTbWlr3p9nJWqf9gnmeEF7kE9J5N/ny0opPp9OH6R1B/+Yj8Vh/BEMULCAikqyuIkUCWzfEM98vgktJp8r5G6/bxIwpbDsGmJB2xQ7N7yvHLEYBcoeQSDnyMOT+GuBBIeR8TGXLik0HT7j5xF49JNF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso1556213e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015839; x=1760620639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfSYnMo7fiy16p3PhjUGaXAHnchMPw7K8V1O2OsfiSc=;
        b=hDsrfBCKl5+33EVSk6WJaq8d51l7i4iZgINLv5nh4fzixRk9ndp1cmBusTGOzH2/LE
         mW6KXS6TmW6LXXIOZCjlujKSZed1BH5qLSzmICCNXyFvh0ewx4mTHVhWFwpWukSiitqM
         GUg9tOfWL0WHKVLYEXFhL96IdhCzrASFekYrEgXG7aFehaLpgb/lbntZ3Yquad7apAZg
         LGSt6Ok4ysvrJ2X1/aReRm9S+iDsLC9xOlmvbAB1Escgt79dXeA/nhwq11DCtv4JuAl1
         52OzC0oj8MWPKo2rt8md5thQqCvVO39HuoEzqKeE0PDtFxYasYdqKgqEJkkHFZR3wBUb
         ZfDg==
X-Forwarded-Encrypted: i=1; AJvYcCVfeQOmqrRar0TsonFlrXwmVuGkB2SCzZbgOBsDUmraQpqoBmpswjAwIqIIZXcJc0CiwvbwG6Ll/duMBMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhEpyUv2oiuQONVk8Riv6nRHBJLqPKY+7wXcTcy73Tvspimay
	nharfGfJeK6L9/PkQdEm6YCEQCEeOkNW+DfUS8Pm2DhK49s7YAnO7I9742hNEeWt
X-Gm-Gg: ASbGncszkLTbuUfA8qNVtIqqskHHnqElfiT4OyoEXyoqov2jbjpRRHT6+Ac0W5s2Shl
	zo7Rw+BLmEX31yJk/WWIXodS4BnMNKnXWwpqKKTAjXzT2IAv+25KN46ptw9b3iYUpZ58pXR9jO1
	eMbt1KLXCg9/prmBPFIJsT1Qojc5g2d2fX2ixl4fM8u4gTD923QoFYRM+758Lfo09qlEgUahhVB
	KyTia1koApuyI79NkUnmbZFgeCr1e315JVcsq9UEcSIxZP9v04u/fCZ/5LdXEF9VOaJifZjIVb5
	rOVQ7XeDO7y386VjzUeB2jiMCO/0vc8Us1GC3rKw0H9VRbv1qz5TDNf5p8l/5FpDY0jbAgWZzc4
	nub3tdVoJjGrBcp8Wj3aPQ6rXzu8npuuj0GEpKyuCFVcBQYstf9SY6A4CCHOd8EoG/30Ikavvjc
	tKRL8/sSoLUsnwfA6qiKw=
X-Google-Smtp-Source: AGHT+IG1NIWGb6yb8aTuPP0df4GUqJGxMUQNV0iMiGhVNs0Iwh/tBZxIEkWhq2k/dyxz2zPL4fznfQ==
X-Received: by 2002:a05:6122:3110:b0:54a:1ec6:b1ab with SMTP id 71dfb90a1353d-554b8f3e2b3mr3467330e0c.0.1760015838910;
        Thu, 09 Oct 2025 06:17:18 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce202c6sm5321139e0c.5.2025.10.09.06.17.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:17:18 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5565a83f796so875001137.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:17:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX61p1R4vIRvxVv3HWUZUcir1bovMt0iT7Gv0wJ7tEt139C56Zpwdg+Z/1YEcMaMuPZxZaaMyfFHgT6C44=@vger.kernel.org
X-Received: by 2002:a05:6102:1a06:10b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5d5d4c81309mr4270060137.4.1760015837455; Thu, 09 Oct 2025
 06:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251007121508.1595889-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251007121508.1595889-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 15:17:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiyQjab-zENSnJsb0F73ApHK5pvA8ZiA1+1pB8_wzyOg@mail.gmail.com>
X-Gm-Features: AS18NWAB-kAJIRsXlBWFwb-rCqWpfJug0iWQY1NUZ_QF1SbJ4tlp4bCFSXh7Wxw
Message-ID: <CAMuHMdWiyQjab-zENSnJsb0F73ApHK5pvA8ZiA1+1pB8_wzyOg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: renesas: r9a09g057: Add Cortex-A55 PMU node
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 14:15, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the performance monitor unit for the Cortex-A55 cores on the
> RZ/V2H(P) (R9A09G057) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

