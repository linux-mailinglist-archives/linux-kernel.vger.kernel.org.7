Return-Path: <linux-kernel+bounces-869156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F068C071E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E76D565B82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6A32C326;
	Fri, 24 Oct 2025 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haNWBL9Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2C32A3E5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321453; cv=none; b=V59GyvZXc+oKYnnQvZOPhBl/0MAQqBXZjRlaDBDHKVwyWsKn+7QtmUCGuaUYEhMmbPLMqoKSHfZ6IFSSSuI/gKTq5NXrDZVi/TUzMsk8sNMl3ycRQNY51sEkCIfHSKAsTMCKHb8n81XcH/T8jpoa5udV8Tt1zo6YWmSpP3INV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321453; c=relaxed/simple;
	bh=32BZRJFxy/KqF7LDEyOXaofUYflahsdiTWj9qs6Pgrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMH+UYaR0NE2YYIHRQnpZSk+zX9FLXH5yjjIF8ipAR7Q/mM9o9F55xTWCIg1TVDmGJbJGeRBTQ5kejKJf07Z4RgpPZg6Kq0+96VbE2LnTbpThz34VC4kpgXTCWXroDrGgnPECBUU2aR/yccD3XtuQqR0UKR+OLVIRtYp6CjxCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haNWBL9Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761321450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xSaGAotvonegYqDLipdghoRR3gYmFE63MavmMNvHheo=;
	b=haNWBL9YGuU2K4qm5Evgf0diP0wkeeBAbNIUP1qMM9KM9QWlHU3DR8LPhBleBnnm3Ef1VE
	bksX3EGZK9B5OnTNtwS5pobBLUXM7ewkgtQRY9q/o9QZgYutVCMHmEc0Fna0vpHKxdgvmA
	NXEgxzh0O1napGeStwMfEUDgN6+JA/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Fz_thIRpMPG0ZmuvZCm29g-1; Fri, 24 Oct 2025 11:57:27 -0400
X-MC-Unique: Fz_thIRpMPG0ZmuvZCm29g-1
X-Mimecast-MFC-AGG-ID: Fz_thIRpMPG0ZmuvZCm29g_1761321446
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so9173425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321446; x=1761926246;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSaGAotvonegYqDLipdghoRR3gYmFE63MavmMNvHheo=;
        b=jZFZz5i6NQo3AVjLwYt9QXgHCQgyGots1K3SdYZzj5/2Qkp2UaP81Xg5OYV58RQmXg
         V2sLP7ESN2tVL2wTcE3Bzo4y5lAhCJDo5P8HWQMIkEzuQLQSX14z7YIOVTMXxhBVlr3j
         aJdhpQZm6Scs1JbLjOb04cN+J7HWKtGT9RpfcLA7mCzXIlX/ND8Uhrdd0XQHAKikpNGb
         Bm7MVIDTpnYRUAh6Rr/jTVwm2D869Nh5YX0LAiibmbZL854WiF4Ne/ooOMy5Nnp2MyQS
         SCv6AbaadFn8LSckIzs1LLklNlywLHrGz2HYQHg26PEoM44Bi+fJtOei1/rbO0/bUulG
         ApTw==
X-Forwarded-Encrypted: i=1; AJvYcCXQpFkc9nKQKUZKVg2Wyn0OdSieWrKVmEUEYNzmzpmBSST9yQR8AEhPvLf8EoPtoTb+f/rBfI206AZxrPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFCcWgtveRvi+7B7mPRhm7eTbe+axWFjIzPqj97KKTdDujAdU
	VZ8TgtTJAd4iKdPCyo/yfjyrT0IKf5QHMJnHk9MOF+fYOSJuTi/ReeK5hEIvZUE7KT1NqXbZeDK
	soBx+jzicIkAiQlc10gJ7/mFd1J/KvxFAgR6uPJ0SNTDuAbiXjPZQ3RX3QKeDnxIOYw==
X-Gm-Gg: ASbGncvcKVvheJlRXDvzZpkYrXWOYA85tzGCCb3KXPz62XXwMbYZ5aHETp7uyRT65YG
	pg+mi/W2U0YO5WkhWekYCSjMHIM+q1UtqlypPIQwOs7PQJ2URPbpqkJFGitN08PDWBVrltAlV2i
	cme2v5sadck/c8LAlTJx57nBMBTJ8+16d2GLFbR/EegxqB+Bteh+XhPp44qrwGmEg7wajBx+IPH
	m1yeRjIE3DnWZIAwrBD8iH5U0rIopvDpSLJCmy+fUtW4EQpxOxPWeY727IWilRss+iTgqlGNGnD
	7gfejV3Wu8MzyjtL5/KkX6klnXJ1VozG1w6OmZmZIafE0XjkmKfayMrVR6WqS19VgxC+pysBFxH
	60dhUCvj95pGjeypSmUIzyuZT1b447kVznr5DmyWkmP4xhwNieretCNpGN0WR/6Ek17Doxh/UJE
	i5aXbOPyOrIqwU7Nrfr4IvAULiBuM=
X-Received: by 2002:a05:600c:4e89:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-47117931c1dmr203634035e9.39.1761321446461;
        Fri, 24 Oct 2025 08:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA4A2hoyfYF06ELU1f5lK86/4VDaYOE4+LD8w0cVkXBoJRLb76v9U0hz/4ouS4xKx4zUaOIQ==
X-Received: by 2002:a05:600c:4e89:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-47117931c1dmr203633615e9.39.1761321445993;
        Fri, 24 Oct 2025 08:57:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4281314sm158156125e9.4.2025.10.24.08.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 08:57:25 -0700 (PDT)
Message-ID: <ff869b97-22bb-48af-b109-ca096afed7b7@redhat.com>
Date: Fri, 24 Oct 2025 17:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v3 1/2] mm: add spurious fault fixing support for huge
 pmd
To: Huang Ying <ying.huang@linux.alibaba.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251023013524.100517-1-ying.huang@linux.alibaba.com>
 <20251023013524.100517-2-ying.huang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023013524.100517-2-ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 03:35, Huang Ying wrote:
> The page faults may be spurious because of the racy access to the page
> table.  For example, a non-populated virtual page is accessed on 2
> CPUs simultaneously, thus the page faults are triggered on both CPUs.
> However, it's possible that one CPU (say CPU A) cannot find the reason
> for the page fault if the other CPU (say CPU B) has changed the page
> table before the PTE is checked on CPU A.  Most of the time, the
> spurious page faults can be ignored safely.  However, if the page
> fault is for the write access, it's possible that a stale read-only
> TLB entry exists in the local CPU and needs to be flushed on some
> architectures.  This is called the spurious page fault fixing.
> 
> In the current kernel, there is spurious fault fixing support for pte,
> but not for huge pmd because no architectures need it. But in the
> next patch in the series, we will change the write protection fault
> handling logic on arm64, so that some stale huge pmd entries may
> remain in the TLB. These entries need to be flushed via the huge pmd
> spurious fault fixing mechanism.
> 
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


