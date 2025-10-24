Return-Path: <linux-kernel+bounces-868050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D9C043B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F11B4350B76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5D26E6F7;
	Fri, 24 Oct 2025 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3X8C14bl"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F12494D8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275885; cv=none; b=uFbTPOLEJnS4dwzt7vnIIT57GKH570q5XGdPI5fOYrHr1xzfyuifP7J11GoGGSsIOIutSeGQOGguEJ8HYZVF1cVU3YERh7NwYfmeUgJt/CXEm6nKGprmW4QOerA2H9vycPbS1Zpuz1tnWUeReZlH9XyPXcvQYIFACsq9vzkaGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275885; c=relaxed/simple;
	bh=Mm2VyaI4Igfss9i7TU8/z7aHTWUycbu8XrGKZEVvMDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SqW1mb9LU4P7TMk/BVLSxIbNEQzDCEBhOfjynedLKTmKn6wGl1SGtGRbaMDDOgmIyYEDbHUu2gZxPQI2TwV9TpHyFHj8lHF/2bHYIaBSnMPHYu7I7weFVouvd0vy5zZuFvxtly4C/SRQSygj579nRblRc3JOl4Y+4CjhZD5KGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3X8C14bl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26985173d8eso36198785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761275883; x=1761880683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=86TD3UzM8BdgXc7Yqd4HgeHYcCczwfuxg2J/6uVoESo=;
        b=3X8C14blxZrrQslcVrMTQFDI4WRmtE1Lu1graPsoUsBZ1ghExnhKSRrvwqTlhyfJnp
         H2TwGiQTruWEQIjJXhkoqQF0AvXmvgvd3rdnW/yYSFLBw6FSJ1tW1tuPtu7GUnNr+L90
         V7y5/14PnkifDQslPICtXoKwRnS+zbPhfDvocXR8dJFcHCbXmyEHciWzF67jD9/7Bzya
         9wvr9TODXQAkUtSM2IdP/NUoHFURgPRw+2tFuHCWKOZrtVtudswlQKRuGuSjXrcvveLM
         W+CMqaCHXsb1ETMcIqsnxwrGz1Sah1do30s13cY1ho1VeYQfgnJt/SatNzl+DiKNladl
         cO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275883; x=1761880683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86TD3UzM8BdgXc7Yqd4HgeHYcCczwfuxg2J/6uVoESo=;
        b=ZJ867P0J69ZooAM/cvYh9Q8UvwqvEzvJl3mo2pCc7FACCXSCIyQgOFsX7Z3qNuCoH4
         uyiJWr+diWdFTBQy5+9XdUE+PDBndrlywxSuhnTmF2l/QlkRVtt0gKRriZ3VgG3FMNpR
         /9sc7/nCuTj1GJreTGScVZXXhjGRwqKEOETAUtq1Yju0fS1hWEETuvRe158Qr628hcdG
         hg/FDwy4QJOQQYRmoDKC4K0wlcRssQB30eCPPdw0I1oLswJ+bpEqK4r0K+5y1fwwxYAW
         IVq4a/ezk8VLIj272MArOrQSvdDd3CgJOX8GwPZJ7lgz1DS/xWdoMgivZqWS2SoZcaa3
         MPEw==
X-Forwarded-Encrypted: i=1; AJvYcCX/+8z2FQUIR8i3ikdSnvGdtlwXQUsJPI0gW6yA+ZCkqH6VSsReFL2iyN+AqGQ1l1ihFGmXqrgriKiOmyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRo229G+JoqOaEM25ah6UYT3qAinpqoJ+yYSFHDIegYt2+MQj
	rwt1qe5R4/s93P8oI2gQmMoCS6K7qpSKv+QtSZCmef3N7lEIM4iGjVmY2fV9d2uGTICnTqB1gZO
	7Cm68Yw==
X-Google-Smtp-Source: AGHT+IGbDXf3zXQD4ouIpOm4qwyHLbnbWkwJ/gIVE7mT+Z9sFC3feertEA2eWKr2O8i5iT2f1gFWGeayNYw=
X-Received: from pjbbk16.prod.google.com ([2002:a17:90b:810:b0:32d:a4d4:bb17])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0c:b0:267:af07:6526
 with SMTP id d9443c01a7336-290cb65c541mr349189525ad.55.1761275882800; Thu, 23
 Oct 2025 20:18:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:17:06 +0000
In-Reply-To: <20251024013153.2811796-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024013153.2811796-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251024031801.35583-1-kuniyu@google.com>
Subject: Re: [PATCH] net: rose: Prevent the use of freed digipeat
From: Kuniyuki Iwashima <kuniyu@google.com>
To: lizhi.xu@windriver.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Fri, 24 Oct 2025 09:31:53 +0800
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat,
> a UAF is triggered.
> 
> To avoid this uaf, when rose_timer_expiry() puts the neighbor, the base
> member digipeat is set to NULL.
> 
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> 
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
> 
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>  call_timer_fn+0x19a/0x620 kernel/time/timer.c:1747
> 
> Fixes: dcb34659028f ("net: rose: split remove and free operations in rose_remove_neigh()")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  include/net/rose.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..9b0dc81a9589 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -163,6 +163,7 @@ static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
>  		if (rose_neigh->ax25)
>  			ax25_cb_put(rose_neigh->ax25);
>  		kfree(rose_neigh->digipeat);
> +		rose_neigh->digipeat = NULL;

How does this synchronise with the timer which is going to
touch rose_neigh being freed below ?


>  		kfree(rose_neigh);

Isn't the problem that we reach here without stopping all timers
or that a timer does not hold refcnt ?


Also, please post a patch in a separate thread so that patchwork
will not be confused.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#resending-after-review

---8<---
The new version of patches should be posted as a separate
thread, not as a reply to the previous posting.
---8<---

