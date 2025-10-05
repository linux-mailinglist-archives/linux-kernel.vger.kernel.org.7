Return-Path: <linux-kernel+bounces-842235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40345BB94C4
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFF7B3458D9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6061F2361;
	Sun,  5 Oct 2025 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mPSfjFj6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC71E25E3
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653500; cv=none; b=Cjc2Re1IdQGt4W/3YyM+z8gW8bWskDgWPWtWPOhs/ARRuLUgAFh/v7NMFB8pGHewV+SWYd/cq5Gcwu4iHFhSOw8te4Tg0rvGhNkq3v8fJus3QItdyHTgu1JDBzdj2WmipYB+vDS4F/3Lbem130dJFF1Gy47GTyw+y4DfqBDUFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653500; c=relaxed/simple;
	bh=3fqWPSIJd3csmKZXNaWWqZ3XRDeayAB5rf7z0R2exvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmKdxqJqhQDr7EwqwV+/ZHCw8w/iUG467T5zMS6x69l5KXkeN4ru75XuPocp74QzVyaAIhxHwrT+BbqCaJ4WMMnAck4Osf/AOnhRHI1bPL9FgPPj8ry66Zu8xhzv1hwNuPx+aLouXSGS1QtlYQTG6ksJpj/WgjBAh5v+7JO861E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mPSfjFj6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-361d175c97fso37191791fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759653497; x=1760258297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fqWPSIJd3csmKZXNaWWqZ3XRDeayAB5rf7z0R2exvo=;
        b=mPSfjFj6Wqfxn3fwpSqWJx87aheLRCYmRJUztu2vObv8J4vLEdpFmz40XizaAhddPn
         gUo61X3era7lKGtAzhPgSSNgDxqCcPYEkwHAxossxwlkoO0nuxN59tYNMo4wXyzh92A5
         miPkXGRRmlYCZHrjYOPnSk3a2DpXkl6n7oTBuh8gNSn7eIldvJKy6DQSTOPJPIKeutDw
         BTOBXCD2p8fVmIQwQtRjXA/akZ/0HkqTZ7NGMCOo1gg1PttGgDNq+i/Z05V27JnPvmuj
         eXOkbI6yQpTt19+wRy8bzEOKgUqVUaJazwEjXFL4qMipQu5lUqPvV8HjCgwlNNJkDETp
         PTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759653497; x=1760258297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fqWPSIJd3csmKZXNaWWqZ3XRDeayAB5rf7z0R2exvo=;
        b=vlV8vj74SybFh8K7reu8+Ty0A2OIdBQOzS3rqBd28d5hcLM0goX5EYNN55JcsBMeco
         yPenGxtkBBrBjSvVxDfwyKomlrmj/wkgRkh1OIHpi0fDgg0+Vq81cAv767ZgSsaB2Kve
         iBp/rGUJvqJ5gm3zEYlE8osUwlOeqh3hWisCJbV3NQrNtuSaEsfkepw8u45y3u/AHKUA
         wNTKeGciw9ojOuBKallKXK7OwtY8ikCrS+m2gNxVZmUyaG72q27P4jw5wyzTbtv6rvQ9
         mSHuFBihS0e69IEvXhjLFOXuko+h4b4C71f4FSNZFoWpDPC9Zc7Q6CoRBrn2Oj5bmQhk
         3RpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdYWTORYu9rpSI7VsEWGX739e/cKo8kQvYkVc/hPnV4+ApS12gDHQFXmwuYmO1az12KUaNkC7hE+qr7hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbFGzAr0acctBZ64YGThEMWU/61xPE1KxdyrtDHRggEWLNCJb
	U3OJkj+6aje7JMniiGBCba6MO4XanSvSuIVrejNOhUD2eySif76/mKdDwVs68AVpCGZIcVLSyjm
	412qzkygRmNxYKnl2Obh6XuW1/wmnPPsxB4NRtvD/CA==
X-Gm-Gg: ASbGncuMbJPyQWQBAujosT7JkjXJQtGY/EvH2YCM1sp1v64tG3Bb1jU8L/iRPt1ftte
	Joipwa3FIMO58AQqsOhr9vYkgGngMLXIyvGTydErUVumCKlWBg0LVu+z7mebDECrCtZzyRol/ZL
	uotyMyba+f/+aZl1zZaC+OPV5wpj4RApkDW9cgvzpf39zHNiiiU4iZJrGbnYKyHc4hLiYimMPMc
	mtdUie1BLVE5B/ADKO++x3noRP5rzAaBln298ZKpi7Gcx1o6UR/swWpY8ov+S3MrMWTynu6
X-Google-Smtp-Source: AGHT+IEINNT+1HcIX5qvEP3cKB0i3Rl+j+gRT3t5cn5mZ+kseOJQ3GUfdRwHB/qOyZHhmlkOW4wkJiqmUqqo9GnyvTQ=
X-Received: by 2002:a05:651c:2357:10b0:372:9780:a2b2 with SMTP id
 38308e7fff4ca-374c386133fmr17808901fa.39.1759653496689; Sun, 05 Oct 2025
 01:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl> <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 5 Oct 2025 10:38:05 +0200
X-Gm-Features: AS18NWC7MOPcYjLRf-YXTIdh4W7Riig9juU3nPGCdB8PWtzaZXoX7i1GOtQ5KMA
Message-ID: <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, 
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan" <ilan.peer@intel.com>, 
	"Gabay, Daniel" <daniel.gabay@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 11:00=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Bartosz Golaszewski <brgl@bgdev.pl>
> > Sent: Saturday, October 4, 2025 5:19 PM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; Berg,
> > Johannes <johannes.berg@intel.com>; Anjaneyulu, Pagadala Yesu
> > <pagadala.yesu.anjaneyulu@intel.com>; Grumbach, Emmanuel
> > <emmanuel.grumbach@intel.com>; Bhaskar Chowdhury
> > <unixbhaskar@gmail.com>; Bartosz Golaszewski
> > <bartosz.golaszewski@linaro.org>; Peer, Ilan <ilan.peer@intel.com>; Gab=
ay,
> > Daniel <daniel.gabay@intel.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
> > REDUCE_TX_POWER_CMD ver 6 and 7"
> >
> > On Sat, Oct 4, 2025 at 4:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > This reverts commit e3fd06d1d8869747e02a022e3c9045a3187f3aa5 as it
> > > broke wifi on my Thinkpad P1 (Intel AX210) in v6.17. I don't have a
> > > better idea than reverting as - contrary to what the commit message
> > > claims - this chip seems to still be using the commands removed by th=
is
> > commit.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> >
> > And here's the kernel log: https://pastebin.com/zrTPbE0j
> >
> > Bartosz
>
> Hi
>
> I think you reverted the wrong commit?
> Didn=E2=80=99t you mean
> e3fd06d1d886 ("wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD=
 ver 6 and 7")
> ?
>

This is the same commit though, right? Am I missing something?

> Anyway, for fixing this issue, can I ask you to upgrade your FW? Then you=
 should not see this error anymore.
>

To what? I'm already at iwlwifi-ty-a0-gf-a0-89 which seems to be the
most recent firmware for this card.

Bartosz

