Return-Path: <linux-kernel+bounces-892050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C1C44319
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E231188C21E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD059303A39;
	Sun,  9 Nov 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUWscdTu"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6282FFDC9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707874; cv=none; b=JRl0MWvSMXNueX6nBJ7KQwdjeoVUcx5ctyiBOCwdfyF7VVLnCGTpXm+r8R9tYSV7qs2VrVk7OuKwWybcYYJULxkm7Hve9OcnYaMnDfanLNUOZHd9WQolvqowV37K59gPGAdqSgA2CJtGlR+lxSVO/ebK1n4Fe1c/xadfyOhiE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707874; c=relaxed/simple;
	bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uonUcuuxl0YSNjwimSO3JQR6LQwrJBtJ4ZxwBW5IKyf9HXXUhSMSYEneGUpGwVqVG7d1UYNh3BUsffBM59cGu1zCuiDy43BMOS5Sr3JHbbqAKg4QUtZzQlEtjytLSWnQ+qCetlPG3RjGEwON6SPFmnKRvQmEreJwzRUaqgnagbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUWscdTu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29808a9a96aso4095285ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762707872; x=1763312672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=SUWscdTuz6E8COB4RFi3ARO92QxTVYh+eM1xKZGjF6toaMhbiUpmk8leK7DKEWdVmL
         T1n7eWLAgZR17BgtucZln5haaFIwIlzBsalpycpO9AxPOEgjT11nWQKYzgTk0Z9K30Kr
         rFye/XM/FEOlo1TZuOg1+8wKc4EhvaPGuuwf7bsd2id6U4ZThUmIyUTSgvVorWd3erHW
         mGWG0yFvj5HsGIavX1MJ6qyQVNruD0wj8Ku4SWPkAODcbDrsuB4gTHSFD73zHzYvw9Xh
         Z/AAbxMNYwNciKd7J61O/9qa17+e9u5qDL/ZsKQWqs+i2yi7vmHiqCc3mSXqFsLZjskb
         DLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762707872; x=1763312672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=SaRzEM+0y6WsbF+DhqB3chcMMp+Lb0lCZz55n47qEBWeOQy3QyL2JiOPTiVwe3Bhfe
         QX4XRoFEoAKGLqM1fE6PlyMoLeqNpfnmItD+Jy25AsNkH4HEFvfu9gqEBpVMDr+7Vi4D
         vyfuVgcniV6XEu1ivvWi+50Y+A38GTDH66AlOj4FvDZ70x5ZqdaoHyLIwOlahH6rPjOg
         1KBBSVxw4AFgz0rt1QlG/C/DcvWbW4O75Z9eVu+rAHV9UNrFnKwXe230Po2LNtwPKOAj
         YFJDAdJG2hnvyFOFPn5fUzK4fnJzp7s4lFcCP6fMV72odUd3tk5F9N1TiM4fdDFLeWOC
         vfKA==
X-Forwarded-Encrypted: i=1; AJvYcCVFWUHXMjGeJiQzJszUvEw8G7EtOks07D8xGf9lLCdgL+CTk4qn5qhFyRwBpOpLwWxLU5K0PB2KRh7kQFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUFwvP2q1Ukz2Ha0bp1mQQN9CwO7jrWVtNNwIrV6q7iw6ZDCT
	p8e55BhwMrzPJULCYqmx85Qg4i5TmgmFmuLadDq6GFc+FB2kCgyD8uKv
X-Gm-Gg: ASbGncvTRNIIMqJ+94tXHuvxUcSfUfQ286j8uUdzv10nzBc8Z+aRMQib+rk4HjDIOWZ
	UI3MCvOpPZ4qJnVdUhn5jX3/FLAF3Nwc22WpFXGfUScZ7PHRfuP3ORKbuVF8ynsHn7pMN3LCQB8
	+nb20+OfKNrTmw4hSGGe/ZehEOqyI4zo4zEl5Gev6fre4GSv7JTsWdrK1P+B0f2lgGCFzz0bkV1
	F1fX57qEPw/T7FXB2avd6sS9aOw8KJXviMspaImgylXVzuAh61mcwcs1xorRtlG/p3EBpPr9+47
	koIOpniQAdhpyj0T+Rqwq2L4/yJkIRbbtd5J+w+K8+toWeQVQhfIg8YlfIhkk71mFg+uw4I43UL
	IEGsZJrNVIlhY6T0R+ziBGHvEHmVOL00Yq08ee4fWcEK2G7hgyi+0MyTNqZFA3vWgB4fTltI7ih
	7Zl45TQaPab7P54dVPZe3R0dsIvbkfVYbMYZg=
X-Google-Smtp-Source: AGHT+IEO5xU3ShKvIQJG0EYcsf90e1JVTbxU34yk/YUYIZqWcpmJ8G9BchXReIw1drUaTkP5NUMmRg==
X-Received: by 2002:a17:903:2f86:b0:297:c71d:851c with SMTP id d9443c01a7336-297e56be50emr71705165ad.36.1762707871570;
        Sun, 09 Nov 2025 09:04:31 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm117879105ad.20.2025.11.09.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:04:29 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
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
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some functions
Date: Mon, 10 Nov 2025 01:04:02 +0800
Message-ID: <20251109170402.145012-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
References: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Nov 2025 12:31:52 +0100, Peter Zijlstra wrote:
> There isn't a single function in the entire kernel with an _ainline
> suffix, while there are a ton of _inline suffixed functions.
>
> On top of that, this function was already marked inline, and your
> compiler just chose to not inline them for raisins. Just make the thing
> __always_inline and forget, dont make thing extra ugly for no reason.

Simple test: "Make the original functions as __always_inline" VS
"Add the always inline version of these functions (with _ainline suffix)"

compile as OPTIMIZE_FOR_SIZE: the size of bzImage is same
compile as OPTIMIZE_FOR_PERFORMANCE: disassembly of vmlinux is same

Adding the always-inline version of these functions can provide better
guidance for compiler optimization, but it does indeed lead to more
complex code.
The best solution may be to prompt the compiler to always inline at a
specific calling point through some keyword.
I noticed that there are also people discussing this issue on stackerflow
, but it seems that the current compiler does not have such a feature.
Link: https://stackoverflow.com/questions/14571593

I have no objection to either option; it depends on the opinion of the
community maintainers.

Xie Yuanbin

