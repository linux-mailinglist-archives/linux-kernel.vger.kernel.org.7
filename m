Return-Path: <linux-kernel+bounces-818669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7EB594E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC8232371F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD0D2D3EFD;
	Tue, 16 Sep 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBDQ8tmH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7691D7E4A;
	Tue, 16 Sep 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021348; cv=none; b=WLAqTJOYUmiMROXzeuXBRDLpuJIO3x821lLgKLR7EXRePdsodyB3oN2MZZTBK1QBiBy47vWURLY+4DNCxVeErjiuI5wkbbLo50MvJvtQTziIFQpFj/7qad/puVexrtyl4/FAbydwF2NO8obt3uDKsSzhd5P/aqivMEO4F6D6ILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021348; c=relaxed/simple;
	bh=kHTIIpXobMwZq/UqsiuTGhnb66QAIDmBrduzUjcnw8c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BbBmcMV5kV3LduWTbEQ0i0x/EGgfj/A8hbM8bPvJcqzaDKlbTf98bgivOBwZofx0TMnxWw4hT2cI/O3VxPVmD4Q6C7224iwWWdDfnqe45K7cSMz83EUTTenvkBM3DhpncLAceEU2VjsfmFFSUWHtNG2b4O4re7CImV2h5tnCryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBDQ8tmH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758021346; x=1789557346;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kHTIIpXobMwZq/UqsiuTGhnb66QAIDmBrduzUjcnw8c=;
  b=cBDQ8tmHEC3e2+zu5rU0j4XuJJjCOHpjdg1VPQzqfbXxB6iZyJMYKqNs
   DqMwj1MjebAKUq6OBty+D//929RRHN0594SFDU1f2ioelgOwyuSpJkEB6
   6JS5hQZcem48v1yjMXF6HTY+BUBT1anfspjIB8qNjiu66z//daKvYcRUe
   dGayD2xnokVvnZrUaedNGmAcTXhfAawzov04STbUDw5m+WxR7pSpChFxF
   VnpPrHG3+XmxFVjFIV+sUOyRQRB49X5PW/6K7R2oXP13dDaYSTV3qY3jA
   6dd75v6wfDg19MEzyE4G2Vhtb+trI4FVhdCY9cWPIX79YxOHGRuMjSs/w
   A==;
X-CSE-ConnectionGUID: G1tsY+73TnqH9iumFlcszg==
X-CSE-MsgGUID: PJdqDWhXQKSQppnfIUSZ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70980327"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="70980327"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 04:15:45 -0700
X-CSE-ConnectionGUID: 8AOJYiOzTlyhE0Yobj6wIQ==
X-CSE-MsgGUID: 4taaoNrqSrCycZQdxeQ3uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174205452"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 04:15:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Sep 2025 14:15:38 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>, Rahul Chandra <rahul@chandra.net>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>, 
    stable@kernel.org
Subject: Re: [PATCH v1] platform/x86: asus-wmi: Re-add extra keys to
 ignore_key_wlan quirk
In-Reply-To: <20250916072818.196462-1-lkml@antheas.dev>
Message-ID: <30d3b204-c37d-0878-ee39-f5b14981197a@linux.intel.com>
References: <20250916072818.196462-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Sep 2025, Antheas Kapenekakis wrote:

> It turns out that the dual screen models use 0x5E for attaching and
> detaching the keyboard instead of 0x5F. So, re-add the codes by
> reverting commit cf3940ac737d ("platform/x86: asus-wmi: Remove extra
> keys from ignore_key_wlan quirk"). For our future reference, add a
> comment next to 0x5E indicating that it is used for that purpose.
> 
> Fixes: cf3940ac737d ("platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk")
> Reported-by: Rahul Chandra <rahul@chandra.net>
> Closes: https://lore.kernel.org/all/10020-68c90c80-d-4ac6c580@106290038/
> Cc: stable@kernel.org
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Thank you both, I've taken this to the review-ilpo-fixes branch.

And I'm sorry for the breakage (I was skeptical about removing those keys 
right from the start even if the original commit's changelog wasn't 
explaining these extra keys with the detail it should have to avoid us 
having to second guess).

If Rahul has actually tested the direct revert or this patch and wants to 
provide a Tested-by tag, I can still embed that into the commit until I 
push the pending changes to Linus.

> ---
>  drivers/platform/x86/asus-nb-wmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 3a488cf9ca06..6a62bc5b02fd 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -673,6 +673,8 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
>  		if (atkbd_reports_vol_keys)
>  			*code = ASUS_WMI_KEY_IGNORE;
>  		break;
> +	case 0x5D: /* Wireless console Toggle */
> +	case 0x5E: /* Wireless console Enable / Keyboard Attach, Detach */
>  	case 0x5F: /* Wireless console Disable / Special Key */
>  		if (quirks->key_wlan_event)
>  			*code = quirks->key_wlan_event;
> 
> base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
> 

-- 
 i.


