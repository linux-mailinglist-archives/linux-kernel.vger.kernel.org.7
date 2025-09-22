Return-Path: <linux-kernel+bounces-827466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF5B91D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B73B2FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155692D8DB1;
	Mon, 22 Sep 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHX5sYFg"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB12D73B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553186; cv=none; b=bo2dk17i6VUod32VctFLh/R4K3u0rKBLauj8ZR2XwyZmWRWlW+Pw55j5RtS2AMKNHurMwLA2Lg12qgXHU4thIfFyEgHOMaOvo5EtsHNo528wTn3Dy2SnXQb4MGqHw+YMaTx+LDj6F+wxQMI65SbvjTg7KHxvcu963FtPndNF5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553186; c=relaxed/simple;
	bh=gj61j0lPIF1rJB/bO3aXTB2F2a0hjKKPVbSWLP9Ifzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNU4+97EX530egZg4evWivwj/gDsa4kq8Oj6E2o/KYx/pRCpBgHQDQFCnK55kQZem8Jzls0vLyuT9U/cmrFlSXJFdIIGMbtYnQVhYo3K6DXE92g9Jyyfl9nQI0nauzbSAlLZbqymZdjKkFwvuMW7mkk6zniy7XweMiG0uX2FVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHX5sYFg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78defc1a2afso57397396d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553184; x=1759157984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC/h4olZvgyGUP1ldXfp9WzTjnMXRRh418KWKJodRBM=;
        b=SHX5sYFgNbwahuC8eH0XEi8khsKxmWZ5d/7wDXxzTqeccxb21vkuilxSJdXf7R93+J
         8111BtSFKQorXsWyHfY3tzQfyXA4x83n373UeVrrePSQ3DGImzNOZfCs1UhvlsfhkCmp
         R5bHJvtTFqyKyBM3RpWqaC6Z8maHM377Eq4sIW/koWYifj3m6h09QlVBi5XiyXTjy8zI
         wvEjRRq/vxuroHCuu88zNzCEy1LQWT9LB9AI+Ay/hnTcuZVSVtLSgluGSSr+5qnTS5p6
         Uf2bjZoMxNcMgYXfyWeQbDXMIblSAvWIwgcvLOG1qpFZMNBr2zworVhLNr2y0ncQRY/h
         nplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553184; x=1759157984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC/h4olZvgyGUP1ldXfp9WzTjnMXRRh418KWKJodRBM=;
        b=FEElCMibRYKswr5+k6TJcHT0G6xBODS9DrOwQ+a2aLMn2+SgCWOk8yClYUajFNxBhE
         UXR3G6+RUZ59QxyOGlCD2nku1T9Q9cF2mWLz4r5DOiM/ucA4r42E5B5FlHFXyl6iX44f
         TqhXR+OQls7RpM7Nhbgx5Bwh4EEbmOoxKBgcq+gPoiK3izkmEQx6VdO/T4fwzXujTMXi
         MX3o2cCHO74N+ats+KF7elVc+YeOtx2ylq7CQwIgIj1zLc+F/ZHlklPWwe80gSmbJkEx
         4p23EKlBEBsan4Nvnfn+8Ma2WucG3ya/YpjX//kr35mSVgFa3yW78Dt+phTMMvyFPCXI
         oaDA==
X-Forwarded-Encrypted: i=1; AJvYcCXs9gHVXMSidLKNGx6xhyu2HDM6tnJLGomkn9IZNFKINkue/4l+hqwVbA31Lle3fKc9EKtHcMbCEIu+Kes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8nPTnkLxUAkaU/6TLbt83/G9lLnYvctE8xDE2YNHJBJjj5X7
	TfTUzge1OvLg3H7gqeMGS83GCOGlw5OmmtIBko7nBDHsBmSeqAlFIzGE
X-Gm-Gg: ASbGncsUPe8iMZbF06wzt1UyKkV11q1l6naFfU6aLjdKESO1q80Y1wluIyirtZ+vVLo
	ESmuTH60Gmc/ZTUMksozZtumf+dm8uyfAwzK4Y6CSYGpFUeeUkBEEe1mkM/LrqDfcuWmsSBeJNh
	+aenMWnUrrDCirEMKZKggusgloq8bIcI5+POoqhNkCtcbG5wl4oDKYi3stK4FnoFdlNX2pcrqUd
	0TGh5IlGpZRJ/HUn++j5N1za5omrQHIIKzMaWBi7DoxN0wW8SpjfdEVMujxs4BrCNJMEvA2m3or
	PvCbTt2yejl0+EFh8g2cBPUzHJz3onvrbOglfVbcDrX04Llmp7Rw67tpQKrxN2iPtM5gD2TiOu0
	cCGJcYUf56h08cLFroANdHi187bwefr5TZVB/wfWdoMXg7qHAFD7zwVmMqd33WwLCHydCH1ZP0N
	qSs+Hv3BhNDsJN
