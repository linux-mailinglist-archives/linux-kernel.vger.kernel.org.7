Return-Path: <linux-kernel+bounces-879964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C994FC24835
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF45234371B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD233A038;
	Fri, 31 Oct 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSSeme8X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3B20B21E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907079; cv=none; b=AHqxWAXkxy3+2f3JzHK0AsTyVX6Hv3iBxkgPtjXzr071f542XSFVeCwDXiKwWA/3rE//w9NmcaWehAMFpLDLkF7bepvmouvQdB9SS68/F574nvwMpEcO0Rprs0POUAhn+yx8IYQxQNdtv9PEkVjFCwmrFM9xTCJjlWPEoANCTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907079; c=relaxed/simple;
	bh=QSaTEzBQfWPbXIC3RRefKKJv8RZk9/0WkODw7UdM88w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFbQHXW4YSDTDidxhrabEgHlcKhTm1QnFWtqQfMFQtxBrOi8zecca5Uoncisxj9VjdApKHNY3wmXasU6pOTEVH1xKLm+ogG6DW1z5C5+WY7I2H5wMSKougzvEorEe2oNAYf5cQRlCmqDQx/cFizRtOUyh0PXDtS0Mt8NI3R2ILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSSeme8X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761907078; x=1793443078;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=QSaTEzBQfWPbXIC3RRefKKJv8RZk9/0WkODw7UdM88w=;
  b=ZSSeme8XiP0CJBNu5b+AyyoscDU1QVwRqeqQeqBMJ+OQ0WvcagEijfB1
   vUrLEgZY1Q3ldMNfdSiE+weEzrGS1EP933x88d/G9uE0uRGP+3DpK4WoX
   d3ZSx6npcQo1pXfEbafOrdVIJnXUA/HllFaZU8xsA4Q7q2a2ImvpYAXJ2
   RD6lhl0DE4sj0T3oFU/G4AjORk3kOjzJ99WFkVRRCdqibeSWlQstCvYY4
   xlpEk6rnkqX+Fi44G21RVmlQYW73s/ydTOwbp1yDGkWQ85G7Sm3s+9Zb4
   WPZY11oeRikMOsxV04OhAr4LxTnsl6DaTGFDoXDf+KasNHw6f+ReK5/Fv
   g==;
X-CSE-ConnectionGUID: LVB7qMwgQxWL0LZ4UoL36g==
X-CSE-MsgGUID: FaNwViWNTxePQxKzrdEhkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81476858"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81476858"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:37:58 -0700
X-CSE-ConnectionGUID: 8pyiYAyjR22by0vnQYF0kw==
X-CSE-MsgGUID: QpR3cUmSTYCPHXpvYKmOdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185892866"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:37:54 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Doug Anderson <dianders@chromium.org>, Ajye Huang
 <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
In-Reply-To: <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
Date: Fri, 31 Oct 2025 12:37:52 +0200
Message-ID: <7071a2b8198c09011c84d39b45dc6d1da4b69d12@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Oct 30, 2025 at 2:44=E2=80=AFAM Ajye Huang
> <ajye_huang@compal.corp-partner.google.com> wrote:
>>
>> The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
>> but it will happen display noise in some videos.
>> So, limit it to 6 bpc modes.
>>
>> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index e2e85345aa9a..a73d37fe7ea1 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -250,6 +250,9 @@ static const struct edid_quirk {
>>         EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
>>         EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
>>
>> +       /* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 =
bpc */
>> +       EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
> I'll plan to apply this patch next week unless there are any comments.
> Given that it's just adding a quirk, I'm also happy to apply it
> soonner (or for someone else to apply it) if people think that's OK.
> :-)
>
> NOTE: in general if someone is involved in the discussion of a
> previous versoin, it's good to CC them on newer versions. I've added
> Jani back to the CC list here.
>
> -Doug

--=20
Jani Nikula, Intel

