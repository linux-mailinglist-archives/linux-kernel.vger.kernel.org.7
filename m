Return-Path: <linux-kernel+bounces-836222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8DBA9090
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3583A34B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C980604;
	Mon, 29 Sep 2025 11:35:08 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F242FFDC8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145708; cv=none; b=cibTUxFso7cc2BEVUBdX+120fRe+Gws8UYd0Br/nZ7KJUMwFByFnZNX/RBgPQqYk2HxAjVkh3flFz9h6B4Z/hBF0upky3sBPdgS9z3gQtmk8ymTfHbIeD7w9OXpYzQwNgUCTT1lCEORTA4G9xSN067U2Ghz4C+IGgkrLBb2puMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145708; c=relaxed/simple;
	bh=ch7c0GMzEBmON//ATPEGlDV9ckg4jFVTkG+ER5Pa/oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8p2zOPwXYGWoH4dNhGaa5Hl4orRgRRhlWZXu122nZ2ChifK6k+C0a4BNDEiGcDuSVl1guGmchteD3L/vR/sVf05OYXTHrCHjnROIJneATPUxhA5u+OdVtCzcgCURJssDqhesE+v9om1XBOiFcmWc0jAVjBMaZfBME2hgGs5hZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5997f407c85so1583575137.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145705; x=1759750505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zscJNsz9LWE1JCbi4f4RqWFcZGer3C+FRtSw/qqEOSE=;
        b=PpSWylKDK2tPJnBcJOwz/8OQUL43cYQOc2DP3NGStZO9kDCPDJW7EdwGkxWJz+PDIK
         F8DmrnjmQXHeBLdfph1D7N5JkdO/KX3mx30Y5mkhe945eom7FLQkukTxjxRTWNXPHgov
         gGAEeHzPY9fc1jg/9nWZ7Mkm9VGv/dzhMy6yUL7x/oy8O9FZlzAMCTDcQVdoE3euIQ8K
         BfEpGWJIkXpAnBEXJ93MUJYAsOMWh/gGGJjvM3O5NbtRVDmbQShx5zDS+lDbRDjcf02I
         ciCBLnmLiB7DVP2s1kLOl1l8USLa+MZaZD60epvJQF9eArSEAwJOi9jW1SzCLVZTdA8L
         fWlA==
X-Forwarded-Encrypted: i=1; AJvYcCUg9up0Q9OhhXB6HdpsR/WU83NpsGw8W9wXHU7fCejYH1hX9d+eToZrmo2kLLHrlRteHO2iMc6/2ufd05I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIM9lrQ7D7VvkAPOFyo1io/sAaGdvDOQZg0Kl3WAor7Yjq3M+h
	PpI7i+8kXldoDPi9YDWqywibTwt7QKFmabLz/xD6Xf587de9+FvhN8VXUj8F4YJz
X-Gm-Gg: ASbGnctmO/9YsP6jFaCCPjv/kE/iDFjMfER52j1upYQrzCvB1Z+oA9VMrsSDnYAJm8m
	9hLfQJ3uxiPWd3usE23gSXks8MZwLdRXeUrog5iexo4ZkQYF0zrLXF/soq5I+uWiQiuaqGgxIOC
	Xq8zfpSie77COLqCTCINpJd+xV11wxCyUzomDSp10LK5xTncvwCeZGmCV7B6KaIIFbkzZEPTGue
	ES09kqSyjseCB40KnNKDtwJWlH7jULd+FIk7ZqwJE6znswBWtNLsuP/PBOEDBmiG5h30zCHGGnU
	nPznRZnsqwt9BibCyrCvRMTPlAn6hRxfWHCnVkJH3wuHRFBZ7S5JDU4bgUc8G+QbDxe2rWvv+sf
	wsn8NLxysddHnkqDXI0/2O5xyn0hikl/Tsfmem6zg22mWWSBJYSy7H7uhskgP0OUfmFj2+2Y=
X-Google-Smtp-Source: AGHT+IEnbvpIfdZA7DVC7LGlG5N6atHzR0JQ2ABDBpcxWB2SwM19SjT5oKAH7HoKND3EElEqhSmVRA==
X-Received: by 2002:a05:6102:442c:b0:5a4:69bc:aae with SMTP id ada2fe7eead31-5acd008aabdmr6091853137.29.1759145705573;
        Mon, 29 Sep 2025 04:35:05 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae39eff1b3sm3302388137.15.2025.09.29.04.35.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:35:04 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-890190a3579so772131241.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:35:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrffFiDEyamn7cOScsGiqjtwm50gjgNGfhB9e8rK+xIHOq87vyxiOQPEGQYM4ht2rwt5v8Pv56zmRjtFg=@vger.kernel.org
X-Received: by 2002:a05:6102:292c:b0:5a1:ea0:f56d with SMTP id
 ada2fe7eead31-5acd0efb09dmr5673188137.32.1759145704110; Mon, 29 Sep 2025
 04:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
 <20250917170202.197929-4-john.madieu.xa@bp.renesas.com> <CAMuHMdUw+cVtMkfnWjuO6BUNPRd=gZHhiD=KqPxugrJVLOe+Wg@mail.gmail.com>
In-Reply-To: <CAMuHMdUw+cVtMkfnWjuO6BUNPRd=gZHhiD=KqPxugrJVLOe+Wg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:34:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVazggwwtD2pvtzwTwX5XWf=UWsuezTU4vJnU5gtT09yQ@mail.gmail.com>
X-Gm-Features: AS18NWCxvZMcs4IKeRIKmjN1qwZhpwGWh6ZDTAZia6k6h8LSwaxFUr6lA65qWRI
Message-ID: <CAMuHMdVazggwwtD2pvtzwTwX5XWf=UWsuezTU4vJnU5gtT09yQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	lukasz.luba@arm.com, magnus.damm@gmail.com, mturquette@baylibre.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	p.zabel@pengutronix.de, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 16:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 17 Sept 2025 at 19:03, John Madieu
> <john.madieu.xa@bp.renesas.com> wrote:
> > Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

