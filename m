Return-Path: <linux-kernel+bounces-820328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC953B7EE64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C503B1891D44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE82EAB68;
	Wed, 17 Sep 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5ZhfZe+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998D2BDC02
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100999; cv=none; b=iRbOajGAFUBiJ96in/CuRl5O5k+LM+l5r1nwufnheB2N41CGODwlv54tgpdazDQ/lvrEtOsrEKdA009+VQOwh/JvmSoTm9LvHleYUn7qfEwRAOdzEgLX1V/1S+SroupIdhBOnIwz2V8/6WLQoQ6O++HTCrw03A2q4qD7cfDJu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100999; c=relaxed/simple;
	bh=/OnTDpiYLJaTVNQZMsEE0kOpeeQejpU4GhdSqVsquuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EfJKFlzbbHIzPGv7RB7dOCThSWGYeQFQL65B8ccxamSZwL+cA7QkkuS0NMCB+++JAYmh9harO2feh5YSHuTt9mq3D1Dnr2aelAzCOuQRcob5+uNlcl+rg0WV00tYFEITNzGdtExA3Q8rnkVBQJ7osrjkJveCmzFLhAndp3Wif2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5ZhfZe+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758100995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvSCxZfh1AeN+mbSyVIIhh7UrokaGa4ZRWUpU2AZ1oA=;
	b=V5ZhfZe+8qzgs48rURRn+0xj6l9oO590K/Jr8D6+ECXVTcMnPJifMPCmXw3xZzu6JW4hwP
	YvbOc5xcTlLN26RXZlTlCwBRYjR7aEzpAFXSMnru8acCGQ+udMn26VbYvzzZKoQnhG5bsa
	NEAgXyU9KrTQMBdd+/ZFWykr8ia8dKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-lYq4uFdVMAudwg-e0rYh0g-1; Wed, 17 Sep 2025 05:23:08 -0400
X-MC-Unique: lYq4uFdVMAudwg-e0rYh0g-1
X-Mimecast-MFC-AGG-ID: lYq4uFdVMAudwg-e0rYh0g_1758100987
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e997eb7232so1782270f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100987; x=1758705787;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvSCxZfh1AeN+mbSyVIIhh7UrokaGa4ZRWUpU2AZ1oA=;
        b=oBPkgbHwU48iDPsnI7ZK0Wlqu+tKvymcCW3U92UGeV+3SzM9RNz+IRiQ+Mf5V2A/m+
         A9r9uT3PKbFcE9pyKX2HSrxdYcRK3g1VWLtMVj3PieKsh13c6LZ37q7WbCEvA3oo34/v
         sOn+hjswKpNUNZRiwHY21flc4mRsN1byd4/UiRBYni3C1vDhKJ2jOGG4/SmqdjLRx4n/
         IieOeHO5g+5mXZKIvHW75noa6yuAZ/X/+ZMVlLDXiNBBmLExo1BKKbMmn0+Mh4z14qN8
         I1Vh2084z+emQrQNKDolZqGtTBU0SENW5lhFZJ6f9fKtIkxlp09kN5VB7o28Gz5BBd3K
         JuBw==
X-Forwarded-Encrypted: i=1; AJvYcCV5c0JpKjyrMFsM8L9fxk6GHekIGjXMVX6D+HR6bA/OOuU33mmZe4nhOy/JpPVkzSqKLu0ru+Y5uGQd4ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmLSQmNvc4+9OIEVUu0DXz+1HNnthcbBk1ni+7iZ+Uvu5GiEP
	YOKMrKm//VekuXaKe8tE718wVtY2WP+3am8MHn50iSXFlYxP1hq76RkN3FIf7KwT37S428x3tjw
	DuPH4NtrvowDefpiMR9vXDOzUclOL6H5oso+mRjO0/3f7EN0bmV3WliUSlhqYfLwFyw==
X-Gm-Gg: ASbGncssE7KMMpVirnU9JT7bz85CrgaSkvKxQ3tKBeNcAv5rf4LY9wpcLGI78nhctb5
	vxXtUf9Wym2EmJuPrcHVkrmxdsWcibB/LzlO2O4Eb/w/tITLGDaYVvxGQ634B2DHZPOv9bVIC+n
	s5AzO9nn8D0beRTeiwfSJwO8t4EJ3EQGX7tu1WiKakVlA18rNgZe8Y7FTASddGg28sTaWwbpUCw
	fcwWSPYZGnoYbNKwbAJyRum6hdEEPVT4OhplDxQ+2ZD5lFnGFsHgkhwgqbPHrlMU/1olWk9lUO1
	u4QCllqipfus1nR1dmMR29vYcFANak3AQoTLUYnDCCKzAwR7PtJmcw+oLnZYrUV/1aMiwXpmolO
	kKX9ZBFgKLjLno7KHMVuXdA==
X-Received: by 2002:a05:6000:4287:b0:3ec:db87:e9d2 with SMTP id ffacd0b85a97d-3ecdfa4d33bmr1584042f8f.44.1758100987069;
        Wed, 17 Sep 2025 02:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFqihtnYAqZ3D3nSwkTZLk2BK6pesDEk8SJPPmPKbgYsWaRJlkSUXI+rL4TmJt9PjMeujIMQ==
X-Received: by 2002:a05:6000:4287:b0:3ec:db87:e9d2 with SMTP id ffacd0b85a97d-3ecdfa4d33bmr1584015f8f.44.1758100986681;
        Wed, 17 Sep 2025 02:23:06 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e900d8f0e9sm16348063f8f.35.2025.09.17.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:23:06 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Iker
 Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH 2/5] drm/solomon: Use drm_WARN_ON_ONCE instead of WARN_ON
In-Reply-To: <20250912-improve-ssd130x-v1-2-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
 <20250912-improve-ssd130x-v1-2-bc9389ed299e@gmail.com>
Date: Wed, 17 Sep 2025 11:23:04 +0200
Message-ID: <871po5ph53.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

> To prevent log spam, convert all instances to the DRM-specific
> drm_WARN_ON_ONCE() macro. This ensures that a warning is emitted only
> the first time the condition is met for a given device instance, which
> is the desired behavior within the graphics subsystem.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


