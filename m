Return-Path: <linux-kernel+bounces-806126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A6B4922F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39B23A80A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269430C615;
	Mon,  8 Sep 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EJtuECkx"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29D2F3C28
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343530; cv=none; b=gsmSlZQzBxhBghFeQ9SVk2Y9xtanLI3v8m/iKi6v3xhZXwSheE0xVRV81eGEBXtNMyPilH3sQWMChUjXEwwi3Zr9B8UmCLxXM7/NyvYMiUZjVIBUW0IhDELEnWAenVVt1XJLAfAZl94+vqXN4qvwGYH9fGjvtFjlWFNtBj8QKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343530; c=relaxed/simple;
	bh=qD6rSVIGRWAFJh5ZP8autyVxm6mFsWrg8RVJ2pRgD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgoVALb2QdeEbtu4ncxRHlMW+yLb+ZeGGwJwQs6QFZxGXi6QqkrIps8Yf+h/s6puoThjSEo5JjXzKwfmpCTOH0liq0f/SCcVjPNLdtbN6laovwXezYEQDCvAMU4ErOogIEmW2QarCWDiup4T6sRTpgxPNrTAjc/jk6g7DjK8hfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EJtuECkx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b490287648so77566151cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757343527; x=1757948327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=At5jIJoawR6VKU81ZFaZespdUJb3hi00zL5H+qR/XdY=;
        b=EJtuECkx5y0uAgmJKO+ebJd/tBhKN2tp2DcBlhIbsY5ddMmsvBDviKGjKrDL4i1YuD
         OVdXdDHipD6LslNb7HfJbozdlalaq7jmhme4m1fmzJaxLLWOsER2LPBcuUPzQeRnhBq+
         8bD9asTxLBssRSSp6NvNyLwQmGF3JFMyLJJeZ1k6uc3VQQ4X0Rkx4FfbBCCFjW28woAW
         kHVcy/CMemv7mb/5u537cl/1Ppt745qxi+jXgYRBvJnLQ/E85Z5TxTF9Y/EL7m5z0f0k
         Svjrjs4htnwXoq4IV6kXziUWCkbtn7yqmQPvMPJvPgP9DjkPHzpW4HQrCBzP25+0lPOn
         HBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343527; x=1757948327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At5jIJoawR6VKU81ZFaZespdUJb3hi00zL5H+qR/XdY=;
        b=Wft5bSgpPu8TqpsgfDdnxmd1rIV0zFlteHyBaWJ0E8BFeBFwtv4MstM98LrlUO4VcW
         XRhkDKLetyab2egitIqlBjbknovmUADFtJgVFrU64YhJTA+ZPYSE32voCae0Py0eioRi
         mQx2MsLPPgvZiHtnhFWCtIIQMmDS77GPZmlP9XCsQ2u9Ob35Fl56+HHukbwYfs6pk8p9
         AW6rDed6TJVfewcTW12DyE1RGZQulfRXjbrWb7tV+S/z6oswaUo+vV4yQw2iGy7QwdRf
         CPX4capBCOByB10GQ7bzOdj+Ckw+y402uuP0AilICHQCs79NDIhUs/l6z55PgZAKei1i
         ozBA==
X-Forwarded-Encrypted: i=1; AJvYcCX2DBDl44E1J5rke76kUZghJA7feuE/6wGQEhc1Eruwjz6fcv8O6lScsCY4hYvbF6CKw90kMAYrZwuCiS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKNG71Eo+vmFIr9d+RFN0Fr4lvgKMhOMiHNo7zKvsjyAB4kJk
	kPwnzXIMn/z2nX7Gy0lfJTvYxJccrIOUw/cpjis0TOls7Iv4oKx0cKy7WdU3LrJwx7c=
