Return-Path: <linux-kernel+bounces-810352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C416DB51927
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84122487366
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA2324B0A;
	Wed, 10 Sep 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="grNxo9uf"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C55322748
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514075; cv=none; b=VjRBTWwDFmaWKVrQFJyboVMaAvUBYwJ5ieFd/17YH8Z0QIrj8XL1WaAy61bhj3MC/UMplzjZR9zZZTy8yJTqMrGBxGBv9QMdvYIlzznXzc1v1Mbbaua6ul2XT9xBea7RCXncBJyCqskBgIhpYXPxhLjicFU71VAHhVdRy1ocV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514075; c=relaxed/simple;
	bh=LNKhKhA6C3nXEhiScX2h3yeOP0cYoVecRbWOHC2eAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyYZxlPrpJSFKC2rqDNS0dqxd0dJFO8xUughoHn5iIwZ0fjD+iDCrtCdqSK+41OUrdACywIVrYH2qTIICaLDEJOFuF2buys2+A28c+h0poBo11P37QEP4ECsL/xKOrbg01lUDCxQGg2sONsXdbfoq0raE/1n+DbgaugiebDJiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=grNxo9uf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8127215a4c6so70638985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757514072; x=1758118872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNKhKhA6C3nXEhiScX2h3yeOP0cYoVecRbWOHC2eAUU=;
        b=grNxo9ufehAhRM21/3rKfugBp1loIxWsplX3mJwKGeH/6mXW1Pb/F5wW/uQIlZKUsS
         dm7/pp9eo7XEMslQyRdNb/H0r5Mlade3+0EIh60jIjtvvGOp1rc6Rdtv53MtAhCuPBRL
         E/5jjvn51wwQc69OyTjGcbDboAHiDpJXowFLiGaVYs1Lqvq8+7faFUy6qxQULUj8jtOI
         yAJr0UdHfS1qPBzCV3kw+tGue8MP/zQ4btnveecyWACi57qfyx1LrzbC042t5jlhbDjS
         dZaiiqkZbAy10GDaKv2z23Zqp+ugiqJDuLRmMmwKidQRwPMj3Oi0opM+ivGpONnBToGU
         XpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514072; x=1758118872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNKhKhA6C3nXEhiScX2h3yeOP0cYoVecRbWOHC2eAUU=;
        b=bu/RH1ENOQ+mYyu4SlUFlc+dQlN5HAnQ6eGBv8WlTS7bPY5WrAyiXnpoYm22lSBZA9
         GbSIjCsN+2MHZjs79qXuCksvnQ5XvJYmmN4/pkweZ4gB0A9QRA6iRycYFZVSbVZw+Tay
         aetRlvBK1NEXte1FOygwW6mAfVLgRE9yYhAn8H8zXIgXqrXloPRrQhG8KsqiUYrG5ebT
         w214YeSJhefJqi57hLFGo11yuWY9UhVUcC1IeEfSWGqLqc4AsPNLQSWG2k7ls1ZVaOmx
         2qy5wS4ciJ9rZHdjebUrKIsS+c6lOmuYYMLPYPmIVcZ3pveUWottdahm+vIJR4NZQFQd
         doGw==
X-Forwarded-Encrypted: i=1; AJvYcCWAKpj+lJJ4HOTgpcQyia7csvf7OxXuT8IUN78dmZr6qdkIi9DS9I8Jkbq89OARtVH/ierDzMd26HQpWhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+J2F4RqgpAR4S0WtvhioPrGhr5NbgSeaL223V21bXlJpXTqh
	O8V1WFgGOiEfovsQY+k0wQPQhSuwE53IM1lmYUKs2dtMbPOSN3AL+Xe7qq7weBpw0ok=
X-Gm-Gg: ASbGncs+Ly1m5rK/xOK5NG+PUHZtQMcnZBUObVGkf/DNGnZjYpXbn9ruznGSijXTrKs
	4ysAkUpsp0Cj8dwIEUi7aNJVNRIdJ7Bt0tIicoQpgD3/5yVZf2tGQDTCUt5eO5LtDPZHGHwQGYX
	pWo6UqqhgKjKQns2Iot7NmfCUOeVSIhgQfVUPUxsU3wGdnrOqSX/uuLj29H2HpHk/EM3WROQYqn
	MJzL3uyemRNiXYTKFzpIZT2lQeui+mMVy8rqg+uZQxGb8SlCaPJtAzgXnMKYehBFJdWNXQnx13Y
	k6qCXXHpacLG5r1u14cYWlmIJHf3YzKpvVEdUCZJWuHxnsd2SGAIcoiqo66DNLLR45lxvET95aH
	C97oaGyiH5lIHDJy0eRRxz8k2Ipbd5x4r/nRygnfyMKfmCwuAIUEWL+LZDyMISm7cEv7r
X-Google-Smtp-Source: AGHT+IFQUqXdlLFuZHw73Bg4VN3PcnM2gIuoqeeTT9gq8x5We6/aliAOx3fJNb9QKgrD/fgUoao2tw==
X-Received: by 2002:a05:620a:4054:b0:7f2:8bef:93c8 with SMTP id af79cd13be357-813c443dcbdmr1375146585a.40.1757514072083;
        Wed, 10 Sep 2025 07:21:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ed732f1sm299020385a.49.2025.09.10.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:21:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwLh8-00000003roy-2q61;
	Wed, 10 Sep 2025 11:21:10 -0300
Date: Wed, 10 Sep 2025 11:21:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arto Merilainen <amerilainen@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Message-ID: <20250910142110.GE882933@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>

On Wed, Sep 10, 2025 at 08:47:43AM +0300, Arto Merilainen wrote:
> This creates a tricky problem given that RSI_VDEV_VALIDATE_MAPPING requires
> both the ipa_base and pa_base which should correspond to the same location.
> In above scenario, the PA of the first range would correspond to the BAR
> base whereas the second range would correspond to a location residing after
> the MSI-X table.

This seems like a defect in the RSI_VDEV_VALIDATE_MAPPING - it should
be able to consume the same format of data that the tdisp report emits
to validate it.

From a kernel side we also should be careful that the driver isn't
tricked into mapping MMIO that is not secure when it should
be. Presumably all the default io access functions should demand
secure memory in T=1 mode, and special ones like the MSI-X code would
have some special version to accept either?

Jason

