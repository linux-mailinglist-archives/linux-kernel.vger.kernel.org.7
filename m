Return-Path: <linux-kernel+bounces-836246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6637BA9168
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8FB19204A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396C301714;
	Mon, 29 Sep 2025 11:43:35 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B93016EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146215; cv=none; b=UGlDLcp5RPFJqzmYq/TJxboIhF2nQwjtns7dACE0G4WqLY6+dc6obi/RE+ngI76pKwP43xLbFYwP23IOyw2Z3/vdej/TIG7amb7y/MnMM0FpeAanYCTceH0QDRRgF3PchFFOeVP2JKuH+GHlfdZqdRAOBg1c8WiixbB+OgtqJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146215; c=relaxed/simple;
	bh=rQxIntxCaMjAl4ZMKvmJmWmfz83LZmlH0mwttLjRCPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQxNPE/WaiESOIYJHKUiT81Ds9sDka1t95olZmk3qdTzscutm1asDMsDHwP5AthoNKoAfKLJsuPJUn2eTl0qAIbsP9UK2twMPMRQCK9ahdK2Zi6hcZtI/tuxNo1iLVYHU6MjNX4ClI5ywLSZsnKxkonQDAiHoagOcv/b/X0QB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-84dcf6f28e0so476503385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146213; x=1759751013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+DvsJXG0G61gRFxkleWdib9RoQxt94Uw42byP7fd3k=;
        b=hhywPQBbTeK4skvYJJ2TRft3THslaHpkoLFWEGXBi5T/IH5YcsAJBZomb3ZlCp+nqn
         VfFKUp5gmzv01OZ2RZGaU8aGKNCSnylFuDs+1Nwx5IKqJci3qO7v5iwxCPuMOu0ki2JP
         CKPS0xmF3OdmcZQ88u7fFg048TsF8QaPEHADOO2786jjp1AEz2dL5rGlzmrP5KzT0+pD
         VB/xcim8NkWL0nt0p+M+F+JiMrnntvzMlZ2PBDw3epGsFgDIQJQHrNrDiWGJlO0rfHDB
         /xq0D59KdRqLcgqpY72LcB/ma6Q/mlVMkeaiW304sB/1Y9ttL2t+0pYVv1eKi7J1Kg2R
         RiRg==
X-Forwarded-Encrypted: i=1; AJvYcCUiv+ko4sLxJMf1mWjuo5yBgdb2eXURiyaKw2wAgGluxXbLh0nAUr4Xx6G83H/ez4Uoa2FqeWck8K5szyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+khdA0Ly0m1q0Xqc4/bmwroypk5SnnBDy/kbqf37Z9V9YXV1L
	ERXaucwL+P48FswO+l153xZWNU7LozX1UFsRShss0lVnh09Rn/Hrm5efjJq246qX
X-Gm-Gg: ASbGncu1hdSTwVtk5VN02TOc2oC2G1U2lgk6uK2Qsm6DV7KoGjeEYzsDUGkP/cGmgtW
	fjMVY58mvcPTtVCzf9SeLkvEaIghnbqgMzszZNUh4RbAF8PZYzO+lSsrTItqxT8Ucmu6/lHYgND
	/6+umVCrpx1FtbpmDnkh/p0ZLBTk/V4TGZBT5XxVfPLGTW3lRf2nS7zaqpsqQI1BxLrSqsHI1YP
	irCceVYWSUHnuGDSFnv+Bk/r3tc+jI7/L9EOMiXSV/zUIn+gxRDALSGFCRLtKP0sdEc9+Bl+qBc
	dlagKsqBRRKYCIypK8bSdy+4NmdWZozgKfxZwx4Lt474GVLJKT+TsIDDVTq5v/iXcfxacQy42Xa
	+61Y1CiS7lazPoqEycUwEWTIkTDx6QXm1CEbiiGxuJ5utEm7S4zOV2iIASW/415piOO2Wlo9iJo
	E=
X-Google-Smtp-Source: AGHT+IEJoQ7KA6jltWLUomhtlPmt9sslOmDW/b/4pQ7w1NouCnEejbuoc9hxk+Y4JC/Tw64p9WLIdA==
X-Received: by 2002:a05:620a:4611:b0:83c:f9f:73a6 with SMTP id af79cd13be357-85ae26a58ffmr1972009085a.35.1759146212708;
        Mon, 29 Sep 2025 04:43:32 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4dfec096b98sm34431181cf.46.2025.09.29.04.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:43:32 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4de1b5a6b7fso26571351cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhe5jCAhsj4bwEakOiqof0/NtaECJJ8xY27G40pD88M+wTcVSRUpg+Y/YI3wutyXrh8sg3p9Zfo8q0hGE=@vger.kernel.org
X-Received: by 2002:a05:6102:32cf:b0:519:f3b6:a1ae with SMTP id
 ada2fe7eead31-5acd10ea445mr6745656137.22.1759145900183; Mon, 29 Sep 2025
 04:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com> <20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:38:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhgGGYAYnR1cgWVtFCdHEQZWmfx_KY3Z3keDHxTp_drA@mail.gmail.com>
X-Gm-Features: AS18NWDeDP8x0wSmUHzwgi3zdRuByvOv6E-OXpBdrFgnvBXmf6gvI4PDDQHxKx0
Message-ID: <CAMuHMdXhgGGYAYnR1cgWVtFCdHEQZWmfx_KY3Z3keDHxTp_drA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: defconfig: Enable RZ/G3S thermal
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	niklas.soderlund@ragnatech.se, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Aug 2025 at 15:03, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.
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

