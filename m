Return-Path: <linux-kernel+bounces-854455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22236BDE6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E31928493
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D999326D6B;
	Wed, 15 Oct 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PY/s/Is+"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481F326D5C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530537; cv=none; b=fs1xtpO0PV1rPErIhI8s8fLkLAoAtVU+zikuvhmWRFdHJApWZtFgwvmtG3ITdIYyPs7JgcToLbIHcELrnEtvM7moNETKm4T58dijKuL+b/HEWLF89cstvlsdj1RybjhzefN6PY3p1MPfnxyMdrYT9uYwIq9ECC/JMYWTnvnD8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530537; c=relaxed/simple;
	bh=mjHQrbbDrwX6GQ7o9PGjEA7im+oTQeT6k/wmhYoPpbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQwKSVKpvLlWU5q2yb6/YrIjHUkQT7puCjkPtweuubKVHp9tU3q1yhzgg+2++mpFxoonGHk2EAbu1mSwgNn1/aHNa+cGuber3rzcCajYDy0OmBSIxppNYRt6YH2XapiBy0GIqNEfyIJU+RhKa3/5SXNDLUGK/IYAzIB9dLcvg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PY/s/Is+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so5839968a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760530535; x=1761135335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3fPSrHORtZHq6E/vA63d68c0Rr3vVgkT2wP5kavB8E=;
        b=PY/s/Is+VCoL/ItlrvYijWuNjl2VNeK9fW8FXfUqzZc93iv4h9kxEmcyGs8PGNQxLw
         cK1RgMaFjyGCif6u38WNaE/u1KfvMuoOriOWJrZu6i7DUoZxBjNTJt9vpPi3NgGfD4LQ
         +fO0OBxhpZUPuict0e7gCTN+uYmivNm2+ntIS4wHnb4GUx/49VI9rw306CqUhbdi9xZ1
         +3o9YqVRT2lTJ+1vQrLYO5drecbjcEWVZwtyFufPSNIxX3Cn1NNAg68nqmFkrQ2P5XUD
         ogf/MsGWo5qA+3ztvqicb336II86XBGijyDCVebQL2wRuQQ4xytM3Lc5jftZoxfViLoy
         gkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760530535; x=1761135335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3fPSrHORtZHq6E/vA63d68c0Rr3vVgkT2wP5kavB8E=;
        b=MdaiNrfsv8EW+U58z33KD4Zwbu7cAms9pdZ+O2DJmRaeYpmMXFFLSMjkvTu2i9lEt+
         jxB2wNcG5sAUL0J4Hki58HpXACfmYCrxBttGSo9LdJk73vM3/PFDY//MA+VXU4zuz/nH
         AUFAOgxjBS1pfy9wfpqhhvl7wzzOajhgLM/gW4L6py7OapAPED7NmZ29+TtZkokVYfLm
         fsAKQ+BEkCFCjPKTu21exknfDuYXBTee6Bnlbf6951aQQOrVWWGAowGuHiPUnCsU010z
         rfmrIn9hQv/FoyEkcbr85s4dbKa0LappmqP8P03iwRuUCTJb7cbjSaHlYCXE4gz8QF3u
         SutQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlalkzD20VLDPFNtku8xp//etQRnj0Di7lNO0Yq495LZETqzdaotx4R4+TIkwTuhIzOHGHAQZRsjgwLQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGodNJtoBldzvs0eQEcH0lvg+5SWXkbjWIVL+WdmlCiJvdR2fh
	fXhlc+iT2vzQAklOkAPTUpSXGJ0oKYJF8PQ3gX1is10qL7QHtSR6tnI7CngYcgJVB2k=
X-Gm-Gg: ASbGnctDPp5sNU7CTTSRYAde5MpmHvDPZlMRk6y+DU74xmJXVmhgX746/c4ccwxDNw9
	/QKuFBLdQYeKRwveT1yx/7kk9w4CDOVXk5XXdnzOFY16MBAgEQrOaCXYW46Bf56SWZLfLU5CViO
	45kYhR3AlKGITBUbLoP8P+fji8XJsbRivNLJBiZiW1aPXUn4MYAnX+YBmmoEWCDNr4xAYt07/3E
	NjBI4FXBHy2OEiEI6E9dJvQFN0HhIBhJeE27HHD7vXtfBd00HshddlTxXpL6rMz+dgtiE0fVXrM
	te1+7IV2kNrr5fXv6FSsC8VpXbuUJKv6K720zuXNCf2NkRG7ZpeawJFsH4roMDLK1h0ean50ngf
	dD8DiFB9tX/MAMSYyzOkg25MdD5HC9JUMfLEZtMklVvk7HbCNaRofh+OG/xNA
X-Google-Smtp-Source: AGHT+IH0oN0GQSOhSxcUM3EYcPBObyIHiYZ5l2qwqp0SzcDahjgm/x0qX3kZMHorNm24TIg/Rs94NA==
X-Received: by 2002:a17:90b:4d05:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33b51118904mr41185997a91.12.1760530534910;
        Wed, 15 Oct 2025 05:15:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67d313e7f9sm6775819a12.12.2025.10.15.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v90Pl-0000000HOiL-1Vvt;
	Wed, 15 Oct 2025 09:15:33 -0300
Date: Wed, 15 Oct 2025 09:15:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <20251015121533.GF3938986@ziepe.ca>
References: <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
 <2025101523-evil-dole-66a3@gregkh>
 <20251015115044.GE3938986@ziepe.ca>
 <2025101534-frosty-shank-00b1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101534-frosty-shank-00b1@gregkh>

On Wed, Oct 15, 2025 at 01:57:38PM +0200, Greg KH wrote:

> If this really is a firmware thing, and you have a firmware device, then
> I am confused why this was even brought up at all?  Use a real platform
> device, with the resources that are needed to talk to this platform
> device and you should be fine.

I think the issue today is the PSCI does not always get a
platform_device, fixing that seems straightforward then all the
downstream things can switch from using more platform devices to using
an aux device with the PSCI as the parent..

> BUT, if you are making child devices that are NOT actually talking to
> the firmware,

This thread is about how to bind various subsystems to this shared
firmware interface.

Jason

