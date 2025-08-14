Return-Path: <linux-kernel+bounces-767827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C6B25991
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77AC3BADC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C93256C6F;
	Thu, 14 Aug 2025 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="pwN6kVWH"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC24341AA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139324; cv=none; b=Tw4jKy+XjgPxU2NdFBnJNOfU7QAGY0rrhzvKPQNLLggh8LsQyQZV8t1AVMeW7YgPnrBLuyVv4BK0JFKnFXX9iHDhPJyWjXDft1SdTDsy8iABgqpu1pzSNDwp7R8y6obMUBr7q+nhK1F3fIVywAil6/pu0unT49bGXbc+e6LBlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139324; c=relaxed/simple;
	bh=5Az+Af3n683KZXZJI20rTIjpZlv6RgGbYo2hi8ndzkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3kHb6b/1GuNwQtF/ff2R/drjCB/VWAxKUArmYFg/j3eDjo1X9kx3/R5de+A2+t2IHsOw6wt262vKqm5+R51Rqwlip9HlO0+8t48Bu0hnIcTP4mVF7soBanLyd1XMQQs/ABT4tIdC38vr1anI1dMn3SksVErdTINHOr+jmTyRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=pwN6kVWH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce908e12so498154fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1755139321; x=1755744121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJNUvNqMaWEA4NfLjVG0wZfCDDqvwD1owu885aCL3Q4=;
        b=pwN6kVWHNR+gs6sz1zfta4Rb+Yq3lf9G5/XF5bOodJfx0pQaoOHBzIR4dwqgDbbn34
         +FpPVpvcGa4UcEJhY8XfG71/VCrImcB0qYwLGVGQFokwcDwLkh8quPOC8VwntSe1L7aQ
         Sq/DvxvKrXcjGPTR8MBtTCREiWnW/ICvDbTdpt8ygzaWgjlMw4C2rv9tGT+f3lWQgBP/
         fwtdTl4eYXgs42/XWXbbzDkpfvgv4Z7KItR8ZSqOm6KA28gGEY0tuIPq7z4hDjVYvHn6
         Jf2VmJkZVaVOqlqZE+fg175hFKQ4raBCqg3ULE6j9gBU+8/2Xh0VfOevX4xmwakRyuD0
         JfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755139321; x=1755744121;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJNUvNqMaWEA4NfLjVG0wZfCDDqvwD1owu885aCL3Q4=;
        b=oGAxdHoJA9f2ZdiPafQsDArGHYZy91tpV//VGrXMBwtxO3ro5ASUMgdJMOEqQPdM9A
         bMFU/N7AMq4q5VEFcLoOYfFv4lIzPz5+oF+7/MRoQfgg2nzzgIa4noSbx3zXv/59YAuz
         IdsYGeUs03C1PeX15l+itfuENeULgyWAEH7TTFJJ88c/7ORnPnhngDeA89JmN0G0rL+n
         s+x3w+INxqXjf/ZxYdboU4IRzJcTo3J6FbgdsjM1a52nYHOtIjVUhvffBzHnC0ecpCs7
         0hGJrJ7AplbX9RyzgolrYk1EqsZ6rsSzTivjJyvLGUE9gue8exVqNmZwkjP82cDerQ05
         ZhCA==
X-Forwarded-Encrypted: i=1; AJvYcCVNTocpKI7ddWWvURTeH8MkWa+nifnBPd1UXkgQoMx3QM5WUb+VLUjqhI9n7fnUtUtvS96DDC8ZerDYgSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuzSSmnvrk9jFX5x2uWbv6ekb8XSpx5pyB0HUiDCvJK0uvaWJ
	kgzVHIUNSDId23ZGC0mAUMOg0ZUHLlGX08CrvyXSDKPXYv2qlxmu4Z6NhkJpdme1+1HU2TNc0d7
	2uzs4zTU=
X-Gm-Gg: ASbGncs9PnEbIr1uthsJUyT309XtKoA4mrWBvi0fJZo6sXJ66SbcG/2hicFZyYTZBuF
	lZ/x3L1loPZNMbipat43DD1Wy5cWYA308p5vxX1REAA7JDRddDtlMcsk0drszytDrnAgjRn9qNy
	GGdc2FAqnkOSoJacAjc7yXvJJJ3/J4uExTXgu/BX4NvYhH3g11cdnR3GY/3xq4u7uu6W7Aupw0S
	x05vu726jPIDHs6+ZWNtSWCUoj9fvQlPJiinAd1/kyBYZv92xyy2Q/pRbMGHwhGHTtFrLk5tr3u
	yXc5Ienl9KmMnC1cjP7rKGt9ja+8aBSt5T4998+aOpyxG/258wx709Ku/0bkvvfuXJVWE/viEoD
	c7orTAbpK3aIkEydwljpA8wvE4pzu+2c1Ve4=
X-Google-Smtp-Source: AGHT+IE/Whgr0VPOqXq34YRNuyEHshloSAlvqInb6X7aJcqtcPv+fjB8h72KLEAmiG1lXgEK1jMYVg==
X-Received: by 2002:a05:6871:7b06:b0:308:fc2b:b7d with SMTP id 586e51a60fabf-30cd139a2ffmr981337fac.46.1755139321636;
        Wed, 13 Aug 2025 19:42:01 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:b599:8872:e83:bedd])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30ccfe6bcd5sm360892fac.14.2025.08.13.19.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 19:42:01 -0700 (PDT)
Date: Wed, 13 Aug 2025 21:41:55 -0500
From: Corey Minyard <corey@minyard.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rob Herring <robh@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the ipmi tree
Message-ID: <aJ1M883eMiVCtoaO@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250814114214.609818aa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814114214.609818aa@canb.auug.org.au>

On Thu, Aug 14, 2025 at 11:42:14AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the devicetree tree as a different commit
> (but the same patch):

I think by normal rules this belongs in my tree.  I'm not sure how it
got into the devicetree tree without my ack.  Or maybe the rules around
device tree are different.

I'm fine with it either place, though.

-corey

> 
>   84e7845761c7 ("dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing "clocks" property")
> 
> This is commit
> 
>   a2f5472f1cbe ("dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing "clocks" property")
> 
> in the devicetree tree.
> 
> -- 
> Cheers,
> Stephen Rothwell



