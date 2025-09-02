Return-Path: <linux-kernel+bounces-796848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07982B40843
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58551B6574D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8783128D8;
	Tue,  2 Sep 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG5V3oGP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A730649E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824932; cv=none; b=V0owhdeMO6avsK4znOYp1yWhliAHaW1jcQIgTFuFUYveh3k6PV6Apo5WU+bPWOX007pLl3Oam9xqs8X3a78gH1ivVOdGSFlZ3lSEIJwx1bN0lxWpNT8/aipf5zFb2d0QceZgvVYtrFzHVWIKfU5YoTAHZMM3NP55lr8/0Ene1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824932; c=relaxed/simple;
	bh=x91AmagGFMOtZuXmG4RqVXoVp9qcPc0XFnUmaJ/YIm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSsb/Q0dWhxihNfifa+bswv7ubQUst/VS1+PssIG7J4B2GZneeMgjgUcjKYp8IPSoZA27m0j2IecOWt0G9ipG2MHtlVSVBV2mtqJrbuFOsTs8joQlhQM3NtGFhdGAq77TQ2iZQ8OZ5uXl7+/9HgevIeksbLwslhIgEOMglKGh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG5V3oGP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFNwloMDDAvR9YVWd6AQKio0WoX59cEAVHNiSQ9F17k=;
	b=JG5V3oGPAW7Pqy3B3w23JLsMwVryzUl3BltEyj6o+YEagQmLlhbBoYoRqcU+1oLgju+GIf
	Sz8Ip8nb8S02yTedntoz+icVuhn2jJdqL6l5d8joNIZkpeJeUjhGa1VoyQknfAUBRGASm5
	nItjZXNXVI+W35y6c8usMcG4FkuRDIk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-7HdKFzDAPWuqPPm04PdaAg-1; Tue, 02 Sep 2025 10:55:29 -0400
X-MC-Unique: 7HdKFzDAPWuqPPm04PdaAg-1
X-Mimecast-MFC-AGG-ID: 7HdKFzDAPWuqPPm04PdaAg_1756824928
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3d17731acb6so2937407f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824927; x=1757429727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFNwloMDDAvR9YVWd6AQKio0WoX59cEAVHNiSQ9F17k=;
        b=IK8LQ8qduQMIjiY7oswvyZJE/9Em7GQaWWtbFY1u86TjnjarN+xaAWmSV045NJgjza
         QtjMhgShzXX/6yDEWRKQtz87PwvmPP07bvwbXpkKQO05IsF9VgsDyK3fSe/V94NDuWM6
         4+8j7bcmnT1b3f1CEAkNmYyVpfGiMU4wPD7nMxdQyOf4v8xeIH7Gq76slvoFIiMN/PMH
         M+KDEl5cz05VCJsHO1cZjg//fya3DF1akv0Yxbpdbv2NuNJJhYjmhrXJOcOkbT6rwLS/
         7T69hw+X/p96uS84CQy8PGQ+bpTjGNPXNddL7OcUlW+7XaRO8Rxq9BrBEaF9M48zJKHO
         q3dw==
X-Forwarded-Encrypted: i=1; AJvYcCUOfnL6Qn5DTHpV+HJ5xy8IsbjXoyBNNJVSQyXbxP+QQzA6EkkeziM+WS1UjCJIveD63o+bQESh6N9CH5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ln/GP3jJVsKwN+bJvlGdQPdomdrQA+q/LsHIoTOt+ncIEagg
	7VOIPzZZjKBnXphcGuFgQaXAi4vtFMNx0xOkajOCmzZrwened6RFotPe2sA+X0Zwq8ZKO1YcY19
	Mo7RAhLuvrhRI28osRzvcK0imWWeqOdWpTIrpsB5KWeh3vvhhrv9Oes/1Gj0hfu3MkcZC1PfPFt
	Cs
X-Gm-Gg: ASbGncuzLZHk/D2MAFZ6R/i4Yc/V+cEu5JUjG4AA0PIbta63PoxylGuoS6uWrMcYw/P
	0q60HqY0IF8rzeVInIsQqN7Ia2oSvUM/6w2B74JQZ0p3jNqZLJrMMTd1wOxP01E0Pgbe2IZD3Cn
	R8Q0hcpILnWe169O43UVeyzPRmMEdPzv9qUpclin4/0B5xdpYsZi81uIqouGeL9WF6uivvoNuMq
	1cme0IbJwdwLB7Eij0xsLJkTITbhDTYeeI81XCRtOavjbISaXP7aoboxQznaeixc2CDF6y22sAa
	kpMs0Ecskp0oNARQKVcBjXZsgPs8DZ7mgREaU06sRmrsbjOhOgJZyfeCzJGiI59qI59ZrrE=
X-Received: by 2002:a05:6000:18ac:b0:3d8:3eca:a9ad with SMTP id ffacd0b85a97d-3d83ecac1femr4388631f8f.20.1756824927350;
        Tue, 02 Sep 2025 07:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr+eQvFvHKDY9pW1QWHP+fNzpn5umUflMtRnLW1mu9VwW/LAlTg4kdk2oVrowt/ttwr680hw==
X-Received: by 2002:a05:6000:18ac:b0:3d8:3eca:a9ad with SMTP id ffacd0b85a97d-3d83ecac1femr4388298f8f.20.1756824922871;
        Tue, 02 Sep 2025 07:55:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add294sm21363639f8f.29.2025.09.02.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:55:22 -0700 (PDT)
Date: Tue, 2 Sep 2025 16:55:20 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aLcFWBGfeET6_KuO@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
 <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>

On 19/08/25 16:02, Juri Lelli wrote:
> On 19/08/25 12:34, Gabriele Monaco wrote:

...

> > > As per the whole _tp() thing, you can attach to the actual
> > > sched_switch tracepoint with a module and read whatever you want.
> > 
> > Yeah I believe Juri referred to model constraints on the already
> > existing events rather than new tracepoints here.
> 
> Separately from this series, maybe we should put such a module/bpf thing
> somewhere shared, so it's easier to use it when needed.

Maybe we could

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 383cfc684e8e..994b6973d77d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
---

so that the new tps can be used from modules like sched_tp Phil
mentioned?

Thanks,
Juri


