Return-Path: <linux-kernel+bounces-841216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4DBB685C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D356A4EB919
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEE2EB851;
	Fri,  3 Oct 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7gbZbRg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCD2EB846
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489885; cv=none; b=arNno/SvIXNVaAKzRco7ySFw1aSrAq9wmSF+0yvh7RBgWt7x4fw/WZDvMPYYV1ctw5/NjKRT6UGnD9V8iolciHQK4tStyjBbms5diPblo8XmTJya3k5oE0lWPIYFKRqCVgJL0piBcigkCH/fu6qlkV+ukK/rp9WhPeH9nEcvseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489885; c=relaxed/simple;
	bh=TJ/zTARjd6zDQqIFw2UEQM3Af58gXd0HfmyZ/pNfT+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hkkLiVxGSckl+m5m8m6PGnMH6G+1teoQ+inUN4kivilTb+kvhmOfU5bsm4nRcyCE4Pq2GDZst2tGBaLNdGplZufIRFIoa151VD7sX0ByU6eSyd8LWSZP7N9BC14dTDpCH1hXmYThejik082SxIG4yaexDK6BZevDXK2CN3cnf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7gbZbRg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759489883; x=1791025883;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=TJ/zTARjd6zDQqIFw2UEQM3Af58gXd0HfmyZ/pNfT+I=;
  b=c7gbZbRgtVlZPsXijBqXi+sjSQTQRzwnDaRGlt6NmJyC9gZU2lAsE3Ys
   OGbEbZaXh0ScOjyKMyrubRUQ6ES24ymYaTcWRGrCFOqxYHIpvYzQ03AGV
   9pIKJkQvS+5n4X0V/Aqar/gaYu5FyBHtZKvEP1AUS232X25lXayKZFpZZ
   /PU/sy/Ky4sMppvNkU0pBHqOYvcuaUJeuqxRRQzouou68Qru1nlrHoRAV
   5MDVn9Pe81u4HIu6YiL7oKcbWZhoEN+ZVaMcH489RpWwyThME0UhtIV6r
   tXrBYP9sNaUTWnnsQyfb6sTZAOddV+sfQcjKEJixtIsyClvafqEvKvrZo
   g==;
X-CSE-ConnectionGUID: 8BTBOiVmTtKHbE91ZgxkXQ==
X-CSE-MsgGUID: FASQlPFAREWKyxE1BRjmnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72448902"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="72448902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 04:11:22 -0700
X-CSE-ConnectionGUID: ovhbu1PYSiKLcRvdCvHezg==
X-CSE-MsgGUID: hVMv4WNBSzKNCrGoQPRhCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="178870975"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.94])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 04:11:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chintan Patel <chintanlike@gmail.com>,
 maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com, Chintan Patel
 <chintanlike@gmail.com>
Subject: Re: [PATCH v3] drm/vblank: downgrade vblank wait timeout from WARN
 to error
In-Reply-To: <20251003032303.16518-1-chintanlike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251003032303.16518-1-chintanlike@gmail.com>
Date: Fri, 03 Oct 2025 14:11:15 +0300
Message-ID: <5871956eef6c89f8361faae84c515c0e8356fc71@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 Oct 2025, Chintan Patel <chintanlike@gmail.com> wrote:
> When wait_event_timeout() in drm_wait_one_vblank() times out, the
> current WARN can cause unnecessary kernel panics in environments
> with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
> under heavy scheduling pressure or in rare cases of delayed vblank
> handling, and are not always a kernel bug.
>
> Replace the WARN with drm_err() messages that report the timeout
> without crashing the system. Developers can still enable drm.debug
> to diagnose genuine problems.

No need to resend for this, can be fixed while applying, but the last
sentence is no longer meaningful with drm_err().

BR,
Jani.

>
> Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D147ba789658184f0ce04
> Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>
> v2:
>  - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
>  - Remove else branch, only log timeout case
>
> v3:
>  - Use drm_err() instead of drm_dbg_kms() (suggested by Ville Syrj=C3=A4l=
=C3=A4)
>  - Remove unnecessary curr =3D drm_vblank_count() (suggested by Thomas Zi=
mmermann)
>  - Fix commit message wording (=E2=80=9Cinvalid userspace calls=E2=80=9D =
=E2=86=92 =E2=80=9Cdelayed vblank handling=E2=80=9D)
> ---
>  drivers/gpu/drm/drm_vblank.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 46f59883183d..0664aea1b924 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1305,7 +1305,8 @@ void drm_wait_one_vblank(struct drm_device *dev, un=
signed int pipe)
>  				 last !=3D drm_vblank_count(dev, pipe),
>  				 msecs_to_jiffies(100));
>=20=20
> -	drm_WARN(dev, ret =3D=3D 0, "vblank wait timed out on crtc %i\n", pipe);
> +	if (!ret)
> +		drm_err(dev, "vblank wait timed out on crtc %i\n", pipe);
>=20=20
>  	drm_vblank_put(dev, pipe);
>  }

--=20
Jani Nikula, Intel

