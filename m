Return-Path: <linux-kernel+bounces-778694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6EEB2E909
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F087A84F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193712E173E;
	Wed, 20 Aug 2025 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="P1RUhGoj"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D12E0939
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733961; cv=none; b=CwdHit8wpAEqibPaqc6vvHe40d/IWFK88AqPXzhQXH03VgZ/U/NtzPC9p4lDkPnWClv5L9SkP6ifeL5Iaqun8idgI3ET7BGhjg6szmUQmifzMUzXG+WwUukbra45piEveWNlmKF1XkjjXWhDI8atgEGqOlOH5BOyIRqVHvcqTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733961; c=relaxed/simple;
	bh=y6CIAXlKpIRMtXGQ/qenvV1rR6NnhU4WaDFG20FSUNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P8BeaAVYxoUN8eX3hOM44Ccs/BFd041zQZO4sKaYk8V5J3n2d0ulDKW+oKTP6fIf5v8vKqXYgUf3qmDutiHIbWwiwpd6UFNEOfy7zf8YVl+2JT0yRIAnKA10/7RrlYTXmd9vlbdirzll8+bR2EJa2H0240KWivCNClq1F8IL1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=P1RUhGoj; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755733469;
	bh=y6CIAXlKpIRMtXGQ/qenvV1rR6NnhU4WaDFG20FSUNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=P1RUhGojZt8l0C29AJXMI+5ULjY9PSItG6GVXXp2P+Q9Wo1A8feroRxpBLuz7fUR+
	 ogF5DkJJbDbf3dHnaOI6/KPjpHKh7EZ97AWD/aMd+o+LEOcUVF7WfjZ0coewZl6co/
	 d5ftGO4jwiGzNONFHM9b5C77R/S4csVrshmsuohE=
Received: by gentwo.org (Postfix, from userid 1003)
	id DD6264028B; Wed, 20 Aug 2025 16:44:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id DC703400CA;
	Wed, 20 Aug 2025 16:44:29 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:44:29 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Sudeep Holla <sudeep.holla@arm.com>
cc: Jeremy Linton <jeremy.linton@arm.com>, 
    Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, patches@amperecomputing.com, 
    Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org, 
    bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de, 
    nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com, 
    prabhakar.mahadev-lad.rj@bp.renesas.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
In-Reply-To: <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
Message-ID: <1e3ae52a-0aea-3146-429b-6a0035181b26@gentwo.org>
References: <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com> <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org> <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com> <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla> <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org> <aJ20imoeRL_tifky@bogus> <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org> <20250815-pheasant-of-eternal-tact-6f9bbc@sudeepholla> <1097a1d1-483d-44b3-b473-4350b5a4b04d@arm.com>
 <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Aug 2025, Sudeep Holla wrote:

> > But returning to the original point, its not clear to me that the HW
> > 'cluster' information is really causing the performance boost vs, just
> > having a medium size scheduling domain (aka just picking an arbitrary size
> > 4-16 cores) under MC, or simply 'slicing' a L3 in the PPTT such that the MC
> > domains are smaller, yields the same effect. I've seen a number of cases
> > where 'lying' about the topology yields a better result in a benchmark. This
> > is largely what is happening with these Firmware toggles that move/remove
> > the NUMA domains too. Being able to manually reconfigure some of these
> > scheduling levels at runtime might be useful...
> >
>
> I share your concern and hence completely again representation of any fake
> data in the ACPI topology just to get improved performance. Yes we have seen
> that in the past.

Depends on what you call fake. There are microarchitectural issues
regarding the proximity of the processors that the customer may not know
about and therefore the data provides by the vendor may be considered
"fake". Certainly that is not the case for our processors.

This is a common feature and widely available on other platforms.
There is no need to do anything but enable the functionality. Having a
special version of ACPI for arm64 or a special handling for arm64 does not
make sense.

The ACPI subsystem provides the ability to add blacklists. If a vendor has
problems with their firmward providing data that reduces the performance
and is unable to fix it othereise then the vendor can use that feature to
disable these ACPI features for their platform by submitting a patch.

Please make arm64 work like the other Linux platforms and do not introduce
special handling for ARM64.

