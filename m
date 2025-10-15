Return-Path: <linux-kernel+bounces-855008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB1BDFEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479453BA251
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892C2343C0;
	Wed, 15 Oct 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2bkKfrr"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FC139579
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550120; cv=none; b=j9vNRQ2OQKERia65BgbHKgU62lDzJSTGIrAgrB3CtLtxkHV9OIdmte8uNdw3EWBCocXZXBnTVG73+yqYKJiJB2wF2aPpgzpMxY7ur1oBN463eDKae6UfmSMMKXpWpg4jsvNb/7ly4RuV0YmTBlBSL36dnIu8J3d6nExx2vyiwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550120; c=relaxed/simple;
	bh=BsinIirf/znp4ZNx+0O+fWW8rgU9YQc8f1+4d/a0Cmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjhXEvHAMjowvuK2wf/iT476bGJSpJEOa21LakPIcfiQUv7S9xPzEpWqzPvoKZXAiKhyJk0X0/LVwppjCRldAqfKhIjuTcJCTUcRBXBMnILxB1OHhG0+xLJFC5pH8TTL7sHDXOinMFWHAfyrotMgILBEE+jyvvBLlGIKkAhUhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2bkKfrr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-85d02580a07so141717885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550117; x=1761154917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suC77hzVyobtmY7W+3E8DzSiGFN4UsTLZ6PQ7vpF8OI=;
        b=J2bkKfrrX8Oq3ptQy9/u9Mqjf3O+DinZWUx51QMP6Ne6FAkruta3d6SC7FCjRvzX5/
         Db6k8wfuFGD5rocNi4fdtKp3plvjd6WJwF8DZpnY4FTIgZGTuBkW54yz8bwCuxnLT5Mr
         yRlX1xc2zyGnXMFeaQAmjIfU6lj22jErdwZet3OJpAyOkzBbDSaWJT96aCWXidRrFXQr
         iuwDpsvru/u2b5NdYGuO6sj4Kp75CagdFFFEAxuwbR1ZiR9fBWCiT9ke2Ud+VNT9B3k0
         Hz8u5YY+fGUskVsuUzjo7taQGCUxWf0cxSQcu9hpwH5WQpi+3OgQ1R4dsLsUAgpgpv7R
         l+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550117; x=1761154917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suC77hzVyobtmY7W+3E8DzSiGFN4UsTLZ6PQ7vpF8OI=;
        b=O3F3AlJTMqwsWfhD9mEUFPLvW3CC9GLX2YPF/rkkO8MsDIK7keTzjkxE2Fvpk8F1tL
         fYQf2ha4hKoVPjf8iKOTANT7Q2K5DfUQJ7z2lGvBIHZFYOvKiGacnsPtA5nJAXp4GRmw
         aIZdA8No34wYA1v+smh/35GQ+Sd+DRmeRr9i3P2d428hs6DLkxzYYHLvAdoOd3k7E6on
         v03gPgjkZWWoXZ9Qj8Df0uWL3LJaKzpoFdedk7I1OAfinLUKj9tkR+magh71Vx50yr6w
         vi0djTu12Ofo0hsBs9KEDdtRpuhpylNhHelgLzE2QQan1FcL4uJUneExWD8ZPFJOzzHi
         tvHg==
X-Gm-Message-State: AOJu0YyXrJWpdIAa/blLL0vCaQWY5jF8r6FM2zja96/s6QZElPAo898Q
	AkDuIZLyKqN9IZ7TIS2F9FeYr4Ow5YohivnL3cBM0k1uNQQ+DDwtpzff
X-Gm-Gg: ASbGncuR+KXhrrGc2iSj7hhaYPe66h9RymigVn17K2vgPwr9jzzit/Qu1UazpsxOCUo
	Gv2H4ufghemZ3+yrQsOZxWkXEsCs+KlEwncqpEzpfY5yaZtAX2j2EFj+5v66pBvVY4koHLO6ZGc
	AlFd1vR2Gv4RuD55m1b3AbQPwse7UD7uX0x4CssV5cp0EI34vwfzPqnTQqfyQx6ZUbyjjv/HJhY
	/CUhl+CoYeGzeg4k8SpMcwNVWsiucuMVW3diX163wKZtTY6EXMydxK2rFMPQL5dtEfgWz8WcEZn
	tZSeCOxNdmuwU6rcwAIvvMeb8B6fsIA2R2DiEZBsLRpDcHM3zBTLZJbatDYF4CfGWl+lkL4846f
	KrsfqjlUAj2WbOhIxrPRhVNRy9yZy+KtvsfwY8A==
