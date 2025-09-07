Return-Path: <linux-kernel+bounces-804587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8FB47A24
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA781B2169D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35773221FCF;
	Sun,  7 Sep 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="ErKpxftH"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AD221544
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757237840; cv=none; b=jJHME9Jqv7WIG0J2/toNiuNdqKiyM0S0dBfBEAFX0LojctZ02qtFigcLlk7cZR24JM4R8sTwgJql24avV00EjXS3wv4hJZDfOJCUppv/rEO1Rvf1QN8dIknBS5RVc5luI9wuQGRGNFNkz//TAOKtZeo5Nr0dT5mgXMXSieKnS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757237840; c=relaxed/simple;
	bh=0Xrg991TS+oaAJX9WvbcTEwohOrOg/V5EHbqh5DH5xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlUj2miXuAms2IhgtWNYEMYQXu8cPfjkVxHjiPzKBz0ysPp2lDK7g1/uB0GoiyFj+aL1uI47YGe+U69hubnDM8MonBAguvItPXLUd9yW/nPHa23a43pK1O0RbeVLhRnhvFBkVdDPtNeaeis841KfjEHQv++1v6wxmzYz2zwR6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=ErKpxftH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b6108f2d5so2399940a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1757237836; x=1757842636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70zvkE3bB7cmZPuDeaKwadOTmazE00TZ9JEFPyMgvYg=;
        b=ErKpxftHKal8gE+zBqg91/L02OIY4ZK3FdbLKHOnaUwzk1lFAb5TLBuonPegyNEQEp
         D8XJNzCAjXlllo8WB1eyjVqgzf5EPVCHD5hAzshTFVMZylBcgD2abvtmqckWZBP8AumJ
         qCYH0rbI/qHEUKTVUEef6BaMOEx47TzOrFpzHc8tU/lRwtwD0NET/G623mnKVLCv6ZXs
         fbbuW3Yk+BaILMGOzMm6z8eT6QDlHInPnmSJI7ciDQC5lr3poJ3EFAkbCqBtlIqyrVl6
         B3TFDQ0SwM8sldo8U0YIz/M4YFMMywOPtbeIMJV6zTyRfb7inToXLMVoRxryiAQh4vMo
         0X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757237836; x=1757842636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70zvkE3bB7cmZPuDeaKwadOTmazE00TZ9JEFPyMgvYg=;
        b=KFWKX+Q2XE3Y3VwotdUumSPUyMejLj2R0iYay1EvIw1oWNIRTmTQqWjUY7bSMA9gf6
         YKkH2dMjxHS9yutoDBNnOPE2DnZT8YZLYojkhp0rAImFHieMihDvS2gO4mOmb8it52+z
         XNdhL6szdmNSluEODAEg9kXbbf34OhpwCYpSPJPmhOitpxmTDjcguO4AijYkRVdXqkuM
         qV375d4SFtfxDw/uAWrUOSgeMzV9QC4NhInkj1Q8ZfvvAU0hvDSHJc7/H/d71opz9uS+
         strKa8Z/uC+WcJb0MOIp21OUWuyhuwHwLzIDOUcOJp6gsfWfQRKIJ908ekyiZ63LXFZb
         Hy8A==
X-Forwarded-Encrypted: i=1; AJvYcCUOhg6xbLm2NsMhwnR8sr4TZRX/uXISogXFCQBBic2PIFNCPgtnUK+U49wvjkL8Pzi/ezKwQclFsTWFMqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqpqIYukcjQ9/Cxxd3CAON1YAzGlxabTnT8hsQ51TCEDgtWmX
	9ahPgaAQmNlli1b6YCCJm3TdUrDSZqZvebbWQdaxLkFM+ndwx9PG3zJGSezhSCx6Wl2L4ztnzCn
	Po6Cef1dodK9PLvzNQNcnbMdir76XqWqBGqcHAIiygAnQG2xW+FWxoN/eBkE=
