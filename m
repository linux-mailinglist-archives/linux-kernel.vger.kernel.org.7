Return-Path: <linux-kernel+bounces-848452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50A8BCDCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31064249FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944EC2F9C38;
	Fri, 10 Oct 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DXAUFiAa"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3F237A4F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110255; cv=none; b=VTP/FqwgBpfD3neFeOchjhEyFv9lSx3ze8u/MzQmL4ZJWXIiNyqNDhOjCC9Q1nCHNrMCpZc8qANtA81mDMVqI9+q5QSGXIDtCbV5nmUm6AVZ8QP0Ch4ACgb6G8o+2f1zFVOQdSLIiG1oi0hsRa9tfuCMFRrD7LZRZt6nSHvA3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110255; c=relaxed/simple;
	bh=YweDjybfnRXAUjAFM2cXyTvz7RwWQP0buSdnlIEIdyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb8MeS9gpFSLczs/g9NnIsZnrNbsO4nyWv6HyBhhnaD9yNHRkwlehIQ+gg82vJibtAJuGauG1rMLS01e/gz/HraFmyNI33K/TKn8stgS3TFKWx2iLyQAatAzjb/LiHnxWVFZ7O43l1bgHVUqIMgBLb5oTI+RixGn4+HnDX4FeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DXAUFiAa; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78f75b0a058so22019356d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760110253; x=1760715053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6cOfIK7qdN8qKLRMhM71lR4Nf+xbZ2+eVm4l2+34ic=;
        b=DXAUFiAaDqqCC3+EGPzuTEpjDPpj8TDL6f7/wTX64ElUquDD3fp/hbRxJWl8zAES+j
         +dnCNkHQplC9wAAKmgxpSmQbvK1W3l0d6pcCSq++3xLlrDG3xBD0z+MBSs7B+lPfBr2e
         l1b26laUQRZIYyja9N804pvrD3shemyxPsUCsgTZ6G32QXpa0OSVge6fW51lGfultT96
         IrSsZkYxbnA14n6CqWaAaRM6YSev8Doda2pH6/bEjAM/CKYqaRvpd0Omt9vmbYOd+IjR
         4oE077WohG5cUdFp9gg+ElT6orI4tDRIR5hbzTcsty2mXYEkqL4+4CE5NdzzT1IdtUeW
         KmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110253; x=1760715053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6cOfIK7qdN8qKLRMhM71lR4Nf+xbZ2+eVm4l2+34ic=;
        b=pt5Pv/LNGG2vz3k41elox11vloKmVVHsUygkm4c+haOUSv7wO2YVFfhkP3cFyOm7f5
         IKrNXa2OzZBP4s2tiCUjmKcz5JJGuDQ/UQv/aoBEm/O7EuHgyIe//CoNV9B9tIqHmCNz
         vCyHzuhIttr+mxF3s3OaqHdqBuGYTz0xrEDvIGPl27YGBb7GRhz2KYrlaD1kIMnrAt+n
         Fcn1OLVmgEE/3oLfM7IO/0ojCcU+zfL6k9QpG3q4D0Du0ocSFXJJ2R2W4gTSfKd/dkem
         g+lSlWv9a5idtuTRW3SIyhDnCakZLz8mKkbzEV2py4dIF8A1RPNkMZ/0Mv+UjuQXqLsv
         zLkA==
X-Forwarded-Encrypted: i=1; AJvYcCWuEDMbGO1jD9FrPY74PlBa4198e/BAFEn/inik0BxWY8ddAS/ff01To05/yR8bh4kgRMXbebOy9qEX9/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFISYmwOR/nlijNIOk1Y/OGxyPaGhmHbIKcv+oXMENJ6uF0Vn
	v3UMcmwQsvh5GxCuKIw/KDb/H8zem/QYJFN/qHPFgqiWN93fbMg18gF4HTx2RAX6O8A=
X-Gm-Gg: ASbGncsyWDvHGRFW2cqEA6YAvMK/GPyp3w5wwmhZOyKlnk+glghn0nxvGTzK66GEr+R
	GKNwvqxk6EOkHBYpIG0wOVQjxhYWmEBaQVHO4DRGOzxYv4StOB8x7VA56oQm1sU/jC+sWVnnH60
	29y6K67PEtiY4f//uSWWZskbArLW3GskgfGF4uQO8Bt5LE6lIhmaQ3Azi+LwU04HKq15RNi6kBL
	9AgLLQ8onniLyzZyxdPdqWygSMWdzMbrkdTcTMFgz26RK3bB+gaBU2COlMz5qlmAjUpjaGurDOE
	ZL3DLNUPskrP56k8w3Us16Vu5gUidpTrLDym8d+nk4YmLs04FnrFykwk8J9lpTcJrp6GweDCZZi
	LD/BNAMEUwjuKGLhHeahyRWQ0PCWjCoHrOct5cRNZpY/haEC3YAeY1PwOgtjnhYn+foH7GA2hfI
	5veGWMrk9SzUc=
X-Google-Smtp-Source: AGHT+IGgKhRm3oNF4ALMXNjdHTaNK2zfI9rzl46bTecy6J4CNJ6lSFvDvqcPlarS77J3/CcjSy9rWQ==
X-Received: by 2002:a05:6214:c64:b0:830:5c6d:419 with SMTP id 6a1803df08f44-87b210728c4mr182061246d6.4.1760110247638;
        Fri, 10 Oct 2025 08:30:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc3570c1esm18187826d6.40.2025.10.10.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:30:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7F4w-0000000GWAu-2XWh;
	Fri, 10 Oct 2025 12:30:46 -0300
Date: Fri, 10 Oct 2025 12:30:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20251010153046.GF3833649@ziepe.ca>
References: <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>

On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:

> > So you could use auxiliary_device, you'd consider SMC itself to be the
> > shared HW block and all the auxiliary drivers are per-subsystem
> > aspects of that shared SMC interface. It is not a terrible fit for
> > what it was intended for at least.
> 
> Turns out that changing any of this, will at the moment break systemd's
> confidential vm detection, because they wanted the earliest indicator the
> guest was capable and that turned out to be this platform device.

Having systemd detect a software created platform device sounds
compltely crazy, don't do that. Make a proper sysfs uapi for such a
general idea please.

Jason

