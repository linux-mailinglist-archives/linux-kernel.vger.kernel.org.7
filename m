Return-Path: <linux-kernel+bounces-832552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AB9B9FA77
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE22E188FBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71827990C;
	Thu, 25 Sep 2025 13:47:08 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEB1FDA9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808027; cv=none; b=MZ57fUZtQDv0VFgSIkRUiVIjHE7Q3+2SJCKGkbQ8R17ibZv8PmnaGFYz5xT+mZqDWZnGypT4PkiV8HMWB6QFGpv22i5uZcUVjp22cdGfRT+ycIcOI8CSq1CE+G28Q3IeQ7zFXfEV0uuMYU7jYEqAi9MZ9ysaj8LUxq1W4DE6bF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808027; c=relaxed/simple;
	bh=76V+ef64wstiWIEawou8zi8nz4mysgrIAL+3ytmcNms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwTmCyir1C+ukgxBdT7pve6agfCVoPvo/AkUl1pJ4yVNVU6IB8GatqZcpx3HdwGseOiDx+pJfPNIXwzitWVIMj/5da2ed8beSwSGdjtC35WPap1OvNSoJIqL2mKW6cJR6e62t7B8YVMHDbBZpx7GYWj0ukvRWPS4jFtKejZj544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso792506241.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808025; x=1759412825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9u5mgXPjjEdl0wf/nsDsPLKxWAZf+E1AY9DpKNlfbM=;
        b=HPg/+2K2CC++J7Vcvc7gElsK4SeyhhCG7FYZhEs5H6S2Ol6y6aSmH2yABOWvRpxj4q
         mCs0wq6ZQCdrI9DGW8TCBSxTqj+g6Wmx2P6cVdWkfwkijf2ZdqyD//L/gG3dZY+n9mGw
         efrm74liicYtGC/aa4hv/uPRZx6o04BxT8CdM5C8sRiOFCARPwnXXoSDuL7SQo1u4oju
         ug46GrEMrdTtlGSw8QYwxvcgJgvpiZiDrJEdtR25mZZ5RV9htPUH+vz7fUT3OsUTH39I
         LMx47dEPcEMawpPAjsLv8FUkjG5iqFyS74pg2PF9kHphU2tu69gciPJJKvZcISu9OFVN
         gBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk7aWNNwtfzOSUBfQZbhqJ2cKdemmt2MpyKWWg9IMR/lkaR7wZ+27A7cy7Xn1DbcEOdwFCMQHPsOChyso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWtaqPsAnMvtSwDINXsEWqWv6bImY8p5JmI5+8DUaq3Ka4dSG
	gBqB7Tr7tcieVdw12KcHEZkXvmvvEIOAV+Ue/oMFYZwHtl5bHQlpWo5la31ET3fG
X-Gm-Gg: ASbGncvVgRJXKJAHPxFoYVTWoMpVWX/iKA+nXHePwHBknscnLdy1ltrHN0J2MPHLfkh
	J2G+SpQxPvtv+eV9oRGvumLlOIQEeCC5NEhhOBgOJ6LCPCh5nwNfHTg9oSyJ8xlYeRsvtXOWWyJ
	i4DsAJZbNffoeoASVTFrNNakMpKBj9v6AoF2D0x4hPvJs/RsJFOdl3Fq86mV10Yic26xCdh/MQw
	YPxVwaxV+BRaWR6Nf5z5XUQ4skbjL2DLdxjUf097YJeEN5vohsA0iOjNI8jux6WEy4/RL8DEPrG
	xeF618GUb7LxJrVBo9+9k9ji3HZCDwrsEwz8JYDeSm1IOSLNaHRvdcHTdC78w9K1hZ5A+QLPkFc
	707aGhvtL/z2LrE9xCEoTzXYTqnIJvKJVAIjWdFvGxSJ/P9+KqmMi3jtWg8+1
X-Google-Smtp-Source: AGHT+IFcWec7LlmR4oOYxgTZnFNjy4Fb/agGCm+FbAo3FqQ9I1DxW79xZDUbdxp3ODbKJhKnB0ftmQ==
X-Received: by 2002:a05:6102:442c:b0:5a3:eb34:6105 with SMTP id ada2fe7eead31-5acd1c8364bmr1483179137.26.1758808024914;
        Thu, 25 Sep 2025 06:47:04 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d878c126sm384767241.11.2025.09.25.06.47.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:47:04 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso792481241.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:47:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8qBGmP1lM6mxAF4LdbbHxYHoAqctB9nz4vwkPV3VP3u/1HFN6rLjibqthe9G+Hdwxc/Q375ana6w97yo=@vger.kernel.org
X-Received: by 2002:a05:6102:3e85:b0:525:9f17:9e55 with SMTP id
 ada2fe7eead31-5acd43506ebmr1559910137.32.1758808023996; Thu, 25 Sep 2025
 06:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXKbPGqAnAcL2kFyF6K3hH9=gr8ECAFVpkgj-OL1mB4eg@mail.gmail.com> <e19b5006-c6b5-4e72-a3bf-42fa6833936a@tuxon.dev>
In-Reply-To: <e19b5006-c6b5-4e72-a3bf-42fa6833936a@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2025 15:46:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOLnLbPNyRm5-=nHBNbVpE6GRkkx36SC1dgnjdOrzLhg@mail.gmail.com>
X-Gm-Features: AS18NWACshqhP7gJRe8a3wvNaNnnr4LUuRpGFp0o_IIumNSTw6shqMump8vYGSc
Message-ID: <CAMuHMdXOLnLbPNyRm5-=nHBNbVpE6GRkkx36SC1dgnjdOrzLhg@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rz-sysc: Populate readable_reg/writeable_reg
 in regmap config
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Wed, 24 Sept 2025 at 17:45, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 9/24/25 16:44, Geert Uytterhoeven wrote:
> > On Mon, 22 Sept 2025 at 09:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Not all system controller registers are accessible from Linux. Accessing
> >> such registers generates synchronous external abort. Populate the
> >> readable_reg and writeable_reg members of the regmap config to inform the
> >> regmap core which registers can be accessed. The list will need to be
> >> updated whenever new system controller functionality is exported through
> >> regmap.
> >>
> >> Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > How can this be triggered?
>
> I found this issue by reading the exported regmap debug file:
>
> cat /sys/kernel/debug/regmap/11020000.system-controller-rz_sysc_regs/registers

Thank you, that was exactly what I was looking for!

> > AFAIU, registers are only accessed as
> > obtained from syscon_regmap_lookup_by_phandle_args(), i.e. based on the
> > register offset stored in the DTB.  If the offset in the DTB is wrong,
> > there is not much we can do ("garbage in, garbage out"), and the DTB
> > should be fixed instead.
> >
> > Is there another way the user can access these non-existing registers?
> > Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

