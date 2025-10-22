Return-Path: <linux-kernel+bounces-865341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E8BFCD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C373AF37F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5A34B43C;
	Wed, 22 Oct 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvQBT5yx"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725234CFCE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146512; cv=none; b=J3KZ1ZjGeKC+bsX6sPs9VRKnwyNSVynyajhkPnIT62dB/x/Dz+7MJ70OsHJoyWNHnjbpay6kgv7JiuLzCoeH3o/WDkI7Zur3zraHjNTXezsyHJhESZShdfwmpjKVD/aPEMlSwveHqSkMopv0QjWiF7ng5LrfFr9SvafWPWtxe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146512; c=relaxed/simple;
	bh=AEtA/oWhtAIGMkwlqzRLBsJV2/4Vi/QootOCgnUxP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxC5+ybJWrEKY2XRNLF5VxtL8vD3OWGCZqZT9Uzr3yVy2dfrn4WI4m+Q5v/zLRtO2kp90XBAK8NfUBs3pvOa+g359Hqa3WUkucao6ccpGNmUbaLsV6LFbVcwTkqYKpWIGjCHANOSdS+hcNodz/PkYzpHTNqvNiKR+H/G5OmP/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvQBT5yx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117f92e32so47417645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761146505; x=1761751305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42ue3TfuagWkQ2V7EUMjj15D8DxB3zkbZ2dEcUmvfhI=;
        b=XvQBT5yxlBDThit09bxlrm8ngcLnkPc0yjies95wMnZDq6QBPyDLqnNrwsjNqibGZn
         7c2jjh/JMwFCJn7JvjRYkbY5vPjMowZ+Nw7BMb/OqQFHcoK3roHfVFnJwdOybk3/FwgH
         7849MncFQKZAoDfv65jVVYh3kcDI8Jf2JtAQ7gjk4HT7tux8TYxFRibNsweIFq3waJsk
         WaeZJh76uyXbNSfGfKP2/4UIXL7vYwF9e2kZihlLh8EIk29D1Fjrivj0NKI1YHoIO+aR
         dpXGZvUimNZrgYCs/AImBC7gTAtnD3YwXoi7O89b+Nuz/rhaA3gCUhc/Zaf+4WeLUZ/Y
         mzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146505; x=1761751305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42ue3TfuagWkQ2V7EUMjj15D8DxB3zkbZ2dEcUmvfhI=;
        b=VJvF8aL66HA9U2Z4ilFcZ48pudep8bDFz1fKVaFZq7tQQLBEtTXQQnXXIaZWj4f8kI
         Siwqxct3vLLFK69Gu2UQgFN89jgEcIGVRCiaGwtSi8mtmV8e/Qm4VjR3B+cZYNulf7/f
         iN+dEVlYCc/b8rvhD1zDSRs2nqreaymKZLrQF+cwTyvvO+a45K+0QIo678SNexkS5l5K
         ChQgh2YkLF4Y2dv/V4LsktlmFyvrOxZWqkB8681GvZEzNll2VX7lV6KJ397IaJFxrLeb
         iKgx032CSH5LcNo8Xf1PmIiLhRj4sbVfZRGo53mBEgxAm+wW/4+u6GeWfKRKRxYpGQuc
         VTgw==
X-Forwarded-Encrypted: i=1; AJvYcCWLHwsx505exoIxlGbO6wzfVCYSQxcoX0pH+dEZp7JqhMUEw1KssJ4uWH6ntB2o8bOXYPXMFrmJ7A7R4dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDRQ5RKV1mX0Lf6vOyj1+xLQlKbgizZeWODqN8X+hBqosOTsc
	kaDV1ZTf4tulf0TMnXXoPg7EO0SQNAg+Zx954OM5If61tWHH4O2pYS+Yxe1vFzyk8Q==
