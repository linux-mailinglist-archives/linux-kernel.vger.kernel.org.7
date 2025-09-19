Return-Path: <linux-kernel+bounces-824349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D209B88BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B494E516C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528CC2F83B6;
	Fri, 19 Sep 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qb0jx92K"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD32F616F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276073; cv=none; b=QzZiLcvKO3lBB6PxppEE69GwGEAH5nbM96FePRqiIe4S+5YaEm6zYBcGdPrciabjUMGO+6/KdE/lahlXxdC16woPMYWitqpUnWGKdllf3gWdcR/hbvINGF9IxJzFOChPcMWjlkpPAGFfjNIApL86cAqk/bN8HbQxYjkqdBWaRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276073; c=relaxed/simple;
	bh=a24Hq/d5xl+UD7TQZLap4eYY4wWFTTqYOyEXcefWYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7bCLW2uEvcET4pakpdnj4WZlmaI5l9RaAjEjIkY7hZq1tAtKesgyXbWuLfFhy5gP4u4jT9oQjZcR9OZh+g+ic8Xdgiukeahg3LXAO/9Q8YFA0kOCic7T94TV7sJelkV3DdAKIoYikrp/d6GmNc9NExYQAft7OgqILjc+J0Gwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qb0jx92K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so11932475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758276070; x=1758880870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6BBuzYX2ggeSMziBzTCfJEdNNCXHrTj/jX8IugZvuU=;
        b=qb0jx92KpgycG+5SohfejdHP+kufC7yJP3FSpiXx/+fP2hZFmaBIUwSoIkWlljbeAn
         Yl8U00bAt/wwU7vxfO4Cvgm9MqlAovVgLynHa9AHPRypMYPHm7Tt+kuiZo0jNmfTGgou
         AjTPXs73pFgBKrL4mZa8IWSZcYARSOneU0Ac+aRkK9SC/hOqSJfftQr9o9xQYvpm49sU
         dr8GwOLcRasH9G35KMhxLoPRGIUTJt3ulkCAZyzFYEp3ICXJMrhBYgzuhCokSD9aDMG4
         NWPlqwYZ8Pvt4O4SQDfcYkRzO226oGXwQWsJ6rbY8KKt3MaeRen0dhSLMMN6q1CgaP+t
         5xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276070; x=1758880870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6BBuzYX2ggeSMziBzTCfJEdNNCXHrTj/jX8IugZvuU=;
        b=sdYLd3ciekSicu9bBe8GRZ4WJDLUXDnYyY07UD21xXkI2FKEeiLGohvS5kqJMs+QoF
         WCPMOYJ5MUPZH3pWNxPZ2LKKfKyzszdGYEYiPW2c/VCd2GiWjmbGTV2E1BqQrCuBvirD
         59KEu4PTnT9wOr5LpGktzjD5gFp3g+KBdgOExACRiLR/EXTWno+JR9SN1pl0skK4NwxN
         l3hJqDDZACRQjGDi1QxQXFD0Y0HSFy1Mj3jDiUrW6a2CuTzZQc9wlSaqH4jIw9ziZ1Nw
         RP3AYia3rQvGYdsEhPN5lI7ftbsDjj/NbxQms+qWip9CbfhwcfnPCWnW/0+y3gyawBA0
         megg==
X-Forwarded-Encrypted: i=1; AJvYcCUG24drhD4nP2i6d9CxNLohAJgGZbh6oRa1ox1CSywHg1gjMypDdUbLZne0Jc0fIoSJ/GV1ZZ/Q7QMIyKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTrJwlkNQVIUxlklTuSVb8wIvgtGv0pp8CnD2fqYMzPIuQJwe
	fhaQixzdhMFPhU9TsZHvUh4HL3fTNWKmtDCDQjCC7lkTA7PTIoSvTeDXL60ctyCYFQ==
X-Gm-Gg: ASbGncsDqVVhiX4sRLVOmz6tHasA769U5IgEPFeTJiwMh8x9EBzuHV331MQiV0aIoka
	4pGlLIDLlYxfCSSybWTgwqC3D4NMsi+2eWQvniWl0wGlnFVxrHOfQsXASyDDc1b6WHyWJ4akd+Y
	h7XHh87/FgYNGOltTRM0NpTJ52r9vV5D22Z4ZS+fqGBmUNBLZB3DLX5VG42DAtxpY6g2HNE2769
	e2dXd9Xt+m+xQ+DFp4MRKy/77jT9m7UW2EBfESMNywPFJjxVccLmKrzKc1kfi2t+XKgnPuwjDYV
	6YepV3/8ecrJN1fwenwlYENdxia+KFZCT6jxipszBRCp6CMVo2JAl45Yh9TnrE3jRuvgu+qrcI/
	B+A2N1TK96n2B1yqtEY/aAqtJHPC3B5juMznUBdtucHZFfMbMCPganJ5zqlH6LVCffryX/M8NcC
	gj
X-Google-Smtp-Source: AGHT+IFWHUGX+juK2JjqWprgLEQZc6/GNyQ1PYUKoMGX9rAYPkExud465f+KLZFJxbpo3+wQG/eGhw==
X-Received: by 2002:a05:600c:4688:b0:45b:8504:3002 with SMTP id 5b1f17b1804b1-467eb8e1ddbmr27074115e9.10.1758276069808;
        Fri, 19 Sep 2025 03:01:09 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325a32f6sm77324365e9.2.2025.09.19.03.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:01:09 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:01:05 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, sebastianene@google.com, keirf@google.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Validate input range for pKVM mem transitions
Message-ID: <aM0p4UB3TNnsKcfC@google.com>
References: <20250918180050.2000445-1-vdonnefort@google.com>
 <aMx351jkCPIv_j61@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMx351jkCPIv_j61@linux.dev>

On Thu, Sep 18, 2025 at 02:21:43PM -0700, Oliver Upton wrote:
> On Thu, Sep 18, 2025 at 07:00:49PM +0100, Vincent Donnefort wrote:
> > There's currently no verification for host issued ranges in most of the
> > pKVM memory transitions. The subsequent end boundary might therefore be
> > subject to overflow and could evade the later checks.
> > 
> > Close this loophole with an additional range_is_valid() check on a per
> > public function basis.
> > 
> > host_unshare_guest transition is already protected via
> > __check_host_shared_guest(), while assert_host_shared_guest() callers
> > are already ignoring host checks.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 8957734d6183..b156fb0bad0f 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -443,6 +443,11 @@ static bool range_is_memory(u64 start, u64 end)
> >  	return is_in_mem_range(end - 1, &r);
> >  }
> >  
> > +static bool range_is_valid(u64 start, u64 end)
> > +{
> > +	return start < end;
> > +}
> > +
> 
> I'm being unnecessarily pedantic but isn't something like [-2MiB, 0) a
> legal range if we had 64 bits of PA? Looks correct though so:

Apologies, I am not sure I see what you mean with this -2MiB range.

> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> 
> Thanks,
> Oliver

