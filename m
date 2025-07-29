Return-Path: <linux-kernel+bounces-749507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B8B14F39
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D23B189D010
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675321C5D57;
	Tue, 29 Jul 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jwPlEigt"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5A19C560
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799361; cv=none; b=X7aEQiAG2Ym/DOxT97SD3sz1L6S1LZFD6oRyEeS56CpkxrWGxa+ppotEguzl/V+Npt16wyEsHBYpaDnnuUXh8o/VGoAEBuiJ0E0A3J+G1YbZbST7LHzZ8qgcliPMgJt1zgV7s2BuWe+PlrMShIsIvjvavpDtMiUaJDXW1G6EETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799361; c=relaxed/simple;
	bh=xOGcPk1h5mkQlFHPfT4qZPTUZq5yx18xGEjyCFHAQpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvcyNoCb/pW1Ho3EgoQ/PB6FNxqWmwMm3JbNw5tDcniujmHwdHVxJCxW3tvlBlLPhrP6NHAQVl+nIh/ei5dQuqOc5o9WmFJmaC52q0X4lagAdMuHuHucDV+NTvKEexeFQljXgmsYhbMVgufCwMzkh/zB2sdgFbkeemd1sR+lDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jwPlEigt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e346ab52e9so713502985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753799359; x=1754404159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qz67H2QziopzvIbpAdOwNF/pBaaQ95fyoFVZsRKl+KE=;
        b=jwPlEigt//r2d3gQdsBkbsY+yHq0n3yoJfUccwhFYje9huE5DTUDak7lolZPef31E6
         dYrLaaNGzFtk1opOKFbUb5rUWJe4F/dJzjy3ltOp3/u8T68di154kyqZMsopWYxQbtHT
         /g3ablFTd6tCDlQy9bI9+uZodFTy6oWdB9jE28SRQpDHpjEqYez9jpg07OZX4VNPqV1U
         6T3r17JaW7WJphJuNzj+Kfo4oVm+aHZTo/YY1wVPTLMUoH7JDjm9wj50OT0I9akf9/yW
         KPwaY7+Z6CKrD2lCMUbtfFbaq/Xib6EyQYLvCrA2Mj8nqIyIIurQboTY5Icz+QmqUjby
         UruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799359; x=1754404159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz67H2QziopzvIbpAdOwNF/pBaaQ95fyoFVZsRKl+KE=;
        b=bW+cFevt4ATrM8wZ8TXyc89UnwBbRA1dUZHfcGk5F8tOWVpUOiTdqGSGTzOB9OtQbr
         u/0pQN6Tdaw0wB819KdYW1W9LU37wFQepRl5WQyzvIihV7IXezDmYMrmvrFCPOrMnDpl
         bioiFnMlpcpQfVDklGeaMnca6xq0PhUzEFQ2YUsVpOyywPy9Z0v7vklFFdYZqBUCkiU6
         Mwc7k9r3FXdFT85gujAAu5mNNQX8XN0kqIxcnapO9DRaGnJ/7HwD08e8O+FqZBl1g58A
         n5B6a9beosupXWBN5t3vx9FI1/CXm1vmgylxeKWdMdsjrlDj9Db9jNfSNo24iG+JNIM0
         M/2g==
X-Forwarded-Encrypted: i=1; AJvYcCXQe0OsLKGd84KWLMgE4Ut4ui1gT9JK4gdUE+T+adDWubWvTiMV/Dp0FcYCD2Pt9q/ikemf2Rv3ozRaKQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfQEzg1ypXoMZtpvy4ufN8KYrSV3aB/LiBLXZZq1Pk5ZCbC9a
	8DkLqm/1yoFkiHoku+oh4wfvcH0KZQd3HyTEvGLEFT83S2fKBeM/SftOvQkpK4kVFdg=
X-Gm-Gg: ASbGncvOoIJlMa1f875GhkgIuk3s7+q5NMAzA45oNtYYf8Z1u/Z9u6n6envvYg7qZ0L
	HjLIwVF89YdTRQPObyfi+tpVYDNrH4q76qbFHY0v8mQBXxT6GJzhkh5YcAoY37iZFe0kuP2yBlP
	PPkZTzqTIjewm6de5qLU4XJ/UZodInwrdAtHvsvb1sEyYHPE9mcCH5kp9UFoXkfGCj8YMZbxLzH
	H+T4EvYaR86FvulTopylciw1JiUlnCEg1qvEvXRFFXgpuYSIETkrIiMICDzGIbChMSoxZPdYIsb
	Vf6jryLFJT9G0/GPwrG6615wOyNqpqDLVu4ExmHAOufR4MvrHmB0XG6t0hUNf/J4X3CCvKBv7T8
	SBqqZPcVLjR+FXGnGY71G2YT/NuavcrDhZziD3mUC6Tgb1b8fiaGOvsC5IGviAOlbta4H
X-Google-Smtp-Source: AGHT+IHYkw6eFpxfaIRVF1srsJ9FJ19UlQqBR6yhpID34uYqJijJ/A3tTeVFt7I+4cQKncFmezcccg==
X-Received: by 2002:a05:620a:8386:b0:7e6:65ce:2bb5 with SMTP id af79cd13be357-7e665ce2c46mr224992185a.47.1753799358715;
        Tue, 29 Jul 2025 07:29:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e643897b24sm431209085a.75.2025.07.29.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:29:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uglKP-00000000JGf-22cn;
	Tue, 29 Jul 2025 11:29:17 -0300
Date: Tue, 29 Jul 2025 11:29:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <20250729142917.GF26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a34afbdtl.fsf@kernel.org>

On Tue, Jul 29, 2025 at 01:58:54PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >
> > Why would we need this?
> >
> > I can sort of understand why Intel would need it due to their issues
> > with MCE, but ARM shouldn't care either way, should it?
> >
> > But also why is it an iommufd option? That doesn't seem right..
> >
> > Jason
> 
> This is based on our previous discussion https://lore.kernel.org/all/20250606120919.GH19710@nvidia.com

I suggested a global option, this is a per-device option, and that
especially seems wrong for iommufd. If it is per-device that is vfio,
if it is global then vfio can pick it up during the early phases of
opening the device.

> IIUC, we intend to request the resource in exclusive mode for secure
> guests—regardless of whether the platform is Intel or ARM. Could you
> help clarify the MCE issue observed on Intel platforms in this context?

As I understand it Intel MCEs if the non-secure side ever reads from
secure'd address space. So there is alot of emphasis there to ensure
there are no CPU mappings.

Jason

