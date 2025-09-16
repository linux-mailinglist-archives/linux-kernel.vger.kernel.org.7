Return-Path: <linux-kernel+bounces-818176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79AB58DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593DC7A96AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF72C11EC;
	Tue, 16 Sep 2025 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb/XEjSq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5980296BC0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000550; cv=none; b=F+JgBCZ2RgwYeXwDG5gYf/HVaJq4f8XwzQobisVOmkcQ7kAjt3EBh9zAFnDoZkrT0/Ce6hvEe+KB04HiNKgMIDF1DzZqtReRBVCJ7ikynAQ4nJ/npimiV/lv4ucByCnPzChKs+7u4F66HCOl8Zs7/s7grq/qHjMzImTbHFTeRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000550; c=relaxed/simple;
	bh=BKHUIrqFsuvwuTWnQKw5vJZ5u30AF4W8i4vNBpyVBWw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JoKkPRUJU0h8fLeRhTu27vFZImnk4sfwuwTUMYJ8aTA+NDqawvRYpuAaT8z2UGBr73OilN0w5UfGSMn2M6rXAbWCZVfWNHuzJuRSWdWKJj5IyGBPa+6gFu+C3HZPEadws14/0zeW2Sh+haExNZkji4V5xDN3j0UguvLlkCePyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb/XEjSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758000547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKHUIrqFsuvwuTWnQKw5vJZ5u30AF4W8i4vNBpyVBWw=;
	b=eb/XEjSqMOLKGY7HYZoggLaiF8rNBMit18jrdAbuqQnwy2h/qqFGYYWgwY1OMB20ezWz9P
	hN/B5mrcGWr/igGRMgDN51OInU+rupx6TMP3okc6MiI6QxSSY0Xi/Q0gXxomiTgM+Aq0di
	6OcxUp5wGf67UZJ/z0ftniUJfbS9Tqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-t0by3uUvN12ZMTpT98eFPQ-1; Tue, 16 Sep 2025 01:29:04 -0400
X-MC-Unique: t0by3uUvN12ZMTpT98eFPQ-1
X-Mimecast-MFC-AGG-ID: t0by3uUvN12ZMTpT98eFPQ_1758000544
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso18632205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758000544; x=1758605344;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKHUIrqFsuvwuTWnQKw5vJZ5u30AF4W8i4vNBpyVBWw=;
        b=ePI1mZfZIR3jC/CrrSXc/cuHenOOEJh4HdGCciBt0CL8d9+zaPRO63hLLjz85I+8H+
         sYd+48CWFYQTmd6JCfekVEo/UHZL9Ql5B0fXcUPfo96kAhCuXG+KSkzucpyxKBYIywlV
         sWyQzlSRBXVneglCFZJF0Y0L+ADnrMIyTi+SHP6lnKSFeqkmGdayWhipfDbGJqZlZ7oa
         72tu+nAy6Eld6QwvDkaYNtW+VbPCVhevemOxGzDPFZXMMlCxQfMywte3mQ1B+ZzSiTxg
         deyOJGmgt8tPl01TWJ2yn6p2T2raKfTgd2YKWOSyU6eentcWpF+3ZqwfvkkeTz1mloag
         iYvg==
X-Gm-Message-State: AOJu0Yz33pHnz8z++IfsA9mTiGqzIkS0pQSlj4MDYb/nXppbbgpDZdtF
	Q9N0C7rG2CVRSSZzeHzGladW4ZDikfd0l/gEK0Mr4jteS4NgP2OwTORStGP7Vv7yhcAJdkSvoiG
	Ax3dvmobUsDF6ztCFWOTzM+6ue51y6jolDvyHwaNvfMMm+NM+jzEsWe7zXBlziRxD1A==
X-Gm-Gg: ASbGncu+lytdv9GJU9Aec9dX79A3gUPWnHSoxurMayJL/dqF9p06eP6yHYwmznkCduD
	6ZBYLtX6ppJcn/AEzzV0N3Wz1rbF47Qk2zxkXO/WpiWqHrTZPtRdUVY9R3nD2oerSw8DY1BKRAm
	Vp3cvCawpU+MSEXOYY0UfC/JJOn8R5zzkv2faFvkhnpi0oEjI4PIVC++U5HAh6BFfVolWCsFQ6+
	FOcP6AxYaesYdksmk8U7wx+3AUz5Slqw5Y0vPacW5SuK7vnQ1YZX5CdcsFiYn398jvojEEy+4SW
	PwlB3FwPsA0AyU2AgBlRN/wPCummTWog5Rqp
X-Received: by 2002:a05:600c:ac4:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45f211f6a79mr84634725e9.21.1758000543712;
        Mon, 15 Sep 2025 22:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzLzcxfLcqGiZREnvnjRs8fUJKZdnoz2ZmiZpt7eoK0q6w1p4bhVVaML4i8MFbXJZn3wIKGA==
X-Received: by 2002:a05:600c:ac4:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45f211f6a79mr84634625e9.21.1758000543353;
        Mon, 15 Sep 2025 22:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45edd9f75d1sm184329185e9.17.2025.09.15.22.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 22:29:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:29:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Message-ID: <59a5840f-2754-4478-8c4d-ffca02b1ecf1@redhat.com>
In-Reply-To: <aMh8Oq6El_xV9Ls4@thinkpad2024>
References: <20250915145920.140180-11-gmonaco@redhat.com> <20250915145920.140180-20-gmonaco@redhat.com> <aMh8Oq6El_xV9Ls4@thinkpad2024>
Subject: Re: [PATCH v12 9/9] timers: Exclude isolated cpus from timer
 migration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <59a5840f-2754-4478-8c4d-ffca02b1ecf1@redhat.com>

2025-09-15T20:51:21Z John B. Wyatt IV <jwyatt@redhat.com>:

> On Mon, Sep 15, 2025 at 04:59:30PM +0200, Gabriele Monaco wrote:
>
> Your patchset continues to pass when applied against v6.17-rc4-rt3 on a
> preview of RHEL 10.2.
>
> rtla osnoise top -c 1 -e sched:sched_switch -s 20 -T 1 -t -d 30m -q
>
> duration:=C2=A0=C2=A0 0 00:30:00 | time is in us
> CPU Period=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Runtime=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Noise=C2=A0 % CPU Aval=C2=A0=C2=A0 Max Noise=C2=A0=
=C2=A0 Max Single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HW=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NMI=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S=
oftirq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thread
> =C2=A0 1 #1799=C2=A0=C2=A0=C2=A0=C2=A0 1799000001=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 3351316=C2=A0=C2=A0=C2=A0 99.81371=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 2336=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 400=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1799011=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 23795
>
>> This effect was noticed on a 128 cores machine running oslat on the
>> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
>> and the CPU with lowest count in a timer migration hierarchy (here 1
>> and 65) appears as always active and continuously pulls global timers,
>> from the housekeeping CPUs. This ends up moving driver work (e.g.
>> delayed work) to isolated CPUs and causes latency spikes:
>>
>
> If you do another version; you may want to amend the cover letter to incl=
ude
> this affect can be noticed with a machine with as few as 20cores/40thread=
s
> with isocpus set to: 1-9,11-39 with rtla-osnoise-top
>
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
>

Thanks John for testing again, I'll mention your results with the next vers=
ion.

Cheers,
Gabriele


