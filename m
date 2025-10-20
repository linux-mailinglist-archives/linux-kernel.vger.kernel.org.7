Return-Path: <linux-kernel+bounces-860912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA671BF14D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D96A4F4BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6E23B60A;
	Mon, 20 Oct 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htf+Jfua"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA671624C0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964359; cv=none; b=iXOQRyz7iUYxL8BjZ03lfn0DUlOtefOm4mUx5oIRo83hQya2ihB7Px855qM8P2Wx+MFH/f+bjcK5rf6Yq/bPf+RZBorIZJbVbROizh2BkM5/J9qPn1vPn5OPSWiRosrh5JPSTFrhHM9P0zolAcWI/r15/UpuyuBy1CJCD0Wq8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964359; c=relaxed/simple;
	bh=pP3A5lVFp+TWJlDAr+FZUeR4ot4uHjyyYG0uyvoNEmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhe9dy+L28W5G4u++lx2oLd1DI6Asgn/QPxfn7IsyPhSBqzgRrs0vcByItp+3dlf5GSYiErMCaWUOOxbsXUmUEOV674DE4MKLAxnVsdV5MWla/sCh4taZUbLEPDkbHpy04aPtWID15NUpuwr77DBcCAcHpP5ASBOP/PAoaPHyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htf+Jfua; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760964357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8arYXBG+DW3SodLFxrTiKZROIPvWVTu4xbqeXb0NwI=;
	b=htf+JfuaQCtihPWdLM2F62dIw9LRfDkSkDL/HHwQ/llqmbhuG2h4OcKT0/tLKRoZCqKKii
	WxKjKCB8mA83PGfLyqmvnGqKqQPirPCY8Q8UY2bjL0KYygV+q5JpSkI8A8QtMKNVYWVSYd
	wha21teRc2k+6++zV66ixsIMoEjSGbg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-99UFG0SNNMKkuiGVBOuzhg-1; Mon, 20 Oct 2025 08:45:55 -0400
X-MC-Unique: 99UFG0SNNMKkuiGVBOuzhg-1
X-Mimecast-MFC-AGG-ID: 99UFG0SNNMKkuiGVBOuzhg_1760964354
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4283bf540ceso1071341f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964354; x=1761569154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8arYXBG+DW3SodLFxrTiKZROIPvWVTu4xbqeXb0NwI=;
        b=I6FbvpPeWk+nV6DJqxuphKZJL5Tk5HDc7FS5eHZ46VjddTSEvFm9SjDF794oEIkn3a
         1P2lhX364VDcGNkq5IF8E0gikj67NhXTr+u49E38GsCAlszIwxCIR6zi5Ba955dTqsqW
         FUo/uuyxKDfIosdoNDl0pmHnsXeLd0CIEbvBBCNtGiSlRZALUeekovQWgEI/nWftdT8N
         mXzK9Pqh9gSAxpHjQoLmIbmP+76z6BbdBPv/Q25H1lbuDJQJjyS0900yF2kvSS8XNOI6
         tRbvaDvFpz6yS1IwpHYZ/aBdQUmq810ONWnucpDH72Y+9d5rNeAElzMR0gk0EBoSE/jc
         Op4A==
X-Forwarded-Encrypted: i=1; AJvYcCWiKhLnzL7+NyfXPanSj8alM/0kR94iRJW9YldJ5sWtM70c3oaooyFOrlJYulCImLZ7+z28IeriNQGUaFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFkEOQY6MGksaXEhZ5dpDTYdqwBaF6jUgmFyyJEbSycWp9Atr
	wHMIJvu2Uu9irfaLAUlOC2vDo+819/+nhAAsxaOkjZf3ryacwoBlCn+BYXv1hmFdyoA9Fy+jDkk
	RSgFz2MEV/+mn8fhM7mFJ5/F1yjW4O8odVPOTNaRd+UiXEOQmuXmPUUoHNN4FLyf2gQ==
X-Gm-Gg: ASbGnctU9oKA1PuthEDHQPr+KQmT33vh2EqWdZdy80KAIjc26RCEMWz59+bDL5ZdWbb
	2Rv2PN3fQTvxMDifKbkcx3Kxrz/mBmwXU/mYAc9PmPHaf4W7LHQSjJ2thzdfJfiWUCPd6ish04F
	XuEl0WoIHU0WntRn6y+fcGbc2GqwlWpkNljSKB71rZTbdlZPC780GhkV/v4+5sHWbwJ9KihJ82N
	343x1eopjVaZLjFPB03DB80+M44ZUOOrXXc+Ae5yRHg0Cedii9hzlYaDub6xKXBuJyzfTjFNtqa
	LsnW5cCVFVmoJA5KAWhIroEzS5AFjot1rQpBUYmY5mVMIBqYhI5S6Fv5UnvvLsQO1mjpp+4mcmD
	AZ1jlBEVlLif8pUTkc2NPsMkTEu4EWw==
X-Received: by 2002:a05:6000:2c08:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4281dcb253emr5610046f8f.47.1760964354453;
        Mon, 20 Oct 2025 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9O5gCxZwTvWdqs5vD1NFCOQQ5mTNsM7VkdHL37Gjdb+1cITrv3BccUNrbtLnGONIEq4LZcA==
X-Received: by 2002:a05:6000:2c08:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4281dcb253emr5610016f8f.47.1760964353963;
        Mon, 20 Oct 2025 05:45:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm15201768f8f.31.2025.10.20.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:45:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:45:50 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] sched/debug: Add support to change sched_ext
 server params
Message-ID: <aPYu_obVO4QjbqUL@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-8-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> When a sched_ext server is loaded, tasks in CFS are converted to run in
> sched_ext class. Add support to modify the ext server parameters similar
> to how the fair server parameters are modified.
> 
> Re-use common code between ext and fair servers as needed.
> 
> [ arighi: Use dl_se->dl_server to determine if dl_se is a DL server, as
>           suggested by PeterZ. ]
> 
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---

...

> @@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		}
>  
>  		if (runtime > period ||
> -		    period > fair_server_period_max ||
> -		    period < fair_server_period_min) {
> +		    period > dl_server_period_max ||
> +		    period < dl_server_period_min) {
>  			return  -EINVAL;
>  		}
>  
> -		is_active = dl_server_active(&rq->fair_server);
> +		is_active = dl_server_active(dl_se);
>  		if (is_active) {
>  			update_rq_clock(rq);
> -			dl_server_stop(&rq->fair_server);
> +			dl_server_stop(dl_se);
>  		}
>  
> -		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> +		retval = dl_server_apply_params(dl_se, runtime, period, 0);
>  
>  		if (!runtime)
> -			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> -					cpu_of(rq));
> +			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
> +					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));

Guess this might get convoluted if are ever going to add an additional
dl-server, but I fail to see that happening atm (to service what?).

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


