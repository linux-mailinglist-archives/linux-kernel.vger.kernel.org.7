Return-Path: <linux-kernel+bounces-830541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FA4B99F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF7A188BCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFA2FC893;
	Wed, 24 Sep 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kkn6onVP"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DA2FC89C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718560; cv=none; b=JMTjcdqQHIYZIfRO25EbsRpEhJlDNovkQJAMIrgYDd1IQfeAd5eKgWG+le2FXTQze+72HVMA6ivBXlT8iqQHYcyHPqHUXoMoZM3dDuMeXxZIRSDfvwJY3UHnqy0YnchsMk5VCALkQApaqiR7z4JCthFIM8eXB6T5LLsr//fFJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718560; c=relaxed/simple;
	bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfufm3Rbsq/kcf+snd4yFKBn9bmTPrRYmowaS3lxMf7hENxRvebTeB/4dFTiwudZxfMkwhOXfCNU71JwX8gkCV3KWgNB0XySON6bu/bVECPgMecP39aMnFLr1RA5R32Pw97EojnmZdRvTU8nUwOxgKypvM/QYJM7gqekiB9tKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kkn6onVP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7945ba93827so628147a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758718558; x=1759323358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
        b=Kkn6onVPAMSNNklmFFZI3aNKbFGXU6nBTzblm3E/Pqfzu0p10WCUO6yPajm/5VwuAM
         0R/CuTowYLBmljyJC/Kn5QN5Wdco/tdBRn5ekpqnGP38SrN+Ac0292QFuzXolu4Ur2ly
         nMR4TkZHt1hXvq1/mclPrqQIzGGal2GIP/5UvgAk/Mdh0Y0kr2haii3hP91cObbCQxQO
         TXW0yvCQfwfgC0aETgt+VkrOzjRw8DVOxHJKZ7J67EtCgL7I4b5l0Qgvqt8gtTaq90iZ
         SZ+0Z7skuhxl+n3wGdTfN6yE1HSJh0h4Qq/SfGrjta4rO8mi9X8xjGNQPxika3XSUOJm
         Ns3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718558; x=1759323358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
        b=YF0t+OuqUX6hyvrkV9DXM1vC9MWe897VCUqBKd5ofkI3uve8a/nLaFcADK69R7v15K
         wwlQ+9rK/xTLtABSLD3W7PRloLo+NKr+p2wvIhc7/0a2gzGKf3cmpTq/YByhIhizVVBt
         vFofY4j0pdgzyDqqvHM3gVV0eIMEw9w1P4dJE/9ETgOpufQyOlzPbwZ+9eX4McVvH8Uy
         OP2ph5qGnvSbrJhDvRciDlXzfkGo/4dusG5m0BGuI48RL/minwwDk0YjOti6zBfaJgza
         6wdDLMmtOL20kwPIXkwJtt1Ez8qmjS7xlrNlWpNFqUERMAMPmAivedmt9T6O0B1pN5Sd
         9WiA==
X-Forwarded-Encrypted: i=1; AJvYcCVxyw8NdhDk2j3unqKyyyYGSrV8U27miX5ECKbpH02UxL13toltnssy4hGK6RJ26KkC3DKpMxXMFRKXqUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV1SKYS0HTJ9tm1JkB11CGiZ99c9hd4spM0wJrv4xV7hCKijaq
	Ek00lzFcOiJPDqxG818Qdjck3gQpC4nN1/2iwdxmnhxNvWt0TmP6hCM9Bef0iY1OyLg=
X-Gm-Gg: ASbGnctOwFH43r2H/y1F6W1PYYaZrZJJUGAa0Rrxw93K9JPmr+N15I0+TvmlGI2JBm/
	f9WMTo7z4k/wAMADdm9li6SSxDLAsTvM/KyAGGWstAT7f8ImF9HH+OMpbIRbLSr8HjxLPt1I81Z
	MvRGLZYg7HbWRcuKZH13EyCxKw3DmrlcnXDzAof1RJZu1picNuEv5ESJ6CIcC4HReJv8ihJnX4T
	oALR3CvKnWA8bChPjp0T9jHQRmpu7/XlWaU5M4Om+KFAOoqwxi+cyDztzeqUjpVTJjdnl9FXOTt
	SYwuAbQI68LRDIeC0zSMLW0tHxe6EjPx0wf13quQzYib+icut0eiRdn59/uFsYPE9fAtHC8I
X-Google-Smtp-Source: AGHT+IHQ1WFwERflWPT6pleBXcoHSBQbFQS1yTbSrGY2yC7WZRjb2FbqLBgkt00nf34cnENXHwUiCg==
X-Received: by 2002:a05:6830:65c3:10b0:746:dc05:8604 with SMTP id 46e09a7af769-79153cba081mr2694566a34.20.1758718557920;
        Wed, 24 Sep 2025 05:55:57 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692af2f9desm7576308a34.31.2025.09.24.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:55:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1P2J-0000000B800-3i6s;
	Wed, 24 Sep 2025 09:55:55 -0300
Date: Wed, 24 Sep 2025 09:55:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250924125555.GJ2547959@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
 <20250923162139.GC2547959@ziepe.ca>
 <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>

On Wed, Sep 24, 2025 at 01:51:23PM +0530, Manivannan Sadhasivam wrote:

> This device is not spec conformant in many areas tbh. But my
> suggestion would be to follow the vendor suggested erratum until any
> reported issues.

I mean the ethernet chip retaining it's SBR after a FLR or link up/down
is probably not a spec requirement..

Jason

