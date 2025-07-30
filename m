Return-Path: <linux-kernel+bounces-750533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99324B15DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13850188E1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6D291880;
	Wed, 30 Jul 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CLM83OLe"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2128BA8C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869402; cv=none; b=ZsisrtIkoEyrlNgfm8Gbcn3BTPj2ipLwTR4MppKU8mq5jt9gOTtY4jAKe6iyotxvWYV8BDK8RM4tuOysdt0y9JTCbeHgDWd7QQ+f6VtTLtq30PH3DSYn+HW1rSb2LRxjis5VkiqRAYZy+3M9FPDsYUPZEzxsmIp6HmNO8mmP8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869402; c=relaxed/simple;
	bh=w9n3EYtiCtFMcllnFHfYMN0Nqed1svW0RYUrV62rBLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiHLZZOQOmSj8XQEWX32kg9RDxyrsbfk4ij5F+V+OHIypjFCpatnV+Ankx16VTBHdpmpKXjbWaa9kg+kND6UEwHO5RmacjGGaByHlivbwGV2UIW1O2+3kahe8A0BgwvOYpJPNbf8Ah/puBwEgdx4z9ePsh6BcR7RQ2QCuawKVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CLM83OLe; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso5652035a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753869400; x=1754474200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oK8H9rTrTInYv+JtHmq2H4dZt8ZSwYJYFJpg9TM/EIQ=;
        b=CLM83OLeQJdYimUK7gIGq6u4bIyaxt9MBDf+Hfq1Kwp3w0b5Cv9AI+wmSth7YuZQhW
         bkKbDp2ls4DMWLS4Zy8cBDK2ew0rFcMGhtGaO7BK5p6KD7NHIbqTNHtu++C2xqEwxD5l
         NpQmrrLVYk6WlJPu7N0k37COzxmr2XwnjsZgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869400; x=1754474200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK8H9rTrTInYv+JtHmq2H4dZt8ZSwYJYFJpg9TM/EIQ=;
        b=XNrOBjRCUxf7ZgOzosNSPynO2j6T+bqCnQT3sly/gFoj9g03fTbzk6Fb8ryr85+OvR
         f+l9LuGlRO5wBCZnVURDcZoCjmclIEH50tOSX1gVdX0s634aw7yMK4qyHaj06mNvj3J6
         h4ZjcM1BP9tO7QQExOR3GClUM0cpXH9bwBCweSTi4Ep5/Db57yhk1Qq/2nuY1jTKFQuE
         A9x8Sr9UhzNaU7BIvYfnSNu18C6IKSUDgGishs4T97UZITENHpK/nkQG0VciB0185rYM
         An+AyWGR/tHTKmivmA9MlDjUoWPnPmwbVjP6PKow4Y4deCiHI7hDoNXU8dkJtqW3R/wq
         +MPg==
X-Forwarded-Encrypted: i=1; AJvYcCVns9JnjEocgB3r6wE+SUuB0FR7M+bQZl4T/ZJGSp+zp2lifKB/YUjKZc2pe0D+CjfJYHlhZ6lg5GdBs74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8foyRjxfOVhP6uESV+HrMrfut6qcKTC1j7hl12WmdBu6IzZGY
	vY1WuReHBpwD75VKHObPavU+zjmbASRfNvtVTaYZB4iveZjm0vdq7Jazg0SrbbeZOg==
X-Gm-Gg: ASbGncuJjX16/OJ1Uk1uqqRAh0sTlX1X54fZpVxb0Y2GsGtjWuiL01Z3FHaSpRXWdsV
	Uq26tPXABg/SNLuI+IroIeJCoeiTOtHLNkLvGqahdEj8CS4R4cBGgJBE2FkI28SDiarWOZlEvbB
	C0duVbrLe8KxDAX/vpY9nqA/XvP2KXBDIffjUVQcRyUwA1et0slvdFOAzKkIedEjk+R2sJm1bW+
	Qx8XL1PUR9CKLcW7WGB0ek1cvSSYX6qyr50d7BDVkrQt08pJZfWunVMz5/d4uCUxhiy52b6lMLE
	ju/9Pin1FZqjY0p4H5PyO1p3gI+QA/UxNAIIK9YPmHqdzA6S1hFBreqpCtmwlAxV8OQVQLa/YcC
	LmNIDszbCAW48+5rGjF851O9A
X-Google-Smtp-Source: AGHT+IG4vB1avAUYC4wg1+JU+WCH2gXrPKr2vD8piaxJZfPcdAAOSX4moxksL2HFhPdU/UH9e3DKHw==
X-Received: by 2002:a17:90b:3a08:b0:31e:8203:4b9d with SMTP id 98e67ed59e1d1-31f5ea4cc0cmr3908356a91.29.1753869400218;
        Wed, 30 Jul 2025 02:56:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f2efd8b36sm2388240a91.1.2025.07.30.02.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:56:39 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:56:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <oiyb3a2qmf4hgqfyoztipno3d6j22ew77s43adt4rfd6kqhqvn@pqzvbsxgj2cq>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
 <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
 <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>

On (25/07/30 17:51), Masami Hiramatsu wrote:
[..]
> > Notice how each task is backtraced twice.  I wonder if it's worth it
> > to de-dup the backtraces.  E.g. in
> > 
> > 	task cat:115 is blocked on a mutex likely owned by task cat:114
> > 
> > if we know that cat:114 is also blocked on a lock, then we probably
> > can just say "is blocked on a mutex likely owned by task cat:114" and
> > continue iterating through tasks.  That "cat:114" will be backtraced
> > individually later, as it's also blocked on a lock, owned by another
> > task.
> > 
> > Does this make any sense?
> 
> Hrm, OK. So what about dump the blocker task only if that task is
> NOT blocked? (because if the task is blocked, it should be dumped
> afterwards (or already))

Yes, I think this is precisely what I tried to suggest.

I'm not saying that we should fix it, I just noticed that while looking
at some crash reports I found this
   "wait.. how is this possible... aah, same PID, so I saw that
   backtrace already"
a little inconvenient.

