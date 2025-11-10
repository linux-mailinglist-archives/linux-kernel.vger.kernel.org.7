Return-Path: <linux-kernel+bounces-893124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C8BC46928
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E19188F1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B972FCC0F;
	Mon, 10 Nov 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0sSO3T0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606412DDA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777448; cv=none; b=B6ZL+ccM7mJhlQ8gymNZbcggp9l7Z8H5+XAJHLIBmHysYNhwVdlRams5gjVfdcMVKxNexXdg9nmhi4TKOw9Ox7PmagUzccjwTdCVhzFkWaPDjd2BFrJ43Sf7zQwrXyHgRBrktR+FIvAB0/RDkXQdST3tbfP849UbZ9Fk1VZdTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777448; c=relaxed/simple;
	bh=UlSWQJrlpkrDBhDaT6PIsJwVD+gGRyH7QnWVKBaYcwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFUmZtNIpb73cMzt6NvcFtEl+Rh0WakK3HkibvteKnonpic150OjtnEhw/d3ztAfOhmBK3vuHn4OCbUE9jzQkaKSduxDXfAwOUzGOFupxfsmnO+38t7nEKz1xnGb41e72EC8Nk2PydY2kfHe6yriyyaNwidG3GJ97tQLsGCwQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F0sSO3T0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so4225026a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762777445; x=1763382245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbpCPMECYSOdkwIDkrXH9MSTXkXDhYCijWz5A6ZW0nE=;
        b=F0sSO3T00RtvHaqFdodjh4HFZS6xwjM/5IyqLwHJ4N8FdAlUATW5kdbDC6yxJIQmHD
         Z0ZBDKKTLXM0CgsifYL//KPE/QDm6B4U65Vw/6r+3SjeZ38rVjBIujTRlOtN5Q0hCPU9
         n+8dWK391J56O/DLuHNDjAGiXH7dtix5SHdCvHDeRcMsirceK8ZuI3BQGLOm36pNYFTs
         Hazcoyk44D3+XnUYkwVsGI7RzHDM0SYhY31ouzi5uE2DJG8iTvRyBNLWruQQy/5EHieD
         zb94Iors7eIECUfj/mT8iU40Tsi0/C4YSxqkiBgtUQj0omjFJOIS5csglH/+zbeaRu1w
         Y4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777445; x=1763382245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbpCPMECYSOdkwIDkrXH9MSTXkXDhYCijWz5A6ZW0nE=;
        b=L5B6YK1H2bjnpuPucah+owKGu5f7xqzRhLfuRqjvDraLPG8Ert2Gugpyn9lMOwAL/Y
         BwFORbPYTecj9B4TAOFgF4vktqVvWATuoQIiKWEkfesRIU8L1m/95lGAw0TF0SpacxLn
         YqAFoB/2P5/FW6MpVrRjO8ezNod+8Q7EZwf5ZRi3O9DAUlIStCbx94+7oEHmUhhaw6mO
         62/lkvBuBSdbdzzpGED0xD0TyA0Ko5qamWMvWVGXQ3KuIqoUh4OSw6lVLFCxp/JZ04+I
         2Hv+ROkkJdRtDNK1JB2ymjED3u3N3Yce/G7jM1HbmMlwZgI0Oh6AX4lSAQYbny6R98oA
         0Quw==
X-Forwarded-Encrypted: i=1; AJvYcCVg2WySQhlhkRvzS5wpj//CjUlND4XU3nciYgQilxWsHStmJvzxKHmLt2hb1LAOoCK4nLlAouXoi925K8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zAHuSyBpOOeDjz2m1Oyg1SjISAEyl4S1gDkg9ud2EMrMjlkG
	gOEPjRZp6slL7MfqROZo37urDznGUW17IAbunY3mB72tjL9M93/ThWBE7tH2b8pFttiRkCFrTDY
	LX11fOgfireFLn+TBSrSne7a7gqmg708HoN7DeTulIQ==
X-Gm-Gg: ASbGncvN8SVSsyeDHvlugRHktylcuU3yEW4asv3yIPsgbEd1ASU0DkwRIzmrRxu9bVo
	pew6cUduQ8N0BkqU/zTB/00gUn587dG12vLV8nBSxIzekdkNjmi6ZF7plLqQGor2sGh1soga+Vj
	lGWhx19vTVtaVI6apn/AurDUpCioB7UQ//fIXeVdZ5hGzTyy3pHyT/y6H0kfuds0Tts9K1PiO+W
	KrMbwE/Q1915DoEwl474p0faWjQWOal7Q3Rr9MN4svOjkqJxERxNV+Q3x65Ew7IEDRH6r6y
