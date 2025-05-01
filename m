Return-Path: <linux-kernel+bounces-628170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8EAA59DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 05:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133404E1726
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AA230BE3;
	Thu,  1 May 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ac6wenrQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45441C173C
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746068695; cv=none; b=LuOdceZ9o2kVO3jdvPRHtXIUtxs9/k3HBiy3NN3pt/p95mH6OLX4OrJCZwzpTtm5OmO4/483hfTjnx+no7RfMDAg8cvtBFFmEsO1vQKv1C/NEJymWan26IrnpeiSDDqzaYBNpFnGikfpQzqqJVwPZgbhkLO4XCSl+kiCUPJhJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746068695; c=relaxed/simple;
	bh=1ObrGtB9IokARfmRtsVBE9r1D8oh4jqlTgFcAClMTMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7l/j6E6m4PVTovApWzEwiaG9+8RxCyu9ibJ1NcTQOuEH+StY4qHUQ71/CyYtqm/leCPo5xnTKq83b8QeYG0EZ7MVxDSIoz6iOSjK6cuFdp3gF8xDkP3s4NZEvewDsDhEygexQfa4OV54Be+ZxOLaFiCjvRAZY2gYySCDttteOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ac6wenrQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746068692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6EHKP8IMf41CnMw8MbfWQc4SNnrbtpA2MJtfflzP38=;
	b=ac6wenrQLCWsbTg4QnkJwU756IuMt/GSbbl/k1wASDfXrqFn5CMp5yPK90us2N6ezyHqo4
	V3FIjb/R0SbOx6JQrOPx/eign0G+TliUBSZD58WhmjCfJAFdvUgVeXeTMzkdmF3psC2qFf
	HSaJTy3LuuSBZMks+PMbP2ucITEvcHY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-isHJfxOpNtKWfKfqSH5SmA-1; Wed, 30 Apr 2025 23:04:50 -0400
X-MC-Unique: isHJfxOpNtKWfKfqSH5SmA-1
X-Mimecast-MFC-AGG-ID: isHJfxOpNtKWfKfqSH5SmA_1746068690
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227e2faab6dso4358355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 20:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746068689; x=1746673489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6EHKP8IMf41CnMw8MbfWQc4SNnrbtpA2MJtfflzP38=;
        b=TMeMgRN35J8rVu3jLJRWaMgNB0m1GUvHyjGzBkSAMl+T1z3L30ou7OLaQh2088ljvg
         y9DmK8uV48dtG0bGxJhYsCLPSiycuWUh6c5EI+nAuu/ROmrBjY3nDSfH70lBF2eFpfb9
         lWqnA036vwYVXeJ9j5lEE4EqROqyQx/SbRMsVHV/PJavAnh6Tw4C8zRuM0xGX5LWJI/1
         1Ad2CyaD/nEKFFFkC5ewlCUcq7zWshQk1uL85fG1WRdkGUlh10JnWatsSfF/C5dYG0gm
         pwcnbXswHEkwIUFEWleudWm616m2fchVN+LpFeqyNYpq8GU+G4/ajsgwLxJtC1Sgb8RF
         YKpA==
X-Forwarded-Encrypted: i=1; AJvYcCWGEWa+Gsd5NcJVYq1gOI7Pfk2n7xgKvSvGEQCPA1r7UDnkT7vb7tv2Xy3xmDho2AABlvtq8GvpZu/5Unc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGrGPkwcd7kUwdyuE9Rgqh3UxpewlNNsJntAKnxS4Oy0Abij2
	fPJ2ZTGpxZSWdty6bRFc1XtSRPEQA1bfYJCdMRE5GBWWLKt1g2wv3KLFTuBpBqd9NNPihtft7kp
	DLi9uu8uE+8Z8+LUibONBnHmDRA52vIt5UxF9vRe4RchJoOMxsHuyD1IVtBoWkLqxHVXYWQ==
X-Gm-Gg: ASbGncsPa+UXDfqNpzx9vpO+Ba4PL8N8YmmYKTCkzaCP65NUjtAwPQUIxdLJY64YaRN
	InGz1/6NwkaohBoPmyF2DjGDLuLI/4HpZlJgJyWMsAmWkDQV77RHxEAsdnLP/eNIdqj7sbt/9Op
	F3TQBErKXzqCmMUi0mFpUsxDkQNuhuDYnyh60lx39mVdBKHH/GjLlAtoLrCe7qUtGK2ABOXO2VD
	QXVvLL89Hq0oq+/YLSE9ellZtkkjkCxanl3dvh8w7f9mNL/lZtV7sidmjgg9E3w5GN7Witqv8K0
	K5DRNEMBnh3n
X-Received: by 2002:a17:902:ecc3:b0:224:76f:9e59 with SMTP id d9443c01a7336-22e040b0136mr23366835ad.10.1746068689268;
        Wed, 30 Apr 2025 20:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1HYZaymy6EVaTH4wKRIzEm7W7NnVNI2iwuZwa7SP72F5l7R9CUpKQ6EYxkWw1HKHA9Whnjg==
X-Received: by 2002:a17:902:ecc3:b0:224:76f:9e59 with SMTP id d9443c01a7336-22e040b0136mr23366505ad.10.1746068688970;
        Wed, 30 Apr 2025 20:04:48 -0700 (PDT)
Received: from [192.168.68.51] ([180.233.125.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a244bd4e2sm3593226a91.0.2025.04.30.20.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 20:04:48 -0700 (PDT)
Message-ID: <e26e4225-e9a8-40b6-bafb-9a007b20db96@redhat.com>
Date: Thu, 1 May 2025 13:04:39 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 42/43] KVM: arm64: Expose KVM_ARM_VCPU_REC to user
 space
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250416134208.383984-1-steven.price@arm.com>
 <20250416134208.383984-43-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250416134208.383984-43-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/25 11:42 PM, Steven Price wrote:
> Increment KVM_VCPU_MAX_FEATURES to expose the new capability to user
> space.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> *NOTE*: This also exposes KVM_ARM_VCPU_HAS_EL2/KVM_ARM_VCPU_HAS_EL2_E2H0
> (as they are both less than KVM_ARM_VCPU_REC) - so this currently
> depends on nested virt being 'finished' before merging.
> 
> So this should be merged after: "KVM: arm64: Allow userspace to request
> KVM_ARM_VCPU_EL2*":
> https://lore.kernel.org/r/20250408105225.4002637-17-maz%40kernel.org
> ---
>   arch/arm64/include/asm/kvm_host.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


