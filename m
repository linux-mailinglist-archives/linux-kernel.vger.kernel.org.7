Return-Path: <linux-kernel+bounces-889758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0205CC3E738
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E952188B5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99227B32C;
	Fri,  7 Nov 2025 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avjy4ZVy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE0221DAE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490096; cv=none; b=aUxW++kenLN7j9Oh6Y2nUgP5P2qo3u8QXs+44rQCrLKLJZxwOcVNzTFhK62Dzh3JC5WuF3feJW+X07Yh3J2PGeyjubaQMWBaeVm/tDFiYljpFIAiGLmFgNaIp+5KB8xLd3YM4m01IAZ99iR3++MVzovE/gc1iSU9rqWfv+BaH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490096; c=relaxed/simple;
	bh=j2VybcDqep5GTm5XHWYR/F0on0LqEt84R5Ole3I+g0A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nyTpIXaNNST2+MfylIlqgJWZzEWwU3Hro7kchCa6hiZROCw9r3EPNuU8t2ANIA985UbmXRvw7thJxcIqJfdRLnxA5n+9UBZWeeuCoozMLo6J+HXdzp1XrKatVzpXdvyXGI2Ge3OIDofzuC6qDrcvVMvPmh+Ltjl/C2HTwutDXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avjy4ZVy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471191ac79dso3415485e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762490093; x=1763094893; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsQ8+DdBhXQQJacebUZgMqys6BflOEfAmdOYN7onnYI=;
        b=Avjy4ZVybMkm08TV6HiiJQuCQorPDPKWul/SeTTf3Ix0jjNRVxh4XD2Ai6B9/qRaWb
         1+W7bBpw8wCpGMpYv8X1B2TDFUnMJW1dOzR9YM0PIrjb/L9x9TqAmsvkYPI/QUpuMDyH
         oKFPAQyj1HWCFP78qSxQr3WJ85hYaTTYaHnvhAUWkJ+z6EI6qt8KgfYerz98imKxkn81
         vx8j4lyk4lYiS+qmhegvJv7mpSShhv45DwKzKUP9khUGrrB6SjpHCCyUDKigqIy1EMZT
         s/8TJHX8x5qcKbUpGi+1LVlqx3wtW6QJ3BOGmk9UWSfRYHzYIwaPlNwYFsyYP58TkSqx
         IICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490093; x=1763094893;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsQ8+DdBhXQQJacebUZgMqys6BflOEfAmdOYN7onnYI=;
        b=Gr0+J+0ruQ4sVvG8TPdjrdZBI/CxUlbt8mzxA6hGd4ZkFqovKAEZVPcxPLljop9QDN
         ciY68cOwoCsj8xfvM2i6L8/7C2VlAHT8gKVeNAuMZSa8B1Cl/QicjECmVPIZdnOdjXYZ
         KVGgin5IKQ55F+NkmoBaD1RAAKYoIHA1GM7+XDyhRgDkmVjwFxiUvmMevJxK1cMVVP83
         7ZiRE4CD88hzEuid4G5Q8eJtMv86DAsipEa6L7T+HlIrcLsUFql2sPWa8wVs6gS2TRc+
         Fnt3j8opPu0mC7wtQCvEwxPUH+MlKE6kgVhZ0oIv3CRf4F4wILSFizLKzqK+IGnkJ7FZ
         wmrg==
X-Forwarded-Encrypted: i=1; AJvYcCUSqH1+xE6KthCV5Zgli9Gw12Ldj3VreCVUjG6NbZ1w+nN7JDT/h7CgvCgOOldP5B5ZJh7pygVBWKWkuw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMAdpRNc05sh46EBW+903T6qR/sLxIAA4L2xHibDFVrUD2Bo7
	azkh4C34ccQNU/EVkruTare9gPuu6bdbcEZQL4pXxx3ENYe0/RqTktEB
