Return-Path: <linux-kernel+bounces-811855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A610B52EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5FAA840F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5530F812;
	Thu, 11 Sep 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPbD/j+G"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0C3112DB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586746; cv=none; b=rDZfzamPIKBsVdthuXWalReRNKkuHnvlB/GOcW9ZHbH2BGIRo3tbxoSPKEIqYMO20R99q05Oq7tdlIkkQqFI04eVykvCoYPTovUpiwW+leJdfhDbefUFIn1VMjckpavbVLGmdxvjLK91gmb0Qo/KxOhFCaCXKdewJMQetutFVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586746; c=relaxed/simple;
	bh=AfzBOkfw/f+2HpXW9nRIV2Am+WTp1lRBGmzAonEDKng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euPF2HfZqj5iaDSgv/vG7Wx65uXb+kZCbz9W/dq1mzpFLwzXwyYaCltNWeDKuGYUr8OX7PxRndUgqrDlZujvdzPisN8Ocu9sQCvKgASpPFyjXb1KBV+if+NVqzzDxQ0pcdFVEP59NmNWDl/Io7m+LGZYrlrqdlx6tylD+nHU+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sPbD/j+G; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea3c9376d90so500413276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757586743; x=1758191543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4ZOsSgcttRMvxWFSgVRWx9LXQHTbGG8yJSj2/0idLs=;
        b=sPbD/j+GrXua7SyQ7s/2a1wNSlaLGwJNK+AI6A65uVSFOMOcy/wfCBh86QkKIRo4p+
         f4ONOMHKEVHSHl85WBJOkqmEegYJXNCkdaod5nkX0OxKQysCmO3HafpeUzZSLYrPDXDm
         NE4YZwpghcd4+/1Q60oLxfYne/xgGnfCvWup/+ivYvg7ZI45HBlbHHSYmWxyLY2ARGBw
         qZvnrCeEywXqGnCmG+EySkdSwhs0ZijdO3r/yQlAdHydtpq64/EKw0cnicAwLl04j/PC
         ygeKv3MTvTyyktGHnUl6YfsAB3zjt6DZ2sBCrMbhlY4emPGSSnRIzyUrs4wON9ali+4v
         LqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586743; x=1758191543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4ZOsSgcttRMvxWFSgVRWx9LXQHTbGG8yJSj2/0idLs=;
        b=WrEfVwktbSgHnG0DcSy9AYe8lUB+rUMxmRkVagCJV57qv0Qn0XEGiFsyfXCwMCqjb1
         Av0hNXf/BtZbWeGWDRa2eVlbUii3fAGZglwXt5K6uBCX+ukYWQXXTnKp06CUTDz/O8PC
         GJP2uERNf24gTWoDYu6ukMzX1uHUa950CyMPCSjt+dhv4ELqu/BV8XiVrRNf/UsNyuxT
         EuIrxenCZmNpeM3mmeclfyd4KW+EGA5GHUge701wNl/lA/KhMVQGFGChTHcTkl86qlxA
         THdRn3jsh4iBUDuZsyg0NgZL/BVrCHDLbjZEGYj3S2T8TceAgFNBErSiaoNSZhsDq6rj
         aBiA==
X-Forwarded-Encrypted: i=1; AJvYcCX98U0+NFLAtYZ3AXgIKxdIZT0ljakVfCWdS/dV5PwLLOxlDTuOcLhdjsBtCMD5uDqmLSMSU/tXz/GKwUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4pPbfLa9GjvZsy4lu7nrkOdgB5xCAj6im0YMKlnUXvfcCC5g
	tygU9bs1kv2IszNYLHqlrfCSB6D69FlvLuIe8kXTS2JU14jFNbM3xMEBT9Iy06HsUbzjjhS93aS
	xOZs8QF8I0zCdLepAyh1mO7ieamoI04TpIJW9QwIU2w==
X-Gm-Gg: ASbGncssZIK5LSJZ/iCoPJsxB6jXUp9/XL8HbjvEpKmkuO3XF8QcB7EPDPFFe7NPnQN
	KOrV4Y0jtztoMGjxNOg9/ZHjmeq2QKhhdPAjDRNUL90WElCSnK/6g2O7kmxhIRnLJv35asTe2xH
	MOkI4uEV5d7Kzy1/jrthvk19Im3HDRKyRt+PODDH53ILU/cJB0M+YB/GeCuYaxMqcgiEDNveHL8
	FYeRN4ChrSx6ri4VjU=
X-Google-Smtp-Source: AGHT+IF6/FMvfkM2t/XH6c5AXnqivQugM2HMLBN1/u9XexbnBojnOfBcCiOm0kb7ITvQxJ9JRgM1J9hGYF+YRqPfZm4=
X-Received: by 2002:a25:ab45:0:b0:e97:398:43a with SMTP id 3f1490d57ef6-ea3ca7088f6mr1978662276.19.1757586743140;
 Thu, 11 Sep 2025 03:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
 <20250909111130.132976-4-ulf.hansson@linaro.org> <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 12:31:47 +0200
X-Gm-Features: Ac12FXx4q_7O4EKT7jwetBM883Ai-tYxqwF2ULDV_qJob3VYY3KUktShD0zBpHM
Message-ID: <CAPDyKFrZ4hA0O3PRUJwwetQYsgAt50tPo_hL90epUx1T8kFDEQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM
 domains powered-on
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 11:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The recent changes to genpd makes a genpd OF provider that is powered-on at
> > initialization to stay powered-on, until the ->sync_state() callback is
> > invoked for it.
> >
> > This may not happen at all, if we wait for a consumer device to be probed,
> > leading to wasting energy. There are ways to enforce the ->sync_state()
> > callback to be invoked, through sysfs or via the probe-defer-timeout, but
> > none of them in its current form are a good fit for rcar-sysc PM domains.
> >
> > Let's therefore opt-out from this behaviour of genpd for now, by using the
> > GENPD_FLAG_NO_STAY_ON.
> >
> > Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> > Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> > --- a/drivers/pmdomain/renesas/rcar-sysc.c
> > +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> > @@ -241,6 +241,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
> >                 }
> >         }
> >
> > +       genpd->flags |= GENPD_FLAG_NO_STAY_ON;
>
> So this applies to all PM Domains.  While this doesn't hurt, perhaps it
> should not be set for always-on domains, and thus moved up, to become
> an "else" branch in the "if/else if/..."-logic handling always-on
> domains at the top of the function?
>
> This applies to rar-gen4-sysc.c, too.

You have a point, but currently this doesn't really matter. Genpd will
not power-off always-on-domains no matter whether
GENPD_FLAG_NO_STAY_ON is set or not.

The whole purpose from my side was to restore the behaviour we had
before, for the Reneas PM domains. I tend to think that it's better to
apply the $subject patch as is - and leave improvements to be made on
top.

Thanks a lot for testing and reviewing!

[...]

Kind regards
Uffe

