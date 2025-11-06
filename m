Return-Path: <linux-kernel+bounces-887732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0FC38F76
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 089624F4DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2126ACB;
	Thu,  6 Nov 2025 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQAgpeyu"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BF8F7D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399752; cv=none; b=et/fcx8/ZSlyFy1veRw7yPjJ+S6sDYZRy5C4kaTXTeZr3xL10vVHd6x/fhUej/7bySoB0i8VF3zMqFvJvwfcqbZhbwynlodZbD5GBsOlJzfng8ki1iixJ4jAxO4VcFQWiq/qiwh1whNaTeVD5KI8lkMCltoX8P8DG+7Eib8PaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399752; c=relaxed/simple;
	bh=GySsdT73BFwStgO70p9Xc8awpOEuOkwucwV3nCJI/5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hv8q+Mah+18M/oeR1uobWKL2KfmHTRznE3nnzd0ISNa15foUid0X9a8ZQHq4fR+pWPncqtaoEUqQEMFFhXFT5S92cEfStY0YMQ2ujX+IwJz//AMH6UgMg3j3fQUTBeGHIcAZKnGgNXkr/Ktf0V4QiKVh0WebN7gY9WsMEkMNL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQAgpeyu; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so290121241.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762399750; x=1763004550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n4CaiNtBzk+J1ksip0bh0eyQEO10boIF1xJKJ7rk94I=;
        b=hQAgpeyubKqOKdS80ykJu3p3RBB3lb8r00yX4e4Vno/B2jZDQIDES2JmwMJJ7cgwnZ
         zWkOZib5kGMW7+c/ytzyhXOh8gpSAVANRfIVN/JDdGIlnyrYsCCoTnRYpE2oap4NSN8K
         4kxAyAli6mV52V4RvMOpVJFDGq6RpiUBX7da9wUVMDzuHJ2mvXwbkhJku+Ho2LLVzhqP
         Z9KzxeqwaxBf2ZwxaSR+HS68A0OZ5SQAzPhuVsveUe6lgmwue6Z/50v2TIp2f3SsMiL9
         3u4PcCZ62BQIlsj5IBKhrLcjq00X3/vCuB/I8wcJk0mk3t6ERf7wv5Gr/hUCG8sWnE8u
         a9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399750; x=1763004550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4CaiNtBzk+J1ksip0bh0eyQEO10boIF1xJKJ7rk94I=;
        b=jVmOBm7BgMdzIM8JUQC0IwQV84XYU1ZCwNLHqCDFdOXaMJ79Nef2EfRrB/JcAY3XhD
         0MQ+vFJW8WTIOIjjKB+wnedLRmwhMh6ox4au9uYnJyjF/XpDL/PZglSA7omTwzKb8uJZ
         X0BaT+BnCu8VLtITC0dAbOoqpbp2KRw1ztxDWf5zTn1vo3jkiq8k9/pD1c+NbGugumCQ
         ZXuopj6WBsGUOAsBO4OCMiAM2S8dd1H7qHIrH6bI0dqGyxwIsQn1HBCUnE2243p/7Pgf
         7cBP0Dg6VPJm2ZHO9KP7ylbJiPZYXtmYxA9ptK5a5rtsu3uSt4GrNuBjVq9PepuPiprA
         ggYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRJLyACtLxf91trEqfW64q0LhGx13z5PQJ88FgSS7fDb2F4XPoBbTbvd19/vBcjUZGsFZvPbc+pCHRbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0d5ebcYtBT8DM16Oij40OE1dOwNbBP/tr7b9SePGvqTs3F3Xx
	33cnkezC139lZQ/jK1eIPtKQQA92RZCkbV9ghsJlxSdaFK0sF6SC2EF+
X-Gm-Gg: ASbGncuiL3vgZ4umgvLrAl23LjC+IWmn9AEBrzvYIUHlO1+hDdBdp5rpz9bdK3Y/26l
	sdVsZeMUIHsH+dk/+VKzD7Kf1QxdcqxIsPwhOUA9aPrw9xNg5P1DZBOew8b4QujOzFh/nQErQ4r
	56vFzoQPxt6aSjSjyXTk78Ex6ktk1vVfdkfLt9zBOBH+EvfGYUQVQSO/Un5LgoYU/2QNhKAZ9yQ
	dJrtmxXmrxHBmhhJa9L7o3HLIa9Y/mwiTEhsa4VCq1nMS7pn0HLYYHvpylaRyN1PXwBTLAjixFD
	dYXIhuByAbZSSR+lRjB6DhWUMWJu3rrH3hDsw4nMQ+fDxZ4yhQOL46qwuOvb8j3tS5TVDUV1RwP
	UMSlaMNHVg/h02kvvIWsy6kMH7aZiz5CfOUpoTnDjrkc7Xs+MlLizika8SG1pn2orgkt5Quufe7
	Dz+PcGXdvD6KTboim8EKE2ju48ehlHSyNEaVL8KjIc5VlCBKFxtArE+NtnSogoSnzH7A==
