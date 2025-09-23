Return-Path: <linux-kernel+bounces-828610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ECB94FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919AD188136A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893331D370;
	Tue, 23 Sep 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7+d7geG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884A31D389
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616174; cv=none; b=FHcBf8bNB5EaAKlGynQvIx2emNk6+0yry6XkgLHIKFZj0UlC6iZlXU6LA5dHiSC5G+nS1I1Z1aTBr1y8X+ZuFImbWf1U3ysXmk/fOb8I0/9iZhvN8FCgwz1NA6Kwnp6TPLEtRV4OoBXX89WDYMeDkwto7xqEiede4khcwFwWC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616174; c=relaxed/simple;
	bh=/RR/U7qjyLInx5I/uwXMxNivKnihvdkWrEIVwHz7Eq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuZHG+MephugCvfwJvt0v5XEoSuLW2EY64AiOgfX1NBZP5WcJ5DbESDktPka3D5qWsG6MycnEOg7g8kYUsLrP8ZNUTgFLgcKww4YyoOsAdERXh4r59u0R7uMPtpGd4tyAfeGwGAU29qAlHTn4I50bJAatUwwX8QlxRjDe++bUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7+d7geG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so4960755f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758616170; x=1759220970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4H3efbdSwxqDOTY4ewV+hCqf/E/cTKwJvAAgRINhHQ=;
        b=h7+d7geGA+etF8ZCmsUK8kncfEW8x50fbrsuTIkMKSer3dWlqW8Gtsi8/VCVjeWCC4
         ACSJwmfTri+3wdYU/TI5OEg55qWgcebHH2TDRnLNxGHKa6SRvIzBGoNMUUXKFeSqejD6
         EPWpW9WRCmNxzObmxCE/sCaddntPxjAle8bzBwU3WUM7kiyQ0tng9h16XKedC2iCvNbI
         Yst4xQXS6QTT07RGc75Jx92VDzf+CkvVZo5pL0sp/Cnyt32dfNqCwctgPgNW0Mi+J+4x
         389SQlr887uPSn69Sf7sRxn5Mq5RgGCXEdAMfv4mmqGE9yr8RTP/f1q8UfEKgUOAjr8t
         Drgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616170; x=1759220970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4H3efbdSwxqDOTY4ewV+hCqf/E/cTKwJvAAgRINhHQ=;
        b=QBHMg4fpeUWnhEdO+sSM7e4xexFvfT52PmHfCycET4ncKMHqhsj0os870PBiDtxHFE
         PsEulUcLdzhT2Sube5iPWkIUXDyNSYVJSE1c1/uL2SfIrI2jLWhyPW1tLEtK78HRlLCn
         nWo7odY2vw+1+lavRZRuXhGo967rPFGY7ENjG/eALGC20qhdpA4haPRyRTjhZLP5zV9K
         QayHZ6JMjhhtYZH+D6ij0m5rqqQu/MMCcW3uIlSasFDeHrvg2fWbll+Nm7dzeyGX4/b2
         0DJIk5sL1B6MZr5gAK7lZnedNA/kxNHwN8zoONGvirE6HixAT35tBzLNEfx15d1olQ5X
         J3RA==
X-Forwarded-Encrypted: i=1; AJvYcCXVs7WqS3gEJVwzNhN6oZjMPiAxwARA3h2WF8mkiKQI4yoCM+NhoWagVLZ/aG9K8EjrlchqPlhoTM8u1c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1+NTrwaBStjtUl7SmAE7q9pw1v388uWzGSTkuD6PcD5mSWwG
	k8VEIZsXFFMHOkiR3BSx4AW/NcKzvFBzt/7A3gvuDCXrsaBr6bQNBOXPiCRyO2UkM+M=
X-Gm-Gg: ASbGncsEuQodPyiLvLrw5BnQuF/lKEKTHUAoXKM3f9JMV1foXJpo7IBXgwHP8aURiAe
	itaPfdr60O4yRj3ryJSxcdaGHNiSpmrkASsi/uR6rDQMazJC1CC2JmiTx2vQuJu+tluNJop2n8H
	I3mdyCS02cGuazjZPNmA0EMBhstHTAzhp62LRyCaxcssF2+P5gN1z+bBR6nC9KqS2eGUITy4wIN
	/8MePIzXo5gM5UTTHAU9n+wKLzaY/4zMJrixOb10FV0j5RKmCdp7ahWAtgog7AlXQL+l9WPmOHc
	eacMDK64kmvpGWae4zoHxICRDxBRfrQghcoYjmjwj+eaEVK7X1i5vAtrB5sxHP7snNDAOOe0gd5
	F91t3sxoLakFwOvehFYcU0Z0pKCwyBsatrxCXsg8=
X-Google-Smtp-Source: AGHT+IHsvSUzwkgJMr2fuGf+beelXF7ViUccT9vVETmtAg6567gvGPlf85mOeUM7tJRvmp045Lmkcg==
X-Received: by 2002:a05:6000:310f:b0:400:6e06:e0ae with SMTP id ffacd0b85a97d-405cb5d27d8mr1308843f8f.47.1758616169814;
        Tue, 23 Sep 2025 01:29:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbfedd6sm23425761f8f.60.2025.09.23.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:29:29 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:29:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ruben Wauters <rubenru09@aol.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	lkp@intel.com, oe-kbuild@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gud: fix accidentally deleted IS_ERR() check
Message-ID: <aNJaZldQsfTtOBa5@stanley.mountain>
References: <20250922173836.5608-1-rubenru09.ref@aol.com>
 <20250922173836.5608-1-rubenru09@aol.com>
 <a8e2ce0c-0aed-41b6-9856-acf62f60551b@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e2ce0c-0aed-41b6-9856-acf62f60551b@suse.de>

On Tue, Sep 23, 2025 at 09:57:11AM +0200, Thomas Zimmermann wrote:
> -:15: WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately
> followed by Closes: with a URL to the report
> #15:
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 

I've been meaning to add a lkp@intel.com exception to that rule in
checkpatch...  :/

regards,
dan carpenter


