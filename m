Return-Path: <linux-kernel+bounces-882986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE4C2C170
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B251893C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB30303A15;
	Mon,  3 Nov 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbxTcQOV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSi/CTPE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF72F0670
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176603; cv=none; b=S6kT7hKlRmI8wBqO7h5smm+/62iPedilJQyxGZ1Ic/2VnjnjZSdbN5VRpDvVjci2EKABixzhEhkqSuVLrcBb9hlNiZTniPRK05qG/6h5JoyeFtLxuT/mGJFK2cnEkeUpbPoSYgcEu16aWKzW98ImLThh8dOeg5vdv8D/J1xYpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176603; c=relaxed/simple;
	bh=1wx3sGMlAjIJ25V9kLnVxb1FCvPDfxLx2gzXU+LMUbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1zaHyRXdescuGafVBAv+1O355VI/sJn+aJFy184bU+2NUMHyMX+cdiZAWqMJqT9KX4bXrwbqObjPTFb/SDCXts/g/LsBaY6IAgfCfFe+GaktEX7nlEZ0YBdi1899CMXQXwniJSZaybHuSRKosiiiGjz8gbrUYeeWl2NLNdwzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbxTcQOV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OSi/CTPE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762176600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZi/1jjNoUO6QAtGhKAuwW6mw9HS1sPAGktTt2mBtl4=;
	b=nbxTcQOVkDN6wdxdEaoDmADkEF1VbgxGG6RnUABu6L+pgkJwCukaMBhYXCtKTeUKARLi23
	TBgDnA8Z+Sc4ITURw3dDC38tdteqglRgR67HDj1ZM2ytsuPzCvRT5uHpvwIv4UZeD6K3ks
	jV4Qkrdmz/e9yNyf4c61DXzA/lVh/CEa9jHekE/OC0rDf0m67hwc4/6Nar1tMH+hF5JidG
	GHGmCCglHQv4lUtzFjt12h9VrgBQ41MCDgUl92zzr16e76TmwHaYFV7cw9FcAaiplXEGD5
	Q7UiqAQZ7oA9UgTc7bhtGfdCHxEaeTn9FaCIjWxLGEeu7peG9ihtYawsOFuIMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762176600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZi/1jjNoUO6QAtGhKAuwW6mw9HS1sPAGktTt2mBtl4=;
	b=OSi/CTPE/z91mAPENZCZybza7vOE+Jp1utffeAC+jFTKpYjiMpuVn4Z0iGHrzO0BaovaOp
	iEgs9CiAJ6DYIlCQ==
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [patch V3 07/20] cpumask: Introduce cpumask_weighted_or()
In-Reply-To: <88d397b7-5eeb-41eb-ba44-980e72008fd2@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.717519165@linutronix.de>
 <88d397b7-5eeb-41eb-ba44-980e72008fd2@linux.ibm.com>
Date: Mon, 03 Nov 2025 14:29:59 +0100
Message-ID: <87qzufw8fc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 03 2025 at 14:45, Shrikanth Hegde wrote:
> On 10/29/25 6:39 PM, Thomas Gleixner wrote:
>> +static __always_inline
>> +unsigned int cpumask_weighted_or(struct cpumask *dstp, const struct cpumask *src1p,
>> +				 const struct cpumask *src2p)
>> +{
>> +	return bitmap_weighted_or(cpumask_bits(dstp), cpumask_bits(src1p),
>> +				  cpumask_bits(src2p), small_cpumask_bits);
>> +}
>
> nit:
>
> We have currently cpumask_weight_and & variants.
> Wouldn't it be better to name it cpumask_weight_or ?

No. cpumask_weight_and() does weight(mask1 & mask2) but this does

    mask3 = mask1 | mask2;
    weight(mask3);

That's two very different things.

