Return-Path: <linux-kernel+bounces-774029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F565B2ADC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071381961D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0633472B;
	Mon, 18 Aug 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YsagBpYH"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF832254B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533252; cv=none; b=u/m/GzzRLBl0+is+E9+S3lxTfy0M2D6KkjnysOEXGjan6pQUfR4v3fzVFFEaUfeKrnsjCkkYgcdZ95Nmpp24BCVBaoQ0mdEOPhU5FL+fH0MzBF08bcn/+hT0WouUQzYsEbi/3SuYaOPENc8/8qtSukJcrkZcNjwo/FiknCTB7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533252; c=relaxed/simple;
	bh=0nLVq+gyo5ua7q1KGVWcw01ye202OQtFJ6ZkdqKnAqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhNsqjbj+SjjMTiTFn2frrOjisJ/lYlzlrNYSli9/wxVipZfCpyK4IN56NQg6D3wB2XoLG7bUE4CTVjJNFtJRPs+gMXehGkGhR8uiE4FlzCmxZXB0ccP916c5GwwhRD/moY8eMRwuBCcygs194pqAtuRFu6pmZ9F/pM19bNkWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YsagBpYH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-435de86378eso2836740b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755533249; x=1756138049; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6ek7I0iyYbZpN/v0UC5zzd0o0Ftoqgt1vFlNzowpm0=;
        b=YsagBpYHWj8Rze3msRgGDkKPLcRpse8AAitr9j0v32EO62pXxbPXA1KN/uVfmIOTDK
         ZCvST9AFkbsdMlIhRSRxQthqv5hkUXYUAF1ANV+AfevxGl7l/ToXEtiSve55Or8LLcG3
         IGYzHeI/Uup2wv99medEXXo3z2f58+Za43I/rMlEdN46KDni3h0l4cpqkoG6tpdAr5Oi
         tnlY5AyGYRb1J3HPHubEAayCPYFOipHUlzJAz3ltMils0cvUAUtbwNbVDajWvfQa/ZUc
         zp3Iv6+P8W9tH1KyKhmshnUido4ScEHsS//dRhmcnnFBOpXCj/bzDpxjtazZ9jjUQRfZ
         Q8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533249; x=1756138049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6ek7I0iyYbZpN/v0UC5zzd0o0Ftoqgt1vFlNzowpm0=;
        b=CBY29F/NgfcqB1inZN/mnP5HVCxffR8JFSZC76Iv3Mw6kbKeuUdr6Bet06usOXA/aN
         rBQOEBJobncgrR4/b+1ZlFmKruOLctJc2BO0TsAtAcHoErjeVTiFIK/4ANybAkfszvNt
         +OyGLN6Jc+uqpUKqTqztF0X4rU1SHKAWt+G284awA3Hgsc0sWE7mda6TwH1s3c2DUGd5
         CvmjxLEJh6olt8YgbzxpV3F2vIqPWVZuyBtxDHQ+DNl2XU0wCZRNiohuSWrFLRppSlxb
         N4eqo19VN9ZWFuNFJZBa5PBuQmIZGHSlGWLWVr9lkvKSjqpt70YtU3aQmqH3brZ8Fl6n
         4Z/g==
X-Forwarded-Encrypted: i=1; AJvYcCXkq3cEnNhd5+sFuut/6oYrLkZMFlKiYY9Ya3a4Tl2T1+l5ECjQh+YIy3Tx5cJiTSK3GGEqcTMzxIYD8DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOPc/F5tPGvdHaFV6qppP1b/HpWz02iy0h4aFXuevfTTBeARa
	pzD1+VRvdlXynYcXDR7WaGwpoFz40ZXyYmWqQqZ2EVDlLWpBOTJHlsax3gQ+jap2n2A=
X-Gm-Gg: ASbGnct9VKDCkLMLjgvOA/xLiWuX6MRy5TmVRZOSZAjGz1O8n4FZuRYOgGXvj1CJyXK
	lnTOkuSQfp9lfBUkD6jDup+tRFMhHCYmyUCXUMaxCZXFw+qLtYPbWyhyLzEYA1llMAJ5vLsFvru
	+Lfjs8Bd2GcIZBpfJCrOL/PklcpsWrdkwt2VOCN9Tsn31rOmaZF9OE94hnpv0Cry4HehxE2Lwpp
	0iRlncftz6D1TsGMFA7w64wWWjGqRB7g5bCMgaHcPyUBVvxkCYAllYKZaGpZ4qyi+xq9tuUVcDK
	BTu/UQST0nRflBQIndjE1ABr7Uy1epQdDC+vwj9hxHRzUYq+UsktRudXta6tvWidrxQ5U1wS
