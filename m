Return-Path: <linux-kernel+bounces-798809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D807B42359
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E067AB132
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63830E829;
	Wed,  3 Sep 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSQnBia3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6971301035
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908744; cv=none; b=ipDY3Q+lDYQZsmbS2GRQLpcsl7kPmuLXjVGhaSCcJS2vqWn/P0dZx9+Q2u47kO28IcLASMZUa5ZsnW/ZOdmxmoXsI6OzG4/BxxgUKBZHs4bLVUWQB/SdiQ67ADlOVid9X/V/0MXrDIVRhsKNAkHn+A9S4+F9Blw3oIHoRBDgTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908744; c=relaxed/simple;
	bh=QSrZVhXwYSbWCqYop/FdR0c5Pkg6OynfXuIeMJ9WODs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJIVnP/rTfwaHUn0HyXiYMa/Hv2e7yWWiv3erTigIAEKAL+TMumNRsZUA7DvELTTa7grOb1VhwETAw3EBgixbV0V35fRRpUk+JttqKY3H2IJJucn3L0foAsZNYLbdocIpcnZdEUrbmDtmc57t9Pyf6Ry2vvB5rouX1i5bz+NjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSQnBia3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756908741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfKediTZQicsjXRgXWOlfF5FJ8vo8w+ELVfGpm5X5L8=;
	b=CSQnBia3sQsZbh4AQknbDnF3wCPPCT8mWYA+E3/Wg4nSRFlzy+c1XUPpIAioSWjHoKhZJg
	0X+tgrx6w3e3XESGHbgTFgB05mffqThWvHX6sqQkzPjMp1exbMxh9yUJZ4++W6oZaHbjrx
	QAJlI8Wv+xqUO7gQ62ZVdTcCPVfW2R0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-VzKGKZUFNzOYhJQI1ifBUg-1; Wed, 03 Sep 2025 10:12:17 -0400
X-MC-Unique: VzKGKZUFNzOYhJQI1ifBUg-1
X-Mimecast-MFC-AGG-ID: VzKGKZUFNzOYhJQI1ifBUg_1756908736
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so1476705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908736; x=1757513536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfKediTZQicsjXRgXWOlfF5FJ8vo8w+ELVfGpm5X5L8=;
        b=qPXbUlnjJ6QOBPR7UJWs85PkTmOZz0+Hv2UQGwzEipC2sOKrf6vhn1u1m+zDfcjQIY
         ZnqwJCs+z2d7pJ5GT9UYuxUzk9yNPLCST50xo2nWabKJ2gdtQhnRNuIo9brWkE/MHhkq
         Mkza8b6z8fEB2PHtmNkK5724nNBltggBZxHZTroVg9UdX7UmSjHZbi14ne9yMnhL31Ne
         wBIvx0/Fu/QavXTVYibsw2gt6gkw5jKxzjrH6GsqfIf2+CcGMUT5u+Rf5vrDJmMbjC/o
         zBrauyKHza9n+53KHBhm5lnB6faoq7Y5fJDg1PbvAjXm/9zz7XgSPnPyShuiHqI3MjtS
         L+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj9BX0QDRjyviKKY/rO6mLYTsRzUKz9zvx8IStK3b5zpwma9K3aUO2To/afUtkqaIJfTY/yXNoxcRJirI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoxKpXbvyju7SOVkGJh564kWzSktlVExoqIOs2Wm5y0aVvncz
	gYmE7ZEg7Dn3yRSG1rByYRRBTTqQNhAe3NMLQi0gpjWFu34EDGdmluVGbRW+CCKhTrUN1TG7RdS
	dMKaMh8yx6Ze8mQ4mhICk3RurHAwyuhp/iwDnwoIQ3cLSr0bcb17rPUq1fzsmHHjyxg==
X-Gm-Gg: ASbGncto4HgaBZ/izb1NdraJ2GXfxQYxCiluppX4GMwgtOASJH6FGzpzw6eLHSn1Xjl
	HhB3ebhZZUxRHnX/iVwSH+hPl94QThRMdzYEJ4EPLJeacg4E8giOxEhiv/oZraXJhdb31Ojj3Mx
	PV/4C5Zf3fNn96i1TDHc7/QN4Vu4nIhGZaqSnTXdGxRUrBPqMHRxyafG41myUpyAEKaJXoQzDzL
	jFmxhubV4CjkIu4Grr83pCNu106WtjD3diLryQBcwR8mW9A/27c1qu4b7nXs+LiZZR/ox4S9QEJ
	MhNkEmq+MpGqmVBexWWyTKiAsnLR6ij5gvAXuJlNNzcC55BepfSS0JO8pTUZLOJM0WYjwfA=
