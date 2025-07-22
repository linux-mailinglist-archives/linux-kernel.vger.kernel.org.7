Return-Path: <linux-kernel+bounces-740750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0FAB0D89A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9350F3BD483
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C3F2E4260;
	Tue, 22 Jul 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DjtDc0LH"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3649659
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185253; cv=none; b=mJAiraxDadM9hLqCbzkzMgK3DBdZZxrr8BCs39l8rM94JQsfS3d9y2IhMYVcTJqfEOUaDSEEnwmR50HaZ0IhldX/bmnRiYbfL2k7UaBH6sG2JVKI4gDrQhwRwtmFMbMEJkv+K7p5jNRitF622qR5419SIjKDsnqsVchHJITtqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185253; c=relaxed/simple;
	bh=Fla3OlF+/YSMx3UOhbmIQazfbvpT43e/E5z5T5vEJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg+xW/GyvtNIXhfHBAWZtO2RPGPxqXkmoR2K8yzV8z6ta+1j7IJ1DiMoHdteHc9Ogq4vEY7KOlvbTXxOQKDo/NJNVjwUOhSOFPsaaCFZMrZFlPqEktDS6xmsknxkm+zmhD2fbi+UtCwjIC57Bzag5XS1vzolJaBmO8es+XltO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DjtDc0LH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9c2754a00so916262366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753185250; x=1753790050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kKt2BVvYAWPd9RG6IbzHHUIGJ1xcLJOliFtWnoC7pE=;
        b=DjtDc0LHqZeKUILy3s2oQKZYOl67ZHw3E6MR8ZsoFMudW1LCstl+1eVWktnLYedAyc
         QHAZDacJek7qNDVWuqyXRaQr0SahdEmxNND230oHu5FmwnW0nLv4tUMhBUQBLw6eGB79
         RX/2eypfTwu4wocmsOlkZfQrIPfk98OvbmqZJdAh+YOn4PDQTyQ3kvMocezzh3W7IBWs
         yfTyz630RbtfHiirLXjmBYuUMoTKwY74jQ55U76ttqlOKqb8HsCqMXo2/r0gsOVbeMZ0
         CK964OQlGW2Dn4GhoJftIcb33+ypxiWkR2Sy+n4aOO/oaHjtr0giypvSCv9snrk+VJb2
         nR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185250; x=1753790050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kKt2BVvYAWPd9RG6IbzHHUIGJ1xcLJOliFtWnoC7pE=;
        b=RHMOEt500NNE5FUIEvJPjOJGaBi5IhyW0RrNfVmLZiwvj5RlsH4hMtxhKmFaWz08P3
         W/fYikj+sl6ShaznAJC6lahK5H4lnuV7c16zZy7p3tADuVSaj8zhdr33+bXKo2vQiXZx
         bQjOL1SqDtdBojJpuQZJ1TMy1Bw+HRIaz+wKzoQX0q71o3sLWcqORlKQ+N6r6BEMN2lX
         W+P2kB/MjNjdTNtzDYvbSfPDzjn0YzRAeJn/gQHJ9UR+G+UKFDzJg/mwSI3MJUEV3KCv
         vDMWJBqBWf3Ir7vMyV8XApFdc9d0FjFTSAWA62CIyzwww3TEw8tz1g4CjOwUo266Hzj/
         vU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+4yRQu6L27b7dSz7UFG1/ClHStlgRG9pXs23ucSB+lIR+D3vzAaXTbWmmiE4gJLk6g7UiHk5V4E+h+VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRi3QP2/5Io7eRLwguryvi0gu7UMZc0qBqe43NvV8b7N8Reyry
	8XXZq5aGznm9X+x5tgNwutFAHknf9AGHUPbk6z76b+OjhiLIFVJNczP0Xg5OPmTd7Ik=
X-Gm-Gg: ASbGnct+vCrz/9D+Y21a7lfwQ5zMxuyT1heRKEmbvEl4K45KzOL1VCA5RgPTAORLU00
	njSYmjPNUoX5kcoWsd0qS23dZfeFYhEthR0bhIlRFZA8sdtJp19Rgk3VJ6f/eYp/9aE1P56AXvM
	rJWQVyYKa39EAsNgkoumU5LeLPWDBDwFDG3XPY0GAG0/PpyE5MdiULy/Mn0+zFBJ4n7VL1CNl+D
	VeDnOqfuUhLRTa0qDfLdEJQg1hqPFEAVkbwevk9G4af3eKcxE4IEcHhv8tCT52MDBt8kxwI+3OD
	h1o0cpcQ2FvjGXER1oMgoCxVOzGythRmFSC/u4WwwNRzG2ObhV653neh8M7CKrqORMoZWkJQxSs
	7G216+R0YNvmmSNHoNKnfqy+X6oAVL5R5YGHOLpRG2eXz57ERFWqk
X-Google-Smtp-Source: AGHT+IEfIxYTONnhe+xRu0jikk0G+zzebdF83eXd074o2mrK0k86lhWSA/IBxcIozC2KvB4QKVdAMQ==
X-Received: by 2002:a17:906:165a:b0:ae7:ec3:ef41 with SMTP id a640c23a62f3a-aec4fc42368mr1727192666b.45.1753185249984;
        Tue, 22 Jul 2025 04:54:09 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2f19csm849926466b.70.2025.07.22.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:54:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:54:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, Tiffany Yang <ynaffit@google.com>, 
	linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
Message-ID: <adrjkqsqqwxcsdr5z4wmxcrvgvutkulzgka6pjjv23v6242txr@vv2ysb46nhpk>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
 <aHvHb0i6c8A_aCIo@slm.duckdns.org>
 <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="euhvc2odhqtm7xfg"
Content-Disposition: inline
In-Reply-To: <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>


--euhvc2odhqtm7xfg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 05:01:50PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> Specifically, this change would allow us to:
>=20
> 1.Remove these CPU-specific callbacks from the core:
>   css_extra_stat_show()
>   css_local_stat_show()
> 2. Clean up the 'is_self' logic in rstat.c.

If you see an option to organize the code better, why not. (At the same
time, I currently also don't see the "why.)


> 3. Make the stat handling consistent across subsystems (currently cpu.sta=
t is the only
> subsystem-specific stat implemented in the core).

But beware that the possibility of having cpu.stat without enabling the
cpu controller on v2 is a user visible behavior and I'm quite sure some
userspace relies on it, so you'd need to preserve that.

Michal

--euhvc2odhqtm7xfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH973QAKCRB+PQLnlNv4
CFq/AQClJUmKOphL5NvNc5AVqGOpLStkEZI+TheupLy0GZFR7gEAnedr53Iw59zU
//68DI0J9sYoXIgmUXii8bcidi8uwwY=
=Mri+
-----END PGP SIGNATURE-----

--euhvc2odhqtm7xfg--

