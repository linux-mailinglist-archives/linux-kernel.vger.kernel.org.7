Return-Path: <linux-kernel+bounces-752903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6CB17C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6842D1C233F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1F347DD;
	Fri,  1 Aug 2025 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xxvsibdl"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0E3C17
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023500; cv=none; b=MhQRWCTvm3qNVuPXO8cZvUGflChExovaTaFypkjCedbV5YtoLTwrlP6dgXUIb3JOZsjucoz1rQS1aGgFotDbCms63cVW7e5QND2XK43TmLYpQV/ytUv2rOiKrLTOUi3qEhixLzfiD0I+HKoMV9NVgbWuD3eOgp/ehS1MGZkF8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023500; c=relaxed/simple;
	bh=0Yp8+sGL3lRpm7HC5BKRhWpXDbqCyYKzOoJSMIzIH6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/RX9iwc8vhWLJLgfLZr76AB6XlB+n4CCxVjbl++quIrRZNMksU1yLOS5wRW/F4iD8mtFjURXvfU86qUI/p05zbA1peRHZMetCqRb1fXa5TlmqH4/DBfHmhd24D4keov1VHN2TtlkbmchEWyHe0D8HtLsJ0Yg3C3hfSVrmt2i98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xxvsibdl; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-88bc6f023edso449802241.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754023497; x=1754628297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Yp8+sGL3lRpm7HC5BKRhWpXDbqCyYKzOoJSMIzIH6A=;
        b=XxvsibdlRKOal12ONE0cMCH5vzD5gU3tRGNyT9485Ov0lFoxvurGxlKiQjRfyPZcSV
         C1Vj+eGB45m0/wqWIhlgkwLmsGa9kK860oON69VoyBAml6ZPdQ2XJjLriZykEl65WwYD
         0eteSb953COSpRC8u6FtX8XyxS+W9G2azm3Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754023497; x=1754628297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Yp8+sGL3lRpm7HC5BKRhWpXDbqCyYKzOoJSMIzIH6A=;
        b=VBs6rDf9z7kkjVk5ZeZ3+Q/SgzMvpIapMvU2SP4TdgxOgecXoXK2C+09usmCzxSQUx
         /lO5yiYQi7Cnt/kQAdkLovMhD3SBulRGa+yHAZxnylVIc184OD2wCloTryGQCzVU3WXG
         bK0Z0RoRnVSog1bKTMPhJ/guxm+dlIkbNZ3PPFuZbI1S41VeNkrZ/t9USUPDgaclD6o0
         CSxEAUFhRpsqCc9a2lBhN2f/+KQkaG+T4TuyVP0wGo0bBI1cMmGSH+SuOLRYR/XFlq66
         EInyCrn2WWXbsnpf84dixtUDmiAC3qW65s6TdcsH1e61r43qRmwfiZuwazbXCh7hF9iS
         uWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdZA0lNabUa9Ii3DIzmCV20GoKtUXBGyeRPBXVEtwChDWLmY+Qik3D79Np0lP7muMa9zE6paFmDeDW2Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEonaSf6LMaeERQosd7OEH8QeJTrYymu9DBZrHaKw71BRd59sZ
	oTG4dAmUt+X+levz8YZUeBA8E5LU/u7P3483nBwxSIfDwRfE6GFXLsMQaSHmQtg+F5kHzGtSTDY
	Q/ts=
X-Gm-Gg: ASbGncujG8hmigQT7pOvmTVZjjCmOb47aApi46TfBffzVsovJx9XEo/hwX89eyWo9b+
	egVNOZQgfFIsj422ha8HsnEn+UswSTu40swtZvdQ2dxr8hxatBQ6m2Q/HUfecQ3nibEW584h2sm
	WLAGsWIMMULIXBlPP897RO8GMAz094e0oOqnFR13CrXF5qDbkPKG876X+eo4Y7w+r+b55Xl1YjV
	uTKfiZR782+9/Q1QZxybjd0+xMZmkDWV4IMtOqFTWiZuppqH1Pdq4SEZptdrf+z7fVu4pLkNNoO
	xVh+BTqrjQc9En/QF1EYfQBIBt6SzQoMCUbmYqMQ5UyxhscaU5i41jPdBLvdDK60NSRQ+L1q3zC
	Vwii4xySLMQ6axmJD0mqwzgaeacUBt1QnAacVKVt7/l8ajb8sXybs7nD8uZLSMQ==
