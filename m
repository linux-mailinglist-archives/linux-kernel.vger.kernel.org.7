Return-Path: <linux-kernel+bounces-859520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E1BEDE2B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D9194E24D4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 04:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027572614;
	Sun, 19 Oct 2025 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3ZFTrOm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DB1A3166
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760848740; cv=none; b=MwnZf97HkLKw27slPWhFrEtr2p8C7AKpItBy97nHly9rke+vMeOEXx7/JgNTrZzggHNmpQi2ZSLxyYk9D7PhIh+7YIBn5ZCFi/FY/mw/CnfYlkTpfRiBYLYDrSnnaKiPqYq24wmFQjGeKryMMYl4t3GUKE5n2EkNq4yI+9Rs54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760848740; c=relaxed/simple;
	bh=0VL6UvbA1L9L3KYApi2HBxM5osAN5B72tXfZdkax4n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJYlk8OulcUZLagE6ePtSta+UG1o2PzOrERkB3g9ZFHGTCO9joemYDoSoL3PZQ1FIV5yiqfIKKUNfQNtoiZJSlfsYBEOMLJww9M8+cFjk6RHG6oLAoEmU+tVbx5b5uKaDCGxgVqH4sUeqyaLHjNgmmbN03+4CPDAKeg5pE9hqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3ZFTrOm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290dc630a07so13611155ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760848738; x=1761453538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmK1mTi1aKqF882bTtKfCSZ/kTsVspf2lr8U06HUrwA=;
        b=F3ZFTrOm/fdEKaf6WBJmqCg0W+TaNaZrVAyDkmvtSoptDqo8MSHNrafraH0ypL3VQ2
         uA1LmHVEO7r1IoGyBmFgG0pi8AQECL4292GZd7fq48C7NChdc/512G0AxBnBRp1INDqn
         fHR3p4dqv3HwfwMnE85m0dmX0KMcvskzZrJJ/TLWgO80gYhJmcCEPmxAYXC4QgkDHE8t
         OP8NMPB5Cn8uDQAM+ty6FT6deNbWo+KsAaAqvvO5WHlcdqwBUKNHBO/0dVr1x34frHBR
         fe0RkWKZjf6qJgy2tcpvZtXXHZIO+dHwwQh4XJlhYext4a6ke7CyAVEaovykpxxaDO9C
         W5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760848738; x=1761453538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmK1mTi1aKqF882bTtKfCSZ/kTsVspf2lr8U06HUrwA=;
        b=h6aKHXbeX677YvXv8mGOeILDgw5z0XFAIbCiZDq6ap+Bq1B+5v9bCb4isv+VNl6Zeh
         9Y2n693bikQvBunNBoR+AtMdFv1jKeYAKKzeRiAoBIRhAmfBm95b/dBYvt3aPlRN4oBY
         sQjm4vCOi1uVY24tUJEG5HDtHG0ZAfc8LyFqvpDvigvVrW4lCoLzFtEV8gZSlMRJtDRI
         tZeg4uIqCvO7pyQfzYYZPRnhEgzSOYQGs2Av+HmNk6Pvq/xPQYp44sEJ0ESvHkYEgOyF
         JI+ZXgkn7dxc6IoyY2BWl5pWxUVxBypeK+2KZi8tgqwtvmfj8b4vdgXGxyvgHpCVIkLX
         G3uw==
X-Forwarded-Encrypted: i=1; AJvYcCX1pzUH1UaqT96EPjabA0U/c0+cEa7Z1r5Qz3lxp8kzELOlqxwsQMJoWqjvMmBIBo6KhidT1cHRWIeKYcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixIBjekXtuEBC24egnKWO/ooS/uCRYE4dryj2KsOQrmtzB9qu
	rHuGKjmWMoE6Imz84jBAkLlUuK2ua35dJ8LKnB2I06U01BZwCgqWIxYy
X-Gm-Gg: ASbGnctXyYaeYm0B9rGMhPtmOrO2Mu+uI/GR516Go69kG/DhwWfZyTeTrH0b+9Mnsi/
	m/1QT0L9+fT+9rr1KD3lgKCm/Yz/kJt8brEmLwWtSo+/ZlCZmG6hosJ377PGlDtba9CIjj1eaoT
	8mKBy/PCn3JhbPhV6K2DnWOC77pbEiMrIZ4GgPoy2Exo3GbeZRucWzerl/DI9//EFoAvukwV99O
	5ZrxbCbG4CDLcm1ZHDiCcZL2TcPNn/FNQ5KyuDc+jQlUL/AXRX3dWqbzqnsEmrRIvMx4fr0xM92
	OdWkr/2hZlG29Oz1CelmbA8axH49DxVMR0CEFh1ljW/MkHcgueB/3iWzydqJ6bdv3vNe/C1UyWN
	kz4R1TFuV4AEK27jULUIpFv+5ARKSwac6mQY1kHE9P4IJ+/8q6BXBY34NI3ajysj8Moj+4tzzjb
	YDv2xIXg+MU/jw
X-Google-Smtp-Source: AGHT+IHdS/E/u65fGvAAeZHq/8Z61TPZEPdEbbbaTroydHGnbRpgb6AV15wzVJl9z/JFGKzlDshZFA==
X-Received: by 2002:a17:903:19c3:b0:270:4aa8:2dcc with SMTP id d9443c01a7336-290c9d34dddmr114629115ad.19.1760848737742;
        Sat, 18 Oct 2025 21:38:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm41615345ad.54.2025.10.18.21.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 21:38:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 Oct 2025 21:38:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	Yi Sun <yi.sun@intel.com>
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
Message-ID: <58d213af-f422-4b70-8821-9777fc1b7020@roeck-us.net>
References: <20250917123344.315037637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>

Hi,

On Wed, Sep 17, 2025 at 02:32:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
...
> 
> Yi Sun <yi.sun@intel.com>
>     dmaengine: idxd: Fix refcount underflow on module unload
> 

This misses a cleanup call to idxd_disable_sva() if device_user_pasid_enabled()
is true. This results in a warning backtrace seen when unloading and reloading
the idxd driver. Upstream does not have the problem because support for
IOMMU_DEV_FEAT_IOPF and with it the cleanup call was removed there.

This is just a notification. I'll send a patch fixing the problem later.

Guenter