X-Google-Smtp-Source: AGHT+IFRdpsmY/DI+yHBCvS3rLRDGu7s/al8f5mSyYsgmn3AA8ppozbbxBgl5KfzlXH+PQb5JnuRsAzS0rNdyeMOXbU=
X-Received: by 2002:a05:6402:4392:b0:640:c849:cee3 with SMTP id
 4fb4d7f45d1cf-6415e8283a5mr6971512a12.34.1762777444839; Mon, 10 Nov 2025
 04:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100337.926020-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFr1VJRS2hV4Yyx_sxwSLfc0cpH5-6Bh4iO7PvWeBXoxGA@mail.gmail.com> <a97b8fdd-4c6d-4191-b8c8-2277550a9810@tuxon.dev>
In-Reply-To: <a97b8fdd-4c6d-4191-b8c8-2277550a9810@tuxon.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Nov 2025 13:23:27 +0100
X-Gm-Features: AWmQ_blUJ0REBAdCUvnjXc6932GgZ2Gj6rccLeQhi6S6zzM0mDdzGuLpVG1DXKw
Message-ID: <CAPDyKFq3TSsa9co2gcJOfR1YB+z3172ghejMLAvfmE9j6bb0gg@mail.gmail.com>
Subject: Re: [PATCH] amba: bus: Drop dev_pm_domain_detach() call
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux@armlinux.org.uk, chentao@kylinos.cn, 
	claudiu.beznea.uj@bp.renesas.com, rmk+kernel@armlinux.org.uk, 
	lpieralisi@kernel.org, robin.murphy@arm.com, rafael@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 15:04, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Ulf,
>
> On 8/27/25 14:35, Ulf Hansson wrote:
> > On Wed, 27 Aug 2025 at 12:03, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Starting with commit f99508074e78 ("PM: domains: Detach on
> >> device_unbind_cleanup()"), there is no longer a need to call
> >> dev_pm_domain_detach() in the bus remove function. The
> >> device_unbind_cleanup() function now handles this to avoid
> >> invoking devres cleanup handlers while the PM domain is
> >> powered off, which could otherwise lead to failures as
> >> described in the above-mentioned commit.
> >>
> >> Drop the explicit dev_pm_domain_detach() call and rely instead
> >> on the flags passed to dev_pm_domain_attach() to power off the
> >> domain.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > If it helps, let me know if you want me to pick this up via my pmdomain tree.
>
> This wasn't picked up so far. Could you please take it through your tree if
> everything looks good?
>
> Thank you,
> Claudiu

Okay, I have picked this up via my pmdomain tree and queued it for
v6.19 on my next branch.

If anyone has objections, please let me know.

Kind regards
Uffe


> >
> > Kind regards
> > Uffe
> >
> >
> >> ---
> >>  drivers/amba/bus.c | 9 +++------
> >>  1 file changed, 3 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >> index 74e34a07ef72..952c45ca6e48 100644
> >> --- a/drivers/amba/bus.c
> >> +++ b/drivers/amba/bus.c
> >> @@ -291,15 +291,14 @@ static int amba_probe(struct device *dev)
> >>                 if (ret < 0)
> >>                         break;
> >>
> >> -               ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> >> +               ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> >> +                                               PD_FLAG_DETACH_POWER_OFF);
> >>                 if (ret)
> >>                         break;
> >>
> >>                 ret = amba_get_enable_pclk(pcdev);
> >> -               if (ret) {
> >> -                       dev_pm_domain_detach(dev, true);
> >> +               if (ret)
> >>                         break;
> >> -               }
> >>
> >>                 pm_runtime_get_noresume(dev);
> >>                 pm_runtime_set_active(dev);
> >> @@ -314,7 +313,6 @@ static int amba_probe(struct device *dev)
> >>                 pm_runtime_put_noidle(dev);
> >>
> >>                 amba_put_disable_pclk(pcdev);
> >> -               dev_pm_domain_detach(dev, true);
> >>         } while (0);
> >>
> >>         return ret;
> >> @@ -336,7 +334,6 @@ static void amba_remove(struct device *dev)
> >>         pm_runtime_put_noidle(dev);
> >>
> >>         amba_put_disable_pclk(pcdev);
> >> -       dev_pm_domain_detach(dev, true);
> >>  }
> >>
> >>  static void amba_shutdown(struct device *dev)
> >> --
> >> 2.43.0
> >>
> >
> >
>

