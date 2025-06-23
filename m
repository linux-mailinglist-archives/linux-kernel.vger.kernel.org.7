Return-Path: <linux-kernel+bounces-697754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D17AE3838
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D103AB6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA420D4FC;
	Mon, 23 Jun 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFrhyEAW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F471D6DA9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666680; cv=none; b=ayC6AvVuOipZQhnsXVQONISTAMGeZNztBzD+pHeEwC25mENRRJ4IDCfnVZCd/SifLapk/hBjag/6rCGi8mBgxXNe8mCB7LKl/R9pOrebK9dUiHfSX9oWJAkkY6gdI5MaLHgzeoy8ti/UrtTSbihUd8LSe0pz9veVIym/Xlocok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666680; c=relaxed/simple;
	bh=taXP7WDD8/lU11UK+rOL7KaY9hZzQVVsVxIvQvyqAuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoctbgzMvxJckYgjRalJjREm6nPvFr3UrhBPkIf/erKrvaGPA16LHMkWNxpzB+9y2S9YKdbnzhRRLqv6VliyzBT6UeOR/eM6MN78rjPmT2j9/sjFH3yXR7ZCpa5pqPTxHsyiZWmGhxB9PTTT3cu0GTmQ54+/oEZKzidTnAb2euM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFrhyEAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750666677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2optOidOvuh7QFbVIaP7zX4TDef2ae6cy4KvRW9fls=;
	b=gFrhyEAWqyufkSFsDNZE3lBj5LG2IscfCKCR/PaVuT5LFOpA9E9T7yImDRkQt9KWtkKbS8
	Cx20MiSMUuV/VX1Fj0nRGgzJYno7dyTkSBjEj/9Ccnys7zMtrdmxk+9s2y66AoUb5aZrWQ
	mqy/aAjTnP8myHtZ9DF4hWiCz6dfetQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-FcDRAz7qMa-2M1IgUPrdcA-1; Mon, 23 Jun 2025 04:17:55 -0400
X-MC-Unique: FcDRAz7qMa-2M1IgUPrdcA-1
X-Mimecast-MFC-AGG-ID: FcDRAz7qMa-2M1IgUPrdcA_1750666675
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-60724177a1fso3539814a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 01:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666674; x=1751271474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2optOidOvuh7QFbVIaP7zX4TDef2ae6cy4KvRW9fls=;
        b=hbuCmXP+OqIlxbXlucDUMA1lXmN0DHZqWTW7i9rZLBaDzAOMlDUssa1zddN4paN0XH
         8DV71fdUe0bSmI+uJoIfp76XF2RrHdisTwYtTWoCqIkHhHFNUUgTTS6TF16ozDPcnFNj
         ThXOkg2UlCmZ772KyCea6IdfRP/pGjA3+tss6vuuRcQgz0VwRMXBR7n3Yg+SNqCaB/Ks
         hvqi/nL3B7+EayE6YN9j08SSN/sQtZEg/7JLLzu+gU9njPLuuehGhvhSUfd8o6vc7gCH
         97XbisQ6iW9mdSXvTAe/2ilPhr0HYNI9/J4edkxPt1Qmfs1QDsbPYa6s/Q2zXCaxpDvu
         LCcw==
X-Forwarded-Encrypted: i=1; AJvYcCUqGF+DwAzf5n/yto7WHTsV/1bgBj35CFmiWIbPrZLqNRNqmX3REIdNuUhaWyhBuqjWk7vPDzNU8pE41bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnr/HndymMNP8eD1Lhf9DV9UDXAWrRkGaRo1YOl8kIDa9NhQA
	6Qtf2NnaHAsyyJo3YPijODcJrkMQ5x5zYXfaHlH3ZN4snoX4r8lWUG823tQWP8eV54K9eZB5ROa
	p/iSBFNvdviUjXqsnzX4NfDF9Pi37GLT+hmxajUv21NErsXm7fkVROf2vJtkcmxTAQw==
X-Gm-Gg: ASbGncvczI+rGNaC7g2WuPW3jCVlJLYT/Jsp/NSEv1upig3/CyNfOGkNur9FKNHLH/w
	LmOXiipY1Q8y1gjXdyMePk6fnypI74P9M1MAQvftp3lSzRKhszCTEdwjBIz/3pseHg3ngRkKFQT
	iccdYx8mkyRjd1LCR9mWJa4+K0jZ5IyOuljAPs9mjF/NbNhj4v6NfUs0GtL6wg3TYO/GT0yWM1/
	DE/YJ+0C3pBHQyIQ+z1s2xA8Ce67W2W84dUHG5YiqoDcmJpLzuOVexj4vhI7xvKpx/qPdXkptgP
	yFSPMQndtz0TOUtS0b2xktoB8A==
X-Received: by 2002:a05:6402:44cb:b0:60b:8603:2ff8 with SMTP id 4fb4d7f45d1cf-60b86033002mr6272829a12.15.1750666674667;
        Mon, 23 Jun 2025 01:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNNF8jZCqYgheFCScBSFPj8i52Q5VHppO0D3a8RZj2iDP7EeavHZjc6mZHpik98x9jOB3QBQ==
X-Received: by 2002:a05:6402:44cb:b0:60b:8603:2ff8 with SMTP id 4fb4d7f45d1cf-60b86033002mr6272816a12.15.1750666674268;
        Mon, 23 Jun 2025 01:17:54 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18514500sm5761336a12.5.2025.06.23.01.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 01:17:53 -0700 (PDT)
Message-ID: <bc831f09-08d2-41d6-b552-ede43f8f2be2@redhat.com>
Date: Mon, 23 Jun 2025 10:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add interconnent support for simpledrm/simplefb
To: Luca Weiss <luca.weiss@fairphone.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 23-Jun-25 08:44, Luca Weiss wrote:
> Some devices might require keeping an interconnect path alive so that
> the framebuffer continues working. Add support for that by setting the
> bandwidth requirements appropriately for all provided interconnect
> paths.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - Sort the headers before adding the new interconnect header, in
>   separate commits.
> - Use the correct #if guards for new interconnect code
> - Pick up tags
> - Link to v1: https://lore.kernel.org/r/20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

for the series.

Regards,

Hans


> 
> ---
> Luca Weiss (5):
>       dt-bindings: display: simple-framebuffer: Add interconnects property
>       drm/sysfb: simpledrm: Sort headers correctly
>       drm/sysfb: simpledrm: Add support for interconnect paths
>       fbdev/simplefb: Sort headers correctly
>       fbdev/simplefb: Add support for interconnect paths
> 
>  .../bindings/display/simple-framebuffer.yaml       |  3 +
>  drivers/gpu/drm/sysfb/simpledrm.c                  | 85 ++++++++++++++++++++-
>  drivers/video/fbdev/simplefb.c                     | 89 +++++++++++++++++++++-
>  3 files changed, 173 insertions(+), 4 deletions(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250617-simple-drm-fb-icc-89461c559913
> 
> Best regards,


