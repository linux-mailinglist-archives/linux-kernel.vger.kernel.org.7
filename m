Return-Path: <linux-kernel+bounces-859247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D31BED1EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B5619A1EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0C52F99;
	Sat, 18 Oct 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR2NUjUA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC819D07A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799744; cv=none; b=DIOLoHXenxxmrrBKfIxeDRpA7Mi4432efreqDcFKmPd2ZgACK0Z9hMT5Hrja2Wvx4zZHiKrm0zMEPiJq0CvlhV+rh5IQODxlVJgPrUwa7ugnsRDXu5DIUqabYZ2hJR1qIepyqEUHtcdsVQuMU8cgManQNutv+HHr8jCRvJP/uOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799744; c=relaxed/simple;
	bh=GUccLFSXbotA/iDSpiMw+QMvX11XGngTX7WaLv4NefM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNZtpObGRlum5pa8Gtr5PUTjB1HYWrc8ZzlTaIZGrubOgWajpx3Nx4SgeWTrRkoN7LSkoqO4zNyLjXQJJ66eoXLH3IxAR7AyGGvCIG1RJmAI0mroo0URiFYsLP3eHMuT0qterbgC/rUfB3bZu+7g03sT3HJWp6o8lt1hnjnbnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RR2NUjUA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d48e9f1fso105705ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760799742; x=1761404542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlYuLpH1igkPNR16V+kXqlzDPd/shpYRQgfcrIfBZBU=;
        b=RR2NUjUAJ77pdrDHYOvN4jaSMOMgPnsU9ae663heVzNop2tUnTFkfEjCpMiFSWE3Xw
         KQKBSm4fXJZY6KAlphRul9mG1Wv9xepeQKbeTg1PjlZ4E1hNx3SIBu2gn+KE9OSzxxnZ
         y4YSWRGHHwp5GvdB6gk+0bM48MlkpXUTyjhr8wLjO/KAYAKm+Pow92X8dnSgiK0sP+IV
         Ddp0CPjUiqKTkFALCODS5LD4NtCQNEMgpaBv/ownu7uIwpb3TDm0JeKduGYCfnUBkB9j
         1XPydKmSIhjolij1FAyKEyVhkW2rjTY0jHUDswLbwXM0yDMGk1ccVQeUzWHphk7fUtSC
         QQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799742; x=1761404542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlYuLpH1igkPNR16V+kXqlzDPd/shpYRQgfcrIfBZBU=;
        b=EscZfoSdReDW812gsh3BLqrYgsKd3Tn01EOBsfIKVfImPwMRUnCrKnpniraS80kJus
         zQe+MYQ6CmzDTkYKKFOACe9BHyFRLkqnlsku4M1J9bRtQ5YxIRQIIzC/6eH9i1T7oeuh
         9qzesjT6KCs+vDwmyyaLCUDDSsY8+uf01oRteyA2Eu51rCu2LrbAc35x2XgT14S8AkdR
         Zq8CPpTpgHKC/Aw2WsMaW32kGSt1E2cm8hfXcQenX6gN6QG6m7tUymKA7PUOAZN8qfAX
         Qpky1n1bx4FN1ctAkSwWJHr2jvfd2HGXVtnJepWWlisycS+eNtg18ZrvKdejpoZedqF1
         kzjw==
X-Forwarded-Encrypted: i=1; AJvYcCWBv6noTGFT85y3YmHeFdzDxUK8UpFtAT5Xlq3rCG6Z3h93zdnCsSQyQNzZtw22l/nPYZ2yq3pd4iwBzw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzorrSiaBFFMd4HF/bFfhGKukWHJ6ETS0+g2QUKbGjlTucfLCzo
	tnN0qbi4Cq+P1DqN+gtXWx6Y1FVkG/Me+DVrxdrnpJjbEUKmqrB92H7quqipi9BuWg==
X-Gm-Gg: ASbGnctgeWPHOZ+PXJLfCKTOPJeBYqFZV0Ltgs7Uqj6k/+NXGeiIVNHaGh6pMMlHPWs
	5hgbn/rwILr1Y2ss5y0m+j0rHPcqnYm0aMOzXZC1uqavMEvryV2Y7/tJYr0PwdbXVzGDtuxR+k9
	u5tUoIx4lnCxNHi7jRj4WG1sp23bVBDGX7CNb7xaXVvnQSGSOocwL0Ny+/+sAfbJd63kYZEBU8A
	eT1Ho4nas7ohvoPuoXE+DNI5zJDJJr/L+cB266FoH502Tx/2fLjrSU++F1jYBK9wG24Lisn4HWT
	ujaSvwBFn082/N0kzFn3ivQ73Tf5mjAWpQ8Au1orohzR+ddAMcYsZLzb26lUUCLNdt0Dts6swP1
	Os74QRsLkh/kNSSe4qGY4bWPJ2dV/YlPZ0O4SPpv7FAtlZ3vQNfTdO461KJTU2Zalvzu8U9UXBi
	iS/Az41c22M+7BcsM1K/rCvzTzDLpTLdsC4X6WvgX8mm6P
X-Google-Smtp-Source: AGHT+IHn/cXDBeHEtC727RudKIBdwOBJikUhHVFuXlibJ3GijDu2a51IVN94hK+dTzRmzOM6IF+O1A==
X-Received: by 2002:a17:902:db01:b0:290:d7fd:6297 with SMTP id d9443c01a7336-290d7fd6551mr9621395ad.2.1760799741386;
        Sat, 18 Oct 2025 08:02:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddea9e1sm2918623a91.5.2025.10.18.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:02:20 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:02:17 -0700
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
Subject: Re: [RFC PATCH 16/21] vfio/pci: Save and restore the PCI state of
 the VFIO device
Message-ID: <20251018150217.GB1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-17-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-17-vipinsh@google.com>

On 2025-10-17 17:07:08, Vipin Sharma wrote:
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -110,14 +110,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  #ifdef CONFIG_LIVEUPDATE
>  void vfio_pci_liveupdate_init(void);
>  int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
> -void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
>  #else
>  static inline void vfio_pci_liveupdate_init(void) { }
>  int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
>  {
>  	return -EINVAL;
>  }
> -void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev) { }
> +int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

This should also be static inline.

>  #endif /* CONFIG_LIVEUPDATE */
>  
>  #endif
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 

