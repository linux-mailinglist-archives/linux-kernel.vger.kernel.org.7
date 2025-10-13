Return-Path: <linux-kernel+bounces-850994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF34BD4E43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F401318A214A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309930BBA4;
	Mon, 13 Oct 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6azost/n"
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5F1EDA2B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371498; cv=none; b=QXJNcJTmwTApiIfIQdUv+gVvwDdd1FomO1bua6r7ZP3uSisEcdOWx1PBfCytxoDDOzBY4g1gLext01XKnlsTzHW6cdDGWmu+Kq14EJYuG152Eb+IlxRgQRy/BjHX8X6uq1cxliJ5zxO5/p2Hac+zfe/Mig8MCt5BmuwAKO5ER20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371498; c=relaxed/simple;
	bh=PALwSjb64mTWnRNMcWLvj6UyYsI8cIclikP+/g1w6VI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peBvSma84tR5pBsIHz6kNG2yyc7QXaKqM0ezupyhF/j1NPZwvENv2uGgzDG/WDUK37tFan5jAcpNTKdkEzTQ297bLqDtsoVqtHDRRQPBO0JkSKlOyV1yQ1YnicrRWii9VCjDj41LDe6HA2HXYJYmo6PeIBCgwT6kvzG7ENCU1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6azost/n; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BeAFLN0HOs+5tCV60lxEz2c6X5B0Jjgl2YbcdH5SmlI=;
	b=6azost/neUBFyasolyvueOW3ezr/HVuKQSWVJC5dlpp1Rwki1y/gC+AGnVm+QICpAHEJnEjXN
	n6PqowqVmk6k+wi4Ac6NNgtGcS1XowlUcKIrdABA2ZDec13IvrLXkC9GGhANU+kwDxxbpLQV0Et
	LmplXVbhQHxqFDz1hsvgFek=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4clhbF2084z1P7VC;
	Mon, 13 Oct 2025 23:48:41 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4clhZC472cz6GBlT;
	Mon, 13 Oct 2025 23:47:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 41DB6140277;
	Mon, 13 Oct 2025 23:48:43 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 16:48:42 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Mon, 13 Oct 2025 16:48:42 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Marc Zyngier <maz@kernel.org>, "salil.mehta@opnsrc.net"
	<salil.mehta@opnsrc.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "peter.maydell@linaro.org"
	<peter.maydell@linaro.org>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "andrew.jones@linux.dev"
	<andrew.jones@linux.dev>, "mst@redhat.com" <mst@redhat.com>,
	"david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
	<philmd@linaro.org>, "ardb@kernel.org" <ardb@kernel.org>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>,
	"gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
	<miguel.luis@oracle.com>, "darren@os.amperecomputing.com"
	<darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
	<ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
	<vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
	<gankulkarni@os.amperecomputing.com>, "wangyanan (Y)"
	<wangyanan55@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
Thread-Topic: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
Thread-Index: AQHcOJEPLIyaftchIkq5VYDgYw17SLS5xPAAgAZ0ydA=
Date: Mon, 13 Oct 2025 15:48:42 +0000
Message-ID: <2b7b73f47e3a4a9a8b21e581cc44ad4f@huawei.com>
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
 <86v7koxk1z.wl-maz@kernel.org>
In-Reply-To: <86v7koxk1z.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

HI Marc,

> From: Marc Zyngier <maz@kernel.org>
> Sent: Thursday, October 9, 2025 2:49 PM
> To: salil.mehta@opnsrc.net
[...]

>=20
> On Wed, 08 Oct 2025 21:19:55 +0100,
> salil.mehta@opnsrc.net wrote:
> >
> > From: Salil Mehta <salil.mehta@huawei.com>
> >
> > [A rough illustration of the problem and the probable solution]
> >
> > Userspace reads of ICC_CTLR_EL1 via KVM device attributes currently
> > takes a slow path that may acquire all vCPU locks. Under workloads
> > that exercise userspace PSCI CPU_ON flows or frequent vCPU resets,
> > this can cause vCPU lock contention in KVM and, in the worst cases, -EB=
USY
> returns to userspace.
> >
> > When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, these
> > operations are executed under KVM vCPU locks in the host kernel (EL1)
> > and appear atomic to other vCPU threads. In this context, system
> > register accesses are serialized under KVM vCPU locks, ensuring
> > atomicity with respect to other vCPUs. After SMCCC filtering was
> > introduced, PSCI CPU_ON and CPU_OFF calls can now exit to userspace
> > (QEMU). During the handling of PSCI CPU_ON call in userspace, a
> > cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM device
> > attribute IOCTLs. To avoid transient inconsistency and -EBUSY errors,
> > QEMU is forced to pause all vCPUs before issuing these IOCTLs.
>=20
> I'm going to repeat in public what I already said in private.
>=20
> Why does QEMU need to know this? I don't see how this is related to PSCI,
> and outside of save/restore, there is no reason why QEMU should poke at
> this. If QEMU needs fixing, please fix QEMU.


Sure, and I did not disagree with it earlier but because I was not fully su=
re
so I refrained from replying prematurely here.=20


>=20
> Honestly, I don't see why the kernel should even care about this, and I h=
ave
> no intention of adopting anything of the sort for something that has all =
the
> hallmarks of a userspace bug.


I understand your point. So the probable solutions for the problem mentione=
d
in the patch could be:

1. Remove the KVM device access of ICC_CTLR_EL1 system register during CPU
    reset and only sync with KVM during migration at source & destination?
2. if 1 is not acceptable then cache in user space.=20
3.  This KVM shadow register change=20

IIUC, you've hinted at 1st as the solution. We've discussed 2 as well and a=
s I
understand you don't have much apprehensions about it? And last point 3,
is of course totally rejected.

Hope I got it right?

Many thanks!

Best regards
Salil.

>=20
> 	M.
>=20
> --
> Without deviation from the norm, progress is not possible.

