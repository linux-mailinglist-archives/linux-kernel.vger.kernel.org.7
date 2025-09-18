Return-Path: <linux-kernel+bounces-823612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65241B87016
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B514C164BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240512D2383;
	Thu, 18 Sep 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c52Ns5Ld"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E12BD04
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229585; cv=none; b=c1+K4dMplRBnMdbWFwb4IdAuS5WbEW67vRdSV82FMGlT/gDAnnJQ68AGMUPJn+f22t1zv4GRNmcQUBgyntmNI/iaWcRWF5rFIQAZK7YQyP+skJi8IqydXMEh6im/6PHeqv193LAPSM38PZyeCyKNf06Nwm+gvZLQNAfspaQE3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229585; c=relaxed/simple;
	bh=KuPC6cAjvhH1q1Wvmz9gKs6s4204dV0dDY/kig2vSqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXXQ5X8vlFX3gmR8lj/KOaoz1sC2XrgG7DZ+LJlQiW7LjYU8ulfSm0javkEgOZzH6NtPMND4eTKnHeQh3vAAGZ4OCb3IVqrBGGUeIMlFuU4RVUlol4mLl6ox5JUR4l8agfKekBDnJnR64cY2SCRScaurHGKxzVX/JqENBENJhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c52Ns5Ld; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso10178025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758229582; x=1758834382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQHCl31kGV9yQ4doPTaILGPNDkJYFj0KpUpdn6brPF8=;
        b=c52Ns5LdN85fQSP4eJl+eRkByG3lNi1uAKUKD/osp0M3aDsygLHpOZZOn/X3nX+ALA
         x896oiWPti2gW+XBceANHUOEQ0Wt2elJMIBgP61FVdzlle2PEaz1yFrvYGroUoP1OJ2v
         FZyMnWQR/ilML4c+FJZcfiTudt3/Fc1ETAnCubCJKqxN2w5NrUCRMGe1+rs7wZ3PVC8R
         qCoVGvZK343moX8jpw+UXiTV66ClSSeqAec+rsX4FvHNLs716hV9cewzg35pWxYSmAb8
         R2AMXN07m5MvwcT85vlY7X4Vl2HyZ6bqykqCWoDwYIYncz6tb3X9ynouzXrvDmgqJZjX
         YyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229582; x=1758834382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQHCl31kGV9yQ4doPTaILGPNDkJYFj0KpUpdn6brPF8=;
        b=iYwx15kw2aSNkMiESDxZpGRl9jETehNhVifW6JGD7Fi3ZiAwgfDrZrD9Oq0od/adDX
         Zk5n9UeR4k+9JfadV4TTrZuFFZAquMir+SrIUtf+/UYkRx0oTcO0uda1yRrXOj347UK1
         XSn3lrRYWW12qIqy67v+E+ASPsIaZTytbRjJ9wKszQ660OApQABvs50BOBKuXB7NL+Qg
         AQF8EJG0WuUteO7d7O34Ej10FTov/B3Fd1nZ4R9V0Sc1bbR4h/btR7T+nVuhhf91DRVe
         9/znrwyAccC6TL3XpAmEInf+A6+AMwyl9MDXN4aEkH6Qsoa8rFTaKqemRIXw48P0D7x7
         ns1g==
X-Forwarded-Encrypted: i=1; AJvYcCWreSiAznMTW6D+2TFEB82BZq/MiwGpI+R2wbbCZcsP4lYLbglyIzG0+l28N0iydZThXzuqLvaPcUgB0hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKA6iHq76U6gTiu7hUv//TgEY1pVgekD+8B5m0SX2VRrQ0JywE
	oOurhsSzVixqMgK2j7hpOrWDnRwSqMYjUXzvxAVIFqINf83muSxVLkuQ
