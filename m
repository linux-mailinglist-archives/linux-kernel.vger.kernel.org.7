Return-Path: <linux-kernel+bounces-756685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07ABB1B7BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC6B176330
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADE28150A;
	Tue,  5 Aug 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O59ynABA"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C6281357
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408545; cv=none; b=RAVUajk69VXXQzd6+NSNq0tMYuPKTlIRreW+LwG0Z0hcWHBhkO//xGcKk9k1RQOAS7PFckKGTkBIowSs1G1qa6qTJAsapgT4R1qzSjr/eWeRgKKygK8Sxf+XDfQZmQ33R8iOm7TluasAYENmHeEsm4rwoouKu+DsXR4MVlOeu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408545; c=relaxed/simple;
	bh=a4XlgZlbGJ3sRkVR1drtwriay9L4ComlRut5kWFIm1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry8gaxF6gzr1FFO04O/tm6vDX8zqyy1L/rXxCyUDB+TKA0JXa6Hs6PS6oMxOBrXjTd39HF3FFiTAe+uo4rwWC4DWb3oS+UiRy0nOsk3cSVoScqgpKLOak8s1mYlUsTgyzXbxMhlpXc005kD/8UaYbJ/7P7Ed2JQVWqgUW5F5glA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O59ynABA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af14096b9eso46568991cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754408543; x=1755013343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+S5TU1iU+zykGCf9bu6hpucmYtXHh8bdT1E2A37b38=;
        b=O59ynABAp4v0NkR2U+JAB6EMk7xHGjNIItS+fl9yZW4fui/yIAItXMs413kHILSoTV
         aLTDSimH4Is+DEPV+J7rMRxSVwXBQfkFg5H6BhPVP6fLP86QvYJuwk0ZWpjKYhrAKxg9
         TG0jTCYwJ7jyVk2vRuU6vjZ9TRX00WMtaVAkBqdj8u8kTDhMUO5oeKC8l92tonWQPvnF
         nfPjA7AyINHPx9a/LegoBdb1pWGqI5XV0ymFYDH9ctC2ldflPfPKxaZIH4DgVAq0ixvW
         kpDsqPgxDsq+b8woxURklX6AG6aP/2Nbzv5JudoaY2X6WsCq/jOAeXmCDTQj697rWLJe
         u+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408543; x=1755013343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+S5TU1iU+zykGCf9bu6hpucmYtXHh8bdT1E2A37b38=;
        b=mtV6YisjUFjM4OpcL2b3yG32sTnAevuZZu0yaQiG8i0DKZKIc7609RjBz31OyZ1Vot
         TaXHiEqpkDf6YKYR3YKa7FFhJf0UIBuUMXcFvfKEwhgIuF1AAvIi4Hp7MxtbfGcqxkHi
         W57zUMPJVuX6TTn2iS14JZsmuwAIALY1WTyPRoVAnbzWyECVpQIsthyd4x3zlbIKbi4U
         uOb4U1CsiEj8KRIz4UIRVYkYSejSAFduo3Op/hDW08EGZjo8SUn9Yje17kPmA0TAY3j9
         bpGEwW6SwzOnX4dL1x/VEyRh0/3JW2V8ajqGY1uWH9Lym9Wqzx3B3SgYvJEQqGNY5v8z
         URsw==
X-Forwarded-Encrypted: i=1; AJvYcCXjaszLpMivBScySsfkK6AcNw2tKLPyHTJOzOqooezpeTU6YQjKXjQqBdL4MwXYLRRDSoaAcP885HnF35s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw1sVuWJbDwb/cZ7+wnfUtFuNGmNAE2wxSsn5g8xoIla1qSRd
	AUSqHz4JcfCDDY8ZOZfi8jXrTEnjg2FhScyS6VDN7B+T44NmUnkkrLvlBGVL5Sivxao=
X-Gm-Gg: ASbGnctf79Z4kK3XInhNE3slXJrvTGlS6N4pvj7gOfGAgSEHas/VUOK05dJYWL27aB1
	qiwvGM3H2GLJNhWDj/pNtFcZwrShzSxERvkLxoYWF5DlxIXq/xbBi7DHWrsqIjXSYLwwBsrv6cj
	etFp1b/MP2oawg+acXNGiA04YEFTa10nBNfXf8AvMWZG+nH6kTCtwLtPew/KIGD+EXyMj8qopYG
	iQ1dbXTiG2/eTbImA6qlx8beFYQjxrHZ6Y26CSlx3/4TrKmAnpDGswd5GmlMdPpjzb7JTHLbyv9
	97YYFxadZQOSYpzXByzmwQ/LiqSojLv/nQ5QWhA1TFnS0wKP5iLUMOpTVDK+poD0cSGQqyEGqI5
	IXW2I6npnFnxR1LU1qhJrc4OJBmBnCwEdgo2uC0LfrkjJNIFWBb7YVBvhDjhD83/NRUEU
X-Google-Smtp-Source: AGHT+IELNrIMqnerJkL1A0WsqSjDCP2vRHWDCNTCx480e/QMCD91vV4yAiss3qzKjBGdBblt5Jsn4Q==
X-Received: by 2002:a05:622a:4107:b0:4ab:6d49:eb59 with SMTP id d75a77b69052e-4af10954c24mr187961691cf.5.1754408543089;
        Tue, 05 Aug 2025 08:42:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeedb2b7asm66390101cf.46.2025.08.05.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:42:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujJny-00000001YZf-0BVr;
	Tue, 05 Aug 2025 12:42:22 -0300
Date: Tue, 5 Aug 2025 12:42:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
Message-ID: <20250805154222.GS26511@ziepe.ca>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
 <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>

On Mon, Aug 04, 2025 at 11:56:53AM +0300, Abdiel Janulgue wrote:
> Hi,
> 
> On 24/07/2025 08:40, Alexandre Courbot wrote:
> > 
> > I see a few issues with the `Item` type here.
> > 
> > The first one is that `Page` can only be created by allocating a new
> > page from scratch using `Page::alloc_page`. This doesn't cover the cases
> > where we want to map memory that is now allocated through this
> > mechanism, e.g. when mapping a `VVec`. So I think we have no choice but
> > return `*mut bindings::page`s.
> > 
> Just commenting on this bit, still going through the others one by one.
> Anyways, there is already existing code I'm working on that should be able
> to extend Page that are not allocated by it's constructor (e.g. those coming
> from vmalloc_to_page). I think's it's safe at least to not expose the raw
> pointers here if we can? Just a thought.

I would try not to expose vmalloc_to_page() to safe rust.

alloc_page() at least gives you a refcounted page with a sensible
refcount based lifecycle, vmalloc_to_page() gives you something that
is not refcountable at all and has a lifetime bound to the vmalloc.

They may both be struct page in C but for rust they have very
different rules and probably types.

If you want kmalloc/vmalloc to get into a scatterlist you should have
APIs to go directly from void * and into the scatterlist, and also
link the scatterlist to the lifetime of the original allocation.

Jason

