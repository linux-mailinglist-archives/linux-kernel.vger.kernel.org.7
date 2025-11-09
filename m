Return-Path: <linux-kernel+bounces-891830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB9C439D8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13A63AE537
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6569241114;
	Sun,  9 Nov 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHC2pbg/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7sLJHUH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01921423C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762674181; cv=none; b=hXo7xgqOZeFKYG/rxrkeInMNNcaeDR1DrNQzR/T7mrQVqS2JZ3/T2YgylV5LMK514B1km7IjgmvISt67a0vkH8U4T6IIFRzmuS7ELd7umrLr8zmGrwfYebXNuYN0i+7ztobUdREC7w6JKkG02vNfaBDNbu/CmCWXfkSvWzGaTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762674181; c=relaxed/simple;
	bh=0l6kSDxuZolXxPvtX81Imos77pzD4xL9UNkd4sLU+f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upb8e9esq1VeY8tXnDap9xZFQ7XJvpa1hwFdH3SYGGzDZ5UX4lXRnj8xdYwYaUJDxxPolU6JX9CHNV3FcdLHjZcYakkqsty11WdrcpGpBxiwIHYJHWnWFAconSp4kWxx30pCo5csWXGNWeTFSl4IiA7DNwtTP30sQJ8qoyxpto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHC2pbg/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7sLJHUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762674178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7l+lGeZ8zBElsB2/hWui9sncARHZER0YlsEox3jgWYg=;
	b=hHC2pbg/cT+SuNFdqdVSzqVyBSnUfpmxkzy//hUlGnhZNnrUOAJfA86Uf3yf9lfX1vJZx3
	KJeoQZDSqnD3thwssG3XcTqJwvGt2Q/XYQoNnlUq65nSBOeuJplJ4oD4OE+SozthVf9PU0
	LfdORdzjZKiXbgymZECS15c3AFgz1NQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-TJrUVmIBNSiYnoYpAPUiaA-1; Sun, 09 Nov 2025 02:42:57 -0500
X-MC-Unique: TJrUVmIBNSiYnoYpAPUiaA-1
X-Mimecast-MFC-AGG-ID: TJrUVmIBNSiYnoYpAPUiaA_1762674176
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d40007ea1so159463066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762674176; x=1763278976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7l+lGeZ8zBElsB2/hWui9sncARHZER0YlsEox3jgWYg=;
        b=R7sLJHUH6CsxJXxK3EMgG8rDA5qWp3H6m3fSMvf0hX62iwoTDD92Nog7A6J6/Ex+Bi
         HLZdvlqMeAbWdYEz2tAlBSF1hNcIn/Ws6yj6oa3uode2q4z14Z+t1NoekqneohkoXjys
         4fKmPjJ3F8Ro/g/hHsQolL4qo+KUAegIBK5NAM3kCcRj4jpBu/8LpDe11P5U2zWKSMJp
         TjaiWcRhDnKpf85QjZ/xXSuxHyc88V6UtHsJor9e0r1rSFZmzitucYW/lC80vAMYHack
         HsZnceElFy4Y/B0G0+/d6DH8m6DCc8C5PbYj1OnvaE//+/+oYNn0h1v1q8MldeGidYdG
         H4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762674176; x=1763278976;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l+lGeZ8zBElsB2/hWui9sncARHZER0YlsEox3jgWYg=;
        b=TjyCPTFNFtl7x+Tzft+RgderKDDH8Q303q/Xo6avf0mihog91Nyh1fQEPU+z4v40B6
         RfWGjBw9TeP/4oYK/l4chnr6bwWzhiovcuat+D2b+U3R4iVbYTj0hDCeHmLMKVVT8dG7
         d3Z7R+QQi+qvFW2pWZbgciYvnWbGEmj0Aqd02HLPSgNzHmyJ18Eg12QgfmOrVbc4xIzh
         l66K6ueYHSOpFD1850JADGD9Z2qbuBQr+QiGw53AENIbYrNlmQhUFmftvifzxon8glDz
         7JBZuejbwGjf4fkflQQjH9zg4B0lqoo9GZL4Dd9NFcxWBn6L9QMpU9jQXI0n2B+jxD4z
         JspQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqWvLnhqH93IW8fA3STJdwiKtyqw31vjEQKnnbdHsCUSiRipcI8ORRRZQvjx9AdwAJj07QBS9iBQGUD7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9YD/nlbOxQcqrf/4ShV6zMk0vyOxjHM3XzmBT2d3JDQsV19S
	Nb0J7Pnz4q7QLd1C/jNuHkRBWyTzM2L0RP5eJ5FtbVW3vyxKgKdibftj0JHGpZzhlh2tbeAjyQi
	1s/dgsVhvYX1S3E2NYYgdWJTeJ6wylaccDaZIj7fTYGdoOqUGRGs01KM+DQgxr3d69Q==
