Return-Path: <linux-kernel+bounces-728329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE66B026D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A505C227D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A721FF4D;
	Fri, 11 Jul 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj0ZnnpU"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90B13B590
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272022; cv=none; b=i0hwKTH4T0IsgPsbVXtkPAYpFZyZjsd+isWlQzAurZ2NB4cYHCFyYeadp9tS5FTFOS+NuddgCWCpBfjLIvJ4AtS8yrwHbKGER7Ml/uNveKqAExQRXF2Gw45LGRRWX/E2Tem/q2GymCKAsjikt4DN6AQBD898ATJyNgEVYjS76EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272022; c=relaxed/simple;
	bh=DV/Vih/DO7F+zd/SpqjFtPvKmIS6pOWu9mI2t3TLKL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okbq++drwHEm5zNMOpEUxpakFBqfLj+PTP+foPTWva4HfBYrKrgmI/ThEcRQgooigZ4CMmaPHiDfVFNRSGv0maPd1nocvGFXZHU4dRKRp/CASaBo60CYI8LCu4KfZ+nd+3i6feq8F1/QdkqtWp6eMCzgRTeX2QDXqdGZtEydXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj0ZnnpU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fac7147cb8so36244586d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752272020; x=1752876820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh0vMNxlPOeSMOhUf/BXn4w6B7Y4VFUfXRXP3fqqHI8=;
        b=Oj0ZnnpUtbreJJcYwMeANK2K1eY/A7HNzz51i7SFXkr1vQ4JemDQ0LBzuoX3HDI3b9
         8LqFmAKrzq4z0uSK2uvD6Nb3sznzqFNhmEeeTa29+FQOhplTBTbHD9q3WWxTc2UKDZds
         aGPZOqf+uvsudtmCmPQCJR+k7cr72Uhq1UY4Vem+zkaEwCdTCymQJTrCRMm8CNLWHLgW
         7zZWRw+uZq5I0x+N5++AzXlsCOLCUTR8mfNumQNF3PCOdsarl3xgQyEUmf3wMzkA0VGH
         fANTXN3OyPdscrNw9YKWoCSoSk4IBVpY2r7hnvYxw5ev9M9IdwvAcjS0BdTmboBz6tNo
         msOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752272020; x=1752876820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh0vMNxlPOeSMOhUf/BXn4w6B7Y4VFUfXRXP3fqqHI8=;
        b=blKQIdts9oIx3BizY79q41NwouWWE1gqPu3HA3RhsQXq16yWl6sYGSH3LYElC7iXgV
         2YCLVWxX5fteacY8l+TAqbrsXgdCok6LlTrlGKrwoQzhdpz7iQ9lIJkZhFjhMnU3P+KO
         Bd3bJ4UMlb8NtXlQYD2MT1F+1PBkV0bCcxq97n3xI0Bq4MhgA6I3iAY9VGo4n1oNSyJL
         TFyNbGk0nlh83zEfx/59RnuMaojTE/TTfwOJVr2GgvXEUxAtTdQfc+BGqkxXxlDZdS45
         Chqlw1nco5SblM8FOBaZJyzRxwSrmmYt1kSODLpJ6yArpMBGV7JRJaWMmD0iaoomklXK
         /oow==
X-Forwarded-Encrypted: i=1; AJvYcCU5ePlpZYkZdbjlqNyPN1tfo8fmP/kkJv542e9XCEAWP2QsR3w24hsqcb+PRjECQpdTH6aHz3/SgwMy3Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxEcD8f6qloVoj8ztN3iREPi3rWpFPsuO8tCYcZSFtLyWhYEX
	17fFG8vZZcd+PtGLseFj+QZj5PVarzW4xXw+C0JrkZfaFai4EmLr+wb2
X-Gm-Gg: ASbGncuNxI1pS5y3e73QB9umuqQPXgQZeaWJ9QouuPLSYlxgA0dMtClUeSyt9qS83Sn
	xlgyEabgsi3aTtx9KiHsb2oENlt5ZfXEdpMRUKXrhDsqDfyTmsMYFWl3u7pLnMd2sKqafYNncKk
	mZMv6fD6u92PYgYC2YVx3trtJaB4jEVogJAHu9hKaEF2Z5y6FNIinISNA2MolLQx9nz9RPtE/lS
	lXFguI3s/TJidnByWnT3QdqD9ld4eRgTN8aNEv8gapr6pIigO4Qp6+clImBsWHxsJA1NqhaMGTs
	ywNpRvfMSW/5c9Yn1rPI5QeJzA6akX48d5Byhf+moyCE+yZVd6mDcnIgDvfSwRqEv+LGxmoJDRa
	s2iHpyayZLnIibUHa9jqab/xeixkdO0bPl4r+oRF0ie0H0f8ZWJ2vjMNVI2xov8BAMAuBWtTcJV
	SOw+gXuE0mczWg
