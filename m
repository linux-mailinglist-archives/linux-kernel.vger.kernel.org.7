Return-Path: <linux-kernel+bounces-752422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3355B1755A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E73BDD39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78523E32D;
	Thu, 31 Jul 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UXoudAL5"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9423AB85
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981081; cv=none; b=kr/fMd87McK+AmBQEscnRa8JtdH4sfJpawMjh44FT2eZU/UNECdCBFPTjXlIjCnsofstMr3mbhyblLrrpQAWpz/3jr8FpCRANbsQvkstEy3q/QSf+G+XJ5tQS/QvlP4ukPLm/k0a4zKlWsdalal+tIJFvMKksGkB7IwueuVz7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981081; c=relaxed/simple;
	bh=sYmx/wQQxsT0OJ4i5ILgxPjIEHTJZkdf4b3yA/YfuDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7iSEE2LvGRTBW30ca7/IVC+d9YNKNGTjwfY6jnCIhNrdTf3MaDL7xCQTwK1prRwv1J/yICjfuIk5u/iL4GzrmbSoQBN8Xwiyx9vRE+cT1cqsu5I8edQmAZ+aPlWG3TcVqozt6i2c6Lhnmbve3XgAlqHbuI4KiYQjTe4LkdsTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UXoudAL5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e1f3b95449so271862585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753981079; x=1754585879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jr6COAzZQd1YZD6Knd07jyj5Q1nEe5SAc40WyTUG0tI=;
        b=UXoudAL5HkawRPc2EuVOyoZphR7+9SUYDJ2oTIInNZU6Y8/fcdZaK1qztaUPnGsOHw
         fJMElSi/ElDMpUHkvFlXDYn9+5eeTCVHdkK3h1Dfs6wXHp+iLXOIB75/Pij52S+WonwP
         V60i54XLBrwXaEBIC+tenCnqqaB89+R35Tg+hw8Bwg7Id4q708ysz12ExSuIMvJ7TEes
         PvdCVPXInb3LQEosxpRsIoGyKfLpgY1GRe6ktYpg44jXOOq6zPtHxdHhsPQg4Mn9wdfQ
         RcORPP0hGgmBkP2A4EoayrsFQVjf49RIXFffFzLsbRL/R2UQFQag0AYrp1WBF6L4YVYA
         1k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981079; x=1754585879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr6COAzZQd1YZD6Knd07jyj5Q1nEe5SAc40WyTUG0tI=;
        b=i37Z0zozH1R66s7NKm6UQ05BHd9dTdp4y/i/A6Ora9m8Dka7NcBwBJflS3gmAKeKGJ
         DMVrlVEagKG80/pZVl1a+T7zMzyubBtctRt5nwomxFv6K3YXX7KEF97fCPIeeomMb1fq
         iGgRFPBg2AfCxZp2fpLqZdLDcigC4F45HbNQr3rM9P9phtoTuW5uVtHsuB2PaMXs532H
         UZkrBxwpeyW0cn4njc8o0Qphe5+k60KLc9sOr7+9pEt9gu1cgmP/UT3B9dwC3VW5jeqh
         aWILueRxwIz+x1FL0l7X66IqYrdXtSjSxvT1YI4U6i8lCng1ekrGE/h9rKxfVFqzRTNq
         5hVA==
X-Gm-Message-State: AOJu0YyjiCI0jb1sd/C6SvLSAAAqjJG5qAGDpRy22flTvA3wXaLqgInR
	8tBWlwcTxXuzqCcnr5y1vIyC/DHATPy/Y73YZKdZBnbuI+DHn5LngiEi/jKR00p+EME=