X-Gm-Gg: ASbGncvjje4uwk4PtSWWmubg0eskhoV5EfoWnzRPBcJUpwL0CMf4u0zL7H7Ip6363Y/
	8UcTbuQE1e2ZHXP9KMsDw485k3/qDYCvREyUEkRVBp6d2V+bcJGSG3Aqqy/B+VzzvnlsrvgQKSP
	4FLngilLAtG19e5p4leqpsUvwjfevCa5kW3uRSLszXM0ZhI2AUhQNYkaV/rztwovEZ/T9MEWSE2
	TAx3TCm26hqsc7n9iIgPsE37JvYtoBjpC6o/mA2j5Y8x9mnzi825kdS/uCpJx+//evRG4qeJPFy
	XozvPTA/lx4kHaq9n+j9ZdAVc3TIm6oCeQrkVMVOwmXZfBE5wq5Hh6vWnKUOd7u9XXca2brsA1+
	XSNpltbxkntOv4TQBOEHk5l189E/LFRu8sz0210F4DAO4Mn9mKEU4rw+wi3h6kSsRArcA9vJrQF
	rH0fc=
X-Google-Smtp-Source: AGHT+IFTREWXmNkCHrDWnxjbQBowejD+m7z5dZM3VJ/Oa0MlcqknU/2nQMhyme6Bl98HvCKinECwig==
X-Received: by 2002:a05:622a:2486:b0:4b3:940:e41d with SMTP id d75a77b69052e-4b5f847f8acmr78181031cf.69.1757343527463;
        Mon, 08 Sep 2025 07:58:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cbc78sm125532986d6.23.2025.09.08.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:58:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uvdKP-00000003IyI-35cn;
	Mon, 08 Sep 2025 11:58:45 -0300
Date: Mon, 8 Sep 2025 11:58:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org,
	steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <20250908145845.GA699673@ziepe.ca>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
 <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>

On Mon, Sep 08, 2025 at 02:47:21PM +0100, Suzuki K Poulose wrote:
> On 08/09/2025 12:40, Catalin Marinas wrote:
> > On Mon, Sep 08, 2025 at 03:07:00PM +0530, Aneesh Kumar K.V wrote:
> > > Catalin Marinas <catalin.marinas@arm.com> writes:
> > > > On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > > > When running with private memory guests, the guest kernel must allocate
> > > > > memory with specific constraints when sharing it with the hypervisor.
> > > > > 
> > > > > These shared memory buffers are also accessed by the host kernel, which
> > > > > means they must be aligned to the host kernel's page size.
> > > > 
> > > > So this is the case where the guest page size is smaller than the host
> > > > one. Just trying to understand what would go wrong if we don't do
> > > > anything here. Let's say the guest uses 4K pages and the host a 64K
> > > > pages. Within a 64K range, only a 4K is shared/decrypted. If the host
> > > > does not explicitly access the other 60K around the shared 4K, can
> > > > anything still go wrong? Is the hardware ok with speculative loads from
> > > > non-shared ranges?
> > > 
> > > With features like guest_memfd, the goal is to explicitly prevent the
> > > host from mapping private memory, rather than relying on the host to
> > > avoid accessing those regions.
> > 
> > Yes, if all the memory is private. At some point the guest will start
> > sharing memory with the host. In theory, the host could map more than it
> > was given access to as long as it doesn't touch the area around the
> > shared range. Not ideal and it may not match the current guest_memfd API
> 
> The kernel may be taught not to touch the area, but it is tricky when
> the shared page gets mapped into the usespace and what it does with it.

But what happes?

The entire reason we have this nasty hyper-restrictive memfd private
memory is beacuse Intel takes a machine check if anything does it
wrong, and that is fatal and can't be handled.

Is ARM like that? I thought ARM had good faults on GPT violation that
could be handled in the same way as a normal page fault?

If ARM has proper faulting then you don't have an issue mapping 64K
into a userspace and just segfaulting the VMM if it does something
wrong.

If not, then sure you need all this unmapping stuff like Intel does :\

> True. The GPC Page Size is going to be 4K. At present the RMM S2 page
> size is fixed to 4K.

A 4k S2 is a pointless thing to do if the VMM is only going to approve
64k shared/private transitions :(

Jason

