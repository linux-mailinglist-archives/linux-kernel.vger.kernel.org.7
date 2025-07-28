Return-Path: <linux-kernel+bounces-748127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA32B13CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF254364E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168626F478;
	Mon, 28 Jul 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U70SHfsp"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1BA26E149
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711830; cv=none; b=XEONkC+VgySTJ8OtmJVVUsvL1uyZ0TgnTY3VmxO6cN8/8Nih70L05B/9it+gpdy3PMqkq02/1+RwrrNg4kXFiOFs9bij7C7KIUKlhbdE6LVgw57kbUxLenfuAtL9Gd2CJbqgtPMO90mvVZ0yNWe3KSobi5mdQHq/M5ZOaDo8/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711830; c=relaxed/simple;
	bh=I9ZeIDzhsLC+Rw6BB2ZpsuLCUCI15ECbtPmeNUTuSxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXNQUQZARz+rVpK5/R1+ZrAm2FMtoOtYnVPD5fNDt4cRChnZ9BkKVD6LuzhREkTT6rsbXBlux9oOlkNTKgo6Fmh+/U0w+1Plk4cCHamKe9+bmdka1WTQGDctYn6BnlWb3in/8XUJ8XQXKcRX7OGhwolJ8wzrJDymJ27RurOYX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U70SHfsp; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e63adcd6d8so295873485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753711828; x=1754316628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eqiZhyg+ZCBOtjufQJyy2X2RHAGHLhNx9NLb+2h7ug=;
        b=U70SHfsphcpkruUSqVSMksVKeHdqxCAPC4Ho1iOgUMBrD+lRcdYNMI6FQXeZpU+pl8
         nTiCsAjxH7z4XuRtcx3xkyB7EzmbaDhZLhsW1rpDPUimcM/v16BPgyqlpSRnInQRSxdZ
         zDXwOweDBJJmxY6jnFA/wy6xxJ7OYJ/cUr32W6C1y1D4dSAEJCg3jOmqHhvEQhbOw7Eu
         kUQGe5laXS/2MEEBRWbhlUREEdWyyT6L1SrmjPJiLaXBhYtDQUOpGfMASIRUD//HApx+
         acBQBaQidkPaTAiRQl6XmprhaaCIxNOBw8yDdyfk+bmS3ALuvr2KJp9Lu71w9I07Xw5H
         TgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711828; x=1754316628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eqiZhyg+ZCBOtjufQJyy2X2RHAGHLhNx9NLb+2h7ug=;
        b=hidfh3ha7ULmFGXe3nnqbhWfCnhY6DvRLqNI14HPpmV2jyL5lMJ7Ku2PoFwk+rtdhL
         7FEqhNxNOSp1G2ytfVDTEIa5GkRLn8iNcYrZXNjvRUCHfuex66MqVy5K4kMnlCexxoEM
         Q0lBTQMUapGz9LBLU9yfsEiTa5hxJphd/5073iVhbrTbE5DHCYRrhvFwAgyJtSYG6upE
         oeYaawMY8n4+mM4RA9uO3s9RcjdLmMOcRiNYdqtz5jzIZNAf31s2F31nfoC6MGjG4fKY
         QBqIhpOb4MtMk7sBcCBvK+UPRy6TAtfIWKrKboIB6AQp59eADRlesRV7j8b1t3GvLzQ4
         HMag==
X-Forwarded-Encrypted: i=1; AJvYcCVvbAUFU+83dktIxCDEGSa0g4/JEHUsEZeOTfSQ6zwnX6nVsBkTtj6hgTVreT1rvGE9V+j5uLZ70jbEZFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZtn5NCR+uZx3cW2Ox5lNl1DT9WHUCd7i+tF27OshTNAYfm1f
	GZLYpUnQpZhnZaIgwVwfnCefewwHr38hdtpKaj0EDJs83WUrGpJMW2usO99Wdp43TeA=
X-Gm-Gg: ASbGncvR/duRm4poru7d6NWOT2ibzkByeZYT37TprUyf3PqG8zLdhVRtsfAna0lmHmh
	qp+fLlqaU/uFVFKNQqMIm0GXE43xs8p9MbDhhZ12xLZv+NbOUYLV2+P52JWy+Mc5xdp/NbLIEBC
	CxOrgYQyZPld7iFEzM/WA5TqT8vUpMjwxqhvi0gHH22pA46C3Mscj/5o6PgtLKSd/FsKDixUIX/
	X8OPI8muSPXjaPJkjEFXWHpyymSvc3e1mP3RuPHb/pCiF65CCzDFy4SZfpTJTA3OGw7nmItLkLE
	IqsHMbUeHs19ok/zCAXR1yQciX9cwo3nDuUIWHO8lv76gc8FafR4ihINih4fRq3IpqLvJCrZz8x
	c0T/wpzrhc0QQmuhf2x8tjOthuVGdxv+Fk+I/oNGfnGAsLiZjonaMAeSBNgiNJGWJvLHI
X-Google-Smtp-Source: AGHT+IG4AMn3fFLDW2xb11IBx2YQ2BaQYNWmVWPx/pnTmFR/H2yiwHIFP+BF1HqcDvdzFfnmN7sa7w==
X-Received: by 2002:a05:620a:2a11:b0:7e6:3c25:b69b with SMTP id af79cd13be357-7e63c25b6bbmr1410127285a.13.1753711827688;
        Mon, 28 Jul 2025 07:10:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64327b33csm296288885a.3.2025.07.28.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:10:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOYc-00000000AQN-25tk;
	Mon, 28 Jul 2025 11:10:26 -0300
Date: Mon, 28 Jul 2025 11:10:26 -0300
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
Subject: Re: [RFC PATCH v1 07/38] iommufd/viommu: Add support to associate
 viommu with kvm instance
Message-ID: <20250728141026.GB26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-8-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-8-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:44PM +0530, Aneesh Kumar K.V (Arm) wrote:

> +#if IS_ENABLED(CONFIG_KVM)
> +#include <linux/kvm_host.h>
> +
> +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> +{
> +	int rc = -EBADF;
> +	struct file *filp;
> +
> +	filp = fget(kvm_vm_fd);
> +
> +	if (!file_is_kvm(filp))
> +		goto err_out;
> +
> +	/* hold the kvm reference via file descriptor */
> +	viommu->kvm_filp = filp;
> +	return 0;
> +err_out:
> +	viommu->kvm_filp = NULL;
> +	fput(filp);
> +	return rc;
> +}
> +
> +static void viommu_put_kvm(struct iommufd_viommu *viommu)
> +{
> +	fput(viommu->kvm_filp);
> +	viommu->kvm_filp = NULL;
> +}
> +#endif

Missing stub functions for !CONFIG_KVM?

Looks like an OK design otherwise

> @@ -1057,6 +1068,7 @@ struct iommu_viommu_alloc {
>  	__u32 data_len;
>  	__u32 __reserved;
>  	__aligned_u64 data_uptr;
> +	__u32 kvm_vm_fd;

fds are __s32, they are signed numbers.

Jason

