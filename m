Return-Path: <linux-kernel+bounces-827868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C926AB934EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F6F3A3BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C527F011;
	Mon, 22 Sep 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1avbmk6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9425D218
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574815; cv=none; b=VZJ5H1tGl09Xy+RE4iS+H5TdbwwUKOypPjAe7e6CesAV0w853UICQiTtclVmkzLJ19D4hwsmHF7QMXubg9UO48dtkVAf5uqCIfxk8fbj+nWW9KREHImrFS5Dl7pgijmHo6hxXs+N+l6TpSyAo1zK6bQuBq8B3Ak2exh+jTcg3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574815; c=relaxed/simple;
	bh=AggCKAT/ai9pPMS+uvkc8gHc61NeqPEoUM5TIXFt0jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3IKAxDiaJCOW3n+PZFGjVZjxm9bXYbPsBXdMoGHZXEMthlfNOAzBUpFnKKHMevaIOxm9YmLLZgyKUpvFfcAmMezAgovJPdm0NyII+mcRGVxwP8w9h2/1tfPxOV/7hqKohxKqSvf5g4NIM9R9EJhpKPrEtSc+PirdfmuRy4JlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1avbmk6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so36320975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758574811; x=1759179611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZr0hPhFAud0Uw+aBiZrTvnM6zeOzyc8u94gFH2jTwA=;
        b=I1avbmk6/YfMZ3csIRh0eB2/T59L8xPgw5F7juqcjhkXIVAzzn8wsuGm9Cfe6deVfG
         KLqVq9G6JDwenEV9UrAz0Hr+perUaLwtaPn+qo+UY14VBn+8lNds6rz3wxKSBeWsrNT/
         bYehkzF0Xj2kPQIh5wHiJMf9j/bjSraSYuDK1rJ8288xBpt34O4hGRzEprxxRIZa4zW9
         fpV8NVlkNVfh0E/8p2t7X7yw2CVDA1WdhLhEa8a8V2hju4uq4TTEfG6oNrem9mgHaBvS
         PK2Qyt5x5ME/lv0lBj2+u5PV4pVipBRE4zQ/5VgbfrzKyetDM2stvq1psnVMddt7Z4dw
         ol+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574811; x=1759179611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZr0hPhFAud0Uw+aBiZrTvnM6zeOzyc8u94gFH2jTwA=;
        b=AhRN0QuIfjCMQJmBpdu4blfagrgmSGQPIJjrsl5Mcq89nOivwKIamzcqh+pObcDomV
         Fz+0nxBARB2zuP22Lnb5WBfY9N/2m2+mW6d6BIBv7qgQBEVXt9W1dFCJ5hHbj5pU/tWG
         +3rGHOMbeOyOtVmDPT0XQGcHG9BJOE2kTskTf2eLnxORmfzFfxblXvqi3jpTSyEhSmiF
         zOCBGmYvVZJ0ENRV0HAce8WjPMlR4W4K8lAsiR5sDk3RP3JNsW4pOIn9Yu7HI2wqb824
         Q6T4e2NHMA/Ywo93AE/0E/EQxQBA52xpr2CuS0gG8cxAF8K6U2S9PrR5h5RnO2cPdV3t
         4miA==
X-Forwarded-Encrypted: i=1; AJvYcCVy/UnLJxoIgsIzzp24xYsRFu/MHGhFKLu2S8miO2y7TMgZPUvx/FYDQhuxkdXZo1GcRFlGz/y+zE70vKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgbwC2Y2tP/q5ShhDyCXWtDiH0W8quNNgetuMWXFoE4Qdykk6
	oOZ+AMW5ECuClXw/nPtL/oDq6M9nXWkdBcu6Pfi8Az00fv+3kVmcx8HWa8ksrtEKUg==
