Return-Path: <linux-kernel+bounces-779515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE445B2F523
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87985683CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCED24290D;
	Thu, 21 Aug 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XC1A40Hz"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A718C933
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771442; cv=none; b=et4vX1KoNaV6xCfNEZPSMcOGa/KXeYpdK7ijCTq7/sXqJCHNKHAp0Pb7vKvBeVlJVq/FEwQp22fV55Ct1ofVST8lUNiViRrrwyk9iGHsK+nRz/QmC4vN3qd3O7GnC1lH5KGCDlsAcnhr5ygIgMBcgFQsOz4HhP4JV4GGAHSeqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771442; c=relaxed/simple;
	bh=AyqpFYzuCEobymTAaoWYv2eXRHk+3jlDnkuqrQwJMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6SGyK5wWTMy/kkd3P5vLxqRGbxQpdqwDMpTjaczz7taSnykk+xmJxLdRz80sIZcAIxxCmHDcNjcBZjOyzJBJhB4fEL5KB7YLVY2c0YuzC3Ugx9eDSljZz/M7aQh7E1z+yT+RF4734uk35R9zyvK6956YqVN+96JOr+b7/ws9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XC1A40Hz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a16441so120601766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755771438; x=1756376238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMBGNe53qB7K6/QwgxbSOAqilozoH1T7Ksw/7As9UoA=;
        b=XC1A40Hz3WvrY/OjKhcdZQj6P2wG+JSxVFK7wMUwLEDpWGrJ8BudhopoV9MKWD+kYo
         JShub9UKeP0LzQSMgrdrbxFUCm+XvF9axtKOf8Y8rHBHOajiGGWFdr9eTDxC46+Jdci6
         PHd4s3Ow0civ36C4X2XVVvu6dHPL2tquYC8y1jHd1NZC6fAqn1PpyHJEZV1ari/qVjXp
         Mo7D0bViJs6ew5+NdIP3Yz1uI/8MRxa6IUA2HxvSb65Ocfub5eg6XiPcKA6FOGyymCnE
         sNnBG5Bv6LC/gxPu5A2GcPwMuyAAtE97oYRqMHGoHS4ZP2P1dMiO+Xegh/2wlmbZTRo2
         A+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755771438; x=1756376238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMBGNe53qB7K6/QwgxbSOAqilozoH1T7Ksw/7As9UoA=;
        b=evymf1rfY8r8s+WHW0ENzMvNpcO7bDkRHQdQdvPqhTZgafHMXTEXTLN5LkjpSTuq+5
         PzqR/dIVu2GBNo5lC+ghuOEjK83wfRytKj+gc1jfgPUKz7Dd1B6rCq8X95AUrlfwzFNb
         YDspQFAMQoo86FG1REH2SFsgwKtZRgrvMaJzuF3KtbSnGKnDq23vo3Xho6CK33PiGPI5
         VSK475p5dccTk0rGna0uys/Qm1Xa6QOhouHc+S7vIH4Y8wA9qk0ZEWSz3Rw3Z6oCFEWE
         3WEam3QtwAKE92vFxDcJZNva00yV/yTyB1q6NsN/P/Eopl/34SyDM/7ePoY1g6NjiMTN
         ySQA==
X-Forwarded-Encrypted: i=1; AJvYcCVYWrDLVAVT9hYGo9vPP5SJy/seBa9RvEk4MEODi84jXgAlRV4+XZ15Fqj4nBe3KNqxMs/65dHi/GyDaf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdcOOXIsEjkFuGO6Ebnrcs+ktCrQ//n5G55XWcUKEnlhlnsM5
	k1yXm2HMPoNTVsBmdN9Df/gmyccdTU7bTqOZojUSBn/XVCPSLMdwLIsfbbYc2eNFWOw=
X-Gm-Gg: ASbGnctV1JkEzSx6ZC8jg9TEiCbTzpDOxohn+/8oq083sg/AuXRU9EKnxLn1QGHWmce
	/wU+xXXCPJIW0Oh3GWsF/QTnJQ4LlJnFqQCtSuaNZDE6C1HbY/Q/BLDdxnXyQKVvFyIzObqlvaf
	nuYGi4zwZjh8dYFCJXAa2fsMOJOvHolyR+YcgDZzKdCsFOKtQAKbJF5AoXHr/MezRjTz84DCGsY
	FGB1OgktjOTtqFtTqYWm57zpMvKuP15fjhgWLJxjbYGSCpyRjCEjsFVGxK87aLsvYqLRyQqGEaz
	kyDTzK9SFHOCKfS6xN/oWQqnxehNZzhQHaAxzw7M3FesdbI21aJsLblGhAavQyWceDj9UTO/dqC
	A2IoktltCW74yMkspKG4=
X-Google-Smtp-Source: AGHT+IET3W48/CcMp7L9uxYnuFSk+zvgVDhOyGcxMX+XKGh2yPWJrKGqYHuBVwmEJF9Hx7vOlkfIsQ==
X-Received: by 2002:a17:907:1b2a:b0:aec:65de:5258 with SMTP id a640c23a62f3a-afe0787cff0mr200345366b.3.1755771438079;
        Thu, 21 Aug 2025 03:17:18 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded52ea4asm357672766b.101.2025.08.21.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:17:17 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:17:15 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Val Packett <val@packett.cool>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>, ankit.k.nautiyal@intel.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/dp: drm_edp_backlight_set_level: do not always send
 3-byte commands
Message-ID: <aKbyKwf5XyUbVwdw@linaro.org>
References: <20250706204446.8918-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706204446.8918-1-val@packett.cool>

On 25-07-06 17:42:24, Val Packett wrote:
> At least some panels using the LSB register are not happy with the
> unconditional increase of the command buffer to 3 bytes.
> 
> With the BOE NE14QDM in my Dell Latitude 7455, the recent patches for
> luminance based brightness have introduced a regression: the brightness
> range stopped being contiguous and became nonsensical (it probably was
> interpreting the last 2 bytes of the buffer and not the first 2).
> 
> Change from using a fixed sizeof() to a length variable that's only
> set to 3 when luminance is used. Let's leave the default as 2 even for
> the single-byte version, since that's how it worked before.
> 
> Fixes: f2db78e37fe7 ("drm/dp: Modify drm_edp_backlight_set_level")
> Signed-off-by: Val Packett <val@packett.cool>

Tested on Dell XPS 13 9345 which has LGD 134WT1 panel.
Without this, the panel doesn't come up at all on boot.

Tested-by: Abel Vesa <abel.vesa@linaro.org>


