Return-Path: <linux-kernel+bounces-795518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B62EB3F3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EDF1A855D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F81DB15F;
	Tue,  2 Sep 2025 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRLXJ27T"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84D22301;
	Tue,  2 Sep 2025 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787955; cv=none; b=cHDXuAv8arUR0hNoKqf1tuZ8ITk6jTb6PdywQKgxlU4F8YkSMddUFhw+Q388pbqAZc5M/e8ZESbTkU0wkP+BtDrJCofQeV4vgHad6OSgAdN1FA4irPwzMi2awLBFss3eHyy5e3R1K5MWRBs9pDsGNLqlYhZWfo/UZSJrkkc2l3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787955; c=relaxed/simple;
	bh=Uj4llZNFTHcTy9cJ7yoCbWpoxt2Zbuk+5mCNaChS8rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHMzfRcvwg0C1o0DuTCFO9ZkiAZmr71H346RmDD+MsU3ChDY6SPoJdka0/LGOyCeY1fiLe/yrMZLTekEm20h0ex0mSq+Y8gWY0ZAiBbfZy1pFV2DlZfFiMe8D/8dX9TPiNge50wou0F6NqSRnyJ6Fr6mZ64yeZxcArPOm5g94/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRLXJ27T; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3276f46c1caso4575805a91.1;
        Mon, 01 Sep 2025 21:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756787953; x=1757392753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj4llZNFTHcTy9cJ7yoCbWpoxt2Zbuk+5mCNaChS8rE=;
        b=SRLXJ27T7WMv4hcElPsToV02Pdif0EsmCqBDEPLJXbElszyyRZOJbe0TBmCKzQMrbU
         YFAF9ufLG7Is1Vv5fotn8zES+0oqlATKvR/CUvhIdh71Pp/+Vm1vsyPczUHDQE9wK0J7
         IWso87h//2Ma/MtFUdp+k/Ek71wMaMzm9z1yd5I5luj9px/O3VUKDX3NtWKwldW3gMXr
         tfeN69J5wr8OUaHaeIpZOS7mxoQAKYenwNF6yzgJgzB39KVXF9RZLSGKGiqQNqDycSa3
         t1x91JSFe/oH3SsNwl9A2fKcG30dpAvcbXA7eDphVCALKDlb/EFzvVDy+d7WhTrBKE6/
         rbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787953; x=1757392753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uj4llZNFTHcTy9cJ7yoCbWpoxt2Zbuk+5mCNaChS8rE=;
        b=TzXCpfSbu5HcCU2azgSJ0Emp+ay07JTX3DUu1ZuXp9YFVs5+R3znW/2BlQED8JBW29
         KVG1O6EY4n6E/jE/M/jvvsFSHFcy3HpVi0+Jvr2WYEnC0bPOc0XPkfuOnjIH4D4lLaU5
         3aKfbVToWcGTUmPua32zxOLHycFn+F4db2HmY7BJ66r2FmTgFDVXzdD0bZNFqX2l7iIF
         taJBh34BUaoMxLcMz91UQa/49bsjQlCpkZ7f6DFo/ibd6D5AjaTmB359HvJpZWnhAAGr
         c6Xiv440EClmNoiZnx1Yg5AqDGRs1V3epIEddWabrAJnhvHM/wgjZLFm/POWdd3POIBC
         6+vg==
X-Forwarded-Encrypted: i=1; AJvYcCVvl5frjZ94yCLuo9OJy0+j48SK+z+gZrG2gKwZUC5oMptmKon9sAspQSbPSGFeQPWceICYgN8Nb42XeDI=@vger.kernel.org, AJvYcCXW3gqXjLF3kNxb7RUCDpSMQ23p71wYRPz/AcB4B+IGdespWZruybfaj9VbcmlRmB1pAzh2OCWBvt9JEj3RkZtvXa/tog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4l82yuLNeX9V3kS7KNO06QQqo8KMT9w+0xupdSf4u4GLc8+4
	J4WuezKgcqCF68ERZv1dsDeJic+dahXkG1Oh7M9wlgMKIZSSIepMe+P0
X-Gm-Gg: ASbGncthNQ0l4MGIGN4esTAW45frRpLKQFeUuiGV31E0w2Wn7oalhiarns2ihpZ/STv
	dWAaeDrFPnyPAfAh2gxl3iaxc5lG09kToHYR2FzFyuZcqA/FHXrIQYplBeCRrtkSO7rrutslRcc
	Vh6NgQRcVjEvg4s17L0RxC644kpZLyyC1D+TwpNOZ+GHeMXzZ5RSvMUX4zZF4c4J02Cr7MomX3y
	D/C8HUSiqwAc9rlkfpnaJproYPdk2rO4Ex4yxoaAFteWqLWkCgT+vMkNkR2+G5jyW7jsuPwlOZq
	4jSXj4T/2zXCyEsn4ZwnVkq+ckRKlhtA5DTct94j1SyI9O9Gd4xVg1X0vvRKUIfCvIQ9UBzsH2x
	R0nHfeRTkjFXedPzvSo3tI1hxo/R+58lQ/J8r
