Return-Path: <linux-kernel+bounces-885593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E5C3369C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DE518C5608
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE8C34A3D3;
	Tue,  4 Nov 2025 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu4XKH1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB534A3CB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299881; cv=none; b=rP6vivslEXrEBCFavxwu101MoTnEa58+AvTKeYtHYQL009nD5elqW88YTqdrmJV+fgbBrItEFD3C0LNXsEdjVuXEsCZ6bm68G0b3CC9kUs/MZ2gjLSu/8NKlwWAXvTMidifSTNNp36tal0gsYtcTRQnPKdFMTeybcSuXjtlMRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299881; c=relaxed/simple;
	bh=mt9CpBqiZ2YsTwoxGWnI6iL1tLMjGcbOOumWZxsd48w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kpjzHOE2s6GCRnGblKror7rtb+kkOByWPb+x6XXoa5109GFxKUxFqo3LBpGhnBq1jfpLlIraNE/k4YdSYuVh2yF8VAcU4bfdAEMDhntMxSbLSBqPCNJQbs3+WWFMN9b8pK7nVgRHVPthN1m24WccIWfz+JbhNtpnQcoFXYjFEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu4XKH1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D93C4CEF8;
	Tue,  4 Nov 2025 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762299881;
	bh=mt9CpBqiZ2YsTwoxGWnI6iL1tLMjGcbOOumWZxsd48w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pu4XKH1hyMs5p27s/mE7LiK3Yl/ox9Dru2veDFiMkYfHlF0nLitn03PwJ4T8Sc7jL
	 iW+W/DwxDpHFwklW8qcRcciyOijsI8o4D1skRs0trfNScv8grvNXuHE8oUKnlzC4SI
	 pwGGa0Yx9T4IL/Jd1xnntWqBaNm0CFX/TM1fdFz0EtiqHzi4AL27pLgovXURfDh0je
	 kl3/ku8LQmh77UFYhJWlIJPGtbb/BRBge9BtVhqX/25EV7u0t0r5b0qsx9fbGqVhn4
	 FM+/gNwaNPDp/zDUh6pm37BVTMKLW7beeJB/7BvOCv4gjDu5gbDhJ2jpeW5fT6NNHD
	 BXTb/ZmAu1Ewg==
Date: Wed, 5 Nov 2025 08:44:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/hung_task: unexport
 sysctl_hung_task_timeout_secs
Message-Id: <20251105084437.b601327ddbaf3ed149c9b2a5@kernel.org>
In-Reply-To: <20251104121920.2430568-1-hch@lst.de>
References: <20251104121920.2430568-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Nov 2025 07:19:20 -0500
Christoph Hellwig <hch@lst.de> wrote:

> This was added by the bcachefs pull requests despite various
> objections, and with bcachefs removed is now unused.
> 
> This reverts commit 5c3273ec3c6af356b29ff50a654f0dc33bf25a83.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/hung_task.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2c1f14b8129..1dfb9bc1bdef 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -50,7 +50,6 @@ static unsigned long __read_mostly sysctl_hung_task_detect_count;
>   * Zero means infinite timeout - no checking done:
>   */
>  unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
> -EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
>  
>  /*
>   * Zero (default value) means use sysctl_hung_task_timeout_secs:
> -- 
> 2.47.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

