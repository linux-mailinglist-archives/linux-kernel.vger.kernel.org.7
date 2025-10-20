Return-Path: <linux-kernel+bounces-861412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F2BF2A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634B61894A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA3331A70;
	Mon, 20 Oct 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9iU/zzc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC37331A76;
	Mon, 20 Oct 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980521; cv=none; b=jCa3XqlhX2kdljWpDTkYr2W1QPDDEXlZSnbySc6O9QEDgHkHiEFpB8el0dru8UeooB/ek/v+8AlovHZDAyJCy8ZIfcF/ydVIS8Zx/lfeiveqlFPdnjGb4ZhuiIODc+zL+DVU287laCV/YkJc+/el6F6j4jUbxRnPpEqBzBsZTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980521; c=relaxed/simple;
	bh=m5XgqvCMLKOPS6aEhK02O0QsfN9A8cDAQIgY2sw4YPE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rhxl8jf46aPlN3QuA6AWDHR6H7dnLqeTsVQopMdfwsqdqvHSKx8LiJ9DwVc/HhXp1BGkGutx74zjVK9of712ryPiegZtv7Xk5qS8CCfmn3j01+UUNnM/SO0aQesWBAq0k73mxXHq1xJDfKykiK6sBONMoiahThTeyKxJYfFyJ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9iU/zzc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760980519; x=1792516519;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=m5XgqvCMLKOPS6aEhK02O0QsfN9A8cDAQIgY2sw4YPE=;
  b=h9iU/zzcX/5bgoj0yUaozl1JVM4V7RkZDSeHdgEX5IEcmRS3Tqs0ee/2
   Vfy/97EvPPolQBj9a4NTwlNLvTFl6dqHJ5DZe8iz8lV1zmqWaAFu6h22Y
   56A5BhCRBaaQAN9CN61cgSdnulXfKReUkvcLoJaCKBRV1Z0U0rivcu1PJ
   7ac4FgOShDa3jgh6K+GBY6ReWkDlB2U9z3Weyh2SkztGAJO0P/7J3S0wY
   aBy1sb2ToWuzyZoHJ8oVlr/wqPpnb7zSGkOdtDmLao6l87aYEyMR2fQ6l
   cMCK6ipLJeDLL92MQj2I/0TFN5ahEHiQB14ih9qJMcB683POEtuMclu75
   Q==;
X-CSE-ConnectionGUID: 5DiHel4MT0u762TNNIe/nw==
X-CSE-MsgGUID: cKdZJy7+T7aohe/cyzwlVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63246383"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="63246383"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:15:19 -0700
X-CSE-ConnectionGUID: OE/6APKQQwOzoNNa3KyOfw==
X-CSE-MsgGUID: GwMjsxubRqmTcwurR36DTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="182523518"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 10:15:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 20:15:10 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: Mario Limonciello <superm1@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Luke D . Jones" <luke@ljones.dev>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 5/9] platform/x86: asus-armoury: add core count
 control
In-Reply-To: <13b9890e-d1b7-446a-9e93-2034c60a0a88@gmail.com>
Message-ID: <f3a69b7e-a698-2dd5-731a-f7db0eabd8f3@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <20251015014736.1402045-6-benato.denis96@gmail.com> <25bd0c90-2de0-ef66-c18d-661180b71fd4@linux.intel.com> <13b9890e-d1b7-446a-9e93-2034c60a0a88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1335968388-1760968966=:976"
Content-ID: <712727e6-b337-99a7-dd34-2583cc52593f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1335968388-1760968966=:976
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6c501b7b-fcf3-6ef9-fcf2-d9521bcca58d@linux.intel.com>

On Sat, 18 Oct 2025, Denis Benato wrote:
> On 10/17/25 14:48, Ilpo J=E4rvinen wrote:
> > On Wed, 15 Oct 2025, Denis Benato wrote:
> >
> >> From: "Luke D. Jones" <luke@ljones.dev>
> >>
> >> Implement Intel core enablement under the asus-armoury module using th=
e
> >> fw_attributes class.
> >>
> >> This allows users to enable or disable preformance or efficiency cores
> >> depending on their requirements. After change a reboot is required.
> >>
> >> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> >> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> >> ---
> >>  drivers/platform/x86/asus-armoury.c        | 258 ++++++++++++++++++++=
-
> >>  drivers/platform/x86/asus-armoury.h        |  28 +++
> >>  include/linux/platform_data/x86/asus-wmi.h |   5 +
> >>  3 files changed, 290 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x8=
6/asus-armoury.c
> >> index 3b49a27e397d..3d963025d84e 100644
> >> --- a/drivers/platform/x86/asus-armoury.c
> >> +++ b/drivers/platform/x86/asus-armoury.c

