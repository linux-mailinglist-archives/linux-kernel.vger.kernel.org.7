Return-Path: <linux-kernel+bounces-836356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC34BA9752
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3556D3B2AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0E308F35;
	Mon, 29 Sep 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzMTMIUI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662E3090E0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154380; cv=none; b=GfiZvtNAdvLtva8KrruTJBWX+l1vXI9B/dLvFTwwU6xv1TewRUAC6s9UCIv9lw4sUnI5xoUS3rnN9MPn0uJKaRvDQdlhWPLGrLOAeqMh9v4FmURhJMf+qw1/JBnFTISS8gbrICmLoMbjtwB6n22S70xgVLCOK4JBN6r187B5rdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154380; c=relaxed/simple;
	bh=7uitIzQ1GatOj3aC/wPhGEU9p9oB81Xc0jNEY+fNKWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iy4GRK0moXioL6SbiZrkjIrwBvxXzDANyZHncA5sxJB6lDOXZU5SBZh5XvI+pxWGiL4aOJLs8cw3+ansiFVjCi1fNSrGE+p8o0wX74RQtdmVa+4UFP46VI1SkrIEBA/OLHW9Y9cr4FZNpYrUYez9Y+JRvWi5i9M+V3wI2ZLJ8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzMTMIUI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3714196f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759154378; x=1759759178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipfI8eVx3bzgfWjoq31uPWRXd4Smibc+RtoSzpX+z2A=;
        b=SzMTMIUILcV4p5Dzp5abWBb3KdTMobSaXTIJ1eOtbZd+YHcJVCt17QBDJrlPd0uYf5
         Aa/zOoFTlW0L1Zzssc4U5hZovWfp+yZ/dzEfIJBvgDWpOXd/exNpUzf6pABMnUQ+s0Bb
         B0WDgyZiFTKWNaLnJiRayvlAG4c4ARcDBs9725UwIvLh3khyeuhqdBaVUsv1a7FFwJe1
         I5Spb7dz8kvoX2H+1rHG4n8QiW3J57hok55RRiCSQ8zOb7ki/tncIGW8BXokwemvPzZv
         eekbBP841OvEeN62U4oqkKQTu1IQBd/zYsHisLp7fCLLs4skUghYBe1W1chXPw7iJSVf
         RNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154378; x=1759759178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipfI8eVx3bzgfWjoq31uPWRXd4Smibc+RtoSzpX+z2A=;
        b=KPhwQSB8dM87Hs9iiDY2aLDw+3fGZopRIG14X06taRpOlor/1j7BlB1stoWA9q/QOM
         XyJ9uq1kc0v6+ATTE/4DuVYJpzrITGsG4+ctSXX13X8stls7q7rxmvrisKbzA2wkwXX1
         RaZoyQ78OYt/zJ2Sl2mvEco6bPtszcU3cuRl4JW0syAu+fhfeaiKRxyDlkVlGTzBbHrg
         B3/jcJb3FKjQRNxRWm+DcV4FOJ69PRkJk5RC8k0zMDpO0XVwTyQLyo3pERC8gKMNUffa
         CXT6RR+oANHu6a46hJMwDvn57ZzhuvHblw+HsHymuuNrjNw3PY6MC7ATLYFqISlyt8MO
         +cCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBS9FyzqSO5uA54CJ6OQOOQ8YHcfvq/2LGKrsluF+NBVNWBT7L/McdMUAP84E7JZyYEBVGsIfe6hSYi90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuh6OFgI5ystNCcvIMWb9IwRzMc/H4jzpjxxxdbroeH9yvO4Le
	X9ktEKie1Uvp8DPm2l8kTDeMD96eURjaXVHuaRDCGUj64Cdles1msDjE
X-Gm-Gg: ASbGncubMXKSnBciIR9k4T+v4I+F+BMG1RjZ1cTyy5JDk/0whyW7zXxYLGwaGiqZJEg
	grJ4rSYnSivfV8T7TiNaKJ8eUulS3F4KRn5QbTpphfQ577NaOG8ZqXidh8ddPo03wIPg5olKzWU
	/ki9wA2rqL8XKFeKE3nMiur1xM4LQ2fBIQT+pLW31qwnq1LTccmhZwWGlycakAims8c6fz2L0/5
	uvunirUZRdQegvC57B7FLoA8WhXt3pvCNMM6e2sqGPCvoEgTsgYnCsrKGziI+jmZ/p2QAk+4QCa
	+11xANsNXSCt37k4N890wpiIVM5xNo8LhnxuOBz0wu3AMxUiMaHkBEjeSpT2ANOFwICyXJCCoCO
	6RuLiWLcnh400vWUCXbml7LkOwTR+sUzQmA2NCnE=
X-Google-Smtp-Source: AGHT+IGmk8eIupNHH6e8ZECR90n/BecDA3d0fPOnthyKhQCMVja8jB69/O5wl6BImeD5SJG0fNGoiA==
X-Received: by 2002:a05:6000:2203:b0:3ea:63d:44ca with SMTP id ffacd0b85a97d-40e4adceb15mr13337551f8f.32.1759154377256;
        Mon, 29 Sep 2025 06:59:37 -0700 (PDT)
