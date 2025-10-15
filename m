Return-Path: <linux-kernel+bounces-855029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA64BDFFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9765E548461
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E630147F;
	Wed, 15 Oct 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhLX5V4m"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1862FF66A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551567; cv=none; b=TdiJrxxAm60GtAen4sA1+o8FvzdwQVi6zMgLjHXa1hHWrzKKhLTZjDsMYiQUhzpL+4LAhfUNzyFBb5GmruPrNjeoVXgddhJy33faDk/B1HT72vUl/iG3YFfcBSj3jv/l0PAfxEbqNQ+KmD8f9Yuo+SpooxyXR6bkc3A/F+RoBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551567; c=relaxed/simple;
	bh=saXVXN/G1RmY/0tPS6bMXu5JGYHAEvpDgnNRPxaVDqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs63VREPKscbYXfVLEMej4M8oBYYEW48zC9uYVG5dbIQmmAkbbV5TK73ZxMbkz/Poj8w9n5Qmc4yM9xFSUxDEJJ/vQUeV7+/NK+2WpVh55mAZPR/HS7KyllPi4+11hH5PEH9yF7yPbOsugLROoXNrQ5HHZsomeyRzGMf8cPWKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhLX5V4m; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88e371e3cbfso158018485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760551563; x=1761156363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0l6MkKaSifnnXj5OTlg2FyNdCV8jBiow9l/iWjkN4k=;
        b=DhLX5V4mF40kTqtfKGDpSNaV2ZPxVLUSu/0YL0hTon77xOX8uxuB4gaVguQjBNv7QE
         y+h2y8uSPuYqjepuYRCoqBgY8J5B5oGXoK5GcbgChC3GatGt56L/ZXjUhJ6L7v/oP2tc
         Oq2M60AM+rx8ZVthzo8S8UQRp8NwmBlS2TP+4/wTa4CdJ7PN45WE6VRlV3OmnAAy0U9y
         X5eLAOTfjQdYFHVt3PX52cKMFWBRxcsJhJpFZSy72/9akVuwOWVcJDrBsq9aU/7TKh7T
         INManWUS9hOb8FQODaRAuWmB5ldcYbbVug7SeN8PqwkajVGakv8WV4Ec3vWQ9hV1pgm9
         zrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551563; x=1761156363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0l6MkKaSifnnXj5OTlg2FyNdCV8jBiow9l/iWjkN4k=;
        b=oTVF145DTHNvCDCffO2BkdX1kmyq/+nRNu4rw6cGouBDjMZFR8rEKiin5F2UAwEgB2
         e3sUTCe0+cVtdYUkeaZKP4zpnzkAjNd74Bwioq0c9ceCkyHEx/Bpfvxt9MM1h8tW2Vok
         YSfRAXnnmxDOYeN513putRHmPD1alneSNAnI86JrlpJwc5CY6ItOHjCfKofgeAjFd4k1
         FrLMXrhTYXDCAqM9N5KudN5O76W5IQzLUZw/o/A64NY740EcrhFAIBqEd3uS+61DsFHs
         7XYPcuJfY6WgUXTChZFM8+NpapWvDgCEWr8dvlD/cdbUQur77ITBDH3e1Q27f58a2BGU
         rPew==
X-Gm-Message-State: AOJu0YzK8LGPChFVTIXYiUsGYSQCzGWfxpURkeXarNAOHGgev9ty2kGH
	9z+/LMv31b8Eg/KbG1SSR/t4CE+WKZwBgOZ5nKdcZj9WQffVYJxlIcSk
X-Gm-Gg: ASbGncvIgfxgXemNC0PEGkPFsmWe3LiOy9s6/NGl6XYOmeuAgTaFjcwKorTFCh15qEg
	OAUpTJrdp/1fFjtS9KCRNIeGdHUxNmva1dISV0wxGuxzlSDIRexdvm6lTUI3FyWdWzIoLSzsVBj
	UXFGHkWStiT0BY2leiPiCAnkO2YwubAV0WbgBcsGj+i9+6eq5WjNM2puoSYh9sUsQ2GV7DN472r
	cJsFDl1EeD50uajgfGfDQbw3H6VdoxgfUau6tB9Jt2fxvqs+TdjYQdCqHgBvK2K6Wkap2yz+sbS
	xruZq8BiOC+anuyFhi7m0fUlNfSdLA9mN1sQeE8128P+blcjUhs5ju9Ima6a/Iu11FOTi8Z6FaB
	E0Xz1v1S1CCOYxOAZq8dFYtzPcXbO6QCvU7a6Og==
X-Google-Smtp-Source: AGHT+IH07pUTWfoILeAURCrXsbdCzX9r9za0TXbpl6sdSzuVgHj1Z35BAP4re0250XF4/DIhG+m8HA==
X-Received: by 2002:a05:622a:20f:b0:4e8:8ed6:9be2 with SMTP id d75a77b69052e-4e88ed69fb9mr27068601cf.83.1760551562889;
        Wed, 15 Oct 2025 11:06:02 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d294e1sm23265111cf.39.2025.10.15.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:06:01 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:06:00 -0400
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
Message-ID: <aO_iiKKVyKSlXeF2@yury>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.757776587@linutronix.de>
 <aO_c3lTmvJyzsOdE@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO_c3lTmvJyzsOdE@yury>

