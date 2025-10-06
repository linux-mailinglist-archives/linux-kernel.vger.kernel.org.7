Return-Path: <linux-kernel+bounces-842707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5DBBD5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18632349C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5523261B71;
	Mon,  6 Oct 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7KT33oQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C433993;
	Mon,  6 Oct 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739513; cv=none; b=rYGRn8XLspONh+nyqIn6wlY887yI5lpFRsE4o43q6afVpsNplcs5UxAGVgKqOfkxpxxg8LgKV0s+6qrl23kpgW2LKuVwQ1Vzbubi7zunZiivhxQ+dzUMXw0SnGKQ2ZlYkIYxdfwxqPFHzsNE9/m1lz+g25wQ+UxgkZ6uW9gVccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739513; c=relaxed/simple;
	bh=+4Ak9WWJ+e80OAageRHyYyGKGpR3BMJGglz0LqhJtVs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IhHtsw0Vw92GxaOLfKf2XDuHyoJFbE3LNQAYu/ccFTzpMHHKf+9mej3CHKkjwz21TVt0MaFiNEUGKwIphvEk/asvmETqgXAIHTCbQ3fhj1YS5xP+O7pmMLAzecV8zI1kY+cD4vnwArtus+2cKK1X4zEamCZd0DmO/1T1MhWjSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7KT33oQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759739512; x=1791275512;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+4Ak9WWJ+e80OAageRHyYyGKGpR3BMJGglz0LqhJtVs=;
  b=Y7KT33oQCV2MY5GWzYkbEu35Mx5HLjsyyuVONQj/cj0PtZoY5lYyS7jj
   hH4xl02CB6FEj18Hl9rgp/+Cqevl8BKvo2vQiyT39htSghL95hMZYbVmn
   BPl5y8iszAMTPk57Tuql4yyZvXriQq91waxkmGHDNyJEYorviBjylM3Hg
   Lm+5Do/mx+Pb91GSvRfxMsx18bECBEP2TGuVxPFiVG5v7uV1gKFVZ8Vfz
   qGhUYEaglCVbUAmFg5zhK8NDwIeks0cde7s4XlF/kfo4n7wjPxDHErS3v
   dXFn4WzFib1o+cHWIFMI988HM7K1PHTQvuWfSTs2+Z8QarOxhg09ox5+X
   w==;
X-CSE-ConnectionGUID: A1aDKrcATlyPgxRr6QC9/w==
X-CSE-MsgGUID: oGnwkIZFRJerYq9+yfW4ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="65557159"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="65557159"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:31:50 -0700
X-CSE-ConnectionGUID: bQxTqlBJTl6cCgDTWOV+RA==
X-CSE-MsgGUID: Fo3iJf5mR3y3dkE6/v+HSQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:31:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Oct 2025 11:31:42 +0300 (EEST)
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hans de Goede <hansg@kernel.org>, Denis Benato <benato.denis96@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
In-Reply-To: <36720829-6ba3-4178-952c-4236622edfa2@kernel.org>
Message-ID: <ebe38602-1832-391f-b043-cae0c10d7e30@linux.intel.com>
References: <20251003184949.1083030-1-benato.denis96@gmail.com> <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org> <36720829-6ba3-4178-952c-4236622edfa2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Oct 2025, Mario Limonciello (AMD) (kernel.org) wrote:
> On 10/3/2025 1:58 PM, Hans de Goede wrote:
> > On 3-Oct-25 8:49 PM, Denis Benato wrote:
> > > Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
> > > DRIVERS" as suggested by Hans de Goede and Armin Wolf.
> > > 
> > > Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> > > Link:
> > > https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com
> > 
> > Thanks, patch looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hansg@kernel.org>
> > 
> > Regards,
> > 
> > Hans
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Luke,
> 
> You are planning to step down from maintainer too, right?  Can you send a last
> patch doing that too?  Or let Denis send one and Ack that?
> 
> > 
> > 
> > 
> > > ---
> > >   MAINTAINERS | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 156fa8eefa69..81bcb934748d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3841,6 +3841,7 @@ F:	drivers/hwmon/asus-ec-sensors.c
> > >   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> > >   M:	Corentin Chary <corentin.chary@gmail.com>
> > >   M:	Luke D. Jones <luke@ljones.dev>
> > > +M:	Denis Benato <benato.denis96@gmail.com>
> > >   L:	platform-driver-x86@vger.kernel.org
> > >   S:	Maintained
> > >   W:	https://asus-linux.org/

Hi all,

Unrelated to the patch itself, I'm more wondering if Corentin Chary 
<corentin.chary@gmail.com> is still around as I don't recall ever hearing 
anything from that address in any context. The latest email from that 
address lore.kernel.org could find is from 2017.

Maybe we should remove that address from the maintainers list?

-- 
 i.


