Return-Path: <linux-kernel+bounces-846456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C0BC80E5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7919E3AE322
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28786288C2B;
	Thu,  9 Oct 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhqv17dM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E98BA4A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998780; cv=none; b=Y0r8bEdSky/A4PF5VT9gcch2E8Wjec45jzXNkxsrwFUptl/6CCpvS3QOrPenAHycsXAh0roReHNaY6ocYpcpnnduNgiTEyeJVQ11r9bkbvDErTSA5sh4aIm3gb2ze+noOl+X+EGS665noV28qWQwUHdCsJDDqYku0/LJ5c3dPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998780; c=relaxed/simple;
	bh=zljMLJhTqmHi2q/FCnKIXWrWrFEkWPNiMAl0+Hq7D2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2DH0IPVLl/wgjtF/vsvWOMIQWHbs/sZnBQ8bW4yq52VfpW9YoYKRGs+bzu6oBeg56vPUAwqGnUlYkGPaMKj3f9h8DvmVY0qFTqsde8+LyaMki6jHvBMcSO5HC9j0uwc8f4nZok4vg4mKpjk2THSd4SXtKZfJL9D4ETGNA7E0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jhqv17dM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-373a1ab2081so5542971fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759998777; x=1760603577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zljMLJhTqmHi2q/FCnKIXWrWrFEkWPNiMAl0+Hq7D2o=;
        b=jhqv17dM/YK2avzLOJ5fVM1xlJrPnS1J0gGa/+ec+ujLYF2djssLkyunOykHm8jWJH
         x6N9qz2rkV/HSZ7Rtf+Szwjwpnu2Z2BTPlBLQs+etaZ5zrQKzIzFSMIkAFtli2iLjfeP
         UWAdDBsXeKzyvO15FI/xGodADwontF/oFYM5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998777; x=1760603577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zljMLJhTqmHi2q/FCnKIXWrWrFEkWPNiMAl0+Hq7D2o=;
        b=oghj/kE2vvR49StQO87wcNVkKFPV4sDx/DGP2m5+HmLoFspi9rN3I6/3vVjTrbX18Z
         cePRMnzqLKBs3f713rEMXzbQLe/G39DojZSTt9nX1/qPCHUKzjHGWU1/D6QIl+5tr9U4
         0MxXt0gZw+ylNfKoGTdnWfdOnIoZHjqFZxp3LkKU4GY13HbakRlowx1a6hJylzBX02N4
         muMrm3vu2QnICxGKU9unSBspImmwIyQiemyZ7rjgqVCIC4GNKWmUv5dug4Nk6enyD18R
         aAsJUYS2/Y4tH4CcQgPV2EE2Tvykrr0APs5UZ0lLjKOqieAXZWuN86a3bVcV9jepEPZ4
         xBEg==
X-Forwarded-Encrypted: i=1; AJvYcCX4VjsBvmEwFR41oWof1eUq0+Y3QI09/uFifb0JnfOdGlJGebUFtH2/sbqtkRd3bNe0N9UyTQAvqWFU8Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GIUxHpH5l1d8HSLuM94PTUyhj76ZDIW14jcccrsoDCW0k4qI
	sQxT2EnEE1au27LzCrPHOj8uS3Tf0CpQTx0foEigjEuBZN2iG6KIXMmlovKySHnhTWr0bW5nyh4
	LifvR1yMEpOahQuOK4tCcj2gc0p9Jg2mo9N9JRf/t
X-Gm-Gg: ASbGncvpDVlxqVtKVShXR67dMIITtc6bJFrF18gCeWGoPcN6p3mAsR4YRyBnMUmXiR7
	EagdselttEOnujU/BPNrRsas/XsVTH5DxqO7yun3eSNmG0vvmnyHCCQ7sp4DPq7rYI+bXefQFkd
	TRJv7P+0uD6K2x6c16f+CzLyFv72VEYN/sZ13JqHmBa0pcWvZxKfXhQM4NLFeSpXnxyMWS/Hybt
	s+AOfbJFI0omfa22dauvlJYxXttwZuJqKVSjyelX+pcHg6kSFGmEL5dYnkfPg==
X-Google-Smtp-Source: AGHT+IGNqC+T82k2UhLGhs5Z+RJRCLCjdXUj8T+fy/dwo+JYeZAn+ZeihTGmoYgDd/1wSNYOMWZ3ybZyqQU5hYgcf5M=
X-Received: by 2002:a2e:a99e:0:b0:36e:93a3:979d with SMTP id
 38308e7fff4ca-37609d52442mr16172291fa.19.1759998776858; Thu, 09 Oct 2025
 01:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com> <20251008-mtk-pll-rpm-v2-3-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-3-170ed0698560@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 16:32:45 +0800
X-Gm-Features: AS18NWD6JVU3Hv0pwNvYA85CDPCr9XWrThP36lbmILYiActB6r-bT0qxLSR0NtI
Message-ID: <CAGXv+5G8XMRGasd2=H_obsLJ-97M-cNPDo3BJCrwhx2+GHhYcA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clk: mediatek: Pass device to clk_hw_register for PLLs
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:06=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Passing the struct device pointer to clk_hw_register allows for runtime
> power management to work for the registered clock controllers. However,
> the mediatek PLL clocks do not do this.
>
> Change this by adding a struct device pointer argument to
> mtk_clk_register_pll, and fix up the only other user of it. Also add a
> new member to the struct mtk_clk_pll for the struct device pointer,
> which is set by mtk_clk_register_pll and is used by
> mtk_clk_register_pll_ops.
>
> If mtk_clk_register_pll is called with a NULL struct device pointer,
> then everything still works as expected; the clock core will simply
> treat them as previously, i.e. without runtime power management.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

