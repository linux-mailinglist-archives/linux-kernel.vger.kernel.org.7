Return-Path: <linux-kernel+bounces-733317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18945B07320
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1628D7AD21B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53D2F4309;
	Wed, 16 Jul 2025 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU4cvV9D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7F2F363D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661027; cv=none; b=d3PloJpmyMNOmzHMIHrTJ9embg4uO9G4ih0RPtpvTd244nO2nloj+aDNNpzvjh+CUhpfZe8pLyCDuvVvBCG2f2MvS2feU/XRwp7e6PqMTWGzPzSdjgRsR/g6zj+Bq1RJ10wzGy9TPwJNTF87Dk50t4AmyLbKJlNkMNBi3BGnfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661027; c=relaxed/simple;
	bh=96AIiKafW5Ss/eN27DKKDqLBLqFsLnsuhXOTJ2lFR0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NiFLZTCZLyI0bYvRmNB7SxrYTVukM/pzJZ4vIlEYs8MLu7rE/Kz2ZEOkZaNUSm1bXfj6IKjJwhEZ/5Oewyawev+zkSsaRl5j2zLLE6e4dE4rCkYmQlFnEfNpmLejtTWmb1Swx9Et6cq8t0nE2AENbWJKLELqZuFm6pQWolq+xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MU4cvV9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752661024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSG5PjOM1vuacWsSNMsK+egpHtJUvGDNlOP+EjzmQwI=;
	b=MU4cvV9Dk2MEGUpMdXDZpbuV1F49/ux9pxse24Sa40Sw2PhlFXFjIV3hWFg2DtaO/Zc3NG
	pz0meuuLpLwW6ZjLEdjArB2KNqjnSZVWCDJZxaPysc9rEG07nN7tWmB2Qeu2/8aprt5eIU
	bWKCOjSnB9UGEdg9ZWMb3ipyOnQ76EU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jJPRHZXWNNmPYfKs_-Bh7g-1; Wed, 16 Jul 2025 06:17:03 -0400
X-MC-Unique: jJPRHZXWNNmPYfKs_-Bh7g-1
X-Mimecast-MFC-AGG-ID: jJPRHZXWNNmPYfKs_-Bh7g_1752661022
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso16894105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661021; x=1753265821;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSG5PjOM1vuacWsSNMsK+egpHtJUvGDNlOP+EjzmQwI=;
        b=APYD/cqYhOAcPW2jNMPlnOUYwEzd5IlhnFYNjFO57wiPc9RViVjos7rbDfTLR2lTcu
         VD44zbcd4duK4YaLBwDBTkKdhcm7pUq43Diwpj1lJ/6kYDMSibcA+To+SxzITPrhX0iQ
         xe99umaAr8P4NslZn5T0rfM09mLYM0j8uXhHiFD9fD8Ny96WT9Ptq9lVhmqE0XPiDFZ6
         wTOJBOYTQDdSLqfyMlG0OgI0kBxGZ6D8l8WTYizLg0PvyQrKIq8EDF5ujHISS986J+Ln
         uN7f7LNe6kV7fTBd5kO9/SRPuCEMFAI1TFbvPMmx8ZLdb5Gt1Xzpk9wc3TmI5vUvhDlv
         Tcfg==
X-Gm-Message-State: AOJu0YwFUBueWLR5BzlTDZWi3yKY19o5NHkcZplyXJOzcTE7k0UXApt6
	pS+hESENVSHaeKl1khE4qUss82hW1cJE32s8WyDeAyEXNFwyn8K4zocLk7A5JEagqerPEoT/dHR
	SSS4soK+cm75irSl578pjpqAYJCyqIDwUgF0YdMWPQ2WpVEcbFM+OrLU2ePF4gTodpWLOEZbY5C
	BvnHaj1lzMCmOGKzhGfWpfLeJqOjnx5AKvcr219d2hPRJ7wx1r0D+2
X-Gm-Gg: ASbGncuYnuuUXGe3yal3aJp6vIUX9DEF0HSy/locBdWHTGTtEaV0dyj7HqD6Xe9ZyY3
	jZUuXNmpqXuxFVFUvxXHP5xJrDBouNNvBM6Zet2kN2H3LRZl6o6YWw1nT/kqCwRyMuLFcGQXoDK
	DQyugZib0kF0qqwevAaxdK8BKrfMQgfhWrBTn9baejCvpUh4VYnMc3fr5XKQptXHgBrnBcAq8/3
	oRlMkzwapetlIImzXlnsEJDzhLjPmLYbA8w+vXFTrOIyIfIE4Mcx2bja7jD2UJ1cQ1+oDeXaMUy
	BKCCacv78YQPfYu3wLkrGADu1bkSvQnx4kfbEZADqvjPPcCyM5ks1vXFf4yNPCwIkQ==
X-Received: by 2002:a05:600c:3b29:b0:456:2ac6:cca4 with SMTP id 5b1f17b1804b1-4562e34bad0mr20159315e9.13.1752661021279;
        Wed, 16 Jul 2025 03:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXeNswO26008TyCVbd1BrUc5pJw0QJ11lHj1/vBSnGgP+du3DSrXSLyMDTcfCk1ml8cEQtJA==
X-Received: by 2002:a05:600c:3b29:b0:456:2ac6:cca4 with SMTP id 5b1f17b1804b1-4562e34bad0mr20158905e9.13.1752661020728;
        Wed, 16 Jul 2025 03:17:00 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e82cf22sm16587455e9.26.2025.07.16.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:16:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com, Conor Dooley <conor+dt@kernel.org>, David Airlie
 <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Maxime Ripard <mripard@kernel.org>, Rob
 Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/5] drm/sitronix/st7571-i2c: Add support for the
 ST7567 Controller
In-Reply-To: <20250715110411.448343-1-javierm@redhat.com>
References: <20250715110411.448343-1-javierm@redhat.com>
Date: Wed, 16 Jul 2025 12:16:58 +0200
Message-ID: <87y0sobftx.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> This patch-series adds support for the Sitronix ST7567 Controller, which is a
> monochrome Dot Matrix LCD Controller that has SPI, I2C and parallel interfaces.
>
> The st7571-i2c driver only has support for I2C so displays using other transport
> interfaces are currently not supported.
>
> The DRM_FORMAT_R1 pixel format and data commands are the same than what is used
> by the ST7571 controller, so only is needed a different callback that implements
> the expected initialization sequence for the ST7567 chip and a different callback
> to parse the sub-set of DT properties needed by the ST7567.
>
> Patches #1 and #2 are some trivial cleanups for the driver.
>
> Patch #3 is a preparatory change that adds the level of indirection for the DT
> parsing logic.
>
> Patch #4 adds a Device Tree binding schema for the ST7567 Controller.
>
> Patch #5 finally extends the st7571-i2c driver to also support the ST7567 device.
>
> Changes in v3:
> - Fix reset typo in commit message (Marcus Folkesson).
> - Explicitly set ST7571_SET_REVERSE(0) instead of relying on defaults.
>
> Changes in v2:
> - Use a different parse DT function (Thomas Zimmermann).
>
> Javier Martinez Canillas (5):
>   drm/sitronix/st7571-i2c: Fix encoder callbacks function names
>   drm/sitronix/st7571-i2c: Log probe deferral cause for GPIO get failure
>   drm/sitronix/st7571-i2c: Add an indirection level to parse DT
>   dt-bindings: display: Add Sitronix ST7567 LCD Controller
>   drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