X-Gm-Gg: ASbGnctsUdiK/eK89bBK5CvwvzlE1ZXQscCjz3UFcp1SuxYPmPc/kFv19MeWJSSu8oO
	aQOIInJ2DPdmZ9f2qUjioiWlCu3hZK/FBqxAV5Nncgeq+UvW+b9CREDDW4T3InPKVscQpeCTnFl
	0Hwe7RBXLWEoOFPHSwjuG0QsPMbbd0+XchAUmCCDGpNnmR7CRLrjVL6QYnV57lyZgEzjm1clC+3
	uqgrvGQZWBXLVcgEpDcU8FxmmwmATuYVKAE2aJwrjyoqkrN9J4XrbMlW0fS4L4k0qm3GtKORPPd
	H5wB2EgTNkPYDWfF/JDbYZs872HeI7vuqJGIdlnic6euYA5wWliqnFAXl+RP3ue4WzM25ItqKBM
	53xxtolEk8QkOoz9+I6DLzL9hDP5W+hZ2dAKTlNzYs6qWsvCf5o0w2B9zaXCAPLrTLJQJ
X-Google-Smtp-Source: AGHT+IFt1zERczq0Nc2LpsPzQKax8feeqQIGI16X5GC5DFj+Af0FRNlixEjUAXqLaAAS2kFETPcSkQ==
X-Received: by 2002:a17:90b:1802:b0:32b:6820:6509 with SMTP id 98e67ed59e1d1-32d43f070e2mr5859703a91.9.1757237836296;
        Sun, 07 Sep 2025 02:37:16 -0700 (PDT)
Received: from zenbook (36-228-15-28.dynamic-ip.hinet.net. [36.228.15.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm27768393a91.18.2025.09.07.02.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 02:37:15 -0700 (PDT)
Date: Sun, 7 Sep 2025 17:39:53 +0800
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: nv: Allow shadow stage 2 read fault
Message-ID: <hzif6tde7p5q3fyrmu5got25rwuiuea5pzbf2ubbqdfc5uof4y@7waunf3d65fo>
References: <20250822031853.2007437-1-r09922117@csie.ntu.edu.tw>
 <87a53rk83s.wl-maz@kernel.org>
 <djypsyratk63ovzv3flzb2tmunqtcoryzserwhsaaq5nuogsrx@u3uuwynnafbj>
 <864itme8k1.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864itme8k1.wl-maz@kernel.org>
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Sep 01, 2025 at 12:06:22PM +0100, Marc Zyngier wrote:
> On Tue, 26 Aug 2025 14:49:27 +0100,
> Wei-Lin Chang <r09922117@csie.ntu.edu.tw> wrote:
> > 
> > Hi Marc,
> > 
> > On Fri, Aug 22, 2025 at 10:40:07AM +0100, Marc Zyngier wrote:
> > >
> > > This would imply taking the guest's S2 permission at face value, and
> > > only drop W permission when the memslot is RO -- you'd then need to
> > > keep track of the original W bit somewhere. And that's where things
> > > become much harder, because KVM can decide to remap arbitrary ranges
> > > of IPA space as RO, which implies we should track the W bit at all
> > > times, most likely as one of the SW bits in the PTE.
> > 
> > But sorry, I struggle to understand this paragraph after reading it many
> > times, probably my experience with the code isn't enough for me to make
> > the connection. Why are we talking about the W bit suddenly?
> > If you don't mind, can you reword what's discussed here?
> > I only very vaguely get that there will be 2 W bits, one from what L1 set,
> > and one from the L0 memslot, if I didn't completely miss the point..
> 
> Sorry, I quickly drifted into something related.
> 
> My take on this category of problems is that we're better off always
> using the permissions that the guest gives us. This is the scheme that
> we have adopted with VNCR. It means we wouldn't have to rewalk the
> guest S2 on permission fault, since we'd be guaranteed to have the
> latest update.

Ah yes I get it now! Make the shadow S2 more TLB-like and use it to
dictate our actions instead of looking for info in the guest S2 by
rewalking it.

> 
> However, S2 management implies that a S2 mapping can be made read-only
> at any point (dirty log, for example). Which means that on a
> permission fault, you'd need to find out whether the page is R/O
> because the guest said so, or because the host decided to make it so.
> 
> Which means that somehow you need to work out why you have taken a
> permission fault. You can either
> 
> - rewalk the guest S2 as if you missed in the TLB
> - or keep a copy of the W bit in the shadow SW
> 

Makes sense. Yes with this we'll have to distinguish the reason of the fault.

> > > We'll need exactly that if we ever want to implement the
> > > Hardware-managed Dirty Bit, but I have the feeling we need an actual
> > > design for this, and not a quick hack. Your approach is therefore the
> > > correct one for the time being.
> 
> And that's why I brought this up: to support HD in the guest S2, we
> need to mark the full shadow S2 as R/O, and update the guest S2 on the
> back of that fault.

Got it! Thanks for helping me understand this!

Thanks,
Wei-Lin Chang

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

