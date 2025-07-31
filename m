Return-Path: <linux-kernel+bounces-751575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC6B16B09
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BD562072B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA391239E85;
	Thu, 31 Jul 2025 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixO+MeEr"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B223DA921
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753934634; cv=none; b=DUeD0EGHVsKmROUUAM/OgECIIjnxLki76aEVCJuCHUDTiHsqV2pWkf1gWxU3v+IPNY6kevOuRw0INK40cMg3g7RwXywRFv4n75P66m0bpMwjOR6rOXD5b+CCF5R+4X6LOR5jj0IaQplK0jzPFP9ibN/WDaeqz0ZfUcWssY5j1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753934634; c=relaxed/simple;
	bh=/ja0EnpPMJAy1a6pZm+E6r8QXYWmEMOdxVyXZuJR5eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzxBcAjjCXoFKhLLSRXyap+Mo4+zIp+TGrlUfnTf+Q5zBXlPchW70nZmALgtnH4IAW6tzNYuXcDC6CfkM6yDTp9mw4JcV7Zeoe8PcNq0Oq6uFQo05v3SpttmnTgdOrYRJ6AiDxwMe7L3Yp0q6kx/i2kvVCfyC2U3eaOxKj8QYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixO+MeEr; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4efbfe9c7a5so1084071137.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753934631; x=1754539431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1REz7lxNqCP0vRE/ucDmbyORYxFecR0vhh1/DbBdVo=;
        b=ixO+MeErDzIYBgca3U5srSgSpk7GVV0YnMBR6e5bAD2iIi7eXJf1LvicgQeC8dAWcT
         A3H2xDPs5L/7pVM5b5aWLlINdVYlS8kPBYjq37MG9BGFwh7HkgrSJhb17RLkzLpslVHd
         HJS1vuKEGTNu/eSP4LfkqQNxGThf8UobPwwSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753934631; x=1754539431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1REz7lxNqCP0vRE/ucDmbyORYxFecR0vhh1/DbBdVo=;
        b=AhW5C4IdkPz/FxQ5OQ1s85t6ddjnZR3FoJB303YgqxcHyZvd1dHoGDbndZMzHyk0h5
         zb9XuGjUwEiF4bx9RGh5basPweAIlP9dozTPn6Stj2xFvalwrCbFo7QAUUEhZh7axPYE
         Te+HQ8L+apOjzF7txIddtRjcBKMpWNiOpwUnUBO8hlx1AFrOr1ZiEnC17mMPBsx+hZSi
         XgQcN5dYgwcHnxIhiG3OdjSIbSXCBv4BCzyw70SOBsceCC278i2K2zutbTDrT95Mx1NM
         EIs6dtwDDHctck/ybU6AwYLVpgnzG30ead2dVKtL3qv4o3bAfzDhSpGf9aHQktAPxPIA
         jRJA==
X-Forwarded-Encrypted: i=1; AJvYcCX1SqPLHng8hf8uCs2hrIdprfYaI2DFrka6dNNsXEdU+DdUuf4i8PP7S0kC7mavRiGoLeEqakHFCAaMwR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEX26cauW/ERG+xtdptMsvu2SL3jhGb3CjXdlWppwfsYLMjiJ7
	dqA9NeBAj50ANmVxDCUMhcwM8022PKY1949YSe0KLQ8PeJuPY7dyg5UFHu9HgNQrp+j+8fN2d05
	QyKs=
X-Gm-Gg: ASbGnctJ2hHDGKkBaVJouUlVWtqYGxrXflDrrTTO31e6QxB6vMGtzikuuOI6SVbUjoz
	+kGni9/K2WBJssRAeB56uofUwmNRRks3AAewm0O6sIWR1+Ge5XpiBjVz4/PrvC/3SMaJQlfgIBv
	cSu5DIwVSvvaMrxn37Nm4XYTGxkmihqhVfa5GvkNkLvAqJdioRjdSdOjXcW3hGWj/47JQTe5zUf
	dk7/RM3BtzsZpADduDECbYLwzldITkJ8eLwpn02TJLDmMUkuQNzfRX3k6UD/rDxu6QOegIK6qSS
	k7VWDteu3tey3AHTUGpLnkL+0G+48/T/PQntUrqf+h73r3vzSffGl9O0ZB7YrK7maCvEmzIEvby
	6uxmxIqDFGYpYiYvNCnc1fStEY9fXsQzMkD3nJbrtYP332QI2Rvg3caZcWQ==
X-Google-Smtp-Source: AGHT+IHw3zCJUIwUk14BRF9V4MF1fhpSrno+Z7SnsUejUWueuRDFkXR20Q4+bZaY8H0BmLxV6uOblQ==
X-Received: by 2002:a05:6102:3596:b0:4f4:af8f:589b with SMTP id ada2fe7eead31-4fc1007787dmr239476137.10.1753934631436;
        Wed, 30 Jul 2025 21:03:51 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fc0d42b8c6sm146730137.13.2025.07.30.21.03.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:03:50 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4fbf846d16fso309816137.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvz7UvQhLg97AUQAOOlvbtXpZ3hdeBe9iPPqdWuWyMrYRlMOG37tObypYi3qpSEAqxeIbXrXjjYu8KSMc=@vger.kernel.org
X-Received: by 2002:a05:6102:5122:b0:4e7:be09:df07 with SMTP id
 ada2fe7eead31-4fc100ad7d7mr227087137.12.1753934630495; Wed, 30 Jul 2025
 21:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-5-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-5-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 12:03:14 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngvS9z-KOZXeV4kLiW_pDx2F+3AOMcTokaq9O=-E4Pneg@mail.gmail.com>
X-Gm-Features: Ac12FXze0WWvW6KolXpxHVZ5mr5bsteDEMGk6n5CvaPH_JsjnG6BTJ_hncHj4Ic
Message-ID: <CAC=S1ngvS9z-KOZXeV4kLiW_pDx2F+3AOMcTokaq9O=-E4Pneg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] thermal: mediatek: lvts: Add platform ops to
 support alternative conversion logic
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:35=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Introduce lvts_platform_ops struct to support SoC-specific versions of
> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.
>
> This is in preparation for supporting SoCs like MT8196/MT6991, which
> require a different lvts_temp_to_raw() implementation.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 46 +++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 8398af657ba2..6e4a35ecaf34 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -125,8 +125,14 @@ struct lvts_ctrl_data {
>                         continue; \
>                 else
>
> +struct lvts_platform_ops {
> +       int (*lvts_raw_to_temp)(u32 raw_temp, int temp_factor);
> +       u32 (*lvts_temp_to_raw)(int temperature, int temp_factor);
> +};
> +
>  struct lvts_data {
>         const struct lvts_ctrl_data *lvts_ctrl;
> +       struct lvts_platform_ops ops;

nit: I think this can also be a const struct, since ops are all
initialized in the platform data and never change.

Anyway, the changes look good IMO, so
Reviewed-by: Fei Shao <fshao@chromium.org>

>         const u32 *conn_cmd;
>         const u32 *init_cmd;
>         int num_cal_offsets;

[...]

