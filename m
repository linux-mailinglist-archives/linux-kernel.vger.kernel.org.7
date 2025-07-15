Return-Path: <linux-kernel+bounces-732008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A28B060AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EF37B6F89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860A28935A;
	Tue, 15 Jul 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKHqa6ms"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CF288CB3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588426; cv=none; b=irvIkS0cJRTxMgxLtuJJC87DRPukAqh1tp7y2fasJJ67ElDErKCL8hDaVrKRwfAex8QeZoEm9AG1aMLx+hJu4kCBhGjPX7z+6wJv+yiFDSr8wyG2kRh/huxaa9APHmtjggysY6wP9ZX7P85eDlXa3nrkjlUdk1Idmr1u1vbxCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588426; c=relaxed/simple;
	bh=L86prP4TTPqpMQIoLPMaLq7KqiWjNJGxwzMCThgDnDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pLLJr2frcURnIyZ+HBfeypWpiAPXN5Ylp5TFuNnLwSayKQkC2jdGpRCZ6P3QKa/yVRkrLxMiasLtj0JezUuUUkm3snvWYIA7GZywg+cA1/LV5ZQIYx0RclIZ7KTaTW1mcZTcv/ZXY7+dPKPF/pv95UWu+jQ99lw7oYi5393xrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKHqa6ms; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38ec062983so4071341a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752588424; x=1753193224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQnNGUtBGDZserhnvy1Sw3vFLWuIiTqycwu8w/nJ2jo=;
        b=PKHqa6msQMhqZ9g5dX1dt54/3J4BbyRdQAOFnCmd/G5vmMveVkykremrnyPcNWNOih
         RROsq0MlzZr82oyBzZdYGA7OLQFO/tt4fsZVW0yoxZvUFcmBvCNwI47Bnnvr010Vs9du
         MN2x6RjwmYBz2QnRIPFmfyqF1exuZYgjtyaTCrb89+Bch7R+I7Xu0kVafjA02oKnYJl+
         znZLKoZZkQQ7BHyvWNCTmsWsfqNxzfdwIe1KhXOFyLHMLF2tkoRDdf5NehZ56PmQbM84
         DoOU2FYzQanosb9Sc0dVIm+c10HtQkv7zWcoaoZ7FNu4J6v4o7mskYurRQ+IEqzIMaEb
         v6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588424; x=1753193224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQnNGUtBGDZserhnvy1Sw3vFLWuIiTqycwu8w/nJ2jo=;
        b=mOeJxyPjpFMb8H14oEwBOfe2fwg6l9/D7JSLwfHfe/+StpnpjigGaC7aVJyFz84jof
         td8xbPVk7Cs96Bh2Gs3KGFy3foxJe3Q0OA2+/QWMMtT+UhP9AcZTHIvrOeP7ZVcC1G5Z
         fYOhBjIeqCfmWFkEB1xOanmU7Oidv1xm4ICQqbASTOnGeXLHvNqXtnKrTxrrh/zaHxZS
         3UJ1ITOnw27y1CseOyh9lru1mmO6FabnL3NPlDCy1gbwLccZu/J/htvjd+0M8E14/iAQ
         Qwrbd4LcRmTjUr8vdYVd1K1SvxzSk54OEwALfLz9uPYXt06xrQiYcmIB53M1m+S7HMi2
         SFuA==
X-Forwarded-Encrypted: i=1; AJvYcCV7j0/uiSmRpjg25m3LobgBX2hmTw538nl62CUyZFuF1K9gLF1j0f3tzxoqARTSQD/NGoV4YSI09K2fet0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxfUZ7Q226V6dFwK8CEEWogy3N+AlrL3PxDnt6NAOIkamx2JKc
	hFFwpQ8okmH2SFApruN3P3Adggr3YLPc1BtqOOKt89hWk/16ZIuEkQHj5Q9e7+ACl+PXAbbs17F
	H81IQrA==
X-Google-Smtp-Source: AGHT+IHBTffReyder+/OKTtAFTslpuPttL+P7LuXHQUtEw62s0DpqUK5B296RLS9f/DVP56Fnx92h7AVsjQ=
X-Received: from pjh16.prod.google.com ([2002:a17:90b:3f90:b0:31c:2fe4:33b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528c:b0:313:287e:f1e8
 with SMTP id 98e67ed59e1d1-31c4ccbc93emr27660997a91.8.1752588424051; Tue, 15
 Jul 2025 07:07:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:07:02 -0700
In-Reply-To: <e1151fff87e0f0f26462fed509a41916dd6ba8e7.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1752444335.git.kai.huang@intel.com> <175253196286.1789819.9618704444430239046.b4-ty@google.com>
 <e1151fff87e0f0f26462fed509a41916dd6ba8e7.camel@intel.com>
Message-ID: <aHZghtaRrcfX7p5d@google.com>
Subject: Re: [PATCH v2 0/2] Improve KVM_SET_TSC_KHZ handling for CoCo VMs
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Chao Gao <chao.gao@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 15, 2025, Kai Huang wrote:
> On Mon, 2025-07-14 at 17:23 -0700, Sean Christopherson wrote:
> > On Mon, 14 Jul 2025 10:20:18 +1200, Kai Huang wrote:
> > > This series follows Sean's suggestions [1][2] to:
> > > 
> > >  - Reject vCPU scope KVM_SET_TSC_KHZ ioctl for TSC protected vCPU
> > >  - Reject VM scope KVM_SET_TSC_KHZ ioctl when vCPUs have been created
> > > 
> > > .. in the discussion of SEV-SNP Secure TSC support series.
> > > 
> > > [...]
> > 
> > Applied patch 2 to kvm-x86 fixes, with a tweaked changelog to call out that
> > TDX support hasn't yet been released, i.e. that there is no established ABI
> > to break.
> > 
> > Applied patch 1 to kvm-x86 misc, with tweaked documentation to not imply that
> > userspace "must" invoke the ioctl.  I think this is the last patch I'll throw
> > into misc for 6.17?  So in theory, if it breaks userspace, I can simply
> > truncate it from the pull request.
> 
> Thanks!
> 
> > 
> > [1/2] KVM: x86: Reject KVM_SET_TSC_KHZ VM ioctl when vCPUs have been created
> >       https://github.com/kvm-x86/linux/commit/dcbe5a466c12
> > [2/2] KVM: x86: Reject KVM_SET_TSC_KHZ vCPU ioctl for TSC protected guest
> >       https://github.com/kvm-x86/linux/commit/e51cf184d90c
> 
> Btw, in the second patch it seems you have:
> 
>   Fixes; adafea1 ("KVM: x86: Add infrastructure for secure TSC")
> 
> Shouldn't we follow the standard format, i.e.,
> 
>   Fixes: adafea110600 ("KVM: x86: Add infrastructure for secure TSC")

Ugh, yes, the semi-colon is just a typo.  New hash:

  https://github.com/kvm-x86/linux/commit/b24bbb534c2d

