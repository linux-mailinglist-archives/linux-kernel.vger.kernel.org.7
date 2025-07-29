Return-Path: <linux-kernel+bounces-749233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99901B14BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D911B3A5416
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01012877F9;
	Tue, 29 Jul 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxa/6kmW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2151DED5C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782961; cv=none; b=Bq+BNQn0gAmgyvDwe6ZQkCzYhowJ6C0qbY4CFGrHG5t6fZDoZ3aM0fUGMTrI8nVzhirYbVgY9bB7ezjig5e61/gcIr1l087rIwARQScuMgNGGAClO7BZf5r8otTivn+oGQabDA+ub7TXIht/PP5Dof/DWeYycA4ugCu3dapg55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782961; c=relaxed/simple;
	bh=6J6O8lIPO8lPF6L2zLsyMC1bVxdBOnAwKLyRubhILW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFzlSbUWqXFUtJKA2+qwCTjpeTO3o4fraErm27+rAhe2KHUMe+ZS1YXslf2bY+58+fb0/RLFFCRa3DBszYqeGGT4oCTbFced9dyMecaDvURvVrSwkKsahwMnPE8cbim4SJbAW9tVWuBPtNtAnuZcO1PabQmHRfulu3eZDLf9H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxa/6kmW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4562b2d98bcso29975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753782958; x=1754387758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8BeCJxT0E9y6LqcrNbSOsYh4JRswSE7zt76fN7xljQ=;
        b=dxa/6kmWhBe87WhpgTV3w72i1t8hRszGGqRL15yb+aCEkm7F7VCUtbO2sUkQE9FvWX
         p5nofwXTUZHPm5KwjnpcRzzg56e8bYoQt3ovQyo3bcEzr4jin1Wd6GxuGjvGAB3Hti2B
         ifxvz/p/PXjRRCAacbeV2mLzteDObkArriwFIA8HJ2rMnpDH1hGWCK37MJquYlLCCeiD
         2h7a8iURs7/Y4P//nM/0YiGxyIkmZ2tc5OXjwxgSBXoTyojIo3b6uQ5p8WqyjpkL7JCs
         HCGzOHv3haPQRuds71CRbKpYiuJA4gpFUpOhKoLVphfyYFfhe5TmZfF2Ow1a2EWZtV35
         r1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782958; x=1754387758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8BeCJxT0E9y6LqcrNbSOsYh4JRswSE7zt76fN7xljQ=;
        b=K/7GlBFmDmuInqeYoUfxGxAbVWqtDYEpqcDGvRMTzZqCx5AfmAxUKPmzU49dWxQx5n
         pSr/F4WvHBkkKMvg1B1hRusMqbxl3Xdu4+TQWzHSuTM8ydGIXNixQKH/ozkWNkPuakET
         1vvYl2Dz68CYRnDcgdSvfGSWZEgjtaiK/W9V3z4kiFRKWi3MzaX28WMMnbd/9UuUR6B6
         DcXU+NmrmQDMOHpr+vHOlaG3JQckVT9BY9uX2e5/Ey/8K7saPoudyCTnCYgKBvoM8S8O
         Zr/V8FrnVjM8Q13chuVJ0+V/0fhuikTVknspauNQ4ppvNkd6dDd7dOB0EhQiVWXeyw0T
         Zj4Q==
X-Gm-Message-State: AOJu0YxkOcg0jW9QmGCeQ61NAW77GbBOiUyro69UvuinAjgnaJZpWXKj
	IqrmYCAF/H8J+ogxkjjwSxc3TFFf0wxMJ6K8YaT/ivfD/ReKejfSk4K61lpjuKZMlL5IDYY0I8O
	giO3duQ==
X-Gm-Gg: ASbGncv/rEz693pfl7x86uNVNaEvI7M5H3O3DIH9o3ocSlhvnZI9gAW18uLPYRFUjRP
	C9a+pUjuIMqYwEyd3WZc+DKqEAQgvODzJseJN6zwqFsFYQZDrSpq4Hm/x8yS2CntmM9GTHnBMIm
	iRsSyFJlEHxhfRLicFOi2a68dauA0JoolvdfX5CEqMaxNzMPnE60+QnD3mpe1B7i5UL/LJk3y6C
	OkrOHGA3eBnI9Z+GjHiSGdf82gQ8ARpEyxQ4AhTG1Fru38P8aHB7Oo5qvPwpaUx8d7Wtjz1NHtY
	/kIcbLDx3otSgZpyS+HjDFBHacSa3JAcxybhQzLjEeQQBi49EahuBkwOIpBAloq7xqtQD0RAsdf
	AzngJGs9Y5RVvvqFqnVnYM9UA3NPZw2LxkWu4jACkRpbcEN93lAhY12fJrmyk
X-Google-Smtp-Source: AGHT+IGzES6hqfjR1ngn6YMh6m2QMnuLZqGDQbq8stqciYuYMIFTwvOmpG+4EtUrCFw2V/nQTG/heg==
X-Received: by 2002:a05:600d:17:b0:453:6133:2e96 with SMTP id 5b1f17b1804b1-4588d58f585mr1058175e9.0.1753782957791;
        Tue, 29 Jul 2025 02:55:57 -0700 (PDT)
Received: from google.com (232.38.195.35.bc.googleusercontent.com. [35.195.38.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e33f8a2sm19702345e9.0.2025.07.29.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:55:57 -0700 (PDT)
Date: Tue, 29 Jul 2025 09:55:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 20/29] iommu/arm-smmu-v3-kvm: Setup command queue
Message-ID: <aIiaqSVtSpX7hr8i@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-21-smostafa@google.com>
 <c8da60f6-4083-4aac-b921-d57b767fa895@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8da60f6-4083-4aac-b921-d57b767fa895@kernel.org>

On Tue, Jul 29, 2025 at 08:44:03AM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2025 19:53, Mostafa Saleh wrote:
> > Map the command queue allocated by the host into the hypervisor address
> > space. When the host mappings are finalized, the queue is unmapped from
> > the host.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> 
> Your SoB must be the last one.

I see, thanks for pointing it out.

Thanks,
Mostafa

> 
> 
> Best regards,
> Krzysztof

