Return-Path: <linux-kernel+bounces-742125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26745B0ED9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C543BCBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FF27F75F;
	Wed, 23 Jul 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJHZW42i"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACBF1581F8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260462; cv=none; b=u3KI1KjFPtyE8B0UAfxwFNjh80Gq/LE6msmAMl3GXs+ovQRV8ByTjEoA/m3T4bTX0TxTLmmA1kL3/c3VlyujpaXW3AjT1PrPwx5Au8/OmA5prnZ48dQrMnGlDpE08kT+blA+A3GPXoDElxdt/gu+SCziXzp70lA5R1htU1VOFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260462; c=relaxed/simple;
	bh=XkWtoBEy+RtVEYij8/zZoQ140vXxVhFS3YCRagqTajs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cQYDmBRVEnsTvjcPu7ablY6WdwppXiv9JNqmw0MiXSnsSQCwkylpk0zgzYtMX+JX1h8b8IcZtDlo5kr3yl1TX+afTKn/XrPU77tVjHsCVlHwunZXEMOVqI+n+/ByUKpTIbOgn5cChl47zcgEtw8UylIQCBwcNSXKb/LEDBfup2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cJHZW42i; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6424951a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753260461; x=1753865261; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkWtoBEy+RtVEYij8/zZoQ140vXxVhFS3YCRagqTajs=;
        b=cJHZW42ir9I/EO7jFk1DFciMyOMJrZZBb0AAK/75DkhNwI0kb7c9b+s5LpyfdZ7K3o
         ZcfIAKK4yp0HH8bzwNeCQkTcd5tR+FacGGZkURO+FxrX/z7rb6PCvEzBYVLEQNV66LEi
         XufNfnz86ZYOG5McAP3Sapz1IJCgpKnO1g1wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260461; x=1753865261;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkWtoBEy+RtVEYij8/zZoQ140vXxVhFS3YCRagqTajs=;
        b=mQTX9BRmwModb4r60o0ucgNODYOjJHXosIr3agxtloBhkKzdRpZwjtvNyFUKLyqRJx
         JINkdBbjInXT4065utJpA9AfTVxNSsszfXCqnyTNAt0wZkRH4P+VYjxJbM8XCzYBhVuA
         MIeBokCxupTgfwYbo88zxPV0ucSkKfuJIQzAlT/6i5V2j+YlX6vZMjG4M4Uu1cz4av9c
         KX5vFi4LJ/RDERAGpk5DnyJ18+V0umKcQV77Zrf7gZV4M7bQNBevA9e2ZbIuWpihxv0w
         UP6six9WMTzdw0b67Jqg8NltJmbcPF2KMXyFejLw8xLib+sPStjlXj/dYBtf4QdxAleq
         Hq2g==
X-Forwarded-Encrypted: i=1; AJvYcCVDDtzYJd2cPdtUjJGiXQrgrj3W2srmtG5JEEm1ZTSH6eZf2ef7r9fO98WdpK+ZuZsSIf7HVc1oWM6OxME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDf/J33wbIRdQtwtRQ+f/1sppE6cl+Jk3fTuOd0VgZOn/Kn8Ex
	t0LMGWYcPzS9gPEAeb3lZWc9cL7nufKmtytl8HBNwufvOOVwUkBX8lqoyTqF+RkQvw==
X-Gm-Gg: ASbGncsiR4i7IrdGbGe1XfZazM0vBBBwrCd7vO7Ll2RIHGuPGPUq043ZCnD1EbgRCgE
	bW7iI97N2ZusTZ9dPMSLmrKIMEq1udRpKkC263gSx4hhtSmcZrjRvAdguCAv+WqtEJxLr7u/sQ0
	6dRCm1vV0Y7OLiBNsMDakmoMZJS5NYM2ST1cHBvFGWvtR6tCMyZpVr/Zw9JKa0SwlE1vCb8+4nx
	IOdtyuyEGe7jQInCrcQELWY4LZE5V3LF2xnfvyQhIoioj/hwjGpv6QcP8Vg1AA9Ry3XHEm37U4o
	y+Kj0cmMx3JaNkhNv+T7BEWg6ZckBDbsaLPQ0uhq3GYDSM1viIgBhmm8329ieAndcZNbIV7pzt0
	8qOITKUUaXPSp8Vj6x6ZhNQpiTA==
X-Google-Smtp-Source: AGHT+IHf7pd/APQTIG3i6HqTIMWQdqJf767iTNlzngJRFG8jMvKF4lKtndMTbEM80kKxucwL/NFrsA==
X-Received: by 2002:a05:6a21:6197:b0:236:355d:5f27 with SMTP id adf61e73a8af0-23d491f866emr3296443637.42.1753260460802;
        Wed, 23 Jul 2025 01:47:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:23e0:b24b:992e:55d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2008sm8500708b3a.30.2025.07.23.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:47:40 -0700 (PDT)
Date: Wed, 23 Jul 2025 17:47:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Mladek <pmladek@suse.com>, 
	John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: [RFC] panic: redundant backtraces with SYS_INFO_ALL_CPU_BT
Message-ID: <wgczmfbmzppwqvdjvsmhwzravvfzkabgeh6yifc3y4syl76xy5@ytgnkkmmcpr7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello folks,

Should SYS_INFO_ALL_CPU_BT use trigger_allbutcpu_cpu_backtrace(),
instead of trigger_all_cpu_backtrace(), to exclude self/panic-cpu?
Otherwise it dumps extra backtraces for the panic CPU, which is
a little redundant (and confusing.)

E.g.
softlockup watchdog_timer_fn() calls dump_stack() from IRQ for the
locked-up CPU before it calls into panic() (assuming soft lockup panic),
which then can SYS_INFO_ALL_CPU_BT and trigger NMI backtraces for all CPUs,
including panic CPU which already dumped its stack, but this time we
dump_stack() from NMI.

I suspect it's a similar story for BUG()/BUG_ON() (and WARN/WARN_ON(),
assuming panic on warn.)

