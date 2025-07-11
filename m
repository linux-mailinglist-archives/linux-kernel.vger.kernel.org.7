Return-Path: <linux-kernel+bounces-727257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE0B0173B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7FA16EADF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8758250C06;
	Fri, 11 Jul 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jNJQLR+r"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4EA24E4BD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224897; cv=none; b=MksyzVN5kLCpn/MVnHm7v9qNvhMUZVmnRWXY7C51hxEjvjVD3DXMdaJnN4styYz7Vcyxs+gSptt4g4IoAwgjrasb8uGjK1DN7zSzOLZbwN39x11ZBgESRMYnimWzaMdv/bz9Gpuqebbtqlb3ow8IER7MSD3fygUHE2qZP1rSO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224897; c=relaxed/simple;
	bh=iequJv7B7n8YgIlgFIxmqeGXukC2iTcYBfrlgmpueQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2HrS6d0wIN3F+9HX+KtIvsUd9eLDVRzYlxjJW/OXpXR9Axnml3NZZmKkcXRqnR4KTWRiSHeCPqLGdGugQklYbxOM93qh6OzKHGgcWNtzTo4mX/o3EoVKI0svQw44RX/DsZ6SOAhXFgeVTIIMOQ9a5sN/o/h+9xWdy04jH8sL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=jNJQLR+r; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40aef72f252so542368b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752224894; x=1752829694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XXJJhy+U3k5gvxPpccx42pN94/IU5yQe/HPwiapn7A=;
        b=jNJQLR+rN+iINdQCFVJothv8W1PnTP/tTgqbYj+O2o5i3tU7fTB0FvmT+jw5Q1Es70
         XEZDq4s3UNmwGpmagQVli3jtDe7Gy1MXi88wG5oIEWrrOCzDZpoU841o6nH1ylLto1/h
         Ht7hoLaI85CCjny1MwiqB35+/aPjglkOsXg78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224894; x=1752829694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XXJJhy+U3k5gvxPpccx42pN94/IU5yQe/HPwiapn7A=;
        b=SJuceY0/ciltBZEDEk5sbR3I04WDIUpXidxylVsjocy5ljRUT+YwzbEuDupiKAUU0D
         uD6kf/zJxrubc/v3ZkN0Cz3wpSjLTeSkQuRZt6Ne96QVH2YDLm9LwGtqRBzTRORafEf4
         rjeJe7L6ZZcMEK+hgU4OMjyQtnvjpX8KTGs07ESFIqwWstToi9PzozMAe33QeikBkxhS
         IQD+jB79g6I2IuunkobjOx5vF3yR0QKibbvkQh2FKkKNpVJyUeM6RM6Fwmf7gES8vBHC
         xVfdomNSrFEWvQbVXFIkH6jlDIfZDJwmNPtxQ1jw4R7ip/owgD3e+mnhLTRjU0u19uFX
         CduA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPdtqwplAKsbaOuQqq0xPLHhNuLab/K/ZMSia1Gob9mtdxm5kI6Ol+TSuFQ6VM99cP8Vs0LF6fiS+WR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmPYQjDiy7mvJbVgVwRyP5xgnLRr9hcb0dhJulcK12HThcDLC
	ZNlF7vOTvDrRUCpsPb9T/3Vock8H5g/OdkZXs46puTst3qlPBhdZY1GjrYGS7xgcePw7pnZu+oL
	nrKj52+p7h2RxU8QwKhPWI5i+hoWbrI8B3LWXqcJSTA==
X-Gm-Gg: ASbGnct/PQuLlGF+vd84hALkIQQYwRCEomNNPF4i2wNiwAjtwWPuHf1jdSNE8pQbo9m
	qAM4NGatcd9CZ0CORR7bLAHSdvd+Tkf7nAB4Qw7xdnSmkgwMUZioCcXtRUGKnAfb8mkVKDadBwm
	8HwXJadIlrCayGFrgz+jJl4TqBAewePJDr7hpq62TqETb1OdV4Hccs54W/TpRiYK8PzMrfoxdLG
	LVEh+tjroBdiKjFGf1YDVPoJF1yAh7+C88a8bZQs8SB2b8=
X-Google-Smtp-Source: AGHT+IFcAouWMXXQM8B7V4KLQu1xy86l+CgTbd5aoZM72dZ/yi5Z4/4mq1o6lT3woytFmkQlDVSULy3tTQmzPTG2yOI=
X-Received: by 2002:a05:6808:16a9:b0:40b:1597:b2d1 with SMTP id
 5614622812f47-4150e31e356mr2108092b6e.17.1752224894172; Fri, 11 Jul 2025
 02:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a087cfd-bd4c-48f1-aa2f-4a3b12593935@oss.qualcomm.com>
