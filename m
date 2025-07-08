Return-Path: <linux-kernel+bounces-721806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D19AFCE16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B014166422
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65F2E03ED;
	Tue,  8 Jul 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="OnZ6/4kz"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407301AAC9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985897; cv=none; b=VDwIge2j/sS+6F2m1hLfGyB6Zj5Yh4CphvdotJYuofAmRCA5QmwvvOCWV3sqvACWESV3nAnwNLlvXaJI65azYahK02ZW+Dr8kmrrS4r+tL/UFs31QeVA2w3Yq6ZhTC9igcplaD7E2ncN8YJvYZLZyinq6sjIwGQlFPiJrYSjAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985897; c=relaxed/simple;
	bh=fN4tOIQJAoq+AKMfht5dCRp3iRRsCe06SubkHAC/Bdw=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VeObq9eTjeSaQtDZTSTKuwDp6ZTtYh2IpGo9rI8g/2G53VxzzUn8hfHJ9mVzzOhPW/4PDP3D8zE75PbPAmtRx6SpCaT0b+WUZiDIfXrZ2dCqojtcPgNclg7GN7J6YYiJFp8HZcSvOMZauXOiAh/LQzLgQdt3yJBQIRtOo2SPL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=OnZ6/4kz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a589b7dd5fso72262381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1751985895; x=1752590695; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NzXFZEk6yErY6D/LjQRstWxZLYYVjR6/95xhHqGbv20=;
        b=OnZ6/4kzGFD7k0pSK2stL7IDrMFKy2Q1fNgKN113CuLiP5xMXzNqm1RK0mpP77IVXh
         pdR5CVi4JPBnTjx/x9iui7FExv9ufpbgBJ+P66qiG9oeECAckMQgXWxvadwkF/yU5d9q
         jfRcItcFSLCW2GUjgXa2sAyhcUGu1RYspODgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985895; x=1752590695;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzXFZEk6yErY6D/LjQRstWxZLYYVjR6/95xhHqGbv20=;
        b=ByWviWNy/ALAHiAGVvDygpS4SRTywDM8nHrdDy1ns2mIqY4p6b9cr6cNaHXa6B8zVB
         P6MPuJbNgm+mQBascnCBEN22saOFZ0ksa77bWmWFhBjUHtG5mZFCOA8EwP3ipk8LkXZz
         oWv5pSaC1CWafOxTUBKwuBhya3J35htFgx2LUb8Yhc7KjM3jX9Bk0OLfLiWpzU7LRNzn
         FQxITa/Wo1ZZ/iaojjwDKqszjGHMsH5ganv2PZM7vKQ6u2UaSMg8ZxHoK/3J4igGGnkR
         EGc6yXetO6w/RPMykfCidyTsOGuMRxDdtStFZ31kVVK3y41hlgirhoLp9XFr/Md3Gpp4
         F9fg==
X-Gm-Message-State: AOJu0YwG/o+GiRMJbqiWQMBtfq0rpObNv9GzmdTPizf+hqNyhJRzXHZY
	k7qmg75Zw/hTLe70FKRzmUJn/MzAnsDiitU5vHSzDjt57JUaLJNit6atF6cerVTTt0FuKnbkYWV
	uKHw=
X-Gm-Gg: ASbGncumw/P/WbYDbfUsGWStZPfcdQhl4+iIcYxy2IvhRODboDbE2vafeFFlzo1NO/V
	Hkd8Ea2/oo3+iOHknRpNU+C2lHUPk57JoZ9ruTwQO9gr3U5VWKqua00WPegEZz0Lp3J5P1yxpSq
	MBQ8/V+6aFTdviMYRb/L5JC+Pei4GFJZfkr1vXiHZpcMI0yNy5Pzyrr/ABMmXU8IaNIMe8lzQ2B
	0RmWoi4Grl82VRieTz8WJ9BzK6+LtCkydKneJpoHzscaMYjO2vP8jnCfg5CYk+keaQqEFwis0xl
	OzO3ZB0kMgEyl117U6TJzTobAeuWXUEO/nLYddtRK5Hy+wiCDttNBDPcVP9x67jBKk3GbhnEFhx
	kAhzSxg==
X-Google-Smtp-Source: AGHT+IHsUOny0OkJ2EB15KMJQvEZrTOer5pzJrOyVcvXVEprUMWypU/1HP1gAhVYH0BuTrhYNhwDPQ==
X-Received: by 2002:a05:622a:191e:b0:4a9:5220:7fc3 with SMTP id d75a77b69052e-4a9cc6ca287mr59779551cf.18.1751985894660;
        Tue, 08 Jul 2025 07:44:54 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a79106sm83843961cf.45.2025.07.08.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:44:54 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 8 Jul 2025 10:44:49 -0400 (EDT)
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc: "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
Message-ID: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello

the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
doesn't look obviously perf related but since the perf_fuzzer triggered it 
I thought I'd report it as a perf issue first.  I can work on a smaller 
test case but that might take a bit especially as the machine locks up 
super hard and requires being unplugged after it's triggered.

let me know if there's any other info I can provide.  The dump below is 
transcribed from a screenshot as I still haven't figured out a way to get 
a serial console on this Raptorlake system.

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
Hardware name: Dell Inc. Precision 3660/0VJ7G2
RIP: 0010:rb_insert_color+0x18/0x130
Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
RAX: ffff93f1927f8168 .....
...
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
DR0: 00000000a000001 ....
PKRU: 55555554
Call Trace:
 <TASK>
 timerqueue_add+0x66/0xb0
 hrtimer_start_range_ns+0x102/0x420
 ? next_zone+0x42/0x70
 tick_nohz_stop_tick+0xce/0x230
 tick_nohz_idle_stop_tick+0x70/0xd0
 do_idle+0x1d3/240
 cpu_startup_entry+0x29/0x30
 start_secondary+0x119/0x140
 common_startup_64+0x13e/0x141
 </TASK>