Received: from [10.24.66.14] ([15.248.2.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm18227650f8f.58.2025.09.29.06.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 06:59:37 -0700 (PDT)
Message-ID: <7d109638-3d26-443a-b24d-eb7a0059b80f@gmail.com>
Date: Mon, 29 Sep 2025 14:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] KVM: arm64: Add pre_fault_memory implementation
Content-Language: en-GB
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, pbonzini@redhat.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, isaku.yamahata@intel.com,
 roypat@amazon.co.uk, kalyazin@amazon.co.uk, jackabt@amazon.com
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
 <20250911134648.58945-4-jackabt.amazon@gmail.com>
 <aMMYKqWsAZ4y0WI7@linux.dev>
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aMMYKqWsAZ4y0WI7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

Thanks for reviewing!

On 11/09/2025 7:42 pm, Oliver Upton wrote:
> On Thu, Sep 11, 2025 at 02:46:45PM +0100, Jack Thomson wrote:
>> @@ -1607,7 +1611,7 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   			    struct kvm_s2_trans *nested,
>>   			    struct kvm_memory_slot *memslot,
>>   			    long *page_size, unsigned long hva,
>> -			    bool fault_is_perm)
>> +			    bool fault_is_perm, bool pre_fault)
>>   {
>>   	int ret = 0;
>>   	bool topup_memcache;
>> @@ -1631,10 +1635,13 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	vm_flags_t vm_flags;
>>   	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
>>   
>> +	if (pre_fault)
>> +		flags |= KVM_PGTABLE_WALK_PRE_FAULT;
>> +
>>   	if (fault_is_perm)
>>   		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
>> -	write_fault = kvm_is_write_fault(vcpu);
>> -	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>> +	write_fault = !pre_fault && kvm_is_write_fault(vcpu);
>> +	exec_fault = !pre_fault && kvm_vcpu_trap_is_exec_fault(vcpu);
> 
> I'm not a fan of this. While user_mem_abort() is already a sloppy mess,
> one thing we could reliably assume is the presence of a valid fault
> context. Now we need to remember to special-case our interpretation of a
> fault on whether or not we're getting invoked for a pre-fault.
> 
> I'd rather see the pre-fault infrastructure compose a synthetic fault
> context (HPFAR_EL2, ESR_EL2, etc.). It places the complexity where it
> belongs and the rest of the abort handling code should 'just work'.
> 

Agreed, it looks much better with the synthetic abort. Is this the
approach you had in mind?

+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	int ret, idx;
+	hva_t hva;
+	phys_addr_t end;
+	u64 esr, hpfar;
+	struct kvm_memory_slot *memslot;
+	struct kvm_vcpu_fault_info *fault_info;
+
+	long page_size = PAGE_SIZE;
+	phys_addr_t ipa = range->gpa;
+	gfn_t gfn = gpa_to_gfn(range->gpa);
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!memslot) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	fault_info = &vcpu->arch.fault;
+
+	esr = fault_info->esr_el2;
+	hpfar = fault_info->hpfar_el2;
+
+	fault_info->esr_el2 = ESR_ELx_FSC_ACCESS_L(KVM_PGTABLE_LAST_LEVEL);
+	fault_info->hpfar_el2 = HPFAR_EL2_NS |
+		((ipa >> (12 - HPFAR_EL2_FIPA_SHIFT)) & HPFAR_EL2_FIPA_MASK);
+
+	if (kvm_slot_has_gmem(memslot)) {
+		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
+	} else {
+		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
+		if (kvm_is_error_hva(hva)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
+				     false);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	end = (range->gpa & ~(page_size - 1)) + page_size;
+	ret = min(range->size, end - range->gpa);
+
+out:
+	fault_info->esr_el2 = esr;
+	fault_info->hpfar_el2 = hpfar;
+out_unlock:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	return ret;
+}

>> +long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>> +				    struct kvm_pre_fault_memory *range)
>> +{
>> +	int r;
>> +	hva_t hva;
>> +	phys_addr_t end;
>> +	long page_size;
>> +	struct kvm_memory_slot *memslot;
>> +	phys_addr_t ipa = range->gpa;
>> +	gfn_t gfn = gpa_to_gfn(range->gpa);
>> +
>> +	while (true) {
>> +		page_size = PAGE_SIZE;
>> +		memslot = gfn_to_memslot(vcpu->kvm, gfn);
>> +		if (!memslot)
>> +			return -ENOENT;
>> +
>> +		if (kvm_slot_has_gmem(memslot)) {
>> +			r = __gmem_abort(vcpu, ipa, NULL, memslot, false, true);
>> +		} else {
>> +			hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
>> +			if (kvm_is_error_hva(hva))
>> +				return -EFAULT;
>> +			r = __user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva, false,
>> +					     true);
>> +		}
>> +
>> +		if (r != -EAGAIN)
>> +			break;
>> +
>> +		if (signal_pending(current))
>> +			return -EINTR;
>> +
>> +		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
>> +			return -EIO;
>> +
>> +		cond_resched();
>> +	};
> 
> Why do we need another retry loop? Looks like we've already got one in
> the arch-generic code.
>

Good point thanks, I've removed that now.

> 
> Thanks,
> Oliver

Thanks,
Jack

