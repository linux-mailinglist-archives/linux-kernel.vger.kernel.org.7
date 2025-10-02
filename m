Return-Path: <linux-kernel+bounces-840242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94BBB3EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E8116B42B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FF310624;
	Thu,  2 Oct 2025 12:43:02 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623312B94
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408981; cv=none; b=O+07IfPnOB5cSXPGOl7CBOuyVveOOplE//JuQ8ZnIBZI3g1K676bNUNm3jaHYwt+QpYZsgbAA078nwp6eiv7o1Q/lIn11qnHtEEJ95AbbRrRl+kZ4xuyx43TcM5/C2UQcsbiMdmD/AFwNXo6oQ+9OLO4z9jPe6/JgcMXYqX9oYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408981; c=relaxed/simple;
	bh=ldafbVk/EsdGQUuPpGATOo8R9kqzDGSfZbSrwCiLidM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8FyN1dDbUC3XuCi+8sUQd8rCosg0qIvqh99IB3oA/vQOJ4FVe/UQW72yyjjaiOh8KT76dithD8Jc9yd5Id9tzZfWnNah8TC62D9vBjM771305WAq+spUhp3Y6ZBAsFmDnnyF7PmMxUCWa3JY1SSe0HkUMd1FOJ6OIRR5bohpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9231a251c01so392894241.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408979; x=1760013779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGY2VuXcVd4t9vRCqA3KNBgIjrj7zClngJ+L6UFqlI8=;
        b=dHa6cpZRglOzLJNgi298yM60VwUf0WlzRZ5TuKBEtgSGhuSaLBzYW0I34Ndp8ibeLm
         KnjA9ZU83LixCAoSCJSSi5ihsTQADdBYTDS+okwKphdfJkka1jOdpksGcQLPvCFAkmPr
         4T441iAkEmy28JiLDtWX6MqNePZ3Rg6enxIqJiVsJAtKom1rcBXaIWba7smhwIKheACd
         GBTEVysJhgojjGuj2hmZKqT1ykuvNdJIMOtnMe526C7doVARqe/go4Bed9Rt5ZoMRG6+
         KEFn3OSIspNHH4lvsJ9drSru3moteVg8be5nRPWeZCVvXidsvkP+JLYzRxiugwrny1qB
         wm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtoC/QM3j4nXM3FeCeDVp5bZxt7PuJDDRZLYxx6FQJStYbaeSPuBSgUlk4A5MJ30fPzuBGP2fdYu9SgWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaIRSXYfJ6mk56LdBDbrHQKB4zjWoFrGiisjaAI2TPvT2yLJn
	9HM4nN8doUXzb5fVdU+ZgQMCeesdLyde8cdShx9GEpa487A1+LHqIhLIy9fSaTCKDu8=
X-Gm-Gg: ASbGncvWRATdZIl1BJqk/mifcrJFQF9MUNktZkEmFUhTvT3glmtrGtkLwatIVgKYnnj
	QHSb2M6FlxIPoiEoY4AQtt+OW72We9LiyHLM7tCsDj2HYelzg2KQ9/8fV7waxHwYoLCEM9deW7q
	rcPYxR04LNw5KflbsmKXMHO8A0/TvJ+Fjh68zGR4Hm+SJS5b7qP+zgEkFEMubKTAFK6/stsOeSR
	e9LF3ww444b/p5gVwuECLvjFLz9WA+cm5fiJcgFV29RjLHBpj1ZkDd3/3FXf6rPUle8TejZTYTK
	UbNsyeIJBNR8cipkJKJGuSCONxAMjX5nWovazmhlWyPkEUP1wcfTws6HFwNbYE+PCodj2TSgbtL
	YqedfajNWub7hk3nFfkKFZ+Rx9vgg91fjj+Z9vHWdDhdImq0/JIzH2yIa1JQwWpFQtnqnmhrJe4
	ZJhAjDewct
X-Google-Smtp-Source: AGHT+IGxOISS4Ui1BGYR/xKpbokydC6mdfBGruAEH0lCkaNH+B5d9XTB7iezpPuQqZ9UFZ9bFIeGHg==
X-Received: by 2002:a05:6122:658d:b0:544:93b6:a096 with SMTP id 71dfb90a1353d-5522d27a265mr2440226e0c.8.1759408978951;
        Thu, 02 Oct 2025 05:42:58 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf99129sm453585e0c.28.2025.10.02.05.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:42:58 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-55784771e9dso552131137.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:42:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW75F22Gg1cgQ5b1i+QJZ9b6l3QTjM4cuAyFekMR9dmDBieqeTtfoebtH5RtIy+cQL9qLISttGrTwELUFU=@vger.kernel.org
X-Received: by 2002:a05:6102:418b:b0:555:ef1e:49d1 with SMTP id
 ada2fe7eead31-5d3fe6ba0dcmr2875038137.20.1759408978222; Thu, 02 Oct 2025
 05:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002123452.146610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251002123452.146610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:42:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYwaqmmnz946EM_v6pQtYFVtRG5raqAvw2HXWp=wcQSw@mail.gmail.com>
X-Gm-Features: AS18NWCgQZQ0eMLLNpMbDyB3hL-2VfZ9TK7OVaQtlKFCCNmGinudcosDhtA0r-Y
Message-ID: <CAMuHMdXYwaqmmnz946EM_v6pQtYFVtRG5raqAvw2HXWp=wcQSw@mail.gmail.com>
Subject: Re: [PATCH] drm: renesas: rz-du: Drop ARCH_RZG2L dependency
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 14:35, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2L DU driver is now also used on other Renesas SoCs such as
> RZ/V2H(P) and RZ/V2N. Restricting it to ARCH_RZG2L prevents enabling it
> on these newer platforms.
>
> Replace the ARCH_RZG2L dependency with ARCH_RENESAS to allow the driver
> to be built on all relevant Renesas SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

