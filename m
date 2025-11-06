Return-Path: <linux-kernel+bounces-889055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6063C3C9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550843AB49F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ADB2C237E;
	Thu,  6 Nov 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPAldE4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0E19D07E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447699; cv=none; b=Se0kK/k8yOvz/U5iaKeUFqJE8YoCjcq68xAI9mdbOmgRSg+0nxlPL3EgtMf49toSa9leD2F7yuus4I8/j4/ZEq9mpv2uqGvG3QmrJD88THTJo2BHEKGCmZ59buVmrxlg+SDqm99ysu38qp7B+X0zYlF6Up9U38U6L/1kr9uQj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447699; c=relaxed/simple;
	bh=C5wiFf0HtzjNwELAgnIcKzS2SjngF5LO34y+NigSrww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W03OudJwvVsn6pnnciWHZ8hZVaoPJzeukv7YcrfG4DOTA82xUBz4ZnMFZFQT519urOg1I7iH9j9+R5CvWrtqp7RfEWjc/+t4PQVx4jdeoXcdAf3DeDZOmHNRwp3UULZol398C7XSDUao8n498dvzNnQFilgpVeHozk9KeOCXPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPAldE4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC5AC16AAE;
	Thu,  6 Nov 2025 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447699;
	bh=C5wiFf0HtzjNwELAgnIcKzS2SjngF5LO34y+NigSrww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPAldE4Hi3LS6gkbwLjpFilfSJwWbAwjhaM2cdjdUbsy/R10VpiECYSdy2UCAr8A/
	 2sEkllP8ZshVididPe4K/fi8ryYZlkyKFtczyH81Z3NwP2NKW3oV+NCOyadqpECMmK
	 5BZBAqOls43gp9jFSH/f/q9nJV/WlghIQdLhR/uQjR9Gs4wMk7XqP9+Wa8e/rZawoH
	 eAjacCD9Jai5uhg8rS4FGU32YHHsPY2eKfx4ugYYMH3QF6RViRaleGCnJCQqWd9Jid
	 rL+2ggNqcjVto5yqq7KlXSYo7gv1TCd9r2ImAuqyP850YpGjS/ZKwUr0e6J/pWv8HQ
	 3lY4pYJY9rBxQ==
Date: Thu, 6 Nov 2025 16:48:14 +0000
From: Lee Jones <lee@kernel.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 06/21] mfd: prepare to generalize BITS() macro
Message-ID: <20251106164814.GA1949330@google.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
 <20251025162858.305236-7-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251025162858.305236-7-yury.norov@gmail.com>

On Sat, 25 Oct 2025, Yury Norov (NVIDIA) wrote:

> In preparation for adding generic BITS() macro, add an #undef directive
> for the existing BITS(). The following patches will drop it entirely.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/mfd/db8500-prcmu-regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/db8500-prcmu-regs.h b/drivers/mfd/db8500-prcmu-regs.h
> index 75fd1069372c..25d2d5966211 100644
> --- a/drivers/mfd/db8500-prcmu-regs.h
> +++ b/drivers/mfd/db8500-prcmu-regs.h
> @@ -12,6 +12,7 @@
>  #ifndef __DB8500_PRCMU_REGS_H
>  #define __DB8500_PRCMU_REGS_H
>  
> +#undef BITS

Doesn't this get removed in 2 patches time?

>  #define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))
>  
>  #define PRCM_ACLK_MGT		(0x004)
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

