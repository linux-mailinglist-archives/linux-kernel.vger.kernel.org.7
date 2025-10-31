Return-Path: <linux-kernel+bounces-879989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10205C248EF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEA6A4F1A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FEC34A780;
	Fri, 31 Oct 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlBcaE50"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909A34A769
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907216; cv=none; b=KjF+i6sYhVkyMU7zDhevhx3IUbB6gc05r/uhVkDgf5cGz+D8prG8PB05vlZCPvAs23Y6zN+xVSHdJcFbykbI0oV/uCfLd7C+j8yPZw0xMGi8D8u9b/GQFjzjp6UTyxu+lWtXMOrJ7rS5RfvTk5UAxUp15FlmAuo0fTTEgY/3jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907216; c=relaxed/simple;
	bh=4bxNHRQsBRMciAEzzGKIK+EDpKWJqabZiAyQ29AdBas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qg/z+ebQBKTsyABAsPtvmL3dIe7C1EQXjfljhSo4M7NNV4Obnk16QIau4B4bl86XwwwkC52JxGU3U3pnKcVV6zFX53Qc6olmQZr44+uZX1JYENgPpTokDdNn0rjDmZrj9LIQ1hdWu2FD2HTLHfGCPTxJ2TIBJQPFRnVzoZxLWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlBcaE50; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761907214; x=1793443214;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=4bxNHRQsBRMciAEzzGKIK+EDpKWJqabZiAyQ29AdBas=;
  b=RlBcaE50QQIiCeSAcSh/EhofbpUmXpwwc9EhUZ4ryvNhPbgp0iffYpZC
   qRILtsbs9BUDI09Ik/vSMgZL871DnUVOCXXVFpjNZx8k2eE8FouhU5/FB
   /2R93eAy33vghUDo1te3olR7exVG2aKMUB6vS0qcemdhUYABGIJ7NZq5q
   uj7bUYX1z65NYC0a2HEQiIFG5RXg5PKQs83cjyOEGX5T6cRAQj81v82Bu
   IaYOVMIX3/0r8mIcWfU0owveaVAvGIhtiNK3EtFW6pt8cEMaRMNEgQhyY
   sQ2B0ZnQ7LNdLoeorqd+OYCZAD0ItwF+tDYe6Aa7YDEi18AjQJECQzpOJ
   g==;
X-CSE-ConnectionGUID: vtFKKRR+Sa6ldI4XfaeK8w==
X-CSE-MsgGUID: YRT8o5bsQ+qqHbra8NHtRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64217094"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="64217094"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:40:13 -0700
X-CSE-ConnectionGUID: MKyg1S5vQwKvwTQGoo6DnA==
X-CSE-MsgGUID: VFY/pj9ASYiSCLaXw2pXkQ==
X-ExtLoop1: 1
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:40:10 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Doug Anderson <dianders@chromium.org>, Ajye Huang
 <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
In-Reply-To: <7071a2b8198c09011c84d39b45dc6d1da4b69d12@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
 <7071a2b8198c09011c84d39b45dc6d1da4b69d12@intel.com>
Date: Fri, 31 Oct 2025 12:40:07 +0200
Message-ID: <789d88744fbd3a05758971dc8d893fb4599475f3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 30 Oct 2025, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Thu, Oct 30, 2025 at 2:44=E2=80=AFAM Ajye Huang
>> <ajye_huang@compal.corp-partner.google.com> wrote:
>>>
>>> The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
>>> but it will happen display noise in some videos.
>>> So, limit it to 6 bpc modes.
>>>
>>> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
>>> ---
>>>  drivers/gpu/drm/drm_edid.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>>> index e2e85345aa9a..a73d37fe7ea1 100644
>>> --- a/drivers/gpu/drm/drm_edid.c
>>> +++ b/drivers/gpu/drm/drm_edid.c
>>> @@ -250,6 +250,9 @@ static const struct edid_quirk {
>>>         EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
>>>         EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
>>>
>>> +       /* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6=
 bpc */
>>> +       EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),
>>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> FWIW,
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

And as soon as I hit send, I notice the quirk is missing BIT(). It's a
bit mask, and the enum signifies the bit number.

BR,
Jani.

>
>>
>> I'll plan to apply this patch next week unless there are any comments.
>> Given that it's just adding a quirk, I'm also happy to apply it
>> soonner (or for someone else to apply it) if people think that's OK.
>> :-)
>>
>> NOTE: in general if someone is involved in the discussion of a
>> previous versoin, it's good to CC them on newer versions. I've added
>> Jani back to the CC list here.
>>
>> -Doug

--=20
Jani Nikula, Intel

