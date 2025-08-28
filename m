Return-Path: <linux-kernel+bounces-790603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4633DB3AAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B41C81B88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95E1A0711;
	Thu, 28 Aug 2025 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miN/tGAf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686032566
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408580; cv=none; b=KcI3DFQYpXF3TUv8bojzQyVCH58eeeGuNL6lplPTkm6nbGslPRTGmt6AySJ8m67d4zA6idbVHBJ13NdvAQJ74xw9lvDefc2KkTs2ix9lmHffOf7WF9UAdOrSX6MJhTdQMr0GIAEYMTQO2xtaojWDEnJkqq0zFcyFrAmwFKj+iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408580; c=relaxed/simple;
	bh=RFlbKxpqNUg/DhIUE8ly4tWnPeQQjIXtov0RnXvyV8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4p5qV4r22QB6I2Y/J+ySTCjFEbexRAS3d8hk86BRyMt84Ap2q4n0JKKWN9sNQjRw3/FW0yQ9yNZItGzvDGSn337ywKFs4kyDEEPaWhb+n6hW+G+HWNgwOK5NNoDRgkAvivMQkwr8OFwxzS6mDdXdw1f8RwPyqwh2V4c5m2ecWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miN/tGAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A92EC4CEED;
	Thu, 28 Aug 2025 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756408580;
	bh=RFlbKxpqNUg/DhIUE8ly4tWnPeQQjIXtov0RnXvyV8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miN/tGAfAAlF+mZ4y2sm4sVPx0oeo4pMUOKJ+VkLlXNtxLS6WGF5+czBFqoFmDFCw
	 kesmPH5WkcukNfYg5EChIWzT07NJZpTRJR7Ke741DzSV87gHtzGZA/BZvnctsV1Ok1
	 LSuDCg6UUcSXnSpu3LOFUMbmPPpdx68KXp6aEGlpNEPpTLirTfaFWJeQHb+1qMVNNk
	 TnFXrq78HRFnMVMHuPjHZYYg7sr8oibwGBV5+I8LAWPk5/9W+d/oL63RvCw4TnY40H
	 K92XiTJl40ywks4Lz6FiVA9OBVqrWy25y0dI/aSgo80Skmv6nrMwtawsj8Jz9Vz6OC
	 r8tfZz2M0p0VQ==
Date: Thu, 28 Aug 2025 12:16:17 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
Message-ID: <r3gkmgetikfsuggva42qnfxzx3pdiy3vtl25fepfvvacvrzyjz@xmgcvxuquary>
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
 <1cd29a46-3c17-42ca-af41-ed0a645b29c3@gmail.com>
 <2956719f-58bf-40ac-9c63-6f9a8092ae1d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2956719f-58bf-40ac-9c63-6f9a8092ae1d@huaweicloud.com>

On Thu, Aug 28, 2025 at 08:06:17PM +0800, Tengda Wu wrote:
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -189,9 +189,15 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>         unsigned long visit_mask = 0;
>         int graph_idx = 0;
>         bool partial = false;
> +       bool kasan_disabled = false;
>  
>         printk("%sCall Trace:\n", log_lvl);
>  
> +       if (task != current) {
> +               kasan_disable_current();
> +               kasan_disabled = true;
> +       }

Looks reasonable to me, though note that some callers pass a NULL @task
to indicate 'current'.

(No idea why, that subtlety should probably be removed...)

So this might need to be

	if (task && task != current) {
		...

-- 
Josh

