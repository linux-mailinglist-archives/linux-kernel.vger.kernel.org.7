Return-Path: <linux-kernel+bounces-855311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CBBE0D81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5163BA225
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6D3016E7;
	Wed, 15 Oct 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIxKAGXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0702FFDC8;
	Wed, 15 Oct 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564479; cv=none; b=UkMCk6kBJtpiepmbtg+4kzJ0PHNUp3tbm/6NRV4AWQi0cCx7olQU2Jlni7Z29DyoTn7k0OXt/sWn20K4j4r4S1mowDC/5YHhY4OCena5Hwi+1+zY1vIHsJfYeajgog6V7xFi4wIxDgi5plgfpLq3yKTo/1nIJbbR+dJ8YrKe1cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564479; c=relaxed/simple;
	bh=/kakUbYI7dN0tnUfmWgLfsQwT8GNByC3o3xabzSqMxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrdypfcDVCE29Cbnk1Iw7aqhVBWjt/A7LPSTWONPl8A7MbvW4CmUvq5Qn0kbPDRiylldH132uKlAxMenXvIz6I2mo7P3MXxUuAN6F40XPWXgI/upKZFLKnImEtab6E7ISADIk1sbjIqYq2Tce3vFO8ocg6auLJ57KFxdMXYCL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIxKAGXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E871AC4CEF8;
	Wed, 15 Oct 2025 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760564479;
	bh=/kakUbYI7dN0tnUfmWgLfsQwT8GNByC3o3xabzSqMxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIxKAGXqYdVYGVq2gq/sq2TFmx3egzDqC+3ItQdleLYD8v9tKIkJFay4mfAHhkzG4
	 k2n46tqRxoUar02QEiE1oF8W6XMfKR4WXITqvSGQpLeGoxsgXpyaQksj1kh0ZTEMsd
	 5Qva1s1BpUqMKesFmeau9rYsT5DP2xWSABpWK/kZB0v5Oa2jnfchXLBEi3iHZLl2jd
	 hcndZk40FNFk9EoY/kWi9/xiaNOfCzFNTAY0UfDGfEC0Yhfn9mcOIN3R/JD9oBSPXS
	 QxMOzdS4hb8qLogULQKYh+RvxQvltAkrT9759eLaWSYIH6nnHvnL8dJk3Ei9V9GENp
	 udes3vIjvqDWQ==
Date: Wed, 15 Oct 2025 14:41:18 -0700
From: Kees Cook <kees@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Balbir Singh <sblbir@amazon.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: clarify PR_SPEC_L1D_FLUSH
Message-ID: <202510151438.DA62BB421@keescook>
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
 <20251015-l1d-flush-doc-v1-1-f8cefea3f2f2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-l1d-flush-doc-v1-1-f8cefea3f2f2@google.com>

On Wed, Oct 15, 2025 at 05:02:05PM +0000, Brendan Jackman wrote:
> For PR_SPEC_STORE_BYPASS and PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE
> means "disable the speculation bug" i.e. "enable the mitigation".
> 
> For PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE means "disable the mitigation".
> This is not obvious, so document it.

The only thing I can find in Debian Code Search that actually uses
PR_SPEC_L1D_FLUSH is stress-ng, and it literally just toggles it before
restoring it:
https://sources.debian.org/src/stress-ng/0.19.05-1/stress-prctl.c?hl=893#L893

I wonder if we should just fix the prctl to match the existing
behaviors?

-Kees

> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/userspace-api/spec_ctrl.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
> index 5e8ed9eef9aa84f12fa255af7b15c163ff01aab8..ca89151fc0a8e7205e0a0062134d63b213b9ef11 100644
> --- a/Documentation/userspace-api/spec_ctrl.rst
> +++ b/Documentation/userspace-api/spec_ctrl.rst
> @@ -26,7 +26,8 @@ PR_GET_SPECULATION_CTRL
>  
>  PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
>  which is selected with arg2 of prctl(2). The return value uses bits 0-3 with
> -the following meaning:
> +the following meaning (with the caveat that PR_SPEC_L1D_FLUSH has less obvious
> +semantics, see documentation for that specific control below):
>  
>  ==== ====================== ==================================================
>  Bit  Define                 Description
> @@ -110,6 +111,9 @@ Speculation misfeature controls
>  - PR_SPEC_L1D_FLUSH: Flush L1D Cache on context switch out of the task
>                          (works only when tasks run on non SMT cores)
>  
> +For this control, PR_SPEC_ENABLE means that the **mitigation** is enabled (L1D
> +is flushed), PR_SPEC_DISABLE means it is disabled.
> +
>    Invocations:
>     * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
>     * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_ENABLE, 0, 0);
> 
> -- 
> 2.50.1
> 

-- 
Kees Cook

