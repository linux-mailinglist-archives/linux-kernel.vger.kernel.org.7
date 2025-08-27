Return-Path: <linux-kernel+bounces-788242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F349CB381B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B637AD918
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF82F3611;
	Wed, 27 Aug 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhFNmels"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6341EDA09;
	Wed, 27 Aug 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295358; cv=none; b=tN6+7C34u4McBX6CxyYtZVFqIlKMbY/1AwOjBAf12GXPxC0tmwvLJ01KSrkv9qtCzP7wIgmhFeEPsq/FA2IErwojmvjdrgh/WWc9otbjhotTXXwVI7nKB7IB+J0GPcZ5n2nSSrbbXosb/gPRAF3K89KQYP5C2qKPhBPnUHixW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295358; c=relaxed/simple;
	bh=znhfLiwONlPw/MZzbudWQ/KtJzWSWLhDzuDkeba+KRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKniIgw1sHv0r3ISn4d5HGAplfdx0OL/szx0iTvlhymdZ8m1lcINHqZUzdjX8oD6IenFlt0sT6eAvfANWGmOVYg5ZfbJiorvoRmSUlZGxdoxlakbYDF7KgBCBr1nr9olJfhVYsG6LHKVcrT3KzY02o+6QFTf6L3PTBKZpKlVTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhFNmels; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756295357; x=1787831357;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=znhfLiwONlPw/MZzbudWQ/KtJzWSWLhDzuDkeba+KRo=;
  b=jhFNmelscrPcHGL7D60jKPGu9xtIDHsl6Se0sVtp8lr3PbqQBDfedFu6
   odAMsIKBw5Ec52S35T+5dyAk3C/cNS4Q++U0ozLBKESiu5reQn1Vli++u
   skFOiqXCQoZBCREAbFeR45NgNPGMim4t7rAu6Htu9lzrs/JYlgC1P6MPb
   dy5mgCKRQ9q/guVrJI4MuBtgJm7UxmWO0ob13HBM+PQFvdnzFQbjWNx9p
   2WOXiQ4/wcz+AdjMi0NJeSChIEc8NJSq8qwx/67m0hVxRpumyn9LMlI9C
   X0gjEVOVAgy3UMrG3pdswPka3xqrWTyMdvZUPevjsdAbYxfgj620odUgZ
   w==;
X-CSE-ConnectionGUID: t02bfFOPRSeVh2PZfED7ZA==
X-CSE-MsgGUID: X7OUtA9IQ0+Vavw/txMWww==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57563662"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57563662"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 04:49:15 -0700
X-CSE-ConnectionGUID: zvvBl4BYSyOUXekQlljAAA==
X-CSE-MsgGUID: VXomUqURQ/O9wweXrTn6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="175121283"
Received: from gabaabhi-mobl2.amr.corp.intel.com ([10.125.109.50])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 04:49:14 -0700
Message-ID: <abdd6c22714984782fbbb7dab5a7e1ab0fa4799c.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel: power-domains validate domain in
 tpmi_cpu_online()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Arcari <darcari@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tero Kristo
 <tero.kristo@linux.intel.com>,  linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2025 04:49:12 -0700
In-Reply-To: <adbc0e8b-199a-42af-a45e-cb3791923554@redhat.com>
References: <20250826164331.1372856-1-darcari@redhat.com>
	 <00466c7a41bd4a0120a7798318ac5bba8878ada5.camel@linux.intel.com>
	 <adbc0e8b-199a-42af-a45e-cb3791923554@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 21:39 -0400, David Arcari wrote:
