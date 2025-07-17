Return-Path: <linux-kernel+bounces-735780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C19B093C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B97D5A1E09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD291F0992;
	Thu, 17 Jul 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx7eMiqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBA1925BC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776113; cv=none; b=PHxi75iyv9o5WVOHID3zO29OazVsPSFr92k/JdEh40Llv/f+r66itWL6cWoko/AXNy6n83fncFVOc6Pp0uZJFO1GfMSteWEGC37/VpusI9BKOY6fJyZ9uIbyJosoPYwNIFGlUPy+Ib4DMp9EwV3scOmqp4dDu9O0iX514oH+A7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776113; c=relaxed/simple;
	bh=FrKWuLhkYPHTMjJw+FGMDuPzUyky1UpUpTN9jBVWjIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGG1Pvt1jd4Jq3vZF3HmdhLzxIScxsXBLa1l2bkR7+pAQ1kKsNbTx/BslR152rxXeFC/vr95Ntsr8qTDbEF5BXJSBE/f2H8m/dFPUS2AXPu7CIRsefzhlLN/LflP9GaIcL0XColCFIrSPf+MdZlOn1GNZrv6aYBStkbkWdFLb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx7eMiqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72B6C4CEE3;
	Thu, 17 Jul 2025 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752776112;
	bh=FrKWuLhkYPHTMjJw+FGMDuPzUyky1UpUpTN9jBVWjIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fx7eMiqS1mb6RLljDY7ThcdbbQ6JhSKHXylBrhOx+gmLCdfcTBhKJBUdMEZKx9DxA
	 PNDbl28KuKO5HpaHrUgOaQWOuRwqllIoVPPKrGQECq8SEVQwlfN0+irKj++FfyUyQh
	 nITY+xSzg9pQqZfo6ZXj/yuPHd5U6+vtX/88sbQBrE+55QhEnA4IUr1ykYufG51F/1
	 sKp4R4jG+sMHXMUTa07tUWj3lri6+pGlKefXGNKU/nxxK8DX90xWaNRD9v1LHjMWiW
	 XRnns2Mxf8IsAs+hpyi6xrOTunz1y3W6M2fUV1jpdlND/KoWMKQWJnB6z1mqskjpju
	 OmHg8JxqKUucQ==
Date: Thu, 17 Jul 2025 08:15:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Use atomic_try_cmpxchg_relaxed() in
 tryinc_node_nr_active()
Message-ID: <aHk9sFNyvzHx6Qjs@slm.duckdns.org>
References: <20250709131923.93776-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709131923.93776-1-ubizjak@gmail.com>

On Wed, Jul 09, 2025 at 03:19:03PM +0200, Uros Bizjak wrote:
> Use try_cmpxchg() family of locking primitives instead of
> cmpxchg(*ptr, old, new) == old.
> 
> The x86 CMPXCHG instruction returns success in the ZF flag, so this
> change saves a compare after CMPXCHG (and related move instruction
> in front of CMPXCHG).
> 
> Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when
> CMPXCHG fails. There is no need to re-read the value in the loop.
> 
> The generated assembly improves from:
> 
>      3f7:	44 8b 0a             	mov    (%rdx),%r9d
>      3fa:	eb 12                	jmp    40e <...>
>      3fc:	8d 79 01             	lea    0x1(%rcx),%edi
>      3ff:	89 c8                	mov    %ecx,%eax
>      401:	f0 0f b1 7a 04       	lock cmpxchg %edi,0x4(%rdx)
>      406:	39 c1                	cmp    %eax,%ecx
>      408:	0f 84 83 00 00 00    	je     491 <...>
>      40e:	8b 4a 04             	mov    0x4(%rdx),%ecx
>      411:	41 39 c9             	cmp    %ecx,%r9d
>      414:	7f e6                	jg     3fc <...>
> 
> to:
> 
>     256b:	45 8b 08             	mov    (%r8),%r9d
>     256e:	41 8b 40 04          	mov    0x4(%r8),%eax
>     2572:	41 39 c1             	cmp    %eax,%r9d
>     2575:	7e 10                	jle    2587 <...>
>     2577:	8d 78 01             	lea    0x1(%rax),%edi
>     257a:	f0 41 0f b1 78 04    	lock cmpxchg %edi,0x4(%r8)
>     2580:	75 f0                	jne    2572 <...>
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-6.17.

Thanks.

-- 
tejun

