Return-Path: <linux-kernel+bounces-890890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E8C414D1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2573E4E1CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF033858E;
	Fri,  7 Nov 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVDDe2rW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D45268690
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540741; cv=none; b=Xm9QUdtyZ++hCf8HQN5nNiiaYNgthlY9PJEYYkiH52RxZBfnKCh4vXGuCM0SkeBeHG4ckT+9uoc3gbAc/fz37g1zXt/2UbEP766hRoWJv2JQbfv/JnwqFXimVO8Gy0fMWR4iplr9mX18Ia2qcUMfGO+2IQLGXl6KvbmPnGzuSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540741; c=relaxed/simple;
	bh=gKCYs2zBDI2I9vwzLZl5xzGcHJgiZqc2ZlXjUmJtqXs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lcigV2mxd55XchzVmQw4/JU5sm8IIi+3hGgQ2bEIeTd1Qm2Mv/jfeMQDl5+0GuHvIQN9DDn4FSETgM/kj9L8kM4DZCi5mDcwaVLj5eWci7g7+SATydPfEir4MJ5DNq/Q7g9hWnFZAW0ZB4kZVfhHcdsZo/7LqRO2uqsrAwM3xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVDDe2rW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1394644a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540738; x=1763145538; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B39IJ+XWXT40oXnxSi3w//eJpYlaFUdn5FoedhvPszU=;
        b=OVDDe2rW0F1PYt7bK3yarlm9g5aIC3f8lF4qX94VL+ILbL4hPIseIw98BkQvxhnMQu
         eZrbmJhX3LQtZR1M6fcOh2oCVLSehBzaH5OfPTj2cEX/sVORxoNLf3dcMqOfwikEUE2/
         R1RKcSFrZO67kclmxH3+w4/CS6C8NLBA4vESfBOwUjgzNdWRVGToTdDzHifz0vwu/mVK
         /c02mYOJe88n1/hKb6s3nlgoz/qx/mYJFgwOkrz1p3TU/FLK1Rt5bK3oYr1vd/Bglh0j
         IzAFERAcP1sviFZ9bALkRBdCwlz0cDxrzMvoVNWhhgEjAOeOdIKfnS8UNzIXjg59tugA
         kIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540738; x=1763145538;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B39IJ+XWXT40oXnxSi3w//eJpYlaFUdn5FoedhvPszU=;
        b=fcoxwbajT5jln1Yx0CND6wRFpjn95pMUWdIsLYChJN4GmA4BaqMwAdUKpEY0J8q6jk
         7VFK+TB00zpbcP5LVpQsFxVsGxWkq3kWBIKb6NKE+iNGzTrSH8LfG87YwDkwgVYBcQY0
         WM2x5EUI3h2U8WtOCnmNjWjpbsm7yt9wTKf+84p0fxxYNMfZCx4my+DEZzXqoqX03MEv
         4soORUsJbnZm8vS7+4wDcBa+A95tcf4dX6FsT95fj/hhmNufyF/Lj4tIU/R410OwMVp1
         MW1L+9tSbcfMjUQnmr++hCiqBceA7e2CYOaRaRFd+1ndp78C8m+9j8OFsgaP4UL4TTQ/
         Mv3g==
X-Forwarded-Encrypted: i=1; AJvYcCUkqpiRTt+J7VgWRVeRalrvqvAPnV5cNr5GfJ16xcvK3LpgmRczoJmTM7swqYdS0GAXsq617b7TsUOzdiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdDodkkdOtyxic5zINDLSMx54yItFqwv+YrRemkaR6JkkRPrc
	FUsJ/dxSQoS0+X4+aaZOkgNQO+2foiQ1CSEQK0VqooIRP5Q1FPea0E+W7tXqVFIvOd4xzZ5KUTO
	f7AFXt3yINht3kGAwjidn9Ht8brWFfHo=
X-Gm-Gg: ASbGncuht+zjXw6B4N7MhEJJU8SnA2u/z4DOC0U2Y5AcWqNkpTEGeNntdqCOaDhAYDk
	d5Q4isekXpHYyflKT4QR/lnddRzTDG6iExg4n1C19tARu+Cz+H8FLmEg59n7INm1N/glXCnjI2m
	qFXmD0RRR8Gl7MaCA/o0BzzA5hZ5n+DOz5TL/zd6CBJSCh3X6+uTTQPCtmhPVeGEWzW6pgqIbmK
	JPaNxJ2U9Eyv++kyYslODj/hKsSRpa1tYuJ4XYN7GtfEgoRKd8Z+z4oAwFGHg==
X-Google-Smtp-Source: AGHT+IEfC9/xtwBnqad9fFzSxPyCtmWduH1ctIXk+JsraeDvSWpIui7wG4K8ICg2nk/D1ExwgrKzSF5XdugPxj2RBuI=
X-Received: by 2002:a05:6402:1450:b0:640:464a:56ce with SMTP id
 4fb4d7f45d1cf-6415dc006e1mr29283a12.2.1762540738335; Fri, 07 Nov 2025
 10:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Philippe Simons <simons.philippe@gmail.com>
