Return-Path: <linux-kernel+bounces-852511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05609BD9288
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC870401685
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A33101B6;
	Tue, 14 Oct 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEbj4jW/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82313D539
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443043; cv=none; b=QaTA2rmV7TpACRlRgf7eW0Za8/Yr/JJ83imM9ApeUuoUevDrlE3t33voER51r6CAwHjnlTUdfO2L4Ys9DkA1WzwMN/fdd52Xcu7hgKwWbVcozvLVke0r8DglwpObXAD6dKJag7v2uWy9t5HFF7E1jgLaRpPo9r3fO0ULznSiltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443043; c=relaxed/simple;
	bh=EV8pPfY7I9OwtXfkZbUk6UzFe2y0S56qrkmnV0+G6Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY1drS/2zRLOzQaSnQdXGE7czbpjUSW1IGIwAkFD86GIKXtN8TIFKYGaMBrxWbuxfrijUsY64axljPWIjcCd/rMjk6qc1lwwe+pXGCUvKgQawz9Qse/hks3QOCW7Nb9POzbpaY+8MssOtcABsuE5cbdWjzPt5Kw//fpzpHnJAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEbj4jW/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b4736e043f9so825766466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443040; x=1761047840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfYNvCCPGe7L50oTKoEL1dXfDHFFc9ojZJtuVOHJgeU=;
        b=VEbj4jW/CzR1ho4BYjciNzGUYZj5XPrh3CQdDnskRbZfBiB4wRJ1hQHZAvu6sfCOnL
         JxyqpfMXBEvBWnaj6F/BN0zD/lkTfm653CDkUkxQ21uVGgfxNKRk1zRE0AKYwxKvgFP0
         QjtS2NqhP0RC+S8PP0K7AszBzGiq5JBtr+xmUFacW3nYsVazcnZ8qLHNu23sC2wzgX1J
         kLu14H25+ueVIA3WdlZiuTrt4oLWoIJNHozLhYYbnHhC2K9SiwvJF8rZp1pQ54k38WcG
         wEEkfpaPQ3M5e5lFauCVPLZzRWfWCdl70VJkAofgW6F8mBxq4T6ugCaVAUErc+7R/ZxY
         s/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443040; x=1761047840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfYNvCCPGe7L50oTKoEL1dXfDHFFc9ojZJtuVOHJgeU=;
        b=Uy+mx6x6+7rfhRgPDzI4qvYWBx3XCgiMVS9N4FCGGCJdfDUu8n6WoSgS/zhE2j7Ijr
         6PTfQeaBNnwbpm0uV7YrvpRchGI/pUzmc6opzcbXzGjzJcNKu3C2aBYjhvGX+ij9oc37
         57NK3pbmai8WmW4AhmE/vVbjr4HOPMMT8A0+CgIIroli7jIs0RYOpMKnzy6aOVFFuVCx
         Yv4UTqVSHglC14V5bsajtF7pkM5mg5nahYGHV6c/ghOv/h3zLvNPa99mGo/kjBo/LgMB
         yDZI0TownMTfSSW2aZO2dQPKjsVcdnt6UI9oPnh+L/0ictKsV1B7/ktBKQVoVA0piDSu
         o8zA==
X-Forwarded-Encrypted: i=1; AJvYcCUH4cJTS8MzSIpE48bZqVTxXW0PhRXZW1Jm5Tgon3HVU7inALqFqL68dhw/nqKPgb0609l0RczQSCRd9Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfeN+c8FGtl5tRmwsBQbxwFEJOvSc8+o4Sz8/g/Z2fcefciKy
	vCKZlt/BaSvGK46Ju70Kw3K1vp9AOJIdhki04w2BAdgAcJaLw33DLuZn
X-Gm-Gg: ASbGncsaDzl30EQIcF5739Wai2i+ZjDB8y8kLm9mFtnUyh446Cvml1su13FI9T1AZ3r
	iStbEHesB+kvZ8o8BCOaVBejDAmA75v7GXKIXgeYz6wo2m3xnsqtmPe+1tBkZVVFl34sj6Se/AH
	62lV5mn+oH94XWUpdwDzOyNBMpx3R5/TN3H8mqfsPkgBy/ec9+9Yy70Lx2bjCdCGycsWKGalMDI
	gBkrRnRbwzYTtn4Mz36miZerxS13xxSK4QnofLO4MldLfO95iFT8nHnt9MQvOmaIr85yz8JC+qa
	xxFmm1IBVraFDxPki1luzmJyRrMseQDW1X2POzH8pncQGMPtIdiNGuq4tiAfi111LdC85v6B951
	FLGTkAgHBwpg9R4FF5RpF+sIsyrMWmbk3Bc/6jiTJdS+C02fHLfcI+LFf1sBqxJS9Eh4VD04gzZ
	BCEiwLCr5zRikgWVB/GzT5xx26deIfHozvmjzEOaD/ZdUyjkD7vD8=
X-Google-Smtp-Source: AGHT+IEO5ExkdB+Vc/eA9hYbJB2YUbFHvlBREw3jtxdBP+T0I/Kox+2SWgXKekZXvheyf/FHTlBwdw==
X-Received: by 2002:a17:906:c104:b0:b04:9ad9:5b29 with SMTP id a640c23a62f3a-b50ac5d1e3bmr2852743666b.54.1760443039715;
        Tue, 14 Oct 2025 04:57:19 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm1152162066b.41.2025.10.14.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:57:19 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:57:18 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/imx: parallel-display: convert to
 devm_drm_bridge_alloc() API
Message-ID: <hr4htgladsaixbuhz6un45syyynzxl6qpshsss3cbeww6mnj7y@jbqwfnzbufqs>
References: <20251014-drm-bridge-alloc-imx-ipuv3-v1-0-a1bb1dcbff50@bootlin.com>
 <20251014-drm-bridge-alloc-imx-ipuv3-v1-1-a1bb1dcbff50@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-drm-bridge-alloc-imx-ipuv3-v1-1-a1bb1dcbff50@bootlin.com>

On Tue, Oct 14, 2025 at 01:30:51PM +0200, Luca Ceresoli wrote:
> This is the new API for allocating DRM bridges.
> 
> This conversion was missed during the initial conversion of all bridges to
> the new API. Thus all kernels with commit 94d50c1a2ca3 ("drm/bridge:
> get/put the bridge reference in drm_bridge_attach/detach()") and using this
> driver now warn due to drm_bridge_attach() incrementing the refcount, which
> is not initialized without using devm_drm_bridge_alloc() for allocation.
> 
> To make the conversion simple and straightforward without messing up with
> the drmm_simple_encoder_alloc(), move the struct drm_bridge from struct
> imx_parallel_display_encoder to struct imx_parallel_display.
> 
> Also remove the 'struct imx_parallel_display *pd' from struct
> imx_parallel_display_encoder, not needed anymore.
> 
> Fixes: 94d50c1a2ca3 ("drm/bridge: get/put the bridge reference in drm_bridge_attach/detach()")
> Reported-by: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
> Closes: https://lore.kernel.org/all/hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r223ar3txri@3ik53xw5idyh/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Applying fixed all the WARNING regressions I saw before, thanks!

Tested-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Kind regards,
Ernest

