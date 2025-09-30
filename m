Return-Path: <linux-kernel+bounces-837304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D9BABEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86903B774B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA62C08C5;
	Tue, 30 Sep 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TDZKJgpG"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DF24DD09
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218983; cv=none; b=nqZos4pMS9U3IEVjNIrtk9kPbhe1IYxGnNwBMx1mmGKS1yrM+KFm/rIJoe9UPCEYL7bKh9ocWunhLopwr2cY9vAIQZTth1R4Sbsi0MJ9tz9Icwx1S8SIJGLDWoS1rnHNCuRivOzTGQ2kkeMWPy2YbuDr3cCpUtoVKc6jApivPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218983; c=relaxed/simple;
	bh=fIolTVJc2lR5M0vH/gheqU+BMEogONLiQ0p/nu9ack8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOVYKQwdAeGy300uhZzNTD7DqWVZ8eNTx3kRkviaHGRwWBmOZqWlZN2IH1a7CZN8RnvPDkKLXjU0KOI7Id1YHkW6hbqx4jh5TVCYwYj6SI0f9Y/wwOLD/X6loO2LuCMKj/P3WTuT5tmAjGY5gLskQ9W7nJVifYzs2j8HalwBYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TDZKJgpG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2680cf68265so47267965ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759218981; x=1759823781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0UguS1D14qL1Pj9KceooV3d1bWiRa0CQxvQVAjJ6VA=;
        b=TDZKJgpGwVKrrvuF/CIOk0hNshUSxLf0rVu8hSBNJmAIYdgGTuyRq2V/HJ+ZMfaWRS
         ADEPMMFwOgMgstoYarkIO/V3wWDfahGfv7SrmlxOUnx+Zr9ZaMDDCc3hWz42ZHLt6s6t
         b1LUE55cxUdE56Cf0/L/WK8MsM02h/TMEag9IHtEeCidkf7ioxZRSQjZeih/69rD1C6p
         O5gMFril91JA14NVmon7sX0SK4WLHdbU3nwsorU7RKchua8YMnYXDNH6Q0zmKtJL361A
         YKgL1jFdMIlI4YeiivDMAbT4KB+uW8cB1A3SEuv2vTQ6w0yFiENLQ5WHtgpfHJ47b5yz
         Qvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218981; x=1759823781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0UguS1D14qL1Pj9KceooV3d1bWiRa0CQxvQVAjJ6VA=;
        b=gb5Cg+GFKhje1hfTP+ecNiqOQnUua2Ri5370jAUPyL2UVbbWUKUDfJvFMN4Bz8zY89
         3F4OUndfefcc4fo/+PbNJFHvGu/xsVkjXfMkmNXKkBUG8j9ifQGYMmL+AVfus7GzH47x
         R4UYPemuPieLXbzFMdg4VXrMp5wXJF2kJQeoJbt6+H4BJIMKEeO6oe9uuLnw6FzLHb/C
         qAqRQTFPX6zcUpqcrbWIRHKKG6QRX50lAeZwUIUWPnQqWcFYmBxYfD0vGo9kJr4ymhp2
         /lhA6NDNZr4H631VCBKunGo2v2xnhZvcw7nxhH4lEAAKCVxpdjLRBLAgWWAKgHy+T6FG
         yefw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Z7idh/Tsb92U6PDBwdPeXMibBdOqLuj4OD/rcuYNphvTZJbwSL80emjZSKEGFz7oxYb50RQIwm805mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhuGJalf78GZr+G+szFUI71S4KXkMQVI75OrCpokBq/FzMHe0
	fsSj4x5eKw6uzS2Hu+R6GXjUIBCL2yLcZmMJS8pgyzXnw8xgnxACExFBM9SqdFEESw==
X-Gm-Gg: ASbGnctxazrrgw+vBqlvz5LiXinP43igmm9QxZkL7aFA0WqTexJN7ben/jDJCZseGhu
	Ku9MnaB77tPzP5EppPxU+0ynk0yFWbE84f0ooPNNzbabsdhPb/+iMT99c+55zhSlR8g2nkmL9rm
	XxOOM5VzN9RJr3gPtYShnPmPF4EphwD1SnO5aJsyTUtJIj5qUVY4+0hXJoRh+ofUVwzQPWfCL+n
	wHsiFGXEB3dO3eoXBixTJYNp8mAxe3rf+mO8hkARIE19H5C+C0HyrxfsdX+9TlhBiQEuZyQERuk
	r49HTBNP7i5heYI8Jr/z42wSdQ4vtXpyFfdtO0Y//aFsEs7/zS6PZtdr6yUNhNfDAa1E3BeNf4s
	tc8cOnhc9hE5WOUbwZJpj0XAMV7lMqq299fg0QnD8gSMT+Z/7owKWf/jr5icritVcCj208UttTr
	vetjnk+5Am
X-Google-Smtp-Source: AGHT+IFeOFl+zFIVJoePiDkAuB9iSwN0UBDcsrSKCTXp3FL4kucEoRQHCxkMIiAUqLGC2ExQF87QcA==
X-Received: by 2002:a17:903:b87:b0:26c:3e5d:43ba with SMTP id d9443c01a7336-27ed49fbe32mr222656925ad.17.1759218980938;
        Tue, 30 Sep 2025 00:56:20 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671e93asm152016495ad.57.2025.09.30.00.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:56:20 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:56:02 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20250930075602.GA510@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>

On Mon, Sep 29, 2025 at 03:04:03PM +0530, K Prateek Nayak wrote:
... ...
> Can we instead do a check_enqueue_throttle() in enqueue_throttled_task()
> if we find cfs_rq->throttled_limbo_list to be empty?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 18a30ae35441..fd2d4dad9c27 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5872,6 +5872,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
>  	 */
>  	if (throttled_hierarchy(cfs_rq) &&
>  	    !task_current_donor(rq_of(cfs_rq), p)) {
                /*
                 * Make sure to throttle this cfs_rq or it can be unthrottled
                 * with no runtime_remaining and gets throttled again on its
                 * unthrottle path.
                 */
> +		if (list_empty(&cfs_rq->throttled_limbo_list))
> +			check_enqueue_throttle(cfs_rq);

BTW, do you think a comment is needed? Something like the above, not
sure if it's too redundant though, feel free to let me know your
thoughts, thanks.

>  		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>  		return true;
>  	}
> ---