X-Google-Smtp-Source: AGHT+IH9fOGizVUpN7L2QFq2vRtERyQuR7T66egoNQuyBkGsxOmwmC3/gPzJE/DfFIYe4MJVcwwCGg==
X-Received: by 2002:ac8:5715:0:b0:4b7:7e3b:26d2 with SMTP id d75a77b69052e-4e890faf8e9mr14231371cf.25.1760550117361;
        Wed, 15 Oct 2025 10:41:57 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012a1cdfsm22128946d6.49.2025.10.15.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:41:56 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:41:50 -0400
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
	Tim Chen <tim.c.chen@intel.com>,
	TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 07/19] cpumask: Introduce cpumask_or_weight()
Message-ID: <aO_c3lTmvJyzsOdE@yury>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.757776587@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015172834.757776587@linutronix.de>

Hi Tomas,

On Wed, Oct 15, 2025 at 07:29:36PM +0200, Thomas Gleixner wrote:
> CID management OR's two cpumasks and then calculates the weight on the
> result. That's inefficient as that has to walk the same stuff twice. As
> this is done with runqueue lock held, there is a real benefit of speeding
> this up.
> 
> Provide cpumask_or_weight() and the corresponding bitmap functions which
> return the weight of the OR result right away.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/bitmap.h  |   15 +++++++++++++++
>  include/linux/cpumask.h |   16 ++++++++++++++++
>  lib/bitmap.c            |   17 +++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -45,6 +45,7 @@ struct device;
>   *  bitmap_copy(dst, src, nbits)                *dst = *src
>   *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
>   *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
> + *  bitmap_or_weight(dst, src1, src2, nbits)    *dst = *src1 | *src2. Returns Hamming Weight of dst
>   *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
>   *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
>   *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
> @@ -165,6 +166,8 @@ bool __bitmap_and(unsigned long *dst, co
>  		 const unsigned long *bitmap2, unsigned int nbits);
>  void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>  		 const unsigned long *bitmap2, unsigned int nbits);
> +unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
> +				const unsigned long *bitmap2, unsigned int nbits);
>  void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
>  		  const unsigned long *bitmap2, unsigned int nbits);
>  bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> @@ -338,6 +341,18 @@ void bitmap_or(unsigned long *dst, const
>  }
>  
>  static __always_inline
> +unsigned int bitmap_or_weight(unsigned long *dst, const unsigned long *src1,
> +			      const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits)) {
> +		*dst = *src1 | *src2;
> +		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
> +	} else {
> +		return __bitmap_or_weight(dst, src1, src2, nbits);
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
> + * cpumask_or_weight - *dstp = *src1p | *src2p and return the weight of the result
> + * @dstp: the cpumask result
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Return: The number of bits set in the resulting cpumask @dstp
> + */
> +static __always_inline
> +unsigned int cpumask_or_weight(struct cpumask *dstp, const struct cpumask *src1p,
> +			       const struct cpumask *src2p)
> +{
> +	return bitmap_or_weight(cpumask_bits(dstp), cpumask_bits(src1p),
> +				cpumask_bits(src2p), small_cpumask_bits);
> +}
> +
> +/**
>   * cpumask_xor - *dstp = *src1p ^ *src2p
>   * @dstp: the cpumask result
>   * @src1p: the first input
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -253,6 +253,23 @@ void __bitmap_or(unsigned long *dst, con
>  }
>  EXPORT_SYMBOL(__bitmap_or);
>  
> +unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
> +				const unsigned long *bitmap2, unsigned int bits)
> +{
> +	unsigned int k, w = 0;
> +
> +	for (k = 0; k < bits / BITS_PER_LONG; k++) {
> +		dst[k] = bitmap1[k] | bitmap2[k];
> +		w += hweight_long(dst[k]);
> +	}
> +
> +	if (bits % BITS_PER_LONG) {
> +		dst[k] = bitmap1[k] | bitmap2[k];
> +		w += hweight_long(dst[k] & BITMAP_LAST_WORD_MASK(bits));
> +	}
> +	return w;
> +}

We've got bitmap_weight_and() and bitmap_weight_andnot() already. Can
you align naming with the existing scheme: bitmap_weight_or().

Also, for outline implementation, can you employ the BITMAP_WEIGHT()
macro?

Thanks,
Yury

