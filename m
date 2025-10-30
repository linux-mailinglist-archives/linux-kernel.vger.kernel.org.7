Return-Path: <linux-kernel+bounces-877933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925FC1F626
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54D9189FC77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E634A3AE;
	Thu, 30 Oct 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXWgcvfg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D115347FD7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817696; cv=none; b=KFBFgoTfmII2Cv7JVUl5+ypEI2cPxl949M5A6Y/d7acDZwhnzwsGPFcUyUlkdFn5eaJMgqCla5fZxutbelGGz4QSvslNRJqqPSxDtHrVJ47lgOdecNNDz3Wvt9d9tSrmaQixXdNP918lHD8E+jPAH4t9J/NBWs1wohRM3caqF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817696; c=relaxed/simple;
	bh=ebOkeb7fxZTrz/OPkH20h6r0CxV5A7mfKGATB6/yINM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5Z8Yjv0S7l2MKm9KSvuJZLBt09N8B3TXEf8jl9dlbAL6lMIoO1HKoOrVWJzRYuRqVswbSRUK/IKspRzb/O4Yh5UotvtetksHkP2Iu+X2K1Z94jiRQD4QN7e0mhl6syPzqw02KoqIeL0d0900gGRamH7Syt0PQCAOse+D0A9pWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXWgcvfg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761817694; x=1793353694;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ebOkeb7fxZTrz/OPkH20h6r0CxV5A7mfKGATB6/yINM=;
  b=AXWgcvfgjoa3EWq3GYW/cEj69YuoZiadqgG3EGGfD9iBGf+A6+IwiR0B
   1dMUMmrkaQKtzZP+fFA/ir0SkyGRZHXc/t6aXE9ncaSwqtdqH+xibD9li
   7+K3JMwXtYHm4AskMrLoFHCr3dXDl7cDuFjn2GSILHtOB+tiZ/t37MUAY
   kNvGpEjF2coz0Ns7ow5ZrCyWeHfeYrRTzJX0jwSZmQEUA39vtLUXwU+vX
   fl84b46jWwnjxOwQ9DCXTIXUIiioi+DtLucOaLJZKhULNvppTosQPyCbh
   zKQJagvMR303/8rbMvwlvafR4zmi5vS7myTG3vaDvx0nvEFB3hvjJGtlr
   Q==;
X-CSE-ConnectionGUID: 0CFQvpzzR7aG03RlgB6IvQ==
X-CSE-MsgGUID: gvSLfvM+QYWwTpW7CA9DGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81582606"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81582606"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:48:13 -0700
X-CSE-ConnectionGUID: ZDaYvyR+TOmXAeN/5d+Waw==
X-CSE-MsgGUID: X3rgFlSLS5GAnqeM2c8tnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186653866"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.223])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:48:09 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Doug Anderson <dianders@chromium.org>, Ajye Huang
 <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, jazhan@google.com
Subject: Re: [PATCH v1 1/2] drm/panel-edp: Add override bpc quirk for
 generic edp
In-Reply-To: <CAD=FV=X9hUxsrJ6o5yP0-bprfKgyQzZJnQRwQVYRo6G0yKWhCg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=X9hUxsrJ6o5yP0-bprfKgyQzZJnQRwQVYRo6G0yKWhCg@mail.gmail.com>
Date: Thu, 30 Oct 2025 11:48:06 +0200
Message-ID: <3ad3ee47f29f7b6479ec19b8fb61eee443a17264@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 29 Oct 2025, Doug Anderson <dianders@chromium.org> wrote:
> At first I was thinking that the quirks in "drm_edid.c" were probably
> just for "DP" display, but then I just realized that they probably
> also are for "eDP" panels. Specifically I think Intel hardware doesn't
> use panel-edp.c so I think the only place quirks could get applied (if
> an eDP panel was also used on Intel hardware) was from "drm_edid.c".
>
> Any chance you could confirm if EDID_QUIRK_FORCE_6BPC works for you?
>
> Does anyone else CCed have an opinion of which they like better?

No strong opinions, but obviously having it in drm_edid.c would be more
generic. Until you encounter panels where you need to force something
other than 6 bpc, when it stops being generic and becomes an
obstacle. ;)

BR,
Jani.

-- 
Jani Nikula, Intel

