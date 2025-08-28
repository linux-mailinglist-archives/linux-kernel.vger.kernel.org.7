Return-Path: <linux-kernel+bounces-789879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10BB39C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0951B24A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3636208994;
	Thu, 28 Aug 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lL3E9pKc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482C2DE1FA;
	Thu, 28 Aug 2025 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382103; cv=none; b=UI2Ddu4IFsIWZvZCwwHNVFzxJl0vPxqAAIxKWpSDCo+mVp9BWj8zVqyzQ+iupJyk0svqMKmf03ouxSif5pgyuB6WlOWG9KoeVBQDYjAGv6CezGxky4fby28OgTnnbhB0K8gV68HsVZn9arM5ht9Ypgqv7oBSogKixw14ySye+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382103; c=relaxed/simple;
	bh=39jDgPut0aMAL2c8xKB2JpY2asybF4VpCuT9Xo4zhCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXaYftPi6t6xGyGuatdB9WJDxVEiUCQBaz6lRH4E/cR0VpvNaqPJ0ZEjHHAlqi7Wpjxl3LqRbaFjMmu09TtkYlZIa0tdg+ReBiI3DuLCEMOfFFdFfLUz78SDH64qo1mO+ha4xUumj+YxaV39WRZt2STfTO62H5BerLM3SO9H2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lL3E9pKc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756382101; x=1787918101;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=39jDgPut0aMAL2c8xKB2JpY2asybF4VpCuT9Xo4zhCI=;
  b=lL3E9pKc5G6ERf/GpG9QHL7MtMXsDOmocVp68o+7P8WYmTGMwr5ZJRQq
   IOeKCrDJ9lwlVMbfDMt5cw9gmcD2bWm6fcj5knFpHcOUh39tZhJrmlJ13
   55wLQm+L8pURuIdO4J2+1jkvtPaZfyBk2leaFDz5yWu08GjSnuvWAQ4A/
   HafhKjs44xsgrppaB3kDRvRmr8uwz9HdTkPXgJnXTV619muoyQ7Y5CG0m
   WCBExaRUayqz8ZqbAq+F22Y/LcNCGkPoueYu4Wsu1xJHc+lgETqHDHqwS
   NGKvgk2OTNF2tlKVtLd7t5YTCtk9RFvczmHXe5SGARbMB71DMaWG/BeY6
   w==;
X-CSE-ConnectionGUID: x+MXggsHSLmMYaUG6MX0Tw==
X-CSE-MsgGUID: aQe86KFQQKqAsf5B0cBUyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58573346"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58573346"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:55:00 -0700
X-CSE-ConnectionGUID: L1OgvqTIT3OxTbxucszvHA==
X-CSE-MsgGUID: 5xDwigh4S7qQpjLd1XWMtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="201013712"
Received: from puneetse-mobl.amr.corp.intel.com ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:54:58 -0700
Message-ID: <0684f47fa5c333b971fd9ccb1f3e86844fb5ddea.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel: power-domains validate domain in
 tpmi_cpu_online()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Arcari <darcari@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tero Kristo
 <tero.kristo@linux.intel.com>,  linux-kernel@vger.kernel.org
Date: Thu, 28 Aug 2025 04:54:55 -0700
In-Reply-To: <67ebb7d5-418c-4eaf-aa94-8ecf76bd44eb@redhat.com>
References: <20250826164331.1372856-1-darcari@redhat.com>
	 <00466c7a41bd4a0120a7798318ac5bba8878ada5.camel@linux.intel.com>
	 <adbc0e8b-199a-42af-a45e-cb3791923554@redhat.com>
	 <abdd6c22714984782fbbb7dab5a7e1ab0fa4799c.camel@linux.intel.com>
	 <67ebb7d5-418c-4eaf-aa94-8ecf76bd44eb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 07:27 -0400, David Arcari wrote:
>=20
>=20
> On 8/27/25 7:49 AM, srinivas pandruvada wrote:
> > On Tue, 2025-08-26 at 21:39 -0400, David Arcari wrote:
> > >=20
> > > Hi Srinivas,
> > >=20
> > > On 8/26/25 4:26 PM, srinivas pandruvada wrote:
> > > > Hi David,
> > > >=20
> > > > On Tue, 2025-08-26 at 12:43 -0400, David Arcari wrote:
> > > > > Although tpmi_get_power_domain_mask() calls
> > > > > tpmi_domain_is_valid()
> > > > > prior to indexing tpmi_power_domain_mask[],
> > > > Because this an API call so that caller parameter needs to be
> > > > sanitized.
> > > >=20
> > > > > =C2=A0=C2=A0 tpmi_cpu_online() does
> > > > > not.
> > > > This is hotplug callback, which should have correct topology
> > > > information.
> > > >=20
> > > > > =C2=A0=C2=A0 In the case where a VM creates non-contiguous packag=
e ids
> > > > > the
> > > > > result can be memory corruption. This can be prevented by
> > > > > adding
> > > > > the same validation in tpmi_cpu_online().
> > > > >=20
> > > >=20
> > > > This driver is getting loaded means MSR 0x54 is virtualised
> > > > otherwise
> > > > this driver will not load.
> > >=20
> > > I don't have direct access to the system, but this appears to be
> > > the
> > > case.=C2=A0 The driver is reading MSR 0x54:
> > >=20
> > > drivers/platform/x86/intel/tpmi_power_domains.c:#define
> > > MSR_PM_LOGICAL_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x54
> > > drivers/platform/x86/intel/tpmi_power_domains.c:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D
> > > rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
> > > drivers/platform/x86/intel/tpmi_power_domains.c:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D
> > > rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
> > >=20
> > >=20
> > > > Not sure this is an upstream kernel or not.
> > >=20
> > > This was not an upstream kernel, but I don't see anything in the
> > > upstream driver that would have prevented the access that is
> > > occurring.
> > >=20
> > The issue here the topology_max_packages() is 2 but cpu 1 package
> > ID is
> > also 2. So everywhere topology_max_packages() is used there may be
> > issue as you have to verify the package ID is fine.
>=20
> Correct.=C2=A0 There are two logical packages on this system, but they ar=
e
> 0=20
> and 2.
>=20
> >=20
> >=20
> > Repost the patch by adding the above root cause in the description,
> > so
> > we know why we need this change.
>=20
> I will do that.
>=20
Also this customer contacted me. In their case they don't GP fault on
the MSR 0x54 so driver is loaded.

Thanks,
Srinivas

> Best,
> -DA
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > > >=20
> > > > Some comments below.
> > > >=20
> > > > > Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and
> > > > > CPU
> > > > > mapping")
> > > > >=20
> > > > Andy already pointed about new line here.
> > > >=20
> > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> > > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > Cc: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > Cc: David Arcari <darcari@redhat.com>
> > > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Cc: Tero Kristo <tero.kristo@linux.intel.com>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Signed-off-by: David Arcari <darcari@redhat.com>
> > > > > ---
> > > > > =C2=A0=C2=A0=C2=A0drivers/platform/x86/intel/tpmi_power_domains.c=
 | 3 +++
> > > > > =C2=A0=C2=A0=C2=A01 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c
> > > > > b/drivers/platform/x86/intel/tpmi_power_domains.c
> > > > > index 9d8247bb9cfa..ae5b58679e29 100644
> > > > > --- a/drivers/platform/x86/intel/tpmi_power_domains.c
> > > > > +++ b/drivers/platform/x86/intel/tpmi_power_domains.c
> > > > > @@ -194,6 +194,9 @@ static int tpmi_cpu_online(unsigned int
> > > > > cpu)
> > > > > =C2=A0=C2=A0=C2=A0	if (ret)
> > > > > =C2=A0=C2=A0=C2=A0		return 0;
> > > > > =C2=A0=C2=A0=20
> > > > Need some more information.
> > > >=20
> > > > The only case this check is required if
> > > > topology_physical_package_id(cpu) is returning greater or equal
> > > > to
> > > > topology_max_packages(). If this true in this case, please
> > > > check
> > > > the
> > > > value of info->pkg_id. If this is bad then then some other
> > > > places
> > > > also
> > > > this may have issue. info->punit_domain_id is already checked
> > > > for
> > > > valid
> > > > value in tpmi_get_logical_id().
> > >=20
> > > That is correct.=C2=A0 In the case of the crash we have:
> > >=20
> > > crash> p/x __max_logical_packages
> > > $1 =3D 0x2
> > >=20
> > > static inline unsigned int topology_max_packages(void)
> > > {
> > > 	return __max_logical_packages;
> > > }
> > >=20
> > >=20
> > > $2 =3D {
> > > =C2=A0=C2=A0=C2=A0 hnode =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D 0xffff9651bbc37010,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pprev =3D 0xffffffffc0b7a640 <tpmi_cpu=
_hash>
> > > =C2=A0=C2=A0=C2=A0 },
> > > =C2=A0=C2=A0=C2=A0 linux_cpu =3D 1,
> > > =C2=A0=C2=A0=C2=A0 pkg_id =3D 2 '\002',
> > > =C2=A0=C2=A0=C2=A0 punit_thread_id =3D 0 '\000',
> > > =C2=A0=C2=A0=C2=A0 punit_core_id =3D 0 '\000',
> > > =C2=A0=C2=A0=C2=A0 punit_domain_id =3D 0 '\000'
> > > }
> > >=20
> > > The pkg_id of 2 leads to the bad reference.
> > >=20
> > > FWIW this change has been tested and resolves the issue.
> > >=20
> > > Let me know if there is any other information I can provide.=C2=A0 I
> > > will
> > > be
> > > out of the office on Wednesday, so response may be delayed.
> > >=20
> > > Best,
> > > -DA
> > >=20
> > > >=20
> > > > Thanks,
> > > > Srinivas
> > > >=20
> > > > > +	if (!tpmi_domain_is_valid(info))
> > > > > +		return 0;
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0	index =3D info->pkg_id * MAX_POWER_DOMAINS + i=
nfo-
> > > > > > punit_domain_id;
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0	guard(mutex)(&tpmi_lock);
> > > >=20
> > > >=20
> > >=20
> >=20
>=20


