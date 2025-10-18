Return-Path: <linux-kernel+bounces-859246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 143AABED1DC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9217C34D5C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A028727B;
	Sat, 18 Oct 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkqYqVGK"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72A1E2614
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799599; cv=none; b=APTiG11OFmdZR3ZoKyw1CMe37nQIGOWBF+eLQ1duAmzUfuLZwovP7MGg9vl4rsehDRYeSpToIdmv3YDf5ewuX7ptoiumI3JM6LXXCG7fmSZdVWd1SikCK6reQ8+WIGQa45cu3y8BZCHmBtUGJAvSRUYO5iTMNzWVcY4/gBrsStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799599; c=relaxed/simple;
	bh=RxRGGS34lOYtj1tSF3o9XGto7oo+cPrOhIqsrmS/Bwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPYLq8/t+feMlcUaoX23AAIJw95KZxcOpEJew4vFSaqRUDRGVkqpVA26k9rETGfeP9h02hB5rQl82d1LwuEwr8phlTAfypUdJm9841Nkxv3bGhDwaSxixGxDy08+4r9N2LJGDAxQLKL4YbaIsPTqhGY6c8TAG+ugoNSTUIyX828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkqYqVGK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290da96b37fso102155ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760799597; x=1761404397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SjKrzbC5Tx+d+FYfgi0Q+xGdmlz3Y5FBshE2AUsLRs=;
        b=OkqYqVGKYHwDdEwQJBt2VkDH5MaQIyGq3FtXkW08/OwuvvPJDWPWk5TwDvn7M3Aqtr
         IZQtMOCZ+F83AY4oBm0UOIBTTHJzCPB8/acfwSYbzppaujUrw5395lpEhzFcQaKGlqVq
         w+yOpAZYLzOE3iBSiZpzQuCDCbhyG3W6byh99Mf5XmLp7XhnP4sZgxu3o3px6Y6YvByz
         7i5rnuI5e4GHQ0wvyLh+d090sdS4MIwW+nTheFVi0jCE2xYE+0romD5W31sYPFBE+R/0
         1qyvW86n5PUnYpJIVkPwOqU/JyVV6f3r8480bWL7qqc/+QrhM5MvKzR5E6HtKrdIXQS2
         Q52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799597; x=1761404397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SjKrzbC5Tx+d+FYfgi0Q+xGdmlz3Y5FBshE2AUsLRs=;
        b=qtKzmN/AUnxIy+kkQ3q2E54SYVUW9g5XxT2Xw7y6zzlzg/qTxSFWdUuv1jNq8xZJJ8
         hN2zrozBXdFkSQr1rxiFRWqH1S2A1xTRjYGqMbp4boaO/PSCnLiBjQYtawlNlmBUpJuJ
         KA+BOPo/jd+x5PhUZn2K32kEDK4R92YF/UmYd5oSqpTvoJSLKKRVO+EF08UpB9ussMqr
         HC/J2Zez/+wIXqx8f46MNzY31BwAUKj3MS5Gmyv9et2Q9bFNWS4RQd81NR0dDGcB7gc4
         2FYL7IcFfPPNroPxDpZFR5Y2su7iuktHYQaeC2oe1BVNdIlYUa3s7WV9+e9ILVvMg0yn
         A3dg==
X-Forwarded-Encrypted: i=1; AJvYcCWYfjMwrTp4WELF3BAKFFKXyrngALx/V6EIHp4WASztOoJpYwZxLO4S9sG5PEl52IDk94pYj1cpgVv3H4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiHqa0ONNuBFquf2eiOCfPEzRKGUb8A3rAf3q5L6DD99AoRKL
	0N14J8DE5nOVAY/MCAb8ydg0ZDwjQfTS7JJZorXPttHJ7KKdD0VYN8fMEt/OsKwkBA==
X-Gm-Gg: ASbGnct2h/zdO9a+mi3G+ErUwzcu5TIDbAFfi6kfUROe6/Gv5ROLrvJ/H4Z6lg9y8Gi
	44ackQGNkL21i4BJvRAgyZrl0twKvcjln5coxPZw6vhH4FTw5sHgnhL6dSeV4Ds1TI06r2GLLCm
	s+NwZ/HL6/aiIsEuKcMkdyjp5V3EQzxZFcP3XNpfPVwUTfz/iLyRl/mdUX5JerJoYbPQOIdu7um
	H7+reXSj1e26mvEgSfTFZ8nLWHrZOwZN6CWnC6DEoKHmIht2/+sT8G0wBQdquyFKo4QWtpoKFmc
	/rGg0sU4CI1p2ZmMX84HkyUBgLFj6/bIKwDky0/OtBkD7NrBYe2sJ/REIiP9IzS64IlUUnDAilF
	8RywEZr/EXLJfC2pVg3vD/GK2vPm8lLp8ae/YMe5F+b5C0dTxUgQOFG61hrrp09CIwLiEIh9zko
	vpwPneN7/eiSFEQIyueABc9fiic1rppoaKpQ==
X-Google-Smtp-Source: AGHT+IEO4meUUEecoQCQ1m49ew5u3IzhZQhIoa/TkD8EI1gJuwGpLMOCNbvdEHLSvt4FD9IHI/8J/w==
X-Received: by 2002:a17:903:2284:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-290879ecc6bmr22769125ad.10.1760799596925;
        Sat, 18 Oct 2025 07:59:56 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2994154b3a.53.2025.10.18.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:59:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 07:59:51 -0700
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 13/21] vfio/pci: Preserve VFIO PCI config space
 through live update
Message-ID: <20251018145951.GA1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-14-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-14-vipinsh@google.com>

On 2025-10-17 17:07:05, Vipin Sharma wrote:
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -109,8 +109,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  
>  #ifdef CONFIG_LIVEUPDATE
>  void vfio_pci_liveupdate_init(void);
> +int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
>  #else
>  static inline void vfio_pci_liveupdate_init(void) { }
> +int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)

This should be static inline

> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_LIVEUPDATE */
>  
>  #endif
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 