X-Gm-Gg: ASbGncsbxODh6d1ZWNJpYdove8d1YLjoKe8Acpr3O47uQlejvDnZlAlrMldQdx5dqsc
	+nVAsJCTuLcvGc/5aHuSzg4ZSspdrt8HDAGdGr2wtgYnpu6U6hOnoGZCgEjQOQiV/Pxn9qLi8pe
	oFp5AvpM+h18AQtQqHFaXQwgx8AJUDaUhvQUQNsBOFfcWnMjGtpF2E0bmJxciqDto3eYgUKK5P7
	D9lED/pgFTPbs4d2wpjZSMctnf2wohgnPOvGShfMp0bPUD0i+QSRRZ/Uf0ROOzM4dHBZH7s+28P
	K66CipnVQzSWyY8nfkPjtIRBJUrvYMm4M4vgvViALOQ7lZGi8ch+i4VxWmLTyIUDT7sVscYJ9ty
	LtFRhnVwk1qJ6xLx3e/ysGGktX/6+SsGyj655LIq6a3hQMg/1CVpW2SPJovj1q/kSUAx+
X-Google-Smtp-Source: AGHT+IF0HcZH8FVBmKJ4GmjA2mzyAVblpZ7PRNdTI+fWx8fAyi9WQRlG7UaDpDQUTKMH5yyVV73AIA==
X-Received: by 2002:a05:620a:4515:b0:7e0:a51a:b393 with SMTP id af79cd13be357-7e68128ccb4mr331058485a.7.1753981078536;
        Thu, 31 Jul 2025 09:57:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f706406sm105256385a.49.2025.07.31.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:57:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhWbN-00000000qFA-1y2m;
	Thu, 31 Jul 2025 13:57:57 -0300
Date: Thu, 31 Jul 2025 13:57:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250731165757.GZ26511@ziepe.ca>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIt67bOzp6XS_yO-@google.com>

On Thu, Jul 31, 2025 at 02:17:17PM +0000, Mostafa Saleh wrote:
> On Wed, Jul 30, 2025 at 01:47:52PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 30, 2025 at 03:07:14PM +0000, Mostafa Saleh wrote:
> > > On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > > > > Register the SMMUv3 through IOMMU ops, that only support identity
> > > > > domains. This allows the driver to know which device are currently used
> > > > > to properly enable/disable then.
> > > > > 
> > > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > > ---
> > > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> > > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > > 
> > > > Can you split the new iommu subysstem driver out please? I think I
> > > > asked this before.
> > > 
> > > Sorry, maybe I misunderstood, do you mean split this patch into multiple
> > > patches or split all KVM SMMUv3 driver out of this series?
> > 
> > Yes the latter, the iommu driver introduction is best as its own
> > series
> 
> I thought about that but I was worried the maintainers wouldn't like
> introducing the infrastructure first in the hypervisor without a user.
> I am open to split this, but let’s see what they think.

You can merge both series at the same time

> Makes sense, from the kernel point of view it will be attached to
> identity/blocking domains, but the hypervisor api is just enable/disable HVC
> as it doesn’t know what is a domain. If terminology is really a problem,
> I can make it one hypercall as “set_state” with on/off or identity/blocking

I would call it set_state with states IDENTITY/BLOCKING. That is
clear. enable/disable is ambiguous.

> TBH, I am not sure what hardware does that. So, another option is to fail
> gracefully if RMR exists (which falls back to the current driver) and then
> pKVM would run with DMA isolation, which is the status quo.

iGPUs either access the DRAM through the iommu or they use some OS
invisible side band channel.

The ones that use the iommu have this quirk.

> They are not random, as part of this series the SMMUv3 driver is split
> where some of the code goes to “arm-smmu-v3-common.c” which is used by
> both drivers, this reduces a lot of duplication.

I find it very confusing.

It made sense to factor some of the code out so that pKVM can have
it's own smmv3 HW driver, sure.

But I don't understand why a paravirtualized iommu driver for pKVM has
any relation to smmuv3. Shouldn't it just be calling some hypercalls
to set IDENTITY/BLOCKING?

> I am not sure if we need get_resv_regions, maybe it's useful for sysfs
> "/sys/kernel/iommu_groups/reserved_regions"? I will double check.

It is important to get this info from the FW..

Jason

