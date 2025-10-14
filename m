Return-Path: <linux-kernel+bounces-852175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D910BD85AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810104E7B13
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988212E6112;
	Tue, 14 Oct 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xz/BeiXx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2F1E3DED
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433100; cv=none; b=PC5TKlPNGi3ixUWb7QccRTrR7HMZmWo8eeqr8NS2DNcnSxBi6a4Ub1d1F+akmb8kJ3FhKYK2IXCvjk9NttxR7pqAf+76m090Rv7OrkB5of8jYcXC766pJGpLl2bkUUsW4SP9iMkyTL2b5fyKcaxjRLPKwORB1qPihXJeWjkqDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433100; c=relaxed/simple;
	bh=M/XOu2Wm57St5QEjUrTwvBtEPb90StpFpKykt2ha1xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg3k+DVL+b2SAE9xyRV80mGP3rZqLmrITDJ+K48xWimWLbUr6RmparP4YxZfGGdTpA+pqGljmYMpaR4RuRtdohjOW/2Op9k+GaBCpNZHUtEkrcu8UNnwiAL3zqcdexYjFsavEHFWcplU2m0awboQ8NC5LlStCxaolI2jkbwU4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xz/BeiXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmZChAiP55LH7fuGlLhGHRkAsOIwC7Uf7Qc1D8RxjL0=;
	b=Xz/BeiXxLX/EWRcckharZ4tszA834Hxu9N9IbxMPG9vEqpeTKmrNc5oFpxUoMh7xFq8FGD
	pZOv+SsGKCMz2jL1kuyo9VWe8+GozyamnXHX5EwlHKLIyFPTgnU/fRWujBrRV2xUMrVeXT
	7ioJy0i9dpQ+loROThssMd8wyAL37nc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-tv7oFco2PICeWDrDHHm0WQ-1; Tue, 14 Oct 2025 05:11:35 -0400
X-MC-Unique: tv7oFco2PICeWDrDHHm0WQ-1
X-Mimecast-MFC-AGG-ID: tv7oFco2PICeWDrDHHm0WQ_1760433094
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3af78819so26072205e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433094; x=1761037894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmZChAiP55LH7fuGlLhGHRkAsOIwC7Uf7Qc1D8RxjL0=;
        b=aaZj15SmjX1G9Rm6bi5CNSnn3b/0Atr7kENzltwAW5Fs2VPoEPq3Hp2ozEY0Fb3pWI
         uKqasVhRXY7c8XcpscjqlmouN54M6RmYgaJKJ9fbrppw9tTBLi3hgSj1hx2BEk0cSjNG
         B28L2C7o7lBrdkCB8QF11g2M5Zp4+4W5d2nSmQOhM16i8cWWRGJ1/M/a0KsRmLXmPBX9
         DZ5diVi6mSjz24gIroCRJfycvU5Y7Km8O8tappmSkLAHbA/0qK74yllxMXl74KVLoVYp
         mwo33HNXUFk1sLql7Uo7ascbFdJTAf71khMjhhnVhxTvE4Tib6Vc4d4tbZMklAB2zTwE
         a0rg==
X-Forwarded-Encrypted: i=1; AJvYcCUqJwW1qq5ccUx/edisdEZ42mFHmALinVlWSuc38Lf0nQRQ1m2TVRus0Jo8ckaPGK9to4AdntVnl4KTNQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31rwlKZmx2mXDpulDJP3/gxcpsy0wRIIe9paYsswSFuFruj7z
	pV4ycAdi734BW0nrOGFONpCIHfxVC2Wi/9bSJGM/u0A6nXUUqJoOVE7ySmRdE4Yy5LNu/iJ6WLW
	lOufZPPRcbzw83iq/+d1keKdpgpQAsRW1zyGejMrL4RfOb0diFMeuKWNw41+eMSc4UQ==
X-Gm-Gg: ASbGncv13V6tKVC6QvrXBUK+P7Tx0SBIAiOcaSga85nkhmcAy/dvgn3/0o7tj0xgqoc
	Lp6GnrO4NtZg53qiDbZco/HH+4589y4wCsWsHnR77+8lAA8Q8Ustz882xa2SMxJkL6Y2C4tDl9P
	GYPkLljW8hI9cY6yjvortfpr7W+yCMtGiZU+OUtetqh1xWRIHnpXvh/2QW1ECm0KPR1qzghdZcJ
	lZ3he+AEy0kjfHMFKL13BnWGgPKL/WfCNxjBu/rnS5uExeVC4TM5ngeF12XZnn0imPJMwdprXPH
	98APdF799wltNmqhHJnMWT3SrYVbPxTlvQe9YqI/Swr8Qi6TjG8UzdBdqv72kjDUNQqy0iy4
X-Received: by 2002:a05:600c:1986:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46fa9aa4711mr148996025e9.11.1760433094374;
        Tue, 14 Oct 2025 02:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmrDXjCw08WD1TQhj3YC4hMNp555u6CSxx5SZw+8OCS1At5RI/2QEFWI5fYDiJWMd8bQmAcA==
X-Received: by 2002:a05:600c:1986:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46fa9aa4711mr148995905e9.11.1760433094004;
        Tue, 14 Oct 2025 02:11:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm145329615e9.5.2025.10.14.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:11:33 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:11:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com, venkat88@linux.ibm.com,
	jstultz@google.com
Subject: Re: [PATCH] sched/deadline: stop dl_server before CPU goes offline
Message-ID: <aO4Tw1SzNpgWutK8@jlelli-thinkpadt14gen4.remote.csb>
References: <20251009184727.673081-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009184727.673081-1-sshegde@linux.ibm.com>

Hello,

On 10/10/25 00:17, Shrikanth Hegde wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> IBM CI tool reported kernel warning[1] when running a CPU removal
> operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"
> 
> WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
> NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
> LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> Call Trace:
> [c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
> [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> [c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
> [c00000000034f624] hrtimer_interrupt+0x124/0x300
> [c00000000002a230] timer_interrupt+0x140/0x320
> 
> Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> 
> This happens since: 
> - dl_server hrtimer gets enqueued close to cpu offline, when 
>   kthread_park enqueues a fair task.
> - CPU goes offline and drmgr removes it from cpu_present_mask.
> - hrtimer fires and warning is hit.
> 
> Fix it by stopping the dl_server before CPU is marked dead.
> 
> [1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com/
> [2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr
> 
> [sshegde: wrote the changelog and tested it]
> Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Looks good to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