In-Reply-To: <0a087cfd-bd4c-48f1-aa2f-4a3b12593935@oss.qualcomm.com>
From: Simona Vetter <simona.vetter@ffwll.ch>
Date: Fri, 11 Jul 2025 11:08:03 +0200
X-Gm-Features: Ac12FXy4nqEh1oT4fQDEt08bX866kDDeTYEZ2441A8ZY1XxQ_jSXmu0yOuXQu58
Message-ID: <CAKMK7uH7Hcviwyw2wZK=WVxcb4zBC+EKpsREhb4FHe_AxEi8gg@mail.gmail.com>
Subject: Re: WARNING: possible circular locking dependency detected:
 drm_client_dev_suspend() & radeon_suspend_kms()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	"Nikula, Jani" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>, 
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 10, 2025 at 04:43:02PM -0700, Jeff Johnson wrote:
> I'm trying to debug a hibernation issue with the ath12k driver, but to
> establish a baseline I started with Linus' current tree. I have the following
> enabled in my .config:
>
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> CONFIG_PROVE_RCU=y
>
> As part of the baseline I observed the following:

On a very quick guess I'd bet on the drm_client conversion for i915 to
have broken something here. Adding more people.
-Sima


>
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ======================================================
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: WARNING: possible circular locking dependency detected
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 6.16.0-rc5+ #6 Not tainted
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ------------------------------------------------------
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: kworker/u16:13/3787 is trying to acquire lock:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffff8881113e0308 (&dev->clientlist_mutex){+.+.}-{4:4}, at: drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            but task is already holding lock:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            which lock already depends on the new lock.
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            the existing dependency chain (in reverse order) is:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            -> #1 (console_lock){+.+.}-{0:0}:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        console_lock+0x8d/0x130
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fb_helper_set_suspend_unlocked+0x10e/0x200 [drm_kms_helper]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fbdev_client_suspend+0x24/0x30 [drm_client_lib]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x138/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_drm_suspend.isra.0+0x74/0x260 [i915]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_pm_suspend+0x6b/0x90 [i915]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            -> #0 (&dev->clientlist_mutex){+.+.}-{4:4}:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __lock_acquire+0x15b5/0x2ac0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        lock_acquire+0x154/0x2d0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __mutex_lock+0x15f/0x12c0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        radeon_suspend_kms+0x648/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            other info that might help us debug this:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  Possible unsafe locking scenario:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        CPU0                    CPU1
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ----                    ----
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(console_lock);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(&dev->clientlist_mutex);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(console_lock);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(&dev->clientlist_mutex);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                             *** DEADLOCK ***
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 4 locks held by kworker/u16:13/3787:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #0: ffff888100dee148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0xe97/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #1: ffff88813f22fd30 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #2: ffff8881049241b0 (&dev->mutex){....}-{4:4}, at: device_suspend+0x3bd/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #3: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            stack backtrace:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: CPU: 0 UID: 0 PID: 3787 Comm: kworker/u16:13 Not tainted 6.16.0-rc5+ #6 PREEMPT(voluntary)
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Workqueue: async async_run_entry_fn
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Call Trace:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  <TASK>
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x5b/0x80
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  print_circular_bug.cold+0x178/0x1be
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  check_noncircular+0x130/0x150
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? 0xffffffffc1600000
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __lock_acquire+0x15b5/0x2ac0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  lock_acquire+0x154/0x2d0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_stack_trace_save+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? acpi_ut_release_mutex+0xba/0x150
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __mutex_lock+0x15f/0x12c0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? add_lock_to_list+0x2c/0x1b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx___mutex_lock+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_acquire+0x154/0x2d0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  radeon_suspend_kms+0x648/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_radeon_pmops_suspend+0x10/0x10 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  pci_pm_suspend+0x1e3/0x4f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_pci_pm_suspend+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dpm_run_callback+0xa0/0x100
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_dpm_run_callback+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  device_suspend+0x41e/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_device_suspend+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_async_suspend+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_suspend+0x1d/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_run_entry_fn+0x96/0x3e0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x86e/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_process_one_work+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? assign_work+0x16c/0x240
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x5d0/0xfc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  kthread+0x375/0x750
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? ret_from_fork+0x1f/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_release+0xc6/0x2a0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x215/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  </TASK>
>
> This doesn't seem to be the cause of the ath12k issue I'm debugging,
> but thought it worth mentioning since I only see one similar report
> on lore, and that didn't have any apparent follow-up:
> https://lore.kernel.org/all/20250202161048.373f89c0@yea/
>
> /jeff

--
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

