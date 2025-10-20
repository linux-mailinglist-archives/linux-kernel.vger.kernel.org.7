Return-Path: <linux-kernel+bounces-860520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF2BF0505
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB9189CC76
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211052BE032;
	Mon, 20 Oct 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcixYmEG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D223D29A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953813; cv=none; b=tfXiOaPoKVHz4WAYY7t2Bmn8BCikkx+H/Ull8Y7hjfVrSWGjQtAa8FAFt38JOx/GQ8zGVWaPjWapBwv5xQpNltD6b3IcnXAQstfYK7czOuoLlfbBa2hG2XH5pmX8RRvIBcUrbVKv1kl6t+gByqfobgzVkcrAhrqyx9ch6riLYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953813; c=relaxed/simple;
	bh=toWtOieDsYfqWfN+8amH9Octs1Y4IKU0gyOxBWazfC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8b9nfMqkJ0fiWhjfdQ3wKD30hnX+6kd+pf7zrmmXRP45LfNvKE73H2KPtnXyMD/V8pbd2jxUlfC3mwIaKygX2xaWLt+a3iqNQAGrojIwfWJtv0hovDpogzcClKXse7aQ3DJS+uxGTJIFSDB7RL5EW5DHLOxkYMFPVfAExOGHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcixYmEG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760953812; x=1792489812;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=toWtOieDsYfqWfN+8amH9Octs1Y4IKU0gyOxBWazfC0=;
  b=bcixYmEGnfsMWKl3NHilOKmMTYOrarrawG1VqU8j0rbChjNaww51KGPB
   qL3uvjoMvCG/81cg2vjNyErzg30GSm6SgrAkvs1QynAZ2/7GUYa84w+wY
   LXq6ImQA3Tzn7RiUK9198OfO+poBC4NR3qU1GmCCJdMbDmFSewWCF3j9H
   XParr81e9LeM6gL7qqTqfNgdPRw1+bj5nHEfqhbiulWVS4CwxlkcItFZ2
   nNXMwWkO7cBdDbO2YK3Ei/42JOGqMkt0+MMpPVj5o1ei5VwhKduXTbTsD
   IPZEYlYhDQd9Ws6kOgRUcZoliDUB03ZPdybZqhd18lCbd7S+CTWOa3zwc
   A==;
X-CSE-ConnectionGUID: X1AUxhF5Slim0znZ5Bp+zg==
X-CSE-MsgGUID: cm2S3A3iR1GRA3z5RdoySQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62972233"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62972233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:50:12 -0700
X-CSE-ConnectionGUID: m2+TlMjjQxGoDB2gd0tPdg==
X-CSE-MsgGUID: tcNt11N3RAOD/MBidoQ4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183702716"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.7])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:50:07 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
In-Reply-To: <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
 <2025101910-dipper-suburb-1755@gregkh>
 <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
 <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
Date: Mon, 20 Oct 2025 12:50:04 +0300
Message-ID: <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Oct 2025, Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com=
> wrote:
> On 10/19/25 3:47 PM, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 19.10.25 um 16:34 schrieb Greg KH:
>>> On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa wrote:
>>>> Replace kmalloc() with kmalloc_array() to correctly
>>>> handle array allocations and benefit from built-in overflow checking[1=
].
>>>>
>>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>>
>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>> ---
>>>> =C2=A0 drivers/gpu/drm/tiny/repaper.c | 2 +-
>>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/=20
>>>> repaper.c
>>>> index 4824f863fdba..290132c24ff9 100644
>>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>>> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct=20
>>>> drm_framebuffer *fb, const struct iosys_map *
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_DEBUG("Flushing [FB:%d] st=3D%ums\n=
", fb->base.id,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epd=
->factored_stage_time);
>>>> -=C2=A0=C2=A0=C2=A0 buf =3D kmalloc(fb->width * fb->height / 8, GFP_KE=
RNEL);
>>>> +=C2=A0=C2=A0=C2=A0 buf =3D kmalloc_array(fb->height / 8, fb->width, G=
FP_KERNEL);

Also worth emphasizing that this is wildly wrong for any height that is
not a multiple of 8.

And I thought I shot down a similar patch not long ago.

Is there some tool that suggests doing this? Fix the tool instead
please.

BR,
Jani.




>>> This isn't an array, so this function change doesn't seem to make much
>>> sense, right?=C2=A0 The size should have already been checked earlier i=
n the
>>> call change to be correct.
> Yes,I was intending to say framebuffer but I was working on another=20
> similar patch simultaneously so I reused same words by mistake. Thanks=20
> for clarifying that.>
>> Yes, we've recently received plenty of these pointless changes. The=20
>> correct code would compute the number of bytes per pixel using=20
>> drm_format_info_min_pitch() and multiply with fb->height. The latter=20
>> could (maybe) use kmalloc_array(). It would still not be an array in the=
=20
>> common sense.
>>=20
> Thanks for the review and suggestion.I will be sending a v2 patch with=20
> the recommended code change.
>
> Best Regards,
> Mehdi Ben Hadj Khelifa> Best regards
>> Thomas
>>=20
>>>
>>> thanks,
>>>
>>> greg k-h
>>=20
>> --=20
>> --=20
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstrasse 146, 90461 Nuernberg, Germany
>> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
>> HRB 36809 (AG Nuernberg)
>

--=20
Jani Nikula, Intel

