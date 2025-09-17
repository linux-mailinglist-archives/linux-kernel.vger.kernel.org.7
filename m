Return-Path: <linux-kernel+bounces-821439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D910B813DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247D0627C27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26982FE048;
	Wed, 17 Sep 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR/KPStv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393F2F9C3E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131585; cv=none; b=dBnShNJy69q4mSaF0FOpza+1qi1ohxPTvsH37EMvgE1iWwols6DqtrKcWUxoiQwZji/8skDYXUkTmtyBH2gdMt82QU9wrvxrQPmmVmyO9ME0a9VUtVJogf+MaSboggtqbf9/Lb/w7Ejg7cwaGIDQCfexc/h3ztUtwQFLI1sf6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131585; c=relaxed/simple;
	bh=dS6P4Fy5DaIo/YXZ79yUSnu6NwFGN22rzXKl7LDAP5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxsNx8VDsyNFAyHnelqD/Pxe8T1dTORDO/QoTPU+17mJKkG1a3kFpglRV77il1F+ozOOKYXYmTg+8PjXvXukhAfQl1g5ERASsY9KafdjGS8sD8JO9s01JYwPs2+k9T2yDQ+Zzf41qexsU5izldJIEzpaoOtwWTK3EybvVvPoQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR/KPStv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758131582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BsOoxrYORRFuh2u0wv92Xrzi9f/Pgvquzh9J6cUQvaA=;
	b=OR/KPStvm2zmfC1NVWjcpd2bgSIZUSGJdXOpPt1ynpogJ8pFM8zKnprPH6sJpncV+6Y0+g
	ZHJTVziNtNEET+NB/YXjDX6au2lFExrPBmL7Ap6Jmsb/819KA+wiPCC3tV4815TZw5gYjY
	vnHucIZaz/zAYlWXv1y2sf2AJUQW3GU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-VIFVkLhIMqiB5CEwua7jSQ-1; Wed, 17 Sep 2025 13:53:00 -0400
X-MC-Unique: VIFVkLhIMqiB5CEwua7jSQ-1
X-Mimecast-MFC-AGG-ID: VIFVkLhIMqiB5CEwua7jSQ_1758131579
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2b9b958aso549605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131579; x=1758736379;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsOoxrYORRFuh2u0wv92Xrzi9f/Pgvquzh9J6cUQvaA=;
        b=F5znTpIZZWlEknSH4LJh1iBkN81J55P9tgqKvY5g8gmhAPckfDzbPK5Gyvlf1ebsXK
         zSfbWkS1m6OB/hF93WavvqNnjED+1jPhpbXPUmHn/bDQr7OPMEaQCIyoJQgVhiVo8h5g
         0SUK9cyzWjsyo4dhnUdDvK17r4Xk+49RtPrldr6IwXkXUr4ctf0GrxxOwZwaKvLyKTc/
         OoH3Mer9zxOcbjn7/HfkCLXu/bqFeybTdjNC6vZXzBH8IBtzBzju4ATBCqa0u9Dk4oYU
         gchEIX/yOniq+Y4ngOyc+tA6WTiJSA2sRJs7MhuEXcfA++9D3A9zJ+oQjBhrehs+CPkZ
         5hkA==
X-Forwarded-Encrypted: i=1; AJvYcCWhNxZ17gp55gpz9R9GnMvvehvrX6PQcLWukn7nhYGLH7QmD0c7YllcT4ZshNBbihz7nqqMbDrwZMHhfHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxnrs76SyxdwgXuVyLDLxaYhcVTCB+2hnr0SIlWu0t8OXK5oTP
	SzgvdTZfgHGW3v3pCfCHLst68qLpv7WwMMP4obrdSCI7yQHXijFEtwKisIg9PhOkNgX7Jr1mQOr
	OmZrn2KCwNlgZLmm4UuEUWf+zX1/ZmTwc4w2idjhI7ATCVL/9Q4xCXT+jOLhrhP98qg==
X-Gm-Gg: ASbGncvmgk4jRqqBi/OwrhmnkEy8/1y6pjRoxYiGm0Z/xqwoWdgRs1UptGYGZDzqhBV
	YUzJSwbxD4Jv2N83K8nM/ehYQBmn8/g8cVm4EfUBH49JWRxjt/QEyaRuSKtNpTlCEe1+cYA4Eck
	arBZeyPvou+T2DQ5qVpI5zPJkS9IqEvOtmhW3prniDKGz2Mhi9kWsszXcFxwOoG7noFD8gk0w99
	pKZ1J+qQyWtyCMP6cF+GRGL6dnNcrXSRGvfvbmhiuHETs3V9D6kNuplvByk6f3S6bxFLS5Gwoa2
	d7mZR6n8NBnLBytobR/XRcPyMTqddY64HS/nzV1YRHtvQCXaqVLT0zJsdvPMzYEHc2HLUJF5dfN
	+0O2oJ8ss+ajgxDnLIKyONoF9bIBF1ETLFTjVaNeFxwE=
X-Received: by 2002:a5d:5f42:0:b0:3ec:4fe:860 with SMTP id ffacd0b85a97d-3ecdfa2b563mr3351045f8f.46.1758131578744;
        Wed, 17 Sep 2025 10:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZDdQECqdk4ftkeQUe6DwCYOxRwirGTAlmfFW6vGHNCCmEwkLY9talzACO0i02UjlIlTW7Ig==
X-Received: by 2002:a5d:5f42:0:b0:3ec:4fe:860 with SMTP id ffacd0b85a97d-3ecdfa2b563mr3351017f8f.46.1758131578324;
        Wed, 17 Sep 2025 10:52:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc72f5sm213279f8f.39.2025.09.17.10.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 10:52:57 -0700 (PDT)
Message-ID: <0d38af14-53b9-489e-bd10-27bb6c7af470@redhat.com>
Date: Wed, 17 Sep 2025 19:52:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KVM: x86: AVIC vTPR fix for 6.17
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250916003831.630382-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250916003831.630382-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 02:38, Sean Christopherson wrote:
> Please grab a single fix for 6.17.  The bug has existed for some time, so it's
> not super critical that it get into 6.17, but it'd be nice to get this on its
> way to LTS kernels sooner than later.  Thanks!
> 
> The following changes since commit 42a0305ab114975dbad3fe9efea06976dd62d381:
> 
>    Merge tag 'kvmarm-fixes-6.17-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2025-08-29 12:57:31 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.17-rcN
> 
> for you to fetch changes up to d02e48830e3fce9701265f6c5a58d9bdaf906a76:
> 
>    KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active (2025-09-10 12:04:16 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM x86 fix for 6.17-rcN
> 
> Sync the vTPR from the local APIC to the VMCB even when AVIC is active, to fix
> a bug where host updates to the vTPR, e.g. via KVM_SET_LAPIC or emulation of a
> guest access, effectively get lost and result in interrupt delivery issues in
> the guest.
> 
> ----------------------------------------------------------------
> Maciej S. Szmigiero (1):
>        KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active
> 
>   arch/x86/kvm/svm/svm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 


