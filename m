Return-Path: <linux-kernel+bounces-831617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D5B9D236
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A0C2E0A92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE102DD608;
	Thu, 25 Sep 2025 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ij/PIj8U"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FDD2FB;
	Thu, 25 Sep 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767208; cv=none; b=dDqZwDF/NAoL0GT2ouLoZL9KIZt71YJE2Yy/zE7d1CcEx76jbZOCJP6GoXubzTKYi9lj73mmK2jm4sIvBuRHVNkERffigEd08pQHFcwX/qjcHtqDIdfaqJiQwUUBBL/qJD68/j5s65nNvZ8oevaHuMYWt2rlDLM5hIZ0Z4mo8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767208; c=relaxed/simple;
	bh=igBfI5ieQEzD4AP0zqB4wSXqgDO8U6h9996ZiFShPcM=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=vDL7mAVxx7inm0e4L70BiahhfGbdsJFZq+Fwh7pRPPmNt9rp26nBmvnNbxVGgOZii7Lp8jvm2LzTN4mmyT/dQJv7gzu9cuRgBpXxPEU4vexGnaxbW9fexfTkKWykXoHjF8EiTTh24FUHV0ZsZiY5pFS5CDKHlm/K7hos1pEdFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ij/PIj8U; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58P2QJxI1799988;
	Wed, 24 Sep 2025 21:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758767179;
	bh=Ls9j3ehev03+/T3e7eCjckf/cKK1mjKSxTbjZU7yHko=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=ij/PIj8UccGFJ7MtcytPs4WJyZsF6uzCdNN0Z28H3V55N5fvGL7G4jkSAVtCZ5gD6
	 e20BhlrEH7snCwah3nHrtT1T2aoL9J9WHvoJtIdWkKWBa0ye2fHIrKnX0Qj2EqHfo8
	 nEVjIrMff8N08aipOCtJBRA11+PZ2oG+jgM1LWSY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58P2QIaK4027010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 24 Sep 2025 21:26:18 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 21:26:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 21:26:17 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58P2QHDi2737277;
	Wed, 24 Sep 2025 21:26:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Sep 2025 21:26:17 -0500
Message-ID: <DD1IXJDTBQ72.2XIEIIN0YA713@ti.com>
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
From: Randolph Sapp <rs@ti.com>
To: Kevin Hilman <khilman@kernel.org>, Michael Walle <mwalle@kernel.org>,
        Frank Binns <frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley"
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh Raghavendra"
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar"
	<ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen
 Boyd <sboyd@kernel.org>
CC: Andrew Davis <afd@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org> <7hv7lhp0e8.fsf@baylibre.com>
In-Reply-To: <7hv7lhp0e8.fsf@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed Sep 17, 2025 at 10:24 AM CDT, Kevin Hilman wrote:
> Michael Walle <mwalle@kernel.org> writes:
>
>> The TISCI firmware will return 0 if the clock or consumer is not
>> enabled although there is a stored value in the firmware. IOW a call to
>> set rate will work but at get rate will always return 0 if the clock is
>> disabled.
>> The clk framework will try to cache the clock rate when it's requested
>> by a consumer. If the clock or consumer is not enabled at that point,
>> the cached value is 0, which is wrong.
>
> Hmm, it also seems wrong to me that the clock framework would cache a
> clock rate when it's disabled.  On platforms with clocks that may have
> shared management (eg. TISCI or other platforms using SCMI) it's
> entirely possible that when Linux has disabled a clock, some other
> entity may have changed it.
>
> Could another solution here be to have the clk framework only cache when
> clocks are enabled?

So I looked into that. There are still about 34 clock operations that are
functionally uncached, but it does seem more logical than treating everythi=
ng as
uncached.

Side note, why would someone even want to read the rate of an unprepared cl=
ock?
I dumped some debug info for all the clocks tripping this new uncached path=
.
Seems weird that it's even happening this often. Even weirder that it's
apparently happening 3 times to cpu0's core clock on the board I'm currentl=
y
testing.

Some devices it only happens once, others get it two or three times. Most o=
f
them seem to be obvious - someone trying to read a rate before the clock wa=
s
prepared as part of a probe sequence. One seemed to be happening directly a=
fter
a clk_prepare_enable call that completed successfully. Not sure how that co=
uld
happen.

>> Thus, disable the cache altogether.
>>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> I guess to make it work correctly with the caching of the linux
>> subsystem a new flag to query the real clock rate is needed. That
>> way, one could also query the default value without having to turn
>> the clock and consumer on first. That can be retrofitted later and
>> the driver could query the firmware capabilities.
>>
>> Regarding a Fixes: tag. I didn't include one because it might have a
>> slight performance impact because the firmware has to be queried
>> every time now and it doesn't have been a problem for now. OTOH I've
>> enabled tracing during boot and there were just a handful
>> clock_{get/set}_rate() calls.
>
> The performance hit is not just about boot time, it's for *every*
> [get|set]_rate call.  Since TISCI is relatively slow (involves RPC,
> mailbox, etc. to remote core), this may have a performance impact
> elsewhere too.  That being said, I'm hoping it's unlikely that
> [get|set]_rate calls are in the fast path.
>
> All of that being said, I think the impacts of this patch are pretty
> minimal, so I don't have any real objections.
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>
>> ---
>>  drivers/clk/keystone/sci-clk.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-c=
lk.c
>> index c5894fc9395e..d73858b5ca7a 100644
>> --- a/drivers/clk/keystone/sci-clk.c
>> +++ b/drivers/clk/keystone/sci-clk.c
>> @@ -333,6 +333,14 @@ static int _sci_clk_build(struct sci_clk_provider *=
provider,
>> =20
>>  	init.ops =3D &sci_clk_ops;
>>  	init.num_parents =3D sci_clk->num_parents;
>> +
>> +	/*
>> +	 * A clock rate query to the SCI firmware will return 0 if either the
>> +	 * clock itself is disabled or the attached device/consumer is disable=
d.
>> +	 * This makes it inherently unsuitable for the caching of the clk
>> +	 * framework.
>> +	 */
>> +	init.flags =3D CLK_GET_RATE_NOCACHE;
>>  	sci_clk->hw.init =3D &init;
>> =20
>>  	ret =3D devm_clk_hw_register(provider->dev, &sci_clk->hw);
>> --=20
>> 2.39.5


