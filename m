Return-Path: <linux-kernel+bounces-773141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20297B29BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F058319600AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB42FE07B;
	Mon, 18 Aug 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqahz7Ey"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37729E0FD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505019; cv=none; b=ItKO6WBsj16cVHumBRsmN/jmbIfpkFdb0mZu/MZjWKkzGaD756r7CY0ozC7mw6PT7XFPtDt3rcPJ0vbt3kUASSypRelABYzJl1fymPO6TSz9QpzMvSVQ2df1AU1Mc8YqpU2/vgHuhs7wlqwRSO0jTh0FjI3GktasPOA3C+pUnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505019; c=relaxed/simple;
	bh=5uGYffxze0LsLFW1PAJ0UDWBU63YtOXf0sU136G2Zlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1QLDhXPkuA5/eJ0w9c6/RMBj1jR6fQutN+byZfgOmWTyqQXELsdGJzKUYoFoL6EHMTk5owzD+r+OU6v46wx13daMOKYpZ7rktLH0Dwm90pOBEK846XYOmg/pcKpm7eGCJZwfQ8Fh4NMym2r7ig8/nWRWUsiHEXYCNN5fmjfQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqahz7Ey; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e9321ed5e5eso2551420276.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755505016; x=1756109816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FJufQOJF4TmIt6/Zdrs4prOHMHASIL6SknBdnGjg4M=;
        b=hqahz7EyHx3FzyNB+1GuxB96xTt8/4uQMOfrja+bwrZyHkZQnPfgHP7u3s2P9VHdc8
         6zrEf9zV3UIn9L+cPWG3IdsSsWMputqnuqvuozc+tJR8XhnY0YD2yXPMsImRjJ9HJX+R
         4VRdpR1TmCIg+d5ODCNN0ZpIUhjw6lZV6B41IH4fNi0++mRFw6IYmU+LZmoB8m04m4pn
         Z4+gkSIG4fsLSvk9P0KsfWeYEpq79WogOqARK+cy758s38mMe+TUWJsHLAFDfe+MftW1
         WM4U7NoPUoR8vfissl8Ns7fOubkcEZAwd11x5S/w/3a4Wls8MLng3ApAPgqbVv+EW04y
         v2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505016; x=1756109816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FJufQOJF4TmIt6/Zdrs4prOHMHASIL6SknBdnGjg4M=;
        b=nHj/dx/AAVHrAZoJjlhrct/vMe1JlSfysed4+zz9LABib5hPif2wfSiNnTvvG2xcnH
         i8epgBUYLRVNDc1fGI2xfxFxgOFP5qSVhvPsuCwf0aBJ2UZwqMe9fG+jLQAMjmRt1h5f
         pUZGnkfsgEUfC2E3Op4xT1QJPUJRrOP9VVK56xbk8PunabOogsNkzoP+mguuXFREvGNs
         BsUf1dTiMvUx/JaplV/5C1/cfWj5ludKG9jXTUiTIsWBpXAAACdW6nwENzFy7Y+WwGrt
         PT0bejc896xoOXNKHPQU0TzxRjumdIxrwPRb3tEo9LBsR0ldg6+oitD6VhTA+GJylBSu
         ftzA==
X-Forwarded-Encrypted: i=1; AJvYcCXtf7JQkEThNdENR4esYOTTUvSabMeTAc84b7QaNx9mF/A9omZdO+1+yfJ8SAxGJDRw1x8yhgN+gAsiu6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANXc0we+gSM3J8YZbAh/Wpv6hamDzyWZhkDKjPM1lPfpV5QvC
	AiHbXfxa7VwyLuGacO8/QlHpdJeXH19GKhd6RzTAu16+Aw0NL9bojYuFFqNeR4K/wHw7f2+Sfew
	omHHoYyyzvt1HBqJNmBk2yteeWZdvkkU=
X-Gm-Gg: ASbGnctqSl53Yin3LiAVOEPEq9C/29JVKyldyYEEGB9Bjq48OTe63MhJ7mF9hn6pUoL
	glKQWQfUc/jjrTCRYaJglY/B8HQrJkczyZVZ8hsK2b00WkPVh+xAgottFp+DEBwKOP/NQGc4wQx
	jTwsFj8XmxLWD8dnNsKas3c9+tbMwtyg/9s6wlPUIGYQY5GIwr8YqNWPxbEsgU1t9lhL1oyQ4km
	SNnh04=
