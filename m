Return-Path: <linux-kernel+bounces-860145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C440BEF687
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70B31884A30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7B2D0C99;
	Mon, 20 Oct 2025 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXkhDskn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035714F9FB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940513; cv=none; b=laBq0IR/mDJcs35oheVpvMQms8QMQcAqVvAWhUB+DWJSx/+XZ6/if0xOImTecBYgNZsR0uE0IJ4rmQtE6tUzkqCSdb4OsLo5Amr1ob1Yn9b25ZmgvUZFlVJFSQLNXQHjArJ6c6bE5kl5upl5bYJI6AQILs1b3ZZv8ZrBSnCXklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940513; c=relaxed/simple;
	bh=BCoSWdmgbT1TaGEsew+RrT4YJRXIR5nlQF1QrBbl/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+885Z810ZEamzt9gmXKZhuG2dthJr7SB8TPX8eKN0/4bdfo9ot44K+3MPKpc4r0cFLg2pkN7HD5qZn6yw52BAQrasIl0HLUl7rWRM6CWn6oObkDUA/H1/1LW/qF2c2HE9fBYpyYAci+AjnuUAW+2rZeONo+2ZDfdtQUX5wkRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXkhDskn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760940510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQuFbzbaUqQeXmCypjw3/sdi/09uNDRdkvz6dGUNKB0=;
	b=IXkhDsknS5iFNUHtNaIeXOx2AyYoL2V3BOhw0FwUJwxhQlfsISa0bGZfRLzZz8mT94XIM6
	e4UkQjSctGHcwSoVlOKGe+Oo32g2dXE66Y229IuwnGA1AoFQsAzHqYC+Kz8vpR41o91ql+
	cUjKXuiNRegkq692+NerZpjDMCe8DRE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-fUgi7zY3M5qE-ithde4ATA-1; Mon, 20 Oct 2025 02:08:28 -0400
X-MC-Unique: fUgi7zY3M5qE-ithde4ATA-1
X-Mimecast-MFC-AGG-ID: fUgi7zY3M5qE-ithde4ATA_1760940507
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114d373d5so41445115e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940507; x=1761545307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQuFbzbaUqQeXmCypjw3/sdi/09uNDRdkvz6dGUNKB0=;
        b=IBd6grh+54qstAlVRBhlBf4p/2JRwB2pfU8rH6ewVy4J9H/FIGGcKzMGtGElNRO0fk
         GEqZlU0si5acaweEI9KsCn1gCCZp8kdusiPZXt31zEzFwaX3bU6vmEPxZS/bL+nuc3R+
         yHQ8uUub6xj+wUrkvogCFP7Tk/WR+p+2GT9gARyBBlkfmWElnTUxN1u3QzczMDuJsjB9
         jRR5u0ZPpMrek4uBHiRib7LO84gkpt98vyjh9hdMJ3L1Pk4am/NTPryzFvJyU/wFrYUR
         ns++Aozz6SjX8ClcpmZ3AKRhGMfEnvE9cLVOB/12zHq/1iT32sUK8bS9w+S77fE4REUl
         WbdA==
X-Forwarded-Encrypted: i=1; AJvYcCWMu97xCMsI15b8/XboKH/RmPIJSyAIDWP92mvGUrRiQOomIF+uWYrm6kYa+g+fQL6Yn5s/k3iQBKdijmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIatjWWgeNkrO7JmH2dbv/Ni1SP4+DAYs2Vz65FcYTcEYWw9k0
	H6OmILNQVhTDbvVX+SR1MhZAC0iIjc2aRq84Vyke5LT1zQO2ZqO7sYwbiTEr2nRbWVn+oL+1jK+
	z+mo6GzOTAyZxRkxXF8eoq1UyDEJwtI8hrLQ/RGLtIGhaUNN7zlxkmQCp3djkdzhvjA==
X-Gm-Gg: ASbGnctO19wyWKrShHTuYlNA8t27zFfr0CptHJAndSuCGNEzit22TXrNGZk42XyCPFC
	bYGUyM6eSyAItWq/PFg8oO4NKRvN6lnKcR9dZB7yXUE+4ojzivNoUjaz/EXDV49ABCTiko10p4p
	CKndG7UJqBmVkGunhcLNKGaHIUhdt60+P2CKULZiasYh1qjxRFGIjxqyLm/GW59SUG7IxLSBFg7
	OO0OBXa7aYq7mrGkY3+M+/5RXIo4irAbTOsQJpm7sd3/fiTh/Hk1WO9hhLNAtAGLYVeMc7eNb3J
	efS3gfufL/tEbSc7aonAfz1XaqysgMsv2cnlNluiXU7pfwMi0z595zgWVO+tc1uRpLjR2kwa/BF
	7djdB9F+1Ax37+SZyI0ZkHmPXOAJQw1c=
X-Received: by 2002:a05:600c:1e1f:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-4711792a2admr85862375e9.40.1760940506875;
        Sun, 19 Oct 2025 23:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCfcVkBiu61OspSB+hr3+Eu+dpCS0oJKyzY5B2GW/2d+oKy9v8Txx/pdsyxDdViW8IOdN+1A==
X-Received: by 2002:a05:600c:1e1f:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-4711792a2admr85862135e9.40.1760940506470;
        Sun, 19 Oct 2025 23:08:26 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fdfsm13385253f8f.40.2025.10.19.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:08:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:08:23 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com, venkat88@linux.ibm.com,
	jstultz@google.com, d7271.choe@samsung.com,
	soohyuni.kim@samsung.com, bongkyu7.kim@samsung.com,
	jkkkkk.choi@samsung.com
Subject: Re: [PATCH] sched/deadline: stop dl_server before CPU goes offline
Message-ID: <aPXR1w8Sq-xiOu3K@jlelli-thinkpadt14gen4.remote.csb>
References: <20251009184727.673081-1-sshegde@linux.ibm.com>
 <aO4Tw1SzNpgWutK8@jlelli-thinkpadt14gen4.remote.csb>
 <CGME20251017055524epcas2p2b7cadb80f5d09c4003ccb66d4c39c9dc@epcas2p2.samsung.com>
 <aPHbXxJRUTdkBZVA@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPHbXxJRUTdkBZVA@perf>

On 17/10/25 15:01, Youngmin Nam wrote:
> On Tue, Oct 14, 2025 at 11:11:31AM +0200, Juri Lelli wrote:
> > Hello,
> > 
> > On 10/10/25 00:17, Shrikanth Hegde wrote:
> > > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > IBM CI tool reported kernel warning[1] when running a CPU removal
> > > operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"
> > > 
> > > WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
> > > NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
> > > LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> > > Call Trace:
> > > [c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
> > > [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> > > [c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
> > > [c00000000034f624] hrtimer_interrupt+0x124/0x300
> > > [c00000000002a230] timer_interrupt+0x140/0x320
> > > 
> > > Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> > > 
> > > This happens since: 
> > > - dl_server hrtimer gets enqueued close to cpu offline, when 
> > >   kthread_park enqueues a fair task.
> > > - CPU goes offline and drmgr removes it from cpu_present_mask.
> > > - hrtimer fires and warning is hit.
> > > 
> > > Fix it by stopping the dl_server before CPU is marked dead.
> > > 
> > > [1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com/
> > > [2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr
> > > 
> > > [sshegde: wrote the changelog and tested it]
> > > Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > 
> > Looks good to me.
> > 
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Thanks!
> > Juri
> > 
> 
> Hi All,
> 
> Could we expect this patch to address the following issue as well?
> 
> https://lore.kernel.org/all/aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb/

I don't think I see a direct connection with it.

Thanks,
Juri


