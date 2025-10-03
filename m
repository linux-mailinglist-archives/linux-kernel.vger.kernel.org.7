Return-Path: <linux-kernel+bounces-841200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BCBB6780
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2762C3451EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE82EA756;
	Fri,  3 Oct 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvjsH6za"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB82EA740
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488011; cv=none; b=Bn+3nbwZbZjMKQ0ROZmoL56KDszfbYs+3SeIImgGPFfu9HpZdGjvdQ9Ewv8XlDsboyahc6Yn/x1QeXkbZwCwk91CcVTJZToP+TPgf3ekIyCAea3aa8Jttsw2L72qQDcKne9CvMWg0kEOf6PQNFwC5GkUqeQYPrt0KAfWpM7E3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488011; c=relaxed/simple;
	bh=uixQ6kyH22/C96wbs0ukOXrsC4/qnZ7ssmSzbpApo70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2M4ManZO9bNawB2cTp4KrniwukayUgSW25kvCSiA3wiERwZoNC4IF8sqewioLIoVVtHnTFQEqRjAyjON4UYTGefsiAAj11I7f53wHV5a5/tEM1vsR+w3CCQdIDQaL7UMhCZte8vt+E+43JCPhbtPbqCEcROvTaiFfG2iFmYo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvjsH6za; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fd2dee5c00so75009f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759488007; x=1760092807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZzWimyXaZpxT4HA9s/MOFmVrRgLJpUiUIoVWOcDDp0=;
        b=dvjsH6zaGEZEyk8hTMUf80P+bHiazsAsPlyimwuYg1i0yGVMjF9cqFdp5PqC/zuEbK
         zhSWR+sfwcOVJEZHyYP3gxsVJoyRnbX2soDpqTNvB+jRSO2pdUXa220OcEuQru5bDWc1
         NIl+INqg98f3ha7JxSwagRHi3Qo0hUxzwD5sO5/cOs+LBkKPJsfFWZg9IeD+cE+TFPDd
         z1aM047F2/XgxTPB/R4H0Q1ugaeg7FXrnsQ/35YsjVEnN/pfN7J3EJ19FYG3VKUVN5cq
         TOcIkPZsiXiUo/dBzT+nN2IYX/hd+/OYHF56shf3at0yqcIEHeJQBIJV7VUzoEU7ifLr
         sSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488007; x=1760092807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZzWimyXaZpxT4HA9s/MOFmVrRgLJpUiUIoVWOcDDp0=;
        b=CXjXEWJT/8JsELnHDRToR+jCE5GAwddTyB0QQiS2o6/a71o/2Q66UQTl3Nj3WE5/+j
         jlBGcGLcbThrDPJQargZuWeYv0OUvRghoq79pZXOVgLua13wI5wZh9h5NMyv2NhYpAOc
         GYsOX08s9Dp0qgBcU3tpVnLFtsL2T8PYXPLzt3dLq1n6+QupuBerMCcvHuzc51OHKm6s
         OpqR3QgwA+OyK658HJNV91+04tsmPH9+tuNRjm1RosSmm6i0LevA/Fv8RIOfip6omh5O
         i2OE5v4iABbLIIgBsdXt6PoyLE1m+wsPE6z/6L5pntjQ0W+ZmAn44li4uFAJxsWV5uBM
         qWBg==
X-Forwarded-Encrypted: i=1; AJvYcCUbBTt5ToyIun6nlXEO5aoNvzx330KRPLziuhUB5JzTBktFkKzdYKQ63mt8KPQ8ETajcyCexi9VbQiaQYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMI9IZrmLxOeTmM5ZK5mgaSc9975GGlOAjE/rrBrvsoZUVqPnF
	hVi9cD5hhDJa/cCX2MxFbTmAB2Xh958qD4pvcqmOBusx8ya/ljU1dOjs
X-Gm-Gg: ASbGncsKDCCAUr64vtyXt3RvTPywSh55+D/AdrvFZtd05lnlN0w/rsE6Ei0BcmjsarN
	c0cwrYHXNa5ygs9DaOzClwl4/0Q3lcNcbmyyRjnKtZ3BH+cHLYZK7egOkr/F2D3j1cW5zt/+ikN
	X1PQy5IJbaCCyFHVBHXx5o22RJBTTHpLMUPB4ycQDnFpEj4x5mLxAe6Yp4jS654KmWC+Py9JLLh
	HIs9KqUr8CvgVgSuv3pZkPBznKPWY4Q9++ERczd8GKBhwsSU68dcY49OhLgjgAKgqKrE5cF1fUO
	rS/13gmVtBrKAGdmprSGTZGSXRp4kr3gq/vyw/h6FgIRP66Az/ExWyJ3z477Jf4rWlnxFfGbNkm
	kbFeiIxb50Fk4dqvATKG2zfleer9nwfGZTxszO1LacTFu2VP/3gWDShavTI2WmbmXYDepiXI=
X-Google-Smtp-Source: AGHT+IFUSvvSSGhE/OmU6U3tpy7UKk+VR5GvbEDJyFIQIUGJpgNu1HB76w5/4UMrESS3rJMjujyoOQ==
X-Received: by 2002:a05:6000:3105:b0:407:4a78:fff0 with SMTP id ffacd0b85a97d-4256715ac7fmr802161f8f.4.1759488007012;
        Fri, 03 Oct 2025 03:40:07 -0700 (PDT)
Received: from [192.168.100.179] ([102.171.6.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm7468725f8f.49.2025.10.03.03.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 03:40:06 -0700 (PDT)
Message-ID: <b0388977-413c-46d0-b0e1-fc8d26ef9323@gmail.com>
Date: Fri, 3 Oct 2025 11:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init: Use kcalloc() instead of kzalloc()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
 <20251002023657.GF39973@ZenIV>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251002023657.GF39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/25 3:36 AM, Al Viro wrote:
> On Tue, Sep 30, 2025 at 09:35:37AM +0100, Mehdi Ben Hadj Khelifa wrote:
>> Replace kzalloc() with kcalloc() in init/initramfs_test.c since the
>> calculation inside kzalloc is dynamic and could overflow.
> 
> Really?  Could you explain how
> 	a) ARRAY_SIZE(local variable) * (CPIO_HDRLEN + PATH_MAX + 3)
> could possibly be dynamic and
I missed that c is in local scope.It's already of size 3 and since 
CPIO_HDRLEN is 110 and PATH_MAX is 4096 + 3, it's far from the limit and 
it is calculated at compile time since all values are deducible.> 	b) 
just how large would that array have to be for it to "overflow"?
If c could be of any size, it would have to be of size 1,020,310 for 
32-bit kernels and a lot for 64-bit kernels around 4.4 quadrillion 
elements. Which is unrealistic.

> Incidentally, here the use of kcalloc would be unidiomatic - it's _not_
> allocating an array of that many fixed-sized elements.  CPIO_HDRLEN +
> PATH_MAX + 3 is not an element size - it's an upper bound on the amount
> of space we might need for a single element.  Chunks of data generated
> from array elements are placed into that buffer without any gaps -
> it's really an array of bytes, large enough to fit all of them.
Yes I get it now. But Even if the CPIO_HDRLEN + PATH_MAX + 3 is the 
upper bound on the amount of space and in use it doesn't have any gaps 
in memory, Shouldn't we change kzalloc() to kcalloc() since kzalloc() is 
deprecated[1]?
Regards,
Mehdi Ben Hadj Khelifa

[1]:https://docs.kernel.org/process/deprecated.html

