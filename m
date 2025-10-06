Return-Path: <linux-kernel+bounces-842727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6AABBD681
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 925264E1933
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64902641C6;
	Mon,  6 Oct 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2hWO+UY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AA170A11
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741509; cv=none; b=LmJ6eo44lDYxw8aredpTEcMYjKJQJ7IhmWza9ogYs6APZJj919QaEupeTjuFcBTjmEMA/cc8w3iaIoiKUdXeiwLqVZD+y+HMvWhI9lQpC3fjqYypv33ViJMUxssvZLUAgkv50kNXQGY5i+uMYgbe4EqQWjdzjYjh9dBSrRDNkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741509; c=relaxed/simple;
	bh=M7RY/jKXEGp1I0Cbhg+O8MbCIaKKQJ0d3+bkdHMZ+so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jywqJY2FXFXgcBrOT9/VCK5LZhitQFi/SQvjnaeRHuSI7hmQY1+RamwnAXaJ9p9a3K7T8UX6yAiJjjUXB0Dq7UM/TpIeaWB7qU0TJbGDvV7TpQ7Ro9fxBpe64kzlAvnA0BndLVoqtHgpBJX+VQKj0pZmW8++UORHYsX1QgPIm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2hWO+UY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759741507; x=1791277507;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=M7RY/jKXEGp1I0Cbhg+O8MbCIaKKQJ0d3+bkdHMZ+so=;
  b=J2hWO+UYmlrM4eU8ZDPoL4ZFZxCwXFc5SGTopdJ5tre38i/5RuMifQmu
   Ii2Z/GL81PE7ijKVDOz6boEx5EAW66XKCCNjyGcXnQWoj0/nJrQP4KMwX
   yKdDqs7tQmkICU4Ql/nU/a+PNTIzLUmdfmqaUZHaGkEXypyQWkPUNI26M
   MctwRXRuQgYQ6yNjRzG1gn0wvJ6XvX8zi2W4qpF2g1GxjxIimxoZI+V23
   Z+zTxpWdUBJFUfaF85AvpTZFfYzIHllRkPc6AAddbpwIam7WB1lyZVwAM
   kqyrMI7r7USKyiq6QPdl6toK5bM6sbVRc8CSRupZd2HGjTnbRaZDBdq15
   g==;
X-CSE-ConnectionGUID: tbWNRFrQT1C3SxFI7YYqIQ==
X-CSE-MsgGUID: d/patFxhTEC6pzCT30FmAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="72163932"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="72163932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 02:05:06 -0700
X-CSE-ConnectionGUID: eKjp6VwDSmiuOlV6c3AQEw==
X-CSE-MsgGUID: CprpgsMbQP2lu51Sw82TWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="179451494"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 02:05:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Francesco Valla
 <francesco@valla.it>, Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/draw: add drm_draw_can_convert_from_xrgb8888
In-Reply-To: <b026d815-dd6e-48a6-8efa-4631ed7cca9c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
 <20251005-drm_draw_conv_check-v1-1-9c814d9362f6@valla.it>
 <a669b2ee89865e9150efd38e181cdc838c2ac522@intel.com>
 <b026d815-dd6e-48a6-8efa-4631ed7cca9c@redhat.com>
Date: Mon, 06 Oct 2025 12:05:00 +0300
Message-ID: <1793a882aba06d4b770799633b4443439d978679@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 06 Oct 2025, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> On 10/6/25 08:48, Jani Nikula wrote:
>> On Sun, 05 Oct 2025, Francesco Valla <francesco@valla.it> wrote:
>>> Add drm_draw_can_convert_from_xrgb8888() function that can be used to
>>> determine if a XRGB8888 color can be converted to the specified format.
>>>
>>> Signed-off-by: Francesco Valla <francesco@valla.it>
>>> ---
>>>   drivers/gpu/drm/drm_draw.c          | 84 +++++++++++++++++++++++++++----------
>>>   drivers/gpu/drm/drm_draw_internal.h |  2 +
>>>   2 files changed, 63 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
>>> index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..2641026a103d3b28cab9f5d378604b0604520fe4 100644
>>> --- a/drivers/gpu/drm/drm_draw.c
>>> +++ b/drivers/gpu/drm/drm_draw.c
>>> @@ -15,45 +15,83 @@
>>>   #include "drm_draw_internal.h"
>>>   #include "drm_format_internal.h"
>>>   
>>> -/**
>>> - * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
>>> - * @color: input color, in xrgb8888 format
>>> - * @format: output format
>>> - *
>>> - * Returns:
>>> - * Color in the format specified, casted to u32.
>>> - * Or 0 if the format is not supported.
>>> - */
>>> -u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
>>> +static int __drm_draw_color_from_xrgb8888(u32 color, u32 format, u32 *out_color)
>> 
>> Is there any reason to change the return value of this function and
>> return the result via out_color? It already returns 0 if the format is
>> not supported. If there's a reason, it needs to be in the commit
>> message.
>
> I think the problem is that 0, is also a valid color.

Right, of course.

> Maybe it would be better to split it into 2 functions, and duplicate the 
> switch case.
>
> ie:
>
> u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
> {
> 	switch(format) {
> 	case DRM_FORMAT_RGB565:
> 		return drm_pixel_xrgb8888_to_rgb565(color);
>
> ....
>
>
> bool drm_draw_can_convert_from_xrgb8888(u32 format)
> {
>
> 	switch(format) {
> 	case DRM_FORMAT_RGB565:
> 		return true;
>
> ....
> 	default:
> 		return false;
>
>
> I didn't do it this way, because there is a risk to add a format to only 
> one of the switch. But after more thinking, that would be simpler overall.

The duplication is a bit annoying, but it might be simpler. Dunno.

BR,
Jani.




>
> Best regards,

-- 
Jani Nikula, Intel

