Return-Path: <linux-kernel+bounces-770123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44AB27709
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA51CC8BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A42BDC07;
	Fri, 15 Aug 2025 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kwvNuP2C"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB441A9F9D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229404; cv=none; b=a7o663GN48cCpO4hWQ0ttMKbLsccWrhOLKrC3Sde0kZUZUTOq9hMb2zKl5/MKcYQSuhoxKvlPmsCy1QqFa/DTfBvaeELnGdbA1BWlINKwT1BorFpPY1fuIlsDiK7a3GJgkkR4iVQ0OZO9j1GmOnDgyxzzJbzk5l4WPL7twxiTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229404; c=relaxed/simple;
	bh=b1bVscfxC4uFT/CEoA/bhRidOult40TJcVZcOy00MCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd19yGwi9Ez5kmO7aJ0WBfAm1dNkUtVTpk8Ej6w0iDYHD+AYxlDBlFkiEkgSfL7MDUEUV95+EKXmhjBVdQ1QeH0E5PD9cpr3l62CNulIXIRA+1DWfx6UWgts54uhThXmEVlpoArc8k5JzKLK7uzTwZrgxLes81Ov2BMWhdyJPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kwvNuP2C; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55ce508cfe0so1553256e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755229401; x=1755834201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1bVscfxC4uFT/CEoA/bhRidOult40TJcVZcOy00MCI=;
        b=kwvNuP2CIZOJMuv6JQVxGZF7wCgfvL/cCINTMjR+jI/e/I80srcqTzD2IdB5OTKOMh
         EjKdYYT91g00ngvRlnd9VdncuLw6ZyCiOPuAYcgMit/ol2jw6VcOU90uXEEYkqmcO70+
         g1GFtDCE8xJdE7Nmm3IKuPmbxweVaak5KzfD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755229401; x=1755834201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1bVscfxC4uFT/CEoA/bhRidOult40TJcVZcOy00MCI=;
        b=HUFw4XOQ/Dw8bfHqBDresVmX29KKlpA23xdgRncfrC/PMYMHnpK9DYnoTs1i32dc3k
         t09siQOl15XMTC/KAr1RXl5peiv7mNZV5Uhtivbip0FRZtGUxfUX+lAhKNuf5s21euQJ
         y8SJY0flib/PBzLIqONbu3+U/+lWqtPGqCww+tobx7mbstG+YhcSr55xhYiWjJh6ibqg
         5Ty45BqKKLrJuqj0SCNt801Bh2Z5DyykDF7qvwpsStEEYbg7f097BgFOsR0XjzBC93RU
         58K8TIMzqGEgyIbsCbnCxQTJZmcWtxS1tGcqqaohe3yjppvfPr/zfJQLKLq53blmO1jC
         oPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIbF3beY6iU2akP5++zMIQpcbGHMV3y2tIuoZeZpc3kuthxMmrcVNSYYzVOq171cwqtsPXHSgp2/igbgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wsZYLD5SkZzfH302LREPeQKOZynP/5Or4DkYBq479d8b/D6i
	v+ah66kDzUUwh0zFCgxeBnpLdFSC8CWUzCwLsvEFt84kVJai+ljYj6eBfc6NFWMSsRPqxukzC5W
	V7iZ+uEukVAnsKS1WAIYdxXK0+Yt8Ctd3epJt7h5f
X-Gm-Gg: ASbGncsLT7ZS6sVLmlyRm/oYelj0DF5YL1eqTd2dt2xWzjYN5xHuzdSrHOapTitI3xg
	32gmLJDDgvS7CMUS4tYZLFifgrH+yxHMHvCsERfpYD57WrOsi3CK+yeSWUspv3iuZ07l8Aer5Mn
	BuJonVYDn9SsysF+GSCDNwd9dEjUXVhf/PYs6qU8sVwEMsPkMbqhvvRuq8cX++3Tp4EK02JqHki
	1wLbeFJ3W4NNhmcQBZ8Q97XAUZ8YG7IdD3ONg==
X-Google-Smtp-Source: AGHT+IEqCwdjtNotzKv7k6sNon11epPQ9Q7yaZt1pImrKpO8J5PSviVGiMjVATClFXgSR2SA/yoBT6p78Ov7Q+2gotM=
X-Received: by 2002:a05:6512:3e0d:b0:55b:84e7:e14a with SMTP id
 2adb3069b0e04-55ceeb42b0fmr131122e87.25.1755229401420; Thu, 14 Aug 2025
 20:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-9-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-9-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:43:10 +0900
X-Gm-Features: Ac12FXzyZO_yczjiRVwJ_XiOUJ7K7LAiS8kN-QE11MKfkqUjTCK5j2sczcKt2tQ
Message-ID: <CAGXv+5FwV1YuBoefMAX1UvOd1=cg9Ld1ZawyNts1BR8YMezhKQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/27] clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> On MT8196, some clocks use one register for parent selection and
> gating, and a separate register for frequency division. Since composite
> clocks can combine a mux, divider, and gate in a single entity, add a
> macro to simplify registration of such clocks by combining parent
> selection, frequency scaling, and enable control into one definition.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

