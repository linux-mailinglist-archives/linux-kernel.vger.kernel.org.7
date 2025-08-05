Return-Path: <linux-kernel+bounces-756692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68BB1B7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03D93BEB38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E2C289815;
	Tue,  5 Aug 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nUerZmxj"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CF1C84B8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409272; cv=none; b=VJkBDPr4ziDcq8cd1i/a5bP7nnQ+LjNS6V6LseRPSk4YumgD2kaoZ7VnHEywWYZl+AQoKYmi71Xpio83eLhzgsoxfOKdnE49Mil/G3LS2aBLxbRh7oWaAISi6yjNH2rqxPXScPF0QU2C+oHMP3ZtmLqCP6ITWcgJIMCxmrmsggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409272; c=relaxed/simple;
	bh=/OzaxpwEfK7AcyjcWdiVUrxbZQFVcmCDmajtf4oAfG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+KBZTsbS1gdNHQ9FmaEqmovwIVH3hCTgac0CvO0JBiUmPlREbqSsmR6S6KJgicO9YxOSPQAjKe85qZh3leI0R3g3DgdmTkRUR+4G8p/b63PlhvHgHcNvnTKyKKQo/bLuVChfVXV8GUjQcXFGz5A4r91o4LhPygvq9mmGiG3bx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nUerZmxj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7074a74248dso51210106d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754409270; x=1755014070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qmi6Xyv0QvJ7lU7CctnLT4GD6xbprG8jnHy2E/XWXdI=;
        b=nUerZmxjSMp1DUMwIFFeolXfd8tUy/uWDH40vCEHDy6biYq3FC4U2f19cBCg/BE7Uk
         pLEKZtHAl2euHAMsszm2+cuUpZrB+cSTMj2d+PJcTg28Hejf2Te4aBhbfwhgVytTMT1V
         mJkn8OKA3TB+gvS5uvXEbIgUi8z60iaKcxTTbo8PFuOYRyAw6f9YBTij0Wl89/b6op4D
         xF7cSa/2ndXE6RBUXpoQQo7o/Ezgw+lyLJGyHrgTNKHPp5T+yzf/5gUH1Fhpz39mYxfm
         Nn8m01KmxjY9IUqHIdHJRtCOo1vYbYJy0S909/soMsnvtdCtQzHZgVAOoW8P+Q2x5lrv
         sdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409270; x=1755014070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmi6Xyv0QvJ7lU7CctnLT4GD6xbprG8jnHy2E/XWXdI=;
        b=XuRA2ssZT0nafx+lHRAYq2unihxgLO+uMPZmHuSG1qcu1rPIXrchySucKDK6jAECTP
         rWY4k+qTYSSZoebi+aJ16L+w9EGcg/HDKWbeOWSUmt129LtazR0hc/ZqJpPdAbyqPqxq
         G/G9gCPj4g/z2uncZAX8yIJ4FC7OMvIzivVilDFeH9ODtUe3hAUnBQOgPmBXGAvkH8ca
         iXRpNOp2ey20jdOftItGTI9WfiuDuD+TygSELXcp5/+wOfMHZcEs8S5H710xukUZrC5Q
         g+GmQuS7TkoUKJA1ROiavDAdCKjz7upTTu5FZEE48BwSZ+Rp+gcwhTYnS99emRGayBGb
         SsIw==
X-Forwarded-Encrypted: i=1; AJvYcCWHvEHbdgWEG5/jxVxwQfCckB5hygl+XR8IKRs2EvJ8OLIY4Ph8hNrIp79iBRjH1IqvrCKPtsDbjJUlFOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACE+eftURAyjrzFYuWE7LLYEmo8R9svH0bnogrsU3IGn97ylL
	CJgpFQBV0xPUNf6RxZA//HRNa9bmtE8Lu13RiEB8SsonjwoQTt9qf7MF/Xz8hf9yGp4=
X-Gm-Gg: ASbGncsnVhIldGKzpUM6LXIhNk6MZ4P437yzY5uEzg9IqZksZdwPBV/+38LqYJI2ucX
	SQH5RNBOyTXkntonkAJor/ovkXwfbSWDV8FUSL6l2LoHe+IUZBrrzGd5+vB/Px5TspzDkK/e7Ik
	6nnLifKHa7+7IRRgJxDgD8iXZJ4bGvdfhJ35Bn3/ZkUJVETxzVxz6VeqRGdp71l4+88hooelgmZ
	gI4woQfbh4ANMa/kAa40v7+r2DDCN1wnq2yjXoHu4x9SDDNIQrVdp/v+2YJ+e0FulIWR4jkt2Em
	VVS+1JjSJSrYMQAS7vk4PL8jS310WXvYRgtqJqY0mh21TccjhI7hYQV2KwyXuYnNfpxJZbMyxBW
	l0IesPPpK04rbficEMyVImVpn4Dgf09vXKK5tFlGnRCmHeL7Zx6QyAueIqAku7zTKM6/g
X-Google-Smtp-Source: AGHT+IEbopEuDV++hnxNrBy6jE94j7fNSg5OYfawZGMmOOqA+BK3PuMzmdEKgi6bq4gnWI1YvySFkw==
X-Received: by 2002:a05:6214:2a4c:b0:707:635f:67c3 with SMTP id 6a1803df08f44-70935f79001mr202676776d6.14.1754409269871;
        Tue, 05 Aug 2025 08:54:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce37c01sm73097906d6.79.2025.08.05.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:54:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujJzg-00000001YhL-3W2I;
	Tue, 05 Aug 2025 12:54:28 -0300
Date: Tue, 5 Aug 2025 12:54:28 -0300
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
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250805155428.GU26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
 <yq5aikj69kpn.fsf@kernel.org>
 <20250802134154.GI26511@ziepe.ca>
 <yq5aldnz8teu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aldnz8teu.fsf@kernel.org>

On Mon, Aug 04, 2025 at 12:28:33PM +0530, Aneesh Kumar K.V wrote:
> Note that we don’t update the phys_addr_t to set the top
> bit. For reference:
> 
> 	tlb_addr = slot_addr(pool->start, index) + offset;

This seems unfortunate.

So you end up with the private IPA space having shared pages in it,
so *sometimes* you have to force the unencrypted bit?

Seems to me we should insist the phys_addr is cannonised before
reaching the dma API. Ie that the swiotlb/etc code will set the right
IPA bit.

Jason

