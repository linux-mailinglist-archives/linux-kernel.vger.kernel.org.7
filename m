Return-Path: <linux-kernel+bounces-842938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E08BBE03B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AA034E4849
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650AD7080D;
	Mon,  6 Oct 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzVkgaso"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060E6ADD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753407; cv=none; b=TR8/TOgyH7IW1wGrcrcXZYILftoeuIM9KkgT28sSNBJfvKdOXlr6jqcWV1vKKODSSrfbpXIo3uAFXMhXPUqwRjPQydoXQ4AFtyjF9Ce3u8z8hTjqcWudo4SgaU93Hv7R6JaUn8S/7a4oz3oaFmkhr808noXB8KGezEXaZhvBchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753407; c=relaxed/simple;
	bh=XhPKKZ+qLVDcEGkmaBKKeLZU4bI38h/0RXwXpIaRLSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+FKxXDca8seHJn5JGxFZDzV81uJVn7NV40YIgGaQnWSb4e43n2kbFKOuNY1e+g5dgG2e1iXLugsjvLEQJ5zh2JhByejN7BdavHbkgUg/kL1k9Islt18O0CfpryxJyg++1sLB3dx7MJSuWD6y7IvgHDgryRl8iUYiWvC0K8dTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzVkgaso; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60504bf8so48905137b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759753405; x=1760358205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azz9O4mUwwwsxG7mSBpJ+zeBvEA2Nl0F6icaY3vg3+s=;
        b=tzVkgasoeNABEGjycNgI13q+p20/nCUiBQkzgyC5nB1L98da+0KoGPABkI/eBpqupo
         noNlVXskyPcdStqiOrSEOcXx+841/gYQlb7VGJH8BzUh9KtvNSKGp9N3BIrMsKOMdrgp
         IWtfKZn6O2Vsyw5JTZt5ej5CcSjMB57bGKnkQVYhNCC8kVpDInMk9gaKaoBIwb7HD504
         5ZVMrye10z2TkLxuErUVInsrUbLXsMP3yjJ0NCdmmtK/7RrPE0ghW3w3PLX7pmbRl6x0
         P44Q0A8hGXl5W0HzDnExvQ9pr2JoRgxSBqXAxjtW/ZI/R6qnNb40xQtY/twcTtiJ+0Jc
         CkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753405; x=1760358205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azz9O4mUwwwsxG7mSBpJ+zeBvEA2Nl0F6icaY3vg3+s=;
        b=uXWXpzAIo/iEfqvYyeAMrM5HnbIK0HXF/togiJvHsBxllF/aWhL1/tWU1eZ+2Erjhn
         DGqwk+npVGJc4lxNaVLGxmk+AewXFoY9t0gHZVPd8zkuKiS8duRGmZc9d68jND1a3dju
         VbcKTnSXHST/BUUr/t5Bnvn/3lMpg8yFYIjEPvNUGreRtg0g62Dywz00G+jNTQvh3ytc
         6F4jTTrSmm5JykNxNSEIik7j+uZJdewiQEKUGwiGv1Chb4yPbayG2EGcKqbm6s+HvMYM
         jyxYXrD2ju0VbOfqrK7dkfzv1NDytmIxajx6zIlo+lQ0Z66hxkN8ZOs7it63rQ0cDBAU
         gA7A==
X-Forwarded-Encrypted: i=1; AJvYcCXCWhUZxIlgv/5cSCBZ1X1z1xrDBI1fT2bl5aOZHg5kC/AjenUgyqFAKWwBOuTCXo69NzmmWAFPizRKoV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfXqmaRjMuHCNr+SaYdAGHebZSjJSs2MeyOhz28e8qMpXDuvL
	oFWCNfYmbwYFodxWMMEpczm6QrYE1UDFvechWI6k3FOleZmC7X3IsZaBrC6hKLBkPVF5APCn1Nl
	GvX0LxMiVZJr4OgcCvL68kH/i+ATMJUNdjassUavRiA==
X-Gm-Gg: ASbGncuPsHsqWvDePkc/Em5oWox1XhUcroIVpYw5zj23VGYLAVpd+eO2Ra38hT6JNgF
	Y37jqFiMwixUptXmtPfXKbBJz7UxXWKoBXRx7DiYe+itVhsfi8dRcJwyq6NrpcoArST88gwwKWJ
	2qpR5t3aoyiTPa51ZtacREnHP1fCwhc1VX0PyD2AP3pWrTDsOnIZT8bERIRQGWQ1vpynxodO/wm
	HGKV9s8n6tNAoXIAbmTrbH29xefcZle/+shOM7h/f7/xw8=
X-Google-Smtp-Source: AGHT+IH2DWL1rMufHJoRTaOEsDQX80kfcKh2Smoz9/7LaEmtgBq0ndRVK0/fgAr61uabtKnXzQgGo5LH2G/ebFNXG8o=
X-Received: by 2002:a53:a006:0:b0:636:13d5:6968 with SMTP id
 956f58d0204a3-63b9a07802cmr9764799d50.15.1759753404956; Mon, 06 Oct 2025
 05:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org> <20251006-manipulative-urban-antelope-31101f@sudeepholla>
In-Reply-To: <20251006-manipulative-urban-antelope-31101f@sudeepholla>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 Oct 2025 14:22:49 +0200
X-Gm-Features: AS18NWCQYiaPlcdiDQop43x4w0EDfpR_gEuiAFidF0pHvlZI8_2qX-prnyesMvw
Message-ID: <CAPDyKFoz4P6cZWNA-omNtF3XqKKciC07aVXBTVQp8ueyyYxmxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 12:54, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 03, 2025 at 05:02:44PM +0200, Ulf Hansson wrote:
> > To add support for keeping track of whether there may be a pending IPI
> > scheduled for a CPU or a group of CPUs, let's implement
> > cpus_has_pending_ipi() for arm64.
> >
> > Note, the implementation is intentionally lightweight and doesn't use a=
ny
> > additional lock. This is good enough for cpuidle based decisions.
> >
>
> I=E2=80=99m not completely against this change, but I=E2=80=99d like to d=
iscuss a few points
> based on my understanding (which might also be incorrect):
>
> 1. For systems that don=E2=80=99t use PM domains for idle, wouldn=E2=80=
=99t this be
>    unnecessary? It might be worth making this conditional if we decide to
>    proceed.

For the non PM domain case, cpuidle_idle_call() calls need_resched()
and bails out if it returns true. I think that does the job, for other
more common cases.

Making this conditional could make sense. Not sure how costly it is to
update the per CPU variables.

>
> 2. I understand this is intended for the DragonBoard 410c, where the firm=
ware
>    can=E2=80=99t be updated. However, ideally, the PSCI firmware should h=
andle checking
>    for pending IPIs if that=E2=80=99s important for the platform. The fir=
mware could
>    perform this check at the CPU PPU/HW level and prevent entering the
>    state if needed.

I think this is exactly what is happening on Dragonboard 410c (see the
stats I shared in the commit message in patch3).

The PSCI FW refuses to enter the suggested idlestate and the call fails.

>
> 3. I=E2=80=99m not an expert, but on systems with a large number of CPUs,=
 tracking
>    this for idle (which may or may not be enabled) seems a bit excessive,
>    especially under heavy load when the system isn=E2=80=99t really idlin=
g.

Right, making the tracking mechanism conditional sounds like worth
exploring. I guess the trick is to find a good way to dynamically
enable it.

Kind regards
Uffe

