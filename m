Return-Path: <linux-kernel+bounces-889305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CDC3D3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91A23A31AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF434DCE0;
	Thu,  6 Nov 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCkS6zvL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EED3043AD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457211; cv=none; b=TsHB2QRKesgQK1wkgS6MEYD6ET2R3uMjqfB7Mt2UTpI8vOqDFTO2JxCmEkxVQ8Ky/Rryq05L2Nd5By/DXawjoKijuEO5pC8zB0tGfk3j8p/t0ew8y0XzCJheRtCfwTOD5g3JxKgvguF6lJfLLEAyDCX4joj+iRX2Hveyo+t3iKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457211; c=relaxed/simple;
	bh=zhh/X5ttMMoRznprN3Pz/B2WPFekQliTvZqswOSYzbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je7bIYsGGdkkNQ/CFM5aD9xI8MTK+JeXb7AwbgHciT+6G5+Ao421RGNUU2JuSrRJ0MAo3iR5iVRNyliRby820e9JhGkV37gSVCohmoMpj/HgJ21mLunSmuy+HnXGrkQf4rrVMrqWWPr433kJl//qxCN7vr5KcnfT3LSvLthpuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCkS6zvL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563bcbbcso6874205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457208; x=1763062008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwyTwhLa5pqI0LdPc0d68jU8z9uOUnUkIeBJpd4iCgA=;
        b=fCkS6zvLozMKxaICvOFxpBjGqvR+qapBL8rc1tWbACPmZSgHktpSBnolXRtnnXQo40
         /KypNPPMRtXhJJk4rXmphRs9XYQffye5DyU82FK/Gfpq5WhJewbSlw3Mz50hbioAJT2L
         l2KdrlFt/q4Rlsx3tgY40N1lLNmkzeLXTYIM3e91rB+tJUr/kQ6uhjBV0JGL1cT/ZOL0
         cMPzI0WFTfo/R8xD8CFRWaDrNZb5l6RWlcxN4Yv/8ze+FySzzqslWNo4Y0PT/J+o/IUO
         jS6/O682u/dA75+Bb0jsuQ1Wx9mZo3tW+I947hgl3J39ebBgNWaCVaOq3W2yqTC5ADga
         NL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457208; x=1763062008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwyTwhLa5pqI0LdPc0d68jU8z9uOUnUkIeBJpd4iCgA=;
        b=WGvmilrF6PAjuzBZxzHKywcgdxnK0vsJzBgnXRLz9vPAG4x7dKjfyFIhCCnkX683p/
         fxsHgiVVm7ithlgbr2V556MYubvOHeUDr1FEKKVqDsblvvWey3Ef06bTju8ll8GRCJiv
         fGSp9z+ZCMtgbkj3pC2BHKsladLtXlML1eAqsWlCAOMOuN8fAjxBF0b+G4mxTxfiFqQj
         KfIkjl2/5fw2PtO/2aC1gyAyJtONMYWO7YOn7z1yq/YMrz71cxoMvuZwRqBrI3t64GDc
         MfxJi7ArQTi+WseIiOg5+9IwNhFW6PChImXSyBkm88zeiyPjFQVfEYKFt/MAnuXWlRDt
         +zsw==
X-Forwarded-Encrypted: i=1; AJvYcCXEAHK8ODZtAMVFgO+rxTLsE77w4g5dq8N3zZsOyDug+yvPnaxC4eQAF27uusmqyulP1Z7nIHMU++tCIpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kffKcL/M1GJTmNYbBfy4B0dlJ4NkL2uBk7Uj+HfiwHXk3V1y
	IwsfpnSRPRGXBS10E/DJ2+BVEQmsdDbzIS2YV/7hwsETXR6rkvE1MXP0
X-Gm-Gg: ASbGncu0ebN+jMhd1+vnPTSsfnUUh63c/amGAOOiIfmyQIh9TiQEdO0BeWEEvWUqiOE
	g7DvFLutHaQJxTD9opm9Guq5sh0awJbDMBpHl1KwmQz0UjmrpjfkY/fsnoZThOVe6Fl4ZIregfU
	AGBO6jaAG+WvINJN4PxS/NX4n91wftr6TR/pOMiUrx/2k2BiHw1rHTokMKG6miG0bd5zbCWpRZd
	CVyrK2Maj9hSnMhLSlfrwsQnQuI2RLJdRq0wKrmDGXzbUe1QXh4bXoB6MnGkzVrFxwjN9UKThMl
	VMZ0v7uVtdNvyQ8v58tuCG/yMja1DR5pQJaEUzLV4SGpKLbkGrLD0kNd68Sn/SrFDiITj7id3Vu
	Rz5EXq2BTIXMq/ifUc1DJIU4UPUrPzZmymcmplZxEJpzcOcoJ7whMJLR5159jXujGkiVLFPPeeC
	BwCuudyomT0g2o9c0djHdxiWEtX+0y/0APuoCJ2ExK7Rzs2HtslZ876TyAhCRdoBM=
X-Google-Smtp-Source: AGHT+IGTla4CePH0L3Rk9O7fjkJCLGeVLWduj8m7JXKWo79RsNtzdF/PeL5Glnk4Exnt93SYvgt/zA==
X-Received: by 2002:a7b:cc91:0:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-4776bd0e80emr3032665e9.40.1762457207689;
        Thu, 06 Nov 2025 11:26:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fb6besm22490075e9.9.2025.11.06.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:26:47 -0800 (PST)
Date: Thu, 6 Nov 2025 19:26:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, "the arch/x86 maintainers"
 <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251106192645.4108a505@pumpkin>
In-Reply-To: <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
	<20251031174220.43458-1-mjguzik@gmail.com>
	<20251031174220.43458-2-mjguzik@gmail.com>
	<CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
	<20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
	<20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
	<CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
	<20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
	<CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
	<20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
	<CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 14:19:06 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Thu, Nov 6, 2025 at 2:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
> >
> > On Thu, Nov 06, 2025 at 01:06:06PM +0100, Mateusz Guzik wrote: =20
> > > I don't know what are you trying to say here.
> > >
> > > Are you protesting the notion that reducing cache footprint of the
> > > memory allocator is a good idea, or perhaps are you claiming these
> > > vars are too problematic to warrant the effort, or something else? =20
> >
> > I'm saying all work which does not change the code in a trivial way sho=
uld
> > have numbers to back it up. As in: "this change X shows this perf impro=
vement
> > Y with the benchmark Z."
> >
> > Because code uglification better have a fair justification.
> >
> > Not just random "oh yeah, it would be better to have this." If the chan=
ges are
> > trivial, sure. But the runtime const thing was added for a very narrow =
case,
> > AFAIR, and it wasn't supposed to have a widespread use. And it ain't th=
at
> > trivial, codewise.
> >
> > IOW, no non-trivial changes which become a burden to maintainers without
> > a really good reason for them. This has been the guiding principle for
> > non-trivial perf optimizations in Linux. AFAIR at least.
> >
> > But hey, what do I know... =20
>=20
> Then, as I pointed out, you should be protesting the patching of
> USER_PTR_MAX as it came with no benchmarks and also resulted in a
> regression.
>=20

IIRC it was a definite performance improvement for a specific workload
(compiling kernels) on a system where the relatively small d-cache
caused significant overhead reading the value from memory.

Look at the patch author for more info.

	David