X-Google-Smtp-Source: AGHT+IFPcHQVWfKGMJtByElKMvMsTEEOC60V8eGIs+IN3Mqvl7S3NqFsn8NQE0Rw4SPmw+6pg47iVNhTm9HDrbyDIGo=
X-Received: by 2002:a05:6902:1549:b0:e90:6a88:eaad with SMTP id
 3f1490d57ef6-e93324ab732mr13484382276.24.1755505016343; Mon, 18 Aug 2025
 01:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082510.32291-1-yaozhenguo@jd.com> <20250817191825.ef254428d688d987333d4f4e@linux-foundation.org>
In-Reply-To: <20250817191825.ef254428d688d987333d4f4e@linux-foundation.org>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Mon, 18 Aug 2025 16:16:41 +0800
X-Gm-Features: Ac12FXxtPxSsj7MREEtj_NX-AYT5YFrlCPg3B4xhjwvr-tYciJ1Bozi69Zqv4dQ
Message-ID: <CA+WzARmV27Oo82zhZpmrbtBOG+e6UMVcCUa9ShcyCW6YEGK5jg@mail.gmail.com>
Subject: Re: [PATCH] watchdog/softlockup:Fix incorrect CPU utilization output
 during softlockup
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tglx@linutronix.de, yaoma@linux.alibaba.com, max.kellermann@ionos.com, 
	lihuafei1@huawei.com, yaozhenguo@jd.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=881=
8=E6=97=A5=E5=91=A8=E4=B8=80 10:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 12 Aug 2025 16:25:10 +0800 yaozhenguo <yaozhenguo1@gmail.com> wro=
te:
>
> > From: ZhenguoYao <yaozhenguo1@gmail.com>
> >
> > Since we use 16-bit precision, the raw data will undergo
> > integer division, which may sometimes result in data loss.
> > This can lead to slightly inaccurate CPU utilization calculations.
> > Under normal circumstances, this isn=E2=80=99t an issue.  However,
> > when CPU utilization reaches 100%, the calculated result might
> > exceed 100%.  For example, with raw data like the following:
> >
> > sample_period 400000134 new_stat 83648414036 old_stat 83247417494
> >
> > sample_period=3D400000134/2^24=3D23
> > new_stat=3D83648414036/2^24=3D4985
> > old_stat=3D83247417494/2^24=3D4961
> > util=3D105%
> >
> > Below log will output=EF=BC=9A
> >
> > CPU#3 Utilization every 0s during lockup:
> >     #1:   0% system,          0% softirq,   105% hardirq,     0% idle
> >     #2:   0% system,          0% softirq,   105% hardirq,     0% idle
> >     #3:   0% system,          0% softirq,   100% hardirq,     0% idle
> >     #4:   0% system,          0% softirq,   105% hardirq,     0% idle
> >     #5:   0% system,          0% softirq,   105% hardirq,     0% idle
> >
> > To avoid confusion, we enforce a 100% display cap when
> > calculations exceed this threshold.
> >
> > ...
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -444,6 +444,13 @@ static void update_cpustat(void)
> >               old_stat =3D __this_cpu_read(cpustat_old[i]);
> >               new_stat =3D get_16bit_precision(cpustat[tracked_stats[i]=
]);
> >               util =3D DIV_ROUND_UP(100 * (new_stat - old_stat), sample=
_period_16);
> > +             /* Since we use 16-bit precision, the raw data will under=
go
>
>                 /*
>                  * Since ...
>
> please.
>
> > +              * integer division, which may sometimes result in data l=
oss,
> > +              * and then result might exceed 100%. To avoid confusion,
> > +              * we enforce a 100% display cap when calculations exceed=
 this threshold.
> > +              */
> > +             if (util > 100)
> > +                     util =3D 100;
> >               __this_cpu_write(cpustat_util[tail][i], util);
> >               __this_cpu_write(cpustat_old[i], new_stat);
> >       }
>
> Can we do something to make this output more accurate?  For example,
>
>         return (data_ns + (1 << 23)) >> 24LL;
>
> would round to the nearest multiple of 16.8ms?
>
>
Yes.