X-Gm-Gg: ASbGnct3NZiFkiuSxpUEjjLi2ysRVvYRQyTmT9sgOnO5MIpES1UsOU47X4nfrjcbI6h
	Ua3zYe8WMeqMBUKUd8L9l/VQjaJlqs6s8cvm5Vk+z4Bo57Rclm816zcyAC3kbcWK6aAXwojOcHR
	PVRZyQUqUvjwpjUXrX8+VGjoiXI91FZw1Ix1YZgX35/LOutp2yoVGV8qPleQxPbYz6yfIvWXMuz
	yfZFL2zxLoMLy2vc4nl3FDPH19s9eNB02K7NGSFOj0KNxVnghlRM7oe73C09ruzE+SSsVkhvPFr
	sUPLhqf7Wmamxp3GpnYIzy9PntChMxdmskMiNY0oW5sMnYvHvU+bPv7aFbaXexGacuzSHSJjVjG
	ir5o7e2nN2/81TP0iKYP9cSwafL0sQWnbcTD6Q5eLAXD8j7tTPdIGpfHQgM4SxVzG+VfGaKGHKP
	zjKTCQG1HXQK76qWeA97csE65PKGdgKS18QNdk3NL/
X-Google-Smtp-Source: AGHT+IEnnK8G84/RCGIcEvbmU2iJ6PJ59Y6J0A2B+/Z8jT2K1jKw12A1VxcO8AZhiMzei5pC8Fi4cw==
X-Received: by 2002:a05:600c:4f95:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-471178ac017mr140699355e9.16.1761146505106;
        Wed, 22 Oct 2025 08:21:45 -0700 (PDT)
Received: from google.com (218.131.22.34.bc.googleusercontent.com. [34.22.131.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm25217515f8f.36.2025.10.22.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:21:44 -0700 (PDT)
Date: Wed, 22 Oct 2025 16:21:41 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, will@kernel.org,
	catalin.marinas@arm.com, suzuki.poulose@arm.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, joey.gouly@arm.com, ayrton@google.com,
	yuzenghui@huawei.com, qperret@google.com, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Check the untrusted offset in FF-A memory
 share
Message-ID: <aPj2hTXbGUseUqhE@google.com>
References: <20251017075710.2605118-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017075710.2605118-1-sebastianene@google.com>

On Fri, Oct 17, 2025 at 07:57:10AM +0000, Sebastian Ene wrote:
> Verify the offset to prevent OOB access in the hypervisor

I believe that would be just a read, so probably it would be difficult to use
this to compromise anything, except crashing the system?

> FF-A buffer in case an untrusted large enough value
> [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
> is set from the host kernel.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 4e16f9b96f63..58b7d0c477d7 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -479,7 +479,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	struct ffa_mem_region_attributes *ep_mem_access;
>  	struct ffa_composite_mem_region *reg;
>  	struct ffa_mem_region *buf;
> -	u32 offset, nr_ranges;
> +	u32 offset, nr_ranges, checked_offset;
>  	int ret = 0;
>  
>  	if (addr_mbz || npages_mbz || fraglen > len ||
> @@ -516,7 +516,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  		goto out_unlock;
>  	}
>  
> -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
> +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
> +		ret = FFA_RET_INVALID_PARAMETERS;
> +		goto out_unlock;
> +	}
> +
> +	if (fraglen < checked_offset) {
>  		ret = FFA_RET_INVALID_PARAMETERS;
>  		goto out_unlock;
>  

Perhaps this could be easier to reason about by moving this check with the nr_ranges?

        reg = (void *)buf + offset;
        if ((void *)reg->constituents > (void *)buf + fraglen) {
                ret = FFA_RET_INVALID_PARAMETERS;
                goto out_unlock;
        }
 
        nr_ranges = ((void *)buf + fraglen) - (void *)reg->constituents;
        if (nr_ranges % sizeof(reg->constituents[0])) {
                ret = FFA_RET_INVALID_PARAMETERS;

}
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 

