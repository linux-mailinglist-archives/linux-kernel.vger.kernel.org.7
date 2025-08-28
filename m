Return-Path: <linux-kernel+bounces-789786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F6B39AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FF51894D68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074AA266581;
	Thu, 28 Aug 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCDYFqg5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CF30DD04;
	Thu, 28 Aug 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378264; cv=none; b=K8qReS44SnzZRmC14VVJRYfunGLr87oIg3zujOUThc+aAdDmzBsADjqfYRmjqz3Nlue9P9RUAU/9/6XRw0QJ8VrNlpWiKrXpniXSq+7yBUMWYsC9kABrDdpl8Yp+LBOKJ89OuBrCgAfRLCPzBOiRkPmii1AFNnuwC3oCa67IUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378264; c=relaxed/simple;
	bh=c/PUxj+uLPNIslaZ9UKyYAl/SqcMxUK3XVmgAyCTiNQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ouk1q5hAKNl0+6HIAgN6KWPz/azc8vJKtvipljmIUH3yd/hKMWWkPYcA1p8e1T0UHdFNH3NG1PlIR/ZSirk34jliUDY9no7LywOw9N3BU2Qc3Sf1OiLnjDwrOtwhFRhLVL/3Dt3c3z3NLFkOWOY69MuiZCjmyxIWYd7fotvmPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCDYFqg5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756378263; x=1787914263;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c/PUxj+uLPNIslaZ9UKyYAl/SqcMxUK3XVmgAyCTiNQ=;
  b=MCDYFqg5Ih8iK80vVrmATH9PEVL04klDxcLVFEuUSDuH7raB6SAiyX4v
   fsPyioDLG/MuyyFo4r8LJOxEvhttefWY/85/c4exOXCniVHzeOn2e2O11
   4PD+igp8XJAJvqc0HdS9ikBwwioiJrwfxozqMTlY1z+YyV8243ZzES7Og
   T1o0z3y+UxtCgqQitXm4sXi9Gb1kO1n352rzsXUOBxAoQ+rLl/SALjUTL
   nkJDWr0dGLurv+Z4SDbt9G4sdG3dbkcFyjjCMHb6tqLtH2GyZQ0xaWPLN
   PjHAU46rGzULwhEArSCHzYjHappb6yexJ9uQL5kho5XnpgdGKS77nAj3O
   g==;
X-CSE-ConnectionGUID: dm1t04wQR165o0/hdQ6JwA==
X-CSE-MsgGUID: m4VFK9/LSrq0ZFART558Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62477227"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62477227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:51:02 -0700
X-CSE-ConnectionGUID: sLwd9dEuRwy5vGLYdyP1Bg==
X-CSE-MsgGUID: v0WK6UTrTHmIrXsv7jL3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169377105"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:51:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 13:50:56 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: hansg@kernel.org, kean0048@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] platform/x86: think-lmi: Add certificate GUID
 structure
In-Reply-To: <20250825160351.971852-2-mpearson-lenovo@squebb.ca>
Message-ID: <a5ecc59a-65bb-a270-9642-f2c59fc958ce@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20250825160351.971852-1-mpearson-lenovo@squebb.ca> <20250825160351.971852-2-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-532599953-1756378256=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-532599953-1756378256=:938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 25 Aug 2025, Mark Pearson wrote:

> Add a certificate GUID structure to make it easier to add different
> options for other platforms that need different GUIDs.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2:
>  - split patch up into series
> Changes in v3:
>  - add field details to thinkpad_cert_guid declare.
>  - add missing comma
>  - Move null thumbprint GUID check to later in series
>=20
>  drivers/platform/x86/lenovo/think-lmi.c | 38 +++++++++++++++++++------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x=
86/lenovo/think-lmi.c
> index 0992b41b6221..a22d25f6d3c6 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -177,6 +177,28 @@ MODULE_PARM_DESC(debug_support, "Enable debug comman=
d support");
>  #define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
>  #define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
> =20
> +struct tlmi_cert_guids {
> +=09char *thumbprint;
> +=09char *set_bios_setting;
> +=09char *save_bios_setting;
> +=09char *cert_to_password;
> +=09char *clear_bios_cert;
> +=09char *update_bios_cert;
> +=09char *set_bios_cert;

const char

> +};
> +
> +static struct tlmi_cert_guids thinkpad_cert_guid =3D {

These are not supposed to be altered, right? If so, this should be const=20
then.

> +=09.thumbprint =3D LENOVO_CERT_THUMBPRINT_GUID,
> +=09.set_bios_setting =3D LENOVO_SET_BIOS_SETTING_CERT_GUID,
> +=09.save_bios_setting =3D LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
> +=09.cert_to_password =3D LENOVO_CERT_TO_PASSWORD_GUID,
> +=09.clear_bios_cert =3D LENOVO_CLEAR_BIOS_CERT_GUID,
> +=09.update_bios_cert =3D LENOVO_UPDATE_BIOS_CERT_GUID,
> +=09.set_bios_cert =3D LENOVO_SET_BIOS_CERT_GUID,
> +};
> +
> +static struct tlmi_cert_guids *cert_guid =3D &thinkpad_cert_guid;

const here as well. Please also note my comment on placement of this in=20
patch 2.

--=20
 i.

--8323328-532599953-1756378256=:938--

