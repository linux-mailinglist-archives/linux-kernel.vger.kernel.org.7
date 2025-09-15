Return-Path: <linux-kernel+bounces-816309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271BB57212
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9793B281D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590272E9EB9;
	Mon, 15 Sep 2025 07:58:59 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77342C0F72
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923139; cv=none; b=QjBUoL394w/hku7RXXTq40Qhg+60IYb4cYjAGZS2LTLRiGn3L4uhuhWuW/+eLw9WA3ttyk9hJ/rNAhQvTUdByI7RyV2YuXsMizlPoHER4tozX2EPVZdQKMeI9+AAtBD1uJc9MuMsGZoR7ZnQg/1EPr8Q6IaWfJBroZSGdiGVg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923139; c=relaxed/simple;
	bh=Sqn/ZgxgCNgAXSMJCtC7zdfFksm2UGuPqP4avjgv+jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFNF66TcnpShgQip3fbShbrJ4/d0E25u0WxDzWLmmh6I7sj+VNR2KAyYXg7sb4Hy5pCplQgM8I38lMTJvnE3TQayM2dZ82/rLoJZ6qWRCrCs4ebpdnTINZcxwz/vZEI49e/cm43cODRyzXyVrzv/n4H+z+MWB+XE+yU2HTzevqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5300b29615cso3447601137.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923136; x=1758527936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdEbGsEznj/+fcW4LYAFT5Nf2skbq2ng99E8wh/Fflw=;
        b=sxMNJGZ3dKKUj1S/RRl1RtYEqMNU0utuix9EYDH9EGMAodQw/VWAvNBbW2lFB4rRdl
         8jAVPy2Rhh0g/+UW5lPegIMZbNO4AvqnYkotlSG9iOvLmwmz6+wlpC97bmiVDoar/NVF
         o7D3F7FqMThNYeg/yk+MBgCw0BZX7z6r7ufDX+FQ/NwAuuyjP7xOZF189BzjY5FUZvG/
         +iKXcV1M2pOHC+Sz3Id+QXYfK1+nuSEeLi1kapHQLJGGifaho09jPcjdBhlj6yaYQiH/
         6zs6Xe0ntBZu5eWC4ugFPWKjsXJ/qhNrK8MbH3b7U0IonyvEhata1vwXsLYzELgv2G0P
         wNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKz2m9cd02ZaCewBNFDcbJkR2yPmQ9Rfbh+L2fckXZHowLu0tCvS8gnZGiZUIEAhSYFGg1bVMnttaIxA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyugmnf6US9mPo5fQPocfN0WysoKP+MErZcWVZsXFoVZOdfRU31
	g3+djrmgh3mMWpkl41krO/wVHTI5V091jp5L8qmPyv1n6Dh2fgVI6a4H0aPIS7Ie
X-Gm-Gg: ASbGncvJvRg2udnAc9WaP2jh822LDRSEOziSzDrwztX7FiHbOZA30CM0UmOE+QHV/VS
	gGFAx+aL124Htfb+WVd6HlGhDXPtWjDQhjEWYPfDl9PlKhVHWjV6JN52+iuIbNxnaAsz/uDlmUE
	i9bEN9DFTuPzncZncA+yacdcizg+P9ln5GwehJsI3romeKjUw/zFs5zEqp4I20fABOLk5pqzdDs
	kI6t2c/xVDrQX4zDVKYzi4R3rIT385iwNsHq/CbjOAj7O4YzZT+5LKPl0Q4+kWlbx2hPMrU1scV
	O4jgtUCliIqoq/wAGYOUu6zgar3wmwNy5xwL8qMxDTUlwQ4eGcII1clqKeUPlv5i4Lhw7/KWsDN
	aiKWmD/S7MDYA1OxcpcIlZBnqfbjVQuQsFgirY7oRcXNmJ/+zOUJGCd7bM7lc
X-Google-Smtp-Source: AGHT+IGO5ODNLahUuh0aoaRDjj/NjkphZQtiinD0d7gANs1bHvVB4EZPh0p3/EN8xr5r7CCwhLVGVw==
X-Received: by 2002:a05:6102:424e:b0:537:f1db:768d with SMTP id ada2fe7eead31-55611298a66mr4276380137.28.1757923135815;
        Mon, 15 Sep 2025 00:58:55 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccd3bd595csm2212580241.10.2025.09.15.00.58.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:58:55 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-53042807be7so2740627137.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:58:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF5pPWneI4fczoQCoDHP/LdjkLFEb5EAS1X9aRWXp+2d1+AFmFosIcfawmACXIc6JK8Vgw0jcxRHWJT24=@vger.kernel.org
X-Received: by 2002:a05:6102:808f:b0:4fb:ebe1:7db1 with SMTP id
 ada2fe7eead31-5560bb47790mr4450426137.12.1757923135481; Mon, 15 Sep 2025
 00:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912130911.185674-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250912130911.185674-1-tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 09:58:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKu3X1tihsa-ouuoSpOaAhuKB-fOZMo8_CSN4fROeLmw@mail.gmail.com>
X-Gm-Features: AS18NWDKwSEGTsUnPuKBqop6XzqwZT8QTZhdu8_6I5VGZEgrXV10p4SrcksRn8s
Message-ID: <CAMuHMdWKu3X1tihsa-ouuoSpOaAhuKB-fOZMo8_CSN4fROeLmw@mail.gmail.com>
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: Remove extra semicolon in rcar_gen3_phy_usb2_remove()
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 15:09, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Remove an extraneous semicolon after the closing brace of
> rcar_gen3_phy_usb2_remove().
> This has no functional impact, but cleans up the code style.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

