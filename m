Return-Path: <linux-kernel+bounces-750830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175E1B16187
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1EB7A1ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68852BD582;
	Wed, 30 Jul 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ovrrohda"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A2BCF46
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882134; cv=none; b=JVPgX8xlVxcnL88lpuWAtkks1n2DUo21R0TfHlboFIgDV0su1PPMq/qFcD3XC7/IoXGdpn2hqy7GuHEROKjUBpEenGPtLNB34GKbjVfUMR0XKs+j9eXs+ty/s5XpZ9BSPPsfDUX31OIWF19HbxlnuvCuzLsP/Olyw3BuEMFM4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882134; c=relaxed/simple;
	bh=dAals4fLIuaDxR/uGo8xANiu+7z+8G2TG1DKclDcvaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLD8iiK16NNOrjspQMpXCEh+h/klhzudLEDhVOWbyoCMAhOYnrNxxmQBoLF9G0h57rn95bBkKJ7WfJ4jU63m3mJIds/ojJii32PnPTSqBn6erM7RmYNDQ9Td1tJ0hHWEvSHB7L7KzsAf/4RC/SarZC5J5JtpjuJiQKpR+jNKIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ovrrohda; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3137c20213cso7222275a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753882132; x=1754486932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N05ndHBiA6vOIEj7aQ8bvNMbMz+3xRwLIOrAmrvIF2g=;
        b=Ovrrohdae1BuEKRBksGnrP1bDAKKEQSqYWM09dD0XAg3FFRo0lNe1yUYY2gNrSRtlW
         Tm74GHxID15GgcMy4v1AXkNjGD6Rnn9u8uzn/qEcxVXYTJNni0/nBFqssqaRpVZYooVP
         z1DGmZIj/f8W9R64GipwgIFjiisWErS4BKHVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882132; x=1754486932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N05ndHBiA6vOIEj7aQ8bvNMbMz+3xRwLIOrAmrvIF2g=;
        b=ac5rN2vla54dJokbfts6Xg3ALxARBBeYsuVKNjVuVEkNydi3bvnRnGHR5o6ebo/0ry
         Xn0cy3pVxSpowcusDUzU09y0iHjfKaLBxDjpuerb1pREIqxSN3RWT697LRYeu4/VP9fc
         3LF4cnvqGCfPkSE+UhIHzv9PIyVLhFOuWMcf1ibsLyd6h9YWbjv6x4UPAiyovshCt+Eg
         YVyKDIWQ3TIHcEhnFlQWx/+HjUbHM0T+FtD99YzChmzRHqIwKITaIlScr249v96amEEA
         LqOq+sn9scBD+w1vg4wCQ5oDRdvnFMEwNzCfNGjWz3wuMCQQsXXIicmrJBHB9OG7uyct
         /kfw==
X-Forwarded-Encrypted: i=1; AJvYcCVC8A1MF1Rza+YkfxsY5tFls7szZEPcWy8FhVwhn4YBcQfZNf26jL88f4pKqSIxE3evnVs0TPbFGDJpX30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWh7ZkerU/fH++/h6ElZxxnkLkaayh1zaD46jr+h9jGMsxq0/
	rm8TZmfLvINf/yconOfSzvNMF1HDadez8bZM9NjBs1QhpHfLSnhKZJyJ4/SoRlRPjw==
X-Gm-Gg: ASbGncv18njzu9rcZdq5xhW8gzIFhPV9sstMTqNBgfjGfklTJ+P8vJ/SZmeDp3hDDSZ
	KxXqD8Aevl4nYgluBaksYnqqb3+f6icakTEvS3hTlV68a0aALr1OTn0kOSHC6Osv3dSZ3bYkC8A
	8tqUkYcezApBxnS1PwOtLhk/tafM4Q+oIsTnw65AoD9X3dh+VtoAkg81ZFQi881A7+4jmcXYPzI
	R4dx/t63rjkwx0GeUnUUGveisnyl+T7KecOpY8VtZjqGhCFcSRsAu7P3t6t+dUfB8oyoKl5Y10M
	StOMFyqaViOvfYGiw2vw1Wmem6mVJddO+dOv4RcGfAB33uarWCJ4+tg/pgbbRvDRfSt3xBfmYV5
	olgSNYLIk9H0vS7C4EIYi0xEb
X-Google-Smtp-Source: AGHT+IGRali885xzg7nkCZAqpobQ/FrL/+QynNKtVo4E+o0NDUSPgTFZCUYGZXOltV2X5DHYyoroBQ==
X-Received: by 2002:a17:90b:3e83:b0:31f:762c:bc40 with SMTP id 98e67ed59e1d1-31f762cbd4fmr2054904a91.16.1753882131977;
        Wed, 30 Jul 2025 06:28:51 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63e007d2sm2071990a91.28.2025.07.30.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:28:51 -0700 (PDT)
Date: Wed, 30 Jul 2025 22:28:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] hung_task: Dump blocker task if it is not hung
Message-ID: <x5crxfuhbnlk4pz3lidlwh7y5meoqlkmteedaljeepizbxbvjr@7orhkqjvdpnk>
References: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
 <175386922226.617855.4016966678697742834.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175386922226.617855.4016966678697742834.stgit@devnote2>

On (25/07/30 18:53), Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Dump the lock blocker task if it is not hung because if the blocker
> task is also hung, it should be dumped by the detector. This will
> de-duplicate the same stackdumps if the blocker task is also blocked
> by another task (and hung).

[..]

>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -static void debug_show_blocker(struct task_struct *task)
> +static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>  {
>  	struct task_struct *g, *t;
>  	unsigned long owner, blocker, blocker_type;
> @@ -153,41 +193,21 @@ static void debug_show_blocker(struct task_struct *task)
>  			       task->comm, task->pid, t->comm, t->pid);
>  			break;
>  		}
> -		sched_show_task(t);
> +		/* Avoid duplicated task dump, skip if the task is also hung. */
> +		if (!task_is_hung(t, timeout))
> +			sched_show_task(t);
>  		return;
>  	}

This patch seems to be against the tree that is significantly
behind the current linux-next.  Namely it's in conflict with
linux-next's commit 77da18de55ac6.