X-Google-Smtp-Source: AGHT+IGq84pER/sZIecXOelHI4zsPED8/4ZzRx/KJycUrYqxynRo9mX8ZihEzIqNg/IpX/Gf7CycAA==
X-Received: by 2002:a05:6102:c01:b0:4fa:e005:cb20 with SMTP id ada2fe7eead31-4fbe7f1548emr6500457137.3.1754023497195;
        Thu, 31 Jul 2025 21:44:57 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f325540sm737204241.1.2025.07.31.21.44.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 21:44:56 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5393d190351so587580e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:44:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViRyGN8KwoYYXFMbqvwxGKqT5+2CFLAxiS5qOjFdKxOFBEuKFCRyy7qA0kHuSn/+oj1kIo6rnD5AbrHvQ=@vger.kernel.org
X-Received: by 2002:a05:6122:521a:20b0:539:345c:f229 with SMTP id
 71dfb90a1353d-539345cfaf8mr2385080e0c.6.1754023496106; Thu, 31 Jul 2025
 21:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
 <20250731101441.142132-1-laura.nao@collabora.com>
In-Reply-To: <20250731101441.142132-1-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 1 Aug 2025 12:44:19 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngjmk8-C0H2Nii4NXE3wsL1dYLQp-PXafG0=oaOVsYgmA@mail.gmail.com>
X-Gm-Features: Ac12FXx2cQ8dN2cbGqrj1qjUfxVx4elX2aD-gscg8zxkv2Gb7ghx-fdTpW8_Hzc
Message-ID: <CAC=S1ngjmk8-C0H2Nii4NXE3wsL1dYLQp-PXafG0=oaOVsYgmA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
To: Laura Nao <laura.nao@collabora.com>
Cc: andrew-ct.chen@mediatek.com, angelogioacchino.delregno@collabora.com, 
	arnd@arndb.de, bchihi@baylibre.com, colin.i.king@gmail.com, 
	conor+dt@kernel.org, daniel.lezcano@linaro.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, krzk+dt@kernel.org, lala.lin@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, nfraprado@collabora.com, 
	rafael@kernel.org, robh@kernel.org, rui.zhang@intel.com, srini@kernel.org, 
	u.kleine-koenig@baylibre.com, wenst@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:15=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Hi Fei,
>
> On 7/31/25 06:25, Fei Shao wrote:
> > On Wed, Jul 30, 2025 at 11:40=E2=80=AFPM Laura Nao <laura.nao@collabora=
.com> wrote:
> >>
> >> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detec=
t
> >> abnormal temperature conditions, which involves reading temperature da=
ta
> >> from a dedicated set of registers separate from the ones used for
> >> immediate and filtered modes.
> >>
> >> Add support for ATP mode and its relative registers to ensure accurate
> >> temperature readings and proper thermal management on MT8196/MT6991
> >> devices.
> >>
> >> While at it, convert mode defines to enum.
> >>
> >> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> >
> > It's not visible in this patch, but a heads-up that I see
> > lvts_ctrl_start() also depends on whether lvts is in immediate mode. I
> > wonder if anything is needed there for ATP mode e.g. a new
> > sensor_atp_bitmap.
> > Feel free to ignore if this is a false alarm.
> >
>
> Thanks for the heads up - the bitmap for ATP mode is the same as
> sensor_filt_bitmap, so the function is already working as intended.

Acknowledged, thanks for the clarification.

Reviewed-by: Fei Shao <fshao@chromium.org>

>
> Best,
>
> Laura
>
> > Regards,
> > Fei
>

