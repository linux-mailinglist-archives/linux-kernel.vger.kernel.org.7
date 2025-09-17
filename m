Return-Path: <linux-kernel+bounces-821109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9696B8074B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33422188E1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65A32E745;
	Wed, 17 Sep 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LoOmsI2K"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900E32BC07
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121872; cv=none; b=CvWPc0xIaDcFyfZSIQtfezTB036RbWJXfLaqNkiWgFpIB3DeMLu44OKksl7hxkZW+e4A33kNU78+pXm3sJJ2oyoabJfndwmUYpJ3bTNVLk1tFXexHa694pTVp5x3iayBbPOnpTWkJDvx3wWBkpxxZ1d/l1C6KoWkYdp+X+Vk0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121872; c=relaxed/simple;
	bh=64hrnh+G03ii19qLsbC+gKG4i0vub0qBYZGHShiMxCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Q1dtqpvSvnAM4Ab/+ABw1LXnk7OpwYf5cuVgBIE7kss+gnbyMUeey1S6Q3pAdriPi5fdYAwdxsNfk8m8pHNXws8fw+f4KfTP16Ra9kW3UBQOngKQbrlUrgwdE8sQbSm2Leq+4hWePOHHDsAFmNXbCAKsZgDO1fcn34hcPiD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LoOmsI2K; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2570bf6058aso87635855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758121869; x=1758726669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=weVpY5S2PB5qtPhKTuvCTrn7esiEfFzwXr1/dTkYFP8=;
        b=LoOmsI2Ks/zUbNEF+n7QQuSDSGgM7521H/F7bpcAFz5soGS5OWWMIvOx7D2A705LyS
         wzPdwzp+dpnx74tuW9tCfPTRq5GNu8Hy3ZC4XZ5nsaaFrAELNtxwuSAUdRFKbRRJllPO
         ehDcrhfC+QWfPX8edW019IlBV4TS7he1XlvZCfbfOHahOQuXuvyqUpfUtLT6YdMijqGW
         MEvLQb32snj70zkRsGaTEbxmIa+KwdvAnxXCZN+OcEpkfILFYhOGghhdduBGOjU85uq6
         nMve4I/mPo8klnuNu742MN/6OLpPcLqqkm8P6rvdh1OjyVxbE4ia5hqPFry/MsT8kv/P
         TUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121869; x=1758726669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weVpY5S2PB5qtPhKTuvCTrn7esiEfFzwXr1/dTkYFP8=;
        b=CKcAWp9XnJdhgCiY8hpfJGfMR+vPyVIgV5KqHYv+o5plXbXAvHdBG70kLkpjBRw8x3
         /gXdcUZNFeTz6K6HeQxzEDreg9WDafSb0SaHBF0SLlR2aDnFHArc47qEIN5vNF54iKIj
         IFAIA7tvvRrP9gF0IGPK4kveefEBbpfHWekH/OW7BHmtt0Zey5iBV/bSj4J2fQShv867
         ATkB8dXe4bosryPeQc1MiSMhWRKOrEcuqPpAwKDYhM6CY+pdUkWsFujN4xFr3oE9ik58
         M7MZTKVfsdhEZudyIeJEK5ApuZjfcUJ3ObKo2PQG/pvZDFg38PbHrEP3XgbUxc4niQvR
         g9wg==
X-Forwarded-Encrypted: i=1; AJvYcCXNb3XomDr/scbzP9yQrzU2/f8vz2h90Q04XxSZpqRPs1Z7WBItGcztKn2xm/b2Hi15IYRz+SqceUeUjoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSq/4Gui6JEQOk/PNG7MhJiP9eFXe5RBkmzCQi88bfgoE7hzPs
	mFDJM4mI3y9Gu+VgfrkSvOcxctBp2yfZN0Hb2ozrfbP/MAwnLFsbPf2uP5Q/b0KEsFo=
X-Gm-Gg: ASbGncuNVuh1Pv8zfXgrHf/FTWsEP6LyzgqJFjlSB1PSnqcHLJAgl1uAioZDvHd+5Ga
	G0cq2yMMIIV1DbGM+v3yNtsuqOXEr2W5pdkzXjRxoNKZQTPHrca+AHLqmW/MoOP5j/P5+NJfQ51
	XJz3WT/06nrjIjQTlgtLJPrtJKh4Iz37QkHkTFbrkQsTxjLfhMW1e79ynn2gbD4D+8MAwC5tLq2
	zB910GYtMg3zxWg9JM0CCp18Nu4kG+YRXuM9IIYY1hXnuswJNKKPBUB0WEMFgVRVT9bhk6rAcJH
	4PG+s9rYJmmOfvU4gOYZVmENfKluay77FYU9dU/UVg58OuLtwpiDHN9HlHtjKnGXtEwADQl85Vr
	LdSEN6mE=
X-Google-Smtp-Source: AGHT+IFmYE7qlDUFZiho9mEwR2DSnCEfJp/r2TtZAeVeo8f4CW3I/2ig+DnSXAwTVwkjjffoimql8A==
X-Received: by 2002:a17:902:d582:b0:25c:9688:bdca with SMTP id d9443c01a7336-26813bf1f32mr31633255ad.50.1758121869329;
        Wed, 17 Sep 2025 08:11:09 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2623fd4d163sm127041555ad.80.2025.09.17.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:11:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uytoJ-00000008NeJ-3muR;
	Wed, 17 Sep 2025 12:11:07 -0300
Date: Wed, 17 Sep 2025 12:11:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
Message-ID: <20250917151107.GF1326709@ziepe.ca>
References: <20250917140216.2199055-1-smostafa@google.com>
 <20250917144435.GE1326709@ziepe.ca>
 <aMrNJw3obyu8IvBL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMrNJw3obyu8IvBL@google.com>

On Wed, Sep 17, 2025 at 03:00:55PM +0000, Mostafa Saleh wrote:
> On Wed, Sep 17, 2025 at 11:44:35AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 02:02:01PM +0000, Mostafa Saleh wrote:
> > > Instead, we can remove the __init constraint, and be able to run the tests
> > > on-demand, and possibly compile it as a module.
> > 
> > I think you can just put the kunit in a module to avoid all this?
> 
> Yes, I don’t see the point of trying to run everything from __init,
> relaxing that allows us to use more of the kunit infrastructure.
> But, it’s more code to do so (it’s just longer to explain :)),
> I can add a patch in between, modularizing the selftest before kunit.

Sounds good, also it would be good to include the kunit.py
instructions in the commit message:

Eg this is one from my iommpt series:

    tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig

You can run that from x86, which is really how I'd recommend anyone
actually use this kunit rather than booting a live system and trying
to run the test before the system boots enough to explode on a buggy
implementation :)

Jason

