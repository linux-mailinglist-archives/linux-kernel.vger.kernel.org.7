Return-Path: <linux-kernel+bounces-832185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF2B9E959
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129C04A1495
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E802DE1F0;
	Thu, 25 Sep 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFfQXCjf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02011502BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795195; cv=none; b=Ksjn7OMdsE9vYUISz/R/B6DNpE3PAP676AB/Oj9I/ZPs20jQ4Bkc9/inqJ5Y7DkSGXz548lJxmk9Y9afkvJkbG+1kEOWMlxN/WTC9OO0qcmKyWdla22XDhWvuymZUMCyLuxyAsDn6Ls1iUdsHuBz/CtcgsHtpItt6CJZDB5hQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795195; c=relaxed/simple;
	bh=HmljixeQc8xgr6LVqYOS1SBQvDhtnhXHQXUSYqpft9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfubHLYt7MbFCv54crk8sh8KZjfHZpzy3Kd23G8OkZCiK2TyaKF+JYxGtuMr7XgWyFOCP1CmwZKBi4tgjdJMxzoQzp3b2/opleHRsnbx1AymWNh+HeyquT8ZrmKpE/0MjCBlX8MJ8rLRDgIRIzbejQE54df3wX5bFenzecvlymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFfQXCjf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so3767555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758795192; x=1759399992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmljixeQc8xgr6LVqYOS1SBQvDhtnhXHQXUSYqpft9s=;
        b=NFfQXCjf6etA9/+U2b26pkIqP2Av9aJ+9uNI4guStBKsK6XO8y6mgBEd+YCNokqtj9
         nhy4klZb8xQswIqn5O7hwGbR7bUCerniOBI1FspJ1dOhXEDeJ6GB7M8lc1AbSGHojr10
         9o5sS0kUoErTWsnv4gLh/g9MvtVRsmYuRs4umwPhXYSxmhMhUzytR3Q3KNlztiBEwOpZ
         p6PqA6h1WTipyig/I6ixlTcJmZg08eQS1yPw963ZspnHLuIUFHK1+p0aSUsaSJ6kp1As
         0WHvaPyx2q8so6NhzUX56mLXYettjds50Lgj0QXjep3pvnBuzFKykxAH3TnvfWFbymYM
         3njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795192; x=1759399992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmljixeQc8xgr6LVqYOS1SBQvDhtnhXHQXUSYqpft9s=;
        b=XcCVD1WrxzaGdy/Jjo3N1s0V5wJRS+cbqiFDfgFiFE2oOzpSKLdA/JlWF2nv58IlD+
         YifxSi5BapQQ7swcye5JMDVKO5OSbJgbxxilG54gNVtOzj8Z7nxaLhnPVjJjog3iRVi7
         AjbgxNcTZEOFTl9Y4ro/Njihes5EHul/lI+W7JfzA39Hh1ItY3OkS/b14DgtWsWftx5+
         AT5Kew+OinjMuWSt2QB29anZlL22+CIOsp1mZbvCqw3PzUvOqSeRS8WH+BMA3AYcjUQC
         gw9Qg/VpPawunj1PZKSKAaZM4Bc0Pi1bHqv6Ozxg2z4SXNgsbi+SyeAsZ58wLl553pSb
         MTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMAgVeQL2Up13Gfu9EPpIIubLI8xuKNDNSNdp++fkD/K0nBj4vXJ6wwcJnfOtJ4GPxBG2JIIUP7oHty40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnnpCeMkwwMbISVRNsrQunTfE6Vu5BKX7mjtZjYjvQQC/xJZfU
	ubNp7z5REoX/q1ExogauY+fOcrjxSQJDTHTAHS/Jn9c0wGJc8kSPLfSQ
