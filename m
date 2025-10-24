Return-Path: <linux-kernel+bounces-868613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867BC059F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B74AC4FC5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822103101B6;
	Fri, 24 Oct 2025 10:38:47 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC230FF25
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302327; cv=none; b=plLex+II0yczUha6SMNyvfmbREFNGya/dRZDwhJJvtIUZzvazmbyR/lHMSwUaUrk1qxfi3OlD2Fy1Zon553TJSe8Dgt4HuuwgsSkAE0rjlXKd5xJu8cKce56/GSG7JF+CYGgkqMZKK7ZkP1jf+QDCoipPArjFXNgoIhH3u2Tvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302327; c=relaxed/simple;
	bh=4aqMM2V2h8+Ukj51rclziCzvwPpszThxOiAHjq+32ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoJKOG874aOIn5871xygvUFPerOdmFE53/RvOSBZyBXJSh8/ggE/CrYfn5ZSBkj3KY9bXSP4diqv32fr9r8i1TspWq2aYdW/hU1sjicPkjox5U7WFdbsTNvmy+4glOon2VtpoHcP09jr5n9hOizoaGn0McjyoiI+mwJG9Fy862g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-580144a31b0so1168056137.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302324; x=1761907124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORay2JAYaT3uXyXxpnw7CEar8/xMIWtpecxnO8T0h9I=;
        b=kMZPRpjy91kCZVMWjPs4KErmlJftzVbR92ah1qk9DOMRRyZPxOZX0+d+uhEkrYCCIy
         jk35NUbwurOR3JLrHtMPPXcZlulJZQPrAvEVeUgPmNm483mY+ZvxHpYT7JNJ5FcifqFk
         YOqp39SmnaqC7cHsjj7BWwsuG7sBEybaDRSyfZXzwqR2smfkTNri3ZAUTbIA+oXHo9b7
         xKcrtQ5v8Y4n/kdR3GXTxWC+1U5tXz6LlbnRY0rOyczRFJDocs5kd3JyeyauGbDMLh8J
         PyeqB3mptYSb+bsS/R9N2XqBJ0Vxrygnwl3GlHIdduHnGnwSLKCR9h2PalEAL04AgUyc
         ydew==
X-Forwarded-Encrypted: i=1; AJvYcCWMop16Tn4p0O0lWvnWlVVH2NpgHGWdydpGeUksySLo3hcswE33ul5kstKm7NgIjo75dWgkxDv3tXCabMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYEqG9nX+V+etzObu+OibNeVlo73lqBt/G23BnWXkE+1zA+US
	5g+p+cPevATOeknWJ+xzkXXq02u5yIkvNwZeZHhC9pTzDXKNjgHO1zqbrp+WBw97
X-Gm-Gg: ASbGncuwrOq62QO7LnTjWD8v6wx8VpXtPMcyi2lPPNDOvglCmk/PjFW1f14KjsqRGUV
	tqU+thBuNsKo1PqozAQBXvGF8aHDfkeDXY1bW1ppuZDiye12krKFOyB+Q1Y7ByBAXb96fE0pbx3
	D4NmUAUHW9WXdQcQNjl6blVdVkSy8ZdwZPsEpNL1Hjwc0aGWL21DwrH17GUBQDDM49nlFJhCNss
	n58mo/Fz0JIRJQtvoOi4PYA+7/Z812qlKLhZZa/AdvC1XcSxpBmVf+2ljKLE5BZAbXpV56/fdQm
	uavUzNXvtsLqyJ7Z5JO5BfVcOdK4nseK9JtxyQcK+Vq4RZZ6XXimuQ6Ion+VbYjmciSY3OEDU/s
	ccbBG2M7uuG8sqjloq7yeUgA4byiT5ossg6n4MGX8H5vfzRCvurQuYjzurMnGUse6HHEl2us4Cv
	sTuWUZbpwr0xzX77P8qlBp3Sqif0lMeGkFn85U6PKZJQPbdnzB
X-Google-Smtp-Source: AGHT+IHNWV1fpn71gbkRLWSsjzrHCO8dAFtY/OlsdKpM0bAScf0/1vQcMwRneaFXc0nPNzWE0R2kiQ==
X-Received: by 2002:a05:6102:3051:b0:522:db47:90ac with SMTP id ada2fe7eead31-5d7dd55566cmr8871348137.6.1761302324129;
        Fri, 24 Oct 2025 03:38:44 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db2c77bc89sm1941569137.3.2025.10.24.03.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:38:43 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so2136645137.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:38:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjVZYBeQsP3NwR48JLpmcicmExiPdhaPKbtGw3MYHH3MzWzouQMDuZjFCNGnevTzIZhYoUYUbLiQpNj04=@vger.kernel.org
X-Received: by 2002:a05:6102:dcb:b0:5d5:ff4a:87fa with SMTP id
 ada2fe7eead31-5d7dd6f5c1fmr8926294137.43.1761302323213; Fri, 24 Oct 2025
 03:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023210724.666476-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251023210724.666476-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251023210724.666476-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:38:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+XsMz42cmSK5tu6DhZV-5ZqJCa1c9u0-YxgMe3V_5=w@mail.gmail.com>
X-Gm-Features: AS18NWDY2yKje__-I7uH-MFrHGUKvE7lNUPe_6x8wQC7kjvQj6AdehD9vn5JPrs
Message-ID: <CAMuHMdV+XsMz42cmSK5tu6DhZV-5ZqJCa1c9u0-YxgMe3V_5=w@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: renesas: r9a09g056: Add support for PLLVDO, CRU
 clocks, and resets
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 23:07, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for the PLLVDO clock and its related CRU clocks and reset
> entries in the R9A09G056 CPG driver. Introduce `CLK_PLLVDO` and associated
> clocks like `CLK_PLLVDO_CRU0` and `CLK_PLLVDO_CRU1`, along with their
> corresponding dividers.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