>=20
> Hi Srinivas,
>=20
> On 8/26/25 4:26 PM, srinivas pandruvada wrote:
> > Hi David,
> >=20
> > On Tue, 2025-08-26 at 12:43 -0400, David Arcari wrote:
> > > Although tpmi_get_power_domain_mask() calls
> > > tpmi_domain_is_valid()
> > > prior to indexing tpmi_power_domain_mask[],
> > Because this an API call so that caller parameter needs to be
> > sanitized.
> >=20
> > > =C2=A0 tpmi_cpu_online() does
> > > not.
> > This is hotplug callback, which should have correct topology
> > information.
> >=20
> > > =C2=A0 In the case where a VM creates non-contiguous package ids the
> > > result can be memory corruption. This can be prevented by adding
> > > the same validation in tpmi_cpu_online().
> > >=20
> >=20
> > This driver is getting loaded means MSR 0x54 is virtualised
> > otherwise
> > this driver will not load.
>=20
> I don't have direct access to the system, but this appears to be the=20
> case.=C2=A0 The driver is reading MSR 0x54:
>=20
> drivers/platform/x86/intel/tpmi_power_domains.c:#define=20
> MSR_PM_LOGICAL_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x54
> drivers/platform/x86/intel/tpmi_power_domains.c:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D=20
> rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
> drivers/platform/x86/intel/tpmi_power_domains.c:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D=20
> rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
>=20
>=20
> > Not sure this is an upstream kernel or not.
>=20
> This was not an upstream kernel, but I don't see anything in the=20
> upstream driver that would have prevented the access that is
> occurring.
>=20
The issue here the topology_max_packages() is 2 but cpu 1 package ID is
also 2. So everywhere topology_max_packages() is used there may be
issue as you have to verify the package ID is fine.


Repost the patch by adding the above root cause in the description, so
we know why we need this change.

Thanks,
Srinivas

> >=20
> > Some comments below.
> >=20
> > > Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU
> > > mapping")
> > >=20
> > Andy already pointed about new line here.
> >=20
> > > Cc: Hans de Goede <hansg@kernel.org>
> > > Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Dan Carpenter <dan.carpenter@linaro.org>
> > > Cc: David Arcari <darcari@redhat.com>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Tero Kristo <tero.kristo@linux.intel.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: David Arcari <darcari@redhat.com>
> > > ---
> > > =C2=A0=C2=A0drivers/platform/x86/intel/tpmi_power_domains.c | 3 +++
> > > =C2=A0=C2=A01 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c
> > > b/drivers/platform/x86/intel/tpmi_power_domains.c
> > > index 9d8247bb9cfa..ae5b58679e29 100644
> > > --- a/drivers/platform/x86/intel/tpmi_power_domains.c
> > > +++ b/drivers/platform/x86/intel/tpmi_power_domains.c
> > > @@ -194,6 +194,9 @@ static int tpmi_cpu_online(unsigned int cpu)
> > > =C2=A0=C2=A0	if (ret)
> > > =C2=A0=C2=A0		return 0;
> > > =C2=A0=20
> > Need some more information.
> >=20
> > The only case this check is required if
> > topology_physical_package_id(cpu) is returning greater or equal to
> > topology_max_packages(). If this true in this case, please check
> > the
> > value of info->pkg_id. If this is bad then then some other places
> > also
> > this may have issue. info->punit_domain_id is already checked for
> > valid
> > value in tpmi_get_logical_id().
>=20
> That is correct.=C2=A0 In the case of the crash we have:
>=20
> crash> p/x __max_logical_packages
> $1 =3D 0x2
>=20
> static inline unsigned int topology_max_packages(void)
> {
> 	return __max_logical_packages;
> }
>=20
>=20
> $2 =3D {
> =C2=A0=C2=A0 hnode =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 next =3D 0xffff9651bbc37010,
> =C2=A0=C2=A0=C2=A0=C2=A0 pprev =3D 0xffffffffc0b7a640 <tpmi_cpu_hash>
> =C2=A0=C2=A0 },
> =C2=A0=C2=A0 linux_cpu =3D 1,
> =C2=A0=C2=A0 pkg_id =3D 2 '\002',
> =C2=A0=C2=A0 punit_thread_id =3D 0 '\000',
> =C2=A0=C2=A0 punit_core_id =3D 0 '\000',
> =C2=A0=C2=A0 punit_domain_id =3D 0 '\000'
> }
>=20
> The pkg_id of 2 leads to the bad reference.
>=20
> FWIW this change has been tested and resolves the issue.
>=20
> Let me know if there is any other information I can provide.=C2=A0 I will
> be=20
> out of the office on Wednesday, so response may be delayed.
>=20
> Best,
> -DA
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > > +	if (!tpmi_domain_is_valid(info))
> > > +		return 0;
> > > +
> > > =C2=A0=C2=A0	index =3D info->pkg_id * MAX_POWER_DOMAINS + info-
> > > > punit_domain_id;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	guard(mutex)(&tpmi_lock);
> >=20
> >=20
>=20


