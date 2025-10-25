Return-Path: <linux-kernel+bounces-870094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B9C09E4D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05F394E48FA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B22D29D1;
	Sat, 25 Oct 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh6UVIoN"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739C2C234E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761416476; cv=none; b=bWNhSQzBE79NgjeRMbqmUi1lwpNkLQ+amWB/ybWMRCpNexXqNPTlkS5S3a/JstGHi6Y9gt+F6H3W6reKoBejzJ5eNmQtw/8RHH7OcYFEWGd9SU14m3+DY0bCj6Z6rUes2nPoEOA9InmfdVg67HyFhwOKMCdy/REbJRgBaefiFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761416476; c=relaxed/simple;
	bh=+C2t4uOr/arkY4PV0Bi4a8mpwjxLCqXksHgdBuOHyq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blATe8kmgHbo/nz/r/JvKqGNzuR8/66J0jKYmaXXrY0wXg7lGLlSSwHYpF2KMp88D4XZ0Pnoad7uAPCxoCVLBZjU4LdCGOkLWSOowXrAmv81durHkQB1RjLZTGLf0JooK0W2uEJDjgBG7SiTYhMm+/TD88qFGkSkh6SNP5pimpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh6UVIoN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b67684e2904so2332624a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761416474; x=1762021274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH14/MnMcHfYPrdUmbrPExznn7x87YgaxQDndo6vh/4=;
        b=bh6UVIoN6V6Ed1kwO7wrh0VhhcnFHMpTi+t3OPI28CEyxBcs8Xb+zGdVjwrtct++fM
         kgtlbQbFJF0hURbxQDVq6b1JFicyoSZ3q0IQZrW8SrNDr+rxrB6tHWmPemaXsxzMW7qr
         vdLc9L51kKsvVOa9pQq8H/f7JiPurVRVPwFJT21oVX4MgWmfB7/SXNVTOnbH9Hxy97GM
         2VV4j9I8K6CfCszYFpTOJYBqezYQu3lU+D+TQ8RL5GikSWtyGxo9Q0g/O2M+i7f6XgmE
         3ryhdMV9DPKZAWYTxomZwmd4HAx0cL5nEa8jpm1KkAO08g5pJw3I8jpYN1hwrmOG8E9X
         zCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761416474; x=1762021274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MH14/MnMcHfYPrdUmbrPExznn7x87YgaxQDndo6vh/4=;
        b=QoBmTChPeoFA6nE6c3WxSs6Dx+XqcaGMikaygMKgzcaXHXgYofyYGDnH5A3TORJiLk
         gT3KXka0av7ZlOy6J6maZ0FmmQThjJM4JKePUqiYjllAiEHHYe4/HaT4jbhW4AOTcyrV
         /7chxQE7A+oSbPr1sgTPhMXwSITWdN69PzlnTcn1b8fNk//5xlt/8cPVihHE2gIWZ/P7
         C9pIOtfuAAFYsGuEy4UbQzmk1axDtn9UldAdD8YHiQBCWFG7+fG0m565No9/BS+T3C+k
         pOrU+xVu0TO9UQFrSlNJJHWDQL6/vZ1g+zCCa4Rc+qkvpQ0Pi2G5liGoGN01X09jkh0E
         M+2A==
X-Forwarded-Encrypted: i=1; AJvYcCVgH00rhmMwx16ay/e/KLYzWvgXBTZ3LmwMvIN+bp6tPcd2M1eoMnM5wGgg7Q592BbZruqpNGjQBXgKx/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc59yVbqLzWRaPmXkexDIZsEkyOVb85Glyb5Trmbq0mDD7E/0c
	7Oun6Ky/JX7P6YHPaJleyaeVY+9LYVE2SZi3TbM9yN97beJt7wyEg/WQ
