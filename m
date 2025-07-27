Return-Path: <linux-kernel+bounces-747283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED9B131CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F7E1895CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5188237173;
	Sun, 27 Jul 2025 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0jSj32b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730A1A83F7;
	Sun, 27 Jul 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648347; cv=none; b=EOc8A22urqqaJgnrpoXZJgyqcsSB4M5V6ej666gdzGrxVAAH7SZHP0aDu3xlBVA6Cugq2nV/GLcPg1y2nnzouHi7lWXilQdEKeUXtSN6FjiN0IkHfdsbJnaek9Tu3rb6xSSzkMaZ+v5g4kA3My7f3Y6Tx600pol0Vc3652L1GFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648347; c=relaxed/simple;
	bh=mRHmeeWqiX/Yg/gASLEy0XlfdLSr8CJCvmN3dE9dHUo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rDD4GASXkqsj9lmMmuUMKgW4iyFDF1JVVcYd8WydlLbrjN4+n1jtw9HV6+JU4Rx90rq1/fdY1EzaFWHvMNKYNRRTV9hHAVHbQsG6+oEA8sLoYOCIxCPzj6LE2OiK8Ny7a5PA6bb6XNVV9aet9sH+EIGpNyKKepCfLwPd/moVv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0jSj32b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753648346; x=1785184346;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mRHmeeWqiX/Yg/gASLEy0XlfdLSr8CJCvmN3dE9dHUo=;
  b=M0jSj32bVtyOj28cNR4o1R3l2204ijyNmOeN2KzS5rlm3CHqusjSUhqT
   HMPvH0EHuxEtammbVw09MTxyv82/ZXtVPDW3pbs4O8BY5C1U1lzUNSLRM
   2xNuDXJyWIvTWuj+CqnE0HJNgTKuIqMwz9QlerMfhZh4BeeyLjm6mfvEf
   qy/JBP5g4kweysTO3CX9P4995TJlJCx0sPN8ohvd5YD0H2OknFDikXuaN
   JcZIosM/GdcpoTu3Q/NfXiJj4+U/QkW0TCZvAUAEQAjcv7RvLJIgDX5ye
   9F3/EsMBP2TuQFEfe21u+IeEsN5OunSotpVV3iNKmsi+qAgbr9GGpt4rm
   w==;
X-CSE-ConnectionGUID: nljQ0JJdRqe68xf87x4uyg==
X-CSE-MsgGUID: qXoA/4V+RQe8QNDQFa10yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="56048910"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56048910"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 13:32:25 -0700
X-CSE-ConnectionGUID: KaouQby3RCicAKd7wSL3Ww==
X-CSE-MsgGUID: PWwTZZXwQbiuKdCPDDYSIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161834210"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 13:32:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 27 Jul 2025 23:32:18 +0300 (EEST)
To: =?ISO-8859-15?Q?Miguel_Garc=EDa?= <miguelgarciaroman8@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    yu.c.chen@intel.com, hansg@kernel.org, luzmaximilian@gmail.com, 
    skhan@linuxfoundation.org
Subject: Re: [PATCH] platform/x86: surfacepro3_button: replace deprecated
 strcpy() with strscpy()
In-Reply-To: <20250724074539.37650-1-miguelgarciaroman8@gmail.com>
Message-ID: <77116abd-289e-efc6-c358-e4a1a1fc0131@linux.intel.com>
References: <20250724074539.37650-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-756295865-1753648338=:1365"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-756295865-1753648338=:1365
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Jul 2025, Miguel Garc=C3=ADa wrote:

> strcpy() is deprecated for NUL-terminated strings. Replace it with
> strscpy() to guarantee NUL-termination. 'name' is a fixed-size local
> buffer.
>=20
> Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
> ---
>  drivers/platform/surface/surfacepro3_button.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/plat=
form/surface/surfacepro3_button.c
> index 2755601f979c..9616548283a1 100644
> --- a/drivers/platform/surface/surfacepro3_button.c
> +++ b/drivers/platform/surface/surfacepro3_button.c
> @@ -211,7 +211,7 @@ static int surface_button_add(struct acpi_device *dev=
ice)
>  =09}
> =20
>  =09name =3D acpi_device_name(device);
> -=09strcpy(name, SURFACE_BUTTON_DEVICE_NAME);
> +=09strscpy(name, SURFACE_BUTTON_DEVICE_NAME, sizeof(name));

strscpy() should nowadays support 2 args variant through clever macro=20
trickery.

--=20
 i.

--8323328-756295865-1753648338=:1365--

