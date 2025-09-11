Return-Path: <linux-kernel+bounces-812181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27574B53418
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2331CC15EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9132ED58;
	Thu, 11 Sep 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knPWJyWP"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B93375D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598073; cv=none; b=Yq9EBNuj7la+Cu8PXYVhXkvmTViQ5HzPca4cJGyRMBm9Z4wSbQhBB/G3iwY9ftfvJxwHUuaoUYU6Xqsi3BgdAMrVVhcUdFEplMwgZVSzO2o6ohO8REsoTI+cvEv7m8GIL30Rrf9TPc71bEC5R+3nmGhX6fQeGemoGSJ9eAuOE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598073; c=relaxed/simple;
	bh=eLNCihb73AkP7eUzkZCYHE7Hj0pppLXFYhZ9Vl1IUQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHb8Nn1dlh3zYxkSjex+Q7OsLM1G2GbmcaiXZCnDb3nM0a4SIyoaGFSiYIYxkeGPwtp1mR3VXNn75ZXFNyk61b+gpqvIu8M4FcIH1+0EJLtfT8LtyO6OJ7GpESlqGbmec6y8qz8RXimuCZQ59vPdUdEn8f1RVUTSd+JRCm0YTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=knPWJyWP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b60144fc74so8819021cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757598070; x=1758202870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9qmtOM7dk27TAU4OyKZ0knJ4KFcYKzonTZZzmEGOvc=;
        b=knPWJyWPr0WFntWs6KShTFUbzrHAFhZbbSVbKcX8R6/tHIj8xdWJmAiN0Ow2pK4omx
         aZVX0Crvad5169nekNpnqzU9q0ccOWjzLPRpXSA6vdUdtZ/FC/DguEvKdD2l7WaJ72Nx
         x1mS1ay5rFmU7kBnllh4JRVRowGnBo+SELguVgZxHx+O1mUbzk5rStsMLcADVEcKMAkl
         97h3ryGzVSvwvHdde/OAdmg73dHI0fVN0aQ85/AahAI4ioBnii+oTckyphjDVjiv3eWF
         2+P+Hj0YyS54wYWpcrpXMwW68vobI6Jc5eZM0Pa7USJEn/WEG+/j99PUG+oka9JAOz1y
         zIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598070; x=1758202870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9qmtOM7dk27TAU4OyKZ0knJ4KFcYKzonTZZzmEGOvc=;
        b=hnKOIf1JFcFjw5biwnSi6tHmaVzUavKuWrfEg10aS0212y7hIsWC82b8u1Iqt5Y/OW
         VRi3Y6dqUZ15EbhojNJPYvk9nrEwTOIShyirCPTau63LbqUlqS5diDC5LGj0X3ezLJRH
         +TNT/i87GZpW+G8w08ni/QX8Nad4IW6Kpcd+Xzai2DMLlRA3tmwjIAWKXI9ZCrXm4HpU
         12W/eLX8nbRuTHunRhIHuHtVuegdDvpDZVfEc2oa5K0pAeGQxOCGh98PxMDAOdHi2Fkz
         omciD5yhPI50YJPo23BqB5GMVt9mwRWpu3LnaVlhjIiRS7ADSYbyy2kVrycgAhqmBdxo
         m86g==
X-Forwarded-Encrypted: i=1; AJvYcCVGIsp81P+6KqOXdgK6fNVNVDLt0PNPCWVRUGfhryr5rogpMEJGZLtsFklt3DG+zjWHoHim4UMCUFm0QQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu31ZZk6qJgdiv4OnGpgzM+67aNLz8w40r1E9SQPb8uMWJzEPr
	hHeX3zb+8XmNDgwK2xgfpUSofs8fwJaWZkwh6utzOHMRBtiqvygC2AKFY6Rgnzy0ylA=
X-Gm-Gg: ASbGncs548wSKTJ0bL3ES+x5xMpCAyEtu1CQ6aorl8s0nflIDo9c3HWEZCp0KKaIjQl
	uY8Nl3YOU9OPNgOK0mombFLLuyY9yvdDnX+JGROfSWLU5wwAqmssZ+kSe3WZLh2U2eknehTDaGw
	eoBCN1Kbd7/24wTx+BbWXr5qQ6unymtuGRbIorHRrEfsMm9oKQDZcKQzZuZ5vfKFX5GtdfywpaQ
	2fU3iQiLw2io6S+Q91IgT4cx8G7p1J3mc/vc4N5bNLiNfpJk2hbiBUY9MnsW7fvDeWn7eE8JTTt
	vOK8S0ACkhAY1q4VTHwdTRdRUj0lVezbbLZdY0CSFHdQP1+8gxWMQfn8MQH3VlDL2TaeKOXv68r
	QJyh97Z5wWdJ6jb0GDgAQCKtc5dCA5lL9TXOfemSqsCtIenuELDkDBk0c4ZnZpoeBWwkuPeRq9C
	0DvhA=
X-Google-Smtp-Source: AGHT+IG5BULuh1Ix3dTKx0dMR7o7+0XiARxVmRkjj0WGgmMyJMRjiHF7nh7Zr7cWchr7UEHaWH/u8g==
X-Received: by 2002:a05:622a:1214:b0:4b5:d932:15c6 with SMTP id d75a77b69052e-4b5f847fd1emr220313931cf.34.1757598070182;
        Thu, 11 Sep 2025 06:41:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm102730285a.37.2025.09.11.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:41:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwhXv-00000003zwM-3lhP;
	Thu, 11 Sep 2025 10:41:07 -0300
Date: Thu, 11 Sep 2025 10:41:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Arto Merilainen <amerilainen@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Message-ID: <20250911134107.GG882933@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
 <yq5ay0ql364h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ay0ql364h.fsf@kernel.org>

On Thu, Sep 11, 2025 at 11:03:50AM +0530, Aneesh Kumar K.V wrote:

> But we need to validate the interface report before accepting the device,
> and the device driver is only loaded after the device has been accepted.

+1

This must work from the generic OS code.

So I'd say add a new TSM op:
 int validate_pci_bar_range(struct pci_dev *pdev,
                            unsigned int bar_index, u64 tdisp_pa,
			    u64 size,phys_addr_t *bar_offset_out);

TSM has broadly two options to compute bar_offset_out:

1) Require the TDISP MMIO Offset is aligned to the BAR size and use
   something like:

    *bar_offset_out = (tdisp_pa) % pci_resource_len(pdev, bar_index);
    ipa = pci_resource_start(pdev, bar_index) + *bar_offset_out;
    if (size + *bar_offset_out > pci_resource_len(pdev, bar_index))
        return -EINVAL;
    tsm_call_to_validate(pdev, ipa, pa, size)

2) Require the TSM to convert the offest'd PA to the IPA:

    tsm_call_to_convert(pdev, pa, size, &ipa);

    if (ipa < pci_resource_start(pdev, bar_index) ||
        ipa >= pci_resource_end(pdev, bar_index) ||
        (ipa + size) > pci_resource_end(pdev, bar_index))
	return -EINVAL;

    *bar_offset_out = ipa -  pci_resource_start(pdev, bar_index);

Then the generic code builds a map of what parts of the BAR are secure
and what are not.

If it can't do either the TSM is unusable by Linux.

Jason

