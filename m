Return-Path: <linux-kernel+bounces-831399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CAB9C8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B933A1692C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A729C323;
	Wed, 24 Sep 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbhgHDVj"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320E29AAF3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756434; cv=none; b=cdviFPGC5cXf9pVd7B0Wx8I/eQpfv6hG3BtJjoR6ddJWzEWSMcxL4XJH1/I3XaYd24u5Ksu6N560Bw9gLLeZQ4MYT3bHG5Rt7oewjW4KLztRcxT2uTmm9pQVi87cMrorQA4+hssPpZFSgSmLMyQOgPkrxxz+PbTzkjUiOFg9BWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756434; c=relaxed/simple;
	bh=aZMEXqSD7qikQnZAEvsbMzCNRClzhg7hU7B4cCBC+7U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAt93xAnrbwoZUIN9aOWCirkZXDb9Tn2CyOfAz5JP68P6g+evboOOeN8PA4qS4ZbSSttL/8WwvRsCRXyWvF8dqqhIaec7xk6bmOxtaCVgg8/TuoQ+AuLK+Dg/gJ5fo7XiQr6ktNZoY9XQfSmreG0GoAgy5zb82xpemdop9QvUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbhgHDVj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5515eaefceso362596a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756432; x=1759361232; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ1sgli7ptqR62/CrqjdmqyeswCTgFuJHQ9m7NV2USY=;
        b=XbhgHDVjpswwki8nIl9OL3iWvxP0Ic0CcK8PzdoyHgB0cvWz17hhn/LyzhhZOj44tV
         0WPj6BHTzyl5vjsDz9iLkzDk5ovc8LakL0DRUN8sXDwXYedKzXVMbKzk1Eih13maS6sV
         92a5fkz3l9yJLoWqtfhWMFc3yYabN4YeX5W1kit2qbPJ7xcICp4PWTRckyjpiWF3W+G7
         1qjBttQdAQD+/dvCgbWCgAQQ3TEY3KQimzRUzYoMh/aHGlUaVtXe/9+HttphFRvJ17Vp
         nzEHKyVPaqqLLrzZ4rYfnZ14yhH1fdT6P9bC1+SfV1xKsINU02boWSB+4swOdodrlkuo
         unlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756432; x=1759361232;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ1sgli7ptqR62/CrqjdmqyeswCTgFuJHQ9m7NV2USY=;
        b=r4mcohFgO0tpsY7fNmduXXDBP3wVnrzMTqg6DUXPcDb6mE9vSeC22vygGbyI90qTUp
         GtZB9Ib1m8tzJ+b9hy6XHgu8KPQZZyXGNQdUkiPK/sEkUR0a4n+qdhJjpkBrqj0WnXCP
         pgejAxMi5UgOWCm8OgtLstmjmUpE72XO7jy0wZYGHMqNSw2wjdsBUrIVM5iQaYxB78TS
         gLmlapZaUmyUYeCjMFxBILoj+0Q7LyROqIj98WiEVgoqknBHVj6xqvm2SdThHAA8bjXh
         aF0Hnpr/9TTGaCF87PVGJ6naEymQZe08P9S7o6hY+vuLHdgMntWj/9cOP40IRjcy8qiZ
         rfPw==
X-Forwarded-Encrypted: i=1; AJvYcCU5djx/AQivi5JYf4cfknjB4wkkyyOkeG8MsPjOtW8ARu+F0Kra+f4xz6re6XJ1ws4zjwA4iKgPFrFMo3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcVUU9NCL21PZIb3FX3Mld8UCnkcgpB/yb41OTnS3smYHHfiN
	PAgjfUJRr5103COp4SSm4IsFLoQiN+BBcmGPkz3Q0JLwg5qaKcMyvOxE
X-Gm-Gg: ASbGncv+Iz/o+5bImR5c1cHwErdJF+PDGKVJEvYzGNO7/T6nkaZe1Pcjq4KxIKKpSO+
	TBOXG3ADa+vFPG71b8zRsPSnWN1rBKg6QzPFyjwSDSrJurNttmYqiALzk1CvuHyWUEWsYa7R5lr
	AM7D+M51KpH3wXFI+D7nMfExYie7h1MPQvQ3YovigxINGhOiuEauZ6BtKkP9VYDoDiP0QMsgXBV
	YRMR1Qm0XQVyF3QGK7NUULaTqOcxmi2TeoSJhjMPZhNI7pJ47njMtgSOs/5//rNNq9LqoHd6MWw
	XbMgRTSiycod2+BQTp857vUoGQiZRlFQLPy6S/gq2TowQF0qXJjeW7eflPI+DSyZHRSpIR2ETtP
	OZrUuV5umseDvDuoGwYRU8Ij8AWa+PlzONZKwxdN4Qo/F8ADFVYaY5nUMhsfHrXY5amZ5Wd1qzr
	mB22xVYQsb+WVRCzGPmgoANg==
X-Google-Smtp-Source: AGHT+IH/KDLvQBQ7UfQ+ug7/uqqc5vZ4hRiu7RY+Ut1AjNGo+pZ/b3uV5AW21gKl38+5adHmTwsrgg==
X-Received: by 2002:a17:902:d507:b0:265:982a:d450 with SMTP id d9443c01a7336-27ed4a492e2mr13671305ad.40.1758756431589;
        Wed, 24 Sep 2025 16:27:11 -0700 (PDT)
Received: from mars.local.gmail.com (KD111238238118.ec-userreverse.dion.ne.jp. [111.238.238.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab64c7sm4012795ad.130.2025.09.24.16.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:27:10 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:27:07 +0900
Message-ID: <m2qzvv77p0.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: arnd@arndb.de
Cc: johannes@sipsolutions.net,
	geert@linux-m68k.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <b55251bf-625e-48c3-8c60-eb4f8358f397@app.fastmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
	<23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
	<m2zfak7mnd.wl-thehajime@gmail.com>
	<b55251bf-625e-48c3-8c60-eb4f8358f397@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Arnd,

On Wed, 24 Sep 2025 20:03:11 +0900,
Arnd Bergmann wrote:

> > currently nommu UML doesn't come with using PCI except building under
> > kunit (ARCH=um), but I have in my mind to use it under !MMU
> > environment, so would be an option in the future.
> >
> > and this series doesn't include PCI w/ !MMU.
> >
> > so, I would propose the modification to revert the MMU dependency when
> > time has come.
> 
> The reason why it's currently disabled is that it was causing extra
> work to fix build failures in random PCI drivers that individually
> have a CONFIG_MMU dependency. Since we know that none of the NOMMU
> boards we support uses PCI, this was an easy way to avoid work.
> 
> While there are still developers that care about NOMMU Linux
> and test it on the platforms they use, the NOMMU build failures
> usually end up in code that are irrelevant for their use cases,
> so neither the platform owners nor the driver authors care deeply
> about fixing that combination.
> 
> If you want to be able to use PCI drivers on UML-NOMMU,
> you can probably use
> 
> config PCI
>        depends on MMU || UML
> 
> so it will be ignored by the build bots on other architectures.
> You'll still have to decide whether to fix driver code when
> regressions in PCI drivers happen, add 'depends on !UML'
> to individual drivers, or just live with randconfig failures.

thanks for the detail information.
yes, when nommu UML wish to use PCI drivers in the future, I'll take
this approach to be able to use it.

-- Hajime

