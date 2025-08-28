Return-Path: <linux-kernel+bounces-789548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09CB39720
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966F63BC012
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F72DF6F4;
	Thu, 28 Aug 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSIj3JEa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E711E47C5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370217; cv=none; b=jUh1oNv+VeBd+i6We9DPFufJgxL0SKayfeyJrt7Oe1By0N3jr9Ld9N/Jkc07RpNmmoNcMxRGBXxDQE2umWQO8Ar5RFRX63iK16zCZSCgJAW5scNRMBXJY2hh/kiJo5rZP1W6e+4bnFUtOzl+kmHZ49DXNNJtD8j0LYYe3Irir+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370217; c=relaxed/simple;
	bh=LmaLKvonrFOaNR/JamUgWZ21QHYRvQzQF4OZeBJIXrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlA4DM2axsW3+Iyxq2JszO8oOIPjg0GeIpsieBFG16h9BmiSCQzhTf0aQJlpcs4GSUh4XryDnPIlEpqopUr6kc1GRZhDNSd0tB1k4dfeCtWL24N8j7dqlnaAkZUP9bnGAgCryBp4wbMT7TFbl9fYeXfmHQqvNDKXHyagXT1yHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSIj3JEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756370214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PSjUmvSnzhT5n7A6inv7FM9jaAvFvhockhlgWAqu+vQ=;
	b=BSIj3JEaXG3hdlXpCskiLYgwykCmTEzr8+Zc+q2f/FJ9l9Sk+XFooV46a9pzMJwqPm4HSY
	vNp8UvbiZhOX+tekwg0XJ3s9MawcNptsseFeFDhDBN3BuVgYzJSt4qrA4iiLXhsnCU7aLB
	gpI0GixZCEp3gC6ACIDQuVR6qdwT8JQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-nZXPLhZtNlq7aGWonlyznw-1; Thu, 28 Aug 2025 04:36:50 -0400
X-MC-Unique: nZXPLhZtNlq7aGWonlyznw-1
X-Mimecast-MFC-AGG-ID: nZXPLhZtNlq7aGWonlyznw_1756370210
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7f674810d8dso170732985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370210; x=1756975010;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSjUmvSnzhT5n7A6inv7FM9jaAvFvhockhlgWAqu+vQ=;
        b=kT5Ns5+bAmYs1wrQ74TU30/QjHs6eFSn3ItL10LJ1O6G89v9gR4EaSFfW0MORT2BqF
         AQ1ryAAIdMEsU3sdVzB5es3gtapa2IrcMN7HcxUXqv+QQnFYaUbEPjjWETOGNxjXSZ7V
         CYAdyC4CAdG3IXhP7Ie9CbvPh4d41UqAknsOXmduJnqn+0d28M1It5KtCXoKHg1t4K1L
         p79sHoDJNmn4FbWoNqf3hDZa7ejH1Sh0pgrFmUjt4VQpesVD8wsmYvWykux2T7CS+lIl
         h+7fshuYpecg3pMaukcFlYAz7IVZXHvcioA4aVGla+hvYoYst77nbwwH8Kg3M6hQe9jE
         tqFw==
X-Forwarded-Encrypted: i=1; AJvYcCUapo//aSN3r0knrV5/FjnLlkCS6yOczDLBa/P5+eWUoJmcBGlNKyA8Lkn4lU40FVwWwkdqdXQRXKI52z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCQzSSI66taMG2zsNQNcMj4/gMwan1TeX/CWX+0brAZgSfYJC
	11u1rg+w/61ZBKsL8E3YRCZiIG8pJE2yvAMu0HMqYJgw8fNaO4lQYmfSpZkUL5FKG4D3gSWHPwc
	L50JRJDNm+eNLK7jm60dBBYvJFLITXkBgcUPdHrTntMkq5K1RAPW9g16O7z2+udnQLg==
X-Gm-Gg: ASbGncsAQCs0vhIY4WqadNsjJ1GGCLpzpgTOBDFyjJ+ca7qHrk4uval/aFZvL9Dy+Ia
	6NIaCK9NZasE7rDAmhxP+INCjao9fo/rs9zzHfcx2Y9InafHsrNG7r6i20V1b1wCvmLMBuIwmRx
	RkBe5tnw5DwWkpIeAsouaEXifOLBOqSt0I9zNQyMcDpSRVKISGVXCHvfXpJHFHzkoQQ0FVxaykN
	ppuXa3KF9kOEE+v+ir+VsOSqyPRdVik2prYTBaQvs59z9JjjFCmFKB5U2wuSiXtkc41XS5UQFBm
	BEVJbUoPQucjGKmG5g+YHau8i4Q5H0WsMVYIPU6Jr8a33I1qxikrwEvu6qOZDkTkaA==
X-Received: by 2002:a05:620a:c44:b0:7e8:3f25:d8e2 with SMTP id af79cd13be357-7ea11045e0amr2099480985a.62.1756370210035;
        Thu, 28 Aug 2025 01:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsijQwZwhAabiy8jbQFP9pXJIeKs7UWvptIDHD0qC3IcBIpz6vw7YVR9JLPOiDAioox8BZlQ==
