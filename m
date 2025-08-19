Return-Path: <linux-kernel+bounces-775362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF5BB2BE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8019016135E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6C31B138;
	Tue, 19 Aug 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSDQO6+w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C29311C16;
	Tue, 19 Aug 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597635; cv=none; b=dPpUAwqVoPYmr7x1FmSM9xenOVUvcapPYW0o93QqsrJdhXW+i0Z2vRaPjYKKc/YISwjA7j/aUxfvQqKK6bCA+qW9TgIqKejD8yvChDhmpf5ElwonUAD8Urflzu5JJwxMw45/ZfvhxQSMOXbM0tVeVYAX9Eqo4g8nW4e9wlQfScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597635; c=relaxed/simple;
	bh=BY8bJb20U9mG5LpbeW/O5Prv0q93kHOPqPkHxNam+Jc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R1UwPBJPu/4MUSedKYJY2C5pT7iYYK9YUX/kMywTHCBDCDIFn4OBUCVbsu0d9M4p0SmIF+woCmY5/Pcs7jmHRjYB7iIb6UYaRiCGVX3Q1dCeybxZRkTslyl0L+j/hbyhc1+NnFQhvIdNQr9AsiJ5PX7ZnOIyDiQRPRMUtRY3zRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSDQO6+w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755597634; x=1787133634;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BY8bJb20U9mG5LpbeW/O5Prv0q93kHOPqPkHxNam+Jc=;
  b=cSDQO6+w/MMLixqoaq50n/7PYk4uPD/KHOaFwWot/xoNZzKXqZEO6yR7
   fdn7MMyzRRf9En2E0oHYyFf0HZ83kJvs1moaNk4kqjYwh/bv0bYoZyq0l
   HUeomknO5XdlCJ/Jy4nqBQ/4A3ZqN48aQStbMYAvL25Bloc4t4AEx6ed2
   ZD9DFUF/h/6ylAE/cN+kKBpZ556iI+A9BSLPHrdFyYbzO/v/8Rw9etByR
   UWJCjTOMXN/NVSDWKIM3OKsV2nUIdOk1b0kyEG1mrtgTAiWzKfS03S6fQ
   TJXn5uuSap2JylEpkrjeLl6eH5ogFRU2hTstgQ4TNL9ceF00Y0D0HbRfD
   A==;
X-CSE-ConnectionGUID: SrR5WzDIQBa9ZMlg85sIsA==
X-CSE-MsgGUID: jcMGdhJCQ6OWeWHyVBrwHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="75288477"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="75288477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 03:00:34 -0700
X-CSE-ConnectionGUID: BLQl8fdfRe+VxWdFoD/sFw==
X-CSE-MsgGUID: N0UNk5I+TfeVEYZJp5QNkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167045565"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 03:00:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Aug 2025 13:00:27 +0300 (EEST)
To: =?ISO-8859-15?Q?Miguel_Garc=EDa?= <miguelgarciaroman8@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    krzk@kernel.org
Subject: Re: [PATCH v3] platform/x86: surfacepro3_button: replace deprecated
 strcpy() with strscpy()
In-Reply-To: <20250728201135.584023-1-miguelgarciaroman8@gmail.com>
Message-ID: <b6cb7905-8906-27eb-60a4-4475cd3f709a@linux.intel.com>
References: <20250728194942.558194-1-miguelgarciaroman8@gmail.com> <20250728201135.584023-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1654603073-1755597627=:949"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1654603073-1755597627=:949
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Jul 2025, Miguel Garc=C3=ADa wrote:

> Replace strcpy() with strscpy() when copying SURFACE_BUTTON_DEVICE_NAME
> into the device=E2=80=99s embedded name buffer returned by acpi_device_na=
me().
> Bound the copy with MAX_ACPI_DEVICE_NAME_LEN to guarantee NUL-termination
> and avoid pointer-sized sizeof() mistakes.
>=20
> This is a mechanical safety improvement; functional behavior is unchanged=
=2E
>=20
> Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
> ---
> v2:
>  - Use MAX_ACPI_DEVICE_NAME_LEN instead of sizeof(name).
>=20
> v3:
>  - Add full commit message (v2 was sent without message).
>=20
> Testing:
>  - Build-tested on x86_64 (defconfig, allmodconfig, W=3D1).
>  - No runtime testing on Surface hardware
>=20
>  drivers/platform/surface/surfacepro3_button.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/plat=
form/surface/surfacepro3_button.c
> index 2755601f979c..772e107151f6 100644
> --- a/drivers/platform/surface/surfacepro3_button.c
> +++ b/drivers/platform/surface/surfacepro3_button.c
> @@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *dev=
ice)
>  =09}
> =20
>  =09name =3D acpi_device_name(device);
> -=09strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
> +=09strscpy(name, SURFACE_BUTTON_DEVICE_NAME, MAX_ACPI_DEVICE_NAME_LEN);

As mentioned earlier, I'd prefer this to use the two argument version of=20
strscpy():

=09strscpy(acpi_device_name(device), SURFACE_BUTTON_DEVICE_NAME);

=2E..Changing to that may mean changes to name variable as well (remove=20
it?).

--=20
 i.

--8323328-1654603073-1755597627=:949--

