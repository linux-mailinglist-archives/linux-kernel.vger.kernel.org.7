Return-Path: <linux-kernel+bounces-741824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FCB0E960
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75603ADC68
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461D20DD52;
	Wed, 23 Jul 2025 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TdYtpK/j"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683B1E04AD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242927; cv=none; b=izn3Uaoukx6NhkW3/08TEKCOVWOFgO0yOyi/88/9VTBCsjaZmkcWw5cPr2uoNPwzA4n3F5Xd7DcbevxIn5mOvzE/X3Gz4qdt3l2SoprwxoSJz+32CVBbET8bZGHwu/TZgpwTyKp/9+qSBo6bDhMZFOfM8XiMZQugGIwbWcrv5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242927; c=relaxed/simple;
	bh=oQ+IyC0IUpkjFuIs/HtICSp+AEWKOXH6EW1IhNu7Ld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d68hMAtHmOosryAQxgpHE1MDjKAzlts4bLjpD3F3UDfQycTU2gN+jcqD/MNhMMnUcnUf6bheo0bioEsSa1Rtg05Mg/boSV8MKsUOLkwR5OUZFEaleN0CBPbu3EU6zwG9C1V0fHcAigCRBIWPulo0Xmefjx+CQsWI4zxdtSF6n4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TdYtpK/j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234c5b57557so55036245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753242925; x=1753847725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YRcngTOmImRVZlU/kPn2yZwK6WlVIM67jiQ/OO/PWc=;
        b=TdYtpK/ja6XLYd9NQtf//5MQPb8UnwDsEeQi04MnwyhzkkHnxMkfrbhxZmiroOK8cA
         +bFf2kVmWcAGsXNrBrXkEVGlSkqqoFXNXWTSuQHMwdXygEViJ3knoZeFVP6q09z+Bkfc
         hoV+L49dtPDYqojW3nvgod68JLc9U2hyJDhDDHZTfZVBHfNeg/arjRrCaQBuuT0WO1Ro
         XAOOKIyB2w1ZvEVtuiUrXWG38ihnPS7GwnXA03jcyeAOzpxbKKqCTl0g3Lx7779kuPR9
         5ZBuAwX61zDnGnOfes1IBeOu7qMxDuV3lEXi6Q0qZ1rSQzNl8EG65RpfUwAZ65iuyQFu
         ohGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242925; x=1753847725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YRcngTOmImRVZlU/kPn2yZwK6WlVIM67jiQ/OO/PWc=;
        b=NAUMxCnSfbplqtW4NvfXOZPGg49FE9hgMK1E7HL5OatrvXLcpi/Aspof/S3ncUvSZ/
         AHJUNOTMdNkHgxN89ntYXMCdVEE4/RqJ425PuHceky/c7ITWEutqu4Ns2KS5tDElrBE9
         hHLv5HEP7lWv6YHpC5Z5ahOGLeWv0HpZaZHLwx89EXRhQHkB3/MICAYeCPcFu4YTYhj2
         u/Q6WRUHnUZA8w36aG4Juz6/YeuoNn2WIeGxThazcEz4kidJehGtiCgddkEnVHAHy3Ow
         zqAVgNL1Z2bS0snEN3sJdbr1feBpr4VJAfiUlzqA5fVd82LMSejnJvskAkfNMnzYefS0
         kjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+wKtCoqrUDExQqIYoFFVB+viB8Hofy6XOyyP4pWLyK3p/efeHGPRoiAxSCq0CbhRu4bHDWvGZquyqZj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLeX3DQuSCmVPr7uN+WJPkT/5G1XSQ+IsHJ3g2rA7Q6DAB16F
	TUSQQ/1XrVDc+GhQqjLLq0hlXWs3wK2j0IobDYL9KhPU5H9Eu1yOW5jlBMeV6/ifUeg=
X-Gm-Gg: ASbGncswQLaOiSTeFXhXVkt/XLmrZ9wQ+t/8cme/SXxVy/l6vIPut4/8ObQxjlUbCIi
	hq1uupEMlMXoPgbDCTFznBPtdaV1IdrfumBFibTZ4KXSsHuQGXsXYcZmZWZ6KPzP4dVzR5LhESi
	gwmYBiE6dtROc51VdkTHfEGKVEmfO4jjsAu02TVkibegTJcUacxfbBRVVwnq7j7O+Z0Z6PMC+Bm
	qFBm0Wc0dM39AK5mPwn/kG0UJg9DjvYjHZgcLXqoC9AC75H3J0+HqPcjcB/2amhujD2KvXhNvBT
	HGEitOuWa5Nks65cisRakUeaQXcJRcR8iaJ68xBjJ14tQepZx/xL5jprWwwA8R/dHonLvnpNcOC
	scYaidiMKH3CtMxU57nnFSMklWNIozRNnsxdyOeKjIh9C7g==
X-Google-Smtp-Source: AGHT+IFPdkG2Deg66tYuBh/VvcuRb6SoC/z/9RlnC+W1ttjW1jVLRuT1P2yag8dd/CsKREgJkG37KA==
X-Received: by 2002:a17:902:e747:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23f98164db9mr18866095ad.3.1753242924942;
        Tue, 22 Jul 2025 20:55:24 -0700 (PDT)
Received: from ziepe.ca (S010670037e345dea.cg.shawcable.net. [68.146.128.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6efb69sm85898495ad.195.2025.07.22.20.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:55:23 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ueQZe-0003Gp-Gf;
	Wed, 23 Jul 2025 00:55:22 -0300
Date: Wed, 23 Jul 2025 00:55:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 4/5] RDMA/mlx5: Enable P2P DMA with fallback mechanism
Message-ID: <aIBdKhzft4umCGZO@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-5-ymaman@nvidia.com>
 <aH3mTZP7w8KnMLx1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH3mTZP7w8KnMLx1@infradead.org>

On Mon, Jul 21, 2025 at 12:03:41AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 18, 2025 at 02:51:11PM +0300, Yonatan Maman wrote:
> > From: Yonatan Maman <Ymaman@Nvidia.com>
> > 
> > Add support for P2P for MLX5 NIC devices with automatic fallback to
> > standard DMA when P2P mapping fails.
> 
> That's now how the P2P API works.  You need to check the P2P availability
> higher up.

How do you mean?

This looks OKish to me, for ODP and HMM it has to check the P2P
availability on a page by page basis because every single page can be
a different origin device.

There isn't really a higher up here...

Jason