X-Google-Smtp-Source: AGHT+IEGNoaMYGpe1zjMENuHS4YoZHiS3pXmXy0cqbrMPjfcUXWgRA5FxJgRVChd2o+0OneLfEKUjQ==
X-Received: by 2002:a17:90b:1a8e:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-32815412b74mr13049298a91.2.1756787953247;
        Mon, 01 Sep 2025 21:39:13 -0700 (PDT)
Received: from cacher.localnet ([111.94.119.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e6d6d4b2sm286573a91.0.2025.09.01.21.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:39:12 -0700 (PDT)
From: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: basak.sb2006@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jlee@suse.com, kuurtb@gmail.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rayanmargham4@gmail.com
Subject:
 Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control support
Date: Tue, 02 Sep 2025 11:39:09 +0700
Message-ID: <5007139.GXAFRqVoOG@cacher>
In-Reply-To: <5b7f6b40-8d4f-470e-ae84-b51d4177af39@gmx.de>
References:
 <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
 <1bb3edd6-405f-4615-831f-301dba525bc3@gmail.com>
 <5b7f6b40-8d4f-470e-ae84-b51d4177af39@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, September 1, 2025 2:33:53=E2=80=AFAM Western Indonesia Time Armi=
n Wolf=20
wrote:
> Am 23.08.25 um 03:27 schrieb Fa-Iz Faadhillah Ibrahim:
> > On 8/22/25 7:02 PM, Armin Wolf wrote:
> >> Am 15.08.25 um 08:17 schrieb Fa-Iz Faadhillah Ibrahim:
> >>>> > This experimental patch series aims to add fan control support to
> >>>>=20
> >>>> the > acer-wmi driver. The patches are compile-tested only and need
> >>>> to be > tested on real hardware to verify that they actually work.
> >>>>=20
> >>>> > > I CCed two users who requested support for this feature. I
> >>>>=20
> >>>> would be > very happy if both of you could test those patches and
> >>>> report back. > > I am ready to help you both with compiling a
> >>>> custom linux kernel for > testing this series.
> >>>> Any updates from the two people with Acer hardware?
> >>>>=20
> >>>> Thanks,
> >>>> Armin Wolf
> >>>=20
> >>> Hello, I've tried your patch on my Predator Helios Neo 16 (PHN16-72)
> >>> using quirks from PH16-72 and it looks like fan control works just
> >>> fine.
> >>> On other note, can you please add PHN16-72 to the quirk table?
> >>> if you need anything to test please do notify.
> >>>=20
> >>> Thanks,
> >>> Fa-Iz Faadhillah Ibrahim
> >>=20
> >> Hi,
> >>=20
> >> sorry for taking a bit long to respond, i am currently on vacation.
> >> Nice to know that the experimental patches work :).
> >> Can you send me the output of "acpidump" on your machine?
> >=20
> > Hello,
> >=20
> > Sorry for disturbing your vacation, hope you're having a great time :).
> > Output of "acpidump" attached below.
> >=20
> > P.S. Sorry for the messed up formatting before, first time here so I'm
> > still learning how this works, hopefully it'll be okay now.
> >=20
> > Thanks,
> > Fa-Iz Faadhillah Ibrahim
>=20
> Thanks.
>=20
> Would it be OK for you if i send the non-RFC patches once i am back home
> (around 15.09.)? The reason for this is that i made some improvements to
> the RFC patches, but those improved patches are only stored on my develop
> machine at home.
Of course, I'll try it once you send the patches.
I'm wondering, where should I send a feature request and a bug report? it=20
would be nice to have the battery limit function upstreamed, and I discover=
ed=20
some bugs here and there as well.=20

Thanks,
=46a-Iz Faadhillah Ibrahim
>=20
> Thanks,
> Armin Wolf
>=20
> >> Thanks,
> >> Armin Wolf
> >>=20
> >>>> > Changes since v2: > - remove duplicate include and replace
> >>>>=20
> >>>> hwmon_pwm_mode with > hwmon_pwm_enable in second patch > > Armin
> >>>> Wolf (3): > platform/x86: acer-wmi: Fix setting of fan behavior >
> >>>> platform/x86: acer-wmi: Add fan control support > platform/x86:
> >>>> acer-wmi: Enable fan control for PH16-72 and PT14-51 > >
> >>>> drivers/platform/x86/acer-wmi.c | 298
> >>>> +++++++++++++++++++++++++++++--- > 1 file changed, 273
> >>>> insertions(+), 25 deletions(-) > > -- > 2.39.5 > >
> >>>> --------------------------------------------------------------------=
=2D--
> >>>> -





