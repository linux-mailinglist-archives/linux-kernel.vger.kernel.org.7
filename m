Return-Path: <linux-kernel+bounces-817589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A346DB5842D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6108A1AA745F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F22BE05E;
	Mon, 15 Sep 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlYySSfq"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7022264A1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959099; cv=none; b=oKXhK7lle4jlHWdaaZZwlZpCMOddqaAyDoV2hyQmH8rn03B1PfTau7N1LY5dXaVnfXOLf+IWBtJKWDAcsaFsgfgHfsPf79Wtgzwi1H1qNl2Yj5YViGO5KuTqFBdiTjBMX0Q8rY3UsrFCBPngdVRgEVwMtGuYDhQpLGUbtu+4Oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959099; c=relaxed/simple;
	bh=btpDNW2yXS55mw43CrFDIwgYj8ahszEQskra937/uxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5OE3N+7eXBPRXlFsXkZYz2+gBVzXpoHqoAwm+awva/W61JIjgmWnZzFjGhD2MVOL2WMMGnu6hm/9F0DGOak5+B/og+70UWe9t+KHYFNaTImiiPN/RFL0dbVuqNLquEoJPgD+ITxiFJ7KPJjtl9ADtL84QeaIuLl5sxENoKDq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GlYySSfq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5241e51764so3351411a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757959093; x=1758563893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJLVEM/+RXo9abva332LMQ7q3OHHpZR7J7yQ3y9DZUM=;
        b=GlYySSfqtvgNBtZBKqhpr6gK8UG5IhxZjWX9O6Nu47qFoB7sv+yEeaga0n11n7SRzC
         TOmzL+5v7T8B44ET924YOqNtrvzUj07UaR2ecAq1Vv08GkRdXuHX3aA6fet/BeK3IJr1
         Mr7u3i/cpN18p8PM5StTpTG57d6/WaW6j6jUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959093; x=1758563893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJLVEM/+RXo9abva332LMQ7q3OHHpZR7J7yQ3y9DZUM=;
        b=iW+0HHkYAv3Hb8S5AtKaIkR1HovPckjWG/3hKIMkj7k8ApZTCx9WFhHs2rd+Re5g8k
         vmGkt774gtagzn7l/ZlfWHt5P8lpObI8rQkBTbaIGcJ0Yfm1PMmc9hPHhujC94UScCGT
         we550ujhwKcj6fqN8bu9fU80YVtJvZl7zG7anOt9x2FlxLDo6GwgspNoL7RqNV4bmLYK
         aKahI2ywcel6UJPPWg6OEHExNGNmkIhiAnBT/vq6Xcdii9nDK8GohjpfbCigxYyWpCad
         wBkrxck20kF45PZ/EEl64wWhcBh4HRZ58ry7fBU+T62g92xzLocn922DGmNAlmOWjPE8
         bAMg==
X-Forwarded-Encrypted: i=1; AJvYcCWKcXKKbV5iy0f4ic9rwAL8dObmUILo9+I5b3qZh+yLsh77uHG5c15qpvaZKofUAu+fTTjeP0YfTPC4DWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqN01mhO8/rHajWRzPpoI03ZAp/oc91n23IptFXlqzCVYQLMjq
	nF4fJUZxlnX2FCNuQBw3Emfj1XIujMXSoP1ELROruD+8mQF001Di7ONLRPFIhzy/A8YRBJ1HV7t
	BUQg=
X-Gm-Gg: ASbGnctboro6X+lNRMuRqco2erX+h6ieRk0O7jjVgnb0Hc3Wfi4hSZ699KSTZEHKNKP
	Kz0yFDl/FJMfYSOnK9o1rfPPORdmZsKEQLGMtfbmt4BrG0BQsKvIVtdFrYwZg9OyFq2LUv9Yy3Z
	u4aI1nzSrFMTBFTr8iaJBYaPGJzzM/OtkKMVnLaDUKOtmfg8oK07Fish/O+e+/my/icwX89S/eV
	nbdRc6VFFbIDxTmq57LP/cep4HibXEAJx6gtD9/4DjPAbwGZO/BUflQyZetGIczVWFGjwdiZEt5
	pUq3CFD3HM9q2eyuwUncSCpLHRxgt39ano0NjdVbXuChZwzUOsiZO6p83VZ39GV78F0mmTUZLGn
	m4FBqeN9px20zp5wS0/A/lM24B6+sGt7EsvSbd6ESAmR8S3Fa3aokiq4++S3o53D1vQ==
X-Google-Smtp-Source: AGHT+IEBcWBON2+sJM+yzoDiKMftQ/loAGphw6WyQDiaVdP8cwpvMyA2NSKOZ5DsK6eEYEYXTgi41g==
X-Received: by 2002:a17:903:b06:b0:240:83af:e2e0 with SMTP id d9443c01a7336-25d26d4ca7amr148205895ad.47.1757959093434;
        Mon, 15 Sep 2025 10:58:13 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2631e29e60fsm62765725ad.137.2025.09.15.10.58.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 10:58:12 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24458272c00so48498905ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:58:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYuVJQzIzNGh2ak2xgoBzh7AANc49xVZvrlpeMKuVHzoaT5am873v40bpqN23FiM8zY51AI/Gb42X3Bx4=@vger.kernel.org
X-Received: by 2002:a17:902:f686:b0:25c:f95c:8122 with SMTP id
 d9443c01a7336-25d26470527mr169156365ad.30.1757959091192; Mon, 15 Sep 2025
 10:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915165055.2366020-1-john.ripple@keysight.com> <20250915174543.2564994-1-john.ripple@keysight.com>
In-Reply-To: <20250915174543.2564994-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Sep 2025 10:57:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xhd+0ZsUE3pkkii-Gijrwx0_Oh6WfRKrutqPQT3Jm_rA@mail.gmail.com>
X-Gm-Features: Ac12FXwvS7Gg8Am23kf54Y4k8rEMwg-5EolA1F18RxI6Ae5bp3Npfh3ORkXawzw
Message-ID: <CAD=FV=Xhd+0ZsUE3pkkii-Gijrwx0_Oh6WfRKrutqPQT3Jm_rA@mail.gmail.com>
Subject: Re: [PATCH V7] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 10:46=E2=80=AFAM John Ripple <john.ripple@keysight.=
com> wrote:
>
> Add support for DisplayPort to the bridge, which entails the following:
> - Get and use an interrupt for HPD;
> - Properly clear all status bits in the interrupt handler;
>
> Signed-off-by: John Ripple <john.ripple@keysight.com>
> ---
> V1 -> V2: Cleaned up coding style and addressed review comments
> V2 -> V3:
> - Removed unused HPD IRQs
> - Added mutex around HPD enable/disable and IRQ handler.
> - Cleaned up error handling and variable declarations
> - Only enable IRQs if the i2c client has an IRQ
> - Moved IRQ_EN to ti_sn65dsi86_resume()
> - Created ti_sn65dsi86_read_u8() helper function
> V3 -> V4:
> - Formatting
> - Allow device tree to set interrupt type.
> - Use hpd_mutex over less code.
> V4 -> V5:
> - Formatting.
> - Symmetric mutex use in hpd enable/disable functions.
> - Only set and clear specific bits for IRQ enable and disable.
> - Better error handling in interrupt.
> V5 -> V6:
> - Formatting.
> - Convert pr_ to dev_ for printing.
> - Add error check to regmap_clear_bits() call.
> V7:
> - Move status check in interrupt.
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 112 ++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to apply to drm-misc-next next week unless anything else comes up=
.

-Doug

