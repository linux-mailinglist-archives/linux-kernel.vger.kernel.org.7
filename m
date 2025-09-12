Return-Path: <linux-kernel+bounces-813002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C5DB53F80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5733B06F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74136282E1;
	Fri, 12 Sep 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3UC5jYU"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD23F9E8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757636878; cv=none; b=PHUD203E3UZxsFijlK50XwWyyK7E3Bosy5PxPh2aDONQrNxTtmrwjl/OoF6ZXRWpE7GjqbqBMSxke+Zj6K991gVreDMHnRD3Zk7zwS47nJWxyl9iWSJWQMDZHzctoS9ym6onDN+hybfS1WhcUdIZITS5KNxhOJWnDcOxAddhsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757636878; c=relaxed/simple;
	bh=biGpY1eDM9VEF5ItVBBgOSL/52vvAvXvOEFZPEEHIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv/xYYFkdsuSanNvUBSlS82hbznSdI1GU6LYJIUbToo4smYmhL23FyO+u978pIxH7plpagseeQ4xbqst7ZzjY//sRcIH8IwjyczPs3v2A+8+FhYj0Wa6Relw8xcr5WPqocKRQZZ2XqrSRT5joI60IN523BngCpdSJTBHL/SJpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3UC5jYU; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-32be6bc21c7so934855fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757636876; x=1758241676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Idsk6hlADPjxBpEO0KSCdleD5LRDgT/uF9HpZTys4jQ=;
        b=j3UC5jYUdHfeNohaGMNn/SduZyxoh4f8t7yXc219z2Ff0WTTyi3f/GHyQ15tT/cB9g
         GzvZhEtypryoDp7dmR4JrN12KHm4T6ZGcQn0zVzLjNTlmCTS8xx3C7bwwm9zsyiYtUwK
         t4AOtWTStABSxWv6NbiVpbrd1YZem9fACKmh3gBLVoKiv3l/dQqIekTIPOWHJ+fsmSFF
         GNcl54harqZfZpejwMvkdUb1YUNCBGCWJSC5cORYuIHaopfK5nTGIZv/lXIARtKPV4rU
         lHaYwwVfvW8QNLyWISj9/Pe9xef42hU/m4k7FSatL+ipibHuFP1rnBpye5mVbMjLxk89
         muSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757636876; x=1758241676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idsk6hlADPjxBpEO0KSCdleD5LRDgT/uF9HpZTys4jQ=;
        b=lF1OpexWdDWJanmgF8YoA0wQZIZr7SE64DlCoHyIwmlRTl7lXCbHWcrsPPh2G6xSFO
         rrcKGcj22WEbNmJHp+HLMwXGZGLSnBEouyiLBt+cnGT/BOEAfdh1s1VjHYuZokG/6ftt
         pjoWtdO/FEAOWEbB5h+m3judDdnjEBQ3LbpawSvdnyDp5SdZFzF9s8Eps0dmands1a9L
         cw6LPP/j9zIlOy/NHma9y77cRE+Fc6ypFpljuXJHpJBtDIxGn3CcNzggdG4Kwc5EbPZO
         d2YywTWxQMemEmYnCRNeeMM0JTpVWwBE7XAvzOqEkUrpCKDIMU+tBsaeTB1FntYPuX6Y
         OqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuqpsaBl5uQ1YMJZAxhGN5viGELnSw44pQwSCA9SDTIM33DD1c6rSjHG6vtboLr07Z127HGkH2O7OWXzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ukJKaw6qAIPhYDZtKKhN9RzKc3P+ONCFLsTLwytm6/HrQx12
	ibDZyLNK2xjYUrBiYUvB465RG96ISbXT2zJbyJFRDCNxoI54KvHz/0WpJZ0rnA==
X-Gm-Gg: ASbGncvMZDHC482ftDwovIL2n5/DJcnxINk59OPoI/d4+kNGY1e5uaeIVCzHxQ3fPsz
	DHyiXDurlvR9AHHP+eFUg/IvPlW8cc0hEv+7D04Phpwy/IgAjNZiaKoR/+/1T+MNtEzKDavDvia
	tZQ9QMUxWKUBbvIyvI52yg/FSxLdRW1Y63W2U5IH3xjs92xCfs4glXXryawS+kjM61/7JjcfM9i
	NuMPydIUgHggwOuYuulRKFBU5/er8B0n2Jk8soWBK3lodgcApxqBbIZI0jtRTFerU2HKYhR65P7
	JZlTBIk+VtOyCXuhYm3oNc5OoEcW/vJUw25MbBaLojkMlBTObic35Cxr68dejPYHjOH2ARb/h0/
	jSjbw7Jx1KDwQm8XR+HZelunIl90I7FeBRm1zWvbenX7zJF0d48+zOg4FGChe2pxBnSDk
X-Google-Smtp-Source: AGHT+IHrcApczyV0/Z9+I9D8KVdIGapYTwq8V/eMviOsp0VNX+SfApS6oDK1nQsIgH7gykwtKQXrCQ==
X-Received: by 2002:a05:6870:7d86:b0:314:b6a6:688a with SMTP id 586e51a60fabf-32e57801ecbmr424170fac.42.1757636876325;
        Thu, 11 Sep 2025 17:27:56 -0700 (PDT)
Received: from my-computer (c-73-136-245-43.hsd1.tx.comcast.net. [73.136.245.43])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d56557sm796602fac.1.2025.09.11.17.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 17:27:55 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:27:26 -0500
From: Andrew Ballance <andrewjballance@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Printing with overflow checks can cause modpost errors
Message-ID: <aMNo7qRCp_yprUAW@my-computer>
References: <20250911213157.GA1039411@joelbox2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911213157.GA1039411@joelbox2>

On Thu, Sep 11, 2025 at 05:31:57PM -0400, Joel Fernandes wrote:
> Hello,
> Recently some of have been running into modpost errors more frequently. Ahead
> of Kangrejos, I am trying to study them, the one I looked at today is truly
> weird, below are more details.
> 
> I narrowed it down to the print statement and specifically the FFI call to
> printk bindings. This was first reported by Timur Tabi on CC. 
> 
> With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
> following patch when applied to nova-core will fail to build with following
> errors. The question is why does the overflow checking fail since the
> arithmetic is valid, and why only during printing (and say not during the
> call to write32).
> 
>   MODPOST Module.symvers
> ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> Any comments or thoughts?
> 

Io::write32 tries to do a bounds check at compile time and if it cannot
be done it causes a build error. it looks like because a pointer to
offset is passed across a ffi boundary, rustc makes no assumptions about
the value of offset. so it cannot do the bounds check at compile time
and causes a build error.

Best regards,
Andrew Ballance

