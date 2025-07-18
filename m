Return-Path: <linux-kernel+bounces-737015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABBB0A6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3881C81B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ABC4503B;
	Fri, 18 Jul 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEh/Wv4r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C48199931
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850410; cv=none; b=iuUcO/LKZWY6/dxkF8WjBnGZsY5DHOFnKAQ4bWEXLB/BHrAnFKq/onJhq4SXkR97oeESx3IhPxAuiE+JCOa7B0JY+vzrjBtaQ5GaZNp3db5X19693KobpgR06dR9ya0Qu+UlyZyr7ZxktprWPRdTQpPGSumbJqi4V9U5GBRYj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850410; c=relaxed/simple;
	bh=PfboCSKP8zBHFuiMpnc+pPlFuhoqKc8wNPWc+Xetlx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRRApULCuWi6T/tk1P/ptSmDZWYsZlntJrN1HREyei7Qgp1Y8X+4mg9BO9+q7TwIw+M3c0goB3WptEDXGvl40QNUakIDw/fMGBoT6VbByZjyUUbEuvMcNxdIGgmJAzv5+QGXhBrkxkgqmPP/28H0Oj+Zp4yhXoF1/raTENnCiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEh/Wv4r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752850407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tt1DyccuwwVhWnL8qupiaIsqI4UYiBZU4Wp6jieZdp4=;
	b=MEh/Wv4r0MAFb1GZCrDQbfydFdYsBZOBgEtmeF1R9PKBs4reXT20uXXrC+3MqE8Q31Fh56
	TMFiU9ijwSuajIoPvwUce9pMxEmD2P852JfPpmWzUKT13O8m/9kdorXHLBa9luHkBkn0dw
	g2ylExrrlTE2AUl4h75s5VVAxC/r3os=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-yx28hMiCNKicg7H1BGu5nQ-1; Fri, 18 Jul 2025 10:53:26 -0400
X-MC-Unique: yx28hMiCNKicg7H1BGu5nQ-1
X-Mimecast-MFC-AGG-ID: yx28hMiCNKicg7H1BGu5nQ_1752850405
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so903370f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752850405; x=1753455205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt1DyccuwwVhWnL8qupiaIsqI4UYiBZU4Wp6jieZdp4=;
        b=lnBoMC+bEHEsxWVg/PweNtGWs2uF8CdfYlVsk9e6SY7AKlao7pxgdcjwvDqGOMFWZ/
         DnsqtYAomFvdmSEoFkbzMrATM5KDFj0KQoO6/UV2kPCNmEjbn+o3yOQTh7d/zdWPvOm8
         tQ429YMPDHGNWKjHNtFzHmhCB2Ld8f3+czpTJ//g9X2grOXP/KFP7TyCM05ZTiZN7GG5
         2tupUGf1P87gsWj+uCWuUlXM07MbLsgzRFJnCHXLt3ONO/kD4L9TgLFodOy77rrVZnur
         NEqJSq3Qt7QjIqmL7VpvAobZ0VHIYRGKazOeBgtG3cdphkkAl9xeaqaUGqAu/+zaoh6Z
         S9cw==
X-Forwarded-Encrypted: i=1; AJvYcCUT6cbyc5X4va5GXXN6J1zlRrpTt2YQ8zT7sbPBpEUHwBoHMYy2KoNTsyz0S00lNUwXmz82a/Ajpvb5+/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsOyD2uVmNM1JQ4vBflyDBqnDigYSBogm6O/hKW5wazjLlD9o
	+Jhj7WHF+o1+z/qFifLB/ht4AefiUKH4BZdIoiXTVTKQw8Cw8zM7lcnJ3B5JczKb8Uc83SBkJY3
	P9G2LRRh5QDAaHs23Bi+qIqHEU6gDH5rmYVg6SW8qa9OWPMSS+GdBUI9vlGZdWjgyAg==
X-Gm-Gg: ASbGncsj6uiT2uMldNOhENn9BCcIdVHatpr7/uEBqVklVtpn1j2yETeSox0wHct/anT
	ntOZQvgCeN7vVBy1b6f9TZoFJ5JUaULLGJ0Azj/L6K2MB88q0pBF5mNWKG3/91SSxP8cvF3EYwC
	FGr96f1nBM2e0Klgpx3zqGvT2AqeNDT+26WGsfxIz0dkDdib1bI/OZnBt7H3tQ/S78eyCueGTeF
	Cl49hX0384dwxJx3+FizuTQ04O9VH5rj+IYN1JXNx2qAgpKtQIznJWIH7lNwn/xOcJIXDExk600
	OjZPcyeu3LFAM+RK4tMmHmAm5o6hI9/iP7ndXy7ICDEEjyWORIlCDULIFIoy+Sb0h09XWg==
X-Received: by 2002:a05:6000:2703:b0:3b6:1f8a:ea50 with SMTP id ffacd0b85a97d-3b61f8aeafamr677394f8f.43.1752850405169;
        Fri, 18 Jul 2025 07:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLFIxUjbpJ9ALlJLMfBnvJ4uxixLuKOh3qB7EwoTfg1ORJWXaYTuHRqgACxw9rRs9JISfidQ==
X-Received: by 2002:a05:6000:2703:b0:3b6:1f8a:ea50 with SMTP id ffacd0b85a97d-3b61f8aeafamr677377f8f.43.1752850404709;
        Fri, 18 Jul 2025 07:53:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.35.128.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d77bsm2076594f8f.70.2025.07.18.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:53:24 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:53:20 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [BUG] Bw accounting warning on fair-servers' parameters change
Message-ID: <aHpf4LfMtB2V9uNb@jlelli-thinkpadt14gen4.remote.csb>
References: <20250718113848.193139-1-yurand2000@gmail.com>
 <aHpYvwRizPkUe8Iv@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpYvwRizPkUe8Iv@jlelli-thinkpadt14gen4.remote.csb>

On 18/07/25 16:22, Juri Lelli wrote:
> Hi,
> 
> Thanks for reporting.
> 
> On 18/07/25 13:38, Yuri Andriaccio wrote:
> > Hi,
> > 
> > I've been lately working on fair-servers and dl_servers for some patches and
> > I've come across a bandwidth accounting warning on the latest tip/master (as of
> > 2025-07-18, git sha ed0272f0675f). The warning is triggered by simply starting
> > the machine, mounting debugfs and then just zeroing any fair-server's runtime.
> > 
> > 
> > The warning:
> > 
> > WARNING: kernel/sched/deadline.c:266 at dl_rq_change_utilization+0x208/0x230
> > static inline void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq) {
> >     ...
> > 	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
> > }
> > 
> > Steps to reproduce:
> > 
> > mount -t debugfs none /sys/kernel/debug
> > echo 0 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
> > 
> > 
> > It does not happen at every machine boot, but happens on most. Could it possibly
> > be related to some of the deadline timers?
> 
> I took a quick first look and currently suspect cccb45d7c4295
> ("sched/deadline: Less agressive dl_server handling") could be playing a
> role in this as it delays actual server stop.
> 
> Could you please try to repro after having reverted such commit?

After that (w/o the revert), could you please try to see if the
following helps?

---
 kernel/sched/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f0..02e16b70a7901 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -376,10 +376,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_queued) {
-			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
-		}
+		update_rq_clock(rq);
+		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 		if (retval)