X-Gm-Gg: ASbGncu8ut8I4Ie9a87Z3bd7I3jGL0W2fPHrh0UAxRckpKhNuLm1IYKIvKenP0tJVF4
	8C5OljztF28jfMZ28cM7LQTK/e0tntgnhmsjnqlteLoZnBQ9LnCO6ZOIJ5J7yNbpF/Hp6X6POCM
	Qe7sfhrEpGoJBD9axhtW7qR76yTHGUdYZVAJg0/oXRXhA23MZ6Uq+fWWihh455oXs1b8dcMVoVV
	Xi6SljXMcUG+rgBCdPJ/4EqzWglaiNCobqd1aCLedwhBGSj7d69AoPLjrZ08/AWaGYfgVRlebB7
	h8/LUZBwSbyzc+Em3hBkic56MD+8Vd9UH0S7pJ83JCuZHd6jWnme4LBEUlLkxa7PyBZzYNUF500
	kecxRyk9QElzGZqoNL1PfSOTJYxV8Woe8y6NaXydIyxmbK6WHuiLXb+GnWSXmfLbFQeSklq+C6Z
	SZPF0=
X-Google-Smtp-Source: AGHT+IHmbi1HnHbBgDb35p53wef/5PFPkFUaJZ8/IcsuRV1U1zsnY7xg4LuyPHiF/rvxibXZGSbb4A==
X-Received: by 2002:a05:600c:1912:b0:45f:28ed:6e28 with SMTP id 5b1f17b1804b1-467ee305892mr4370735e9.2.1758229581813;
        Thu, 18 Sep 2025 14:06:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3262f6aesm64770895e9.8.2025.09.18.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:06:21 -0700 (PDT)
Date: Thu, 18 Sep 2025 22:06:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Oleg Nesterov
 <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Biju Das
 <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 next 05/10] lib: Add tests for
 mul_u64_u64_div_u64_roundup()
Message-ID: <20250918220620.13e74f27@pumpkin>
In-Reply-To: <tvv7kzky7wdpef2s27fpvav6a7sbkmt45v7j63y4jirgq4sf7e@znv4p7d4u7is>
References: <20250614095346.69130-1-david.laight.linux@gmail.com>
	<20250614095346.69130-6-david.laight.linux@gmail.com>
	<q168q017-9p30-69p2-o4o5-s6q1s1385o27@syhkavp.arg>
	<tvv7kzky7wdpef2s27fpvav6a7sbkmt45v7j63y4jirgq4sf7e@znv4p7d4u7is>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 16:00:42 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello David,
>=20
> On Tue, Jun 17, 2025 at 12:30:17AM -0400, Nicolas Pitre wrote:
> > On Sat, 14 Jun 2025, David Laight wrote:
> >  =20
> > > Replicate the existing mul_u64_u64_div_u64() test cases with round up.
> > > Update the shell script that verifies the table, remove the comment
> > > markers so that it can be directly pasted into a shell.
> > >=20
> > > Rename the divisor from 'c' to 'd' to match mul_u64_add_u64_div_u64().
> > >=20
> > > It any tests fail then fail the module load with -EINVAL.
> > >=20
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com> =20
> >=20
> > I must withdraw my Reviewed-by here.
> >  =20
> > >  /*
> > >   * The above table can be verified with the following shell script:
> > > - *
> > > - * #!/bin/sh
> > > - * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3=
 \4/p' \
> > > - *     lib/math/test_mul_u64_u64_div_u64.c |
> > > - * while read a b c r; do
> > > - *   expected=3D$( printf "obase=3D16; ibase=3D16; %X * %X / %X\n" $=
a $b $c | bc )
> > > - *   given=3D$( printf "%X\n" $r )
> > > - *   if [ "$expected" =3D "$given" ]; then
> > > - *     echo "$a * $b / $c =3D $r OK"
> > > - *   else
> > > - *     echo "$a * $b / $c =3D $r is wrong" >&2
> > > - *     echo "should be equivalent to 0x$expected" >&2
> > > - *     exit 1
> > > - *   fi
> > > - * done
> > > +
> > > +#!/bin/sh
> > > +sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\=
1 \2 \3 \4 \5/p' \
> > > +    lib/math/test_mul_u64_u64_div_u64.c |
> > > +while read a b d r d; do =20
> >=20
> > This "read a b d r d" is wrong and that breaks the script. =20
>=20
> I think apart from that problem the series is fine, isn't it? Given that
> I wait for some time to be able to use the mul_u64_u64_div_u64_roundup()
> variant, I would very appreciate your effort to end in this patch set
> going in. Do you plan to address this issue? If not, I offer to look
> into it and create the next revision for this series.

The series doesn't currently apply due to a conflicting change.
So does need a new version.
I did start trying to do it, but have been busy.
I'll try to find some time.

	David

>=20
> Best regards
> Uwe