X-Gm-Gg: ASbGncuFqYfwoSgL/uukqNaRuPEdQTsTBsz3CUEVPAyL+3//tu7kacQHLi3hMKvC7n4
	9Li5+4KLpIOhC32MsyJmU5WcaAD3JRkVdavNztZ8B/vKBIjPyG9VYPT8u+Axc/3X2osaV3Q4UHi
	bT8KkNht01y7JQjf4dzKBC8r4GyZQjUMyhow5L3YdMSS2O5FnhZ+17pcNMQyg70OaEAwoYCgRUF
	uGwRBMAuKckzoldq3W7eevunY59KTdxpWbpIjyrjunYVqGNg0y4X/HLfC4jYtF/P3wR4iODa9fa
	4uJ6tJ89Z3fMGx9OYaEiuRSpD9yamr0QfNatXXxZQkIVBk8Pi+4iI7RkHEVimDRVcLTZTga7bac
	P86O9lynUaY9TG9U7q6RPROQN97xqM5M=
X-Google-Smtp-Source: AGHT+IEC57Rdx2+h+FGeZVFTjH1ezVMChuJ93kmZqX1ZaXIDR/t+6gNu7QdgglKgxzNMt7eo3aLEiA==
X-Received: by 2002:a05:600c:5d1:b0:46d:83e7:45ec with SMTP id 5b1f17b1804b1-46e33ca94eamr14208235e9.11.1758795191990;
        Thu, 25 Sep 2025 03:13:11 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9768bdesm2438865f8f.23.2025.09.25.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:13:11 -0700 (PDT)
Message-ID: <ab4b09ba3a332305f5e1e9d456acbecdb492bd85.camel@gmail.com>
Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Manikanta Guntupalli
	 <manikanta.guntupalli@amd.com>, Jorge Marques <gastmaier@gmail.com>, Arnd
 Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jorge Marques	
 <jorge.marques@analog.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Frank Li <Frank.Li@nxp.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, Michal Simek	 <michal.simek@amd.com>
Date: Thu, 25 Sep 2025 11:13:39 +0100
In-Reply-To: <91e73a29-96e3-4a52-addb-0cb954f46c04@app.fastmail.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
	 <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
	 <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
	 <37d47af4f4d5220764efc5870630fdfc1e9be2c9.camel@gmail.com>
	 <DM4PR12MB61093CEE50990ECC403D3FB98C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
	 <e5a6789230840b31ef0f60ca0a770a4fb266da2a.camel@gmail.com>
	 <91e73a29-96e3-4a52-addb-0cb954f46c04@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 11:35 +0200, Arnd Bergmann wrote:
> On Thu, Sep 25, 2025, at 10:58, Nuno S=C3=A1 wrote:
> > On Thu, 2025-09-25 at 08:47 +0000, Guntupalli, Manikanta wrote:
> > > > (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
> > > > On Thu, 2025-09-25 at 07:37 +0000, Guntupalli, Manikanta wrote:
> > > > > > i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
> > > > > > On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> > > >=20
> > > > I would argue that's something for callers of these functions to ca=
re
> > > > about.
> > > If each I3C driver has to handle FIFO endianness individually, it
> > > introduces
> > > unnecessary duplication and overhead across drivers. Centralizing thi=
s in
> > > the
> > > FIFO access helpers keeps the logic consistent, avoids repeated
> > > boilerplate,
> > > and reduces the chance of subtle bugs.
> >=20
> > I mean, that's what spi and i2c drivers do already.=C2=A0With enum
> > i3c_fifo_endian
> > you're already forcing users to care (or know) about endianism so they =
might
> > as
> > well just pass the data in the proper order already (not sure if it's s=
uch a
> > big
> > 'burden').
>=20
> Can you give an example of an spi or i2c driver handles a similar
> situation to the new i3c driver? As far as I can tell, swapping
> the bytes in a FIFO register is very unusual for a hardware design
> and probably a mistake rather than an intentional decision.
>=20

I meant that i2c and spi drivers (and I meant on the device side) already a=
re
the ones having to care about putting the data in the proper endianism so t=
hat
controllers don't have to care (AFAIK).

But I so see now that the above is kind of unrelated.

> On the other hand, I can find drivers that are obviously wrong
> on big-endian kernels, such as Tegra's i2c_writesl_vi() function
> being unintentionally swapped from i2c_writesl() on big-endian.
>=20
> For the i3c helper, I think Jorge's current version with my
> fix should work for every normal driver, and I would not
> want to make it more complicated for an obscure case. The
> version for the AMD driver can just be in that driver, or
> it could be a separate function name in the common header
> if there is a chance we'll need it again.
>=20

I do agree with the above.

- Nuno S=C3=A1

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd

