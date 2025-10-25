Return-Path: <linux-kernel+bounces-870106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3278C09F31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795B03ABE5C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972A305940;
	Sat, 25 Oct 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqx+o/z"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F2302146
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419940; cv=none; b=tEQRzic4RvFXRw0NFXGA9f5uBnoGcuHgroutlUHEKdzNycpp7UcTbik6m/bg11Iu7QxPwLKecpvU2qUyw1PValRa1Q9IXF3arccDhWiBveABS1Zs4LC0k/qDebaMS52SXKWiM4xTC6968GD5lFqXyNYyG0eLgn2XZ/vAL99W+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419940; c=relaxed/simple;
	bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYNpJAfoKnj3ciOhCgJbhLVqgZS6Ca4KsTcnVjvGOeP42uEknxie/z99HeFfNw1VALxlSVkzMF1xjLGvsgzB4HM5wvL2IAd4L7CZLPugf4tkQV96p2+zz7CgUSLs1isqNO11HOBeTMGUU7RxRDFENfr70H8hrQGgIIuV+2mcH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqx+o/z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b62e7221351so2885651a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761419938; x=1762024738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
        b=gAqx+o/zrW38qe8vTmotvOS8G1BK0a4PPbPHZ+5uhUNrTPl0NW2TqVA1EU6TpCrRGh
         GzuApbZZFeg9EVYXfwWy7qYrWubTWy6BJ7kHjZkrF0kNtyxw+T/eakjNqr0cxpSkN/Qv
         nAw6QtAgDQefdqru9VnlBqrFJHd3RCOH+8AnkHQjNJTOHe4M5aTuzcyKYQMDCvZAcI8Z
         0jOS+mw4XTEKwmU/ll2iTsbuLIAvslDOMRR5zE9wIPbqSjzmFcEZqqDUXfK0LXuM48yD
         ydHJcVDEhcOnxguGJa4DAIB8Iwmt9VspSbWk5Q1aXtDod5j0Rh/g1fQZaDF5Jon3nN92
         7OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761419938; x=1762024738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b50a9arCrSL/MR93BKO9o7wTWQtm+XsywFPqsAesqkQ=;
        b=X0raXBmLqrNPqzMoZuOXNzRNLfz7SsAyTXX/eDlbH1pQlMdmX8j7rMj+svCvQAvDqa
         KNdvCG6gGxyfLgkqD+P1q9nzeSPIsltQrepkn9Eq8O+kfH5cokpFLcPOxBDKt5BkubM8
         l1q24yuOyYm1tEIZ5xGnFsiDfDXBf1JrXZt+HNH5L1My961Xu7wJlb8UbZcK5+7WoIiX
         Y960HFcIi1WCQkyR3hvtoqlm7dpV4+SZWF2B/Xb/CQ8IiWZLdC5Zo2mPZeeislx7PZSe
         sSzj9ms21H/hkD0oE5+pn7+KbIsIgof3VEf4uJoS+n7FNqQKrZlECWTzebakx1HYlYFi
         g3ew==
X-Forwarded-Encrypted: i=1; AJvYcCVxOg2w74gsllyPNYRO34c9eCQjoo8OVsuTh/tkNyVY2QwWJ4F+bm374EUcFUQe6OYwrU0ovGzfojCwuq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1zw6sbQPytXrTB3lsSeCIx0Z1VE4leox/T6FuiC0vkGhlbLt
	flKoX0DqatrBlEnhq75gaK+YnvVsB6gbgS2NTx4fVCKZBxSqjkhp+QRE
X-Gm-Gg: ASbGncthxJevOndEeuu2trcoUjGCqqOkCEMWlHBLGT27MH4p5Txj3EpaRUiytvN3UXJ
	Z1endb+NVDyEf6nesu8CKiXQoxfrMR7rezkyybiqPkX/qyi1W/m/3ylaUWxpF36z6oZFTCT3DaQ
	p0AX1yTgr8tCbKmqWxko0CuEgplkhaEyEntJ9zqZqgDIWzut1CS9WDWDzew69BKiDUgnZTzxqAa
	V3icEuEHcgw7UmjO6zN6ORU1dIV39Xl99cvnWAOkW+V8/x7D1lfTaHL+bj97Ri01OIzMq2gYPvB
	w5E3FPeNTnu5OvKGSX2hCR2sxIn9WfRGcJkG5M4UloV8G4AIQhc45AEO3czKlGOJ80KlkSqj9/y
	BoP3uGp0t4twW/UedXZgaCne7qEdjGSRPEwlgA3/Dlu18+dBvUQtAI+J+X6qe9+blIbMw32TKzh
	ccvc9kRyMoR1mdwOKBODEZcvCVozlJObI=
X-Google-Smtp-Source: AGHT+IGB2o/5lEiKd9cWH/x2UTjOp0RZ2ut0VtofYuc7VyGMeDPM/lJA9l37C37EEgCCcQfgsU8H7w==
X-Received: by 2002:a17:902:e889:b0:27d:6f49:febc with SMTP id d9443c01a7336-290c9c93af5mr423757525ad.1.1761419937751;
        Sat, 25 Oct 2025 12:18:57 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm30054435ad.100.2025.10.25.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 12:18:57 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: riel@surriel.com,
	segher@kernel.crashing.org
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
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 2/3] Provide and use an always inline version of finish_task_switch
Date: Sun, 26 Oct 2025 03:18:39 +0800
Message-ID: <20251025191839.6907-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
References: <18734a4944e47952b7ad3e10a36c902392bdaa91.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 17:36:06 -0400, Rik van Riel wrote:
> Does that actually work, or does the compiler
> still inline some of those "non-inlined" versions,
> anyway?

For the current code, adding a new finish_task_switch_ainline function
and calling it has the same effect as directly changing the
finish_task_switch function attribute to __always_inline. This is because
there are only two references to the finish_task_switch function in
core.c. When one is inlined, the other becomes the only call point and it
must be inlined (unless the no-inline option/attribute is added or the
static attribute is removed). The uninlined finish_task_switch assembly
code will not exist.

However, if the call point of the finish_task_switch function in core.c is
increased in the future, as long as one point is added, a non inline
function will be generated and codesize revenue will be obtained.

Xie Yuanbin

