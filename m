Return-Path: <linux-kernel+bounces-819956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32428B7D08F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB46460C26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8026C3BF;
	Wed, 17 Sep 2025 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5mMTb8o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257323D281
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081427; cv=none; b=nrdWM+RMUSIvUF0AA2/MCvDasbc1Bw02Df/J6DW0QV5uqrXT9IY3FoBFxe91JL0xs/f1sA4q7V4Xf8GvzNQm04k/wu6ZFDMU1t2D7o1n3VlIYyaXUyjV8WWiqX+UM9sYxVXl0HdS5LPx+qQv6kEHprBllLY1HxNLv6FwZ9t3ewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081427; c=relaxed/simple;
	bh=BK2vt+oVFag+vs2ay9fYOX68fPEFL7tR8PLO+nSyEB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+mJiY02+rPbyDQpK48E4UULyHRvebWAaUuGnrhiuE34KwKVC0Ao5zkSwvqQ5P39z9GbC12R/yFkRWpDiX/oZyIsxYnsRYpRSXhCaKo6DGjkawzehXpXMC2Bt5ZUETJ1KgZqOHCzT7suXb5mUMceYaHX+dfvBxNK/HgIttSNrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5mMTb8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758081425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTGV/Lpx58Ur4YHkEVEE/DLD/lQA5hgEBF0FsirS0AA=;
	b=Q5mMTb8o5tAQu1gUCc+kS4QOA9+ygq5Dp/d2t6kxaKfUR4vIGNVFyIDlwYl1I5Ah/nG+c/
	pyUkrU74gvZoEb8MkGkP3kWcMnWq/meMrICFf731QOO+tOLwUqcrlq6rE/+Z+QoaBJgmyb
	SQwBJ83Bfhqg6VfWFDIwCV6rNR7DKOE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-LhD66Vn2Pjm0By07QaE8oA-1; Tue, 16 Sep 2025 23:57:03 -0400
X-MC-Unique: LhD66Vn2Pjm0By07QaE8oA-1
X-Mimecast-MFC-AGG-ID: LhD66Vn2Pjm0By07QaE8oA_1758081422
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77260707951so8785872b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081422; x=1758686222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTGV/Lpx58Ur4YHkEVEE/DLD/lQA5hgEBF0FsirS0AA=;
        b=P8bpwfXScQsS6vumtoI4rwuP+RmkH7uVuFjQywpYNOhzYR/lcckriarviPDEhwC2XG
         P+Z3BVffqKfMM9wAhXnZpE+K95swNGRZ9juFa6thWAll/o29syoIn0uI6/c6GvzbCDkL
         AOwpQ9s5v8C/DTRVCsAi5h/0uUKXHud91J1zLEne2Hv4mOX1rIGXKqkcARe9e++LDZ//
         pdYEIrAv9p23T/lDcaM2l2xcEpf/p6lamqBdtcFQkNGiKzMGiq2XwWzxaDk6+COEinAO
         U6BTpJALoxtQdSBnQ66fRADcX5Pdy22BEJhPgXrj3g6z7D2eKxFj9ti1SFBRYTNLXiNQ
         4B1w==
X-Gm-Message-State: AOJu0YxiTHLNRFstTTJ9aQLSK7E0HcZvUk22D7TfmNdzNch/dQRLyL5k
	3nClcNdyLMvdsXieIFrzs+gj+GWtpBbPDXH2C221z1vj09RIQDZEOHIwdZFSkGCfmCTk1nglQSu
	wYHqwhx3CMiY3TWM3gn8B3WCdefk5IERrU5C6B/JTTZbmk2Q9SH2pxCrkpmLaazGBcg==
X-Gm-Gg: ASbGnctzIZ9rfKeXGd7cpKleOhTDFeQjdh5CHousV4QB1eeuc+vmmEVQE23EKR3EVwz
	noPGFV+h+ovOC0zf4OrlXpDnt0zv7clY398Qh2li1wYRIVltMW/CJwkoS5ggwGpnFzFO/jHAqMo
	45eWOqywRJCUWnANtq8+6ScdoOp+r0GFAcVHyuvk6TrWQvXlelR9jOAUwBCzyn/u01j8Do3PTTU
	1G8L3sZ7TPnGJtDQfQVnzoF21+ri/useLEx1q3+t8p/uaFqLFCTo6blDeKS48EFin7yLW2elu/3
	Fr1Gc/fjn4mAt329NiYAqfFcZT7+f8Zj+y8082UNA1HOyBgOD4UicM8W1HJ8RhHzQ6LHEVA6FGs
	wz1RB
X-Received: by 2002:a05:6a20:430d:b0:252:f0b6:bde with SMTP id adf61e73a8af0-27aa2e9fe25mr909370637.24.1758081422419;
        Tue, 16 Sep 2025 20:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMc2O27tB3E/QqyAooDB3y7jr/wt0/Bey9oUtK/NtFfEn70CrDz7Artb0At8viujU7do8N/g==
X-Received: by 2002:a05:6a20:430d:b0:252:f0b6:bde with SMTP id adf61e73a8af0-27aa2e9fe25mr909353637.24.1758081422069;
        Tue, 16 Sep 2025 20:57:02 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77613e4308csm14709454b3a.73.2025.09.16.20.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 20:57:01 -0700 (PDT)
Message-ID: <4e618201-05dd-46e1-8ca8-3956dc738300@redhat.com>
Date: Wed, 17 Sep 2025 13:56:55 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: acpi: Enable ACPI CCEL support
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@kernel.org,
 sami.mujawar@arm.com, sudeep.holla@arm.com, steven.price@arm.com
References: <20250908223519.1759020-1-suzuki.poulose@arm.com>
 <20250908223519.1759020-4-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250908223519.1759020-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 8:35 AM, Suzuki K Poulose wrote:
> Add support for ACPI CCEL by handling the EfiACPIMemoryNVS type memory.
> As per UEFI specifications NVS memory is reserved for Firmware use even
> after exiting boot services. Thus map the region as read-only.
> 
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1
>   - Map NVS region as read-only, update comment to clarify that the region
>     is reserved for firmware use.
> 
> ---
>   arch/arm64/kernel/acpi.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


