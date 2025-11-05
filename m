Return-Path: <linux-kernel+bounces-885980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F57C34706
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F36324E8620
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150F285074;
	Wed,  5 Nov 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obs/NTMD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1551F8723;
	Wed,  5 Nov 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330833; cv=none; b=N55aHgL9kbpVVwPMTwzmN+3jnho/SPnh8DxkXM11oykmGCTyTmPiUn+1MC+qzbFcaMhw8DMk5mMKQQY5Cal0+OmoBGKhsODMyQaRg9aNuA01nuUqXJ4DZQrLK2CznqDOex8U0IRWkXetiN/D2nDgefhjy0C0l860G+vrLX/7qXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330833; c=relaxed/simple;
	bh=0M+R2+DmnukaFATQy9kB0vDjA0hW6zSfLQJSFybEGrg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tN1l32Ylm1/8gHV+CT4QGw7/1uUqa8saulpDRb9FsdUXoVXIrgL9uZSa8IR5wF/OkOGblKqRTQ2bdab4ILKCR5/3Z8jl05hLf6LDXZtQNb6idXpBVVhfyDZgpBJGs3U8sdG1r7+9sXTrOhkJ9OBqb2HAftfhFbx2Vj08Fw9V42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Obs/NTMD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762330832; x=1793866832;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0M+R2+DmnukaFATQy9kB0vDjA0hW6zSfLQJSFybEGrg=;
  b=Obs/NTMD+LhYAHm9BnT0igdMMbgCRgK3UPmeUjg6thxTLcWcntlVq/Xl
   Zv0kuOukkXg8kXId06E4BDElSZhYZvYREHF86qBbJtz0h48jt1mKdz6tq
   LDJDIlIz4pa1xcDFOnHiopQfsG/ft5WVWIlNJQcmr1ICBwkl/4kvye+Ef
   tab9Qsfq/ANlEObW3R5QNB0IprKHv3L8xUQwiSV7UiH37Ut3/N5sFqVUx
   BclP4ohhrkudmIfEOMY+0Sl/Tk9N5/6NuD6XYO6R5pp54isJ3dciNOiLu
   BRJsPTrCc8peWeOUIs06CGr/INHPaM0UG+g96fQb816slwz0z3I2PHHAP
   A==;
X-CSE-ConnectionGUID: /4PvmQGyR9Wcjv203zZrPw==
X-CSE-MsgGUID: bISFOcOUScq0G50W2oteUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75787420"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75787420"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:20:31 -0800
X-CSE-ConnectionGUID: 4jG+jyGmS8SbnIz1fUaBOQ==
X-CSE-MsgGUID: 7TBVQ5uSRPqQAMaFhontoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187081224"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:20:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 10:20:24 +0200 (EET)
To: Rong Zhang <i@rong.moe>
cc: Ike Panhc <ikepanhc@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, 
    Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Use str_on_off() helper
In-Reply-To: <20251031184435.44819-1-i@rong.moe>
Message-ID: <b533597c-a2ba-4446-70fa-5a88926d5fd3@linux.intel.com>
References: <20251031184435.44819-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-322173085-1762330824=:33477"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-322173085-1762330824=:33477
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 1 Nov 2025, Rong Zhang wrote:

> Use the str_on_off() helper instead of open-coding the same operation.
> This improves code readability.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202510311551.xjWbHTrm-lkp@intel.com/
> Suggested-by: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/2bae2ea7-2ef9-0cfa-0c2c-39a7043b2aa5@linu=
x.intel.com/
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> This patch is based on 'review-ilpo-next' of pdx86/platform-drivers-x86,
> hence depends on my previous patch ("platform/x86: ideapad-laptop:
> Protect GBMD/SBMC calls with mutex").
> ---
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platf=
orm/x86/lenovo/ideapad-laptop.c
> index d2bfaa532020..931a72a2a487 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -475,25 +475,25 @@ static int debugfs_status_show(struct seq_file *s, =
void *data)
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
>  =09=09=09seq_printf(s, "Backlight now:  %lu\n", value);
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
> -=09=09=09seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off=
", value);
> +=09=09=09seq_printf(s, "BL power value: %s (%lu)\n", str_on_off(value), =
value);

This change should also add the include for str_on_off().

--
 i.

> =20
>  =09=09seq_puts(s, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
> =20
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
> -=09=09=09seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off",=
 value);
> +=09=09=09seq_printf(s, "Radio status: %s (%lu)\n", str_on_off(value), va=
lue);
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
> -=09=09=09seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off",=
 value);
> +=09=09=09seq_printf(s, "Wifi status:  %s (%lu)\n", str_on_off(value), va=
lue);
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
> -=09=09=09seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off",=
 value);
> +=09=09=09seq_printf(s, "BT status:    %s (%lu)\n", str_on_off(value), va=
lue);
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
> -=09=09=09seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off",=
 value);
> +=09=09=09seq_printf(s, "3G status:    %s (%lu)\n", str_on_off(value), va=
lue);
> =20
>  =09=09seq_puts(s, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
> =20
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
> -=09=09=09seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "of=
f", value);
> +=09=09=09seq_printf(s, "Touchpad status: %s (%lu)\n", str_on_off(value),=
 value);
>  =09=09if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
> -=09=09=09seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "of=
f", value);
> +=09=09=09seq_printf(s, "Camera status:   %s (%lu)\n", str_on_off(value),=
 value);
>  =09}
> =20
>  =09seq_puts(s, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
>=20
> base-commit: ba06b928f05bfd2785260819f6b34b658a04a4e6
>=20
--8323328-322173085-1762330824=:33477--

