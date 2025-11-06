Return-Path: <linux-kernel+bounces-888361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE2C3AA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB1D3B4EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C452F3C07;
	Thu,  6 Nov 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UmvrOMB1"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB82DF716
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428805; cv=none; b=hhVdQUMidFXQ6j0qKDVD9G3TcfRcRwFx33Xp90q7xsima6vh1b1y0pMtF5YBI6RmsOzZeszobCYdvvrVJK2Lqwln7snBlnk9nKMp2YkERdnZ5Ox9YpZANf1FhI+Aht+QWAp8XhnOfq8AHVJ5XkhToVPHquD3D/7Z2IeJuewCn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428805; c=relaxed/simple;
	bh=tkR+GnRDtqKSwAHuMAm5xpZ63WHRMWHzSvfOCt3qkeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9rx/cvzjkUp7KB5UPTWmm0kTywq1FbtKNgWaLsw1C16jWF2rI/kRGvnalFwTpR5Jaha9ig5cXGAPVfvdW+6r2wCBK16NjQNHWbSj5oMz3/0uFKCClN8COg3AYB6WvUQoHecGbtMAZK9eNJ0z4wq1S/sDMxCBM59ptsv67bYHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UmvrOMB1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33be037cf73so1000891a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762428803; x=1763033603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ij/rVy4GziBMq3uULEB/2DhQCV4nm5H8hheAM8nrkI=;
        b=UmvrOMB1XT5iWPhswOdcWDt4HEzZa5Vkx9WHbF0frT5f5pzRmrLN2GWRBKGWz52yZI
         wqQckTptBqCk5+f/f+95mTzsQPU2C/h2M4WgOvFKo7YkjS+6DZbEb0JpLULr6N8EqnE0
         H94TEDji4Cc9viKmep9ZNrBfc5d2q00ONodzp7pm/ALBBF6jxLAyCJxSCxIhROz7+EBp
         xsKhEyffuGM3gFGAxAT+BQWeiX05wTk6fllH2uNcCN8eYac59hLV9TZzswPliVGFc+Aj
         aDtfaA7jSsx4piAl9MD7d3L1LIvS/9CLJhi0iCBjJQVClpzSiS204O563tt+51VDb2yH
         7Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428803; x=1763033603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ij/rVy4GziBMq3uULEB/2DhQCV4nm5H8hheAM8nrkI=;
        b=DpmbBVIbEa91gpjxf5DR6n310KMl6kGUw2Vj2Bi0jliaac3XPnO7RdDTHn8rZ9E2tv
         7Fruj4mjKR++oaiALeMyyXugYFYXC5mKBjnQSpW5VzE00EcPZUv7ktgUMlwlZJfTlqY/
         yUl91l+8f3jirnS7RUvwGXWC50JbMh3hhMkM3zz11z0RhfT4fN0qoR6jc8Hd2NKhDTuj
         Q75yIl2cK3la6TYgDfeztP6kbikCntYALdOWywtUdT3EPKpwfZdAgPZVA0NuMpMPJ738
         D7B3rHb4YbnFznQ6pzfHk3nWRrMATw4slKjSenp2X9AP8Ncsz6ZUhdg19f+RUMq4yKx2
         AGMA==
X-Forwarded-Encrypted: i=1; AJvYcCWdoZnj+N7gttWlpP/V+jADzHcWCl2w4n3YaFrYLdALgpV/4HTd0Jy74pGVmhPlS6RsmfrEy24M9oPK5vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeXCENxH7m3b2KXidS+WvqJXnD6HFXJO8L8WknPwtH+nILxEh
	C3A4Cf0EloPdImDqiElRtuo8J5+C1SKCD2c6h2doRQ8jUi44pEt96EMOzNCkC85urg==
X-Gm-Gg: ASbGncsF8IoLpFWk3oiH5QaWCALe69938P8EmbEsh2XB12QeK0c/nq6tlk4lDv8pXxv
	OvC5d5r5+UKuQSXZ2MCpcde296lMBob/JucJ46bGvOHHz5nVClf8BsjbGAca/FtljdDQeI55dDp
	oKudTIhmQk2XK4Us5sLDuxuS7qW4yLilVpxn+itIODc1YQAdvBDVTyjJGnGaRzd5KheVSrYdeEO
	/GLuzU9gEF++jlw5nswtE8Av00jm9YPYzxU2d671uljw7tVB0khkuCc8nPe0POMWEFSa2iE33p4
	w1/F+plmAVR1WtYGQ+T4nIi95EUb04jDzq8y1/Ip6n/6PstmLBV76Iwy9EuhWBBUle8DZBP5MsF
	BFRXThI6KHmf9zpv6xZRM0LeGBsRRSCj32mwRm2vt7oR6TGmzQpkQlyzcFf3o77qjo3oK9m/0Nc
	lfnSdGMgEWSM2/lX7R+e//xUGaHpvz8+o=
X-Google-Smtp-Source: AGHT+IEiAJMBgqtthto2j9GFXwiPZEtaYsWnKLnAoaxjbeeaon3+saFFVOVfdUtlulDdFlp+CcxI3w==
X-Received: by 2002:a17:902:ce0a:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2962ad069acmr75069665ad.8.1762428802934;
        Thu, 06 Nov 2025 03:33:22 -0800 (PST)
Received: from bytedance ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm25812805ad.13.2025.11.06.03.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:33:22 -0800 (PST)
Date: Thu, 6 Nov 2025 19:33:13 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hao Jia <jiahao.kernel@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Message-ID: <20251106113313.GB471@bytedance>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
 <xm26346sjh47.fsf@google.com>
 <20251106112500.GA471@bytedance>
 <20251106112721.GS3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106112721.GS3245006@noisy.programming.kicks-ass.net>

On Thu, Nov 06, 2025 at 12:27:21PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 06, 2025 at 07:25:00PM +0800, Aaron Lu wrote:
> > On Wed, Nov 05, 2025 at 01:37:28PM -0800, Benjamin Segall wrote:
> > ... ...
> > > Reviewed-By: Benjamin Segall <bsegall@google.com>
> > 
> > Thank you Ben.
> > 
> > Hi Peter,
> > 
> > Do you have any other comments about this patch? Or do I need to send an
> > updated version with all the tags collected? Thanks.
> 
> I can tag the whole thread (esc-t) and pipe the whole lot through b4 to
> easily do so -- in fact I just did :-)

Cool, thanks for taking care of this.

> 
> This was meant to go in sched/urgent, right?

Right, it's a fix for the current kernel.