X-Gm-Gg: ASbGncvlTdWUDSqfFzhXTuuhlqZVdb1a1jzL/t4JEe2s6lYoIXL5efgW/DTTjRU4BF0
	W7DyiE+vuV7j4VDW9WgiVXgLco+SwMRQ1SxmLBuhEdfGeVJ6jLX5mmhspBcX0yDSzu8scUTcqt6
	I6TOMM241BnDU2qtqX77fnlBrde9iZQXX/qxdGxBWcmLCJL/I8gjHrr0RYfY0+aNTzXIepdcJEi
	qUX0lzdHMz+fME1AsZnbcZ/az4atEGDPJ95DEoCDxLbWGnukfjfdZ4MGt1omhIlWmI8fR6ks8IH
	4rs6IbwniG5uWFRYefe3zCwsB+CcsZu2iopcKoK5zUBEhxJXauWNTsb9qq/D/UfbdZ3Bitqpvkm
	RlhVvfmTRMvcAx7GJa6MLtg2oHmnlWah6W0mmhL03dXkidRuOImuerVQTjG1ao4/29A==
X-Google-Smtp-Source: AGHT+IGQQ4kfiQOVTFeyQzQt2jYtkM5/eyZicm9Wu0N0OnLEQ0zchv5LfIGa+8+xPV9iHI+UIbvczw==
X-Received: by 2002:a05:600c:8287:b0:46d:34cc:e9c1 with SMTP id 5b1f17b1804b1-46e1e0f7c74mr978165e9.4.1758574811415;
        Mon, 22 Sep 2025 14:00:11 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1bc00695sm14039935e9.4.2025.09.22.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 14:00:11 -0700 (PDT)
Date: Mon, 22 Sep 2025 22:00:07 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, sebastianene@google.com, keirf@google.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] KVM: arm64: Check range args for pKVM mem transitions
Message-ID: <aNG417MneSKBxyn8@google.com>
References: <20250919155056.2648137-1-vdonnefort@google.com>
 <87plbkxcvv.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plbkxcvv.wl-maz@kernel.org>

On Sun, Sep 21, 2025 at 12:29:08PM +0100, Marc Zyngier wrote:
> On Fri, 19 Sep 2025 16:50:56 +0100,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > There's currently no verification for host issued ranges in most of the
> > pKVM memory transitions. The subsequent end boundary might therefore be
> > subject to overflow and could evade the later checks.
> > 
> > Close this loophole with an additional check_range_args() check on a per
> > public function basis.
> > 
> > host_unshare_guest transition is already protected via
> > __check_host_shared_guest(), while assert_host_shared_guest() callers
> > are already ignoring host checks.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > ---
> > 
> >  v1 -> v2:
> >    - Also check for (nr_pages * PAGE_SIZE) overflow. (Quentin)
> >    - Rename to check_range_args().
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 8957734d6183..65fcd2148f59 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -712,6 +712,14 @@ static int __guest_check_page_state_range(struct pkvm_hyp_vm *vm, u64 addr,
> >  	return check_page_state_range(&vm->pgt, addr, size, &d);
> >  }
> >  
> > +static bool check_range_args(u64 start, u64 nr_pages, u64 *size)
> > +{
> > +	if (check_mul_overflow(nr_pages, PAGE_SIZE, size))
> > +		return false;
> > +
> > +	return start < (start + *size);
> 
> I will echo Oliver's concern on v1: you probably want to convert the
> boundary check to be inclusive of the end of the range. Otherwise, a
> range that ends at the top of the 64bit range will be represented as
> 0, and fail the  check despite being perfectly valid.

Do you mean allowing something like start == 0xfffffffffffff000 and size ==
4096?

But I guess that would still put all the following checks using "addr + size" at
risk. Also, I believe even the code in pgtable.c wouldn't support a such range
as it is also using a u64 end boundary.

> 
> That's not a problem for PAs, as we will be stuck with at most 56bit
> PAs for quite a while, but VAs are a different story, and this sort of
> range check should be valid for VAs as well.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Jazz isn't dead. It just smells funny.

