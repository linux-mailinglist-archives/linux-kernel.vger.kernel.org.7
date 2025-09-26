Return-Path: <linux-kernel+bounces-834092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E692BA3D66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3301C05499
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0146F13D539;
	Fri, 26 Sep 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgcilBPL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DC28E9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892525; cv=none; b=PW0zydE6i22QM6cG4/Ny4sVH08peJs+c/VAUtfkznZR/aHnp7C9Z8iw0Gmq1hHFGM9ghAeY7nurGNk+bRgtc7t4zIIdinf+lONMsTQrA6vCGU7/G34PAu51QgDZui04LK2L3QYU82jo3B2e80cs3lW5TjrEghOLnxUD8CaEzXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892525; c=relaxed/simple;
	bh=JzOguCLcc9FgOCXLjHy3k9+Secjg1Vwq7ITLXqNYsPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7ENMv+oNhXpWi7aolZ9wCSSwzuq/IiuPJPeVPdFU7JiiQ7RL1EsCOALSbI+rksPpXJ0OnKQhS0oQmXTTzHt+uPZQuSn9NhCGbGuraeAfgMdpuURZ1OK6HCyTVjnFm1qX9e0HNfVKN9wjX/QYwX/rLup43wdMRKb65FUBI9Pcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgcilBPL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758892521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6gloL9plQf6RtxB5L806/XSaHmhkeCLtVCZieySzvw=;
	b=GgcilBPLALLg+6tVnVFOmME89hcztavtd1tyymFdaiEylJ+3NQu4tSyDPWBwC2XL6XjE4o
	TG0Nypg+m/114Isp+9E629mhw/iyHB7rmhgbbJKX5M/ldgSepiFBYHybOiK5mfUSMsFgnf
	33lRDcGIyqWA6IlqYzw9GHaEaJbV8U4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-xh2UKwWkOFiVWnnXQzitUw-1; Fri, 26 Sep 2025 09:15:20 -0400
X-MC-Unique: xh2UKwWkOFiVWnnXQzitUw-1
X-Mimecast-MFC-AGG-ID: xh2UKwWkOFiVWnnXQzitUw_1758892518
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso1283845f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892518; x=1759497318;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6gloL9plQf6RtxB5L806/XSaHmhkeCLtVCZieySzvw=;
        b=gmKHNeNNho7z56GHRaNOX8ZjMIc+FDJe71kvcEdzz4s3dST7tzg1Z1dbi0yLCooFCe
         w3RQzhS/JTFPag+ua1wEQAqUZTvv7fc/7b9QnSAqgso9bZMSzmD8TZmeYiLF3GBu1vz0
         f8WoY3Jsterbmrw9l5qSxBCpC+ZGej90PxxsvEQ8sIR9DM8lmn/iX/Ik4OE2aKK80F7L
         hnhzl0/dvPkiHKlKPkRhrpASRVJIGQqq7MB04bzIHn4Qf8B4P07/9RSq/6vneGB1xIV6
         HaEMafxk6Vt5NzpYmd9VbATcj7sL09JGgq+twuZFvKvZSlJ0BJSECTuXlD2zrTU6RTir
         ODXA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5SLCxqYPmuLUIpc/ik89/WWiMQpCOES5TE/a4rXHuzNLINmiuDh+LzkOrUSmoUJUi2LyxPmA2Uf16Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/upJQy3HPxU/+ueSnc/vVTGei2c1hbCL/Elc+v8svpcMXcS9
	+6VtR51j4UuyPt5z6EUo5wUmOrosSdDGPIizYwkh2a7nqQdGhVPSgM0Yv8gxhjJKngd3Dx722PH
	Qo9UI6OEAlukzKwEkL/V8T03c1Smfy0FR7SWu1tmErZWsrEklLAhKv4XtaELNfbP3WUikjBlcKg
	==
X-Gm-Gg: ASbGncsbgqj/ftiiV4QRNNCXSxJdYyu+b1QyqcKEPng5kXphwwMlA/cfnMYrSmotlaI
	pu7TCGvI5k3g7ce9MiGgIcvj5uZLGrZ6EbKncvE8vvvryER1g5H/bsk2lSjbnj+VM75xeHpGZA7
	YN7NX40eYMDQp9VAqxVdG0FLZbNd2+iMw7gHaQSS+pgnBuJQ/KEZYhdlsi8aFr8XoqvbjM1rX5J
	tmQfkaFjELj7U4xLUw4VznjWF2Ns7+3qTKHyQAgfyBxNzUiQSxQsQ43PX0mVYlqEN9m6UwLuKyr
	eN4SFuL2dIkc3/7wkc3OHE4M0DT2oa39xlaAaiS5mfCHlpYAT9sxLPDuoof0q9GqAQ==
X-Received: by 2002:a05:6000:1acb:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-40e447772b6mr6450697f8f.1.1758892517664;
        Fri, 26 Sep 2025 06:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdQJaXU6qBeKy575PXxNR5wMjBV00QJq4HVM+OcRu1Z+hB4Jn+gkEnlY2TUSw3YCIQLZKVw==
X-Received: by 2002:a05:6000:1acb:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-40e447772b6mr6450663f8f.1.1758892517117;
        Fri, 26 Sep 2025 06:15:17 -0700 (PDT)
Received: from localhost ([90.160.50.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm7307121f8f.20.2025.09.26.06.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:15:15 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Iker
 Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH v2 0/5] drm/solomon: Code improvements and DRM helper
 adoption
In-Reply-To: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
References: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
Date: Fri, 26 Sep 2025 15:15:13 +0200
Message-ID: <87zfah8ie6.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

Hello Iker,

> This patch series improves the Solomon SSD130x DRM driver by adopting
> existing DRM helpers, improving code clarity, and following kernel
> coding standards.
>
> * Patch #1 moves DRM GEM framebuffer CPU access calls to make critical
>   sections more visible and maintainable.
> * Patch #2 replaces WARN_ON with drm_WARN_ON_ONCE to prevent log spam.
> * Patch #3 adopts drm_crtc_helper_mode_valid_fixed() for mode
>   validation.
> * Patch #4 adopts drm_connector_helper_get_modes_fixed() for mode
>   management.
> * Patch #5 enforces one assignment per line per kernel coding style.
>
> These improvements reduce code duplication by leveraging existing DRM
> infrastructure and enhance code readability without changing
> functionality.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
> Changes in v2:
> - Use a goto label to ensure drm_dev_exit() is called in the error path
>   of drm_gem_fb_begin_cpu_access().
> - Link to v1: https://lore.kernel.org/r/20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