X-Gm-Gg: ASbGncuKKhlozTzYl5Pe93UxFiX1bdtglb5M4WEPn0Nx6PxqmERCBFR1GhBoYicY9jP
	yCLX9XpWABo9EaX2GUtQ0Pj7e+cvRIN5n+hByoWE3j+eLFuV2728y4xPvwG80hupEQ1NYVdU3GS
	RVrFb3mDdyL9812s5/9IoMRIuBEVCR0RHlxDGTYCwmwdrRS9T+MGsSrnMGWgvLcza4JyGLcqPKY
	lsqALLkTSGiUyRtveyswpJB+SDPAZ+sJyIvHHZKTJpbBQE4u7QqLOHatljHlnY5ufM4dVXKhL6U
	PaB3/DXXdcXXHnp+0OvCGlUPOduD4P0LJECWhaW2QvOpy/fMe5vRHIG4U7DxbZH/q+MqYcAHDvy
	Su5uIniBwWEV59g4mXbJgS0EIFnfKxLfCe0muW4jx9NN4Ek+MRehBV+0S6eQW7VtuZjy0k7qVhs
	EW4SImNwldQd6qgw==
X-Google-Smtp-Source: AGHT+IH8iYOa3zkzdeQ81462RWXFWW0SZmtk+MjUb5V+E2Hp+U6gTm6QWNnh28oZTtNNxpK5jLmI4A==
X-Received: by 2002:a05:600c:354b:b0:477:a58:2d6b with SMTP id 5b1f17b1804b1-4776bc8a01emr9870455e9.7.1762490092703;
        Thu, 06 Nov 2025 20:34:52 -0800 (PST)
Received: from [172.23.94.183] ([147.161.143.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcfcfc7sm29496635e9.12.2025.11.06.20.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:34:52 -0800 (PST)
From: HariKrishna Sagala <hariconscious@gmail.com>
X-Google-Original-From: HariKrishna Sagala <hkrishna@gmail.com>
Date: Fri, 7 Nov 2025 10:04:13 +0530 (IST)
To: Shuah Khan <skhan@linuxfoundation.org>, hariconscious@gmail.com, 
    shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
    nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
    perex@perex.cz, tiwai@suse.com
cc: khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com, 
    linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: fsl_ssi: Replace deprecated strcpy() with
 strscpy()
In-Reply-To: <0c7f307c-9de5-4d67-b9da-e728d43e00b6@linuxfoundation.org>
Message-ID: <fc28b6c4-3495-0581-1dad-41e49ae86917@gmail.com>
References: <20251105052113.39999-3-hariconscious@gmail.com> <0c7f307c-9de5-4d67-b9da-e728d43e00b6@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 6 Nov 2025, Shuah Khan wrote:

> On 11/4/25 22:21, hariconscious@gmail.com wrote:
> > From: HariKrishna Sagala <hariconscious@gmail.com>
> >
> > strcpy() is deprecated,use strscpy() instead.
> > No functional changes intended.
> > Link: https://github.com/KSPP/linux/issues/88
> >
> > Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> > ---
> > This patch replaces strcpy() call with the strscpy() API.
> > strscpy() is preferred over strcpy()/strncpy() as per the
> > kernel documentation.
>
> Which kernel documentation and can you add why strscpy() ie
> better than strcpy() instead saying "as per the kernel documentation."
> >
> > Thank you.
> >
> >   sound/soc/fsl/fsl_ssi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index 320108bebf30..b2e1da1781ae 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> > @@ -1447,7 +1447,7 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
> >   			dev_err(dev, "failed to get SSI index property\n");
> >   			return -EINVAL;
> >   		}
> > -		strcpy(ssi->card_name, "ac97-codec");
> > +		strscpy(ssi->card_name, "ac97-codec");
> >   	} else if (!of_property_read_bool(np, "fsl,ssi-asynchronous")) {
> >   		/*
> >   		 * In synchronous mode, STCK and STFS ports are used by RX
> >
> > base-commit: 284922f4c563aa3a8558a00f2a05722133237fe8
>
> thanks,
> -- Shuah
>
Please find the below reference links.
https://github.com/KSPP/linux/issues/88
https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
Thank you.

