Return-Path: <linux-kernel+bounces-740824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F206B0D9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665C83A7971
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2824167C;
	Tue, 22 Jul 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkMOPEzN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF09DDC3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187518; cv=none; b=K+z2lzSIWvQoO5DO6sNfre3YKf6mz2kRdFRAe6WD09uNe62d8GaD7IHFivOgbWbbBzQBNKsFR+nTvMIy98Su9LGN7FAWmZq9lsBbOoV4F3x/yAl1w4ipge19jcNsl3HQZaHhL7MzBa5ZVaOQcEqfBPFH8/hcLflaqbC0T4l0P9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187518; c=relaxed/simple;
	bh=4nWfOgAtDJRiUKwl4CEAmak9LoVjK6F6e7GI51ynqlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2N3BGEPuxDBa9fE7eyzCbDRjFli0bEG55ECFRcDWBlcgWIMHMCEvV9RscDO7aISBsqNPCbn/YVQhu9EZ5IKaDQxrz/EQR3PZl/lFVLnXR5hDZjCbPeKUXd2MWcGb4peDgC03snn7Y4WH/bm9fCYMIEUsL435QINBVSlberX/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkMOPEzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753187515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uytWltKrstTEMZ/fxOMVemtki77h53KI7bgXkDpu9yg=;
	b=QkMOPEzN7/305ZoIwpcWUL68oJ/qZcpeyyeMfIgd8qwUCDT48zjMQ2yr8fC7YpfekR21k1
	9mFNby79dfgO4gYQoal5jWE/MCWS38rF5R3itVA9tnIJonYBwPRtqGHtdI+8GMQ0NMwJ3G
	PYvLX7ZUkOyHb96uQupF5ZwLo/g4X+c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-GWesnsSoN8W22w_9CdGkmw-1; Tue, 22 Jul 2025 08:31:54 -0400
X-MC-Unique: GWesnsSoN8W22w_9CdGkmw-1
X-Mimecast-MFC-AGG-ID: GWesnsSoN8W22w_9CdGkmw_1753187513
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45639e6a320so27556245e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187512; x=1753792312;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uytWltKrstTEMZ/fxOMVemtki77h53KI7bgXkDpu9yg=;
        b=j+mlPq8H1yXtT0fGlPw2IVol29s8tcjbt/yBc0CECsYUqNIFJsbplrJLA431yy7ZKW
         DP115pB7+adULq/UGiNqFcTFu7UVjpdLTfuyf2kXT+caEAV5HuA8j1fSAvm2vdT7+Sfk
         DG7zzRlfslQQM+9dtQMcfdQktEFNf5sn4gCwbUQtTkn/tdzOvnK5j4ydjVFdkcFT82JN
         9kF6jh7XXMUETlgj4VO6whTogaMDtMQ0IpQO7mOX1Q+CNTSTW6CYC6E9cFQK2FkBC/Qh
         MFyrb41IqMScJHMU7dcvjRoCFSE/hJJgsUNHSyNAp8ZL0R02iOyD1gRBKyM7s1f5qeoN
         RTMg==
X-Forwarded-Encrypted: i=1; AJvYcCWugeJtnPzM+eGToQmY45yZgZUTiNDyG7x9v982zZVteS9MuN9t9WAGhEtC7UJsJflRSF8238KHIb+M97U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpA28zrbvRonica95HVRAxExO2znnUhfvhqd59NmRib8vWMUud
	Jq1UXXDuF267nWOXvZ5OE8FZKekK4EqyQ0ykkejgTFFoBzyq64jcVma2bs4YdNIFD+hhfJLEm7w
	sv9QsjhdhTVuT7gUIlh30sJ984r0v9rqhFgjCE/iONarLUA+aDPFRn8iDBOf/NeEmaJwpiRToVg
	==
X-Gm-Gg: ASbGncuryhqiNLt2XVW50petrSQ/O74DFT5XeOo/klooK3zF7S6wCI2inRHXW8k11TU
	KC8m99A3Yo+sOWdJVx4ZUxZBm4E9+nltR8efFVNWL6TMZKA7yhp2/WGYzy9xHnyEgw5RiDKhgr4
	v+VrX28xuhi8rXu4bhmdOeqfNhWjXRafOIPXflCZnhSV//caCenDcZpHRVF2DjicoP3UEzxGNyU
	glOOxUTVvPCdDvQCI0m+u4zbSWhZV82+ozkHta7MK6XOWTJtwZw5RhjvlDNpXlAuZFWNd4N5ryy
	/kviPss2oSpbZiFT9aRafKMi76X2D7HYwPZ/G1KClK4RDElEF+ljlVB6VpjcbEn0QZNMOGLfRBM
	zu+JLgZK2o5CQ/nyDd30t8SnZ
X-Received: by 2002:a05:600c:3e09:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-45631f87c31mr181301185e9.23.1753187512486;
        Tue, 22 Jul 2025 05:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4my1j/WYJuwr9m+hNLzJ2DZBCwfcZJAPgIp4WhpZ9p0NPXJOwuF4NQsIbzxcCa/EayJOxMg==
X-Received: by 2002:a05:600c:3e09:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-45631f87c31mr181300905e9.23.1753187512054;
        Tue, 22 Jul 2025 05:31:52 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm187616275e9.33.2025.07.22.05.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:31:51 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org, Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH v5] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <20250722102600.25976-1-shijie@os.amperecomputing.com>
References: <20250722102600.25976-1-shijie@os.amperecomputing.com>
Date: Tue, 22 Jul 2025 14:31:50 +0200
Message-ID: <xhsmhpldse79l.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 22/07/25 18:26, Huang Shijie wrote:
> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
> iteration count limit. It is however set without the source RQ lock held.
>
> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
> as observed within detach_tasks() can differ. This can cause some tasks to
> be unnecessarily iterated over more than once, for instance:
>
>   env.loop_max := 4
>   detach_tasks()
>     // Here env.src->cfs_tasks only contains two tasks which can't be
>     // migrated anywhere, so they're put back in the list each time.
>     env.src->cfs_tasks := [p1, p0]
>     // The iteration goes:
>     p0; cfs_tasks := [p0, p1]
>     p1; cfs_tasks := [p1, p0]
>     p0; cfs_tasks := [p0, p1]
>     p1; cfs_tasks := [p1, p0]
>
>     // IOW we iterate over each task twice
>
> In the Specjbb test, the similar issues can be caught many times.
> (Over 330,000 times in a 30-minites Specjbb test)
>
> This patch sets env.loop_max only once RQ lock is taken,
> and uses busiest->cfs.h_nr_queued for setting the env.loop_max.
>
> After this patch, I cannot catch any above issue in the Specjbb test.
>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


