Return-Path: <linux-kernel+bounces-852011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E5BD7EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1DE18A164D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3FD30E835;
	Tue, 14 Oct 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAhSY8m2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4830E821
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427140; cv=none; b=gt2ovQ9bMp+8Xuu6cjCWmtdgstaRilnzCk+dyUKHmb8mxeO8Yik4vsBxT1EwzKjPBjptrqvzLm8sDosjqVc3FDzi6V8CUUMdfVkJ1P+fndHUU8I3/rPFIyKGFX8zdURas49r9IHTosfK7h/KgNr0+cOwdafDQTzN8qjVE9gzfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427140; c=relaxed/simple;
	bh=tIefyQwY7kzYvRvjxqhE/Rg+bXOUCtYqGqMTPTNbhIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxJzOG2cObLS3zkQX6dmYHt9axotRR+i35qhDQ/Gn8cpgaBdvuPSs8uyKtWbSKNPyPbHHV7epIUoxEuQBor5aj/RGlqgyHED8z7PbfjMpv7s6qzelxXA6+IWpa59fF0yOJSKCaLS6japbjQdVQwSRp8NExSZ9fjakL5+NT/vvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAhSY8m2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTEvqfVMwIkz4DW8+ZLEnZjvY2H6k8QKs9GKfPXMt8s=;
	b=LAhSY8m2ukMvZO5uqLG7eYhIB3xaFp5b5yv8Z0ihyV0YwDloSQid2VPWsJZOvOvL4udeac
	9xfbPz5PEjh1sjOOG5+1nOKTC5D8rMk8kS9Vp7ZDhYim690XGODrWdxD7vV76m0jSIQZBr
	NAyKGPU8S7ROtTSpZQiCAIfN9zybd9c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ZATxpRZNOMKIuUFWIi5e_g-1; Tue, 14 Oct 2025 03:32:16 -0400
X-MC-Unique: ZATxpRZNOMKIuUFWIi5e_g-1
X-Mimecast-MFC-AGG-ID: ZATxpRZNOMKIuUFWIi5e_g_1760427135
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-401dbafbcfaso3921863f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427135; x=1761031935;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTEvqfVMwIkz4DW8+ZLEnZjvY2H6k8QKs9GKfPXMt8s=;
        b=GF93Nma/u2TG0IOvWzifwYGr1LeBwHvZBu/QUp+ioqpcNFIkgSrsoedT5ug7cA0e5L
         19JRVogQZNLHOzPIbcplUtxAjCfLC8YcVG1NcoeoZZCiOq3Z+mj1x1myC+ymni3arzvT
         0Ijo3OloDy5vpSwzLA0Vk36vOGZClsTlp2EzYJ6zfxjNNQBtRDdYGuVJVgcNkaPjN7BC
         haiKcDX1Fit4wrLQAoSj4MWTbJwNw71MteIRVrfIQ+CtfmprPlMHQUGk1ri9SBpPTlfz
         RKEb78UVI+Tlc8i2uo4OlcTgh518OwaNMOnBzjMCm+auWfYrWin/mmGCY7tPCJhaPd8V
         1sHA==
X-Forwarded-Encrypted: i=1; AJvYcCW6mN0p3UIO/9nTSrii9Yv8oQ1eemSFNE/jGjVN0IoXffwU+dK0Ksqzy48AAhHzs3NnXdC/COj3kUDj5jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsByEIrKHbDiBlHeZo0O3XfwDajPkfu+p57xAxnfI4r+7XKR5i
	6bDtrYtXjsf2IStNBYV2iwTW/MI/Hkqt7hAbJNZv+L9PWef6PdQvePUW8zvR5YprKRizzTrS+Iv
	qGfDTQH/xSEUhs1i5f0QZOfms+yIDzSOtu8ENd1tb31qdjNjsWVS0Jkv9uBnaG6qhsQ==
X-Gm-Gg: ASbGncvQ5LDICuFMpB/sgocZTARRRSePwi8emjrUvP6Mge5CGMDz9ogKixmtMUQSFnQ
	lGZCzeb5m2r+4oN7vnc0N5vUf8vQtjjLFu8/Wi88ziu6cAFvw/zWDl56FQx3JOy0/CzXN+RZoOV
	PPmWIOVaKDhQqYjACRbAON4AJEShqoWHLUG+WUIizqoeMCbFKKSX833m5omoIaN+uk0a0VW0Tdq
	DiGaC62RXQM1IzZWHYO8gBG+h50KErVBLz5fabImc9d+N3u2TDhuyXZrpmZg3XUIeg7lHP8njc5
	Tgxan0Lz9jqLOZ7MmMPoLNTob6LHRo5L0/nvX1SWPoZEgcQlzY0h40lW6K69j5naPR44NObBDrY
	F8MyvlOkDvBRmrgx8qyUQEdM=
X-Received: by 2002:a05:6000:1a87:b0:425:742e:7823 with SMTP id ffacd0b85a97d-42666ac432bmr14939924f8f.12.1760427134877;
        Tue, 14 Oct 2025 00:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi0EuQ//2MOCgb87kcf43mwyCqeAgLwogfvvpgOqhiAT4wu5KaE/+LX7onRuci9KVtSJ0glQ==
X-Received: by 2002:a05:6000:1a87:b0:425:742e:7823 with SMTP id ffacd0b85a97d-42666ac432bmr14939897f8f.12.1760427134470;
        Tue, 14 Oct 2025 00:32:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm717892f8f.0.2025.10.14.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:32:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/panic: Fix drawing the logo on a small narrow
 screen
In-Reply-To: <20251009122955.562888-2-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-2-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:32:12 +0200
Message-ID: <87ikgiq6pv.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn,

> If the logo width is bigger than the framebuffer width, and the
> height is big enough to hold the logo and the message, it will draw
> at x coordinate that are higher than the width, and ends up in a
> corrupted image.
>
> Fixes: 4b570ac2eb54 ("drm/rect: Add drm_rect_overlap()")
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


