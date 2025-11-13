Return-Path: <linux-kernel+bounces-899589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E2C58761
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD24F1274
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEADB328B46;
	Thu, 13 Nov 2025 15:10:20 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC12E9749
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046620; cv=none; b=c7zylEdoITCK3YFOVczXIPpJXv/gfpfeSQLdWVDdS8s226qexHZqZRVjtDlLYOKxeLOmTa+bx+9hD9uzf6Ose9dcHKfF9ypGqJGRQhEYZHkGyhhjMwncw1ROCMjWrWhMUIy4ZrY9EtcX4Hnk2rIcel2ph5nEl7Mt4NUQ2JPDZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046620; c=relaxed/simple;
	bh=96Y6UTc1RsC1zBGnStoKZ73w488HXsI+oYFS9qcYNHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY3zGi9r84H6WmRxxlPej/TEVwVZel7P+quD5aNM2bSfb2zzmm0H3OkjRxdl4Ij+25EhYATE/B8D5uaUNKpGe0TfbtM9kSh6THdtOufccbMaH0z5+wsMl1sJ+o3s5/w6xpWoNDglb/OxbFrswSbf4KT3fu7bc9SakNBprqqvozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298250d7769so5591675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046618; x=1763651418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ubK9EQtGlqEmscuI2UlEc444kIJ9wNNtF0OWUtH/PI=;
        b=v/7JWw3CB7E+ln69TgRYT5wBXS8m4SQGge7qJ/yh78M4CCZUfpCXGDoLwKZOI9pQLr
         qWRBxUrXNzQHd15JQmZoEJ/FO3yyyb8mh/5wg59XMjDC1AOqJWzA8hXM3uy60T0XBrjZ
         W1Im4EIVgDzFjMg38n/Ml36vWWLB5pG7cI3pwJtrm6hHXs1+NTQjjRymab6zoeVJVmHs
         Nd9ua8Vj2Zb0Pe6lxZmj/YawrRcBHslggU4YnhtyYqQwY3K+aO7VWhqCyxBSBpM/Lm91
         OqoRfmyCLiMNtboyleKIwmXWkXu6ZSbf8aKirnqJLfiMVR3sukQfufE5A9tyq0dKm74/
         phaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBkyyuvcn8GvG6tT0SZC2NleIbvJuAJU9kom3i9XF4GnB78KTqjch2F4lr3kBbZyQWpCWrFq/UcqfiLGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnQ5qWshWYs+gjUO+HoJ0twLcxntdRM7u8LOmr6Y+rpKWmwEi
	VZGu587xIRyr/QizvQiIfmIx74076wpPBboncawhTupao9A9o02+E7A+HO7CsjAHdVg=
X-Gm-Gg: ASbGnctSfjn6joaVjCn7GFSPnLXlcKEYw1asygKHAoIxqUSPU3doCFO2s8UhUi/h4X1
	MUBhZtZjzfSBCZnIjFVyFUUgt1kjQdKx6kCckkZsHucnGylYmmqbhi9ZBksOGwIE4QCB3RJ+BQO
	ujCPtLhR9I8WFo54XAcR+luSz/WUXjzSKakmqcpC2SS4b5S6SjSiOS/KMvhUyOonm9kiecOkuRE
	v/1kji4bVlGF8CVWQjLmyVj+egw1eIgFHvP/utW+deOtXN5FPvqWCkh318rAwzDL2UpHq8cVbYc
	cmMbZAY+ebiKnIaroy0eUscCJKSQlRmdyrvAV5CKz2stmMBiBwIBpXAeIJHWawwTXelJu6pIeMJ
	0U1z6m5ukdRIeuSPmowpoP7JSc7CugIe3IEMBdGqCYbZKOT03J0ervfWqmP3DmjRyVhijyHR5Wy
	oxFUda0xYU4eDl2An/L2AJC+WtKOu6rTj8chDwlKQ3JA==
X-Google-Smtp-Source: AGHT+IFdxzP7aZetGEjaCFqiL0iMbztOReM0sa8LxnAlzGzdvZlk4BXVhUUTPtI/cZg+kULRbz/4jA==
X-Received: by 2002:a17:902:eb8d:b0:297:c638:d7c9 with SMTP id d9443c01a7336-2984ed3e7bamr86331505ad.13.1763046617907;
        Thu, 13 Nov 2025 07:10:17 -0800 (PST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d76sm28468965ad.68.2025.11.13.07.10.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 07:10:17 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b98983bae80so617397a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:10:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWs4oVoM0zIUgV7ikoaTO2KgyZ0SVncWP40SIO+K2FMWS5a/paZiq+IeOljD+LMrIfirILVa7O04at4wvs=@vger.kernel.org
X-Received: by 2002:a05:6102:a4b:b0:5db:f573:a2c with SMTP id
 ada2fe7eead31-5de07d2f924mr2287392137.13.1763046294441; Thu, 13 Nov 2025
 07:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com> <20251023135810.1688415-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251023135810.1688415-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 16:04:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqoi-1GgyC3ZpmOupNtFxaUwRx8C4Q3iO9nx_hMwxX5A@mail.gmail.com>
X-Gm-Features: AWmQ_bntxYDPmpH9FJ7BCBwIP1rRXvUl6W1zgLobUSlsMYdvdi_L11aPQlSxmS8
Message-ID: <CAMuHMdUqoi-1GgyC3ZpmOupNtFxaUwRx8C4Q3iO9nx_hMwxX5A@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] arm64: dts: renesas: r9a08g045: Add USB support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 17:21, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add USB nodes for the Renesas RZ/G3S SoC. This consists of PHY reset,
> host and device support.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

