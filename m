Return-Path: <linux-kernel+bounces-813812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0CB54AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5661C87CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AB3009F4;
	Fri, 12 Sep 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkOnNN0t"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B63289E06
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676541; cv=none; b=V6VGSpFBZg/XXbnHMuIzF04ot3IUVQ3NSHll8qR/iIcFMWVGuipjsmg5n1HjEnGbfeBkvGGeWFqy+GRU0/LyH4WtBtXpmCaLp55rhb9ShRUHbTTl/Xtx4vAnqIvIZtVa2ZyP3/LzPsrBC99qmCmII2Yfri+92ETwkztJC2Z5zYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676541; c=relaxed/simple;
	bh=GEi4Pu+BiQVVyU3qMyfkPd4FuBQrgtgvLqtdUY8/eKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nEDT1I2SqpPszlKJ9l+nr882qaZJZQwSgA42gPLj09BFthnO+Io/3ArGHj6Q2n52u74eSWi+cWNT00rZmY8WruAHkJXmdeXe0i8U82epBduX9zGoLH6Xb6UGRqgRB/eieCtWw16XWdOpXRm1ay0339ZfpnMTGmgtgKDvifSDKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkOnNN0t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso11845765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757676538; x=1758281338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwVKnR8rFntApp7ZzuwxI7ZqvcEkE867VJlDRhLtWrE=;
        b=YkOnNN0tKCd7dFUxBO6a6OGfcGbvZUvBtanLpBXdR2QKt7UCxNFIPudZ9eszCm7xhx
         3IjxRynPnObsQs0MTKw/1AQhqJjasI61s95+FdIm9vdYHhw0Z8L8PHrWyUPXCSfyR4ss
         wR+0OT0xMHyZvtmG32aOE1Q14ILRm1Q+hFAcOnhD4bKw4x3o2Faegk2SW0mBHXMtyRny
         OOh0b+92gOCc+8055HK1pKQMF1dTrcPeHEDoP3AxCGKZNpN39zb9UUtbUzNQIAaeEPPJ
         2LKMzURZjq4xBTjrmjGO/AMov3eNE2JikehFC2EiCYvaDYcYOITbevyheofk+ZzIe14c
         wETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676538; x=1758281338;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwVKnR8rFntApp7ZzuwxI7ZqvcEkE867VJlDRhLtWrE=;
        b=hBa1+44rQN23vh4e1evZdBVPEjaSnkK8JFWgxpzuTw4Latlj/VU3cbx/w7+43wqHMQ
         66szXFSiZQaxs+dOKncklWPxH1e5gl4TaaEBoI2IhN6QsCnoopGpUEJTzFdByKMXyoN+
         7SUrOksCrHnuAlZc1Qx3JgH748bVxodIB2uL/2YP/QmYjTUQJvGmNoSAOlAFnSVXn4PG
         IaDLaOPnWew+7JDPK7mCgKllBsRvAhhfj9VUdnMFEMEEdisBuldApcF9khQQy5Tv0uog
         /EsCPa7WMA6zJEIdRrvysQWYwio4vZ1NHLbS4zlWJ74u6gJaHdfxuYYAViYOpFJ2i7Ha
         GY2g==
X-Forwarded-Encrypted: i=1; AJvYcCWHpCBIFRsjA0HGK5xiskORC0INhqhE+7msjqFNFzwBHOAZQlo9vVcBAOxmkybNxvNVuMDniKCwrYknxaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+gBJ6mUswbrniKwWNoYl3ELkNhwcCfyPA4EPcoqJ3MR05jJl
	OtlAuHGJSlBxyFJlt6vBlDN7zqH9su6qaeTDuNMEdpxxe8FPhJu4qZs=
X-Gm-Gg: ASbGncvwUZOCDnee8HckpfMPxH9xXHjssDh0rv6k2oBWGg0mDaP58Xq+j7HKASsncJG
	H6SDepWR6P3iQ13smy6j4ZgY4luXUG90ULYYQAmoEHl1bpoBOezbXtI/kKCNQSaQH8VmnrMevXO
	pg8rTdJJMyX+O18kBMeiWo6rq+y0oRJScA+yxvWsb7FHyfTLilUgtpW1GYGG6hH1zR79B7nV+xI
	KjzGdwF08LEaLrtpKl/qUu7ySGy+pms72dbSlI45u+rC1bkMqDMRVpsaJm3qy0Tt6EmlmJL0Ovc
	P6PLiCXBTrkrnd8E3olwXs0td5dN6yj/D65FHDehHDnEU4e/v+IcvX6tPAb+AWwyqZvx8m8PzwO
	X59A3ZmHJtHh7mVNJlq34QnA=
X-Google-Smtp-Source: AGHT+IFO8Zfr+KXGf/gZA9YAUU3Z1l/VSfoJhHCmcp+Qzls93TzCsPrunrvFxGOcxkZ8FeqrxBfgLw==
X-Received: by 2002:a05:600c:4f8b:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45f2121ac21mr22734455e9.29.1757676537834;
        Fri, 12 Sep 2025 04:28:57 -0700 (PDT)
Received: from vova-pc ([85.94.110.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ce5sm59042975e9.16.2025.09.12.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:28:57 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:28:55 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <aMQD9_lxYmphT-up@vova-pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A soft lockup was observed when loading amdgpu module.
If a module has a lot of tracable functions, multiple calls
to kallsyms_lookup can spend too much time in RCU critical
section and with disabled preemption, causing kernel panic.
This is the same issue that was fixed in
commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
ftrace_graph_set_hash()").

Fix it the same way by adding cond_resched() in ftrace_module_enable.

Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
---
Changes since v1: https://lore.kernel.org/all/aMLPm__QGrQCwz1t@vova-pc/
 - Move cond_resched below within_module check
 - Add some details in commit description

kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..42bd2ba68a82 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7535,6 +7535,8 @@ void ftrace_module_enable(struct module *mod)
 		if (!within_module(rec->ip, mod))
 			break;
 
+		cond_resched();
+
 		/* Weak functions should still be ignored */
 		if (!test_for_valid_rec(rec)) {
 			/* Clear all other flags. Should not be enabled anyway */
-- 
2.43.0


