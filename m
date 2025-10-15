Return-Path: <linux-kernel+bounces-854445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954BBDE64D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE4B04F1888
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC75326D61;
	Wed, 15 Oct 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3XMQzW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B63324B30;
	Wed, 15 Oct 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529995; cv=none; b=hUV4FG6DGftYMrSvP4nAxfm3fA4V2Afhnr9HOLq7glc818MOKx8v8ziPu1YaYrjxCOwUnX81/0cFIKnnYLwGVIqaZvjcehfKa0flMLl11tUh5lDFFzH3tH5Y5rDZIEPHoJJ2CKBi2SeLz8pWWd7MMHGultre3cN/wCcrSUu5gwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529995; c=relaxed/simple;
	bh=yQEpOxPTGcBaKmexZ9nGco41a3Mmcbamj3F4YNeLBd4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jDCgZ004Do5OQGr2+QW67ZS60KcvJWQG3W2OjtvxtRagRRnFd5PKv9RpBoIyjDP2tfBfaHXrGmPlyAAFQ0lTg2j8ZO7/N4WpbEChQ4tpK4OFN9cxTUu32uCSCRPptLEkPSKI2SUldx/iiw1KtRH+ziwMEF57JJBKnvTyv0q4x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3XMQzW+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760529993; x=1792065993;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yQEpOxPTGcBaKmexZ9nGco41a3Mmcbamj3F4YNeLBd4=;
  b=F3XMQzW+wZcN1VXdCti3DUCN/LdaaKIZrd+qrUzhloI5kH1hm1TlngUP
   MmkRmptHND+pfI1qeHtqSm49bvTxp1jY+g/3l3wvzOsiWY8EiDCXhBi8f
   RYPoGD4SL5K2CXz9BP6GjpDL6+shZ7jjk1ewthLLpj3mfI4qYkrcNXwn+
   jdaDHQsXIspZlCxlU6p+x+Y2V9ThvdYESSlSYjxawcSiv9TKU6BJSrbkZ
   DGO9h/pjBIjzHBA5X25DZZP42SWPbbAIko1S51KNMp6Msyu5eFXbT/d29
   j78r8qNspy6zFhHWc9ZK4Aj54uxgRyzh/6A63BJ6OvxT1gT70nTb36iEu
   Q==;
X-CSE-ConnectionGUID: tb0z5fVpQ+yX24HBwSlLYA==
X-CSE-MsgGUID: aC/hed6uQrqTVcHeZs/yKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="85320267"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="85320267"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:06:32 -0700
X-CSE-ConnectionGUID: By3WkWfvSyyjEwR2Yw0i8Q==
X-CSE-MsgGUID: rtd8vhKJSDmS/MmSR55sBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="186416339"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:06:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 15:06:25 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: Mario Limonciello <mario.limonciello@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>, 
    Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 0/9] platform/x86: Add asus-armoury driver
In-Reply-To: <97c56897-ed9b-4d4d-ba54-d6e2abbc8b0d@gmail.com>
Message-ID: <66bb61ca-94ae-7f0a-ce9f-f5c13b51eb01@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <0752fcde-6c25-4cde-b35f-2204e24ff0f1@amd.com> <8e381c36-3bdf-a1d6-8e51-53243ba8bf4d@linux.intel.com> <97c56897-ed9b-4d4d-ba54-d6e2abbc8b0d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-325223156-1760529985=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-325223156-1760529985=:957
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Oct 2025, Denis Benato wrote:

>=20
> On 10/15/25 11:38, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 15 Oct 2025, Mario Limonciello wrote:
> >> On 10/14/2025 8:47 PM, Denis Benato wrote:
> >>> Hi all,
> >>>
> >>> the TL;DR:
> >>> 1. Introduce new module to contain bios attributes, using
> >>> fw_attributes_class
> >>> 2. Deprecate all possible attributes from asus-wmi that were added ad=
-hoc
> >>> 3. Remove those in the next LTS cycle
> >>>
> >>> The idea for this originates from a conversation with Mario Limonciel=
lo
> >>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4=
ec27a945c99@amd.com/
> >>>
> >>> It is without a doubt much cleaner to use, easier to discover, and th=
e
> >>> API is well defined as opposed to the random clutter of attributes I =
had
> >>> been placing in the platform sysfs. Given that Derek is also working =
on a
> >>> similar approach to Lenovo in part based on my initial work I'd like =
to
> >>> think
> >>> that the overall approach is good and may become standardised for the=
se
> >>> types
> >>> of things.
> >>>
> >>> Regarding PPT: it is intended to add support for "custom" platform pr=
ofile
> >>> soon. If it's a blocker for this patch series being accepted I will d=
rop the
> >>> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that =
done
> >>> separately to avoid holding the bulk of the series up. Ideally I woul=
d like
> >>> to get the safe limits in so users don't fully lose functionality or
> >>> continue
> >>> to be exposed to potential instability from setting too low, or be mi=
slead
> >>> in to thinking they can set limits higher than actual limit.
> >>>
> >>> The bulk of the PPT patch is data, the actual functional part is rela=
tively
> >>> small and similar to the last version.
> >>>
> >>> Unfortunately I've been rather busy over the months and may not cover
> >>> everything in the v7 changelog but I've tried to be as comprehensive =
as I
> >>> can.
> >>>
> >>> Regards,
> >>> Luke
> >> As a general comment that applies to a few patches in the series.
> >>
> >> The S-o-b means that YOU sign off on them, it's like a chain of custod=
y.
> >>
> >> Any patches that you're sending need your own S-o-B, even if they're 1=
00% the
> >> same as the original from Luke.
> > There's also Co-developed-by tag which may be appropriate in cases wher=
e=20
> > both have touched the patch.
> >
> I have re-read the submission documentation and confirmed I need at least
> S-o-b for all of them. Is it acceptable if I simply answer to the email w=
ith my S-o-b
> and Co-developed-by (on patches I have touched) or do I need to resend
> the whole patchset creating a v15?

Hi Denis,

Please wait a bit with v15, I'll try to take a look at this series=20
hopefully before the end of this week and I suspect there will be more=20
changes needed as a result (not to doubt your effort but it's long time=20
since I've looked at it).

--=20
 i.

--8323328-325223156-1760529985=:957--

