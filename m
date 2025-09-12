Return-Path: <linux-kernel+bounces-814167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59033B55022
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808251D6299D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BD030E82C;
	Fri, 12 Sep 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6EEAM46"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E230E82A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685486; cv=none; b=nerk6JBbrOzqOKRyOY1zLJKpETSNVyTHZGW0fNExmd1kLFqAaeW+1c3QNxweNqNXxZV5MMS/tUBimIWnoU46YgxwpYZ7YSriPd/oTWG1i4rhJaE1TCRfZwmxKRTIqI9uKMo4JZK/LNWoDKjQDrfbWhKAabhWSphv3h4Km2hqHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685486; c=relaxed/simple;
	bh=1Wus+tWWA1Pf1OLp0wzilv7Tpo3YFBFrKQ8SLrrvZ9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeaIa3+IvWQwhoyPRpYTmrGgZTePer+GvMNTdbREH5pTStaplDTfARjaKyDvV2QB77fHef8Yw0VmbzP3llC65BKs7L1MNtr7foOxtkgvo6r6Sn5eln1EOvHWokn43CTsEdJQj0tHM84d4sw23lFkaLeDIQjP6QFf+/WqB/waQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6EEAM46; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6231b2cbeaeso1226550d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757685484; x=1758290284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFxQ0Jf0nlGIKF7nmzUolG5JBu/RkrzE8T9acMd7qhE=;
        b=O6EEAM46NWME2OjbihlnrS3IE2Ya/nVM4j2JS48oUidYA+usEsJWXHaFvbs7C/qOfK
         ETL/NYKdIJNG8ixNihQWH13IOirrfdytr1sRo+VL/ta1Or789BIt2pXe+tDKV54KBXo1
         6za3WbaZTlwNBgT8U1pEOahwlqRORffQIZjuK3exsK5An20+3q4gRzWbh11ZEYU5V1ML
         QtNPC/jZZRkVqpzTqYf6VBCyzjftNZfNWCL0CRI8b5tiqcGYcT5567xS6HMl7LaxqZgd
         gixOSL2hYU+LrE8TAD8psmWoXbg3V8wJz+ZD02cBI3AorKl4rKRzmw0TSI4/elmHXKSx
         9k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685484; x=1758290284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFxQ0Jf0nlGIKF7nmzUolG5JBu/RkrzE8T9acMd7qhE=;
        b=xS8uFg65ZPzPaSQuoiiv/QxTa8w5KvNywvbzc7HbFHoJ4zjY6ZmBLgAODRVxSBDtEt
         rTZtkk44n8QUWN09V4wK3o/BwjwGeyJswptNfMTspS/Jsb6ugMbhejzgRJ1ReyFTpXz+
         dqCw6GKIttfNT9KjGoj+nqzXxSMwb1JdFzhnUYFVMp41hqucEFcIYnHr4ky8MA0PgY0h
         OjNBSU70b3Yb+mNOs/PsGZOqPKJ/8eAPzGTwltgILaGA7GzhDT13d/Lj29q6vLSHADZL
         SiIQ0+Cjn1rePSdcR2eyBo+ZX6FPTrMMsK2rfXTsBj52xaSiR0XRyzpWefJZVCtE5Hw9
         vLPw==
X-Forwarded-Encrypted: i=1; AJvYcCWEA/aoVdmCUZjXNuFsuCkzrNs5DiwPIT5EN7hg2Af7OHYojiQgeoNH0SCKQZUV60M1qhRNZLN3veBQZ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEUe8cPIFULewrKzZSk8Cdnfi4mPd3u05VEPSX+xoul7BYwya
	FjGWpQx7bR+4mtSM5qM36225QDqpl44ldCO54DRU5LGbPhxr8JlO9wOaR9EHLMgXsg7KQz/TjHk
	zeRDC71I6NETXFjmNluly0L1o5Bkhb7LuyX58f7aE4w==
X-Gm-Gg: ASbGncv050RVRKxt7K/3f8cRF34mg/csKI33U/cc1cNEefG3B6TiGIxKRABcnYH9pKU
	tQvqwe0nMvk33YElgfqglhXR0NGfl9ZSY6XhZQJ8T+kUDUcdSyi2Cx4TclYdgabpaKSELKsc2Ly
	vWsnXLJL7HhFXtk7T6E30yRncznmp5eJ1Cn4v5m1JKIuQ68UjB9dec8GmpnjhdymZlnW6iGGsap
	rrQs/EeyNH31bvEB6Q=
