Return-Path: <linux-kernel+bounces-727922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD28B0217B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171E816332C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45DC2ED156;
	Fri, 11 Jul 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoKLZ4OF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3823C30
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250621; cv=none; b=Kn5BRQixUf7raupJ994dvIT8/oN62imksawa7lNKaELQu27FPcX9urbm9/IQ0vt9pGSaVdM7IKdW7pt5V55WhV5R2zU382K/OigN94MaVnVKvczSm+8Qf8iep+3u+2xdSQOz8qZbXPS+f1G9PBVaUwTciJoXPl39jzdY25aSlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250621; c=relaxed/simple;
	bh=N69y6RAWrW+VLoFuLAUhgQMkb1DzeOqb/BwKA2ls4OE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NyeZTMUTf20qpP5lVCyjpj0xlEbu5vdmtYZbemY9nG7gCZiDxuPNH4lPSEPLPuIpaOPr4rvLwyz5GyUXx5VV1jGzabAzILgxQ10Aoa5nfTUBdurr/hvbdF8TZMrvGWkFepSw5zt4Eit/+XlrP7nUOcPx8zGsesDrtWZx7TwN3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoKLZ4OF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752250618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N69y6RAWrW+VLoFuLAUhgQMkb1DzeOqb/BwKA2ls4OE=;
	b=RoKLZ4OFcfhBr94zAZfm2sS2onqnBh0R6kiKcQhWP2A/dUrFz17fQhl9383FWiIqD/xxjJ
	DjOR9eptQLVYDSj3E57QvOP9/Qwh9TNvctnH57TJ/NBARBOhc1zgvd20bBraZyloHBHJKK
	XLH2ycebQPuoj1OfQV5JY3lmLdUhBLY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-ew37sK7wN6OE6QobrxRoKA-1; Fri, 11 Jul 2025 12:16:57 -0400
X-MC-Unique: ew37sK7wN6OE6QobrxRoKA-1
X-Mimecast-MFC-AGG-ID: ew37sK7wN6OE6QobrxRoKA_1752250616
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450eaae2934so17122775e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250616; x=1752855416;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N69y6RAWrW+VLoFuLAUhgQMkb1DzeOqb/BwKA2ls4OE=;
        b=f4PdldAO5n4oCg2LUUJtVF5bCXMh+FqaO567EQTSMq1y6/DYRKidzKKBiOw14wGonn
         9DqZ6OCY6IijFSj+gG44BeVjbC7Kaz0cS+H0Yb0iphAJcFbdqDekq2jADdp14UUseCbi
         6pNTnkoTJ+SR0EDXE6JXJzsn8FtluW5SLSjRiy1IGYol9pReh6zwsbae3CHb6hQLM2jk
         I4MZVNe0ntlPpD7Ebwf8vXUQR/JcDjGtknT1SPnyiI2oquT5Hw/S+uNZiwajjRAzT8f3
         +6o4p6nT8lZOQYOP2ROW8MmbEA7shEjFDGMp0JIOxvnF7oQbvcLhFMurEp4RT1f6v0U4
         i8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUOi/ajEJE3PPzCpSemtTV2/pGZbfgwYYQr+A5iK3/1xI1HCQ+zBQsMTLzADjrE8pKNRoK1HCBmTI5Nbu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrnIAQoT7DxEkk+5u4TL6M3QYaCyvY5svH6SGgU1FK4wdpVPU
	+nmj9MKJGH09gsT2g4HRXAAXAWOQWS86V5x2Z7Y+1H/JWZFz+kXaq2b1Lwr0FywSxlZHU9E9p+z
	q9WJbaDCXeCiRoePybGFUIE3uBLCw8hBrKpR/lyqu4nz7trehYkcf8wnmh/IG4JKKAg==
X-Gm-Gg: ASbGnctoZDnXor0noNt7W/hq2GFDh+EUeygugnE1IksmWXnD/e85cfsBL0tB467gzyL
	tXWUBEPaQEfelNtoOoo9xVEAaBDjRAJSgzta3ZexrFvnt3Zu2CyH1PJsoUJmWZSeIzrNFk3ooXG
	eS46ngj/GojXfZwl5Xs7a3mah2OIAqpsL2k27y7aSEqI69TeL0AgqPT22mnzczlQiIs12ZjsiXI
	aVK9XFZ6kdY8I8g/qCbYzL+8zwL/w+iMEvAJOSkBAzXN1KyabOCeN8BkwnLSM9NfYHoiFHsxc7K
	b7dSEv7MbBc8t20aCj80GPMaN9tMuNsaFxgkGJtW6ZuMKvJwSrcYtO6Fz04ZFugeACmRdnqmShl
	Nt0GDHj83rTnlFhPEtAF2mzDl
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr36001705e9.18.1752250615711;
        Fri, 11 Jul 2025 09:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqKqz+Nwu7qwpmpBJkgzK4CfoTHj5MeRmnd9QnXmnsCEbZD4jDrigJcYLQOC87BIdZzV/wAA==
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr36001175e9.18.1752250615191;
        Fri, 11 Jul 2025 09:16:55 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4cbsm4924805f8f.50.2025.07.11.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:16:54 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Li Chen <me@linux.beauty>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Sohil
 Mehta <sohil.mehta@intel.com>, Brian Gerst <brgerst@gmail.com>, Patryk
 Wlazlyn <patryk.wlazlyn@linux.intel.com>, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Li Chen <chenl311@chinatelecom.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Tobias Huschle <huschle@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 Joel Granados <joel.granados@kernel.org>, Guo Weikang
 <guoweikang.kernel@gmail.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/4] smpboot: introduce SDTL_INIT() helper to tidy
 sched topology setup
In-Reply-To: <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-2-me@linux.beauty>
 <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
Date: Fri, 11 Jul 2025 18:16:52 +0200
Message-ID: <xhsmhqzym1z4b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/07/25 11:20, K Prateek Nayak wrote:
> Tangential discussion: I was looking at this and was wondering why we
> need a "tl->flags" when there is already sd_flags() function and we can
> simply add SD_OVERLAP to sd_numa_flags().
>
> I think "tl->flags" was needed when the idea of overlap domains was
> added in commit e3589f6c81e4 ("sched: Allow for overlapping sched_domain
> spans") when it depended on "FORCE_SD_OVERLAP" sched_feat() which
> allowed toggling this off but that was done away with in commit
> af85596c74de ("sched/topology: Remove FORCE_SD_OVERLAP") so perhaps we
> can get rid of it now?
>
> Relying on SD_NUMA should be enough currently. Peter, Valentin, what do
> you think of something like below?
>

I remember asking myself the same question when I mucked about the SD
flags; I ended up convincing myself to let it be but I couldn't find any
note as to why. Looking at things in their current state, I agree with you,
we could just bin it.


