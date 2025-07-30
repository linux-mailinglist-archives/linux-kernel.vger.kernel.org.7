Return-Path: <linux-kernel+bounces-750934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC091B162FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD544E4864
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73A2DA779;
	Wed, 30 Jul 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uTLS6uK1"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7A2D97BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886602; cv=none; b=i1dUeYo9SV9f++YmLAP/jDbOwPGLmd9eEHw0aT2FKMGPmuFlsbuaAXSZJTTLD1EpvwyrttI6w8G6ck7t04GiFMNO2NCrcUFtqTWmNLUKhxZNEvKOq3I4NvDHLNjNT07XZ01gONnpRngSsb1FzYsG9m4cmCcETSHlDJZG+yt/5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886602; c=relaxed/simple;
	bh=CKq9v+K3YjQmz4Jl+QChnxzzZaK4ptBAPhWt3hwDMxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2K8ZYj2+54w00YcisUFYx0lzGWvRKzaRYd1XHJKIPBEu27KfsktWs5K15HhOzum16is0OMEPMkeWS/9Su+mGR2QfDgHn/7cqAJZSvhcI4C0J3GxkF8nftcV/3Jz3+95WDahiQr8/Dt44aylcPtL975apgVSStaYaazyRjhckEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uTLS6uK1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e576b29-8376-450d-a5e8-17fb29aa7621@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753886597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcB/cYn5pM69bB19DiN7NiEmXNzak6AQX6L+z3RvaMM=;
	b=uTLS6uK19a5LZ4seHHVrvRyQMClb/SEKimMi3fJTNZ6P70trk5n0xtD9rv3L4hTkaMISq2
	KZ8X5ROFCowylGQLoQVNDv092OKbeyLHlGqEF8SxJU+p9nJnYPqWhU447fawNZsmCOmf9O
	Qo6XzTsBrfvJEikaFrO+byxp5LzRSIw=
Date: Wed, 30 Jul 2025 22:42:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add Masami as a reviewer of hung task
 detector
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lance Yang <ioworker0@gmail.com>
References: <175388550841.627474.3260499035226455392.stgit@devnote2>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <175388550841.627474.3260499035226455392.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Welcome to the party ;p

On 2025/7/30 22:25, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since I'm actively working on hung task blocker detector,
> add myself to a reviewer of the HUNG TASK DETECTOR feature.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Lance Yang <lance.yang@linux.dev>

> ---
>   MAINTAINERS |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0b444e5fd5a..e76fa00b0c3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11290,6 +11290,7 @@ F:	drivers/tty/hvc/
>   HUNG TASK DETECTOR
>   M:	Andrew Morton <akpm@linux-foundation.org>
>   R:	Lance Yang <lance.yang@linux.dev>
> +R:	Masami Hiramatsu <mhiramat@kernel.org>
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	include/linux/hung_task.h
> 