X-Received: by 2002:a05:600c:154b:b0:45b:9961:9c0c with SMTP id 5b1f17b1804b1-45b99619d89mr53049375e9.33.1756908736097;
        Wed, 03 Sep 2025 07:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHMMouH+0cy9pnDYVwpeG8uIlzVJY4DB/KoTItyUFm/aiTV0vf+tT+RUYzKOqzzuFOlNaTkg==
X-Received: by 2002:a05:600c:154b:b0:45b:9961:9c0c with SMTP id 5b1f17b1804b1-45b99619d89mr53049005e9.33.1756908735548;
        Wed, 03 Sep 2025 07:12:15 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm10974053f8f.7.2025.09.03.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:12:14 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:12:12 +0200
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
Subject: Re: [PATCH v4] sched/deadline: Remove fair-servers from real-time
 task's bandwidth accounting
Message-ID: <aLhMvNI1Loy3_jFT@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903114448.664452-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903114448.664452-1-yurand2000@gmail.com>

Hi!

On 03/09/25 13:44, Yuri Andriaccio wrote:
> Fair-servers are currently used in place of the old RT_THROTTLING mechanism to
> prevent the starvation of SCHED_OTHER (and other lower priority) tasks when
> real-time FIFO/RR processes are trying to fully utilize the CPU. To allow the
> RT_THROTTLING mechanism, the maximum allocatable bandwidth for real-time tasks
> has been limited to 95% of the CPU-time.
> 
> The RT_THROTTLING mechanism is now removed in favor of fair-servers, which are
> currently set to use, as expected, 5% of the CPU-time. Still, they share the
> same bandwidth that allows running real-time tasks, and which is still set to
> 95% of the total CPU-time. This means that by removing the RT_THROTTLING
> mechanism, the remaining bandwidth for real-time SCHED_DEADLINE tasks and other
> dl-servers (FIFO/RR are not affected) is only 90%.
> 
> This patch reclaims the 5% lost CPU-time, which is definitely reserved for
> SCHED_OTHER tasks, but should not be accounted together with the other real-time
> tasks. More generally, the fair-servers' bandwidth must not be accounted with
> other real-time tasks.
> 
> Updates:
> - Make the fair-servers' bandwidth not be accounted into the total allocated
>   bandwidth for real-time tasks.
> - Remove the admission control test when allocating a fair-server.
> - Do not account for fair-servers in the GRUB's bandwidth reclaiming mechanism.

However, it looks like running_bw and this_bw still account for
fair-servers? I just checked with tools/sched/dl_bw_dump.py and can see
their contribution showing up.

running_bw, although, also influences schedutil decisions, which might
be something that is required, as maybe tasks can still be starved if
the cpu is running too slow? Not sure about this last point.

> - Limit the max bandwidth to (BW_UNIT - max_rt_bw) when changing the parameters
>   of a fair-server, preventing overcommitment.
> - Update admission tests (in sched_dl_global_validate) when changing the
>   maximum allocatable bandwidth for real-time tasks, preventing overcommitment.
> - Update admission tests (in dl_bw_manage) when offlining a CPU.
> 
> Since the fair-server's bandwidth can be changed through debugfs, it has not
> been enforced that a fair-server's bandwidth must be always equal to (BW_UNIT -
> max_rt_bw), rather it must be less or equal to this value. This allows retaining
> the fair-servers' settings changed through the debugfs when changing the
> max_rt_bw.
> 
> This also means that in order to increase the maximum bandwidth for real-time
> tasks, the bw of fair-servers must be first decreased through debugfs otherwise
> admission tests will fail, and vice versa, to increase the bw of fair-servers,
> the bw of real-time tasks must be reduced beforehand.
> 
> This v4 version removes dl_bw_fair, as it is not needed anymore since each fair
> server's bw is now checked individually rather than globally. This is necessary
> because different fair-servers can have different runtimes. The bandwidth
> assignment is sound only if each CPU's rt-bw + fair-server-bw is less tahn or
> equal to 1, rather than computing the total and checking if it is less than or
> equal to the number of CPUs. The check on deadline tasks can be instead be done
> globally (on a root-domain basis) as dl tasks are allowed to migrate between
> cores. This new version fixes the error reported here:
> https://lore.kernel.org/all/aLa3zdmyKuRMy3bm@jlelli-thinkpadt14gen4.remote.csb/

Thanks for looking into it. It seems to be working correctly now.

Best,
Juri


