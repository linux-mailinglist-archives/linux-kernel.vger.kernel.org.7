Return-Path: <linux-kernel+bounces-743073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF3B0FA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576AC582362
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136022B8B5;
	Wed, 23 Jul 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JTOj3tO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A5218584
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294906; cv=none; b=Gs6eGXV77NKjuNHt6ahaNWhJ8icKzGrEK85gD+fmU5JzuG3f7dQx7jRzxbWEDsyZvxc8vL/YkVxVgcR/PmNZBONcWKDDHVH7wWzZO528TC1Il5AzqLrN4hoCARN+kZjndwU4LFcfcb51rAQ8bs0BOuOaqbJuzQHnRv5fWaiCbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294906; c=relaxed/simple;
	bh=VqIngfHCPjNn2aJvm/JpMowD1ulG5Y/mqzv4IonmpQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KtozDIDZT+HSqW1paJ0s/hUAClDB+hZII3wfuJVKregZLP2SP7E4MRN7F7Uxia9O88hD/CTbdz1FjVqg1ID3/HWvX6aolNqWvZmjulPXfsDmTMLWipYP+ju3sjZHUFruaa12kKi/oFWro8nDrxSAFtBksnvLnXoLBg4f5LpEvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3JTOj3tO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so124997a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294904; x=1753899704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DG7M6lyjDlWLPjJAB3sObE4Is8Lu2eOsJs2zd5O8jM8=;
        b=3JTOj3tOW7Yt1MCWqdu7IwMjj0v+5YXRWjIdmkdWaI62r2br9zqQkqtPCyEc9DVXXo
         ui1ADSh0WXU9Yo5RgduVzgw6y8RgyRlBkbSeSXUXrFb8oLtUKQ0aHyru5wSzRkhC8a4L
         riqy+raHP1XnR65GLwtW2vVVHM3xNnehrzp1R5OSMxmvgy6Q2PnS9azlG9js1VeoMXR9
         eEu4ocjoAv9kaVduhTbqRaRpurUGegfcn1GE0Q/Ma2crthsvhPso03MQYMB9PAUeDCOl
         eFfTNNCI3V/ozXI4jOsBA1rm3RiFbwuSSrPnHzRcmhqL8zA5GA7ge2VOO4o1yWoL0++N
         kbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294904; x=1753899704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG7M6lyjDlWLPjJAB3sObE4Is8Lu2eOsJs2zd5O8jM8=;
        b=kZgUw46LaUdK/zImOnkOEZrrLJ4JgMb6BPmET0R6rwlPRhsWzBHnnRJNLQWC3mUFvM
         4NpQdUgKA+iQ5fnVgNXJ5xte+nS/mQxzeIPQnWvdhr2YlyybIWJn3J8wg01oU7fbZkJS
         mcbJmSP/El+iG0Fz67oAL7MzqOBXJQ+nYTe513Ba3ozu+D3/UxbYDbq+JlyAHfkLZhQI
         35I70dcmR4ElsH+8cCy6tsZjhO7MxTVPAwL3sVZ6d5xJWs5HmHYb2MVUY4phMZ77RD67
         hnCa1swuCH5F6Ddxgem/DefXy8jls3zrQ2EkFAArMp+275Mg/2sbKhU6qEQh8axmeo63
         EVfw==
X-Gm-Message-State: AOJu0Yzsp48sxYlh0Cnm3Vp9WlZq5V9YNTJWGeVMlswrYBcyX/DQdWlH
	hRZW864VMC7gLJVdQ1O+3U/nyuXr9b7TgDIjXUmT8sTWruUg2sLxsFO+l47WLEl2pGjvuWzUxsW
	9PzeHFw==
X-Google-Smtp-Source: AGHT+IEoG6geTciHyN2JVzYp6ADYGYP+/NlO7+c7gYm1psQpKmX7ZKOFLzHimcilfZBXWxvlIN7WpZ2A2HE=
X-Received: from pjq6.prod.google.com ([2002:a17:90b:5606:b0:313:246f:8d54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530f:b0:311:ffe8:20ee
 with SMTP id 98e67ed59e1d1-31e5071ccdfmr6939359a91.11.1753294903836; Wed, 23
 Jul 2025 11:21:43 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:21:42 -0700
In-Reply-To: <20250422161304.579394-6-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422161304.579394-1-zack.rusin@broadcom.com> <20250422161304.579394-6-zack.rusin@broadcom.com>
Message-ID: <aIEoNpe-LFoH6LBm@google.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: x86: Add a test for KVM_CAP_X86_VMWARE_HYPERCALL
From: Sean Christopherson <seanjc@google.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Zack Rusin wrote:
> Add a testcase to exercise KVM_CAP_X86_VMWARE_HYPERCALL and validate
> that KVM exits to userspace on hypercalls and registers are correctly
> preserved.
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Doug Covelli <doug.covelli@broadcom.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> ---
>  tools/include/uapi/linux/kvm.h                |   3 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/x86/vmware_hypercall_test.c | 121 ++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
> 
> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> index 502ea63b5d2e..3b3ad1827245 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -933,6 +933,9 @@ struct kvm_enable_cap {
>  #define KVM_CAP_PRE_FAULT_MEMORY 236
>  #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
>  #define KVM_CAP_X86_GUEST_MODE 238
> +#define KVM_CAP_X86_VMWARE_BACKDOOR 239
> +#define KVM_CAP_X86_VMWARE_HYPERCALL 240
> +#define KVM_CAP_X86_VMWARE_NESTED_BACKDOOR_L0 241

Can I bribe/convince you to port KVM-Unit-Tests' x86/vmware_backdoors.c to a KVM
selftest that verifies KVM's behavior for the various combination of module param
and capability values?

