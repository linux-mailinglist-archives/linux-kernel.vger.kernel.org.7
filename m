Return-Path: <linux-kernel+bounces-880338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1554C258E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAA7463285
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF02472BB;
	Fri, 31 Oct 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="a3wdAVyV"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006492586C9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920296; cv=none; b=QpFt1Fp/sqFcqS47Wv97TAPgF8p/xDFWNmy9o7EF8jZwu2mbDNpalYYJWejd39/sv+LxJy7m7dMP03tT5KZQSaONDyJnliUjJo14s6OeqXc5SfnuQ+uZg4nW0GHpnEjpAIbucAwEFlNwEHEJrAE8LEp0xUm44hAlaOKzyCeB+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920296; c=relaxed/simple;
	bh=dpOwsW4OaXt3IO+YhE8vGcbgUYzLvgd4DmQgy491Rb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLvNkjLHAOniuQmjy0uBAs6THw5JLONBPOW3P4cm70cmCTzhUweJtwkQJSFzZTe1yge0v5C8vLHXI1u2QosDDlvytHVgh5/DJaF3qdb7n55mf708Fh5OHu7E9EKvpSbahEx+GcPb4kgxcyize1ma6oRipBOsHwRYeKi1ykT4AG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=a3wdAVyV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b403bb7843eso500291066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1761920291; x=1762525091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpOwsW4OaXt3IO+YhE8vGcbgUYzLvgd4DmQgy491Rb8=;
        b=a3wdAVyVhYOZQCayteUSx3Cvnp4Mlnf5Uqq0J3oJVuDYuJEcUpXxVYzFKA4jk1oymT
         NgNiyinG/zS7Of5FEBPHSEY3ZSWP74vvLi58wvP9eqKCJF1bZtvkRynbzvc44QJHdI2A
         Ttr1kisFTJsWj/RmlgzE2GrnzATrsUsJ5ZCPgG+tuiVWnuDY0JmdMJZDn3PFK10+iTTZ
         Pa8IJObZT8KjvAHeU2lVhu5rZ/O3QAwg8PDwAwm8gB++eAMpL6QBSSM2PNIOHePXuOzx
         RKwu/dRLEPKBP7GRBWJlghaewN2jt1w+II0oT3JIqSM+liuUpMBYbi6dYg5Uw8tmZlfW
         XsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920291; x=1762525091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpOwsW4OaXt3IO+YhE8vGcbgUYzLvgd4DmQgy491Rb8=;
        b=Cqv/FffGeRTjCk1WuXBz7ftEGJguVVcuIvTlbQiQhP9JCE77c/ZCy7e6FpDYvZmexM
         0gZwh+IViGdhexKhU+3HgllmzLyMncQdE88pKamBkfMb7QavXBxR4zvLUd+XVubqL6PK
         bJxMSOd4rhsmjUj68TZt7a794b85kzKXcSUsojhTVKpVLZr0FE8X16XvllPHOLH5kKxO
         2NWb/yLcTamjYOoyQgbpBhTE9Tj3E8nc6t6KBwSabxhUTqHmtSVO9nTW98R1a6jIet1V
         +VyYuvoTnmoIwYDpnAU25kfm4dc2Wtf7fleRyU4fr04hNGbNyFo9YZNvHBUK0pXTfyfG
         Fjgw==
X-Gm-Message-State: AOJu0YzmEAUzsqcJNhqYGbEZxlH+I5sNjd6SiT9w+gK6rnhje4M3W7Ap
	8Kah+fwhO/fQZD/S4AGaRCbTrogLYSS7WrYdzWnfEsEK2NrLyzjPEGp27asHJ98g/24=
X-Gm-Gg: ASbGncsXi87KMgErPb4hemoshZke/WQ1cJDQYNtzO+7YEK6qhHuk+Jf9YumeeGlp1NW
	45s3akJscPRioJ6bTw3U1QomsL3JW5YUXS7ZU05LPwF0457COxgz4gKviOhQTarcVhbfrZCqc4j
	nO3DTCl871KPriOnxEUZh0ai+/ZfhdEy3p5PRcG12eoHPrNRMZkkm+MbrMsD7hfCkYO87xZqDyS
	3yWaQB5dlV2al+W4/xgJXC2c61dB1V6hZk9K+Vge5kJQhyZeZAPrW2rKqEGNzXK5EjIEmuHOg7Y
	cMJh/ZFp8vxjAVi9mYCyvOIYLCqELP5c1YLrVBdhsNJogaGj7FoAeGLrmFCG+IcHKoplNNWYcgT
	nwMlAZ1cDQ5rW3TsTJmpvAf/LBTaCTwgy64F9ft5YBts2NEt7yvfNPWUPFYrGw6LOQvv+EjeYtI
	9clmoqKfiwlo7d0cnzcBKXjouLOQBltqoff9hDbDp7jY6qG+X85vk0
X-Google-Smtp-Source: AGHT+IG/on2h4t3AE4tA/aWcwth5JN9h8ZraeYNLOQDKECZbI1ZJ38z/033kuQ3rG2khwd8SssYwHQ==
X-Received: by 2002:a17:907:1c93:b0:b04:9ad9:5b29 with SMTP id a640c23a62f3a-b707082f754mr437109266b.54.1761920290566;
        Fri, 31 Oct 2025 07:18:10 -0700 (PDT)
Received: from caroline (2a01cb0405e83a000cb38cfe29807c1e.ipv6.abo.wanadoo.fr. [2a01:cb04:5e8:3a00:cb3:8cfe:2980:7c1e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a92c9sm185644766b.22.2025.10.31.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:18:10 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:18:08 +0100
From: Mary Guillemard <mary@mary.zone>
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v4 0/5] drm/nouveau: Enable variable page sizes and
 compression
Message-ID: <aQTFIN1dPHVtL4NR@caroline>
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>


Series is working fine on older versions of NVK and with compression
patches on mesa side (tested on Ada and Ampere):

Tested-by: Mary Guillemard <mary@mary.zone>

Regards,
Mary

