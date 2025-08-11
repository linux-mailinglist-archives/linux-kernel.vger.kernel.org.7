Return-Path: <linux-kernel+bounces-762348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD9B2053F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895101888DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB22227E97;
	Mon, 11 Aug 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLjCbIcn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0C237163
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907887; cv=none; b=h9enUJ7V6VUjxNXO0kZ8OxFhIDL1TgsEfL1BEbnEEddLYjtNTSN79KEVj0lJguVYi74KaK8lQzdaJXsC7/bFyIZqK/S8fl5r1FsRinVfaJPBIAfFQ/9tlEx2M2Mkjj0XEcTyB03H5onM3kVMgB1pyFGhLF8uDpy9iplgXuF2SBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907887; c=relaxed/simple;
	bh=6brobFK2NROSc48XBQqk+Be5Gx7yulhT6LVp/hdSAC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUctizigfzPMOnTPT5QIAuHirQsWccRObRXpquSCWjtS7ZU22Mc90Y+YLLWt/fMs4sB4mrQY5vklFUpdMmp4B5M6GlcYYFo0Wxlz8KAwg1k+XhriDl7Fs0YH5MoNSAx1izujXJZmCOqEbqRC9K6DqBjsM4D8QpP+6C/iZwMxwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLjCbIcn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a0d5e4c45so2444065e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754907884; x=1755512684; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HBe9czUDzx4VIYaunJNZUgByUfhVqy3wgTZDB39K9Kw=;
        b=dLjCbIcnvd38Fp9nXLo5yzsMmpG0Dw9qNzDb4l3buTnl92KaizVjNQ5bRbGKqhJaR9
         FSLJOUCUpmfwtQE52VsIWeL2YHztAR+SoWqwXp4mhTTscKHxIP5eyK28R071Ej3iHLhq
         tOhXosOSyTyX8boX8092jJHypJ5a0NoSRyYWzlFuygfcUJMKF10BuT4wAypEWt1+Z81l
         X4WpUGow1/iQtOOZx1TnhrWgn1989T421ZFJA/M1C02DWhY2ylSyrxHbzIt73lR4VnW6
         9GowzCS20NKTefKSLHjGCDltkw+ULqrRJTo7DTU00blpvikZgZkvzTW8A2iY8aie083f
         yQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907884; x=1755512684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBe9czUDzx4VIYaunJNZUgByUfhVqy3wgTZDB39K9Kw=;
        b=snXtrJzFgD/Pjx6he4P84mQ7sSAYdvLUjRcZIRNsTSrKUUg0kXM+GX91n5nbVFr3tK
         4It9vB5ZP81RFI0AJI04aIDoUZmdYnRFnajwtbS7UEowsFQLzLpm+0BSOovx4nsp+1Ux
         qd9W5o02C4SyVIXYcA6plnSssXdzfQpTeInuOQKtHu5U0Ku2uTdCpLBWQWDBG4za16/8
         Xfy2xh1by77kILCT8OobUe+lqkPYgLDhVw68JUMqSO/DwYclBQQk3FuvnMDoZp88art0
         JGk91tQZVTZEIujff96ApwNia9+uddhmM1adWmldYNRFeYOJMWNcUOx0G6IEV6OLl6X9
         pEVA==
X-Forwarded-Encrypted: i=1; AJvYcCWW89SK5IaoaMLYp/iG7GVyiADa79fwF5WtaChh5zv1sMxC45fDk4U6SYcPOua4SDhlCGEWCDBMT0A/xbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oF2uVEZuSYmN6sSIGkmPNWth//wZIsPj9ml0zmjuXlJzTwNp
	DWFrkKYNZghIAvzawUMR1AyK5+UCu/HLwAA9uNXefIEN4bNxX3SuG7L0
X-Gm-Gg: ASbGnctfmXMTWv9vnJZAfX6ze01Qm8rETRQXBUujVWcwb54CPQuZ75muzsPkvUkNkFG
	TkO7E/YkzeSigekc8Xm0pII9xOhINdqoMFiPfDshJy+HcjiK/yPQsS8IquFSlXZ9XU6WDnQ4a6H
	VKu3rAd296vQMS8ED6+5KeDfkkOp4wimWyBjfBKh/mBOjr+eI5r4ocwrnA1GNih6hlmnX86RBXF
	2UQn1qaDewSWRrFtkDy6DWT0dGMUrLKt+t/CwZg6d+koss/QvyWrGhjMUc3wZOpe5W+7H8Zgo4Y
	E/dXv3Bdi1XDfVPL14w/L+WF55fz+tNQ2ejhIoRIQBjCeQU3OeFWRJadnrBGujRkgMt7leR23zU
	8O/TOuzV2uCK6OGM5tUo=
X-Google-Smtp-Source: AGHT+IFUPHEEiAr26JDbR4Tv1T2rbVTYYcdhOCQ0HeIDjGQzbNBbDgyPBzabITYI3btFT1OS8u/kKg==
X-Received: by 2002:a05:600c:1912:b0:456:18ca:68db with SMTP id 5b1f17b1804b1-459f4eb3ce1mr109619375e9.8.1754907883569;
        Mon, 11 Aug 2025 03:24:43 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm268177675e9.22.2025.08.11.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:24:43 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:24:41 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org,
	cristian.ciocaltea@collabora.com, gcarlos@disroot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tests: Fix drm_test_fb_xrgb8888_to_xrgb2101010()
 on big-endian
Message-ID: <aJnE6Uu_WutFA06X@fedora>
References: <20250630090054.353246-1-jose.exposito89@gmail.com>
 <20250630090054.353246-2-jose.exposito89@gmail.com>
 <9467c5f1-fb70-4698-a611-80f9be499b22@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9467c5f1-fb70-4698-a611-80f9be499b22@suse.de>

Hi Thomas,

On Mon, Jun 30, 2025 at 01:37:58PM +0200, Thomas Zimmermann wrote:
> 
> 
> Am 30.06.25 um 11:00 schrieb José Expósito:
> > Fix failures on big-endian architectures on tests cases
> > single_pixel_source_buffer, single_pixel_clip_rectangle,
> > well_known_colors and destination_pitch.
> > 
> > Fixes: 15bda1f8de5d ("drm/tests: Add calls to drm_fb_blit() on supported format conversion tests")
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Just a friendly reminder about this patches. Can I merge them?
They have been in the ML for a while and it doesn't look like
there are concerns.

Best wishes,
Jose
 
> > ---
> >   drivers/gpu/drm/tests/drm_format_helper_test.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > index 86829e1cb7f0..981dada8f3a8 100644
> > --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> > +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > @@ -1040,6 +1040,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
> >   	memset(buf, 0, dst_size);
> >   	drm_fb_xrgb8888_to_xrgb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
> > +	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
> >   	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
> >   }
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

