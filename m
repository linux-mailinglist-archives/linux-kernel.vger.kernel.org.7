Return-Path: <linux-kernel+bounces-867389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D301C0278E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9A84EB9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18800322541;
	Thu, 23 Oct 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+kE+46I"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A531A56B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237465; cv=none; b=oplp6pwd5v77iy75QXaQCNFdsGAGRT3GxgvqmvIs6O4gAfTX+7J4geKIyOR2fIWnVoFnr7H/5oFFjjRzchvDxSru/U4k0UOFOEg43MsHWM0L1W9QIdEe6sG1Xie44/gmO+dPufrxYZxqKQUqUnYvaAZTwqAba43xh9Rb1xYd2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237465; c=relaxed/simple;
	bh=n4xZpbQP+wjDmEMBPzLT/m0RnwiIqd287DF1feMd4Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb18Xcj3IMP3IPilgD3wJvcaF512faY4jepOt5T/bVAPl3XTnz7IpCvjtD7BzI6s63hfJHDKACyO4kdNIwdikVOT7Ap8bjm/yfDiIMrGSScPPjcHENCzxCkjjoeofB9WsfpbTdbvxIxCTV/ksGwak7u9Ofm83J21uauFFx84nRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+kE+46I; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88f8f346c2cso108659985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761237462; x=1761842262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/s5yix21HmdEBfIV0ckUFJ1IIkUKMDZn7M3THeIFGKk=;
        b=U+kE+46IHt1rUCI6uX5SuxopbGjfF0uMk7h/Ywoq/q6gUZxW7NzFy7RR2D8OgURHAt
         VbYYakueWEHM9R7/tt7isG4kUkm1eJJuFlSUlCm34JD/Mos6J3tS+GW9LZLUzDJbh4cd
         HiK7XmKiqe1cC8UQDA96zhytcEgEvQm0nNSep/zgJxbUPT/grZXe8XElzm3t40toWbSk
         VsoW/E1tuJXPlHeaGRio+zqWKXHTc7Lka3tIFxJfHzAI/54Pt91iwKJ4vFlZA7KvUv6V
         EyaOm/r3b/vvLV/Yl3RdG9LTpsb0Q3HleX1169kMW13WUafYJWyX4avSImVSQduiP5Il
         CN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237462; x=1761842262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s5yix21HmdEBfIV0ckUFJ1IIkUKMDZn7M3THeIFGKk=;
        b=smuiZrwzEej76XPDP6xonsiYcOkZQ++uEzbs/oe9Df9aN/0mFSigPabLqcv3Fs7bhz
         VQY3PcJ7aP4W1jXIy2lUeO18vPvDkyfRipYN1W4mHv4ANLRYju675J2BOytryIPgxikK
         i/7/3qkgIdjmoWZaK8uS3bkAP99WjhC6NYz3+kEplruz8CaC4bXpk6pe1cjL7nnDuz5Y
         sQv3To3Dx7rzUroMr2gWKvCwaOeZCJhia2/jByRCjRN8NBtWQ+idIf9cWIyhREKCjnwD
         rECLG4aDwxlBN5x4vJdxxy96ety/fscEfJgnZYcWhSOR9dJyKhYwX/xeU7jLiXc2hLuv
         B6Fw==
X-Gm-Message-State: AOJu0YxXEunD5Lwab8W4O+pb4Ysv68nFVkWrSCCYJa3zsQ7bVzR/qFat
	G/Ww/CwUpelT+OH9U4SCMhqZlwXuv6jwAuFokETSiciGnlpzPAp7mRWg
X-Gm-Gg: ASbGncvHe0o00mbFmu5v6ECBqR7Ifq5eIeEwketD4nDuccjQN1Sf/DrjmD8UZPtpx4L
	ByFzc/+WRN9ouVQSI1wbWWkwahoyJNZHoi7lpuoMw/ULyjyLIO4XeMtWN/j9J0UaDjHBgqSb7W0
	6Tm/gCMjAdMsVsHv6Lde9lnf+YVKeu7AkM6W7A9LdT7PWHQXX8Tmt3zSW+sAInqWf6gZDRfV+nI
	oLIdByKdsL9wAnJxZWJO/Y/bAFnm0yGYMuKmm+QZPrvXvpdPM8j9kIpWV0fcRXBxQkMFmOIJuiZ
	dM7yLKDUMaXslLLCz4/iG/rDI9rZzw6E4t34GEiwvb8q8Pd1zsFQ5GaouJHxR8zixkwkRenMBax
	T4otLx2j3wKZ+bRJrRcRHf72AbqTbj0kLIKlwU1QgrWCv7MW971J+BCZzOxUx0CcOywXvVBeOya
	XasVNJC60=
