Return-Path: <linux-kernel+bounces-848313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C43BCD604
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62A1C4E1438
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21525A2DA;
	Fri, 10 Oct 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kFWqS+QV"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D326A1BE
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104767; cv=none; b=j8gB2KXD7hRwtqFDxMAXWOY4++R5RvcOsGWyHCGfR1GABGyPnSmgYb9Jp8wugyokutEHb94Xja08yzB537fviCt2NcImvPjUShyjTic2LtCf0Wd0rnEsdJazFdh2XH8bs7OmvEOFm0kk1XqQTKDOOp1OQijOJLIOk9tVD80F3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104767; c=relaxed/simple;
	bh=hZPZVS2QtrtI/5LeWNnPEpjPSsnogRA4qP9cGK1n1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqtPAlbf8HiMiURIUW5SX6hzWSzuZaMu1id68XATfIPNPO6OEwLaDRhFOSGsNvn6uIgmhyXjIp6dKxNYW+UZHZxmLzLtDix7FS/m2oaxiDX2gMRgcYxyskrCDcIZBrniMJaIk99vM2JnDQozgocfaS29eohjRkD+LksdpJ5YKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kFWqS+QV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-85e76e886a0so186291485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760104765; x=1760709565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNvJ31G0uSRPH3SSYUmcqBJNw8nBZA0aR9UpQ5R7KAM=;
        b=kFWqS+QVbA0HW6ZrpNPV8fF8hLlUwyQ5X7X1ErBcreVmJ9cwGiWYdlaQ71hgyJCTmq
         yUynLNJffYZJi5yyuBN5fYSXbhn1WTEruZ9LhTyl7zd7F1FTh5Z3lo+nM5yB9czVFOOM
         mA1xexk3En/XglDuDGEUR3p3gKaDYRkpqG0WZo1sLtMW+BCjihvxmg6qDy7CQK8JM2mc
         22j6Y8OrYmW1HKeaQ522WZ149rhZlwsvmysakuiDOeDpZDRGdcSPHssnho9/B4PSOiYd
         qfCdFvnOskQ7n+fmxpN8O1tsGJNxevpdcxKbBzytMAboV7gW8qK7n8Nfy3m2I3473GlI
         2RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760104765; x=1760709565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNvJ31G0uSRPH3SSYUmcqBJNw8nBZA0aR9UpQ5R7KAM=;
        b=NrEAs6mmiyAn8q6TtuSDNhXPOaf0RrJCe7Ag/XPW7o/VKlF6kuDxXkBFSgUD8zB5LR
         3bvUd9nyDYpjXhKK2PLTO6LsgcCqa3C632S5veFqHB61xVsHPvxtwo/X95nmTrxwi6bl
         r8swiNwpvajVjiJmtwTs5K0QFZwsXeZ0y3bh0sMaWj9InF+bzEMqtDA0LcRQscAiueNk
         SaFWogsz6SpF0dueezuUXiGWKO2RLWo4YI8JmhW56GJn7y4JQIhc5A4IYG5gukGwWHuF
         Lk28pKuhRxhzec7KwAc0RxhNm/Yrk5eJWmjUyuStIpNGsB0opQP0uMhxNQVg7YFC/yIH
         kl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbxTnnM9VKPiQeOODeR8s4hjHGbjJjU+9jgdWuGIhocp7nq9x7oxZZjGjmqG2I9Hd2+5c6fXoy25eQMR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJH1dJBPaTX7oTkv5yT7qyLo2sQnbKkAoeWK53fmEt0RgQxOv
	S4yhWzO3yk5Ew6zBSR9GZfKKf3gKq1YuJ0LX26l7aYikvDk6mM5Au9NG14Gp1G4Mp2Y=
X-Gm-Gg: ASbGncvso8ZYyzIcEGM2gpAgIaz3wW9jpcx/p4zl5o+7TBVJSsBcIgQMajzlu7kOa40
	zN1nuhfpVoWdk7wzxQSmZrUzrDjV52jg64qZeP4vTkfrS/ChPokKM+RKS+Sq90OItwZAdpavpin
	A3LTIUZXPNJhUz+V0J8qEwdV7lHQhgR/Tzq4xovd/cZns09UUWc510OWxaCEYgPqjSJAW3FFjw1
	VG4S+UeCsnvagpL9zC58DyHPlYiCxFPyyNdjgx+JZlxnpYqOFpAYjOpy7rmgY8k/s811QJkLXcv
	p35ktoFCMB4U7aE6Dq3RhGYw1Jyw7bUKlkmI9fqERy/eQjTwEdSrjHeibe0oNrcFJpAQjK7oTAD
	apdg/JDrprLFVU7c27iUsNlfC6nNfr2RQgSs0mA9hc1ODc1xhrt0CT6rUOLLkfouYk0caWnnuIm
	qF/QrLl6cgtTyZ5DRu+uFkAg==
X-Google-Smtp-Source: AGHT+IExPwaL1TTGwP76ooAIbGqIBucYWqZgImMdJPw3egaQEtYFbCr/oHIOKZgGp1qijtOpyq8L8A==
X-Received: by 2002:a05:620a:414f:b0:86f:4009:dea6 with SMTP id af79cd13be357-883527c7719mr1533083385a.59.1760104764491;
        Fri, 10 Oct 2025 06:59:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a293bcbasm413337685a.58.2025.10.10.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:59:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7DeU-0000000GVew-44jV;
	Fri, 10 Oct 2025 10:59:22 -0300
Date: Fri, 10 Oct 2025 10:59:22 -0300
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
Message-ID: <20251010135922.GC3833649@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>

On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
> > Yes, use faux_device if you need/want a struct device to represent
> > something in the tree and it does NOT have any real platform resources
> > behind it.  That's explicitly what it was designed for.
> 
> Right, but this code is intended to trigger the kmod/userspace module
> loader.

Faux devices are not intended to be bound, it says so right on the label:

 * A "simple" faux bus that allows devices to be created and added
 * automatically to it.  This is to be used whenever you need to create a
 * device that is not associated with any "real" system resources, and do
 * not want to have to deal with a bus/driver binding logic.  It is
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
 * intended to be very simple, with only a create and a destroy function
 * available.

auxiliary_device is quite similar to faux except it is intended to be
bound to drivers, supports module autoloading and so on.

What you have here is the platform firmware provides the ARM SMC
(Secure Monitor Call Calling Convention) interface which is a generic
function call multiplexer between the OS and ARM firmware.

Then we have things like the TSM subsystem that want to load a driver
to use calls over SMC if the underlying platform firmware supports the
RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
RSI call group over SMC that autobinds when the RSI call group is
detected when the SMC is first discovered.

So you could use auxiliary_device, you'd consider SMC itself to be the
shared HW block and all the auxiliary drivers are per-subsystem
aspects of that shared SMC interface. It is not a terrible fit for
what it was intended for at least.

Jason

