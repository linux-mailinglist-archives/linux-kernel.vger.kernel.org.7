Return-Path: <linux-kernel+bounces-836229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B734BA90DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD718189FD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193023009D8;
	Mon, 29 Sep 2025 11:37:50 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506F29D289
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145869; cv=none; b=ux3tSJ7O3B7olrrcnakA0UGpaCRuedM3eWo33GrdTZHEFE4DVk2RBraVYGVm2a6XaNXsGbSUI9UjnEmuzLYCq3u6JybkAKOKAHrTTu2lrUrM/ygtaDcpAmClK/as5Jp1hXennQCrzQvivMx3YHZ5rdoaBQLDhO5+daiQdVf2CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145869; c=relaxed/simple;
	bh=14SGPZS9nPNEndJRTPYwlhVvLeiJWTHVwacGI0l7DKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHqk5YN2W9Qeu+IzSVlkL4LMaG8KW+Mggq+J2kKGo0zsOpBUAJ0XQB3egfuW9iJDv4FF/WTcV4a6Uu54f+ktzCpar92D+ZwPWnXr3CLzMxHRmHyVmAljdjEHFK1afJeSlMTdR4QQiC0n0l2XAUmRWg6GGURGkYBIZTyfQnAaiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a8f6a2d80so1615699e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145867; x=1759750667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weWdXbQxCnMJeHS7B7BXqXEXqPpjTdZBAI+JQlcZ3Pc=;
        b=wqt0L7fPOi1+EcQksD9cczxlAhwr9aZOUhuwMhRhcKBXGXKNtWFyngnH5vWwzDRsRu
         j09svnxhXFE2BjClpMdLNKXXBBjzcmyiYH06mIjhIYG4kYzs5MZFE3dUZcF5l5Tj2fCN
         Ohk5vn31lE6bBlCgl9RrB7EAhKd5BkBxZKZzQt2SlLjIB5sov1zZSD366qpPTHXDdy/V
         lat9T+cOmRGy5LF3CgHoKOLa8HbTmU+3esw4zCbIdpPUeKU8XSefsstRcqeSSw167xfk
         B29WmKEkPBHIz7tZXOV0WxMrzqRH1jI/OJxZ5zp4LP/G3CYojxPcgP38ehZLcHLckTV5
         Penw==
X-Forwarded-Encrypted: i=1; AJvYcCW3kvim7xB5FkhJ1/riumH40qPpfw6Fq2/h2TmFFlY81Vh+HNTTi1RGGRCAFu3SMk95rshbybr0gB58KOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMM4/QGJR+mQJKIJJytQQWSPBi3zWzPrc8oeyKP0z6bh6BC/t
	MdCxdlMpR1/YGZkTCJUDv1WVGuDaX4j6P+Y8NzuNEfDXvIe9W0crBmftPQzWV6Qz
X-Gm-Gg: ASbGnct26NDFR7DUGSS+2pCvQCP6oL5wajFu8UXcgu+Acoli/KYb+et2Z/U7ijbbE40
	DjZmpX6TE89Wz3wF6faFjsELSEfxXMv917ajYhfESSpQoaOUekGD4TRCH5B+nvVIhIFzM1BedmA
	t9IRXy9DQtu8tABq+mWtXcELLYjdVLUYd7fO7zXeFvqtBsPiKQ40U/+LCDJaDWbJ+CwqDvUaHq2
	9u+65EuAxG/SUBUoHKmclmQdpek2ocbho9FRN8PDjU2KogAURhZrNpyfOOYbyC8Clal80WALDWZ
	MncC/C6yJuc15DjW+CMcXMTGrQEmnJQ9n9B74Hqv345S6WcSGWeKCck6j0WXAfrx1J+AGbvpnOP
	r9QEGwRmwv1h0F75n0MI746uCMT5B1D1Ru6GkI7+n93NPFvvgjhhOdypqtxqEYRKi
X-Google-Smtp-Source: AGHT+IFIS6lJLQZGh1TQ2ldmvxkZGcJaBejO3Y2olSmoNE53/3y5f6PW3od97FQ6NafXXmLTH892vQ==
X-Received: by 2002:ac5:c7c7:0:b0:54c:da0:f708 with SMTP id 71dfb90a1353d-54c0da10569mr1829298e0c.9.1759145867124;
        Mon, 29 Sep 2025 04:37:47 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bedca040bsm2175886e0c.15.2025.09.29.04.37.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:37:47 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54bbe260539so1813187e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:37:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtwgmIr6JpyX8xRZxnzCPNxLdD0ou/lcJf38707r+pBUPQ6ezmQjgEmEBMw57TDBxZBpq8eyTxWqbCC3o=@vger.kernel.org
X-Received: by 2002:a05:6122:7cf:b0:544:8d16:4541 with SMTP id
 71dfb90a1353d-54bea102e5fmr5636901e0c.7.1759145866822; Mon, 29 Sep 2025
 04:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com> <20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:37:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5zSX5URg4vY3Mm8zo9ghE9cTBOMg8ozLZJ2QevF=7uQ@mail.gmail.com>
X-Gm-Features: AS18NWCeuTWOa-ri5Qlkxi0ZocAYLNnINdMinkM81tK5_mT4fKgbcdtjVA380a0
Message-ID: <CAMuHMdX5zSX5URg4vY3Mm8zo9ghE9cTBOMg8ozLZJ2QevF=7uQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: renesas: r9a08g045: Add TSU node
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	niklas.soderlund@ragnatech.se, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Aug 2025 at 15:02, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
> The temperature reported by the TSU can only be read through channel 8 of
> the ADC. Therefore, enable the ADC by default.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