X-Google-Smtp-Source: AGHT+IEH8qYUI4aIsgMP7hJ6RvYPpHw88cdHgQhN4wdhQY9BX68X+IeqNrxdkl8XRpaStWVYV7GGoVNWRyW4cNyOGog=
X-Received: by 2002:a05:690e:1542:10b0:5fb:54a2:9cbc with SMTP id
 956f58d0204a3-627234f5d09mr2498019d50.19.1757685483801; Fri, 12 Sep 2025
 06:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org> <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
 <7hldnp6apf.fsf@baylibre.com> <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
 <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
In-Reply-To: <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:57:27 +0200
X-Gm-Features: AS18NWBDU2F_Z1dm0rgVpNYpankFj315zLiLW4hs9rqLkP4wevoYC_ZQ6_7pf3o
Message-ID: <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@baylibre.=
com> wrote:
> > >
> > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > >
> > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > >>
> > > >> Some platforms and devices supports multiple low-power-states than=
 can be
> > > >> used for system-wide suspend. Today these states are selected on p=
er
> > > >> subsystem basis and in most cases it's the deepest possible state =
that
> > > >> becomes selected.
> > > >>
> > > >> For some use-cases this is a problem as it isn't suitable or even =
breaks
> > > >> the system-wakeup latency constraint, when we decide to enter thes=
e deeper
> > > >> states during system-wide suspend.
> > > >>
> > > >> Therefore, let's introduce an interface for user-space, allowing u=
s to
> > > >> specify the system-wakeup QoS limit. Subsequent changes will start=
 taking
> > > >> into account the QoS limit.
> > > >
> > > > Well, this is not really a system-wakeup limit, but a CPU idle stat=
e
> > > > latency limit for states entered in the last step of suspend-to-idl=
e.
> > > >
> > > > It looks like the problem is that the existing CPU latency QoS is n=
ot
> > > > taken into account by suspend-to-idle, so instead of adding an
> > > > entirely new interface to overcome this, would it make sense to add=
 an
> > > > ioctl() to the existing one that would allow the user of it to
> > > > indicate that the given request should also be respected by
> > > > suspend-to-idle?
> > > >
> > > > There are two basic reasons why I think so:
> > > > (1) The requests that you want to be respected by suspend-to-idle
> > > > should also be respected by the regular "runtime" idle, or at least=
 I
> > > > don't see a reason why it wouldn't be the case.
> > > > (2) The new interface introduced by this patch basically duplicates
> > > > the existing one.
> > >
> > > I also think that just using the existing /dev/cpu_dma_latency is the
> > > right approach here, and simply teaching s2idle to respect this value=
.
> > >
> > > I'm curious about the need for a new ioctl() though.  Under what
> > > conditions do you want normal/runtime CPUidle to respect this value a=
nd
> > > s2idle to not respect this value?
> >
> > In a typical PC environment s2idle is a replacement for ACPI S3 which
> > does not take any QoS constraints into account, so users may want to
> > set QoS limits for run-time and then suspend with the expectation that
> > QoS will not affect it.
>
> Yes, I agree. To me, these are orthogonal use-cases which could have
> different wakeup latency constraints.
>
> Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael would
> allow this to be managed, I think.
>
> Although, I am not fully convinced yet that re-using
> /dev/cpu_dma_latency is the right path. The main reason is that I
> don't want us to limit the use-case to CPU latencies, but rather allow
> the QoS constraint to be system-wide for any type of device. For
> example, it could be used by storage drivers too (like NVMe, UFS,
> eMMC), as a way to understand what low power state to pick as system
> wide suspend. If you have a closer look at patch2 [1] , I suggest we
> extend the genpd-governor for *both* CPU-cluster-PM-domains and for
> other PM-domains too.
>
> Interested to hear your thoughts around this.

Hey, just wanted to see if you have managed to digest this and have
any possible further comment?

I can totally implement the ioctl approach, but just wanted to make
sure that is the direction you think we should take.

Kind regards
Uffe

>
> [1]
> https://lore.kernel.org/all/20250716123323.65441-3-ulf.hansson@linaro.org=
/

