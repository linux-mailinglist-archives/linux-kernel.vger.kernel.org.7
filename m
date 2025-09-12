Return-Path: <linux-kernel+bounces-813221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E86B54220
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43E2567C52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890027511F;
	Fri, 12 Sep 2025 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtBuGFQZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D150270EC1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655588; cv=none; b=c0PKHGZlt8MLSDA9a3GwMgnAYlGABkIgphlN1BfjgOjQepv3KYZAM3JRvw36Pvg0oSR0nh2ySsZq8H6laGbbhiRSBEpZIWbLIsK8uy5b7XehT8FXhWWm1az55OTbN41pi5qDD+8qgN5ZN7oPjRYBXk+U45/GAnJpVJjd3HczgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655588; c=relaxed/simple;
	bh=FE4LEfa0MFWh4XVO+HcjVeFJCgM/7FC5uvlRFWH9I8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwzrQoT5cP8dfXHDZT2BGadNZloFcU61CJr7WObmiJyW4uAdyVu5rqwdOc8E9iENQEDzl53EtF0hLzbIcBC6wEZtJtwOpYoB2VGS/mzz2XeWMKB607nwhVATN2DmhUUIUCPPzry24ICHUcZ9bfvMtX6EsAquOyj0mlNMigEKpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtBuGFQZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso10859305e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757655583; x=1758260383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hM2DWLFWIwZvGeYjqfMb7Q47eznE2Jw4O6GSXIWsUA0=;
        b=OtBuGFQZWfSakL0ZrkWP8l7Q97BBOLa5Y6HnC1IuCiH0Bi3T0J8LHyAI61zTLDNPOo
         NCYAt9ac8yx9GIg6plUCvnsKdHVTeRUGRBFQtdIWOiR0FhrKgXV1t0X6d2AQxtEpV/Ua
         5u8T/iEaU2H/5hg93oKf+KZCCGMw0UvYTYOk/pmZ+OhejNpOYQLNJbzT0o+mEEHgX68A
         a1y4PLDJxyoInM9sFYcoeLYIDpjb5AtxbBZ8gQdqWf1BAMHV4L+L0U5FBThmHgpTzfH0
         sikMBTnk+TVX3DR4ae141UWi9LMSLwhWVvfnI5soHBFMwBinx+IiXR41lkQnTHZMAq+8
         37JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655584; x=1758260384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM2DWLFWIwZvGeYjqfMb7Q47eznE2Jw4O6GSXIWsUA0=;
        b=KRhyvsfL49KyAhiaL/ukY28d/wLBm4ZabLCWOYODnY0g1omjwlpKZNWc0P20qtEfCL
         zGy55BV3Vc+NK2t24uG6kDG36pkSHFvBgpdaqXbPTw8YZAKDEH+NBeat60t9fzpCwmHt
         SkAt/l71asUAih8frX06OQGNdkyp5ep+PMn9S8+F5JMcM/pKk2m6unJnxRYTNNfpkdeq
         UUiCyx/eVZKWy0BbUtjHlzIyGLTfnFqfeeqa07w21no4ZqMNnuCad4WCioMWA/IBYRih
         zUDgxVD+hdaOTde4YTUnawEmKeAWBYu/Qj9LRuMOsC9Xw5Y5KorzdojAz0YZa2Lr4v10
         eTIA==
X-Forwarded-Encrypted: i=1; AJvYcCW8FHrXp63f+fwIf1P9RIz56nWS52TIUou7S8Wal3ywYQawJK1LkcQr+F9/76eQnH0+lluG5cCHRfBT7Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YylY4JERnuIX7IeN8cphh0szkxa4t+k1XaznOkHntjLx5ldZ5Qg
	IE3xDqWfkkgSoKGrcmp9vmlhx/Q637Ay933CNCpXJiUojZWiXmwkvg45
X-Gm-Gg: ASbGncsz+x4ssovCnnNQo1RllDTpZWNYfhpyXtdsM2g+VtsiDW6E9CNLOTQYcAGafYe
	VbnRnpwARxh9tu084tzK60NgoSbeeEDxfOuBezRtER/ioZKxMdtgzRBl9vXG3Yx9z17Kfz+3r5f
	HBZ8QTikBT4PHZJGfEOlusICYfEPcsThRJSZ1p9YIB13suoBms78Wida/nIwsyvKpIU76NoC1tA
	ve3fQ9E1fY64suaDgFXhqTwR1MXUyTFKosf+WYhYmn8uLlmOChxPxA1W8jvaXwAiKfX8WLTv8MZ
	kGw2nk/qkxg5lnbXcaA14rmIbroUZ25kpZKnkUHgKeHHDsaNBabmLQm3s3xtXfSBG/LHz8LQPcV
	675LYuVdPNyDxHefi66D8YwOjVyIw45CpBI+HrarGFEX5oKOJWZ5U3ktyjTFv68c/sHghTeKmy2
	GEzw==
X-Google-Smtp-Source: AGHT+IHRrddtK+Ata6mD2381zASluGACziWU1VzEvaAee09SitgxP/yhFsAZ6KBSeSxjyPaJqjpjiA==
X-Received: by 2002:a7b:ca5a:0:b0:45d:e0cf:41c9 with SMTP id 5b1f17b1804b1-45f211f89d6mr11529475e9.22.1757655583416;
        Thu, 11 Sep 2025 22:39:43 -0700 (PDT)
Received: from laptom.homenet.telecomitalia.it ([185.92.96.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd27dsm5032925f8f.41.2025.09.11.22.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:39:42 -0700 (PDT)
From: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
X-Google-Original-From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
Subject: [PATCH] sched/deadline: Add reporting of runtime left & abs deadline to sched_getattr() for DEADLINE tasks
Date: Fri, 12 Sep 2025 07:38:28 +0200
Message-ID: <20250912053937.31636-1-tommaso.cucinotta@santannapisa.it>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm resending this patch proposal after having addressed a few Juri's
comments, and a rebase on top of the post-august-break tip sched/core.

The SCHED_DEADLINE scheduler allows reading the statically configured
run-time, deadline, and period parameters through the sched_getattr()
system call. However, there is no immediate way to access, from user space,
the current parameters used within the scheduler: the instantaneous runtime
left in the current cycle, as well as the current absolute deadline.

The `flags' sched_getattr() parameter, so far mandated to contain zero,
now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 flag, to request
retrieval of the leftover runtime and absolute deadline, converted to a
CLOCK_MONOTONIC reference, instead of the statically configured parameters.

This feature is useful for adaptive SCHED_DEADLINE tasks that need to
modify their behavior depending on whether or not there is enough runtime
left in the current period, and/or what is the current absolute deadline.

Notes:
- before returning the instantaneous parameters, the runtime is updated;
- the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
  in CLOCK_MONOTONIC reference; this causes multiple invocations from the
  same period to return values that may differ for a few ns (showing some
  small drift), albeit the deadline doesn't move, in rq_clock() reference;
- the abs deadline value returned to user-space, as unsigned 64-bit value,
  can represent nearly 585 years since boot time;
- setting flags=0 provides the old behavior (retrieve static parameters).

See also the notes from discussion held at OSPM 2025 on the topic
"Making user space aware of current deadline-scheduler parameters".

Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

