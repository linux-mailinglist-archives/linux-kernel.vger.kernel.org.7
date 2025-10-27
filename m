Return-Path: <linux-kernel+bounces-871169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FFC0C917
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601EB406497
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB92F5301;
	Mon, 27 Oct 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXLHdXBX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39242F49F8;
	Mon, 27 Oct 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555776; cv=none; b=YDXGM0Kwa/o7+SG6KksBx85HooZTeG1pXxwukltQV9Uu5bFgAy0TBYoZXHkKqx1berG1qL85weG4/OKjzVnPSat/EJvoGHmMORor47WmDEOA35hfKbyzjrPcxQEKpnxrqc/D7KeFhdFdr//JTqyFMweECyByzcySEzWHKi+Tdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555776; c=relaxed/simple;
	bh=G1ePlaSWeQMNuAJ53oX32ThxSRn7zfNb9gCAqZMnhFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZftzn3cuaqrpP35Ca12E7gA/KVTCK8+eozW12AEXSB3ouP8kM+HRlJTsPnQ8L0DdVRYubFPGkzibU8FapNBsDnLd4tbTNIVrOjX15GKreN+L2ejbSAwGWmGsid7VxaY9gU6Iho4cOv9oEgDdj2b7xiIpBh97brAMqk8OdC2muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXLHdXBX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761555775; x=1793091775;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=G1ePlaSWeQMNuAJ53oX32ThxSRn7zfNb9gCAqZMnhFs=;
  b=JXLHdXBXcam66NjXNxTX54ti8b0GzXvEpUaF5MzkBjNLr7N2TGmvVUKO
   ebS+xQ/Dov41qvvTiQQgGHh5N19lI0pqDsjyvfyse0UYljQtwdcpmQoT1
   f4oyD7U5UQHWRE2KhM9loFL4wrTF9Ov42QmSYtH5ImLqr/rocFli1xblO
   9BJfJL9OpUnPcp674iwan6eI9C5eO4T/mHSeFzbGnk99wfLUTa1ehmIJd
   LEHagUEWVmAL1rKmfaCwh9NQpV0csdoVBkEqFWl85V8r0GLFY8k97NgYq
   Qo7kX+0+LISNgVzQj16iP0H3txkoA3XO0HO80cz/bPOCFHQoEfVs/MDac
   Q==;
X-CSE-ConnectionGUID: dH/HtpCoS7GaBfw8OuzcFQ==
X-CSE-MsgGUID: a0koW0U7QeuVAEoPMA7i4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73919101"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="73919101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:02:54 -0700
X-CSE-ConnectionGUID: u2MvC9QpS4uX+ruEyclGQA==
X-CSE-MsgGUID: Jyzz3AT/R3aV/tylkEXqnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184893022"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.35])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:02:51 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: Re: [PATCH 21/21] Docs: add Functions parameters order section
In-Reply-To: <20251025163305.306787-14-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251025162858.305236-1-yury.norov@gmail.com>
 <20251025163305.306787-14-yury.norov@gmail.com>
Date: Mon, 27 Oct 2025 11:02:48 +0200
Message-ID: <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 25 Oct 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> Standardize parameters ordering in some typical cases to minimize
> confusion.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  Documentation/process/coding-style.rst | 48 ++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index d1a8e5465ed9..dde24148305c 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -523,6 +523,54 @@ below, compared to the **declaration** example above)::
>  	...
>   }
>  
> +6.2) Function parameters order
> +------------------------------
> +
> +The order of parameters is important both for code generation and readability.
> +Passing parameters in an unusual order is a common source of bugs. Listing
> +them in standard widely adopted order helps to avoid confusion.
> +
> +Many ABIs put first function parameter and return value in R0. If your
> +function returns one of its parameters, passing it at the very beginning
> +would lead to a better code generation. For example::
> +
> +        void *memset64(uint64_t *s, uint64_t v, size_t count);
> +        void *memcpy(void *dest, const void *src, size_t count);
> +
> +If your function doesn't propagate a parameter, but has a meaning of copying
> +and/or processing data, the best practice is following the traditional order:
> +destination, source, options, flags.
> +
> +for_each()-like iterators should take an enumerator the first. For example::
> +
> +        for_each_set_bit(bit, mask, nbits);
> +                do_something(bit);
> +
> +        list_for_each_entry(pos, head, member);
> +                do_something(pos);
> +
> +If function operates on a range or ranges of data, corresponding parameters
> +may be described as ``start - end`` or ``start - size`` pairs. In both cases,
> +the parameters should follow each other. For example::
> +
> +        int
> +        check_range(unsigned long vstart, unsigned long vend,
> +                    unsigned long kstart, unsigned long kend);
> +
> +        static inline void flush_icache_range(unsigned long start, unsigned long end);
> +
> +        static inline void flush_icache_user_page(struct vm_area_struct *vma,
> +                                            struct page *page,
> +                                            unsigned long addr, int len);
> +
> +Both ``start`` and ``end`` of the interval are inclusive.
> +
> +Describing intervals in order ``end - start`` is unfavorable. One notable
> +example is the ``GENMASK(high, low)`` macro. While such a notation is popular
> +in hardware context, particularly to describe registers structure, in context
> +of software development it looks counter intuitive and confusing. Please switch
> +to an equivalent ``BITS(low, high)`` version.
> +

GENMASK when used for defining hardware registers is completely fine,
and *much* easier to deal with when you cross check against the specs
that almost invariably define high:low.

Which other parts of coding style take on specific interfaces and tell
you to switch? Weird. I for one don't want to encourage an influx of
trivial patches doing GENMASK to BITS conversions, and then keep
rejecting them. It's just a huge collective waste of time.

Anyway, that's a lot of text on "function parameter order" to justify
BITS(), but completely skips more important principles such as "context
parameter first", or "destination first".


BR,
Jani.


>  7) Centralized exiting of functions
>  -----------------------------------

-- 
Jani Nikula, Intel

