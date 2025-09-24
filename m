Return-Path: <linux-kernel+bounces-830492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE9B99D43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB393327451
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B713019B9;
	Wed, 24 Sep 2025 12:27:44 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2922E62B4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716864; cv=none; b=oTPRU27T2+H+W2zAlFNYladd7TIM4n33IRNHifVKUAI0mxvPt52HV541R79PlKscx+VwvZ3z76UoRRJ3P8yylnVhF3UhdIteA/7T7tsY8Zi0HUkLRTL/qxiyyQCChsw9hvAzPRSmRBhkZiaNRHg5F1meZCvxlCVhUtDyGcpfWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716864; c=relaxed/simple;
	bh=m4UMSJRwUb34SEoWabfjkvMgMST+WZDrebs6YW1/cBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rr/Am5yTK5oBGiE1joL5cFftgRa2Pi2A4wUoUKGaux6pnoDubTmlQqMh48MX7vbi3ncHq0V3aIu9oqgDOVlb8lqPPDFsV0fkHxlkYGojgSQwKeBeFhNGnU2bmlLrd6oobGlPgj2tBaKXwcAdFwW8ibXl0AvSMfyYRwjwricb/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-50f8bf5c518so4863980137.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716861; x=1759321661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrIcrX+WqLkK/OVX26j4zeOlHzZuccByNgRjxzFWguA=;
        b=bmGfzPXK2uZ/iaeAlBysPSXFfiOBhU6rr9zRREKjXNtF8glXnqBDraErqaGTm8QZYL
         mPAPyLj/IK0K0kduo6UhRlOhcbZ9wN/Jk7snh/gXZW6JaJ+osYvAVUn9KYRab33jHMfS
         DSeAlBkdc5NG0iqqM4R9HlRXY1a3Fxo4v2VnVizhdEbEUGPSTK2389RZcWNwunEEzzMz
         klpdB/aGgw7awCheR8CxOChVDsZxa5oo20pE5sVqkukdEiVL7g5mbFO1V7vPHEd5DPqT
         wRi3h+tQP0JfymB2lsI45A9gZCkolTa5cMEarhC0zJ4tB4o1/nYjrx4FwnKuQqWunlTy
         rRNg==
X-Forwarded-Encrypted: i=1; AJvYcCW7EF+tushYyWp8jf/5PLP4FhZYH3r9u9BQfLYfMDC/oe4HtGVICF8E/pxihCe5IMWnGIC3M2smG27MGUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKcJusKYAKatPcci1zjG863HH3PInwNNqHiqPD+iMh28EDkfW
	tQ+QpkVpPv2WxIZDobm8sR2PQi+rIREnDQ+GCY1lRm/YU/5CHzPYRXl38qYN9cnF
X-Gm-Gg: ASbGncsRkANSCzUWyeMsj6tRc0K9xK8RLARyUE3it7Y52PHpStNDCbnSfrANzhRD+bJ
	+Ft6sBDb83PosMJJXf5mEoSV8wSkhARL9ai28ODRwNXWLoIhvKDYHGiJvDbP+79hgNYZM25pEz7
	AAOw4DCLZJI9klq+42t4wV7vks/jgFdpaxWeVo48HaMENtVfwJMzvc7JaMrl04KoZDe4rvUK66A
	aC88dqY9DBFNKkuY5VQV7rxSrEGwLrKD1xxl2o5wTnKQV2WO0/ZXO5kMY822eANE4KmHIM/KIca
	CTZEj3yat5nbdEsgGO+sGbgj0ZArIJ0fhxufndOLJojzVOpiH1oMRVXfjBreUwch05R4ngkMkJC
	veq3rd8KeKIar9ZPLMZpC5M8nCRnjb+9wrHl/HmFvosNkfKLDKHhkaHgtI1jzc6I3JTS45nk=
X-Google-Smtp-Source: AGHT+IGu3P2z+TnxRtDFdBUkd6aecjKrvgeXkIMglBjt5nKAMGbRqZEb85Awiwvv+qKWaWBM3X6vAA==
X-Received: by 2002:a05:6102:c03:b0:4fd:53e0:b522 with SMTP id ada2fe7eead31-5a5787acad3mr1895335137.19.1758716861193;
        Wed, 24 Sep 2025 05:27:41 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e7fe91bdsm3292982241.21.2025.09.24.05.27.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:27:39 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-58d377d786bso3580373137.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:27:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCqRBK9vIkuhiTQo7gnZAcT59XrEnUrCtbX0f+ilqfiJwH0x7Vbk6N3Td/l9Zt6RvfFEnQb7OlunanTMk=@vger.kernel.org
X-Received: by 2002:a05:6102:32c2:b0:537:f1db:76cb with SMTP id
 ada2fe7eead31-5a579b1e1eemr2463960137.30.1758716859238; Wed, 24 Sep 2025
 05:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com> <20250916150255.4231-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250916150255.4231-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 14:27:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUACU1tPKDgoOhgBW8KkDCxSEzqb7TnucYk2dW2jOet5g@mail.gmail.com>
X-Gm-Features: AS18NWCVenDuOrUB7TMiuq4fiv2syjlHZqz-8Xrb3HQqOfe_05Duah7vTFUtX5c
Message-ID: <CAMuHMdUACU1tPKDgoOhgBW8KkDCxSEzqb7TnucYk2dW2jOet5g@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
To: Biju <biju.das.au@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 17:03, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Enable USB3.2 Gen2 Host controller(a.k.a USB3HOST) on the RZ/G3E SMARC EVK
> platform.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

