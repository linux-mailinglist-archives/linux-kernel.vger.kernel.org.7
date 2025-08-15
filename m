Return-Path: <linux-kernel+bounces-771137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99177B2834D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3122D188B01F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7384308F21;
	Fri, 15 Aug 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbUwWtvm"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A61308F17
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273100; cv=none; b=sdHAG7a9YZdTFOqt+uguCobS7s6Vj+YpIk/Tmxp8jElrt5LbhUiViUBYTbq1jK3uNxMi5m7Hu1MNDoJL8vxCAAx1B4iPw0loO1SJesLXh8B0NdB8x09Sk5QSJBxxcyXBXAsjkI9joHdhUqBeg4sZnZTk8+a+pCMOTkFXN+OY+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273100; c=relaxed/simple;
	bh=TC3F7GjzY+OYu16pCnRLEw1W9DDDYcqj1aSZMIOYjuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxBzLyEI9qEGRLvFGs1/BZXvxsMd+UMCZUnZd7fwNfdt/WiaxnHGdcOWJRp3rirCvRryHh5qrLUVBQBCQtvsTwzw5oXKbRMNJPIS88tN8Uui9MaeOnPpWUZDaGa4AMQHNFb/oBfA3hi1kZEtRpoM6jO7TisvwTGNbcGUxgCKIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbUwWtvm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47158d6efbso1525377a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755273098; x=1755877898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLuuQdqXBRGyu60+ieS//bbxP+3AVwFN22YqAdloirM=;
        b=VbUwWtvmPg2mzJ1mDCrvoA9XcEX+R1vUa2Ytu1ZtQTkrmWQBNqlULza7r07TfXRunw
         rgTiJih/HIKEqr7vaGDRRkBS0UnEY54fKQBbf4WBjGJVIk38G8ugO1jrZ3Xd0gSIz6cT
         R8STM5KEF6lEudZxvKFLWEkK0CiqcYRWCl8OZlFVyonlBmDE43x4v3HHCoaFVQYkZue0
         3DDjzZSrVEJdosIX6rTshEjnnm7d/hKlnkWEy3LUwn8NqJ7LWYZ2DxJChCMoZwznWSqX
         TRyAEETcPbALtpKTWxzCy1T3weTv0fjnZI76Z8PrWUcFGL84VdFEXdrEadNIdzowWYYh
         l9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273098; x=1755877898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLuuQdqXBRGyu60+ieS//bbxP+3AVwFN22YqAdloirM=;
        b=A6KaSBvYX4dl2zDE9foW1IunGSBBPJmMqmdfaEKuVXVVotl0XH7VSw8ZE+0aVJivIK
         T95zDDUAZIg8G7H2qoyMFyWDVVSwRizp3yIZC/Bf4IsWfZdjjBxgvHSfX2OHv+7459zR
         7X4r+l9rRMBl2P8/wi4vuRWBU9mfWACbk9nnRROxCM06rJ8nM5W873B9paY8z+V0wtap
         bOFii9/4lYm62PnY1Jv17oNpg6RuzStE4OsSKSjhaVPbyPS42I7zzLDA11Hr2zg+05Z9
         CMMKHh+CBxz1pWtpfCMKupuP9SQa2tSgZg9AY9dcm9SUwcDXSvMCqovkxOK5VR4/aPID
         jPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPcMQ/BwscdkjuPbSQ6h1oE2PSjNJpMi/YVFFQ+fOQQLPXVSYuKjrpPXa1OIHBugXjErQytqc5llbO9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9o/g2iOkNbhv32sHgRKaGvDgCRjBSXsb2oAJUXYsBxKcTDJXx
	jvTe7qG5H2bFQAtXVD+gT+FlwtCi5DvnnSIwMcMt/iX3eOCvPTqqMK/PdatWlz9nr5GCF1rmQ4n
	FwZcM0A==
X-Google-Smtp-Source: AGHT+IEixUUF/+ontXG1UvvxuaP113HP3iSlTpnTS0Og0gwZnRo8djp+nSrKI0cvN3mMbDgB4JtBQNij17k=
X-Received: from pjee7.prod.google.com ([2002:a17:90b:5787:b0:321:c2d6:d1c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec3:b0:244:5aa5:a8b
 with SMTP id d9443c01a7336-2445aa50e20mr99042625ad.27.1755273098085; Fri, 15
 Aug 2025 08:51:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:51:36 -0700
In-Reply-To: <20250815130436.GA3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com> <20250806195706.1650976-10-seanjc@google.com>
 <20250815130436.GA3289052@noisy.programming.kicks-ass.net>
Message-ID: <aJ9XiAa58oMs55Ky@google.com>
Subject: Re: [PATCH v5 09/44] perf/x86: Switch LVTPC to/from mediated PMI
 vector on guest load/put context
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Mingwei Zhang <mizhang@google.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 15, 2025, Peter Zijlstra wrote:
> On Wed, Aug 06, 2025 at 12:56:31PM -0700, Sean Christopherson wrote:
> 
> > @@ -2727,6 +2739,21 @@ static struct pmu pmu = {
> >  	.filter			= x86_pmu_filter,
> >  };
> >  
> > +void arch_perf_load_guest_context(unsigned long data)
> > +{
> > +	u32 masked = data & APIC_LVT_MASKED;
> > +
> > +	apic_write(APIC_LVTPC,
> > +		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
> > +	this_cpu_write(x86_guest_ctx_loaded, true);
> > +}
> 
> I'm further confused, why would this ever be masked?

The idea is to match the guest's LVTPC state so that KVM doesn't trigger IRQ
VM-Exits on counter overflow when the guest's LVTPC is masked.

