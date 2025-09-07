Return-Path: <linux-kernel+bounces-804627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E3B47A9C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89483C2C36
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FA25B1DA;
	Sun,  7 Sep 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDmUSJnv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19611712
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242772; cv=none; b=u/A0vIT1tducPKbzs2QhHznWZOmvY9PRHmxskRfS/TIA7JUtL6EG4gwVOyqbPV4cQPOBdthyRZ71Vp9boHi52dY+YDnOPwxX3ye3ecIJH2NscNsInBH0E3OhxbIIOK3M00/7wVboa2eGYZ96YsLFSgcJL7+fuDXEj/MZ7CglEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242772; c=relaxed/simple;
	bh=Jn7DhhG1HyOHVMii19EXt6HoYd+tNXEZNiR41qcbG+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pbP881Gx9J3t8US9MSgA3BYFOFUlPTxMfNnXzKvn0n0m89KQz1pPqxELWpxATQ7JYT2/GG3tubhwABYdSXW6Oz0wiU2+p9kOOxxOvOiPhXKxofbvDcm84lQA9RONoJ3H5tjNPUPezzWy6E7tXHwCasWryJNUpS0mEKCrzka1FHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDmUSJnv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dcfc6558cso25130715e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757242769; x=1757847569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nru7/1De12iNy/Lo6mL6Fz1GV9z9SyaW/89+3KISNuI=;
        b=pDmUSJnvG+eqIZzkROd5SsqxZf4KSfar48FBtw5V1hzOHP4R5fLLIJjDb2WZaF3Q+I
         WYheXdCNqwO4ycg901s1oXN86qnJx3dEeF3LzomXKKWKzwP+LA8gpTkUBq+ndZiqh2GI
         12JSc4sQF6Vcnr2jnPAM+Crc96qLrwkGXXssfx+LgOO/Hm99k8yDjVReatZfJGwxyN/8
         gBThJpski5Xw/vm9DfZw7I8qxa1YAK/r0cvAuHmLSsdXLdH4iAOKEVhipuHi0n+7bRTP
         MtLkTRa8FlAlRLfq4UWO0eTEEq079BRqIeZxRZNyujSsJzxIMLWpLoqWJXvgEbTtr26h
         QPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757242769; x=1757847569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nru7/1De12iNy/Lo6mL6Fz1GV9z9SyaW/89+3KISNuI=;
        b=hQUBUAxDEX/ChG9OXpOZJ7I5UuJN3mKJbX/fDwQhLfrxyXYq/bpZhBfbJLQTwy1uD8
         dj+qylq55CdCb6OpXVapL7x2iKrkKE0+2dXJQ0Cm8Kyc3fXCkzueJ48XCTMNIsmYKfa2
         5XSH2w2J5mEoJd4HMwClbJ6VCBC3HhDxeSoFnihD+jOcrr4T4dQ1II+W1/3O9hceQnye
         AQxt7Xxe1ZMR5I/N7dZtmpV81D6n0BuUVIHd70x2bL3RWM7yCSoo3gojdQag9yndKDGq
         SogFIDPI4LDNBYbFWbLGhZNaTCUIjwernzEjVfRj75EEXqURx95WUDwzYzagq/TC5RE8
         vwQg==
X-Gm-Message-State: AOJu0YyZXfu86XjnXHWsWg4kNrA1h3LVstGBtXN2IYOdZKVjosnYHyj9
	vplL9JQ9UDxKzjm0P4hCchUDmvLLbBqGFIKddeJuVWUovFaytD9xGd/v3ctqIIP3K/bwOa11Wfi
	FSZFqTAEENdQNCKXDmw==
X-Google-Smtp-Source: AGHT+IEO00SwMUdgmBkfcCYJ1fsDPI1xYuY1er0rIaxUxSTDTvFSh41jkR7cSeu8y5v+3Z4Xh0/HPN7Z/+Ekzas=
X-Received: from wmbet15.prod.google.com ([2002:a05:600c:818f:b0:45b:7580:5aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed0:b0:45d:d0d6:223f with SMTP id 5b1f17b1804b1-45de5ff494cmr5479955e9.0.1757242769289;
 Sun, 07 Sep 2025 03:59:29 -0700 (PDT)
Date: Sun, 7 Sep 2025 10:59:28 +0000
In-Reply-To: <CAAofZF4a6ARXOS0rmK5zY1Kd3xdODqdkj_keZmEYx8Z-JRvhng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905090819.107694-1-marco.crivellari@suse.com>
 <CAH5fLgiZnCbNLpuphv4Kgsu48kRkhf6wJiSLrrgsqyEDvU3X3Q@mail.gmail.com> <CAAofZF4a6ARXOS0rmK5zY1Kd3xdODqdkj_keZmEYx8Z-JRvhng@mail.gmail.com>
Message-ID: <aL1lkN5WcWkwiq3S@google.com>
Subject: Re: [PATCH 0/2] rust: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
From: Alice Ryhl <aliceryhl@google.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, Sep 05, 2025 at 06:05:50PM +0200, Marco Crivellari wrote:
> Hello Alice,
> 
> Thanks for your reply!
> 
> I'm not entirely sure I understood your doubt.
> 
> system_dfl_wq and system_percpu_wq are wq(s) also present in the C code.
> They are part of the prerequisite already merged in:
> 
> 128ea9f6ccfb6960293ae4212f4f97165e42222d
> ("workqueue: Add system_percpu_wq and system_dfl_wq")
> 
> Let me know if I haven't understood correctly what you meant.
> 
> Thanks!

I mean that instead of:

+/// Returns the system unbound work queue (`system_dfl_wq`).
 ///
 /// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
 /// are executed immediately as long as `max_active` limit is not reached and resources are
 /// available.
 pub fn system_unbound() -> &'static Queue {
-    // SAFETY: `system_unbound_wq` is a C global, always available.
-    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
+    // SAFETY: `system_dfl_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
 }

you add a new function:

	pub fn system_dfl() -> &'static Queue {
	    // SAFETY: `system_dfl_wq` is a C global, always available.
	    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
	}

and do *not* modify system_unbound().

Alice

