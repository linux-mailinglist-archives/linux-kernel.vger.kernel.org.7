Return-Path: <linux-kernel+bounces-821229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD87B80D07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C257E7AF688
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338892FBE1D;
	Wed, 17 Sep 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NujC3H2a"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C32DC35A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124775; cv=none; b=TqNAvFMKtWBYxip05wG/8ujxliwCOeHFVmqs/jHGbAEWlSJWA2Bgh8higwwHqDFdTwtv4wQe9aSSlP2IuwuGkzV8XdvjpLnYk/FSXWZnCNoFXjSLNt5DiJhAciZI7/eThK110Ip/4XtRHjZLMpElNneTG6hpXV1W7NCuZENNGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124775; c=relaxed/simple;
	bh=bwd2hym8tNSAdXkGE4hZ3iw7DYGozn+untN0aXZ6tZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poqIvpWWa4oQgkc38Z8mskz4Gw3KTs9/qE5C/XGlXV6BUEAJfD8KURNK9sRqq5NqZ9yiSYIMsAe3RrWroiXcTeUnuwNiK4o/tuRYRydqn3avPdaAGlib2SfRyAe0ti+r18tpvUVA7ze7Q0tdvA0OsZ0tx4FmW/KNJxsYTnmgv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NujC3H2a; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-621132816c8so1907eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758124773; x=1758729573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwd2hym8tNSAdXkGE4hZ3iw7DYGozn+untN0aXZ6tZA=;
        b=NujC3H2a1m14GIu3bjmWd3ca3E7gLcVDIN+HxLv9W3WOoS8F/Hpdtn1m/0N64MFGeE
         SoP2Z4ZixG0hA0BHPrDfxp1578zB9HaWuQTaINkxqpOjLuoC2RClpx5gdJ75CWNN6rRn
         vPa9B0CkC3sZJMoWPxeOiQd5xI05uJAINF/bur7H7ddKHGVE9iyFj+MI4R79XlYiecWL
         1gXMjMRvD0oAExv9D8yIRBo8F6mZwMrnRSWTIKMBZW+3GdXrxQNYvE8N+UG7p1AuiyCn
         +U5dPlB5MCwEF5UVt9TbIgDYdfBONH3LORTtbKxgfy89K6kRErGEAs1v71FQu5eDFCbq
         tVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124773; x=1758729573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwd2hym8tNSAdXkGE4hZ3iw7DYGozn+untN0aXZ6tZA=;
        b=sDub3+lcsvO5+EAOHRe24+b55Tay//qPA/fBzpzhJ6WABd45ZvkrBMTL2wb6RESYNk
         0xIm3HQ43XqEqDLR2auTn1Xa7Bnvt78EFPBuiPkjj2euHq4q0JNLSKRjO84+M15GgPty
         8lWQUNV1jF9pGqBp3a6jJ8od2KPpFnw4C0rQTD4EG1zjrY162ElM+A1B32e+/WWgXgv2
         GIKi1/NMVeAI3A7B9DbLmLjPmsvwkw0StywL0a7oovIFGEsiIGtabFe4CRDtIFBt3Ejl
         0EQHyL7xkR7HBV+Q2Ddiqh3+0NattNsQ0cQc1gbLVMJER8qqJZpo3eWjTBYe1lOM9bLp
         4+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWolzRYnPVS/bWGqBNxHGu/mLTGcbGRUOP83P4Da2CgDBJzveB53c2PhtZEvHews6Nu6N1u2yNLsgn5rlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47FpgXTIO/WWTbvrnMJIMstcCMeqUIg4DEEqNH5A0uJ8lR8Rm
	NFadqvsZCkG3XC7FlVgDCNzLFg3yv8IIY2eOM+AjJz6IMiIJaNZkXd7173JwEvF5Nvg=
X-Gm-Gg: ASbGncuHlNq/8yjI9vAeY2KJ8+BOLw36USmxGqY6VfZrhAMlOx/NXgWohJRjPcbgQw6
	DrX3Yj3eHDrsr9qN2cnGxytOrjrDjwd15/+nK6aVMkqnktc8e+mzxyNcWxKZ7fOSMcH25p1sZpT
	2ii/WdR6lrCDohGUNJO5EkRkhGMk2DxafZLUPERoKPxaePvBzwtLLaOwM/fS4wQsiqLNyWeoeG3
	RAMTUKJVZF0psfdNjkyxI6LRfPf64iHAi0FGBecRm/DWOV9JHe26lv8wRiJki2HHdOUql9G8UCl
	zy493TiwqrcrqW2CBhevRHqJo/x9dQDHs35nUYyV158Lh0QTLyFyPqQjpHfYVAqINu5bCf1Q
X-Google-Smtp-Source: AGHT+IFPi2deeD5xpECHK4kizIqpzvjT3NpSt1j+SxaGfjDrfDGe9/bYIqtD0y9cjE6AL0d46S51pw==
X-Received: by 2002:a05:6808:4f4b:b0:43b:2829:e642 with SMTP id 5614622812f47-43d50c63332mr1037591b6e.24.1758124772981;
        Wed, 17 Sep 2025 08:59:32 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d6909sm4320090b6e.7.2025.09.17.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:59:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyuZ9-00000008UmV-28J5;
	Wed, 17 Sep 2025 12:59:31 -0300
Date: Wed, 17 Sep 2025 12:59:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250917155931.GI1326709@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
 <20250917123601.GA1326709@ziepe.ca>
 <aMrNTny9jgZJd_Ef@willie-the-truck>
 <20250917151612.GH1326709@ziepe.ca>
 <aMrS71vQ_MaVonzi@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrS71vQ_MaVonzi@willie-the-truck>

On Wed, Sep 17, 2025 at 04:25:35PM +0100, Will Deacon wrote:

> Ah right, so the driver would unnecessarily issue CMOs for the structures
> that are just shared with the hypervisor. At least it's _functional_ that
> way, but I'm sure people will complain!

Yes, functional, why would anyone complain? STE and CD manipulation is
not fast path for anything?

Jason

