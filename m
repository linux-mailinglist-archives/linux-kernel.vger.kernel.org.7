Return-Path: <linux-kernel+bounces-748121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B7B13CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8927B3A2113
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1601ACEDA;
	Mon, 28 Jul 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cJqGHCgS"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C525C80E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711726; cv=none; b=o4VMGJ0GtW3bmhbUtRSwbdC5nfFv+ezSQfIp12xh2f9t2fy8O7DZknx5DxU+VpA1KvU/6HBIswKOazef8a25ySklxjtiNboZzjmFAVbRf4ZqCFbX83vBGiio8OfQ3OOvPUpPSKmgUOdkJa+1QchU7vbEVKYUs+5IdLkNl11F9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711726; c=relaxed/simple;
	bh=4kahnbCUUVK18hvpSBxURKB9raQB46M0iQ5FOKtQghE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+hniWOQ2rWLAI8Hm06w77eHX6tICqyztl6+bcrx57Cg5d2t7cg3J66PDURWhKv7FeZlxfX69D+5VSzgLQVAoG9EPVEaTBChFDRKwCWRsc7MKOKb4HRfeIToXijdn+jHACFikHDvRriAVC9dO6Rl5q9o7dYatJPd6H4x1qKc5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cJqGHCgS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab82eb33f9so75655061cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753711723; x=1754316523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kahnbCUUVK18hvpSBxURKB9raQB46M0iQ5FOKtQghE=;
        b=cJqGHCgSRbn6dMh3wcmSonKnTJI91EXt7JAH+J7k1MxjwaoDIz4wMTWJbk1DbodHGF
         5hRUpKISh4MeZhLmDOXndC2wHKnIWOGoLZNwzS1m6CEWcr639wWaBCrwuOm1u1PyU763
         B91qjf4TijsRMp16gJTq3GzUnGhnxSeToAUEzU/dRHwYFyp67e/F45IiBVxS1wSskIu6
         HrEizMDt9zvMDBxGt1ZKrkg1vjbBCN+ZJzrBmc47hcFFlbYPXpGx5aqd3uTAo2ICPV6J
         mPALCbFS1ywzQGhgt5hi8v2yOYiC3Y2eTWVSo4z2xIrWme3Z71Mvi8614tb3IwVslSad
         yTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711723; x=1754316523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kahnbCUUVK18hvpSBxURKB9raQB46M0iQ5FOKtQghE=;
        b=gzjix6zvivlkXH2fPparSn6UGURfLxLfzaPEHY/sylRqxf4hOitSQ8ubGUoPZRsgFa
         reyiR3J2ynL/D+52l5cZ7HkqsTANLFbckuI54v7PyaDARS/qSedB80YMYvEDlNcQJH6M
         0eBSdCcJE2FuZePnW/swxyDT42GGlsEd/vKhUb10jtyLUN3EGAFS3amBRX2grc7SW4pM
         Bvb0NQfWoeF4aEuBwh2JBClN8IYJtPrcMzf3ojJqIXNbd/5e+kQfuPdDdEWvf3ygJZub
         K73j/737axIxM0b94SSTzvoAGUHkeB9bRLzUD7bw4zNCvZJlhwECJxuwuBX2XMDoEd87
         qJXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZEQ28Iv77AjRkw/oYp7MpcffB5oW+EwHvICIR4T6vx3l0s3BY9/3fkh6OyJZHFHzjERmIq6v2UnCNnes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaK56W0HG09ZgfowQpMLk3BEzKPkqS64ubCvzD4Mz6h8eKGT4
	hsMCZk+X3t0BTBF+q5L1TRzvcsu/RuF+UDsYZy4e0+/Jw1LRlGIm+6oCIUAViGvK4uk=
X-Gm-Gg: ASbGnct99MIEgzy4DdU4u/tRHHy4Q9zookpUGzIlDSRvWyD46hB0cWaB2sEEMSupn49
	BUPQAXyr/lFg9jrbpsh5IxMGHdtcJ4PiQmPwdFc86r0eX/8UWPCAihWdON3I4Bx2TZp1qrYw9CJ
	4+YFCLTCHBnQJdYkQq79k7ebcLzIWUJR8Wwn7zFhelI94rOMHaeUu1jU9YTACkIH9NSxgOZiJZD
	ow1VONK5PfXfwC9mAgkl3Jswy+YwPDK1Bd8QU/I8s7bZ2Lr9MTTbyGUKtBn0sKwgGuc05ht3lfy
	I+nzlPh1djOv8024PtK8sIiqYCdizF6uKbajLRrW+sJo+jmkN36bKAg7vuzjZU03IBggeQXn2rD
	X8oliVBv628tPDqcUB20cXo3SmEa8hHZZNx207wQp0Y5nj1mdxHQC2dyBJVgP3/H5IxYK
X-Google-Smtp-Source: AGHT+IGXQH54g+OEuDAZ//VEsPFOF0VZ1eCHZSsCk3KsPn6dRKNeXLVClWZB7Vwu63ig1wAqfFoyFQ==
X-Received: by 2002:a05:6214:929:b0:707:4509:b6c1 with SMTP id 6a1803df08f44-7074509b794mr50900796d6.11.1753711722526;
        Mon, 28 Jul 2025 07:08:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c70979sm30626156d6.86.2025.07.28.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:08:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOWv-00000000APv-1G4L;
	Mon, 28 Jul 2025 11:08:41 -0300
Date: Mon, 28 Jul 2025 11:08:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
Message-ID: <20250728140841.GA26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-7-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Why would we need this?

I can sort of understand why Intel would need it due to their issues
with MCE, but ARM shouldn't care either way, should it?

But also why is it an iommufd option? That doesn't seem right..

Jason

