Return-Path: <linux-kernel+bounces-748140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620AFB13CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2197E7AA2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13626E149;
	Mon, 28 Jul 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cL6oxSQ1"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DA635
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712226; cv=none; b=i+f7zBKhDwNyTSc2X3DPuVOn6jbfJt8K96kX9YH9Y7z66kpXRvf3sqCfRTNta94qweuv1pOWrpgQL8eHIvmVkrUUPNhcOyuTBWC8BYrUGY4ezeYsAkbVv3ZSX30Nemn2bdvWQb5JFPPJjFaBaRbf+hQ3Z0n37WIpJBVjOiLy65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712226; c=relaxed/simple;
	bh=+sQ9t0gn5L4GrZDYwNd4uW4hApI7Q8x2B8KZ36bnLW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqFtcpH6K+H/SRQ+fVeqRfBSk/MCHsfqKkgcNPi676A3WYtiB5dv1Tcau4rAhkQCDhdoxdLtwR8ZkJzMYZ8NA+sWFLDATSmgRvbVSHhmP6DKpzMNGw7EJG8ywdelUaK5F8Zj6LlPCV/jA5+JS2F/H2oj4AvS/pVg513OuCSvO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cL6oxSQ1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab71ac933eso40336251cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753712223; x=1754317023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sQ9t0gn5L4GrZDYwNd4uW4hApI7Q8x2B8KZ36bnLW8=;
        b=cL6oxSQ1t5M7yyjEyaWjV5UluyYz8UMb+Ee4Qwnc1mp66J1AJVVkXz5ln/RePsbsqp
         s6CKiA32rQlfVpiYxbJouXIBX3Nw02LLiy+FTnYX1povSoBu/o58YSGMYVh/cioK+eVl
         x69oeEg3T9askYPiqTf7S1RyUj+bN25GPgpzD5E9H53CDk50uE6Qtb7M8qGo59aKJxmj
         0s8qtLznK7/QOddMrfV3YuayKhahQoHqIqQ/1VjvQPcfp0up/zuFE8d5Wqc5pb6ozco4
         NU7CbMDVt/c2NQnveC9UEt+aPf7hA/m6QHTFNpduWHmZdwabYqML1lLPsGBWuiK5RKs7
         ajUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712223; x=1754317023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sQ9t0gn5L4GrZDYwNd4uW4hApI7Q8x2B8KZ36bnLW8=;
        b=WUGIMzXU27vVK4lGmnQ+yW2Zoope2gNi7T2BAGHUfhaJ1rQweD2oDdMxuZYC7fVQCT
         nT3p4/4btTiTXUI9RFmtkEeTQMzILNXzs77nUbBCiEfbOXz17DpHE2NXuI2GhCQ4Cm76
         r/SPLq4fFPhmaD+SsbfkJ96QrofMUR4/AOhG9cxN3b2EBUOXspgHw4kcCoFbgP/c6CoW
         pg8TnhC05ThRZXYlPyYYeiK8Qx9H67ZkcnyREM8tT35oFTMSuc0F9jBbsJmKHpOwKCm/
         okBA+9CgYISZ4uWSmua0a9akw56QThA/oYbH/u6/lXdobWdSE14eITghLIPWSuHicOI1
         Q42A==
X-Forwarded-Encrypted: i=1; AJvYcCXFLV0/OdUITwIXffOreUiK2mlgFCeulDuIVIYuvJ4iwLZ3YkVu6g5CEWIvL2PUOxrD5HkawDQlj+q2PQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHD8r8lIT2fdj2nqUDrWQpIS60vNVTbmmzsh8hSWJVwVWdvrW
	fWHV2ytTWUYB/wuWtnmu4Y5ch80Pd1/IwZAgdrKbHrQUJTr7QigFraniRXzKsX++DOE=
X-Gm-Gg: ASbGncswwxabai4hI0yDgsxsEMZUk769qognckXXsQoSafj0gNHmP7yidsssoj0D95s
	8DVoV7HZnpRf7nyCTYdmjv2hrJgorzR5YubgT3B19cCoYDDtBj/91aVhGh5oiyAEQhc1zjNOmq6
	w97XCatlqeto3wefZx1XW14Tu/L2UCHPpxuLPmfdjxbeGIfZ+8ekyLSzEjc4P9p1D1ZfqEdRAWz
	ERAwOPuTHsV1zu8Hrixj1mdRCd6MUgavEPTidMZMmaHZKNrlHr0f7laaCrKnj9Dg7YV4MDlmlXH
	jZBlgs27arTm8vltBOoiSS2OxnSmKF4Rg0m8BWTFq5/hkKBGDAt6txN+l6rr1hFEKZuVi3wrx9h
	FqpzAygAyo+a5FqlP20BmKrKAVmgjn9yXg8g/OocOMza4n2pQtp/6FxE8HOITeZZIHr77
X-Google-Smtp-Source: AGHT+IGJsSVbXjLNIqrlIEbk/gUzNYQYHSbjL32ASxGtiy6zgoFXF/rrvq7tro5LsCceIcXyRKliEg==
X-Received: by 2002:a05:622a:1104:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4ae8ef5c18emr158029941cf.9.1753712222972;
        Mon, 28 Jul 2025 07:17:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99516fcesm35769401cf.9.2025.07.28.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:17:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOez-00000000ATD-3mT3;
	Mon, 28 Jul 2025 11:17:01 -0300
Date: Mon, 28 Jul 2025 11:17:01 -0300
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
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
Message-ID: <20250728141701.GC26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-11-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:47PM +0530, Aneesh Kumar K.V (Arm) wrote:
> With passthrough devices, we need to make sure private memory is
> allocated and assigned to the secure guest before we can issue the DMA.
> For ARM RMM, we only need to map and the secure SMMU management is
> internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
> does the equivalent

I'm not really sure what this is about? It is about getting KVM to pin
all the memory and commit it to the RMM so it can be used for DMA?

But it looks really strange to have an iommufd ioctl that just calls a
KVM function. Feeling this should be a KVM function, or a guestmfd
behavior??

I was kind of thinking it would be nice to have a guestmemfd mode that
was "pinned", meaning the memory is allocated and remains almost
always mapped into the TSM's page tables automatically. VFIO using
guests would set things this way.

Jason

