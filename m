Return-Path: <linux-kernel+bounces-899474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E772C57DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E874C4E6425
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7326F478;
	Thu, 13 Nov 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ildeHDei"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3426F2B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042957; cv=none; b=DDHAzM+YgzhY4IaUOvkjNS8dyuZstFTfRk60yH3CmLHNI+R9WBtBKVFHKpkELFhdO/4XszJL2Q9t7tXX/3heqjrW+2UZ/ePS4JpReRjtckO6/3mCzFjTTsXjDexUQCsBg9Dd2WBOwfjiRo/ysZzdvAaUqhDQShpJbO+8Hzlg5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042957; c=relaxed/simple;
	bh=anqFmjUhwQ8vKV8G0qJTF8NCUXoKhfPHmhdWO0N20WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYcdXzZcqGPvdKs17uWg/1iCBvBPPpnnfOTZQaLm1y22qwIcnjk4BGgx/aWJR08A2E2KIh3U4wwz+qmvhE4WPnl24o3g6aCZoaVPF6DWnva3YHG+l84wUys+xnjHCom5aZTMTE7C+yAaIUCkhxYHEQywcGG0xCJjRfVGm9A1OvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ildeHDei; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632d9326so6277095e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763042953; x=1763647753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZyGvcYiCgEWiRpNWtQD8KconPlU7M6IpPd18MQ9pr0=;
        b=ildeHDeiBZoX0Nw/Yh9YiGyRz4Rf54WijsLytAhzO4FWMUB85xU/Oaxd1qbE6NSzpE
         uM9iGti9crChBEN0vFu6JYfFnLqZ09nnIlMkZ1pRT4QO1/kMsAmO4Ea9FTSyH4sSLuZx
         Zd+aXn2YeFag1Tjw1weTM4KYCbo5bTftnBT+OPQhqPuJXiDRjEQDimRdI9fExC/FDwh/
         OY3gm5OX/Q6RrbHezREd5T/eTHVz4Do4yATYqMSIipR6tndp3hMydmjo+fWRuab/Ol83
         11AyOzRdAa7BEpYNrTRZc1nGo85MXqrqx1G5NAU6VAzqmUhvnOPdpyQg/DCPTn37+fcE
         SFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042953; x=1763647753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZyGvcYiCgEWiRpNWtQD8KconPlU7M6IpPd18MQ9pr0=;
        b=hTvtyCBlxBCe0NWAoZKTCBNrf2vDgi9NlbB6tP6FD2a1cL/hqj8ABflIxvueXS79R6
         gV1wFN0KYP5J1epOnvZ0iUGJgj2+9/Wvv/ojg9jIuMhpb8GmFdBEgbY0q1NGgCHFt6df
         Cw9DegPMLTe+Ohfz5jDcCvfzBng5J6to862PUee2+hd0My2ueZBHzooDXZ2AUflUT5BE
         mgaF7cUmxsVJbgE+L35Zmp3PPJ41v2j45BAiIx0oCBRW2sGr1EH+hJk8IyS4qEHb617D
         YNck1aC5LVFAMzPIG6AzcVEq0bSIl60HSzuTC570Aio9tqfd8V9OqqY4EvWZv+drZlyh
         n60g==
X-Forwarded-Encrypted: i=1; AJvYcCXrrpZoREN+XZvKCnpuSPZIo36+U7zqADFnQQ0ksk7onM4ZRSrUndvhVU2NOOvVwoWkHeS2vXAnDApOhLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQnPrVqMkqKHa6+NDDlIze/sjMofwPXcvcVJD7hCfs433BRkW
	+9/yoBT/XssXuKVRgj84qFTgZ4Sb1+UukudreVPS/ZSYoeGpG2ZHDi00
X-Gm-Gg: ASbGncuMblOytGa2p9ZmaokB68OwSH7uSLBt2/4d81pso3OilTF27jzjIB0B4HbrFkz
	nOlNN9tn1XCuA/Lcqp31A4NU8hlVqTmTeGTadSywdQsYPcBgbyAsWPtufpJxfH2GxNj9odQ+Huk
	VTnR8Tasq0CF00ggSrbW56cU4Qa5fbrGhYLTMBe6Dyvv6iBongVSvlfor44Had1MuMllWru9Q3g
	CpO0BbpFEnGp4aka8Jq8LhcBobU87xGQn1+C7vc3yfUtflRqjshutuwCyynsC8LC/maN9r+8R1T
	adxSlNaL9LLR7u3dkauLfUwo0kXg7TYEycmZJY03iSdyTGCliyvj1MfSAkltSzzpCdWHI+3FI2P
	P4a0pUnuOoPWDXcx4q9Lm7uJuUQDWR9C5CqQFho1oYuxy7fnBkiG0AvASq6l8jeHhpFnz48vqQw
	==
X-Google-Smtp-Source: AGHT+IFeNfJ1eyONHrbz+WXHARO/AJILEljcspBbpTWg7b7/P997IAGWloWsSUmV91qlQ+SipQ99TA==
X-Received: by 2002:a05:6000:1788:b0:429:bc56:cd37 with SMTP id ffacd0b85a97d-42b4bb74cc7mr4917562f8f.6.1763042953261;
        Thu, 13 Nov 2025 06:09:13 -0800 (PST)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm3981192f8f.9.2025.11.13.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:09:08 -0800 (PST)
Date: Thu, 13 Nov 2025 15:09:06 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	victoria@system76.com, sebastian.wick@redhat.com,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RESEND v2 03/32] drm/vkms: Use enabled/disabled instead
 of 1/0 for debug
Message-ID: <aRXmghF0m0ypbQMs@fedora>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
 <20251029-vkms-all-config-v2-3-a49a2d4cba26@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-vkms-all-config-v2-3-a49a2d4cba26@bootlin.com>

On Wed, Oct 29, 2025 at 03:36:40PM +0100, Louis Chauvet wrote:
> Debug information are mainly read by human, so display human
> readable values.

Today I learned. I wasn't aware of those helpers, nice!

Reviewed-by: José Expósito <jose.exposito@redhat.com>

> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index cfdd5f32f234..391794d391c5 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  
>  #include <drm/drm_print.h>
>  #include <drm/drm_debugfs.h>
> @@ -354,8 +355,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
>  		seq_puts(m, "crtc:\n");
> -		seq_printf(m, "\twriteback=%d\n",
> -			   vkms_config_crtc_get_writeback(crtc_cfg));
> +		seq_printf(m, "\twriteback=%s\n",
> +			   str_enabled_disabled(vkms_config_crtc_get_writeback(crtc_cfg)));
>  	}
>  
>  	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
> 
> -- 
> 2.51.0
> 

