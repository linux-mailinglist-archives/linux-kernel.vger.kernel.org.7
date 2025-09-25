Return-Path: <linux-kernel+bounces-832847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E4BA08FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DF31B22B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054C2DEA9D;
	Thu, 25 Sep 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="thMDMZAR"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA129BD85
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816915; cv=none; b=VQEmU/cgBqQtgR7WhCCfKlwJa9xlTqztAWpzB2R58LgjaNUMv9OmQvDnFQZXLHxpgiSBXlkFjQaMPm2hRbybgjtJWXKqbvuMo44ebdLD/blRfypKL+q6sWq+l4aylaIXqdnsXJpFX1/DrMAl87xbJSINIUJB0jPlTpvSDyEDBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816915; c=relaxed/simple;
	bh=AFNz/mj7GGkk5XJKLp7PMXOuW1I1Iq5ldz2/NMHusU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msxSewFGXgVDZDGPvLbC1yjSQ28m3+2KD1Ieul02TuOPFJnWowQnNklw7IpxkSR9z1AqmnQD9MERKMuiKI1rmLJD2zqt7qFu24HQ+PrhixEw6UhC4MTkXrlYSpWzZKMIDhwQluC1RS9YJdWHcbLzA2pKWjx1QvosJriAbTlaVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=thMDMZAR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758816911;
	bh=AFNz/mj7GGkk5XJKLp7PMXOuW1I1Iq5ldz2/NMHusU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thMDMZARHTIwlV7YfodJNzfCtggYq1/0rjfrdNIln88MY+S4pTdal1JSYrMJKL6ua
	 221MpH224Ol7/ZWDkQwb9VrqaxZ+HAfow00Oh8/+QQ9oFCDa1rM3+d896zf8DzkelN
	 xykTGe+L1poUXjLz1CNVqtDhBQ+VVUtZA4qgSE9k=
Date: Thu, 25 Sep 2025 18:15:07 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, 
	Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-dev@igalia.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Message-ID: <7e8b9f3d-3888-491f-95ad-954fcf48dd00@t-8ch.de>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
 <20250925141423.504427-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925141423.504427-1-andrealmeid@igalia.com>

On 2025-09-25 11:14:23-0300, André Almeida wrote:
> Add stdbool.h to the list of nolibc.h includes, otherwise tests compiled
> with -nostdlib will fail with "error: unknown type name 'bool'", even if
> a nolibc stdbool implementation is available at tools/include/nolibc/.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk/
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

As mentioned in the other subthread I'm fine with this.
How urgent is this fix? Can it wait until my regular PR for -rc1?
If not, who is going to send it to Linus?

If someone else sends it:
Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/nolibc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> index c199ade200c2..d2f5aa085f8e 100644
> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -116,6 +116,7 @@
>  #include "sched.h"
>  #include "signal.h"
>  #include "unistd.h"
> +#include "stdbool.h"
>  #include "stdio.h"
>  #include "stdlib.h"
>  #include "string.h"
> -- 
> 2.51.0
> 

