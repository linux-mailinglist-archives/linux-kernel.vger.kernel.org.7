Return-Path: <linux-kernel+bounces-833028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C64BA1090
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C39C3AD099
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB3319873;
	Thu, 25 Sep 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mYzfNO0N"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2F1DE3DC;
	Thu, 25 Sep 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825191; cv=none; b=MGaL2C5GAD9CVSmmwlCr+Isi8X98gODhBvcSLW41oe9fX4mR+wpyUDfeYGLtxs9ZNK3uhNwig726QA4FikeEgYRbt+0jZx2zehL0oj4wV8AwtYx9CReU52ba3hmHwuakiJ313idC9AYNeSEQuy/zT46zO8n9dN3rcNCjHsT2vhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825191; c=relaxed/simple;
	bh=LKG06+HbgIfwwZeYeC6t/w0EWDw3h0ZyjMODB/HrRXg=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=nhqH2B7mnJObQuR8OnzZXuwMXt1YTVmG/EGWLRxTHTRFlGk6gxztxrQu6j+ak82MkN5sVF4jxruYq9qANOqOZRsEX8JNs8OkD1CkLEsRd2yzmjV5F194P2NHcTq8Umq2YkCtCfGouJCgBJ2yhlXhbkMwSSosOUCpGS+HJE13Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mYzfNO0N; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58PIWcmG1982853;
	Thu, 25 Sep 2025 13:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758825158;
	bh=YLhrPrJ/nxo/JR0QIrb3ulTfkmpHmQZXFDh+6QpJP+Y=;
	h=Date:To:CC:Subject:From:References:In-Reply-To;
	b=mYzfNO0NcLI02J71eFtQCotuLVhjtjaITQ1N4lrLwB6x2aQSYNwoqLLTCb8P5i4bg
	 cZv9s/7o4VOR/0hcRC0Yn+BGQ/J+VPFQHzWAfeovWwWKLkKNIx6DPqNqCknC137cZt
	 thznWX/1Eh2RDnpG3fwOY8W2rzLOK7/mxp9wVPrI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58PIWbXk3402736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 25 Sep 2025 13:32:37 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 25
 Sep 2025 13:32:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Sep 2025 13:32:37 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58PIWb6h001964;
	Thu, 25 Sep 2025 13:32:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Sep 2025 13:32:37 -0500
Message-ID: <DD23HER39PNM.O17TMFNNWD37@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Randolph Sapp <rs@ti.com>
CC: Kevin Hilman <khilman@kernel.org>, Michael Walle <mwalle@kernel.org>,
        Frank Binns <frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, "Nishanth Menon"
	<nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Andrew
 Davis <afd@ti.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org> <7hv7lhp0e8.fsf@baylibre.com>
 <DD1IXJDTBQ72.2XIEIIN0YA713@ti.com>
 <20250925-elephant-of-absolute-prowess-a97fcd@penduick>
In-Reply-To: <20250925-elephant-of-absolute-prowess-a97fcd@penduick>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu Sep 25, 2025 at 6:43 AM CDT, Maxime Ripard wrote:
> On Wed, Sep 24, 2025 at 09:26:17PM -0500, Randolph Sapp wrote:
>> On Wed Sep 17, 2025 at 10:24 AM CDT, Kevin Hilman wrote:
>> > Michael Walle <mwalle@kernel.org> writes:
>> >
>> >> The TISCI firmware will return 0 if the clock or consumer is not
>> >> enabled although there is a stored value in the firmware. IOW a call =
to
>> >> set rate will work but at get rate will always return 0 if the clock =
is
>> >> disabled.
>> >> The clk framework will try to cache the clock rate when it's requeste=
d
>> >> by a consumer. If the clock or consumer is not enabled at that point,
>> >> the cached value is 0, which is wrong.
>> >
>> > Hmm, it also seems wrong to me that the clock framework would cache a
>> > clock rate when it's disabled.  On platforms with clocks that may have
>> > shared management (eg. TISCI or other platforms using SCMI) it's
>> > entirely possible that when Linux has disabled a clock, some other
>> > entity may have changed it.
>> >
>> > Could another solution here be to have the clk framework only cache wh=
en
>> > clocks are enabled?
>>=20
>> So I looked into that. There are still about 34 clock operations that ar=
e
>> functionally uncached, but it does seem more logical than treating every=
thing as
>> uncached.
>>=20
>> Side note, why would someone even want to read the rate of an unprepared=
 clock?
>> I dumped some debug info for all the clocks tripping this new uncached p=
ath.
>> Seems weird that it's even happening this often. Even weirder that it's
>> apparently happening 3 times to cpu0's core clock on the board I'm curre=
ntly
>> testing.
>
> The short, unsatisfying, answer is that the API explicitly allowed it so =
far.
>
> It's also somewhat natural when you have a functional rate to set it up
> before enabling it and the logic driven by it so that you would avoid a
> rate change, or something like a cycle where you would enable, shut
> down, reparent, enable the clock again.
>
> In such a case, we would either need the cache, or to read the rate, to
> know if we have to change the clock rate in the first place.
>
> Maxime

Thanks Maxime. I'll take this as a hint to stop digging for the moment. Rig=
ht
now, treating unprepared clocks as untrusted / uncached makes sense and
shouldn't be too much of a performance issue.

- Randolph