X-Gm-Gg: ASbGnctYgr+91ubC+aB2OhpaEjpvpVOpRbooLexh+mQJnzY958JGyC/0TDYRxQ63uZJ
	2mMO18h5TJxyiKInHpDmB8xgERAxT210IQQorBCVIm4/8Vg+FfPkdKLgmuuaEWtgWV0MzDFGtK1
	XL8+5kr6t+LZ+6BdRXq9ekDMNba8lF+DV1cXCpzgyLcfjk/8zbsg8lKdxKhqVcsyjHkmQoMYNq1
	m9gJtGOQ0roVYQm3ZMkKWnamw7LyH5iFjRtq5STCLaD3IBCZ92zD3cUDC8fsCwItYQByV/IhSkR
	CQBEX3as/JB7e+tHMAb3/dod1NCkViA/HzGz1N/aSlGgWeIOPm+mi52p4RjNcibu53cD+dkWohb
	8I8VmbMMbZbLP4FrgemdmTULWsVyICKCnRNz4umOTUnnEhM+wdSvjwoQ6kzkKkfKs594Pcl3oCd
	5Jv492PW64HrDflHruN7u/
X-Google-Smtp-Source: AGHT+IEsUSXlYbD6I629dWvXZvj4cEZuKoZGpxoERZCztC74qj4lgbg/Yxnib/SOWntPtHtuSob5TA==
X-Received: by 2002:a17:902:ea11:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-2948b97429emr78955375ad.14.1761416474192;
        Sat, 25 Oct 2025 11:21:14 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4113fsm29127285ad.90.2025.10.25.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:21:13 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH 0/3] Optimize code generation during context
Date: Sun, 26 Oct 2025 02:20:53 +0800
Message-ID: <20251025182053.6634-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025122659.GA2352457@noisy.programming.kicks-ass.net>
References: <20251025122659.GA2352457@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 25 Oct 2025 14:26:59 +0200, Peter Zijlstra wrote:
> Not sure what compiler you're running, but it is on the one random
> compile I just checked.

I'm using gcc 15.2 and clang 22 now, Neither of them inlines
finish_task_switch function, even at O2 optimization level.

> you have no performance numbers included or any other justification for
> any of this ugly.

I apologize for this. I originally discovered this missed optimization
when I was debugging a scheduling performance issue. I was using the
company's equipment and could only observe macro business performance
data, but not the specific scheduling time consuming data.
Today I did some testing using my own devices,
the testing logic is as follows:
```
-	return finish_task_switch(prev);
+	start_time = rdtsc();
+	barrier();
+	rq = finish_task_switch(prev);
+	barrier();
+	end_time = rdtsc;
+	return rq;
```

The test data is as follows:
1. mitigations Off, without patches: 13.5 - 13.7
2. mitigations Off, with patches: 13.5 - 13.7
3. mitigations On, without patches: 23.3 - 23.6
4. mitigations On, with patches: 16.6 - 16.8

Some config:
PREEMPT=n
DEBUG_PREEMPT=n
NO_HZ_FULL=n
NO_HZ_IDLE=y
STACKPROTECTOR_STRONG=y

On my device, these patches have very little effect when mitigations off,
but the improvement was still very noticeable when the mitigation was on.
I suspect this is because I'm using a recent Ryzen CPU with a very
powerful instruction cache and branch prediction capabilities, so without
considering the Spectre vulnerability, inlining is less effective.
However, on embedded devices with small instruction caches, these patches
should still be effective even with mitigations off.

>> 3. The __schedule function has __sched attribute, which makes it be
>> placed in the ".sched.text" section, while finish_task_switch does not,
>> which causes their distance to be very far in binary, aggravating the
>> above performance degradation.
>
> How? If it doesn't get inlined it will be a direct call, in which case
> the prefetcher should have no trouble.

Placing related functions and data close together in the binary is a
common compiler optimization. For example, the cold and hot attributes
will place codes in ".text.hot" and ".text.cold" sections. This reduces
cache misses for instruction and data caches.

The current code adds the __sched attribute to the __schedule function
(placing it into ".text.sched" section), but not to finish_task_switch,
causing them to be very far apart in the binary.
If the __schedule function didn't have the __sched attribute, both would
be in the .text section of the sched.o translation unit.
Thus, the __sched attribute in the __schedule function actually causes a
degradation, and inlining finish_task_switch can alleviate this problem.

Xie Yuanbin