X-Google-Smtp-Source: AGHT+IFvklCkjOqTgnlXIWVWMIWL7sS7maO1XSIXZjkCVM9Blgpl4AbKEvp7bGe2dqkt7u1i43hGYw==
X-Received: by 2002:ad4:5cc1:0:b0:878:ee25:427d with SMTP id 6a1803df08f44-87c20648fc1mr304887056d6.59.1761237462431;
        Thu, 23 Oct 2025 09:37:42 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9f8edeaesm16560706d6.48.2025.10.23.09.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:37:41 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:37:40 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [patch V2 07/20] cpumask: Introduce cpumask_or_and_calc_weight()
Message-ID: <aPpZ1HHXh_RMGIjR@yury>
References: <20251022104005.907410538@linutronix.de>
 <20251022110555.837390652@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022110555.837390652@linutronix.de>

On Wed, Oct 22, 2025 at 02:55:28PM +0200, Thomas Gleixner wrote:
> CID management OR's two cpumasks and then calculates the weight on the
> result. That's inefficient as that has to walk the same stuff twice. As
> this is done with runqueue lock held, there is a real benefit of speeding
> this up. Depending on the system this results in 10-20% less cycles spent
> with runqueue lock held for a 4K cpumask.
> 
> Provide cpumask_or_and_calc_weight() and the corresponding bitmap functions
> which return the weight of the OR result right away.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
> V2: Rename and use the BITMAP_WEIGHT() macro - Yury
> ---
>  include/linux/bitmap.h  |   16 ++++++++++++++++
>  include/linux/cpumask.h |   16 ++++++++++++++++
>  lib/bitmap.c            |    6 ++++++
>  3 files changed, 38 insertions(+)
> 
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -45,6 +45,8 @@ struct device;
>   *  bitmap_copy(dst, src, nbits)                *dst = *src
>   *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
>   *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
> + *  bitmap_or_and_calc_weight(dst, src1, src2, nbits)
> + *						*dst = *src1 | *src2. Returns Hamming Weight of dst
>   *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
>   *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
>   *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
> @@ -165,6 +167,8 @@ bool __bitmap_and(unsigned long *dst, co
>  		 const unsigned long *bitmap2, unsigned int nbits);
>  void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>  		 const unsigned long *bitmap2, unsigned int nbits);
> +unsigned int __bitmap_or_and_calc_weight(unsigned long *dst, const unsigned long *bitmap1,
> +					 const unsigned long *bitmap2, unsigned int nbits);
>  void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
>  		  const unsigned long *bitmap2, unsigned int nbits);
>  bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> @@ -338,6 +342,18 @@ void bitmap_or(unsigned long *dst, const
>  }
>  
>  static __always_inline
> +unsigned int bitmap_or_and_calc_weight(unsigned long *dst, const unsigned long *src1,
> +				       const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits)) {
> +		*dst = *src1 | *src2;
> +		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
> +	} else {
> +		return __bitmap_or_and_calc_weight(dst, src1, src2, nbits);
> +	}
> +}
> +
> +static __always_inline
>  void bitmap_xor(unsigned long *dst, const unsigned long *src1,
>  		const unsigned long *src2, unsigned int nbits)
>  {
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -729,6 +729,22 @@ void cpumask_or(struct cpumask *dstp, co
>  }
>  
>  /**
> + * cpumask_or_and_calc_weight - *dstp = *src1p | *src2p and return the weight of the result
> + * @dstp: the cpumask result
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Return: The number of bits set in the resulting cpumask @dstp
> + */
> +static __always_inline
> +unsigned int cpumask_or_and_calc_weight(struct cpumask *dstp, const struct cpumask *src1p,
> +					const struct cpumask *src2p)
> +{
> +	return bitmap_or_and_calc_weight(cpumask_bits(dstp), cpumask_bits(src1p),
> +					 cpumask_bits(src2p), small_cpumask_bits);
> +}
> +
> +/**
>   * cpumask_xor - *dstp = *src1p ^ *src2p
>   * @dstp: the cpumask result
>   * @src1p: the first input
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -355,6 +355,12 @@ unsigned int __bitmap_weight_andnot(cons
>  }
>  EXPORT_SYMBOL(__bitmap_weight_andnot);
>  
> +unsigned int __bitmap_or_and_calc_weight(unsigned long *dst, const unsigned long *bitmap1,
> +					 const unsigned long *bitmap2, unsigned int bits)
> +{
> +	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);

Nice!

> +}
> +

Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Maybe bitmap_weighted_or()?


