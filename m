Return-Path: <linux-kernel+bounces-728048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCCB022FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2CB7AB078
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550E2F2372;
	Fri, 11 Jul 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUUd4SId"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD82F19A9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255872; cv=none; b=MSqXyRl/+RDLIwsILem6qfKCf4ydTGzaUTCtH2Tu/VmonIcS9sVDVBLgmRvZhnBTH0bu2KJZ6Riq1cDV2mdT6X4RmEHipW+mpt+5o93N4vZdbSJx4oOzKAImqymi3RyWK8qkwBP6SsQUER3vrt/SYCoKQwDHmu6lQyAGYgC3r3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255872; c=relaxed/simple;
	bh=u+ZM5SO8L4rZ2xYIS3dtWrMrDyHsyXlquIkrSDaXE+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y87NKmv+/iq+iuHsnrrLfYbD18S3TEHJPShfKAHHNI0nlGZqrWRsk1A12Gft5eanEwx3YsNjkcms5zURrv2n1ooPjssWocnEyqK6J/O2aH1qhpmD7u6nXeFDcL79bbyVLbnqvli0QJzc2AMF8pSUOcHKMCW58EO/R9Qi2EUJuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RUUd4SId; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so21804641fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752255868; x=1752860668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+ZM5SO8L4rZ2xYIS3dtWrMrDyHsyXlquIkrSDaXE+w=;
        b=RUUd4SIdJbvakysuyj53v/ouHK9sZMKllZGJ2C8yMk44LRa+g3eH02ZWskxW10QwJ0
         RFfRpIlkxTlPVK4mN11YJWSQEebePr71rOabZTT6uaDoUC9rKzzuMRZp3yA/LbiMfW6l
         FCd4t3Kci1fx43bhYAFtq97wWLQgBBve/BAn6K09JXfcrSgKyttrpyWl9jYpL3nwljAI
         4863pNLzhlBm1lDUIv9W3t+5HiLoWquy4kxLVaGdkoeuNczFNKZbv+VnjkcacoZv9vu5
         /Gi4M7Ei5GBWU3sm/l9bfCmwWY9wnEKVFEAnXP51eGwBY5T5+RRbnCUtDb4GwtWFIr9s
         BDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255868; x=1752860668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+ZM5SO8L4rZ2xYIS3dtWrMrDyHsyXlquIkrSDaXE+w=;
        b=l6aomWsH3VC8cisXpeV+69azWDXxmec7qO58gGE6okkSWPkBfgRdN0eM3BCq45cEtA
         ze4XJkxxCBhotiej+G6RCaNisKUgO9oUiFhcrZ011uyMNVH6EjX8bcL30XWVDXgCg8M0
         Nd2tkxGl3DHoQltju64yr/vJjjxc1S+0BwinRLXIZHd1Mnu2dssxmSFJBrf2um+oWfcM
         2ikpayrWrvXa78m+USbkulskpN5RaYXLSFQktIVBelkJplJ6PIL+43HWAC9GdZfCJSRF
         gD4kHxbk7W5ajbTZILv7d3gfk5Pqx4lxpUjjqjYZyuliBi9Tz9qJg0Hk3lO3wNQG9Gn3
         WcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxg0kdxkpolLw4XieoAqzVX7H3QLuQfCkHfsLPPNapYnFCu0PY28oT+Mb1xlpbO6d7AEJkkZ2N/65z68I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+H7c6+sDOlUFHVFo/ozbNJ6hB5o2qPAgZIOZEv1CxFLj6sUH
	eOmwpXwug79IkNe+KcN9zuSiWq8nJjSzfAlPSaAwpj45OjLKAdJxfOdeVKnMcVYsbAltM+a4Lxs
	1+76ssyw5NVzMza/dzaJbNsM6YuhkPiXLZyzkQQ9ByA==
X-Gm-Gg: ASbGnctxYte3LMrkETHxhYvFiJ1Ce0f3A96DqlIFk4+6uIaeiyeoDLKZXK6oQx2Z0gr
	Bkc+X9ZxEJPL39w1Fovs+DuDt67VntIBINtJLbE82vXWSUbqzL/rxEr7Tp6RBTwwHJuCsE+P6Sq
	b5eV7+JhiURaLcs7B4jPkBcfGMkdhDLwx+tTXvf4V8+UBZk6mLt46Wycze8PaIwW3UbK84nXh9X
	iSP34A=
X-Google-Smtp-Source: AGHT+IHCwFbr6hM4SofCoKFNuaGsZexul62ZHJaP09xPkxTc5K3eZJNMRyy9Lqm+DJrLEpWrNm0Dt8rNW5UZHZ3ILnk=
X-Received: by 2002:a05:651c:111b:b0:32a:6b23:d3cc with SMTP id
 38308e7fff4ca-3305341163emr16031911fa.25.1752255868348; Fri, 11 Jul 2025
 10:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com> <20250710-drm-clk-round-rate-v1-2-601b9ea384c3@redhat.com>
In-Reply-To: <20250710-drm-clk-round-rate-v1-2-601b9ea384c3@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 19:44:17 +0200
X-Gm-Features: Ac12FXy5w5LZfYTJ16GWumg6iWoXPYqfrbZ0euf79O43X2SKG618Bj4k3h1lAGY
Message-ID: <CACRpkdZus86rP1BiSw2j24eaSuMrCEorZU9Rc4ouWmmz8iaqhA@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/mcde/mcde_clk_div: convert from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Stephen Boyd <sboyd@kernel.org>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:43=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:

> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