X-Google-Smtp-Source: AGHT+IHkRfCegHArKlwGfaPyx0kzz53A2FyhdpjpMnPcsXRnYC7i/30cf6RRe0zz3Qa6ICjSFo5brQ==
X-Received: by 2002:a05:6808:3a07:b0:435:8506:2263 with SMTP id 5614622812f47-435ec487ee3mr6478173b6e.24.1755533249123;
        Mon, 18 Aug 2025 09:07:29 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1b10bfsm1783361b6e.18.2025.08.18.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:07:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uo2OM-00000004Orw-2igd;
	Mon, 18 Aug 2025 13:07:26 -0300
Date: Mon, 18 Aug 2025 13:07:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/6] mm/mmu_notifier: Allow multiple struct
 mmu_interval_notifier passes
Message-ID: <20250818160726.GH599331@ziepe.ca>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
 <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>

On Sat, Aug 09, 2025 at 03:51:32PM +0200, Thomas Hellström wrote:
> GPU use-cases for mmu_interval_notifiers with hmm often involve
> starting a gpu operation and then waiting for it to complete.
> These operations are typically context preemption or TLB flushing.
> 
> With single-pass notifiers per GPU this doesn't scale in
> multi-gpu scenarios. In those scenarios we'd want to first start
> preemption- or TLB flushing on all GPUs and as a second pass wait
> for them to complete on all gpus.

The idea seems reasonable but I'm not sure I like the naming of
'multipass' or necessarily the complexity.

This is sort of a co-operative multithreading thing.

Do you really need a linked list here? At least justify the design
choices in the commit message..

> +struct mmu_interval_notifier_pass {
> +	struct list_head link;
> +	/**
> +	 * @pass: Driver callback for additionall pass.
> +	 * @additional_pass: Pointer to the mmu_interval_notifier_pass structure.
> +	 * @range: The mmu_notifier_range.
> +	 * @cur_seq: The current sequence set by the first pass.
> +	 *
> +	 * Return: Either a pointer to a valid mmu_interval_notifier_pass for
> +	 * another pass to be called, or %NULL if processing is complete for this
> +	 * notifier. There is no error reporting mechanism for additional passes.
> +	 */
> +	struct mmu_interval_notifier_pass *
> +	(*pass) (struct mmu_interval_notifier_pass *additional_pass,
> +		 const struct mmu_notifier_range *range,
> +		 unsigned long cur_seq);
> +};
> +
>  /**
>   * struct mmu_interval_notifier_ops
>   * @invalidate: Upon return the caller must stop using any SPTEs within this
> @@ -243,6 +269,10 @@ struct mmu_interval_notifier_ops {
>  	bool (*invalidate)(struct mmu_interval_notifier *interval_sub,
>  			   const struct mmu_notifier_range *range,
>  			   unsigned long cur_seq);
> +	bool (*invalidate_multipass)(struct mmu_interval_notifier *interval_sub,
> +				     const struct mmu_notifier_range *range,
> +				     unsigned long cur_seq,
> +				     struct mmu_interval_notifier_pass **pass);

Couldn't this just have a pass number counter and some return code to
indicate this notifier is done?

Or do you really need more than 2 passes? Start/finish make sense
too. Otherwise you may have issues overlapping the backgroundable
operations between different driver types?

> +static void mn_itree_additional_passes(struct list_head *additional_passes,
> +				       const struct mmu_notifier_range *range,
> +				       unsigned long cur_seq)
> +{
> +	struct mmu_interval_notifier_pass *p, *next;
> +
> +	while (!list_empty(additional_passes)) {
> +		list_for_each_entry_safe(p, next, additional_passes, link) {
> +			list_del_init(&p->link);
> +			p = p->pass(p, range, cur_seq);
> +			if (p)
> +				list_add_tail(&p->link, additional_passes);
> +		}
> +	}

Like this is very naive, if one driver has only 'prepare' and 'wait
for device ack' passes, then it will immediately stop being concurrent
while another device may be still working on its 3rd pass.

So either this should be more complicated to properly support
different numbers of passes per registration or we should just support
two passes and be done with it?

Jason

