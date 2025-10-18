Return-Path: <linux-kernel+bounces-859187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D1BECF94
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D23A2495
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D212D193B;
	Sat, 18 Oct 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUopvBcH"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2A285C8C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760790351; cv=none; b=Q606OOADe/hdYB6ay7D+nv4NpTpCAOf0OVx5c8+b9wSQUSNp5op/kBxtVwnqzH/iil5uJoXFBmv4yr0+vMt8XlIFp0TAduP7q0Z2q0K3AoPKwloJmCfgamsW0rFhMFbjkb39NCSbPT9xtujJWSTjjsUgoicWp+IFGfTyaM0Qmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760790351; c=relaxed/simple;
	bh=P8XBi5I3NtXNdsQ+DnhxOruhCFctpANcNt0z1Wm/2bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciI0t3tQJzkKljd1ZwsnfARAy7xOx3zDXCMd0nXFCRrM9aPitMkNzE0WtJ+TAYwXLK97cwQyb34OQlR/G76fxQ8fPds390wH8hR336GYo+MxpsHyveRUl8CNXWukSGTvOsvGNbWJV0wE3J2fyo3Qaih3vOmdxp5j1WUZ10sdbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUopvBcH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bca51so2267700f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760790346; x=1761395146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qxh9yQnKYSbelXax4RapBIx42eIGM+JDvuTXPUm+30A=;
        b=UUopvBcHDmLLl78yRZyKUx2I0HYZlWc7lJbwmO9+yDon9Ez7nxD6KDgBe51EtP+ixu
         N/5Qa7eSqcWu3moRg5P4kB2MIreei3OYI/iE/8WZbAIS47VSPcunNYAvlw4jqsXpIeFQ
         hrH0zERvJSSHdNHuWbVMXvSVZUNVEGajA9xg2SAcdgNsAL30MRuZ1+sqr0bQ75sJ9+sw
         TlZSgqRG8hLLlI+rRtVbE0ntX+s3m/Ldk9mCG2LYP+Hc0JXWC+7o2md2CyOzLLkR9NkA
         5a4ijNv8rpNqKItk3wOX3zJmWwWzUOOLL8x4DS6zu69Wu6/Vx3yans91DTTEkxRG0Mhm
         7o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760790346; x=1761395146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxh9yQnKYSbelXax4RapBIx42eIGM+JDvuTXPUm+30A=;
        b=GY4lyJJRomr1LEFBOkHRd8yLysBJbYtf2Lh4QoUiv4hhE0TYjzWTXbMkbAkPFYuxRy
         TwJRxqhcbPuWSERkGm3/P2jDgUu6ErRint07pdCOlMhMug/a5yvukGfkzjm1P5qCvTNV
         umd0Or0d2s/eyLpNQBwSuHlPFmMhX5VSzCGu8s7g5SyUixrbx0j/TX6b1CxbsgaGaupY
         YGTyG4khZbKDoKSPhpH4Okdgrm5ePiIPnUrtolNWmh9aHqvxygafdaiW3yZX0s6l/+Gw
         FNyjqkZrc1+1iOT54RsCIYK00EwZGZGVLZZiF2lp2KyYka8O6yztaaHZA5CRPqqzc3Nh
         HfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSXmeAkzxjclHGU+65re/4ig24yr4L5bOlxVzJFE9SO8gXXFQCr17qlajeNIa4s+oGEnzQGW2nIIPLPtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+WF6NDFex8A1rLbNPGVrr9N4VJjv5taSfm8Nl7nGmZ38Td15
	/9vbntG6E6ZNUgabeOXMzpTgdUsKRwraJ4WHKhE5G6tmnBT5hIM0o4MP
X-Gm-Gg: ASbGnct2HwKFaNUdoU5UUoBxqKvAJpx20Zhgq2oaGIedyfJ5NlePmZM7HDjdama/r7H
	XJSQWgkmpkH2+IKFNJCOkKJYGsbaublp2frC7OyzkgX8QOw4M43KmykMjT/HpS1lH1p+fof+VkT
	iln5fx5XEt/UjDXNwTQ8tERHWXQ6chgKCjKPW28VNx0TEM2Sy1K8c6fZcl4rk2HzVoDO7SSByTn
	ntjGUFeIBM3DJiFXBrKdjqp0J/q3YYDnJYp1C94jZBCbBOFArnts20lRJ61m8TBVLrfFaUIwIEJ
	df0wrpXjHerkMlxwlfWG+RFyOI04coxC2ozfkinp5yiap6f9zxBt2r3yKNrvxTD6/8urt1fSxNe
	WrcbOcM7w3xB3Qf+r5TasxAYKQ1o9oh10iHE9UB9cVn5BYj6g13syq77VHPscg6Sk4m7gmxGeYg
	IE81Fb85ou3wpPNz6SnGpA+IedsPjiGZxt1+F+7B7EDbk8wgNXK+bjf7ZNrDU=
X-Google-Smtp-Source: AGHT+IHrvYmWU8VX2IjvdY7vhN8XWzCKvjWvIIW7b+tyYuQhrexcrdSS7qJwieJq0P0lR7mpRkRGsA==
X-Received: by 2002:a05:6000:4b08:b0:427:526:16aa with SMTP id ffacd0b85a97d-42705261894mr6353009f8f.58.1760790345945;
        Sat, 18 Oct 2025 05:25:45 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:2acd:89a8:83d9:4be5? ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3acfsm4828453f8f.14.2025.10.18.05.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:25:45 -0700 (PDT)
Message-ID: <e303c2f5-0868-445b-ab1f-dbb81dd173d9@gmail.com>
Date: Sat, 18 Oct 2025 14:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/sti: call drm_edid_connector_update when edit is
 NULL
To: Chu Guangqing <chuguangqing@inspur.com>, alain.volmat@foss.st.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251014065406.4017-1-chuguangqing@inspur.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20251014065406.4017-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for this patch.

Please change the commit subject to "drm/sti: hdmi: xxx".

Le 14/10/2025 à 08:54, Chu Guangqing a écrit :
> call drm_edid_connector_update to reset the information when edit is NULL.
> We can see the following comments in drm_edid.c
> If EDID is NULL, reset the information.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>   drivers/gpu/drm/sti/sti_hdmi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 4e7c3d78b2b9..31a72f7f4d43 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1008,6 +1008,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
>   	return count;
>   
>   fail:
> +	drm_edid_connector_update(connector, NULL);
>   	DRM_ERROR("Can't read HDMI EDID\n");

Now that empty EDID has been properly updated, the DRM_ERROR can be 
removed IMO.  In our use case HDMI is not systematically plugged, so 
this ERROR is quite noisy when we do not expect it.

Best regards,
Raphaël>   	return 0;
>   }


