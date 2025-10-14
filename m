Return-Path: <linux-kernel+bounces-852017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EDBD7F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F41425E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020812E6CB3;
	Tue, 14 Oct 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMdIXGjq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F6242925
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427298; cv=none; b=om8T2zWJMmYkE5GjHQf305/5pwLcYcUa2QIGebGCgJwSssGdax+iTHJ8taTGRa7bQi/e8AsyVakWnfxl48ZjeJC693lB2RyOKGJCW9UpV2lMILxZYIAhkneDagaGA+rv16exCMf1DLySeJM2DNsI0okrXJueByp44tSj86/YFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427298; c=relaxed/simple;
	bh=insi5QuAvcDo4ELXBPMiD7HNYLAxnQ0SSVuXp/JizwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsnV5KCYahj5cUx9ZC8HUG4sCSY4FydWZg3IgYWhqEf2vEgHmtDJYqavWcGYiEppnIcW2MBMPiwRuoH4FF4R/8fUWRi/VTXrNDUUM3bNIPyWE/O5pYYriCfe8EGBfzI+3GhPxd9TiPts7IfkSO5dZCdTsVxlLizWzolmLtKOsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMdIXGjq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZAYJ7xq6WZ4FioBhdfbaQnlgRPAlKAdI8jcSI5iXTs=;
	b=iMdIXGjqdcdMDoRIKCjXv4W8pnoSXZYu+OiqyLVQdbWgVIr8SIaM1OLTk1g/vZKLjsAOYm
	JKaYFOVRx6eakAIoBQn9k7I1XEmSymfiXszJnStjMSTzWnAOSwadZQfb4nOOzODIGRQfFa
	ztu5jaU/mrt/dYAjWbWjsSA7hHuVihA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-NDxBSe6LPtWND7budzYVHw-1; Tue, 14 Oct 2025 03:34:53 -0400
X-MC-Unique: NDxBSe6LPtWND7budzYVHw-1
X-Mimecast-MFC-AGG-ID: NDxBSe6LPtWND7budzYVHw_1760427292
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4256fae4b46so3511085f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427292; x=1761032092;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZAYJ7xq6WZ4FioBhdfbaQnlgRPAlKAdI8jcSI5iXTs=;
        b=ZYFsNAECTuxdyHrXNiq42aRF3LPbcqMa2a3qg7VxpzKeXRNQnw8oX1daFioxB4aAG+
         6AehgcpCQLGaFkN/gQStRTiLASiNQ1BppUyCQxHzuTjVoYsyhrS/7A5vRy1ZdBI4iO7k
         kDKBKKEtvA1QkHtATnm3PrtNBF5VPeDshhEK88ymA8Ylj5eTCFYrmWAHlBCHuPFXVndL
         DgdJ/ghuitbYJj4c+1HfkWzWsua6GrUhf4HaIJ9wsrmj3rnvl29pP6OhOuvVXDUBZjVU
         yv3xvwGYSvchadykAimTRcAYNL+kONinA7PtZqYFNPhvg8IacJmL3oPlg+fL+njb0U3m
         hNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWu7Eg3cKd1uVzCw3LDj8bVtlUMWLmXlqYS3rV9F6QeJ+Ztkioj2HzqBSPjV/kwylLp8Fy2ZhM4gyikA/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzshda+eoiNjZKiRdn57LMxembUHvFqVQve6oKcDvdJn55mNLB/
	uYyNKzbgSki7ew1S8ww0w3Yfu86Ws+oDFSSL46ReanFJoMOJZAgEqaiOgJp7qNM9FcbqqETQm59
	ih3oF40BkXzxDmlzaAe9H4F+Q4oapkv8cDdZo0/6decJAQanhtNrfEvAyjjwG28ARxw==
X-Gm-Gg: ASbGncsF3iksZ6ILvarwcjOFdY8cvwwcJGGlKZrn6+EtKP82wA9t0EQMPQQus2ciHZ9
	XGweiZCT3RHp1MTdsBOwjSMxtRgrI+XzYvH238I4KGIxq8eZsQsp7Ia4CnfZ3UdOfm/zdIiK03G
	1QP70H6V7J6nu3ypQYUH4Jvg+dM3nC5ePhkQu6eqe1ke7surgwXLiSyIcoKIH8iP/S6oL0sc1EB
	EeSKTSITZfz3HM/xemOQNnppVJz1k48ttBR0YufF7l8cF2ZIa3QVRgOSTA3pjZCjqC4x1Tgkz2i
	PaTm0nK0nAb5CdyVYRGLjruI5txcvPoqb1+0QH4RGHQvcp8IQ5WNfGtRZwr7EvZmYACN/t5xEdD
	+Eu1uanFPtLg0PFzKpm5FJUI=
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr16860032f8f.44.1760427292313;
        Tue, 14 Oct 2025 00:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxNwSeqZAx1bogXJDeVtjJdr6RSvW9zsie6Xf2fYECED9RUObVAre57ulfyG8aTO0EyMtU8g==
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr16860020f8f.44.1760427291948;
        Tue, 14 Oct 2025 00:34:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm22720436f8f.33.2025.10.14.00.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:34:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 3/6] drm/panic: Fix qr_code, ensure vmargin is positive
In-Reply-To: <20251009122955.562888-4-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-4-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:34:50 +0200
Message-ID: <87cy6qq6lh.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> Depending on qr_code size and screen size, the vertical margin can
> be negative, that means there is not enough room to draw the qr_code.
>
> So abort early, to avoid a segfault by trying to draw at negative
> coordinates.
>
> Fixes: cb5164ac43d0f ("drm/panic: Add a QR code panic screen")
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


