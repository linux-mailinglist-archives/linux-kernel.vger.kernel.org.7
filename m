Return-Path: <linux-kernel+bounces-748917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFB9B14794
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82EF7ADFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED9235046;
	Tue, 29 Jul 2025 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tvv5qHsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265B23313E;
	Tue, 29 Jul 2025 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766920; cv=none; b=XV+ykkW4rHyETU6YkvbVLy9xWRUHhVUiwMhtkJPmsy0pRZxriI6QWQ+dNak1SOwritQxkbqFGplmDOUKz/5uGZLyLBnJcsYjsgJ9nkCyaT8rk5f4xflx5ZmTEklJ9nMTaMAolzlowhnCR7duGl8WtYVvwlRCHrjIra2FYofHPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766920; c=relaxed/simple;
	bh=RgDWBuLQXDIfua6WFpM4jNdyD0EvjoZ+OJqExiNknj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctN0EbG62vb5ZLK0s6ZyWYwpa1SPym4HfejA5a212zTRqug6LJzX2IlB0hyP2ux9vEjZbVazZo2B/Gu04E0ZmZkaRkKJ8Qt3G0NgtvO8uyQFT1u3Gzbyh9ZZLckunWa+nRNnWvNtHwRznv7uDVQNFrx9pkre96BCSMvl5MvKICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tvv5qHsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E5C4CEFA;
	Tue, 29 Jul 2025 05:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753766919;
	bh=RgDWBuLQXDIfua6WFpM4jNdyD0EvjoZ+OJqExiNknj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tvv5qHsT/7DutttkOcdfb+kp4lO9frcjWZkku+iA/Gc8irK6qluNQM4AyzxAZidR2
	 jBC8dGD3Mb0F9pc1iBbesDVJj0o8+eJZ7bE5a9sM9MFveCOs5W0CyAK7v9VL0IzcOe
	 EV2TcrD+6u3olhRFSzULPxAPIWwN3r6esLq9dIBk=
Date: Tue, 29 Jul 2025 07:28:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de,
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
Message-ID: <2025072925-lint-agreement-77e8@gregkh>
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729042621.6403-1-suchitkarunakaran@gmail.com>

On Tue, Jul 29, 2025 at 09:56:21AM +0530, Suchit Karunakaran wrote:
> Fix a logic bug in early_init_intel() where a conditional range check:
> (c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE)
> was always false due to (PRESCOTT) being numerically greater than the
> upper bound (WILLAMETTE). This triggers:-Werror=logical-op: 
> logical ‘and’ of mutually exclusive tests is always false
> The fix corrects the constant ordering to ensure the range is valid:
> (c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL)
> 
> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> constant_tsc model checks")
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> Changes since v1:
> - Fix incorrect logic
> ---
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 076eaa41b8c8..6f5bd5dbc249 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	if (c->x86_power & (1 << 8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
>  		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  	}
> -- 
> 2.50.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

