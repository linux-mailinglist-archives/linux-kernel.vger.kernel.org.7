Return-Path: <linux-kernel+bounces-870100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F631C09EB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220083A56BC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA580302CDF;
	Sat, 25 Oct 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OumiIAd5"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB32FCBED
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418307; cv=none; b=KlKlkrftrVjhwo2cPDdA754SYv8/ns+qAmiVVZC1dFCf4uXQBfpVBgUVIPlUGzvolivb/3O0TjRU4QU6jE8qBOFskHQtP/OdiG47hVHYOd3HOU2EYC7VoaDpyjeIfzgcfwQE+sMeLlkAt+mQdeOTeEENLe3oF7H1KcL/GBMWHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418307; c=relaxed/simple;
	bh=bIE1dNWJNDWO8or3nwiGA7qbCcPQuWvlUWlsOjJvHas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXQ4sqmDlqqZH8essSMpIR0BhaLggVDFD/1JSsxZLYWNo4U8Nlir1dPCjG5Hpt1eKs61N2cKuxn6MhEWt5NZnkE+OHxlTE6yNBrYWY19SCwJl5pih4PiDwyvXYBNmUL1nnm3iQXzTfelCrZeke78fdqparNt9owl6XTTYWG5+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OumiIAd5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811a02316bso2344416b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418305; x=1762023105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIE1dNWJNDWO8or3nwiGA7qbCcPQuWvlUWlsOjJvHas=;
        b=OumiIAd52mCDIWxBvkc4sx/mY6AGD1qdzpMd8pl1TUTxhYEX5q84GEg6bGFuQuBRln
         2F5uoUpsW4Dk2owigJC4esen5PDF20+UtY3w44OTaSxbR/ZW3ikNiRpYwgYaLYqxH9b0
         0nXq4VbZkjlFeSVk9oSEu87qNaSnImr0drPZjptdrWhtKCNi7B7FtLg14CXHilZNypOJ
         LR6Orvv4VaCltv+tlfryTjYRsJauLuFwvAtRmYuRlmPEhFs2y6eBHfCmq0/1bjcNm7iD
         X+zqhWDc5Z06RSIzzS1HmotZKI9zHjn5Yy7fOo3lgGe9gG92JLDssTY9XZLdK2Ms6NwQ
         sztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418305; x=1762023105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIE1dNWJNDWO8or3nwiGA7qbCcPQuWvlUWlsOjJvHas=;
        b=YLlH+JHh1YucBawmpWtkXB760qyZFOz8WxdpnnQiOki7sY+1ntPTT1uZyg5NzuQ4RO
         3n0uVcTqBVoBPHqQwUok4x1W+3QAtO68JIIlH2L63O5MP7MXUQuSPCBD7FtzUsFCpPjA
         xylmDaNx+pbqilB4ElYH9Kgrx2YdDgWu2wxwZgh9mu52r7L2ush18nvzsFT8Ck15E8uD
         RPNcW7XcU7dWs9T18G0cQmiapgeCyTjpbaPS5PB8Tbli/fmUnKbM943INd3ybDjLZ+o+
         l0FuosTHVFDGzEwnkdzOtCSgdgBdGQf0kIfaq+0pL/Ed+/RB4JzK9UxwMHGNSFPiUOKT
         7b0w==
X-Forwarded-Encrypted: i=1; AJvYcCUOBUHwwauOPJVJtxV2UEgSK3hcwlAhVTt2j0gu4j8XuNkRX7ayScaXl3sIOfmfWcMKoqSelQOJ/uoVH/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHanst8aRXSSks6ugTrT3cDa7vSO8Z1Hh7RsI5PqG2IqEwUpH
	NGUeDP4Nc05bGNh7r6rkHcK6YZ8/OCuGlY2KyotqSr9hS6iNWp8Qji0D
X-Gm-Gg: ASbGncsQxs7iIlyl+mdZQItcL376o3nOrAfgwQ1byZAN4TiegG6SBQDDESeYWTwWq7l
	erZmUKrWRsxQa/5TpdkT3qklTux4voBid4PWmhlTef83EYaH3OUYxvprqla2MWYpMR+g+JPwkYP
	hy5kNjCkeM8tU2Spq7+7TeqHq0V8lvBPTVLveni2XNGkikyhKjsop1zg1fOEoukI+VVd1jXyxCK
	eMOpbJD19EFo7TLsV0QXRC4diZ7FiwKqwkj+zRl6XkIISkEcH3WaMAgyiSubR08oRyc3vLCm07+
	itUdZzeK8fGovIkUbDryBUsAm9nqeOQS2JDZ5Q8v+DVMhirZbN5VTqqSL/H6Nw+hLH2H1KHbwot
	Rcu+r8HOG7Qbyt0PRHxxQEyVQ8urza8i1Mv/j2Ga1e9HW4h7SQEDsjmFjoGs2817RRdyUHWCbz/
	yV3gjg2hndpeq0ieuUR3ae
X-Google-Smtp-Source: AGHT+IFA/PpMad08k18p5dz1XblACJuseYn3XTA1biqGFVkwzh9uXMt+aH7CWADiafyloVKa8I/K9Q==
X-Received: by 2002:a05:6a00:94e3:b0:7a2:8343:1b1 with SMTP id d2e1a72fcca58-7a283430981mr9276736b3a.17.1761418304909;
        Sat, 25 Oct 2025 11:51:44 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e554sm2897425b3a.18.2025.10.25.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:51:44 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	namhyung@kernel.org,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 3/3] Set the subfunctions called by finish_task_switch to be inline
Date: Sun, 26 Oct 2025 02:51:20 +0800
Message-ID: <20251025185120.6760-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87placw0dx.ffs@tglx>
References: <87placw0dx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 21:44:10 +0200, Thomas Gleixner wrote:
> What is exactly the point of this indirection. Why can't you just mark
> finish_arch_post_lock_switch() __always_inline and be done with it?

In this patch, I've added an always inline version of the function,
finish_arch_post_lock_switch_ainline. The original function,
finish_arch_post_lock_switch, retains its original inline attribute.

The reason for this is that this function is called not only during
context switches but also from other code, and I don't want to affect
those parts. In fact, with Os/Oz-level optimizations, if this function
is called multiple times within one .c file, it will most likely not be
inlined, even if it's marked as inline.

Context switching is a hot code, I hope it will be always inlined here to
improve performance. In other places, if it is not a performance-critical
function, then it can be not inlined to gain codesize benefits.

Look at your opinions. I have no objection to setting
finish_arch_post_lock_switch directly to __always_inline.

Xie Yuanbin