> >> +static ssize_t cores_value_show(struct kobject *kobj, struct kobj_att=
ribute *attr, char *buf,
> >> +=09=09=09=09enum cpu_core_type core_type, enum cpu_core_value core_va=
lue)
> >> +{
> >> +=09u32 cores;
> >> +
> >> +=09switch (core_value) {
> >> +=09case CPU_CORE_DEFAULT:
> >> +=09case CPU_CORE_MAX:
> >> +=09=09if (core_type =3D=3D CPU_CORE_PERF)
> >> +=09=09=09return sysfs_emit(buf, "%u\n",
> >> +=09=09=09=09=09  asus_armoury.cpu_cores->max_perf_cores);
> >> +=09=09else
> >> +=09=09=09return sysfs_emit(buf, "%u\n",
> >> +=09=09=09=09=09  asus_armoury.cpu_cores->max_power_cores);
> >> +=09case CPU_CORE_MIN:
> >> +=09=09if (core_type =3D=3D CPU_CORE_PERF)
> >> +=09=09=09return sysfs_emit(buf, "%u\n",
> >> +=09=09=09=09=09  asus_armoury.cpu_cores->min_perf_cores);
> >> +=09=09else
> >> +=09=09=09return sysfs_emit(buf, "%u\n",
> >> +=09=09=09=09=09  asus_armoury.cpu_cores->min_power_cores);
> >> +=09default:
> >> +=09=09break;
> >> +=09}
> >> +
> >> +=09if (core_type =3D=3D CPU_CORE_PERF)
> >> +=09=09cores =3D asus_armoury.cpu_cores->cur_perf_cores;
> >> +=09else
> >> +=09=09cores =3D asus_armoury.cpu_cores->cur_power_cores;
> > Why isn't this inside the switch?? The logic in this function looks ver=
y=20
> > mixed up.
> >
> > If I'd be you, I'd consider converting the asus_armoury.cpu_cores to a=
=20
> > multi-dimensional array. It would make this just bounds checks and one=
=20
> > line to get the data.
>
> Please note that this interface has the potential to brick in an irrevers=
ible
> way laptops and it has happened.

This function only prints values held by kernel in its internal storage?=20
How can that brick something?

> Of all the code CPU core handling it the most delicate code of all since
> a wrong value here means permanent irreversible damage.
>=20
> I am more than happy making changes that can be easily verified,
> but others more complex changes will put (at least) my own hardware
> at risk.

Understood.

> If you think benefit outweighs risks I will try my best.
> >> +=09return sysfs_emit(buf, "%u\n", cores);
> >> +}
> >> +
> >> +static ssize_t cores_current_value_store(struct kobject *kobj, struct=
 kobj_attribute *attr,
> >> +=09=09=09=09=09 const char *buf, enum cpu_core_type core_type)
> >> +{
> >> +=09u32 new_cores, perf_cores, power_cores, out_val, min, max;
> >> +=09int result, err;
> >> +
> >> +=09result =3D kstrtou32(buf, 10, &new_cores);
> >> +=09if (result)
> >> +=09=09return result;
> >> +
> >> +=09scoped_guard(mutex, &asus_armoury.cpu_core_mutex) {
> >> +=09=09if (core_type =3D=3D CPU_CORE_PERF) {
> >> +=09=09=09perf_cores =3D new_cores;
> >> +=09=09=09power_cores =3D asus_armoury.cpu_cores->cur_power_cores;
> >> +=09=09=09min =3D asus_armoury.cpu_cores->min_perf_cores;
> >> +=09=09=09max =3D asus_armoury.cpu_cores->max_perf_cores;
> >> +=09=09} else {
> >> +=09=09=09perf_cores =3D asus_armoury.cpu_cores->cur_perf_cores;
> >> +=09=09=09power_cores =3D new_cores;
> >> +=09=09=09min =3D asus_armoury.cpu_cores->min_power_cores;
> >> +=09=09=09max =3D asus_armoury.cpu_cores->max_power_cores;
> >> +=09=09}
> >> +
> >> +=09=09if (new_cores < min || new_cores > max)
> >> +=09=09=09return -EINVAL;
> >> +
> >> +=09=09out_val =3D FIELD_PREP(ASUS_PERF_CORE_MASK, perf_cores) |
> >> +=09=09=09FIELD_PREP(ASUS_POWER_CORE_MASK, power_cores);
> >> +
> >> +=09=09err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, out_val, &r=
esult);
> >> +=09=09if (err) {
> >> +=09=09=09pr_warn("Failed to set CPU core count: %d\n", err);
> >> +=09=09=09return err;
> >> +=09=09}
> >> +
> >> +=09=09if (result > 1) {
> >> +=09=09=09pr_warn("Failed to set CPU core count (result): 0x%x\n", res=
ult);
> >> +=09=09=09return -EIO;
> >> +=09=09}
> >> +=09}
> >> +
> >> +=09pr_info("CPU core count changed, reboot required\n");
> >
> > This interface has a problematic behavior. If user wants to adjust both=
=20
> > core counts one after another (without reboot in between), the new valu=
e=20
> > of the first core count will be overwritten on the second store.
> >
> > You might have to store also the value that will be used after the next=
=20
> > boot to solve it but how the divergence should be presented to user is=
=20
> > another question to which I don't have a good answer.
>
> Given what I have written above I am thinking more along the lines of all=
owing
> only one change at the time, giving absolute priority to the ability to d=
emonstrate
> not all P-cores can be disabled all at once, or after a reboot hardware w=
ill be
> irreversibly lost. It cannot be recovered the same way as I did with APU =
mem.
>=20
> To summarize I am more inclined in allowing only small changes,
> or to postpone this patch entirely while we think to a better, safer solu=
tion.

Fair enough, please mention this as in the changelog as a justification=20
and to warn other messing with the code.

> > This seems a more general problem, that is, how to represent values whi=
ch=20
> > are only enacted after booting (current vs to-be-current) as it doesn't=
=20
> > fit to the current, min, max, possible_values, type model.
> >
> Enabling eGPU on a laptop with a dGPU that is active makes the PCI-e
> spam PCI AER uncorrectable errors and renders both GPUs unusable.
>=20
> I have gone with storing the value at driver load time and treating it
> as the boot value for 2/9 (eGPU), but I am very open to suggestions!

I'm not entirely sure what you're trying to say here. My point is that=20
there's no way for user to know what value something will be changed to=20
(the "to-be-current" value) except through rebooting the system (when the=
=20
"to-be-current" value becomes the "current").

--=20
 i.
--8323328-1335968388-1760968966=:976--

