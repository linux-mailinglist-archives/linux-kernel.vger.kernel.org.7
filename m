Return-Path: <linux-kernel+bounces-842732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B5EBBD6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E4D4E9761
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A62652AF;
	Mon,  6 Oct 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWZDfrNO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91E823DD;
	Mon,  6 Oct 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741942; cv=none; b=kpU7NbSqG3vMoEAdZJsAmpVFFnIVN8dZ1TkFZ6+Bm1Qv0hH17EUCkOm+VFDMPwmVe7O3ibjwWDHUWrKKGRwBEqZ/KSLYFmNODdwFdIO+Uw6seXMl2bwnv6C1yy97MbUs9mUmKrMbeCKSJ3xTLsVuQJ7OV1egGI69Qlew7GB/u3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741942; c=relaxed/simple;
	bh=rHxXosLOOB5DP8C0jB3HGSgVUyuiDjtUQAbeOeLamrk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DEYq93AqcoyJQAZxxHrndt8P5ha7ozlBmWZs28crCARh7ZorjYKbemjqLOqJ9M5BRUf55uHZMkZshp0mc0ZAGEudOo5Q597GhIw95HMfELHtYoNhRbjPIeLpCSl9h7kBzUtqKMU9la5wx3WNtPdvMriz2TO7E7RDQ7lg2zhOJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWZDfrNO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759741940; x=1791277940;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rHxXosLOOB5DP8C0jB3HGSgVUyuiDjtUQAbeOeLamrk=;
  b=aWZDfrNOgHK4TpsiH73WQDQoOx8yLsIG2t7TNV01DfHNFqVwNufSqHhF
   Cze4EUcNTbPsweQ7jQQut3u+IOTfYny0/DmcXN+WpTEjqkkxr+An2UES3
   +702XbMILtUfrrlqQbRvJKYOQvr5D5ljvT4GYCqCoKzwjXRz4NpBnZKsC
   ucT1aiT4RaJ4CxZ5zvMe33C17oTVKwzRxjTGGTZZyKS/5KOJ1B4AhAzxP
   Jwv2WwxwaChLNk5mReBsVApzn7zNyOzrCTAqUuhC90mC/RVLkcRZSWvqq
   50L6x7UtMswWhYqNjN+7U/96kTPkMO1q0ImyE8QXV0MRH9Qu7UQLAxx09
   w==;
X-CSE-ConnectionGUID: 1vVWnru6RBe4HRdlr46crA==
X-CSE-MsgGUID: u8hX+XI6SvWco8l5eU1h4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="73012571"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="73012571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 02:12:20 -0700
X-CSE-ConnectionGUID: ZgM1taHPQgeYYxweoMgcoQ==
X-CSE-MsgGUID: uvdz1Y1hRpmtvQeYRnfoKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="203571883"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 02:12:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Oct 2025 12:12:12 +0300 (EEST)
To: luke@ljones.dev
cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hans de Goede <hansg@kernel.org>, Denis Benato <benato.denis96@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
In-Reply-To: <E7993E86-3805-4E93-A714-0D4A33FBA759@ljones.dev>
Message-ID: <7c741d8d-dc07-7316-3999-cd69f2af67a3@linux.intel.com>
References: <20251003184949.1083030-1-benato.denis96@gmail.com> <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org> <36720829-6ba3-4178-952c-4236622edfa2@kernel.org> <ebe38602-1832-391f-b043-cae0c10d7e30@linux.intel.com>
 <E7993E86-3805-4E93-A714-0D4A33FBA759@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-544830337-1759741932=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-544830337-1759741932=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 6 Oct 2025, luke@ljones.dev wrote:
> > On 6 Oct 2025, at 10:31, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.=
com> wrote:
> > On Fri, 3 Oct 2025, Mario Limonciello (AMD) (kernel.org) wrote:
> >> On 10/3/2025 1:58 PM, Hans de Goede wrote:
> >>> On 3-Oct-25 8:49 PM, Denis Benato wrote:
> >>>> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTR=
AS
> >>>> DRIVERS" as suggested by Hans de Goede and Armin Wolf.
> >>>>=20
> >>>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> >>>> Link:
> >>>> https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gma=
il.com
> >>>=20
> >>> Thanks, patch looks good to me:
> >>>=20
> >>> Reviewed-by: Hans de Goede <hansg@kernel.org>
> >>>=20
> >>> Regards,
> >>>=20
> >>> Hans
> >>=20
> >> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >>=20
> >> Luke,
> >>=20
> >> You are planning to step down from maintainer too, right?  Can you sen=
d a last
> >> patch doing that too?  Or let Denis send one and Ack that?
>=20
> I will eventually step down yes. Denis asked me to stay on for the moment=
=2E

Fine, no pressure either way.

Could you please send your Acked-by tag to this thread so it will get=20
captured into this thread so the tools will capture it when I'm applying=20
the patch (assuming you're okay with him becoming a co-maintainer with=20
you, which I think is the case here :-)).

> >>>> ---
> >>>>  MAINTAINERS | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>=20
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index 156fa8eefa69..81bcb934748d 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -3841,6 +3841,7 @@ F: drivers/hwmon/asus-ec-sensors.c
> >>>>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> >>>>  M: Corentin Chary <corentin.chary@gmail.com>
> >>>>  M: Luke D. Jones <luke@ljones.dev>
> >>>> +M: Denis Benato <benato.denis96@gmail.com>
> >>>>  L: platform-driver-x86@vger.kernel.org
> >>>>  S: Maintained
> >>>>  W: https://asus-linux.org/
> >=20
> > Hi all,
> >=20
> > Unrelated to the patch itself, I'm more wondering if Corentin Chary=20
> > <corentin.chary@gmail.com> is still around as I don't recall ever heari=
ng=20
> > anything from that address in any context. The latest email from that=
=20
> > address lore.kernel.org could find is from 2017.
> >=20
> > Maybe we should remove that address from the maintainers list?
>=20
> I=E2=80=99d been wondering if that should be done. Though never was sure =
of the=20
> process or if that was okay.

Hans, any thoughts?

My opinion is we remove that address, there's little point in keeping=20
people around when they've stopped communicating years ago. For this=20
driver it's easy, but that address also appears for samsung-laptop.c
which doesn't have another maintainer.


--=20
 i.

--8323328-544830337-1759741932=:943--