X-Google-Smtp-Source: AGHT+IG/5ZvbPKKY1+QnoEFUnpHg8GPFGq1MEgCqaFVOkk+r70cYHjelvIp8ZaBRKymAqBOgsvf6BQ==
X-Received: by 2002:a05:6214:e6c:b0:704:761a:13d3 with SMTP id 6a1803df08f44-704a36114c6mr91549826d6.32.1752272019895;
        Fri, 11 Jul 2025 15:13:39 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcd8ef047fsm266824085a.0.2025.07.11.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:13:39 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E712FF40066;
	Fri, 11 Jul 2025 18:13:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Jul 2025 18:13:38 -0400
X-ME-Sender: <xms:koxxaMw9G5ULlk6EimCMAthVnyNvKV5eCllVclpqS4dVErk-tS5oEQ>
    <xme:koxxaFwuuRytxHvwfr92hVTcqyWyGgMQdnXS8qlpzhg-FEojxIY8G4Sv-aJpVZhtA
    E63yqT0EcNDtZaHXg>
X-ME-Received: <xmr:koxxaNY2TkrMW0rUGpaBY30JI_5_DlS79sDI9Gr2GXa2tHIbTYV6twK9NVuq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtg
    homhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprh
    gtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheplhhonhhgmhgrnhes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheptghmlhhlrghmrghssehgohhoghhlvgdrtg
    homh
X-ME-Proxy: <xmx:koxxaO2qctPhMpQWAbZOS6kmF3b-fN7x4XVm9ATBCwIySWRn-bmaDg>
    <xmx:koxxaHczSniXEA-D7xbfteNWeHoZ1yTAQCO7lIG3auuaKDoxT62LDA>
    <xmx:koxxaDL1eAJWxeu5i3YTdf9zA9IC7eo-Y6Jv93Q8REq8VEVfbExpHg>
    <xmx:koxxaNrxUIV2dhLSl1Lz1VZVtiVZp_YqD_MmSdkJu3Sq8MUghQEKkA>
    <xmx:koxxaJvgohbGpwruV6YmjjGBvvQIn-tBgmWG3VQxgQY_oigFMFnVjuj->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 18:13:38 -0400 (EDT)
Date: Fri, 11 Jul 2025 15:13:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
	Carlos Llamas <cmllamas@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] [RESEND] lockdep: change 'static const' variables
 to enum values
Message-ID: <aHGMkczXH3zxugmD@tardis-2.local>
References: <20250409122131.2766719-1-arnd@kernel.org>
 <20250409122314.2848028-1-arnd@kernel.org>
 <20250409122314.2848028-6-arnd@kernel.org>
 <aBTQjnB8ej3z_van@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBTQjnB8ej3z_van@black.fi.intel.com>

On Fri, May 02, 2025 at 05:02:54PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 02:22:58PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > gcc warns about 'static const' variables even in headers when building
> > with -Wunused-const-variables enabled:
> > 
> > In file included from kernel/locking/lockdep_proc.c:25:
> > kernel/locking/lockdep_internals.h:69:28: error: 'LOCKF_USED_IN_IRQ_READ' defined but not used [-Werror=unused-const-variable=]
> >    69 | static const unsigned long LOCKF_USED_IN_IRQ_READ =
> >       |                            ^~~~~~~~~~~~~~~~~~~~~~
> > kernel/locking/lockdep_internals.h:63:28: error: 'LOCKF_ENABLED_IRQ_READ' defined but not used [-Werror=unused-const-variable=]
> >    63 | static const unsigned long LOCKF_ENABLED_IRQ_READ =
> >       |                            ^~~~~~~~~~~~~~~~~~~~~~
> > kernel/locking/lockdep_internals.h:57:28: error: 'LOCKF_USED_IN_IRQ' defined but not used [-Werror=unused-const-variable=]
> >    57 | static const unsigned long LOCKF_USED_IN_IRQ =
> >       |                            ^~~~~~~~~~~~~~~~~
> > kernel/locking/lockdep_internals.h:51:28: error: 'LOCKF_ENABLED_IRQ' defined but not used [-Werror=unused-const-variable=]
> >    51 | static const unsigned long LOCKF_ENABLED_IRQ =
> >       |                            ^~~~~~~~~~~~~~~~~
> > 
> > This one is easy to avoid by changing the generated constant definition
> > into an equivalent enum.
> 
> Any news here, please? The problem still exists in v6.15-rc4.
> 

Queued for v6.17, thanks!

Regards,
Boqun

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

