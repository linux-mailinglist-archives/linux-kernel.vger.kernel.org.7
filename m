Return-Path: <linux-kernel+bounces-776953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC2B2D373
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820031C25709
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9349B283FDD;
	Wed, 20 Aug 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSr3zKHE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E108283FD0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667212; cv=none; b=Kw0K8RkRwxI3uy4aDRrx96B/rUCNSZ4JXpZslz/5FSTDKZjmL1qOpL0CpDMiGbjBDN0dEweBC9pLCZzK70dcW+dqzeVSfNxTvtXaMrCxRodtQf1+dDXhAoNrfas6gYkB+iV+krF9+bdZyIuEdH5ciWcvLY1PRMMLubljE/UzCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667212; c=relaxed/simple;
	bh=8L6xU9g5KoJQAjxkNUL9KSZwhdgL58+kV/17rMqhyes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRD9miYFFG6S0JLkLaEC50A7q1Ai5UC36vFAlkLTFftlKB7ZXi11wIZObfoLTTCxST77839RMZvEM7v2DgVROO0n8WTM0YN9q4N0oHDV891XIMrhq/RyvVBqPbh9x0XqdgiFpE+mJMiwf5V0dK9ODc7L1AR1A5J//xCJQG+cyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSr3zKHE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755667210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ah9GxSMPJfdjLyXj5m0xcjCzjb8lydcS1ejzqq61Uk=;
	b=aSr3zKHESDPs44jMb1rVOtsDb1SIlIGyqGW509aBQSCWAtERUKVJkIs4JPiiyZiQ9VIy6e
	nrj9t6sW3aI9jsyIlb1dD6OvLlFuNKhsPM1xBT28RMk7dAwz2EZgPQcPq5v5o/OXozJK5I
	sm75/SiAP6bbITrZext4rITXEGUhuEc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-8OmHXYvdPqyzvVQ5LRECqw-1; Wed, 20 Aug 2025 01:20:08 -0400
X-MC-Unique: 8OmHXYvdPqyzvVQ5LRECqw-1
X-Mimecast-MFC-AGG-ID: 8OmHXYvdPqyzvVQ5LRECqw_1755667208
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8706202deso1607351185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755667208; x=1756272008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ah9GxSMPJfdjLyXj5m0xcjCzjb8lydcS1ejzqq61Uk=;
        b=V1VTCxTJD8HjgmhI7ujhVYhNu2SiHz4IeCZSjBRkW+ev+g5y8Jgjb5/u8VSUpInzwn
         4/mNXw8exkHP1Bgn/UJyru1O5VKVOZkx8DJnVBCdQDFJE57Gh7zVge+pabymcqgBRstg
         C4O3fy+cm95crc/sriyJDXAgS7Rpelkpev7ztzZoqsUi4biDGNH3FnV6LBVud5ud5sPF
         KKSqi0pcUrI2+a0L/pAqVMdN6Kw5LiQiqC+02PFvliIBiJUOKNshGRRO4l9QiWlkE4dk
         AFasF/Af9WqoPUoqMuBti+B6WlsN6efC9HWVISW1hzDzQwxiFFAm1gHD8VEJ04ToQJrr
         rmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu8yMR4fsGRIhpBEJU9e/g2r/nOASol/tuGkNmQFANtOH4wUWBaV89nUYjG63rC9vKdLkdZqJ9W/y68C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTPTDqqXReFxSc1gDDR6RXbm82pZnkQ+WpAqtvF2z+G8jQsUb
	mSkYPqr8HUu/OnUqWTC8QEKfs8eN0J04HQ2ZDwEPkhqATkX19zFh76ykcLjKbJKsPjP9oujU4Lx
	d+2GQEdSsnvQUluxtXjwlaT+uHh6OiyaKbQZ7NgKvZ4L3pwiZH34Gmk5PNLuzJySHnw==
X-Gm-Gg: ASbGncvZFviW8x8bJ8a9qltkhq6hXnEVqEuZrSJvYazGczYOydCfttkUMazCwDXklRX
	AlGdVsnr7U0HKKBf3J0CUxBRuy2nU+O2Uq1E2AXKdLBsDqKP+wqLa13X1wnmGwE8+C3m1E1L3YW
	BIIUcoOUKhutLpDOHAerhUT54knzOgciN8REa3HtmTbi1kyKnBu3LGJdKS9h7C47LJVQ30cb7AO
	rqBGsMjXH1vI3OzDJJSXQ8cXGnfobdeE0vA20cKoPskiSIHgNrIONaqfAsz1yYRJDAsnTFUoBFL
	CPxIiX2Du6bPc+IN+u8g3mn3vdC7xyUMsiGmaeE5GYFZoMNl1rcq50MHcTAFyruLjSDl
X-Received: by 2002:a05:620a:4410:b0:7e8:2998:51e9 with SMTP id af79cd13be357-7e9fcaaa54dmr177401285a.32.1755667208061;
        Tue, 19 Aug 2025 22:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHENpttOb5Oa0vbXSaecXzwbSoqFX74Eh9EpBV66q/UJJaR/79Mf7XF8zMF+IdE6uYsCj3gJw==
X-Received: by 2002:a05:620a:4410:b0:7e8:2998:51e9 with SMTP id af79cd13be357-7e9fcaaa54dmr177399385a.32.1755667207630;
        Tue, 19 Aug 2025 22:20:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.50.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0224c1sm900340285a.6.2025.08.19.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:20:06 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:20:02 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aKVbAnkKnvQ2OyUA@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
 <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
 <20250819143823.GB282929@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819143823.GB282929@pauld.westford.csb>

On 19/08/25 10:38, Phil Auld wrote:

...

> A few of us use: https://github.com/qais-yousef/sched_tp.git
> 
> This has all the current scheduler raw tps exposed, I believe, but would
> need updates for these new ones, of course. 
> 
> I have a gitlab fork with our perf team uses to get at the ones they use
> (mostly the nr_running ones to make their heat maps).

Ah, cool. Didn't know about this, thanks for sharing! I'll take a look.

Best,
Juri


