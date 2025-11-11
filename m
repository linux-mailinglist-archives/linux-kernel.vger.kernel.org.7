Return-Path: <linux-kernel+bounces-895689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E37C4EACD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81CB84FA0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBDE3112C1;
	Tue, 11 Nov 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvgC//gc"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D228FFF6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873071; cv=none; b=HsAtipmzIL3xqdR6vaEyJL6YeWXzZ2a24vFq0JiXrgaTcK5vE1AQhd5BGUgUBqoV/Iu+M8o6sKbPf4vDu1X4OevzezefLEmMs3xqODJ/lxteACOg9rD/ikBOwlpzJlM4ao12ASKGI9LSHfuXYZvX3YtJlR6UJ1j5x12MH1DLCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873071; c=relaxed/simple;
	bh=zIAJYvFlnqjwTCcDLrwYuCJuNplcR5iWuYDi6bUO91g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbkmsEOxkdthFpzQNK1ILajf/xq0FTfLmA6Yu/OHfpJIvGEBKqaZL5rnnJNEwx8WN0tL4ZUFA1pqOgL4dPGrqVzE5ZXldRHgI6pliC7/XHgWZd2xIg7P0tQevTKBzhcDWDfEbq/YJ5xzJ4Ja/EqoVFZ73aoOv7URY/A7synzVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvgC//gc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87c13813464so55064286d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762873069; x=1763477869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnKzJRxUMQswCpgDbIGddFJBw4T/v1HmQefMzOICXxw=;
        b=hvgC//gcMYgfwyKIKyazLU2Ju7iQ3gyiwwnv/HhMkFq4X4FfJ+VCIm3Rcof/3JNxB/
         vWIl0ZR2ApsAeP4q+nDJJT60tOSq/4+YyM3Yp3pkKz5CL3IDRh4Q78P8a7RwV4fc7yXX
         Az/FFS22539TqdhWuJT3ks9CrtIukE2XcGO4mvqjixm2Cjw7XOfTjE0p84P6+IsVhVGc
         A1/dbW6vU/sjBcptyCF4v4GwzIODDLObD6Wk0/TtNyyj2izScbQHlJCCFz4Tyog/xqJd
         TXyOalm2Xnok3PstbwsF0P39KQ8MyTeRAeciFlyPerPpYxOl4Ps1MlTBqx5u11J9E7Ed
         5Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873069; x=1763477869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnKzJRxUMQswCpgDbIGddFJBw4T/v1HmQefMzOICXxw=;
        b=rD7hw66Jc04GYwR/1gR7YJ9L4QOg8Ng99T9cLY2BXuo+mUNaEQHMEJMTz4PGylHwom
         keGoi+2RmkU+EnbvFFwdznYn5N5VeASSZKEW/BbZD+hQLPSoDnn0lJgZo3Ks9X9Z3c+Z
         oo5nj4icH3SXBJPXK0zXVVnmhliBqEN3QDMnltWEk77594lZ+S4F4hEiKeZyGKcA3p86
         9aoDzSLDlvGoY0IL2lnKtSiIqGepnhvszpJvszR5TBqwfM+si1yK3dhGzxq3JpYhHJvV
         zXZkxp+ibJD0fPjXCpuWoNFtOoAkVXIX/3Fba2Y3WSDXcj5trl8xKFKvbEaQBPJW2mdK
         QubA==
X-Forwarded-Encrypted: i=1; AJvYcCX9qYkvsSOCZZi20r+vU+gv7vL4lLpvLQjp/SymMLIJbh5mdsWm1GsXhzgP7W0kxhVIFVVssbVXVkFn/CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZTDqMz5suaTTuq3tFPuQhBbqAH0fVJTiEQdSL4IUuGpI9HHb
	eOoRYEi/QCdYw1VFUsYgc+3fSYTzghftGhOfHmnUmxAXOkblQNgUGqzuSlL7gw==
X-Gm-Gg: ASbGnct4Z2aw+C7v7re29koZrhd7zwT0r6RnRnHuJSdLVcuzEUUqc0mOeyAQx4n2Lab
	O30ocmtMlCokUudb4IjiPHsFDGjF0OjSW8RgjMdmmlXe/UyvmdzQVlhLZsyL804tFg3nKdmiEOE
	jSYq9seLBcQelLATcEOZCBTLJt2571m0bH4qv9T/A6cp+pvswrm2/qoUl6UpzEODuGmxs2gAhYB
	EM8CZajce0mWNA/Ygp9PJiAgJUl+oLdvalM65o444+DH3lnM/pyyq1h3pqMzBM2IxrQKqZeClpo
	I0nVE2++RFpRx1zNrv2dWROMHiiMIvcJpTb0mG/aPoK7KtJ5N+G4nrGSGRXw8o7LHl45ihGmPqy
	7luyY8wrkAwkRqKDYc3Gr9zxHVMnOpbIGwvwgyCv/3/Ywy11yS467hKCT6OiMCh6bmD2rLDQ8v2
	iAiiZe0hevePd8ZfVGzRMXimHo
X-Google-Smtp-Source: AGHT+IElMIyji7uPUvw6aoJovAxjkcTZAsKXd19Q2rmtiC7uMfNHOttDD/l5SXanUGpE43v9DnBlxw==
X-Received: by 2002:ad4:5be7:0:b0:880:545b:ab7b with SMTP id 6a1803df08f44-882385cffefmr194862386d6.4.1762873068873;
        Tue, 11 Nov 2025 06:57:48 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b742f0sm72171676d6.43.2025.11.11.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:57:48 -0800 (PST)
Date: Tue, 11 Nov 2025 09:57:46 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRNO6j5B4RDugKfJ@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-3-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:01AM -1000, Tejun Heo wrote:
> @@ -919,7 +948,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
>  
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  {
> -	p->scx.slice = SCX_SLICE_DFL;
> +	p->scx.slice = scx_slice_dfl;

Do you need to use READ_ONCE here given that this can be modified concurrently?

>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> @@ -2892,7 +2921,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
>  	INIT_LIST_HEAD(&scx->runnable_node);
>  	scx->runnable_at = jiffies;
>  	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
> -	scx->slice = SCX_SLICE_DFL;
> +	scx->slice = scx_slice_dfl;
>  }
>  
>  void scx_pre_fork(struct task_struct *p)
> @@ -3770,6 +3799,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth <= 0);
>  		if (scx_bypass_depth != 1)
>  			goto unlock;
> +		scx_slice_dfl = scx_slice_bypass_us * NSEC_PER_USEC;

Similarly WRITE_ONCE here

>  		bypass_timestamp = ktime_get_ns();
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> @@ -3778,6 +3808,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth < 0);
>  		if (scx_bypass_depth != 0)
>  			goto unlock;
> +		scx_slice_dfl = scx_slice_dfl_us * NSEC_PER_USEC;

And here

>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
>  				      ktime_get_ns() - bypass_timestamp);
> @@ -4776,7 +4807,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			queue_flags |= DEQUEUE_CLASS;
>  
>  		scoped_guard (sched_change, p, queue_flags) {
> -			p->scx.slice = SCX_SLICE_DFL;
> +			p->scx.slice = scx_slice_dfl;

And here
>  			p->sched_class = new_class;
>  		}
>  	}
> -- 
> 2.51.1
> 