X-Google-Smtp-Source: AGHT+IFz8CjtY22nY8CSkSNf3qcSwgBcNz2TUbUcHnHKwWyMgld/sbQ3g787kvjrkj/fsGZMF1TvTw==
X-Received: by 2002:a05:6102:f12:b0:5db:aee2:9964 with SMTP id ada2fe7eead31-5dd9fcfa31bmr711345137.9.1762399749959;
        Wed, 05 Nov 2025 19:29:09 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3? ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937089699dcsm550066241.10.2025.11.05.19.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:29:09 -0800 (PST)
Message-ID: <867953df79b54037ce91cf1886b09ec5c30f7442.camel@gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, Alex
 Deucher	 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, David
 Airlie	 <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel	 <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Date: Thu, 06 Nov 2025 04:29:05 +0100
In-Reply-To: <CAO=gReERBacxH6SjLrcCNcStiAzMosR=aW5D4W925CJ_yjzbhA@mail.gmail.com>
References: <1043551.1761844832@turing-police>
	 <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
	 <1296761.1762045181@turing-police>
	 <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
	 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
	 <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
	 <CAO=gReERBacxH6SjLrcCNcStiAzMosR=aW5D4W925CJ_yjzbhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 19:24 -0800, Amit Dhingra wrote:
> On Thu, Nov 06, 2025 at 03:40:52AM +0100, Timur Krist=C3=B3f wrote:
> > On Wed, 2025-11-05 at 18:34 -0800, Amit Dhingra wrote:
> > >=20
> > > >=20
> > > > What do I need to do to trigger the warning?
> > > >=20
> > > I have the same problem.
> > >=20
> > > linux-next on Arch Linux
> > > GCC : 15.2.1 20250813
> > >=20
> > >=20
> > > Steps to reproduce the error
> > > - make mrproper
> > > - make allmodconfig
> > > - make drivers/gpu/drm/amd/amdgpu/
> > >=20
> > > Turns out its due to randconfig, See [1]
> > >=20
> > > Setting RANDSTRUCT_NONE=3Dy seems to stop the error.
> >=20
> > Can you please try and see if this fixes the warning?
> > https://pastebin.com/raw/b8j3UABj
>=20
> The patch above defining all fields seems to fix the error.
>=20
> >=20
> > Alternatively, if anyone has other recommendations on how to fix
> > it,
> > I'm also open to suggestions.
> >=20
>=20
> What seemed to also work for me is to defining the struct as below
> without an initialization.
>=20
> static const struct stream_encoder_funcs dce110_an_str_enc_funcs;
>=20
> Its static so should be initialized zeroed out. objdump shows correct
> size
> allocation.
>=20
> objdump -x dce_stream_encoder.o
>=20
> =C2=A0 0000000000000b60 l=C2=A0=C2=A0=C2=A0=C2=A0 O .rodata	0000000000000=
130
> dce110_str_enc_funcs
> =C2=A0 0000000000000a00 l=C2=A0=C2=A0=C2=A0=C2=A0 O .rodata	0000000000000=
130
> dce110_an_str_enc_funcs
>=20

Thanks! This looks even cleaner.

I will submit a patch to fix the warning next week.
Can I add your name and email to the Suggested-by tag?

Thanks,
Timur



>=20
> > Thanks,
> > Timur
> >=20
> >=20
> > > >=20
> > > > Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=
=C5=91pont:
> > > > 2025.
> > > > nov.
> > > > 2., Vas 1:59):
> > > >=20
> > > > > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> > > > >=20
> > > > > > Can you say how to reproduce that?
> > > > > > I use the same version of GCC but it hasn't given me any
> > > > > > warning or
> > > > > > error for that patch.
> > > > >=20
> > > > > Upon further testing,
> > > > >=20
> > > > > [/usr/src/linux-next] make
> > > > >=20
> > > > > is sufficient on my system. Turns out that it errors out even
> > > > > without W=3D1.
> > > > > My
> > > > > next guess was that it had to do with -Werror, which would
> > > > > cause
> > > > > warnings
> > > > > to
> > > > > be treated as errors, but my .config has
> > > > >=20
> > > > > # CONFIG_WERROR is not set
> > > > > # CONFIG_DRM_WERROR is not set
> > > > > # CONFIG_DRM_AMDGPU_WERROR is not set
> > > > >=20
> > > > > Do you perhaps have patches in your tree that aren't in next-
> > > > > 20251029?
> > > > >=20
> > > > > I wonder if Fedora's build of gcc 15.2.1 is different somehow
> > > > > from the
> > > > > build you're using....
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20

