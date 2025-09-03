Return-Path: <linux-kernel+bounces-798089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79456B41957
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24067B1DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A82ED86F;
	Wed,  3 Sep 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuL7ZXrT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D702ED860
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889752; cv=none; b=dwLeqy9inVdSxy2W3P4Dk3bkslZ6FykNhi0kv96FgvsuW1CATH/nPnCKvt0XYzPR8qd2+75+hRwClAL/+H6LdDhtqHQ+Q3Ku2MCNzD+YvJXv3fGe4Yqpx/uF1cpgHBVWmu7OUiWZxXBw5GoYUSw8uZ+tPf7LAXsq/oqI9zIGPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889752; c=relaxed/simple;
	bh=GYN9iaw7rAier/pATCqUnEp3Xj8mNzeugHEcM8SbDPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk5WXdQsUd3viUJ0HYa85l9uV22MRsozKr1r9PoOD4LTCZyyhp4GKGGvugrTwFje+7QdbFZ9y1jRO0vba584BCCQgiiG5VdVkH4eJoPLN3tPCZjL4ZTgSP6Shfz2MV1FlCV6VCqOOb933q9ZXnGc1YDVzAMHlMnw1aXWUNE9GB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CuL7ZXrT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so3027235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756889749; x=1757494549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cV4mqPmxW1tPyF9dbost7ZwM2Dt79PTTYDkgTZFQBo=;
        b=CuL7ZXrTmUjw1fvqBh2MDozJxPqXGHzfp42WV0RZO25tFjW6Of4f+cmHZp4G9SNDcw
         lzQvQWzpjG3WxsaQ3/yBBKhel4crElo1Cuulw5rp2XnPCaYhpTRmW9FVnE6TMNeLHNi5
         jsnr0DVomD/nC7JMLm/4EtJpx+rrL6qn552W/6qaqteNjNczWV4QKftJz6jGNIUOlwGy
         JCfVCOvTl8WAhPWpNOhfVcKAk3gRaYfTGk/yOqimqIaUPg1yjRz3ePcDvltIdfAXk38B
         Xl5QLahdypr3pjj33m+ALNBpNtewEVCx4uhpZZ3+J70HWipFTdvWh3x5y2gdqi5RiGMo
         UwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889749; x=1757494549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cV4mqPmxW1tPyF9dbost7ZwM2Dt79PTTYDkgTZFQBo=;
        b=vC8NC0sE0a5lGNF6iBS2dPVgBRY6XNNz+m/HnKegUqLUEs+zf1BIXI/mgSLzoWYbpT
         grZ2RZ9l+QXGyZbBX/TY5ik+5KElzMcJe5SARxpvEQjqU1xmVgMzBHev7DqViytw0v1B
         DbQZy2SkKZJS/y4sWMbbVC28qsJ2qzR1HYYKv5+lC0tgk8B4+T+SZIscwM0C7ZDMf3CS
         iK5njbSuHBVmtTV3HvciGSk3ExoO1qc1ViiVX2EERCDdWBlqO9u0BSI5dU1sbgApaGYS
         a4vG/Ahzgg4pnkY0XcyN4M4JHft8qEQAM1R+L7Xw7aGBkGoBj+yEMtpNIxcfIC5jzBe2
         adFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD/b75pIrfWL4N4j5KEcWv3XBG4kzb3Pv+u/ALjsCCqi1/0BrofMzvYYl/1obABG9ZDcwuoUP3Ku+wuxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BpKrIMhGfW77aELUcY2ZwCDYB0gRR4m4AReDbvtanIGR0zE7
	3JqohESU3zKSUy15F+BD/FIr2PGJaMCpccx7eJXjvoD7GU+z7JZOZ46GHQkuLsr4++g=
X-Gm-Gg: ASbGncv5x560+klvlxV1WSY+ewi69ghJHscJbjnBzTg0v35nsYJra8lw1kfLmH2W2MZ
	Uo/8NT59ygklM2/DG5EpebiHSnYpv4k8Lyw3Rb1EPspFBtvlyVd5BacZ3DId7TF3FPQxjU3Zkcu
	5icDV8zTpHchKJpVCJX4PcY4jjrqz0a2CUIpzFRr+mzatgnAvo8g+8UAD14Nfx9oM6Km3Udonxl
	tBA/GLPj4YasG96T9oaw/lOIjnVbMNszNSjmDEglVt0raTtMU66Tk7YrGzyj1WzD+YFMzvL+5l5
	/2ygAfUx58jvZFrZc/KQCzHIxCwTVdewZEp1H4kJd3JGL9mf9YPNbG4Gn/XIjH/gJjdRLoyytDe
	HODZr+rBBD6Chsp9xCpbCbE/oVKGx6wXjXMcrWg==
X-Google-Smtp-Source: AGHT+IH/I5haMU97rwsp/23eXdJD7jSFORVKYid/zP+DHP9530edfSTunocGOnjSttPgmZD8RbnDJg==
X-Received: by 2002:a05:600c:1f1a:b0:45b:47e1:ef76 with SMTP id 5b1f17b1804b1-45b8559849bmr123014385e9.37.1756889748976;
        Wed, 03 Sep 2025 01:55:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3decf936324sm1205616f8f.9.2025.09.03.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:55:48 -0700 (PDT)
Date: Wed, 3 Sep 2025 11:55:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Shaoyun Liu <shaoyun.liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/amdgpu: Fix a less than zero check on a
 uint32_t struct field
Message-ID: <aLgCkRO8jkzwuxW5@stanley.mountain>
References: <20250903082018.2702769-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903082018.2702769-1-colin.i.king@gmail.com>

Are you editing your CC list?  The get_maintainer.pl script gives me a
longer list.  The most important thing is that you've left off Shaoyun Liu
from the Fixes tag.  Added.

The kbuild-bot did report this bug on Friday so the AMD folks likely have
a patch kicking around on their end, but just haven't sent it out
publicly yet?
https://lore.kernel.org/all/202508290749.ti6u3cLL-lkp@intel.com/

Anyway, the patch is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

