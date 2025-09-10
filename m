Return-Path: <linux-kernel+bounces-809991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9338B5145C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A577BE3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1A3164B5;
	Wed, 10 Sep 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr012LlV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79230648D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501173; cv=none; b=q/Krcuf+wJSAPOmJBdC0l8CmNAnxfrbGfeUAHXyUbu3jZtwXG/7Hc3ngO4Azhe+WnRuJv+vBMAEwmGfJH50uLYfUQ107GIcfkmWqywa9XGxPScNNXqfs/RiUD9s0/B790pQ48q0W6Oa1BEABSnLKiS80+3m5eWoYTt3iii6mJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501173; c=relaxed/simple;
	bh=YdQDjKnCp0fZZEDL6h7rSAoz3IU0LZop9X2eKSzS2tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0jQakyek4E6WYizy2i4fPgHz/0+TzFzp3pq+XM9GYpIOATnu48MBmnP6/BFrHFRJaXyUzBVSe76HZgNR0uC4RG4s9A7Wq8ktoZafSn9YfNdYtBzFHDBAtrYs5u98QrzDFGZ8LLzEEQ/VycfM9Y8d3QJPGJqSjQubYk/cf/oPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr012LlV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757501170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ish3TOdF5itkEce/x1a+uOeE11uGbtv2vXkIso/jAMo=;
	b=Xr012LlVME+G5KE53VkVKcXsTgQr7rHHsplHBscAVTHICNCy0lKfEu0DfpSAbIHhkRFyPd
	TC2RW59ixnnXpAahfQOPEFfEyUFq792/LkiOY6hD14X5ovve2ons0pgQDqTz8pV3YBjI6e
	VwH0UgRG9v/g2qWFeFDhWAgnynxC7/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-9jGcO4QUOuqtVOU_xpY2Ag-1; Wed, 10 Sep 2025 06:46:09 -0400
X-MC-Unique: 9jGcO4QUOuqtVOU_xpY2Ag-1
X-Mimecast-MFC-AGG-ID: 9jGcO4QUOuqtVOU_xpY2Ag_1757501168
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so38344035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501168; x=1758105968;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ish3TOdF5itkEce/x1a+uOeE11uGbtv2vXkIso/jAMo=;
        b=gPcuSIrVMbJ8L2pfwhlq4e1fF5RErwZQyLjiSJ4nwH54+JZV7NOYFA3d8QgblicTwE
         RO2SzLs5EEVDs0Oh/gtiWyfACpeVoaSHU9XvNRUyY9IxJSAEwAdHq0MHQxIivwanPzm8
         gg0wnXbMWe/Bt1oIUbLqJGCKN2riHKCMdpUuuI6iLU4BZiS/tLzXi35qfFFlA8UUO/bG
         MmvZmJkPDl4tNmIALMkhaUp0Q6QpHYnMWWQ9e8bpXrO3x3puw2FN8TR5zNOAQCoPKNLq
         QnSQiMSYc+SoLtUdagfr1VHknRJMePCj1RHyBcdR+l3BMfNuGGJALzA7mjmhUIZG5QIi
         qyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8h1WfwgNKQuiR3/KSCfBezDbjDeG3fMJ2Pbdhkp5elC9NU5Alz57THr+/mS819i6a9QjulUykU28K7UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyWT20xaQtoDC3g0pV72EBMI8h7IEVyDgInRS7AnIQx+OOshy
	cmqXJlU6UBYXlZAVLn0owHKmBIOejZiLB4KrbwnMajwDJgb9fH/7XiSxlUuiFXhmLpe1Uz/trvx
	ubDIfYlYqvNP8FoI6XOdPHIU9gDd+2eC3VRnNtVsfyrU1386SjkkZ7nShltPfCoj3sA==
X-Gm-Gg: ASbGncsT1MVimwH8hSmjBMnQP2Cnbp1peLGKHExK11zu0vHWMTmQVSmjhqiWhvTyV5i
	adMVp4TDmOupzZDUxIPY52wRMPJf1W6xbaaVP86oe9YQutV1UIr70t4brs6cGT3POn3ryotmjME
	H96A5GY4LaL3gyY8COSTresJDYJLtXKiBi6mEBUznlouCdTwEwQesZ7UYuswQckzUxGlyH0msnu
	KvQyUzgPThNN8EycgEy+WOXsHtnkOE4B6QeCJp2CqXDwP/WVVRz7gy84iqBwB8EJ9xUX0rlGEnF
	Q8NGQGgSC6E/vyajVdOOWn16+E851gB0fSnCZCkZQeRk34yeOksrTF2KDtWYhWs/L0xmF/yEyXk
	JlZhkXqbN9gpdF0khd/FR1A==
X-Received: by 2002:a05:600c:45cc:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45dddec78d3mr134563145e9.24.1757501168142;
        Wed, 10 Sep 2025 03:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41It7Gch3Cc7HmzlNTf33KcOKcEcqR+1x/JRLAyd/4r51Mnyjg/51A7Gwi/T9TvTKWE/bSA==
X-Received: by 2002:a05:600c:45cc:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45dddec78d3mr134562745e9.24.1757501167668;
        Wed, 10 Sep 2025 03:46:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d193esm23564835e9.6.2025.09.10.03.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:46:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brett A C Sheffield <bacs@librecast.net>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Simona
 Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Thomas Zimmermann
 <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Murad Masimov
 <m.masimov@mt-integration.ru>, Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
 <sashal@kernel.org>, Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
In-Reply-To: <20250910095124.6213-5-bacs@librecast.net>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
Date: Wed, 10 Sep 2025 12:46:04 +0200
Message-ID: <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brett A C Sheffield <bacs@librecast.net> writes:

Hello Brett,

> This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
>
> Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
> removing conflicting FBs") was backported to 5.15.y LTS. This causes a
> regression where all virtual consoles stop responding during boot at:
>
> "Populating /dev with existing devices through uevents ..."
>
> Reverting the commit fixes the regression.
>
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> ---

In the other email you said:

> Newer stable kernels with this
> patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.

But are you proposing to revert the mentioned commit in mainline too
or just in the 5.15.y LTS tree ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


