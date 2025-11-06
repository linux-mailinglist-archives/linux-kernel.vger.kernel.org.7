Return-Path: <linux-kernel+bounces-887526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30964C38714
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 482C34E8500
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951E18EAB;
	Thu,  6 Nov 2025 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1Ewc2pX"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB817555
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387933; cv=none; b=QCmVIZULR4QV1I6SenNoeKE31D/SGvlR1mrlvhwYohEEUblYKkEYkoboJi7uHX/QvdoXRp/QQqhLM4chBp/qR+uAUW0SS+2OFTpYnlgL8gsFK4rdLM7xuyvQ+cf7gEI5ktkfdLyf1uD50nqLU9kyoZBO+o8Nc6lCnMQv7w5vZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387933; c=relaxed/simple;
	bh=0bC+YF0uuNbhQCtupED9tKbcEeEMcAcwocuVIfmRMYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKjDehUmnPEJnbXbpDZWrh8dWx2MuISFJaxuxowH0DaRGQZZN49Sp9bp2FZBKAHVpnIfU9NzC2bMYRXTdvahndxVw+DaLCJusQdCyEzIHYhdE12UD7M+aMalXEa5KImL9n4OExxegWKyLtuvqcOEV3gMlkuRV4OSL2Hx7boowHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1Ewc2pX; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2953e415b27so3756155ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762387931; x=1762992731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjKG1KhFcMCK3nhGqteZ5V7ruyWrAwYqXjl33IaIq2A=;
        b=A1Ewc2pXuWB6HiEby2sicNS4Egez/FYenJu52IxrM5g64LSH5xhOD20xgg4NJ5cakA
         qBDTOFRI/5PzykmEr/sUlsx3qik1PezdkSiH9ssi3j7cMxKastmzxj2PCtL4Cs3V34yZ
         yrkz8m+jcGXNuGCWTegswrCSm7/bfmpwjVf85R6Lx32QEA5Z8bQe7UcFq3+jbIwqOhlX
         FvG02U0GEzAw5xZkw7T7I0sAV5oGyNBwE4PZjCYilgOTijIKlOgvsyv2iXrez2+NPnuG
         JcjiPzlidnxq/oMla8Tp6qqkDTUg0Lv54jzPj/GtnRZfUwhXEPxibITW+6aTgr5AgEp7
         oW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387931; x=1762992731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjKG1KhFcMCK3nhGqteZ5V7ruyWrAwYqXjl33IaIq2A=;
        b=KA2xdq2VvhutL0FUH0Cv25HhDWZ2e6v2VOfzK/mUrgiZL2BCIxeLBXMNT+SmsctumP
         gbXr457UK/LvRYcDSmXkGhSeucQZeTkVvjKaCmaOLNxUHqDfPniCPH1k3b3fdWwFawcn
         RHXU84Mv+2fTq0Cu3LRnrSnDscyAsRYyzvK556oqMVJ+5230O/g0d/zYhVSeRLTBTtMi
         928VgHt45Tmb/rtMi7VMZl/G6YSgRoCjocfZYmVKTuD6MrRvC0f3D3zSqCKaGt4V6oDL
         Hfefd4Y53+qT7xQKuYEof66xgrVzAv2XUphTJbrcmt2FKFifsqnp3OZpnp1ViH2M9Kys
         6RtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7EaP5R+H+IM7pTmksMKFIvSBw12EuFkAE8tPA+aT0FygMoC78Vu1CUiX1l0DXQE/q5jQYA8wT48BYHYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8x5bHBHi/cBXTfsJF0XdVcdhuasR0tGDXPmJN+pT6S7zfc+tz
	DpVMbgM7eQkx0r09dKTMh/66zbz57ir31ZAthUGfMqJ7BQ+6ZZ5GlTS26fV7pLSInJbVnHJoYGG
	eXffYeZco
X-Gm-Gg: ASbGncuqcJaxx8nAKirYuRbylhoPpipvPxq/jDAASWtb/mm++Cy9/CjIRY0ts3tvTAa
	2otO1P7DkVEpVwK+aEXaI9Zrc3j9QEhGmjUdb4hLpBRPNONewtK/1bE3gizjwrclVTs1VLMRZwr
	VsfF4FbP53ao2H5yaYpkxmh6lKFqiyEB6lwohK1CGkeyFAx3MmR3S8hSbz6eDF+03xAkvXUu7MJ
	X7gLFyqNuF2xEM3TNPJA89lYLsKuXdW1H8B1YvacQdCMX3FGNRsaUcxtp7+5uEWAzZoy+lLqId6
	q/chRghxhJpQI9RXIFaiBc0h+QEwx4E3Olb1b7QyRwE2SMMAT+3NffwukUGKHJQq0pgVCNRq7l9
	lqjhIeLoZJAkHYJRnc4dYtexb7ReOr58uyPnfZpNoHgPClqtNvUc2zNAk2GGns6V+kve8cUZuCw
	CtcMyyfRGI3nfxBTzLDYbZaV2kYYWumWhyIc6UsIRzfw==
X-Google-Smtp-Source: AGHT+IEaCd9qPDXRUzojzt+yrklyPttl04i3bg4Y4xCKKm1DEqaJwmaybBTc7n3FNKNkR7Y9u9IwEw==
X-Received: by 2002:a17:903:2b0e:b0:290:cd73:33f1 with SMTP id d9443c01a7336-2962ae5afe4mr71915935ad.59.1762387930895;
        Wed, 05 Nov 2025 16:12:10 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ce87sm7196065ad.29.2025.11.05.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:12:09 -0800 (PST)
Date: Thu, 6 Nov 2025 00:12:05 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] vfio: selftests: Add support for passing vf_token in
 device init
Message-ID: <aQvn1b9sspmbYQVo@google.com>
References: <20251104003536.3601931-1-rananta@google.com>
 <20251104003536.3601931-2-rananta@google.com>
 <aQvjQDwU3f0crccT@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQvjQDwU3f0crccT@google.com>

On 2025-11-05 11:52 PM, David Matlack wrote:
> On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> 
> > -struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode);
> > +struct vfio_pci_device *vfio_pci_device_init(const char *bdf,
> > +					      const char *iommu_mode,
> > +					      const char *vf_token);
> 
> Vipin is also looking at adding an optional parameter to
> vfio_pci_device_init():
> https://lore.kernel.org/kvm/20251018000713.677779-20-vipinsh@google.com/
> 
> I am wondering if we should support an options struct for such
> parameters. e.g. something like this

Wait, patch 4 doesn't even use vfio_pci_device_init(). Do we need this
commit? It seems like we just need some of the inner functions to have
support for vf_token.

