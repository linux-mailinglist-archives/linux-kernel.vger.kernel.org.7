Return-Path: <linux-kernel+bounces-739173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CCB0C2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A5D189B916
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F8298278;
	Mon, 21 Jul 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtV4wor2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40798D517
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097071; cv=none; b=ESNim8/xTwgwEq4Mas6Ev2eeOfn6KiFvZ2cI2mzm3SdSKt47hwPeLY3pgiAW7dOXZhZoUthwPujoleRbeSlK2Au5+KNsO24ViqLAand+1VBUAaJSF8dMikqejC0ymHnx+5rFH1EhHtZYkQLMVNGRBkCn/fubvcjKsJnr57i9u8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097071; c=relaxed/simple;
	bh=tZBF1LALJXt7BV0PHJ+XVouRhusYLviMWHw66CC1O/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knu5dcrfPKgCITdN279EHaDVCnjuqyXyKSYKMmnnIO5PfBzfJr8dM5Mg3jmrSvVboyK5JAllCmhg4kcs4ezvVPYCS5EMmBdsWANB9dtN57nhhkLkue1cvN6DglEoxY1RQq5KWCeBgpu5dB5Q3Ig6l8G2QQvg6P+rNVTFCT2uFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtV4wor2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753097066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S64oug4rzFMt9OTheEDJ2IKdCev+SwZ84xmyXjvBrdc=;
	b=gtV4wor292boB64WjkuLXCeUjxp4n/h5b184fYT3E8jg/lvb2oe5OzMJHkR50C/yOXHdwd
	A67FYQhaXWYD6wrA33RXmLv4jv1DjqWRFqmnhG7VshlwRrZWT0Bkbg4wznCbPONb4OSUQf
	0fJ3Xa0jT8+bcv40EHxGHXp5Np21EvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-NmmNp856MQSzoQkCLpw7dA-1; Mon, 21 Jul 2025 07:24:23 -0400
X-MC-Unique: NmmNp856MQSzoQkCLpw7dA-1
X-Mimecast-MFC-AGG-ID: NmmNp856MQSzoQkCLpw7dA_1753097062
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso20740925e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097062; x=1753701862;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S64oug4rzFMt9OTheEDJ2IKdCev+SwZ84xmyXjvBrdc=;
        b=qf8AoeBrDhaXspbRF5TYbG+2HUmaLbk36CE8ZSGmwPoGwgGWcT+MraPOkAkarOAprA
         M+EdbEbwhKmRfVsK+nU10y4SjGaDJ8KK9Rwo7JM/pi8uMqr8SGW9UQEcsC3JzD/KGh6F
         wwax3BOAe5SUS86d+YnznKEr3mxMop0P1TLfvR2PCaqULxYm5Wpn+0istL0o1DutQzkE
         5TUJq1sZigMuvARkHkP/z8L2mKWfKY5ipFsAgHRVnwV7fQ4XKnmMjYdPZN+GFUp/awDA
         CNZMLEStLxxEdUnRGFZfyhy5/Eo5Y0QLIbpcZcExMEUQxrf/GE/S1KMUNwdodBy70imn
         PnOw==
X-Forwarded-Encrypted: i=1; AJvYcCXgeosjAo3L7Y0bqpYg0iLkOb+0foFHa24kAGbWIdG1uZ1ZkE1q8oPwusVXwJzUTr98eISiQaGUcVIIFqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2AW1O/S1QLtUtKXw4zDrGWeT/rCY8bLWj0J5BmbgADMN/yi3
	5U6mxA4ftYRXF0Amo8VfbbzAaaKE/R/IIz2P61MvBhWU172k/3CU3hHf512U/RZ2RFBW5x4LmqE
	Y3tiqxGH3BsxcPdXuIjWdVgn6ey8naCmlSeXBujjzo7y5sMg6CI4yl/hRw3DcmMdJ4w==
X-Gm-Gg: ASbGncsi/eYqen5I6TEyQeGxbYEWirfNjpvJ57To9S0dizy9olr9vwAEdhM5o+yJaRf
	yJZvc/jQ9GapNCN5rUn+PNiIbFuEVo9prtNABqc7sB7T6+Ccu3CDbJ2BtvJ9nriHPRxe8YWEGfd
	+vYFUIjFXWMNcpu9nIfeFQPYS/9Vp6BewQ+wNlB507xPXZrfPHPw3J15vF8NeVus9NXw/bKOKUL
	uLdn0O4kW0XfpHMozlIFzRGG/S1FvTm+mo8ztdvHutVGpu3E4LX8pZg9PE448Vmfo1D0TS7BqBO
	rC3j01Ce7JDtmQUJRyNEJK7jXcUWVEL6i1aUwdxVmh4dBw/9RDA+i98TOTW2uzUOPA==
X-Received: by 2002:a05:6000:2286:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b60e53ef79mr14025126f8f.55.1753097061995;
        Mon, 21 Jul 2025 04:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV5fGm/RSSf7ecoYFwTb4SzjfI9mHWgwy3o4Ms8iGa6PQPuLjyQSBdsTEN4qxIYWqzBJlVrQ==
X-Received: by 2002:a05:6000:2286:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b60e53ef79mr14025105f8f.55.1753097061590;
        Mon, 21 Jul 2025 04:24:21 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca24219sm9820770f8f.15.2025.07.21.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:24:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v2 5/6] drm/format-helper: introduce
 drm_fb_xrgb8888_to_gray2()
In-Reply-To: <20250721-st7571-format-v2-5-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
 <20250721-st7571-format-v2-5-159f4134098c@gmail.com>
Date: Mon, 21 Jul 2025 13:24:19 +0200
Message-ID: <87y0sh947w.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> Convert XRGB8888 to 2bit grayscale.
>
> It uses drm_fb_xrgb8888_to_gray8() to convert the pixels to gray8 as an
> intermediate step before converting to gray2.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

I would like Thomas to review it too, but for me the change looks good.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


