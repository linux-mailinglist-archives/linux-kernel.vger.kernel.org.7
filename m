Return-Path: <linux-kernel+bounces-792446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D21B3C407
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE107B953F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197E257459;
	Fri, 29 Aug 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJdanWQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1B13A86C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501323; cv=none; b=hxYnHQ+yp/+BsY+mL/3oeB1Vm6v0lCIiK/s1OMw3P5y5K8npDZrTHFOJiwoiPeXc4oGHb8l2zqqEfpbg6pmC/jRNlUEaySU1ph6RtdjDC+rZxY18e6tQ1qs4+MhFWo8ookdCzNTgNkNeKll1UvmH53t2KHPRp/5t+ICUiB5YapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501323; c=relaxed/simple;
	bh=XfwR4hxOI5qyZEumBA82tqSDjfKDKjvzno3THU3PxVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBsvxNpPDnpBcnek+F/E/QYsuMLGA4b0hFI53P+j2Sc//08ejTZrMkW5MIiX6PLp1/pbkfRnMc1Iac10zzERiSNcn9tr9ybETAxAEHKdOmSpEaCs4gXUS3gtidmJH5OAD/eFrAQ6nmz9P1e4sGJ4vIBdj/LdELgUvZCtl14zNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJdanWQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48957C4CEF0;
	Fri, 29 Aug 2025 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756501322;
	bh=XfwR4hxOI5qyZEumBA82tqSDjfKDKjvzno3THU3PxVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJdanWQ4v/LTz7kGtaY0NVKodxj2fZoSNU9AHBk3mzTFd/RInf5TGcBHzPXs9hi/D
	 T6kaQOzIOPqAnUqfO/9cgdGvzYFKVTZxTJLj2m2qp6Jq1rnn/eqa0Y6lJNWXThNVkr
	 bVdIIvYfzV8BuCoNRuDGTOux59dK8vBLJtOJ+rpCfakbPZ87hPrfbcyCrchV+jS1h+
	 xlfw51z1l2VMZ7sRAZQmXwkB1d20pVHvOlRlij6/nRb4yG+mkPF6F0TDFAvMe02p5b
	 K318flCeTVtiHOO4G+qm8ZUH13XG8S9hJ5165jX6CbP60GhKw+3uLwO9fBLKVsh8f3
	 ThnA4aSR+Udow==
Date: Fri, 29 Aug 2025 14:01:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] x86: Prevent KASAN false positive warnings in
 __show_regs
Message-ID: <xlaeuraw7mupek3fp62o7ahp5viusp6uo36jadtuidpwwkmy6a@5pzmlcxtb2ro>
References: <20250829094744.3133324-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829094744.3133324-1-wutengda@huaweicloud.com>

On Fri, Aug 29, 2025 at 09:47:44AM +0000, Tengda Wu wrote:
>  static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
>  				  bool partial, const char *log_lvl)
>  {
> +	bool kasan_disabled = false;
> +
> +	/*
> +	 * When 'regs' resides in another task's stack space, KASAN should be
> +	 * disabled to prevent false positives during 'regs->' operation, as
> +	 * the 'regs' contents may change concurrently with task execution.
> +	 */
> +	if (!object_is_on_stack(regs)) {
> +		kasan_disable_current();
> +		kasan_disabled = true;
> +	}

I don't think this is right.  object_is_on_stack() only checks current's
*task* stack.  However the regs might be on a different stack used by
current (e.g., exception stack).  In which case there's no need to
disable KASAN.

What really determines the KASAN-safety is whether it's the current task
or not.

-- 
Josh