X-Gm-Gg: ASbGncsPY7cg1H0AuMJi/rREL5L1YjOgaIvX7OuYqINinn9W9pkNMPvSPjy0N62qQmO
	jPkS8bNb65gq1lqyixAfTEPDDDK2q+Z5lfgnVghCJAmZygD2+DpO6xlq7tnuMOpsvBQRytTjHIV
	/OfX2tiYlxA55jWfZwgF/ivU+uc1vCR81cKhWNObzpreq+gjH6ZPXadjokScO3br+GLOawmoyFY
	zZFbFzZxeNE+twq8OsGDLxuq5fATjDmpKKbfOOHxpCnbscJvuBHXUXY9qDLr9fvIi8r6LSzlwXx
	pXAg90b0v3XdOMCdXaReZSOYryQwyUUb8BHF2QWG8XFe6h1m2Clk3R0+6UysVB/P9yjWiEBWUM5
	Vj0rvFQjjaLMoNsqnqCmRRDetNZuFG63090dpXHyF/2b0vQqmDJDGMBmRnRf2n2D4CyyrFYo0Hr
	zDX1TJ
X-Received: by 2002:a17:907:2d22:b0:b6d:7b77:ff33 with SMTP id a640c23a62f3a-b72e02db6bfmr380121066b.19.1762674176082;
        Sat, 08 Nov 2025 23:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZQB94vRvTudvuLEaO7R+cm3s9oXIrJERucltzdm1MPb3XJt9DN7Y2H/ORMphe6ximrdmO9A==
X-Received: by 2002:a17:907:2d22:b0:b6d:7b77:ff33 with SMTP id a640c23a62f3a-b72e02db6bfmr380119166b.19.1762674175662;
        Sat, 08 Nov 2025 23:42:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b72bf9bd36csm766237366b.61.2025.11.08.23.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 23:42:55 -0800 (PST)
Message-ID: <b46bfeef-c728-4598-a047-fcdad2d42d6e@redhat.com>
Date: Sun, 9 Nov 2025 08:42:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] KVM: SVM: Mark VMCB_LBR dirty when
 MSR_IA32_DEBUGCTLMSR is updated
To: Yosry Ahmed <yosry.ahmed@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Rizzo <matteorizzo@google.com>, evn@google.com
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-2-yosry.ahmed@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251108004524.1600006-2-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/25 01:45, Yosry Ahmed wrote:
> Clear the VMCB_LBR clean bit when MSR_IA32_DEBUGCTLMSR is updated, as
> the only valid bit is DEBUGCTLMSR_LBR.
> 
> The history is complicated, it was correctly cleared for L1 before
> commit 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when
> L2 is running"), then the latter relied on svm_update_lbrv() to clear
> it, but it only did so for L2. Go back to clearing it directly in
> svm_set_msr().

Slightly more accurate:

The APM lists the DbgCtlMsr field as being tracked by the VMCB_LBR clean
bit.  Always clear the bit when MSR_IA32_DEBUGCTLMSR is updated.

The history is complicated, it was correctly cleared for L1 before
commit 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when
L2 is running").  At that point svm_set_msr() started to rely on
svm_update_lbrv() to clear the bit, but when nested virtualization
is enabled the latter does not always clear it even if MSR_IA32_DEBUGCTLMSR
changed. Go back to clearing it directly in svm_set_msr().

Paolo

> Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
> Reported-by: Matteo Rizzo <matteorizzo@google.com>
> Reported-by: evn@google.com
> Co-developed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>   arch/x86/kvm/svm/svm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 55bd7aa5cd743..d25c56b30b4e2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3009,7 +3009,11 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>   		if (data & DEBUGCTL_RESERVED_BITS)
>   			return 1;
>   
> +		if (svm_get_lbr_vmcb(svm)->save.dbgctl == data)
> +			break;
> +
>   		svm_get_lbr_vmcb(svm)->save.dbgctl = data;
> +		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>   		svm_update_lbrv(vcpu);
>   		break;
>   	case MSR_VM_HSAVE_PA:


