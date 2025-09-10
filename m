Return-Path: <linux-kernel+bounces-810812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B53AB51FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D333168F57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3433A01E;
	Wed, 10 Sep 2025 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Inyajxy6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAE23F42D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527582; cv=none; b=eK/0+3Xfum3Ne0e0LQq4jaJs+5x+TA6XVuEDqynU28wsAtFNDDfH99s09DSft1S8LerAU5/2RJXZQ49B9BQlFl1l20jkfHik0nQyg4OV9u1/abovXpy4cPpamNFaThXtB8lMq19n5+BhYWIGkqDt4uzOK/tQo5xGu+D9tShiWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527582; c=relaxed/simple;
	bh=OUrGVouFgRVC1KBlj4tFW8fG8b2yPwjv/geLcZRlEdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTrILtGyBOafVvbAh/+Li+1XpKz2LeM1uYDCRD0mOgZ+pzlRv0O3ZPXu4nzNf0CP6tgWQgV5kzf4miOSWANf2amH08YdGJ0lLATD4vdnEX9l1H+628OlLnA8tTXj2R7DZvQNdDwRzHBjlC+2lobI4ImWE/p9xY1h8W2g9QzGcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Inyajxy6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25177b75e38so54399205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757527580; x=1758132380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UVGOVWtRHXvatY0bYJx5CVZgGyj363t5d9nI3Zws7Pk=;
        b=Inyajxy6EJwv0mNHHpP+3Nraek3HZgkeOIBqz1Ev/LZPiPEClGPYPQSFcDeTE8clh1
         dv7ifnUopplBtkjVDgsrmSRmOgjqqYlfr64zHOVBVrjKiuNMwAIIS116tJR8eiD5N4hb
         y+WV7XG1YFHr2QztcerXMEbAD+jXwskUsxlj0Y0Gqsj4N2F+Nm2X7arBRVvRRfL2b4Dv
         OX4l5f/Wpp4nUxUIdz8Bq1YG72tCt1j+eoa8tCWX8xUchC29TMgvmCCUL1lAriP5Seq+
         soPXjH7Bzog2IKqjYaO8UGDa75g1xjqsDzv0c0VBZ619mtxQiMw8aH0wv03xt6DfUPMF
         Wf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757527580; x=1758132380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVGOVWtRHXvatY0bYJx5CVZgGyj363t5d9nI3Zws7Pk=;
        b=dhS1HPPeYBuNM5JV1pfs8Gc88BP/55KapCJ5NStEfksDE5R3JPKI0S9OjS8AVq6BlN
         ZgDYZUfcye95aNHKo9ITPBSPap2bAS5+kr/xpgiBGX/YlOH7sM9SOkssLye+s0xBfyjw
         QjsOjKWDxpS3AIF20Jb7wkh7+3qbD36cZc5S3xMOUa7mttp8HUDCFYrzLKkQzwCeLFuL
         gtXNyBIaehv4rP9Yt88KUTVXKk4YNs0y107AH5WjvTob+4OZINXzrJICwCxcwC2GxBAg
         Eylg57P7fWaZW4gaBPI7XGlQmWHNG46FDmu1w23gHfx0ZjYeqKFrgSi/31d+DhE/i22X
         pn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU5Z+ds1BnXeeC7No/gizRzne7wLCaEaCZkwXJiSZz62+Oc9NTc2EE3GSLMnjGDTONjQtAq+f30hNn59s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8AT50cPN+ar+Z84vM6ccSqoLTi4kD4EjaFdlxydX6IcqBQSy
	u0iXhzEW+WcqV3MrW3MzDh3LzZtvQTgusts0NROLcGKgppG+vOpqBI8yo2ge6hk/1mVJRLDLLCa
	yDyqs8w==
X-Google-Smtp-Source: AGHT+IE/5ogtjOVM49AIkJg96HNYIRC2cVumzLNlxW2YPKSDkeUIvZ0HyOM1ZQI2TOugK9y0O3Wf9/5cigU=
X-Received: from pjuw5.prod.google.com ([2002:a17:90a:d605:b0:32b:8ba7:306a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf04:b0:24c:c58e:9d91
 with SMTP id d9443c01a7336-25172e339e2mr233912515ad.59.1757527580330; Wed, 10
 Sep 2025 11:06:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:06:18 -0700
In-Reply-To: <20250909093953.202028-23-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-23-chao.gao@intel.com>
Message-ID: <aMG-GoL5Sfn1WSG5@google.com>
Subject: Re: [PATCH v14 22/22] KVM: selftest: Add tests for KVM_{GET,SET}_ONE_REG
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, john.allen@amd.com, 
	mingo@kernel.org, mingo@redhat.com, minipli@grsecurity.net, 
	mlevitsk@redhat.com, namhyung@kernel.org, pbonzini@redhat.com, 
	prsampat@amd.com, rick.p.edgecombe@intel.com, shuah@kernel.org, 
	tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, xin@zytor.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Chao Gao wrote:
> Add tests for newly added KVM_{GET,SET}_ONE_REG support for x86. Verify the
> new ioctls can read and write real MSRs and synthetic MSRs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  tools/arch/x86/include/uapi/asm/kvm.h         | 29 ++++++++++++++++++
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../selftests/kvm/x86/get_set_one_reg.c       | 30 +++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/get_set_one_reg.c
> 
> diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
> index 6f3499507c5e..59ac0b46ebcc 100644
> --- a/tools/arch/x86/include/uapi/asm/kvm.h
> +++ b/tools/arch/x86/include/uapi/asm/kvm.h

Don't copy KVM headers to tools/, KVM selftests don't actually use them (i.e.
copying them is confusing/misleadling).  The copied headers are mainly used by
tools/perf, and they run a script to synchronize everything.

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index f6fe7a07a0a2..9a375d5faf1c 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -136,6 +136,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
>  TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
>  TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
>  TEST_GEN_PROGS_x86 += x86/aperfmperf_test
> +TEST_GEN_PROGS_x86 += x86/get_set_one_reg
>  TEST_GEN_PROGS_x86 += access_tracking_perf_test
>  TEST_GEN_PROGS_x86 += coalesced_io_test
>  TEST_GEN_PROGS_x86 += dirty_log_perf_test
> diff --git a/tools/testing/selftests/kvm/x86/get_set_one_reg.c b/tools/testing/selftests/kvm/x86/get_set_one_reg.c
> new file mode 100644
> index 000000000000..8a4dbc812214
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/get_set_one_reg.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	u64 data;
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ONE_REG));
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, NULL);
> +
> +	TEST_ASSERT_EQ(__vcpu_get_reg(vcpu, KVM_X86_REG_MSR(MSR_EFER), &data), 0);
> +	TEST_ASSERT_EQ(__vcpu_set_reg(vcpu, KVM_X86_REG_MSR(MSR_EFER), data), 0);
> +
> +	if (kvm_cpu_has(X86_FEATURE_SHSTK)) {
> +		TEST_ASSERT_EQ(__vcpu_get_reg(vcpu, KVM_X86_REG_KVM(KVM_REG_GUEST_SSP), &data), 0);
> +		TEST_ASSERT_EQ(__vcpu_set_reg(vcpu, KVM_X86_REG_KVM(KVM_REG_GUEST_SSP), data), 0);

This isn't a very useful test, nor is it extensible.  I finally bit the bullet
and created an MSR test to mostly replace KUT's msr.c, and to add coverage for
KVM_{G,S}ET_ONE_REG and KVM_GET_REG_LIST.

