Return-Path: <linux-kernel+bounces-898650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53DC55A80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6983B6B10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E562C327C;
	Thu, 13 Nov 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl+5ZE8s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922F279DAD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008446; cv=none; b=ZxdreSdXC2kd7kcJRvpet7aSdXRy37NOLC3M0tuh9aRtZhwhAjd0qCqrH4PoSKiiUeJtTjxRA5xSR9ujX2O3z6Lcv9MqMMo7HVZJAxeM96CU2qH/paNZycJ+Qp3yxj38W2/JGTS7x2/wqjyI+kwvMFUqVAq7FL6TOwF96Nn3Ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008446; c=relaxed/simple;
	bh=xjyuAAPDocq+pcIMgJPYGtD+7FFq1Kw4NmzC0x4omiU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MULA/qGVpQCk9kDv/lFuY6Q9/Dg+0kzcdiXEoaGgMbq0Kyz2n3RS2eJrWYgqRFOMboL70PUOZsvVVq2+yy8gQEc9SkmuIo1sqHwi+jUDTIm92lDUl/RmxwveANY7miRemViOLi93R2t05HkznfU8yYUHXkxXELRCu1jg6/HqkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl+5ZE8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B6CC4CEF1;
	Thu, 13 Nov 2025 04:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763008446;
	bh=xjyuAAPDocq+pcIMgJPYGtD+7FFq1Kw4NmzC0x4omiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dl+5ZE8s54+WHTwow/GK+kcMRaEBwrSjov4DLNKxDGWpvU/5o3AgVOdRni3b8MKqs
	 clraPd4U/ENbc3uRwLNq4BxFdQCo+aM48L98ZJKaidvOa8aK38v1YfjplnUKUUJsCQ
	 YZlGGJMu4eY7Cjy2EnAFJM6POEGLvBL3YFp5ZMgv3qyZdNzU8JSEflkKZCJcE1rb1T
	 fPUC1S4tN4Uzjqj6jZK3ogtfR72tNEJILdIbpCFfDVgXoDM5sVpSRDy7KItHZsLxcY
	 8VuZfQ3jVZXnf2OTf+8pEaOGdhyXj13cMia1CSSBZkAa1UmbsJCa7UgNgdifuWT3om
	 DixDj+fW+b3xQ==
Date: Thu, 13 Nov 2025 13:34:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 paulmck@kernel.org, mhiramat@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: arm64: pseudo NMI bootconfig question
Message-Id: <20251113133403.308046d2df1c97ba7dcd2388@kernel.org>
In-Reply-To: <rs4igmsjrm6r2aio4nbe5jos3vcqk2u4bjhltjwtj2pn3cquip@kv3grgec7qrb>
References: <rs4igmsjrm6r2aio4nbe5jos3vcqk2u4bjhltjwtj2pn3cquip@kv3grgec7qrb>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Nov 2025 06:05:43 -0800
Breno Leitao <leitao@debian.org> wrote:

> Hello,
> 
> In most major Linux distributions, it’s common to have a separate debug kernel
> build. This variant is compiled with additional debug configuration options to
> provide deeper observability and easier debugging, typically at the expense of
> some performance.
> 
> This approach is also used in several companies, including mine. The debug
> flavor is usually a drop-in replacement deployed when investigating
> issues, allowing quicker identification before more detailed manual
> debugging.
> 
> I’m currently debugging some hung tasks using the debug kernel flavor and
> noticed that backtraces weren’t printed correctly because PSEUDO NMI isn’t
> enabled.
> 
> AFAIK, to enable PSEUDO NMI on ARM, the following are required:
> 
>  cmdline: irqchip.gicv3_pseudo_nmi=1
>  config: CONFIG_ARM64_PSEUDO_NMI=y
> 
> I wanted to have pseudo NMI enabled by default in the debug kernel
> (without relying on kernel command-line parameters), but this isn’t
> possible today. The reason is that `irqchip.gicv3_pseudo_nmi` is an early
> parameter, which can’t be set through bootconfig, so, independent of my
> .config, I need to hack cmdline arguments to have the debuggability
> I need.

Yeah, that parameter is for early architecture initialization,
which is done before parsing bootconfig.

Can you try building kernel with:

(arm)
CONFIG_CMDLINE="irqchip.gicv3_pseudo_nmi=1"
CONFIG_CMDLINE_EXTEND=y

(arm64)
cmdline=$(cat /proc/cmdline)
CONFIG_CMDLINE="irqchip.gicv3_pseudo_nmi=1 ${cmdline}"
CMDLINE_FORCE=y

BTW I wonder why you can not configure your bootloader to pass it.

Thank you,

> 
> Question:
> 
> Would it make sense to provide an option to enable pseudo NMI in certain
> kernel configuration without requiring an extra command-line parameter?

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