On Wed, Oct 15, 2025 at 01:41:50PM -0400, Yury Norov wrote:
> Hi Tomas,
> 
> On Wed, Oct 15, 2025 at 07:29:36PM +0200, Thomas Gleixner wrote:
> > CID management OR's two cpumasks and then calculates the weight on the
> > result. That's inefficient as that has to walk the same stuff twice. As
> > this is done with runqueue lock held, there is a real benefit of speeding
> > this up.
> > 
> > Provide cpumask_or_weight() and the corresponding bitmap functions which
> > return the weight of the OR result right away.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/bitmap.h  |   15 +++++++++++++++
> >  include/linux/cpumask.h |   16 ++++++++++++++++
> >  lib/bitmap.c            |   17 +++++++++++++++++
> >  3 files changed, 48 insertions(+)
> > 
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -45,6 +45,7 @@ struct device;
> >   *  bitmap_copy(dst, src, nbits)                *dst = *src
> >   *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
> >   *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
> > + *  bitmap_or_weight(dst, src1, src2, nbits)    *dst = *src1 | *src2. Returns Hamming Weight of dst
> >   *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
> >   *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
> >   *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
> > @@ -165,6 +166,8 @@ bool __bitmap_and(unsigned long *dst, co
> >  		 const unsigned long *bitmap2, unsigned int nbits);
> >  void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
> >  		 const unsigned long *bitmap2, unsigned int nbits);
> > +unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
> > +				const unsigned long *bitmap2, unsigned int nbits);
> >  void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
> >  		  const unsigned long *bitmap2, unsigned int nbits);
> >  bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> > @@ -338,6 +341,18 @@ void bitmap_or(unsigned long *dst, const
> >  }
> >  
> >  static __always_inline
> > +unsigned int bitmap_or_weight(unsigned long *dst, const unsigned long *src1,
> > +			      const unsigned long *src2, unsigned int nbits)
> > +{
> > +	if (small_const_nbits(nbits)) {
> > +		*dst = *src1 | *src2;
> > +		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
> > +	} else {
> > +		return __bitmap_or_weight(dst, src1, src2, nbits);
> > +	}
> > +}
> > +
> > +static __always_inline
> >  void bitmap_xor(unsigned long *dst, const unsigned long *src1,
> >  		const unsigned long *src2, unsigned int nbits)
> >  {
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -729,6 +729,22 @@ void cpumask_or(struct cpumask *dstp, co
> >  }
> >  
> >  /**
> > + * cpumask_or_weight - *dstp = *src1p | *src2p and return the weight of the result
> > + * @dstp: the cpumask result
> > + * @src1p: the first input
> > + * @src2p: the second input
> > + *
> > + * Return: The number of bits set in the resulting cpumask @dstp
> > + */
> > +static __always_inline
> > +unsigned int cpumask_or_weight(struct cpumask *dstp, const struct cpumask *src1p,
> > +			       const struct cpumask *src2p)
> > +{
> > +	return bitmap_or_weight(cpumask_bits(dstp), cpumask_bits(src1p),
> > +				cpumask_bits(src2p), small_cpumask_bits);
> > +}
> > +
> > +/**
> >   * cpumask_xor - *dstp = *src1p ^ *src2p
> >   * @dstp: the cpumask result
> >   * @src1p: the first input
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -253,6 +253,23 @@ void __bitmap_or(unsigned long *dst, con
> >  }
> >  EXPORT_SYMBOL(__bitmap_or);
> >  
> > +unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
> > +				const unsigned long *bitmap2, unsigned int bits)
> > +{
> > +	unsigned int k, w = 0;
> > +
> > +	for (k = 0; k < bits / BITS_PER_LONG; k++) {
> > +		dst[k] = bitmap1[k] | bitmap2[k];
> > +		w += hweight_long(dst[k]);
> > +	}
> > +
> > +	if (bits % BITS_PER_LONG) {
> > +		dst[k] = bitmap1[k] | bitmap2[k];
> > +		w += hweight_long(dst[k] & BITMAP_LAST_WORD_MASK(bits));
> > +	}
> > +	return w;
> > +}
> 
> We've got bitmap_weight_and() and bitmap_weight_andnot() already. Can
> you align naming with the existing scheme: bitmap_weight_or().
> 
> Also, for outline implementation, can you employ the BITMAP_WEIGHT()
> macro?

Ok, I see now. You want to do a regular cpumask_or(), but return the
hweight() of the result, instead of a boolean.

The cpumask_or_weight() may be really confused with cpumask_weight_or().
Can you try considering a different naming? (I am seemingly can't.)

Can you describe the performance impact you've mentioned in the commit
message in more details?

Anyways, for the approach:

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

