Return-Path: <linux-kernel+bounces-820507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD32B7C9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217A7320766
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224228466C;
	Wed, 17 Sep 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLW6BYxL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D17464
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106150; cv=none; b=T9EqVDXdOMC9gD5MvTiMEKW7uo6eot+jm4UZmkS75mR2XsGE6w+W/uwc9fBvecXVRM/PQEwtk2g0lA70WAYR4pcOEQtDma6UCrk7JgKFsl985X2NoYmmFjxCDF1zTYQtwS7xXBrKU4SWOR22Cj2BaWWlFiuyfhdshG1M+sXfP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106150; c=relaxed/simple;
	bh=/Is+QhC1ppKcBnEuR82I+wnYLqHDhOXEU1Sx8//I0FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tw94FbDH4i+hKAQ7t1RO8/CnCPA5zJAhTAmE69K+WshnqjqjZ8CsoQ9gwc2BxcP9myr6M2hkiPqQZ2T5QSxvvPEcIbAoUBEiRg6FinD/IGa7nz/lXGS061tl0G2TGkj3y8zmilbe/jHgTuIahud/YBKx329skBqbCXTA3R00eGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLW6BYxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758106148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gx+TdCKsbhxyY3jdn0KEhYYDqelpsIcgLkEZzRgBNo=;
	b=JLW6BYxL718bQyeLTMPTMZ37GizK1d1JUb12DMAyf7B5DNw+TGTFYbNyQ0HH+MBXUPTnpQ
	ZDHkg1qK3BYVSRNjqHb/hC1djOJo4FgRLl1tgGDQVtbvb1wnlNxmEj3L9jPf4lXatNcMUR
	OJetGTN+fgDUXK8ics9a6MjDwMtOWDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-QiuOPB37PzyM5e3OqyO0bA-1; Wed, 17 Sep 2025 06:49:07 -0400
X-MC-Unique: QiuOPB37PzyM5e3OqyO0bA-1
X-Mimecast-MFC-AGG-ID: QiuOPB37PzyM5e3OqyO0bA_1758106146
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so49330085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106146; x=1758710946;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gx+TdCKsbhxyY3jdn0KEhYYDqelpsIcgLkEZzRgBNo=;
        b=xS7gwwIPpNv9XB2zpNochb7XO8MJUpWfmYa2mC4QOrQVxVxTIjMVwYJ1xfBDAqNxJ/
         MpYXSCVp8ahqBRdxKDCYEjJkPMVHLMikvWzSrbHCc0njZ6qbajL+SyuLb64+6UQ6MFAS
         tulwoJI7c+POYm/tjwBsPErCYH+d8QNbjZR6qt/NZiiti1DLrlp4TT7C6pMQP75hajxG
         hllCY3bJusYc+R6WNhr5QTEa4+3xwqdd/Zl6Oms7sT16FvdRj9pnr/zMEmK0hAU7H573
         +FrPbbr51Qe0kyXv/2XwdrZXnE0E2HpObLvFOUz5Nm/FagMAmeKUbRDhvTQ3zJ4oDByO
         qbJw==
X-Forwarded-Encrypted: i=1; AJvYcCUAEk9Ec1I65bLX4DFk6iDDRLFgh1l0nbffqPVYOqGKZaEd+rDQL/47a/1Rmt3F+2Gkk4WHHnZQsCLGjuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/5sdAgabJorLl8W6MmzHqQ4dDthckoZ4OwEFKhybvWxReniW
	0KP/IMD5KyKlylnntvwqaldxa1ntNWgetghpa45GkNXEh0NlA6WMR9yhDFCx7+PkemrTcrkghHm
	6jw2AwpxlmpuGnrifmyxoClDYWvJsuaN4YVJtY0OWiFGRNpaEJFkDYW+kFvdCvIZ5dw==
X-Gm-Gg: ASbGncu9c2Bsm0quKSipP5zNotFEdMt7NWb2bjoKLcWKHT4GNk4798eekNTGqUNOBrY
	t8qC5s3VIUOICfZWayUS4v9V3/N5URvHbq/Q81gUh2bokbrD/1ryhnMoFQBS0UZZz1RhHix8dNa
	5dA8NKCd47mhsU7S46ktUyZ47i9f8FRZzwJBGt/fmFvmAuKEnpUYQhP9If07ub2XttrpC6hzzQO
	OGX3FZOaRKmBQ9yyH8Ubyphl40LdxsOwMenkzmmWhEJWmDAFip+PXVByLryq++jZqDKFx+HkRnc
	6Rg3DXUCv3Gb25xndDxL1v/yKBEcB9uMwH7iKmKsgUrDxwqRVQgtyD6fahaM0kf5yKrPiCZDMt0
	Xwqc9X6tLJVPKog256WD2dA==
X-Received: by 2002:a05:6000:420a:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-3ecdfa2af44mr1788142f8f.45.1758106145845;
        Wed, 17 Sep 2025 03:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDibHsRXwK4fNY6Iro6utVUGE4L1K31z5iDT3jS0cDkRWw/GZJYpDVS83FdGh12iI5IMZeA==
X-Received: by 2002:a05:6000:420a:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-3ecdfa2af44mr1788111f8f.45.1758106145366;
        Wed, 17 Sep 2025 03:49:05 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870cfsm26394071f8f.19.2025.09.17.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:49:04 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: James Flowers <bold.zone2373@fastmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 skhan@linuxfoundation.com
Cc: James Flowers <bold.zone2373@fastmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drm/ssd130x: Use kmalloc_array() instead of kmalloc()
In-Reply-To: <20250914073841.69582-1-bold.zone2373@fastmail.com>
References: <20250914073841.69582-1-bold.zone2373@fastmail.com>
Date: Wed, 17 Sep 2025 12:49:03 +0200
Message-ID: <871po54an4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Flowers <bold.zone2373@fastmail.com> writes:

> Documentation/process/deprecated.rst recommends against the use of
> kmalloc with dynamic size calculations due to the risk of overflow and
> smaller allocation being made than the caller was expecting.
> kmalloc_array avoids this issue.
>
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