Date: Fri, 7 Nov 2025 19:38:47 +0100
X-Gm-Features: AWmQ_bkHIOfF7n3QsiGcjLcgrQEkuEHG2jnWo9Mn_6nLZ3uw5-9DHQVVGAeOO4w
Message-ID: <CADomA4-WZJbuBV=WEmeKDHvtT4o47k90=2jSWSj8Tdmb+6iJTg@mail.gmail.com>
Subject: Kernel ooops in CCU on H700
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I'm having a kernel oops during boot on H700, and I think it's also
happening on H616.
It seems to be related to interaction with panfrost freq.
Kernel oops doesn't prevent the GPU from working, at least I'm able to
bring wayland,
but sometimes the GPU seems to hang later, unclear what triggers it,
and there are no ooops...

Here is the kernel log

[   12.293156] ------------[ cut here ]------------
[   12.293185] WARNING: CPU: 0 PID: 904 at
drivers/clk/sunxi-ng/ccu_common.c:38
ccu_helper_wait_for_lock.part.0+0x78/0xa0
[   12.293221] Modules linked in: hci_uart btrtl bluetooth
rocknix_singleadc_joypad
[   12.293254] CPU: 0 UID: 0 PID: 904 Comm: gpu_overclock Tainted: G
     W           6.17.7 #1 PREEMPT
[   12.293266] Tainted: [W]=WARN
[   12.293271] Hardware name: Anbernic RG40XX H (DT)
[   12.293277] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.293285] pc : ccu_helper_wait_for_lock.part.0+0x78/0xa0
[   12.293297] lr : ccu_helper_wait_for_lock.part.0+0x4c/0xa0
[   12.293308] sp : ffff800082b93760
[   12.293312] x29: ffff800082b93760 x28: ffff00000a761140 x27: 0000000000000000
[   12.293327] x26: 0000000000000000 x25: ffff000003616fa0 x24: 0000000000000000
[   12.293341] x23: ffff800082b93800 x22: 0000000000000002 x21: 00000002dc980343
[   12.293354] x20: 0000000010000000 x19: 0000000028002201 x18: 0000000000000000
[   12.293368] x17: 0000000000000000 x16: 0000000000000000 x15: 24cab3646a9395e6
[   12.293381] x14: 0000000000000000 x13: ffff00000a7611c0 x12: 000000000000b67e
[   12.293395] x11: 00000000000000c0 x10: 0000000000000a80 x9 : ffff800082b93610
[   12.293409] x8 : ffff00000a761c20 x7 : ffff00000a7611c0 x6 : 0000000000000001
[   12.293423] x5 : 00000001f7251325 x4 : 0000000000000002 x3 : 000000000001706f
[   12.293436] x2 : 0003c6685f2db0e6 x1 : 0000000000001b84 x0 : 00000002dc993b76
[   12.293451] Call trace:
[   12.293456]  ccu_helper_wait_for_lock.part.0+0x78/0xa0 (P)
[   12.293471]  ccu_pll_notifier_cb+0x50/0x80
[   12.293483]  srcu_notifier_call_chain+0x70/0xc0
[   12.293498]  __clk_notify+0x8c/0xd0
[   12.293511]  clk_change_rate+0xd8/0x2a0
[   12.293520]  clk_core_set_rate_nolock+0x198/0x2f0
[   12.293529]  clk_set_rate+0x38/0x150
[   12.293537]  _opp_config_clk_single+0x30/0xa0
[   12.293553]  _set_opp+0x134/0x4d0
[   12.293561]  dev_pm_opp_set_rate+0x1a8/0x2b0
[   12.293569]  panfrost_devfreq_target+0x3c/0x60
[   12.293582]  devfreq_set_target+0x90/0x190
[   12.293595]  devfreq_update_target+0xc0/0xe0
[   12.293605]  qos_max_notifier_call+0x30/0x70
[   12.293617]  blocking_notifier_call_chain+0x6c/0xa0
[   12.293628]  pm_qos_update_target+0xd0/0x110
[   12.293639]  freq_qos_apply+0x3c/0x80
[   12.293648]  apply_constraint+0x88/0x150
[   12.293660]  __dev_pm_qos_update_request+0x7c/0xe0
[   12.293671]  dev_pm_qos_update_request+0x38/0x60
[   12.293681]  max_freq_store+0x70/0xe0
[   12.293692]  dev_attr_store+0x18/0x30
[   12.293706]  sysfs_kf_write+0x7c/0xa0
[   12.293717]  kernfs_fop_write_iter+0x130/0x200
[   12.293731]  vfs_write+0x244/0x370
[   12.293743]  ksys_write+0x70/0x110
[   12.293752]  __arm64_sys_write+0x1c/0x30
[   12.293762]  invoke_syscall+0x48/0x110
[   12.293776]  el0_svc_common.constprop.0+0x40/0xe0
[   12.293788]  do_el0_svc+0x1c/0x30
[   12.293798]  el0_svc+0x30/0xf0
[   12.293813]  el0t_64_sync_handler+0xa0/0xf0
[   12.293822]  el0t_64_sync+0x198/0x19c
[   12.293833] ---[ end trace 0000000000000000 ]---

