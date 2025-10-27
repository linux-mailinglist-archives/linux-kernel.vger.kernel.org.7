Return-Path: <linux-kernel+bounces-871394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B5C0D1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4108119A4FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838862F6904;
	Mon, 27 Oct 2025 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qk0A740d"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0D2DE6F5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563774; cv=none; b=OC3GH1kDHwkBP+phi5nsb+Uq3LzpuS0loCqptlxEGoUvoVIW+hebRX2zgQkUYCbJ/c1kVaijGLhOWdWUqh1Vdgx7quhnom2IOLQCGRjsssR8TuxRqzCOQzcp4t96XcgsSoSNhNgTx7/WnMPZcG72TSAExgdv8W5VmLnGzsIPiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563774; c=relaxed/simple;
	bh=LB1x7BTh2A7aT4Ar9EAQILXWwWs6rqT8BpARa22vuVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDguCr2u25BK24DE/WEAYQVO2rLyn9psPavrsgPkDAfbaLQHiBr9fPQOzMwv0Hh5tJJAh8frbuMPZD5oylX+N38qZOjoC5i+R1uVqyP4rOh400FUFkuGGv4abl9DGN37hfPnA3+2ENAyzFdm38SdZJMAqQOs/ldCQRK1OUzyo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qk0A740d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2052889b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761563771; x=1762168571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EuCROQjNcUGO3SGHRGo+0eYSMk802EES6aqkHgOAUk=;
        b=Qk0A740dMrAPcVxGJR1GpLsbSoyJKWbUJW4QTm73OTNwYuY3E5jg1Mtbnv/tJg+Ocz
         Df1uYg61S7JyeBBBZq13Xay/6TJ/CX/ijBvo3bMYl8NO1iVhxk6n3s9dBQefj0ZGDEX8
         AzEZF7pjsDKE+BWPMCunguKP6480PEDlK0u7YF96kkhb0VNYXTbBAaf2usSDdjWqGth9
         yXZpSbykAwCx+2c0C82ubvCB5vcuINzI5nYQ37b8rbd5Y9PFSfYUnojCfz6xfcmKzc4q
         AP1ETI/WmHkgd0GiOhU0YrrtD0JS5O3p4sucM+5+Jn2YUFEe+RmTS/Ye6Tz5IGReVVL3
         oItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761563771; x=1762168571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EuCROQjNcUGO3SGHRGo+0eYSMk802EES6aqkHgOAUk=;
        b=gC9Ii30Ww10rnPWr+bn+62DfRlAlUH61biaKY3juJGg3NKHdTABBITn56Mr6PO94Z8
         is9O22Lyie+zpqqDe4/0+0KP0nT7pKVdqM/NPTk3KXwezBc970nanvO48evJw1jZoj71
         lkS1prCUD0lEnup67zvRhfiSRimK4xgCdr/Fp/HTvfvQ0xcwV3Lc/1Z7LO5Q8ZhKNYfY
         ofe7XZd2tI8/y08L9PA04tySKq+bfH12b4gxSkxVBNnl/z8UE/ty/Wk6928imUmupuhh
         rosOUBJY+65TGaRBBSJjJ4xzYHNFCk/MyKAt5aFGR1KY6sOp9W/TURERqeqx+9l+ZJsN
         9scA==
X-Forwarded-Encrypted: i=1; AJvYcCXqyFeYgoSzdrxZ2IEgVt8LUYVO6wjpRZjtEXSoVfnPbn2BK9Sgnz9M1F9/QS6M2s1IjjFdwbwpMtyIBBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkausD+n4plvx9BzFLXLOpl0hgi2ACWel+Hhs0zhXghRAvcBP+
	jACiIDJFEZUdHaTEdXYl01cF6AiIBr/ZayYQlAtPXsjGZpq+//6S/TO0RjX9zm3rlw==
X-Gm-Gg: ASbGncua4OiAtGvl7+1lOdU51rrGDthBNo2sD+OPTcXvrj4trlGuPUhisP0DrJcZubQ
	2YjW9vCfrBQg3hhPFv6KSSWPpuEbeHs2pk76+7EYrKxvtt2klyY0cKT0Xnh+b32bLgSoQ2AygxC
	TmWTzRV6jx6tIhKEvnQ1OFjYT5Uq9DSx9DrHH8Lp2fmOCfdVgkLIqRKqPuDZ+sohlyvURz83Zn0
	DHzM9pSGF4V0RC+A9Un+h8rnBIG4du3f6tGK9cdpQoK3XkBHqDSvcClPyse1o1L36niH+ui2QIZ
	S02CYAEoXsjCj+Ih32nhgjk38yhhcPHIBzOCjTDgovitiHMqKoDxM1kUAfWD6mnD0wcJgFZRS2W
	Ju5PpDBGWDqvBiTledHqV/lDchGvn9H5sgdIc+Ky+k4QCCYg/d1wAuShXPk1JQU6bgD3R9il0BW
	MVCDAiNnJ/7Q1ZAeNlpLZMg+HNkvj2nXo=
X-Google-Smtp-Source: AGHT+IHjcNKIqHx7XlVV4F+FWNuGokV68s61fjE1WVvhohLMYjdAGDU/gdAXYEut+xcuQ4GTYWJd+g==
X-Received: by 2002:a05:6a21:32aa:b0:340:e7d3:2f40 with SMTP id adf61e73a8af0-340e7e272bbmr11991133637.25.1761563771317;
        Mon, 27 Oct 2025 04:16:11 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d2869sm8127511a91.7.2025.10.27.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:16:10 -0700 (PDT)
Date: Mon, 27 Oct 2025 19:15:52 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sched/fair: Remove dead code which might prevent
 from building
Message-ID: <20251027111552.GA33@bytedance>
References: <20251027100529.1806944-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027100529.1806944-1-andriy.shevchenko@linux.intel.com>

On Mon, Oct 27, 2025 at 11:05:29AM +0100, Andy Shevchenko wrote:
> Clang, in particular, is not happy about dead code:
> 
> kernel/sched/fair.c:5233:19: error: unused function 'cfs_rq_throttled' [-Werror,-Wunused-function]
>  5233 | static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
>       |                   ^~~~~~~~~~~~~~~~
> 1 error generated.
> 
> kernel/sched/fair.c:6736:19: error: unused function 'cfs_rq_throttled' [-Werror,-Wunused-function]
>  6736 | static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>       |                   ^~~~~~~~~~~~~~~~
> 1 error generated.
> 
> Remove a leftover from the previous cleanup.
> 
> Fixes: fe8d238e646e ("sched/fair: Propagate load for throttled cfs_rq")
> Fixes: eb962f251fbb ("sched/fair: Task based throttle time accounting")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>

Thanks.

