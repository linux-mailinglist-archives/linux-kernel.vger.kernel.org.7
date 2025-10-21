Return-Path: <linux-kernel+bounces-862526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A2BF5877
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABA343528AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5222DF3FD;
	Tue, 21 Oct 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy7KMu5y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B60221F0C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039307; cv=none; b=XlPg/Sy+DXxLOo54fXozsoSPydXdZaqoCkqJ3m6hqo659AAApo3Q3Oi5eSutDS2JgCEsvfUM427ss153HFpL8C7N2MD5lMlIw+B/aXaqyiFXMd4XPl6eUqNKxqFBqKSaR3ef4FQU0XpsNXoh/bbv2JikiXoPccxgm2OSmKKQZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039307; c=relaxed/simple;
	bh=l/h5cb+0/LUyVGEvr+WGHekbJqC8VotYimlfk9vdV8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4BPS0kNa2dz+iSOJdwQXWWQU4fAINYOsOUU1DV0GUMkGaFZhTs/pNPiSGl+l9hsZjBlGTLxHmUHmJ1OjznQefwotwKpBGfGPM/m0j4dT7p0O3vTNN+13KtHD4/k2COrBEvsb+fRzJ4R2HhTGnMq8d9qLh/3COMCzuK5S7xa7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dy7KMu5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsfpJjNAphnWLSpR/9hQ9zHV9rrWcLBcQx4ViQ+mRJk=;
	b=Dy7KMu5yEjZQw4h5LnXqsrfU/O7/Nk3NzznZpw6XRTLby5qFqUciQg9UbPhGHgfHOaLRaD
	jGeGMePhH9AkTQA7OLN9qCsMfXJQ67o6fV6c9FWWJ7XA44Ic0pTwGWbfyjyf+tU7AM0HY6
	eXe+J17PzHCBK6OAt/bBOzPtMP2sAHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-guDNe7f6N5KhaLS35Z663Q-1; Tue, 21 Oct 2025 05:35:03 -0400
X-MC-Unique: guDNe7f6N5KhaLS35Z663Q-1
X-Mimecast-MFC-AGG-ID: guDNe7f6N5KhaLS35Z663Q_1761039303
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113dcc15dso37507255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039302; x=1761644102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsfpJjNAphnWLSpR/9hQ9zHV9rrWcLBcQx4ViQ+mRJk=;
        b=B956yTJ3hGOuzXJv7eGvqiytfhh98WIrdgFXPALtpcbtWav9ISWcVubLm82ydd2ATT
         AVzq8t2z7KEcaUC/7x51ietZAtaSB2GmWDK5SP0tVSuDrPgmoL+MNJZuGvRvgMH4+VpL
         F9ZgWUUlUuQXd+HHqIgnJwewfuvANWBvh3/ipqZyaaBQ6toL9vMtsDI00Kd7xK0Bby/c
         KzMXg2iHVjMWiUmvTQP3UD2OS6drQZWy27rFsuwbG4GyUlCEhBd4qO1Ht0X/kBGuma2A
         JK+W9Wcp6nIl/Xa5mnMdo5R5Rw1xYWUYbVgIynYJ7F8vfbdty9gv9U8bfVp6sL/O/LyQ
         ClCw==
X-Forwarded-Encrypted: i=1; AJvYcCXRzhfDyxrv5nw+MEuUwqNIH01/GreZr5mCKcR2l5eXcKcpceJstUGNFSG/qb9ggplavEWyI6gXJX2oO0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKICDPmIpaAMI69xQw+05Nn8vdWR4Uz1WAERnlgiAsguyCsV1
	ERYUbx0b8sEPZzZqdbgNChcwncneV9G5IkB7UUHafsjv01o1OtFtzfawJz+qr1SnlxMm3zthjUZ
	BymGVULzc/Enen/hOophx9ex226WjSt7Y6NPLq0fEGhb7anEorhPnlPInBLne3ZYwLg==
X-Gm-Gg: ASbGnctGYGpYBwhMeBT3VxBajIQGPJoYE0sLfQPbtLKZghyP8d49e8FceBpVcRRkjut
	zGv0+q62PpV5ELYi/ci7QduxZz+3MggRGX5Bab2KQzSeXCfvpkSPguxt3tSdgTktLmdVA3bCQgZ
	sFNijxDuZMUrs8Yar4/omCafNWDVKZcduUIpOrchS1kZ1w9Zx3bddnH/5VCQJZ7Df3LvCnOuGvx
	w3o2FDeisThJ1yoeiAaZSIt5ZiE3WS6DynBIsYlC1ZQzOFvQxWNuNz8D/qWiKpAEBH39FKmD13w
	EficZXBvn/Q3C5BetmTHW8IstFgv3sVO2WHvVajum2vW5kkyZDHlUTHHtdfnEkhCLcsqDCIcs/g
	5nr32TD4mSoK7OGu9Mf77slKzdmZyCy9dJzx7jw8=
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47117912b0dmr121009765e9.31.1761039302598;
        Tue, 21 Oct 2025 02:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt5KLfPmw83SPRT8OisjsvH92UuGC/3O3ChwZqMD9Wd7ly0YlXsAEqC/1kFgopwE5vclnf0g==
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47117912b0dmr121009555e9.31.1761039302202;
        Tue, 21 Oct 2025 02:35:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm19776843f8f.51.2025.10.21.02.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:35:01 -0700 (PDT)
Message-ID: <f8f1e0ec-46fe-4d71-94aa-bdd081ec35fb@redhat.com>
Date: Tue, 21 Oct 2025 11:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm/panic: Fixes found with kunit.
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251009122955.562888-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2025 14:24, Jocelyn Falempe wrote:
> A few fixes for drm panic, that I found when writing unit tests with kunit.

Pushed to drm-misc-fixes.

Thanks Javier for your reviews.

> 
> Jocelyn Falempe (6):
>    drm/panic: Fix drawing the logo on a small narrow screen
>    drm/panic: Fix overlap between qr code and logo
>    drm/panic: Fix qr_code, ensure vmargin is positive
>    drm/panic: Fix kmsg text drawing rectangle
>    drm/panic: Fix divide by 0 if the screen width < font width
>    drm/panic: Fix 24bit pixel crossing page boundaries
> 
>   drivers/gpu/drm/drm_panic.c | 60 +++++++++++++++++++++++++++++++++----
>   1 file changed, 54 insertions(+), 6 deletions(-)
> 
> 
> base-commit: e4bea919584ff292c9156cf7d641a2ab3cbe27b0


