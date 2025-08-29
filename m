Return-Path: <linux-kernel+bounces-792434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04399B3C3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C65C173CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6C271462;
	Fri, 29 Aug 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9xPX+it"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05143451A5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499895; cv=none; b=dAw2A71/wPUlHb7afOgkZ3klOcVjEuSN0xXCwMgTndqhsQxMA6SJ3tR/zkYHeLCN6x1aKUrruo6alfSuGvAc+jd371jjv/2sD/4fZ78f5sXJwmttu0c2g94C3glgQ4q7JDN6My4pP0GSb2npaeaSnGrtfDIu1PsEemvpI5PCrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499895; c=relaxed/simple;
	bh=TdNF0rfgV0VHRMX8IeG8YvWVl2OWePe9R39tCBmM5oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cwLr3EueDK8ktDS066oj+ETs5sP6aOyYN7Y+aU/+7RDVBI+NsF2tlQmp44tlU9tk83X6wHDZ8EduBp6qLYBCBHmT3EzYbFiwygb3G6d2nxlZRHh5i0S+UQGBp9E0BcGO85pfAhrDYJx+FiFVNh008g1GX+5mEEUI6oez2TSvFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9xPX+it; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327706e0642so4077239a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756499893; x=1757104693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd39rUGECk+rHT5205Jy1pAxAHPTjmOemrBZEd3ePt4=;
        b=M9xPX+itjAX4pcjD1NhjP3RlSRpLs5F3945x47soaDOJe2Y6BFfNufZr0xNwPVV4eN
         cGrRsJOT/nTHF44By61fVAg2+e1/3i8N6S39M+qY1dHalhxWa1CoczUfHa6vswkVTvOf
         /uhUSnOvQfcYmvux5LDOtn8FBr9rMz1xjLbh7YzCvhuoMjJUJGt3+Xin7x83yFJyQSL3
         ELXyS+jkTxHizH7KPixgm0WxMOIjZ/YMi5dM3gZTTzJ5AmfBNYLAlC6FHSfcElhANQUV
         dP3k6NkVetxwKogHlzpR29NnSaPUZu4MFnwrOxNvi2Jd62JrCyz6+WJ2Y6t/T+sfrf48
         bnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499893; x=1757104693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd39rUGECk+rHT5205Jy1pAxAHPTjmOemrBZEd3ePt4=;
        b=AFkJEpuvvTIds3yrnF93z4xd6fuRsV0AodqgtSCcjqoQPw+wpPrmqS3PeAcLF1h/pj
         YxtB6Ny9q1FhUVPS4vtaniJ9uPMinRtXTKZ4o0X6DM0Fb3JkxkalIMIUqtnfqKnX3rug
         yXzfpTWqkseJNQ/idXZCW036/fuixc4V/IQRQo5sKdm2HLPy17twUqGvQX+Y3aQzUVEz
         VrwEhqrDsTiF4SBO8Jvauows/uhJx/sxCOIqHkjfJ6Wr4O7WymA2tDydC7DcQxNyZLOm
         lO24svT46RF9JMKz8wcMTePa2p0+iFW7CjrT5ys8LDqMI9McwDMbbrVF3vOZV1QlfIcY
         gMsA==
X-Forwarded-Encrypted: i=1; AJvYcCWFpP3eUk4b3HduDUVTOYirwjWcjecMIptlyVe3sj58csTnLGc3ISDhjuoAloYK0OLDV7Yyz13eQBerMHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4OUKS4eUJZUBmAAs2GL4ibJAsg9KUOLsEGaSi20ssRYH9TGA
	nnVLJO+Zm3HGCMFvJuFVKonyQms2DyPdG080KPmi6RZbR5n7A2/DvdKpnE6e+9zvmFSntBNtIwC
	oNkxsRw==
X-Google-Smtp-Source: AGHT+IGbRKcpJtJXxkGfMF7qVHfw+rJ15N7Av9i4B9mmR8F5Rd6/k2vtLv3vdjeoQhg79ZK6pefzoikNRho=
X-Received: from pjbpm11.prod.google.com ([2002:a17:90b:3c4b:b0:327:7035:d848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc6:b0:327:96dd:6294
 with SMTP id 98e67ed59e1d1-32796dd6549mr14897061a91.37.1756499893148; Fri, 29
 Aug 2025 13:38:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:38:11 -0700
In-Reply-To: <20250829142556.72577-6-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829142556.72577-1-aqibaf@amazon.com> <20250829142556.72577-6-aqibaf@amazon.com>
Message-ID: <aLIPs7eqA_i75Bgy@google.com>
Subject: Re: [PATCH 5/9] KVM: selftests: Prevent PAGE_SIZE redefinition on x86
From: Sean Christopherson <seanjc@google.com>
To: Aqib Faruqui <aqibaf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 29, 2025, Aqib Faruqui wrote:
> Prevent PAGE_SIZE redefinition warnings that can occur due to namespace
> pollution from included headers.
> 
> Add an #ifndef directive before defining PAGE_SIZE to avoid redefinition
> conflicts.

Please provide more details on what is causing the conflicts.  Blindly using a
PAGE_SIZE without _knowing_ it's aligned with PAGE_SHIFT and PHYSICAL_PAGE_MASK
is far from ideal.

> Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
> ---
>  tools/testing/selftests/kvm/include/x86/processor.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 2efb05c2f..3f93d1b4f 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -368,7 +368,9 @@ static inline unsigned int x86_model(unsigned int eax)
>  #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
>  
>  #define PAGE_SHIFT		12
> +#ifndef PAGE_SIZE
>  #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
> +#endif
>  #define PAGE_MASK		(~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
>  
>  #define HUGEPAGE_SHIFT(x)	(PAGE_SHIFT + (((x) - 1) * 9))
> -- 
> 2.47.3
> 

