Return-Path: <linux-kernel+bounces-729874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B62B03CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF1F3A6BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091E8242D99;
	Mon, 14 Jul 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXHzv3po"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341A1A38F9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490598; cv=none; b=JOQ4X5nRlGLThAh3T59a7qavMWn6dxB1splV77QHj1madVaqiOCME/cj0wvvxPszlRmflLmGv/np39d63QydU2wtYPHbcSCMQ9+4OxbUCWN41yRXisgSNPmZXyZq3KB8B49eNxs7mbyUCCDVQdFlVWINeTUtSMM/MFAGTSWou7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490598; c=relaxed/simple;
	bh=3vxP1XTJlgVCgsYCM8sOVrgQyGOgdDxnyUWh1e/KDlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sc1JZogxVvJxwqf6BaRgX8mpYCzSpP2qUw48TLZobSHtqw1tDN8Dg4vBKGYlM2KUm6RyZraYj9j/tvmBh+eaMTUtSd7bI3N3rvfTNidNbT1mgCil08usYdXQ+CEaSXf9WEhKKYVnqyMJ4RWG8d+3LChlLNFO9+grHQp/O5iY3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXHzv3po; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752490595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w93JWie8E8zd/q18qvrOAzbqexxKKPXgPTHOy7odRa8=;
	b=fXHzv3poVllcOikftf1vnzMrMAKFnhu3Xg/rpGJgSN+a+5aOMGo79qlWctmMn1vxzZucJH
	qV3dA02UtklyH55FJY8Mdd8tLlyIKgvpNfEbNY4gJvBx0/FFOAJjic62/kg+bNnzRYsEja
	0yrGbJn7OeXu+nWwWD9DSJMXIQR2ZtM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-mvPBcdYSOK27Y2SDfjiTFg-1; Mon, 14 Jul 2025 06:56:34 -0400
X-MC-Unique: mvPBcdYSOK27Y2SDfjiTFg-1
X-Mimecast-MFC-AGG-ID: mvPBcdYSOK27Y2SDfjiTFg_1752490593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso21348015e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490593; x=1753095393;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w93JWie8E8zd/q18qvrOAzbqexxKKPXgPTHOy7odRa8=;
        b=dWCmyJXVHsXwAY9cGtl6r4S8TErp1xAPJPCZl1Jc8i9ak+evkD2doFVXIlay3WlwIM
         FoaVbQ86B6nmArwWWFYanEzHJR1kQuhWlwmk8yni274AE1TZ7X2/E+2Pc9y5ioB2vcZU
         RH7LRLBhm86++doE0J83h2JcPJFmIQPi5r25aaectTZW9aUFYQ8auRGrt4/g12eL50AI
         uWoiJL+5PZ7MmTvq9dyXuKt2H9EHApXPUUzDy6sXLQjUrz6EsDmRhlPKN7W/AWm6/w38
         GmkjHO5R0+9+4xRSqFM+DWTdTCYxTvsrROYkS6H47stjmwaJFy0f9ydAOIIAVGp22TkB
         u5tA==
X-Forwarded-Encrypted: i=1; AJvYcCWK2HFH4jVdtJz8pedfwNA3Oykfm20zezTWlzKfP0YvzU0EwzWVbBsv8elACZR/E71wMPtJ/BTPiTDpCsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5AwdYzf3/chDHVp7r3U/+Uh7klsyM4Oy+f/Q/kqoswerQwvk
	y0fkt/MBP2xNUfNNHF9wSX48toVil/usY3beblSx/PuICv1eJ1a3bAppimQR1zXZqHAvw5K4EgG
	6SDIZBXNfCOh5b7KUoKH7xhmcB81zOc4CH8Fx7QJ0ehleVM2Wgoa1deL8fnuM+w/jQQ==
X-Gm-Gg: ASbGncvDJL+2c8ORIu0o3h9CMjd0EF/srDFsnD+iWlRABd98xbR+63xKpFnPJq2ekBZ
	+L4QzepHidUJcrXSKSOE8Jhl5uwr6Rt6uY0wer5aWWSTWHri4ae88G3CkXAnlB4CaAVTFs10Tk3
	/clqSCeMR95eHeTuvjsFHvYbLUCgmAwxYOHLZyPrj0D6Ug4FTGwjPc5NLVHDfI0pzAF7Xpvj9kH
	TphRR5lNBlkg3kOVixKbhL1Yjsg4ObNPvEzaah1vcFJEo5CLzCHuiJRr4fZgBZ6nqVtul3vPotw
	iD+Wa7Bl3U1rODwKQ0Nm4F35gkTjZkFVFJ7kLYuQ5UEWQeeBYdAsBdBMuGq1KZ3ITA==
X-Received: by 2002:a05:600c:5304:b0:456:1bae:5478 with SMTP id 5b1f17b1804b1-4561bae5841mr27165455e9.2.1752490593144;
        Mon, 14 Jul 2025 03:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgLMus7ZlRljQsgOm8qpcp0STSbB4fi2uK0BYeNsg/g/S+kVymwynI6QO65qw6qJtfq5k01w==
X-Received: by 2002:a05:600c:5304:b0:456:1bae:5478 with SMTP id 5b1f17b1804b1-4561bae5841mr27165155e9.2.1752490592705;
        Mon, 14 Jul 2025 03:56:32 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45617dc1fccsm38119995e9.5.2025.07.14.03.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:56:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 5/5] drm/st7571-i2c: add support for 2bit grayscale for
 XRGB8888
In-Reply-To: <20250714-st7571-format-v1-5-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-5-a27e5112baff@gmail.com>
Date: Mon, 14 Jul 2025 12:56:30 +0200
Message-ID: <87h5zfkplt.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> Add support for 2bit grayscale and use it for XRGB8888 when grayscale is
> supported.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


