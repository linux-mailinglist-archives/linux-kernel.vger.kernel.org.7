Return-Path: <linux-kernel+bounces-899916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40BC59464
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA156138D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB435A15C;
	Thu, 13 Nov 2025 16:54:28 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1B35A14E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052868; cv=none; b=enpl01azB++zGSas3W7ItO8G4nah0vCvwmuoJwo6SO6/EQNDHOrV/E2b/YALi97LLxgVY0q9SMIzYzqIoBi+99mlKKHlmVNvpGS7H0ZcQ1eeYBCUbl7PRjzgQi5SJWjuD5PD55rfJ3m+MAmxAGUf0cJH/VV/plEllX6Rz7Onwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052868; c=relaxed/simple;
	bh=/w7U1lULN0Wt5cy2n+o8BXmaQCUvdOw6lpumB8VVy08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgAZPNi3g9mkE1nTo+8KkOkmm5IW2WQJqvEwXE+i/cRwkrpDRfH5Hh9ZxZ7XZJOX3jL1wBxDX5UGBqdVJuD1la2PGP7hLXPs5M7cLJfurHUIgRcVe5JwxtMXmfLzdS6LgRv8/0uWCa2FwKV6CF+QZDatB3oUR0YWfrBTWwPw/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-935134ef989so657719241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052865; x=1763657665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiVTOOriFml3/StIKpZ5dwhW9Hno3lDZNqDkWyJuxDU=;
        b=B7xRIGx9DTLUqLAyel5+hsP1dM/l5xmWaaSnje4BbQ4BWMNo19WskZ2GUmcylful2X
         CKYwbHCPvtBJfSRbzWTM7WrTGW6aLmzJW/8PNO00iOUA11rYzx5sFMgnY7jx7oGeUssG
         2zqUQhPd6vG8jQMWARNS7CmWh2Uu4vHJH0WOIdbS6GS8dYLyQD7aZVc4X5WOoAD5rTgg
         Jctvb/MhJmHGbB4gLDkvfNy859GYedNiY/4ZrhNXFnbSYgczLTt42zUoip1y9UhJWWpj
         R9M/jkCu9q6o5EOJnAMGsuEK84acCRV1/KKZjhgA/qg2akziHMA6L1hTMbWsCVXIhpDX
         9+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zyn9/1Z/oj4rK4c0b9S74UEvPj63XxCsYD80Ex8Z86QlLOhhx9X9nJKqjITxN0T7dvDUKs3pq2Unuuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZQBeUFsDrjNlMnS7p4wSC3MZnh1gQOVsvokciQHdHwjc1DDp
	g4hmhOL3YqBBt3kcMNw8YZKk0uQs7Cv7DM9iL4jsXyUlOwJqS6jJDt3lYPpatT3rfAQ=
X-Gm-Gg: ASbGnctwmHp5XENJ5JBwjAc39UW0rOE+nul7wz2RVEsvNsgy+fyvMgCm+3avRb0f9ly
	tBo73f4yzDFj9GT9Ek8uFDxnv0ZjkWQ6aHRqeeHNmI3nXbWmIE9zfc+COeSzsHiwWfNObCi4eH6
	3J0DGoNDIoB5O2FsZQJiLuCRMZn/S94Kxf6Y4Vy1B01txoCOTE9DQV+AkA2IGARgrmD2AlOhhdC
	/GQqU9XhtvioUYIn9E1h+H8uledOumXwcvdd0eFX1+7JqO43RhD8SQgOGNT6ugGS9vj5I3JbaJs
	lRsI17RRUU/MrK2Z9XoHXi4lSFdcXWGdqlAkDuzL8Tp3hIUg/yQIAVF/z+IWYT6gsIFkxhSxNEI
	ub2I27wog8Ktexs0TUFTlEig0ZENn8DBH5UxsjQPhihljF6fkE03S/5MCShU/qJZFe6ZiC+uviG
	OxQ/meJv9AZudypM76vALiHvlH/mFprfmTzs+jQA==
X-Google-Smtp-Source: AGHT+IFmuaRcjFofFdjgk/8nhodNa0ddZA6+9iDAB6MkGuwZkt7OAkhgAlbv1ifRH420yAcIg2B6AA==
X-Received: by 2002:a05:6102:e08:b0:5dd:89c2:6759 with SMTP id ada2fe7eead31-5dfc5bccbefmr156332137.35.1763052865256;
        Thu, 13 Nov 2025 08:54:25 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f3307ffsm846993e0c.4.2025.11.13.08.54.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:54:24 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ddf9c25c2cso768963137.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtopzoHh65In1XW0j7CAeJiZTR5BjDTAMZ4xABqFS2D0Z4/NcqUpVQ60tQa6yBdPoWPWn43yift6KI8Oc=@vger.kernel.org
X-Received: by 2002:a05:6102:4a91:b0:5db:f5d1:5799 with SMTP id
 ada2fe7eead31-5dfc5bcb984mr194258137.33.1763052863591; Thu, 13 Nov 2025
 08:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251101050034.738807-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251101050034.738807-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:54:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6V-wQfiMPSE2k2Yi3dfWCj=Mp-3DYLwqHEWumYhxGSQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkUtT4Rsq0h-4oIRE82Mo78vsdX3V5yvPLmFpsMCot8nqUOZIzab71zY8g
Message-ID: <CAMuHMdU6V-wQfiMPSE2k2Yi3dfWCj=Mp-3DYLwqHEWumYhxGSQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: renesas: r9a09g057: Add USB3.0 clocks/resets
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 06:01, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add USB3.0 clock and reset entries.
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

