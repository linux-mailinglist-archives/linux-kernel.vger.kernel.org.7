Return-Path: <linux-kernel+bounces-810766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0DB51F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92D5445A41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C432F741;
	Wed, 10 Sep 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4PAFdCY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086127B355
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525749; cv=none; b=qRPnoIjkuIm1f5V9u3Wt/WoYHBaqBp6Y6t0kRUm7KaiaaKLqU4G8hNURoSlkN7hwMuV1RGNpgjWGhCqiCv/u0dzjOe8tl/j7XTFs+R6fq1OARBmIQ/gW+glKTEwgDpGLv/eF2csEnfnfRD8Hm6LWKUbY9HuSCAaqbJGrn78GYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525749; c=relaxed/simple;
	bh=loP8HPZivD7ACH7V0w4NocLfwXke5eDWmuUP7xIp2Z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oJUOelYyahiCg9G5Gawfs7kqMWmaFOIN0HpEMHXdddepAN6ra3yus+aWH08fVN93qH8BRyg4NezYwM24/tYXzKPigpdSu880NkbImqdHJUECBKe0pJE025nIR7CaubJrUIpk5GHQLSRZULFnjFAK3GNPWXaFHRe0d++lcx7io3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4PAFdCY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77422201fd8so5516514b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757525747; x=1758130547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iO/ZsYGSbIMx/Phc3/cDa0lxkPb1F9j/LU0uE5Fnnto=;
        b=X4PAFdCYSl1/pZxIDqzNV6WvD4AB03G2FCsW5G1WONJaEBhA2KivgPiNCBn+1TKcma
         Qaqg1Y+l7jNeNuvrAricI6/io4os7NJyndt2uYzrd2BUwHidg7pWm10VfVgAgh9Rej7w
         6KVLxUBBoAZrs9y7GAm34p9UNNvTQqK2ra8P2Nh2WO0DHhOqRChtEN7dGQtDIQALP5Eq
         gZ/JwGB0uKNpdIrvaMj5pEyAmQxu9Uumj0eCmqci8Aqu13uoXTVL9F2r33vYuZOPx+fK
         h38bMAf2PJgg+d2J3TcVrlTDK2k+T24wr7k8oDAjkVfbU6ciw3J363mufGUS8fUbboJL
         HMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757525747; x=1758130547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO/ZsYGSbIMx/Phc3/cDa0lxkPb1F9j/LU0uE5Fnnto=;
        b=szZ+0W334ACAEGEaHeyBUufSyC9AWg4Ec3GBqhrvoKe9aNhjcoN2n/O+FRedDDyoat
         /pZ3iKSYYmlzuI+NlG5t8v4L+RhI0Lsn5xAKPiKVfjn/j+81LV0I7uUkp/oTffEiYIpj
         KA45AG1qG2ii3lcaYu2ttS8TvTp9zZSq6LO1w278TYgNOhtpvTalvwBxrpswmDWDeU7R
         2VP8tNXWK2h6v8GoE33qT1Va8+W0WdnmQ3Hki44VM2Bfbawovma0JhR8KhgltJC7sQXM
         kzpolZRE6/8zhw3yDGtTbELbzKU7aEtruAHhY/6MRdgXfj9XDCl5OPnvKAeEs17AbWiR
         OxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKJDqK8LrkmIIhLqmZiXstkUWu/pVpwqGuqzZsM5E4pBg33tkHpLbnnwDNzTkrEc/7YieYIT17Q0jCpBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMB4x+0f3Q6YMu9KNpzTZli1fxfUV4U4QqivNryaBtn8UIZL6
	Ac35Os9L/fcGMR2kXdPNe8I1NphtskwS/LfoV1wSoE3dO+zdiC1jq30rZu4qVhtoeekjaQlpf11
	c2PWGIw==
X-Google-Smtp-Source: AGHT+IEBzSQdUHmA3TyEKJQlmkFhZJqc6bnksPf3qYWhh2BEicugNPiKD9TbhOOHbK5k4iJSThyP/B45Vzw=
X-Received: from plxb5.prod.google.com ([2002:a17:902:bd45:b0:248:6b51:1364])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b8b:b0:249:17d1:f1d5
 with SMTP id d9443c01a7336-25176729912mr186178225ad.60.1757525746596; Wed, 10
 Sep 2025 10:35:46 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:35:45 -0700
In-Reply-To: <20250909093953.202028-2-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-2-chao.gao@intel.com>
Message-ID: <aMG28ahWdS-2gHk6@google.com>
Subject: Re: [PATCH v14 01/22] KVM: x86: Introduce KVM_{G,S}ET_ONE_REG uAPIs support
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
> @@ -6031,6 +6071,44 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  		break;
>  	}
> +	case KVM_GET_ONE_REG:
> +	case KVM_SET_ONE_REG: {
> +		struct kvm_x86_reg_id *id;
> +		struct kvm_one_reg reg;
> +		u64 __user *value;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&reg, argp, sizeof(reg)))
> +			break;
> +
> +		r = -EINVAL;
> +		if ((reg.id & KVM_REG_ARCH_MASK) != KVM_REG_X86)
> +			break;
> +
> +		id = (struct kvm_x86_reg_id *)&reg.id;
> +		if (id->rsvd1 || id->rsvd2)
> +			break;
> +
> +		if (id->type == KVM_X86_REG_TYPE_KVM) {
> +			r = kvm_translate_kvm_reg(id);
> +			if (r)
> +				break;
> +		}
> +
> +		r = -EINVAL;
> +		if (id->type != KVM_X86_REG_TYPE_MSR)
> +			break;
> +
> +		if ((reg.id & KVM_REG_SIZE_MASK) != KVM_REG_SIZE_U64)
> +			break;
> +

Almost forgot.  I think it makes sense to grab kvm->srcu here.  I'm not entirely
positive that's necessary these days, e.g. after commit 3617c0ee7dec ("KVM: x86/xen:
Only write Xen hypercall page for guest writes to MSR")but there are path, but
_proving_ that there are no memory or MSR/PMU filter accesses is practically
impossible given how much code is reachable via MSR emulation.

If someone wants to put in the effort to prove SRCU isn't needed, then we should
also drop SRCU protection from KVM_{G,S}ET_MSRS.

> +		value = u64_to_user_ptr(reg.addr);
> +		if (ioctl == KVM_GET_ONE_REG)
> +			r = kvm_get_one_msr(vcpu, id->index, value);
> +		else
> +			r = kvm_set_one_msr(vcpu, id->index, value);
> +		break;
> +	}
>  	case KVM_TPR_ACCESS_REPORTING: {
>  		struct kvm_tpr_access_ctl tac;
>  
> -- 
> 2.47.3
> 

