Return-Path: <linux-kernel+bounces-756710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2949EB1B80F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8171637A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83346292B4D;
	Tue,  5 Aug 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QoCjH9aB"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A4291C36
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410238; cv=none; b=Xwv0MfjNbJYB9l6xoe0zQf5huP+Wn4eCbV0giRC8R6CYuRoCGUh5madfn86f9wz2/4Fkjvk5kWb+DGFr4wCeMRo+5/NczRwkYXPOD0QeN57z8XDissHynv9icvMZjxRve8REhfuGeHsmMZcCfRmEPHZSJcqMBSh1TEZotlO5EMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410238; c=relaxed/simple;
	bh=MSerwvz14RWslmARCsAjgCCXLaUZEmefMPtv/CC0p44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi8n+jQTn3hGcmIIaOpLmG5ETV68msIyampqYSMryTs+bhvbm0szULRHgm1cgWP8RslYvYoqsecyzqb3cfd265uzzDiXsc0JaXmVqtVwZNFMhj8Pn/t8BNF49D7QnZDqnBNbnRbgnuq2Q9APtQ4Ua5eVV7EEA8iYxLRSMa+F9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QoCjH9aB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e2c1dc6567so283164985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754410236; x=1755015036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUQiiaWDlCWs+LVMgQEGU5eYzs+NIuuvY+XiZIK97rA=;
        b=QoCjH9aBzpjS6eWkvUofOeOs7IYtg/kBnNyddWH28bCfpvuah9x4DshFkY3I14gVax
         2lPSpsacVWmcEERj0mmAQgOE8dlCeRLC1+kyNw+zltB9qFmD9mxkLzJeL+WLAvOEfOzj
         u2vZdJgOPn6XTfADGp/ouoMx+bBt/DmhhZD329jIMCOltfIdujG0zOxMTebt1Mube6/n
         evvv9HLce+usE4S9gnzqQ6BvO25Lv5Kze/T0F/R1VioFq9HwqhHEVpRpGE62DtBxLC0V
         SxLIxAMr80A3Okw/d78WQBPhoDwkZwvKW9xVvnZs7XJvVOqpuRXSBAmp7h5+LIE7Z7Rq
         VlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410236; x=1755015036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUQiiaWDlCWs+LVMgQEGU5eYzs+NIuuvY+XiZIK97rA=;
        b=tR7gEEM+EWdjFaUWFadxUJb4iGpMfU+Vi/QZzH0FXwb/CEBUJ9g78xvVd3j1i7VAZl
         DdGbqMGHfhho5HyYFpebOsLjr9/1ia9vVAXfMEQk92sdAI75IsuVYJq6LPGNeTtJDTGh
         oSg/R9lLIgOi5kDv6G3MXW7zXPZ5coyG/gnf59lG5NNIL0e/jxvIIibpyrraPdqzlmVn
         6QXV9BapnaXM/gOgrh5Y1eovQpSlq8DJ8ksFtbUZufcyR6BA1LVLOMEqLRatL1Koeo2v
         YR7UodXBFRvyFYnVTA3FuNMM4JEzf4fLfE0bpFjhNg3Eph1pJGHrPFyu5Ofco/dtKYjy
         IaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbM3Pe0zGHmMIcZ3svwgm+3HVjY44TM3sUnkpcbJsWd2i88Ot9aa7s9JMkuonH38sYjPOtQtbXvJeg/Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhxAFmd/dSF4laHE+ArhS/NMOv6OrfrnLJiw/UpQ3wFQ3FPlK
	XZ1r0nFf2o8vJh9J0xPFCYKHCG2rotCUqpdeKsSCQyHwWeSTEPCsarSnusS6ckUHdYQ=
X-Gm-Gg: ASbGncsowC9rtVuWDISJFcqmB/4QYI4F+7Y+bF+h5bwO9mN8qNXRy1cXyJDZZHbkDbP
	kzW/xXgubiYZHH0dqYb95wqbvn4jpGIATamDLd7P+KwDAYdiHjZ3QLd8Q8bQPZwAZpUTOReLlWb
	TcxjsWNIdwp7NXGwCxBY8iO26/krJ+dsMah7vXNnakXcPreRbt1NEl0KaXiMzELSUAYGSrMgwpj
	SLpbtHe5CP0AFW2a9XLjTDMl5SiYIAGU1su4GWtLo1kSjvSyaJE8yLsBz4goNedQNIWXNP0tXMj
	wqANhp2pjx1AiMS+KyLDgjKn6ACS77vDoBMLAa/2TBuYgLhmk66UIo8aSPXTqy/VduDfq4kK4pv
	d8zYSB+IWrdQcuA7oL3jF8tNZ4X8K3YbnXZ3s3qJvY+A1rUcueScT+CfTe4eUQmV+TIp7RG3IWL
	DHv6w=
X-Google-Smtp-Source: AGHT+IEjj+v1rIgRJqmyVkBhYcdet0WfxL50iTtkAjLR8rDt3iZUkWBN7QnPGs1X6WJS44VAtI66Gw==
X-Received: by 2002:a05:620a:2649:b0:7e6:252b:9b28 with SMTP id af79cd13be357-7e69636eee2mr1728455785a.33.1754410236229;
        Tue, 05 Aug 2025 09:10:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e69e15f5e0sm369670685a.69.2025.08.05.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:10:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujKFH-00000001YwL-0rt1;
	Tue, 05 Aug 2025 13:10:35 -0300
Date: Tue, 5 Aug 2025 13:10:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <20250805161035.GW26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
 <20250729142917.GF26511@ziepe.ca>
 <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>
 <20250731122217.GR26511@ziepe.ca>
 <aJFrvsURkhpTJgh8@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJFrvsURkhpTJgh8@yilunxu-OptiPlex-7050>

On Tue, Aug 05, 2025 at 10:26:06AM +0800, Xu Yilun wrote:
> > IMHO there is no use case for that, it should arguably be global to
> > the whole kernel.
> 
> I think there are 2 topics here:
> 
> 1. Prevent VFIO mmap
> 2. Prevent /sys/../resource, /dev/mem users
> 
> I assume you are refering to the 2nd, then I agree.

Yes, the region stuff is only about #2.

> > 
> > > The original purpose of this pci_region_request_*() is to prevent
> > > further mmap/read/write against a vfio_cdev FD which would be used
> > 
> > No way, the VFIO internal mmap should be controled by VFIO not by
> 
> I assume your point is never to use more than one request region in the
> same driver to achieve some mutual exclusion. I'm good to it. We could
> switch to some bound flag.

Yes and yes

> > The only thing request region should do is prevent /sys/../resource,
> > /dev/mem users and so on, which is why it can and should be
> > global. Arguably VFIO should always block those things but
> > historically hasn't..
> 
> Agree. So seems no need a global option?

I'd ask Alex if he is OK with a global behavior change to make vfio
exclusive, after any required fixing to make vfio only request the
regions once at driver probe time..

Jason

