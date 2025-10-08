Return-Path: <linux-kernel+bounces-845396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53741BC4B84
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5543341758
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9E2F7AC1;
	Wed,  8 Oct 2025 12:12:35 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD51758B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925555; cv=none; b=TbKMt9h5efV5+X5teNRduxzXWaGUybouG5/i/nZUgk4XCxkweptPklbd7qW6bt+AQPvd7NmcZ34sp6urfLZE4vhTEtlc+XQVZckFUoiNnZ007ioMx8pfO+ChvlaVrZnksOrrQHfJqyeplts8JyaYX32iMv1zaGropiEbT97avW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925555; c=relaxed/simple;
	bh=o1l3n2y5YwxEXg2rM4gAYMR7pahw4lA+e2lcwHc4J4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J85XImzg5IvlmK39GxiUhzK2wc6jDTBx9rJbPy457a/OYQS/aeL3Y4A0se63HH+/yLn2WMKYtEWRj0s82iuiUX59ChgqHojmzlN52NaAfr58gryj9eE8NwBcgsya3B7pJf4B7PmVbL848fi10RkKVn5OLeyYt+K3AnrURKAK/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso3580785137.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925552; x=1760530352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Brp2nrWlwG3bN8c/hrIoL4Nm2qLdFlreoXWyVG7Wt10=;
        b=FRR/MVz1iQ/gViluIO7C5w+bqTJvK+kly4nG4A0zOj4N/EFEHwBhN2Exj+slpG+Xi4
         XSG3oya6S+PlV49mNB63PWevO7uFWzdKzXrOytDCIdIaG35veKoONIoH3ASO1cj28i4z
         qZ3UGDmj81jqI4f9ewdBw8c7wuAcwyOkZaxX7QhLeiIvryXO16rhSl4plRaR8jz2pdHk
         pIWHlrUcoh7yIYzOj+jtZ1g6S1uidqbbFjZHN2/BwlKuFk1KXtWa4C7cKn+415oYFwLQ
         NiyLM0Zozbutqk/qoAWYjAGKMEawsJSUwWv6YHy/bKjA8/rAO27jBSVJxSRri5T/9Lba
         023Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4bNGRhQU6eol4z8foUygMPuHkY+IjofYQKvN3aq0XsasuKsAckErI5tMzdZkjLZ6NGqRuakUdST/EJTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrqjjv3DipTLbdw7/lRHigD3PygOEwcb6yI4GPh8GVR9cuq5R
	UwTVRLL14HLZ4vCE4YfBVBuMG4qUjSiU+4WbHgBbdhF/82dGSxnD97qYOM2BhX7K
X-Gm-Gg: ASbGncvc3HA2pmx+Ju9TPbgqxiK84UXBnfeo/dNkatC/N+u1/KCfkrdEiT5FEJVFgGZ
	yWjstWL+q8sp6PHVNQkUze1h01+Za8cbmU0foHrlf0yL/YpYIZBSiX9+KaLrIx+Ak5nLzGndGPJ
	jomEz0gtMHF0RiZw7FJsmGHWok5tipNxBzy/Yhq3Otyt2kcXmv9UXvaOijEWnYK0qZiO69HEoBa
	5XEf/8w3W6Z+DcCZ9LILH72F8D57PGYkoEgQ6+UN3X5LAZbdWlGPl8XCHiHOVw7glvt/6W9/AWr
	ijoFY2KpLusz1Q1RXvZlFA4db99GzKTs2BrjFkcJB5O+wSMNPuZoVGHOeJr+A7N0oYy/gO10bqM
	+yl0l2rn7v4Tx+7PqvCYCb79z/KLzxF5/6aahzh4GH3OKCkjqj9MjrTvIeDpUI3dJdjun2Hy1CZ
	6MF0cRKAOT
X-Google-Smtp-Source: AGHT+IEE56NgFUjAJuVG0MeiC016K5kKS+967Xq3LrATz4Fm3HTY8dhA8M9ollER1i3n8V3TaD2n5Q==
X-Received: by 2002:a05:6102:32c4:b0:57d:c090:dfc3 with SMTP id ada2fe7eead31-5d5e2376f9bmr1035860137.29.1759925552243;
        Wed, 08 Oct 2025 05:12:32 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39ad6bdsm1565431137.10.2025.10.08.05.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:12:31 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso3998219137.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:12:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeskcM6pGyDtHFbS1a2DBpDFVd+MDAsoselEiYKg3I8Z1eHMZqNIGDXsOhvTfKl3Gt3FSXrzJEAE97/Oo=@vger.kernel.org
X-Received: by 2002:a05:6102:f08:b0:519:534a:6c22 with SMTP id
 ada2fe7eead31-5d5e23b4082mr1034500137.32.1759925551779; Wed, 08 Oct 2025
 05:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com> <20251007133657.390523-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 14:12:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWf=AfW40m0qJ3_P=Ni=OsO=KMqDY7USdvHEXmrHM+mzw@mail.gmail.com>
X-Gm-Features: AS18NWAtQie1NbudVP3BXMcF3ZQanxK6LGXJKC21rxZI487nMAs440k_Psy4Pfs
Message-ID: <CAMuHMdWf=AfW40m0qJ3_P=Ni=OsO=KMqDY7USdvHEXmrHM+mzw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] arm64: defconfig: Enable PCIe for the Renesas
 RZ/G3S SoC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable PCIe for the Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

