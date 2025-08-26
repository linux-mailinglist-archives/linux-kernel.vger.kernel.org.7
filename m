Return-Path: <linux-kernel+bounces-787035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DFB370A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ECB1BA1DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D3368094;
	Tue, 26 Aug 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8o1NA52"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E372D12E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226299; cv=none; b=HRX35lzz0Xhw60C26kTItHHXgz9S9Eny4z5BAIxa/ZQAho02d3FKSrjRCh9ZnHEAzl75EIMUc3Rs+2kIZVE2CwxM5s2+WSvY0DtgACaVQ1S8lRv7Bs/+o3YPs4y6wlyCgXJaBRVKS4Fbp4YKPgNGA2t6Gjw+r3jAKERh1pg+QSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226299; c=relaxed/simple;
	bh=IZA6OL5p8O+5QNVz1cw/X3Wrim59+EoqxbFxaryX0Cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SKMJMJsO07Jk+1Jq60h3qlzthCYQzZQM7yr+A9/vAyyGDmcnfJPn0k3NWi7nXQQ4eNfvvrQ3Za/WrLHgAPAogIGK/cG+CAndRjrP6QhzC/V698dimSpz+vTe0HW6vPkClKTSO7fy3GRd198mBFlha3qDnv7SAkGvTZolmXieSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8o1NA52; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c1d26b721so1790412a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756226297; x=1756831097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KArhLKucBXK1qma7WLAGLPHRkqsc2bT2vqsvNWf6PMM=;
        b=e8o1NA524f3NKL/ph8L3v/cRKbXvrP4LfgBiux/K/hKN4MHdDHYUAdHXx8nz1h7g/8
         thQeU7L5Q6itRTejj1d3uI7rxYy2VzOJPs/EIaZ/qHY822Nqcn4HGJTx1ccXYeVD+07q
         y+NvdwhgBtOIK2XRc1Cr2pNwYL5GPGcZHaDKiZ5ym7O+fU3Yzky660ErRCxNz9vHTgJP
         utnjihofGdYw1UNWCC4pYBAHemgSwbHTmEhlrGATocS1rrxmP5pUFQ2bHhFimNCk7tFn
         ZAh7vlFMWgXVB8nlHf+FjBMnT5m5nKcANLfvaEPokCu6RDlwg+BrHDjfRCfQmw5GRTpv
         gABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226297; x=1756831097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KArhLKucBXK1qma7WLAGLPHRkqsc2bT2vqsvNWf6PMM=;
        b=meu9fFCWrSUFYHsolcLubZIDNbXT8fQXKu0DvRvuvGgpzs7wDmRc04LiqD/kQAwTQ7
         8BkGpIPpA8SHvhn+m/T07gsbfuL8//K3A2Efjl3r4YkyIjYivjL/y2Q5vpy7sC/p8Dbb
         rmg8qDnlc3lUPoGq+DzyMptEWEoq4tF1I3R1ruNEoFuRp6lKMtUdVYTn2wEozJdFeBMb
         kLNL7Axy4mjUStygyrxHn/eZC/rOL7+mAiLO7xh/lBtkzn0TGC3svxWxkxWFZB2P82Pr
         uSetw0sZlK7LmBXsVuWVoON8rQLFre6Nc/wBgVWWb80RULw961UCerMykrmLLwJXJYTD
         SQzw==
X-Forwarded-Encrypted: i=1; AJvYcCXVAWUoMJ+aulHhdehZGHU20sJ41IU62VEs5uheJsjPZXn4mqd1OmRFKv1znlPlwunRYgX12rGiPx3tY6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3GTnAeHXxxYPEN2LdtQDTPRiYd75e7Ax/XLoT0728dbMS53l
	24QwmhvlOwg3N5uVcV+UMayNXYuqNhsQRs2qaUm81YzUEdykn9l7afe4+ng/ZZD8B9qn06PPPf4
	uCaOIhw==
X-Google-Smtp-Source: AGHT+IHW22aqV9V9u5Zze8D3GfPgtdWWFsehZkrUkllA1TCvbFhmXlWXij1jXskDhKIIjelfwPENG1eV3eQ=
X-Received: from pgww6.prod.google.com ([2002:a05:6a02:2c86:b0:b4c:2bd1:3d27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b32a:b0:243:6e7b:9666
 with SMTP id adf61e73a8af0-2436e7ba22dmr9292868637.28.1756226296889; Tue, 26
 Aug 2025 09:38:16 -0700 (PDT)
Date: Tue, 26 Aug 2025 09:38:15 -0700
In-Reply-To: <aKv1VNFiOPJZBN/T@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-11-sagis@google.com>
 <aKv1VNFiOPJZBN/T@yzhao56-desk.sh.intel.com>
Message-ID: <aK3i910ghgsaIkir@google.com>
Subject: Re: [PATCH v9 10/19] KVM: selftests: Set up TDX boot code region
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 25, 2025, Yan Zhao wrote:
> > +	/*
> > +	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
> > +	 * code, as there are only 16 bytes at the RESET vector before RIP will
> > +	 * wrap back to zero.  Insert a trailing int3 so that the vCPU crashes
> > +	 * in case the JMP somehow falls through.  Note!  The target address is
> > +	 * relative to the end of the instruction!
> > +	 */
> > +	TEST_ASSERT(TD_BOOT_CODE_SIZE < 256,
> Looks TD_BOOT_CODE_SIZE needs to be <= 126, as the jump range is limited to -128
> to +127 for JMP rel8.

Gah, I managed to forget that relative targets obviously need to be signed values,
and I also forgot to account for the size of the JMP in the assert.  Go me.

Maybe express this as:

	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 < 128,
		    "TD boot code not addressable by 'JMP rel8'");
	
> > +		    "TD boot code not addressable by 'JMP rel8'");
> > +	hva[0] = 0xeb;
> > +	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;

I think I lucked into getting this right though?

> > +	hva[2] = 0xcc;
> > +}
> > -- 
> > 2.51.0.rc1.193.gad69d77794-goog
> > 
> > 

