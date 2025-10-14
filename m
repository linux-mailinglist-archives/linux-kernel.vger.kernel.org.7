Return-Path: <linux-kernel+bounces-852025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD3BD7F92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886BD3E6716
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A72E6CB3;
	Tue, 14 Oct 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg7USC6Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BE19CCF5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427483; cv=none; b=KdrrU6MrArxsc1G6AOmEPhWjs5IGmqHWi+hI2sC0h0GmMVZ3wzhleg24CitqYNw7fOrNSriEj7xpqbc36u/OLga+jMLs0bnl5q9zEXuNINhM29X/qqsuZ46YgeLnrNdR1NYqsrBd4Bl1DYQeWkpKcRS+Tnr+WOfqamRIqioPiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427483; c=relaxed/simple;
	bh=9hS2W03OaaDBRq488L5ZeXOwSJoUvpd0BYVLf4iTHzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSlx9s1ePnBVjXbEFvsmdbDk631KFCYRPpAv0rJJh4k2aWeid+990m3c8OO52CW2FZOYyJLUd4zNGwwR1Qb5XLtORAFq/yzZ1ezGSMhontzVkSK1fG6nuixf+le2oDJuFmzZ1FQNmfWqxDJjldmRYehYCl3mAND3CWxYNyugrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mg7USC6Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajVLHYVNTc11NQnF9+qMXQzNmIez+Zi5q8MUvX7v/NA=;
	b=Mg7USC6QWcCFg5zQBgYoFi1qjO7lWsk6ikoNCOKuDNgo0AjsfGN1ya5Ss/xKQFSTSsiUiz
	WEzgCYMMVebZRmFf0Sq3CgZfyXycMZElqypvuh+TGsaUa7fM/j5MYnr4KCgbg/qofr5v0Q
	hEg0zAxmKJ3OiwlDzHfuZqyNwPZMOEA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-DHaW2rIWNJeEySAF3aa-yA-1; Tue, 14 Oct 2025 03:37:57 -0400
X-MC-Unique: DHaW2rIWNJeEySAF3aa-yA-1
X-Mimecast-MFC-AGG-ID: DHaW2rIWNJeEySAF3aa-yA_1760427476
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee10a24246so4140235f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427476; x=1761032276;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajVLHYVNTc11NQnF9+qMXQzNmIez+Zi5q8MUvX7v/NA=;
        b=oixmXyT4RXmPPYcUYRobF/4wlUVtvQX8/wA+MavGwac8AYTg6JRHyepi2aK8pDqsJZ
         bMtCj+OapvKAA1uogdhviopP4zzCtnbySMge+6DNrhNkeO5QFYYEulD5UDHIvYzICJfp
         qBDppuDUneYExB3ZJMFs/ylDNSMUuAtJ4V5yA50KEgLIl0oFzQBce9bu21SXHQt5cNhJ
         aP8SEdsfbi5eJ+uQy6UupGOSpBH3kgdeervH9HtHMkRPDzvNgAkyHQCiHzpm3x21Hm0O
         tR+PV9HDWOYoc3jLzwtlS7QrCtPeGJbTP86YE3GLNjG38hsISM9mNwyXYFEb3nkx2URb
         MTkA==
X-Forwarded-Encrypted: i=1; AJvYcCX8RE4eflVG91XQ47exUW9LDtbT+YF8OuL0QDzLdxaa020Pu8BMGGA2ZypzuMOnfT/Uij7AS1fG06lKlJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yXmxem5LunrWEY3BfXPYyw0Akm5QVcuGoM5heR/q7qZMjNjV
	ItwIfBX5wcDNbSXGk3yQGLAzKBWcQ11+EmyXl5bhQ62D3OTNb6ex4GcQS8vDDQpAFq4FyysQy39
	/bAkzL2JHSA+paPgepA+yf4uPWCQRp5EUrsDHdSglk0/M6VOx4mraEVnES3y5/RNw5w==
X-Gm-Gg: ASbGncuZWIFQc7pr+MkSO0j/8B+UI0zApEnm7FoA+Vn9wGbUaS2CPn7itxEYMd5Dj84
	xZVAQTTpBatl3spo+b1k7wY1pExKcgLcIUQCha28Mitk87mQLz6uP4MlgVV260XJNU2iu48k0hS
	37c2JCxIxruNkk4ev2mbXwwgzi9o4ZememxspaFUosiBmPStf0pFNqCZzj8Zt/TYthWvB3mTPWr
	kWsVtbMUyBCqR9PKaQi4qiNhf5mbrB0dnLje2aZ2xFMNv//dWNwi6cMNEKF8SGAF8catGOKi1dd
	2Pcgka9P0cO7UMgOUbz4Clf+/zLNjCwbdlz/KvzhwhFmiiYch2uVd24HLLT/DBDAVGwrDyrY2NL
	yGCfn0XLqHbBHgibfmij7sV4=
X-Received: by 2002:a05:6000:603:b0:425:8bff:69fe with SMTP id ffacd0b85a97d-4266e8e6c55mr14958367f8f.57.1760427476426;
        Tue, 14 Oct 2025 00:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFakWFpLVIjohFo3FxWGxf+m3faCZnqyMx0D0r3L4Uyua5kzQh9UCZhYel6YlToPfvo+XXFPw==
X-Received: by 2002:a05:6000:603:b0:425:8bff:69fe with SMTP id ffacd0b85a97d-4266e8e6c55mr14958352f8f.57.1760427476002;
        Tue, 14 Oct 2025 00:37:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm22711021f8f.23.2025.10.14.00.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:37:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6/6] drm/panic: Fix 24bit pixel crossing page boundaries
In-Reply-To: <20251009122955.562888-7-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-7-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:37:54 +0200
Message-ID: <874is2q6gd.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> When using page list framebuffer, and using RGB888 format, some
> pixels can cross the page boundaries, and this case was not handled,
> leading to writing 1 or 2 bytes on the next virtual address.
>
> Add a check and a specific function to handle this case.
>
> Fixes: c9ff2808790f0 ("drm/panic: Add support to scanout buffer as array of pages")
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


