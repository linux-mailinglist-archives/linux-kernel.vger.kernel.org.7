Return-Path: <linux-kernel+bounces-811482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3709EB529B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E0B1B27675
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33C266EEA;
	Thu, 11 Sep 2025 07:18:46 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602C4409
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575125; cv=none; b=WA/8DCZrHgTIHDI8OGu4j6UNJ6u91rw2BJka/XttHMtYJDW5Ju/9L9CTUndI99vt1IFUeMUr1rwr1tVUUMLq+XiAO+WA92oMma3M7EwlRffE+s1wEAzCW8xAqIuOvSrqK1vBDUNZf3Ho72jtDDFnMmCSw7lVwDCULI13pSj4FfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575125; c=relaxed/simple;
	bh=BUelSzWkvex/VFMHwxFi0FJy3ipU5VpPMti+oBm/JKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHcVqsn2+B6yl6KOHjphlUaO60cidC28af3k0QqMWq7YsHXfa6cBW3wTlbXA/rQIh2Am5CfhSbQ76XmoocOT+XB8d/yhLE8b6JPRWjdPcmNmKtrUM5WOuD9yt8TpN1nOs9Ux+idgaErOOhYnClXZDFwFQIfU+b4zilqPQnTlWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-890190c7912so124213241.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575123; x=1758179923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xz8T3amYkNV7rSzjipUYMhb6u7hBtXfStQbJ8Sahd0=;
        b=ndEVNKjaJQJxMhlJzsxK0VCQJxyrFjc5BuYzaRiXX2wqUEQIJ/ZiWg7S949sCqWyIk
         syZ0tvf67QF04ZevPhcKEYzi48QKUPpbia3KawHVCl1xYpxPhHHpj00G+W3fgw3g2WI8
         RPYdGpzC17eFKCp+fIbYvZ6XtmZUUWSdXhKHSREozOzMxdvy2sQsLFAnBw51cXHE/Crc
         CHbGZavbjuHERvgR01vku+VSlXpbn9JmHL/WH6vHzQ9nwZZc+dyuBEchNNTccjn3gx7X
         OeZQ9QzeuMLhwqZjhKla7MNr9EBY5H7D5cg+WIZ22CikfnX8k7jpo7yOM3IIYiShAdbi
         CsbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWK8QCYoDjxAH4u0RqfCcL7PgEVzrgyhe/VVV1C1Nr0Oc7qxSeV8ULIK59+0REUH1plXFVHRyPC5LoqYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOIGSi0tsgZGdBDcgBJf43406IriJF+LwRfDnLdH5/0P+vK4A
	ekVeXzNWPyEUYZeaD6Nl//5mwfcZhnitsYMD9tnvc3rx8Ana1ExoOPRhsmhVr3xp
X-Gm-Gg: ASbGncvAnv24XqvlP73ykznEc3sO1Rc0ctUqHtwIXFjhmf6B4+/t/ynrHVrgb0BTOp8
	0Cq3ZBelOrYVJ63VHhPiN2hIQztTBaCsAb8252K7xc4a6+N+x0UWqQfbr5Q/Mb7dj/u6IcoGxXh
	HibgCsXNk1KcXFdIssdA9CtEZ9sO6Cl6P/PEGWdl71iONIjLxYGJ5nU7dk5rT8DkV7l8sOfV1l1
	dd/wSaqNhbLEfaIa7HDZPbiEPWB8RWPl8jgBtM2D4P9hm3g4SptSfM96qqY1aI/9/gALQTwoKNb
	wyb6J014g4UaQ+80Zkl4hcjaRnyCYdHuTQlJqfJDISssb/AtPNFKEN7tJ/YKHTC6SS2CFKCgPNf
	0ks7oJoH4TIS485v3BjDv4nHd0QFcii/Ak1Bkypg7GN8PZO+h2X/ysTuYKRyNq0GZvSRlF+Y=
X-Google-Smtp-Source: AGHT+IFk/08j6/yLxdil6/dCCUg5PUwYIlvJ5QJ4ORrWeGK2qEVeG5prtmTUBdXPlV6SZHzkGNqW0w==
X-Received: by 2002:a05:6122:6599:b0:544:9414:105f with SMTP id 71dfb90a1353d-5473a3c5cb4mr5262464e0c.2.1757575122952;
        Thu, 11 Sep 2025 00:18:42 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d40b6e6sm130428e0c.23.2025.09.11.00.18.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:18:42 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-52e6037a484so80814137.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:18:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtdOYBTP/3B1AWzscFp6nEhVtb+jYKJ+heqQWwmena+EdSQtApc7cbDALyZJD5b3idKn1zL+IufEMgDzE=@vger.kernel.org
X-Received: by 2002:a05:6102:54a9:b0:521:760c:7aa8 with SMTP id
 ada2fe7eead31-53d14d8c892mr5750708137.27.1757575122627; Thu, 11 Sep 2025
 00:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org>
In-Reply-To: <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:18:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
X-Gm-Features: AS18NWAQShHnTB-pHMrvSyt-wwqsfojP53wsm5mwBKc4qvyVjVjagRnbLu_77lI
Message-ID: <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Saravana Kannan <saravanak@google.com>, 
	linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Diederik,

On Wed, 10 Sept 2025 at 21:33, Diederik de Haas <didi.debian@cknow.org> wrote:
> On Tue Sep 9, 2025 at 1:11 PM CEST, Ulf Hansson wrote:
> > Recent changes to genpd prevents those PM domains being powered-on during
> > initialization from being powered-off during the boot sequence. Based upon
> > whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
> > on the sync_state mechanism or the genpd_power_off_unused() (which is a
> > late_initcall_sync), to understand when it's okay to allow these PM domains
> > to be powered-off.
> >
> > This new behaviour in genpd has lead to problems on different platforms [1].
> >
> > In this series, I am therefore suggesting to restore the behavior of
> > genpd_power_off_unused() along with introducing a new genpd config flag,
> > GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the new
> > behaviour.
>
> Is it expected that I'm still seeing this on a Rock64 (rk3328), just
> like before [1]?
>
>   [   17.124202] rockchip-pm-domain ff100000.syscon:power-controller: sync_state() pending due to ff300000.gpu
>   [   17.129799] rockchip-pm-domain ff100000.syscon:power-controller: sync_state() pending due to ff350000.video-codec
>   [   17.140003] rockchip-pm-domain ff100000.syscon:power-controller: sync_state() pending due to ff360000.video-codec

Yes, as the sync state is still blocked on them.
Disabling unused PM Domains is done independently of sync state.

> This is with a 6.17-rc5 kernel with this patch set applied.
> And it also has this patch from Christian Hewitt added, now in v3:
> https://lore.kernel.org/linux-rockchip/20250906120810.1833016-1-christianshewitt@gmail.com/
>
> When I boot into a 6.17-rc5 kernel without any patches applied, I do get
> the 2 for ff350000.video-codec and ff360000.video-codec, but not the
> ff300000.gpu one.
>
> Interestingly:
> ff300000.gpu -> power-domains = <&power RK3328_PD_GPU>;
> ff350000.video-codec -> power-domains = <&power RK3328_PD_VPU>;
> ff360000.video-codec -> power-domains = <&power RK3328_PD_VIDEO>;
>
> I would be surprised if that was a coincidence.

Fw_devlinks ignores the index cell (RK3328_PD_*), hence all links are
created pointing to the pmdomain controller (in case it has a platform
driver) or the first pmdomain (in case it has not). thus blocking the
sync state call and power-down for _all_ pmdomains managed by the
controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

