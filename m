Return-Path: <linux-kernel+bounces-836228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A52EDBA90D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAB17A6A11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399E30101D;
	Mon, 29 Sep 2025 11:36:21 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147A3009EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145781; cv=none; b=Yxl3lIVRixMxjD/dotK0wV69i00ws+IcWVe/4sjuDUdevwvKmIdUUMh0/0RoYv3wOOnuc52KkOzIUecuYfZ12Zh6RbW7fkFpUlQjZNk5RaC+wiOdgcIQrwnERplvhpQJ7xOqVj4J5q2n7QptVoIKTbSobhY/rS2oAHhYcb8cFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145781; c=relaxed/simple;
	bh=mnFFlAyLIwT1Q5AcB5DFjSNt1dV9nkw1CzOpVFtZBvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkI/mk9Vrj6hmV5K3XcHh3pnWgFEv5CYqrC2ToiKo4VtozQ1TBR3pcucfrtrTee9HdOChmtQyrmcOkwsgLAOiJ+LSmW2nINbziemDwajmvZ6xNbq3AE9F0pXLgqCimCkPwEiI5dEUGn92TTREbAyTj/I14I9yMOiSJqySc4aM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso238269137.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145779; x=1759750579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wo+c49wamlH5OIn4NEbxEDOQ99erhVXBTj7EjS/boc=;
        b=LY8xkkNsZ0fbIPvzB+PvTLUQZRJewAhu+9q/OrXPcYqlJdROy7FOa/tycOwqQEF0qO
         20GR0YTNmrTcQxOF+eBiUsHLI2s3EWFu+s39xxdaWkWfwRsUus7/iVqK693IOuKu8Ogk
         /nAW93J6VEvQSit0sV9/Ym2B/pRZQKm7ZxeKxxgF5cfS1zPmEWJM4si4adODJ8T0iW4d
         po5KQGLg0EpFIarXNTPg1YaqZkMJ7XSIkc9pJcmwFhy+jY7D2s0Eqm2gZTcPmcz7r1Rj
         7UurbeFbZfkYU9NxRdinhhYZdIQprEQlQhrFsvog65lcc/QSFsNtDxwa8HHic7O6c/LA
         jGUw==
X-Forwarded-Encrypted: i=1; AJvYcCVw/KSBdjzYQ350Q1LiuZlNwUsFgivHYYhunftqnTE3W/lwCRDOid6rWtz2QdrKFYwT79CoDEx6Giv95wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUElpGtsfjQy578O7pBQixvXcOrt+41vF0UNvSgOn738ETPc4M
	40ETQ5PI6Sj7ARGeITcNByxYKWuQqBt9CwbyGPOi/4A3PN/WUO/inX69tD6ER+Yd
X-Gm-Gg: ASbGnctuBJBQrATlwGIB1TLeOU+hMJ1mvKmd3/wWr//jIuWozoVN6cp9pe92R7ZFwia
	juvt/4HgkKb1Uy9JSvmjD4rxA50F+mCJcuuX2OKW9X8BF8cZsxphtz8MvMGlwW8oKCFSfx7NXVn
	Q+9FClxi0MnTptLlkLF9iTmZmqOr75rt3jiHPLQ+H89rY3+qJ0vz9MZqIUIjuOBza55ZYu29leD
	exblcnvhH6pbUvzd1YGx/nhNlCnBGo0NoMdwWwPDr5VwFEFoLADLowNvHQlizvWDEaWkPHkm+4K
	MFUowxnm/9C0qA7ratJM9JWJN0Ip0WQ2YAvzN7B5InRerC6NzdF27aM98QCWey0K1JAnTvO1qE7
	063h9uULRUNPYKBA6NOYtyHpAj17mRLfmY9ZMtEekW1RY5ubok0THuMlaU6e8plzyaq0oV6U=
X-Google-Smtp-Source: AGHT+IGu2reUtKjJMAYlItX/hcteF0PG2raLWewhzMi/OcSgwxPyyhlHkdGX3HU19Ksc7U1T2KkT6g==
X-Received: by 2002:a05:6102:d91:b0:52a:4903:95af with SMTP id ada2fe7eead31-5accd4f6945mr4827082137.19.1759145778712;
        Mon, 29 Sep 2025 04:36:18 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae39efda42sm3278243137.13.2025.09.29.04.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:36:17 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-51d14932f27so2340815137.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0WSTXxdeijRcPzyS5pw2uG0eD46DKBLFoy5nWN8Odt7Hvng2ZaaZ8W877PQtgA36snIDA9EaP1rQ045o=@vger.kernel.org
X-Received: by 2002:a05:6102:38d0:b0:536:7bfa:22d7 with SMTP id
 ada2fe7eead31-5accd215f1dmr5953694137.18.1759145777154; Mon, 29 Sep 2025
 04:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com> <20250917170202.197929-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250917170202.197929-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:36:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfZG=FEMesgTz=q4agJ0huMPFe+gsvX+8-zmKBup-Feg@mail.gmail.com>
X-Gm-Features: AS18NWA4k5X5kIR9EAR4SmDXTePu3QOZUfbdTpezmeEEx4rSxAt1uKChq-x8rPA
Message-ID: <CAMuHMdUfZG=FEMesgTz=q4agJ0huMPFe+gsvX+8-zmKBup-Feg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] arm64: defconfig: Enable the Renesas RZ/G3E
 thermal driver
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	lukasz.luba@arm.com, magnus.damm@gmail.com, mturquette@baylibre.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	p.zabel@pengutronix.de, rafael@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 19:03, John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
> Enable the Renesas RZ/G3E thermal driver, as used on the Renesas
> RZ/G3E SMARC EVK board.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