X-Received: by 2002:a05:620a:c44:b0:7e8:3f25:d8e2 with SMTP id af79cd13be357-7ea11045e0amr2099479685a.62.1756370209648;
        Thu, 28 Aug 2025 01:36:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed8911aesm1050432385a.19.2025.08.28.01.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:36:49 -0700 (PDT)
Message-ID: <10f2d5094a6c2dae1bcbf7d7f8198c11c6fce4c1.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs in batches
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.org>, linux-kernel@vger.kernel.org, Andrew
 Morton	 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Ingo Molnar	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-mm@kvack.org,  Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 28 Aug 2025 10:36:45 +0200
In-Reply-To: <7fddf82f-e85e-42c5-90f3-9cfca4d8756a@efficios.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
	 <20250716160603.138385-9-gmonaco@redhat.com>
	 <7fddf82f-e85e-42c5-90f3-9cfca4d8756a@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 14:10 -0400, Mathieu Desnoyers wrote:
> On 2025-07-16 12:06, Gabriele Monaco wrote:
> > Currently, task_mm_cid_work() is called from
> > resume_user_mode_work().
> > This can delay the execution of the corresponding thread for the
> > entire duration of the function, negatively affecting the response
> > in case of real time tasks.
> > In practice, we observe task_mm_cid_work increasing the latency of
> > 30-35us on a 128 cores system, this order of magnitude is
> > meaningful under PREEMPT_RT.
> >=20
> > Run the task_mm_cid_work in batches of up to
> > CONFIG_RSEQ_CID_SCAN_BATCH CPUs, this reduces the duration of the
> > delay for each scan.
> >=20
> > The task_mm_cid_work contains a mechanism to avoid running more
> > frequently than every 100ms. Keep this pseudo-periodicity only on
> > complete scans.
> > This means each call to task_mm_cid_work returns prematurely if the
> > period did not elapse and a scan is not ongoing (i.e. the next
> > batch to scan is not the first).
> > This way full scans are not excessively delayed while still keeping
> > each run, and introduced latency, short.
>=20
> With your test hardware/workload as reference, do you have an idea of
> how many CPUs would be needed to require more than 100ms to iterate
> on all CPUs with the default scan batch size (8) ?

As you guessed, this is strongly dependent on the workload, where
workloads with less threads are more likely to take longer.
I used cyclictest (threads with 100us period) and hackbench (processes)
on a 128 CPUs machine and measured the time to complete the scan (16
iterations) as well as the time between non-complete scans (not delayed
by 100ms):

cyclictest: delay 0-400 us , complete scan 1.5-2 ms
hackbench: delay 5us - 3ms , complete scan 1.5-15 ms

So to answer your question, in the observed worst case for hackbench,
it would take more than 800 CPUs to reach the 100ms limit.

That said, the problematic latency was observed on a full scan (128
CPUs), so perhaps the default of 8 is a bit too conservative and could
easily be doubled.

Measurements showed these durations for each call to task_mm_cid_scan:

batch size  8:  1-11 us (majority below 10)
batch size 16:  3-16 us (majority below 10)
batch size 32: 10-21 us (majority above 15)

20 us is considered a relevant latency on this machine, so 16 seems a
good tradeoff for a batch size to me.


I'm going to include those numbers in the next iteration of the series.

...
> > +cid_compact:
> > +	if (!try_cmpxchg(&mm->mm_cid_scan_batch, &this_batch,
> > next_batch))
> > +		return;
> > =C2=A0=C2=A0	cidmask =3D mm_cidmask(mm);
> > =C2=A0=C2=A0	/* Clear cids that were not recently used. */
> > -	for_each_possible_cpu(cpu)
> > +	idx =3D 0;
> > +	cpu =3D from_cpu;
> > +	for_each_cpu_from(cpu, cpu_possible_mask) {
> > +		if (idx =3D=3D CONFIG_RSEQ_CID_SCAN_BATCH)
>=20
> could do "if (idx++ =3D=3D CONFIG_RSEQ_CID_SCAN_BATCH)"
>=20
> > +			break;
> > =C2=A0=C2=A0		sched_mm_cid_remote_clear_old(mm, cpu);
> > +		++idx;
>=20
> and remove this ^
>=20
> > +	}
> > =C2=A0=C2=A0	weight =3D cpumask_weight(cidmask);
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	 * Clear cids that are greater or equal to the cidmask
> > weight to
> > =C2=A0=C2=A0	 * recompact it.
> > =C2=A0=C2=A0	 */
> > -	for_each_possible_cpu(cpu)
> > +	idx =3D 0;
> > +	cpu =3D from_cpu;
> > +	for_each_cpu_from(cpu, cpu_possible_mask) {
> > +		if (idx =3D=3D CONFIG_RSEQ_CID_SCAN_BATCH)
>=20
> Likewise.
>=20
> > +			break;
> > =C2=A0=C2=A0		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> > +		++idx;
>=20
> Likewise.

Sure, will do.

Thanks,
Gabriele


