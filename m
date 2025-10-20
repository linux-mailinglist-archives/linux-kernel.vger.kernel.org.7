Return-Path: <linux-kernel+bounces-860518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B0BF04EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF234ACF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB623EA82;
	Mon, 20 Oct 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diHCGmFr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DB238171
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953800; cv=none; b=cl0E08mam8LCwWeaHp7IDfPlI3QCK3y3UHMj+dFRCHsq55Lvk24JKhuDkqTz8Ie/N+YtpRDeWHyuehRqPDCv4mxKaf6I/4Dweh0n026qOCvM4OVIXebMAi1/X8xtG8lZTLFQygKkpEvLc189c96fx5OvlPZY1smZBfE0u13zfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953800; c=relaxed/simple;
	bh=L88CURN76sT3+kKjYcMn64mems4KIaIBpiqCE7sLYgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkcYNaYuBzycF94ZHERPBIellk3nxPKu2QeWMDwAf94M0FOAckTXfFRqNuQanzUGRrTccfzaHbS+EvcNr9wMktCrMXTFUhZ8aWoWpAWckKQU/DssyiHMTrXjeuxYAQ+drGavq1yn/NeCfBtrOILGtyWo+3M6Z/2lPmApaFucxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diHCGmFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760953797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFTTrhJcTtAwy2zqRcI97c2G9J1jPFu8DQY9tZIK604=;
	b=diHCGmFrFi90oKz2i9vdPD5ZZ6Mf9SPMhiRmgZrOmszySw/IfXmXyJa2lYzJ7UTzpS4sMh
	FXMUtNS43s25qmSLa3jogjnVKPGaF22NBFP9pqGqrnGI1BahD61XCO6dhjdoeJWRPBvqyc
	XEnLAQXK5+0FmdaGhcMFCxr7GUDUodo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-oHvSwupbMCe6QTYCaRR3MA-1; Mon, 20 Oct 2025 05:49:55 -0400
X-MC-Unique: oHvSwupbMCe6QTYCaRR3MA-1
X-Mimecast-MFC-AGG-ID: oHvSwupbMCe6QTYCaRR3MA_1760953794
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4284525aecbso1377502f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953794; x=1761558594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFTTrhJcTtAwy2zqRcI97c2G9J1jPFu8DQY9tZIK604=;
        b=XfEAzYkW62P510e261uPY5WbBWopvZ4abwtcF09ysJSZ5F6Ts40H9SrcXraHcAYC4n
         qwgdTS6OK2kq92xRbXheS7f5dBqCF8z5QCyHPjxwGQREdZWgrYiTyHEilddurC7RnsdN
         tJiNpqvALzZ6vpZ6qvyyDNiBhAYiqTYd3P+RjkOGLqZ866cs+71B3It20ri9bxPU/EMq
         gikELV7Gol3cdHmncyO/mSJIfvF+/2NCMY/j2zkfcy3bx/bhW4JFKohjoyqnmpwFqGG7
         czXH1GozmI4FX+erPICU9Rf2ykB3WS3rIRw3I1bIz3edEKrKx7DCemM3ESmwcpFzIyQe
         //+w==
X-Forwarded-Encrypted: i=1; AJvYcCW+N8kzm197fcF43o2IJ4IWIiVB2lspdoQ8bqVuNSpJXJBbxiqW3M6VscDeEHG7wZWYd65CdAZuqdj1ZKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Z+On+5jzZR3oYs+73FNcNuuzrG9HVR/X5ToSGLMuAZGFFmEt
	2iZDyd7RQt3jDGN015jRBBFCvc05s2WtaKTG19tT5L0Cn91SRj28rA9bSHMX9hv+qiGnawyqijE
	ZS+s9UVCAviKIpgeMHmMmNIiCoDmjwhnUjtIJUyJ6Q9MjP3M1ieTt3KdwyUWYJ+iX1Q==
X-Gm-Gg: ASbGncsLKHKXu7Me2edgxG0cQNSkYKxeaeR/tU2ObWRU1qIJZKCHuFlfmsOOfg1v1R/
	Xq2i8mkoAFTEjK327q5l8Qqu/+4i9HxL/ldydm6B162LQ/V0V5YcgZeOWWLCxQBdPZKtsZd0NAN
	hke4uc9anoi6OIsEMfezzoPf0f10D7QZvzPgmMsp4r2fNByxLIOyUe3OaRSFvBFEx+CpkfW+S9I
	VdYF2x27JHUB4Qu1OWYLSw+jth+ij08K8V9yDS+XUwt0VmKewssBPgMVtyU4Jgsn3hNm+MVzc8Q
	SXZE3hO7iVffrWZ6ditLIxyNpYbvPHaCaqEWdA1gjbbw054eTf0GbchppakeC8UXYUuw2LPz+lO
	wA0ofoa6PsHrrB2d08tSbsi/GSpk4lEk=
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id ffacd0b85a97d-42704daed04mr9407323f8f.38.1760953794293;
        Mon, 20 Oct 2025 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEircX9r4vwBahUAWz08Ch5Vp4KLieMSMxL6ClC8S+P82LJBqd/Fmi99o4l9qj8yYvXucqwnw==
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id ffacd0b85a97d-42704daed04mr9407306f8f.38.1760953793898;
        Mon, 20 Oct 2025 02:49:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm14899561f8f.29.2025.10.20.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:49:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:49:51 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-5-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Hotplugged CPUs coming online do an enqueue but are not a part of any
> root domain containing cpu_active() CPUs. So in this case, don't mess
> with accounting and we can retry later. Without this patch, we see
> crashes with sched_ext selftest's hotplug test due to divide by zero.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
>  
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	/*
> +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> +	 * with accounting and we can retry later.

Later when? It seems a little vague. :)

Thanks,
Juri