X-Google-Smtp-Source: AGHT+IEHe/CHdXJUkZuoP1JzEUs4TjwTHCc0pRfedv4Na1eNLf16LBC4uPeU79zYn5G/dLw7EkeLcA==
X-Received: by 2002:ad4:5eca:0:b0:796:5c30:b079 with SMTP id 6a1803df08f44-7991c5f4a5cmr149827546d6.43.1758553183474;
        Mon, 22 Sep 2025 07:59:43 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793473b8633sm75273986d6.29.2025.09.22.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:59:43 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6C89F40066;
	Mon, 22 Sep 2025 10:59:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 10:59:42 -0400
X-ME-Sender: <xms:XmTRaLdSUbGk2hyGVwqbIANivmLaNkjBc5qSaa0nBe94tU2vweJ3fQ>
    <xme:XmTRaPcnHeUhtGOrHTUzMETKEByw2SadDmfgwPbOVkreVxsT3ZF5JwJrCtDp7Jqdp
    qjqXnoKuFlN3OSA9tzNWwN8paLlPSc8U8puIWSb9Eav2BQotJCizw>
X-ME-Received: <xmr:XmTRaN0xVMDDShwwPSSVLPqF2sfKOnjFTetAPCDxS9YHcqzUjwZcQQe1JVM0wHUWnZ31LhQIuc0OAMn5Q_OXvDJGHJJNuWcn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihurhihrd
    hnohhrohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepsghqvgesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqnhgvgihtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgrthhtghhilhgsrhhiuggvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvg
    htvghriiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:XmTRaP-bRh0H2kbJUhFLTn_fBJlzqiIWAofg67glkj5cuhb7jws47w>
    <xmx:XmTRaK6gFqiKyMKv_vQdxDCc_np8ePMh2XdWgDpdsO115qDjhDoLMA>
    <xmx:XmTRaPsomKfRC9GVCva3UKFHXK04e_LRxLuvcrc54j5Ru_EZMiQ6Gw>
    <xmx:XmTRaE0uUEr2eU5dvM4a1jzy8WTP5lp60j77uJmiXG4NYx8y3_wb4Q>
    <xmx:XmTRaAoiZ1Vk7YkxBBuncqwgQNZwsbqfwtwC5-2Lt2GkuiVpW_zC7sbZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 10:59:42 -0400 (EDT)
Date: Mon, 22 Sep 2025 07:59:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	Burak Emir <bqe@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Matt Gilbride <mattgilbride@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: linux-next: manual merge of the bitmap tree with the char-misc,
 drm trees
Message-ID: <aNFkXUUDtJ-Y4rJZ@tardis.local>
References: <aNEhcEFTsdPXmtVi@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNEhcEFTsdPXmtVi@finisterre.sirena.org.uk>

On Mon, Sep 22, 2025 at 12:14:08PM +0200, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bitmap tree got a conflict in:
> 
>   rust/helpers/helpers.c
> 
> between commits:
> 
>   eafedbc7c050c ("rust_binder: add Rust Binder driver")
>   d9ea5a41cef80 ("rust: sync: Add memory barriers")
> 
> from the char-misc, drm trees and commits:
> 
>   78d9de4ca3474 ("rust: add bindings for bitmap.h")
>   ae384a4623fc3 ("rust: add bindings for bitops.h")
> 
> from the bitmap tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc rust/helpers/helpers.c
> index 3d7d0b40c9f13,abff1ef14d813..0000000000000
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@@ -7,10 -7,9 +7,12 @@@
>    * Sorted alphabetically.
>    */
>   
>  +#include "atomic.c"
>   #include "auxiliary.c"
>  +#include "barrier.c"
>  +#include "binder.c"
> + #include "bitmap.c"
> + #include "bitops.c"
>   #include "blk.c"
>   #include "bug.c"
>   #include "build_assert.c"

LGTM, thanks!

Regards,
Boqun

