Return-Path: <linux-kernel+bounces-881417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2DC2828B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F33BEEC8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAA232785;
	Sat,  1 Nov 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYhUkmJQ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECD2264CD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014279; cv=none; b=tysew+H+1H/Jc8LgpxqM01MDNGiNS1+te29JOZ8lTsfdgarLN3Z8dicpv3pIvWw555JTmBUM9IPQv8Eg6ZefD7PATgMwdOv0/DzxI3tYmBDIOwOG9QQtTyVYSaVJGlmPhLq9ztqk+4tH6zFNQsiPq6HZ6wTntPXgJzIsDpEw954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014279; c=relaxed/simple;
	bh=8So3JWqBAaKGNy531dj+WUD85/H5vCwPpPit551+T8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG87mnp8a6AmlD9MYtW9gqctkbx7de+/q4YayMYuLK7b7WmY81t0aIvcvIAUIq0P6NaIj0V7PE8MYNjWbHnn/IUt9xCpmFviCkcA1L3Zx/wgZc3rwwoZsfThHXeJnjHFYWS4pFXAj6vEOWPBC0gFKemwFDPdREeczVy2D+QrPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYhUkmJQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so4023566b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762014277; x=1762619077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aSgDRnC58+tzmlVy5fG0Qm/V/R/8QzpyzJN1Q8zqG0=;
        b=AYhUkmJQ18hiMPhWiFHDHdhrx7FHSQlAGLf749XcpKWYi0lgZG9ON8eVlI0Fhv++ke
         AvL+r6bqJ9mGtfWEdDdOEkl+Sdxe82R+hbJaUbMXdOryRtchygJd3bXqlA4N9t0MkUqq
         YKP7CpZId4RxjA3OzumV+aXvBxyCC/syXCpaVWUbFfZ7SCjcCESsSk5ZVu5z8cR/kTpV
         UKlwlbPvDJoz4a/PWbMx2Yh4tv/BMdgL2uTIu5AL6/SiW3dS7h6dJLFTrbOXzxW8wsJC
         1WCBSOYCpIcRGodOk1lDJ47MS3/3nRVY+aumcNNrr4VPnuQtLC1Y04Eq5dbSu778cKKA
         t7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014277; x=1762619077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aSgDRnC58+tzmlVy5fG0Qm/V/R/8QzpyzJN1Q8zqG0=;
        b=VB5jbPEwhAYuIIRLJwmve6TUVjClDG+Aw7ksG2yPCgToz2uh6zhdzudOdeJ++sMB6Y
         v40UL9BuaJG+yHorFFJtPLPSVu+gnSY4TMuS7TZt4Ug8nIQmNWqToUO38mL/v8W7uKCZ
         nhF6jzd2Gzqt9KKah2uFCGryySLnYIHtG+TgOZHJR52Ao/7ypsZ10Xdv8b2FnEGiybkI
         n+WP5hImCxpyo12gpA5nClb3Farbd2vhscP+Ptn84yRUi2lEhS6sk8GWCeOYjHhVMYjC
         FW1ygcniPY/dG9D3udHcrIwVhSQkAtgIBlbrhTdeMyMwnSRclUVsLPEllo1lMIrc/Zxo
         Rpfg==
X-Forwarded-Encrypted: i=1; AJvYcCVBByVNyswwRxJiASspeXFLjsp58SVF8Xko45gFDvsFl+ZvtQL/c4uSxGqIwmm0oL5xG4O1e/8f9Qhz9Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhBDwFjNLfD4waoIJYVhv/+iLp1AI66nuK2MFIcjS4Qpmc3Ji
	hAdZ54CVBPyRVkpDXq2C3MN1GjsQsL5FiENNvdZ2LYUnqNdYDwqvpLOHfwtODA==
X-Gm-Gg: ASbGnct277BSE50Rnf7R8kB8TfdOycZrtIAf7WoptTUvOisf6qJ6/5g4AddkAJuJcds
	DNcQ1VhYDMAaQ8I6pGgjjMI4/nXDgNO0B02Ejhql6O3yyCKV9M074ctLhfP8sug8Gchbd6S0nrk
	BbC/7E6VJkYxeB6LEpvXHFgtL4ej0OhpJ3/kd9LWNoFZ/I4QxOv3WdWYeUUXGdvpTBa+7dtI6uI
	J2s2LUrxFW0DnM27SpGnlZAmJjdDTf6LcQR9+aF8RIeWPQ+iza6ezZ0DJqZ4Xp27kJPhT1E+OlA
	S4lPeZK83WVMcw0KRQQneYy/kE3Liezzf8rvFba7UM/B3spw+d1RkFDGpsHXztgtx1o5DyULX3q
	ZmRKh5nV7z4sIOlPpwZ9cBLdAOPp9D5IN2Wf3zqBZQ7E0aGnhlZNLKxu6GP22kJ0bIrB14p4zWa
	+GbjmQdFts0eh8
X-Google-Smtp-Source: AGHT+IE5ERDcIYkSeS+YaI98r5jzYTcH57ZVQ0eSBaZ2r+j5WnN1dN7b8IWn/4yF1SfT78as6572ew==
X-Received: by 2002:a05:6a20:728e:b0:33e:774e:f5ad with SMTP id adf61e73a8af0-348cbe9f3e7mr11610791637.32.1762014277160;
        Sat, 01 Nov 2025 09:24:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340d1a4a587sm1666225a91.3.2025.11.01.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:24:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 1 Nov 2025 09:24:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next] mei: hook mei_device on class device
Message-ID: <8deef7c4-ac75-4db8-91b7-02cf0e39e371@roeck-us.net>
References: <20250826125617.1166546-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826125617.1166546-1-alexander.usyskin@intel.com>

Hi,

On Tue, Aug 26, 2025 at 03:56:17PM +0300, Alexander Usyskin wrote:
> mei_device lifetime was managed by devm procedure of parent device.
> But such memory is freed on device_del.
> Mei_device object is used by client object that may be alive after
> parent device is removed.
> It may lead to use-after-free if discrete graphics driver unloads
> mei_gsc auxiliary device while user-space holds open handle to mei
> character device.
> 
> Connect mei_device structure lifteme to mei class device lifetime
> by adding mei_device free to class device remove callback.
> 
> Move exising parent device pointer to separate field in mei_device
> to avoid misuse.
> 
> Allocate character device dynamically and allow to control its own
> lifetime as it may outlive mei_device structure while character
> device closes after parent device is removed from the system.
> 
> Leave power management on parent device as we overwrite pci runtime
> pm procedure and user-space is expecting it there.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14201
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

This patch results in:

[   20.260342] mei mei0: wait hw ready failed
[   20.264530] mei mei0: hw_start failed ret = -62 fw status = 00070355 002F0006 00000000 00000000 00000000 00000000
[   22.308353] mei mei0: wait hw ready failed
[   22.312489] mei mei0: hw_start failed ret = -62 fw status = 00070355 002F0006 00000000 00000000 00000000 00000000
[   24.356433] mei mei0: wait hw ready failed
[   24.360577] mei mei0: hw_start failed ret = -62 fw status = 00070355 002F0006 00000000 00000000 00000000 00000000
[   24.370911] mei mei0: reset: reached maximal consecutive resets: disabling the device
[   24.378787] mei mei0: reset failed ret = -19
[   24.383079] mei mei0: link layer initialization failed.
[   24.388329] mei_me 0000:00:16.0: init hw failure.
[   51.219835] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0:4:838]
[   79.219833] watchdog: BUG: soft lockup - CPU#0 stuck for 52s! [kworker/0:4:838]
[  107.219832] watchdog: BUG: soft lockup - CPU#0 stuck for 78s! [kworker/0:4:838]
[  135.219831] watchdog: BUG: soft lockup - CPU#0 stuck for 104s! [kworker/0:4:838]

when trying to run v6.18-rc1/2/3 on a Skylaker server with non-functional MEI support.
The problem is only seen if various debug options are enabled. Reverting the MEI
patches since 6.17 fixes the problem (reverting this patch alone is not possible).

Bisect log and more verbose backtracec attached for reference.

Please let me know if there is anything I can do to help tracking down the problem.

Thanks,
Guenter

----
Backtrace:

[   93.187907] watchdog: BUG: soft lockup - CPU#0 stuck for 52s! [kworker/0:2:834]
[   93.187909] Modules linked in:
[   93.187909] irq event stamp: 523739110
[   93.187910] hardirqs last  enabled at (523739109): [<ffffffffa43975d7>] work_grab_pending+0x1a7/0x360
[   93.187912] hardirqs last disabled at (523739110): [<ffffffffa5203b9e>] sysvec_apic_timer_interrupt+0xe/0x90
[   93.187914] softirqs last  enabled at (523364938): [<ffffffffa4378d9b>] __irq_exit_rcu+0x6b/0x140
[   93.187916] softirqs last disabled at (523364933): [<ffffffffa4378d9b>] __irq_exit_rcu+0x6b/0x140
[   93.187918] CPU: 0 UID: 0 PID: 834 Comm: kworker/0:2 Tainted: G             L      6.18.0-dbg-DEV #2 NONE
[   93.187920] Tainted: [L]=SOFTLOCKUP
[   93.187920] Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.116.4 08/29/2025
[   93.187922] Workqueue: events work_for_cpu_fn
[   93.187923] RIP: 0010:work_grab_pending+0x36/0x360
[   93.187925] Code: 41 54 53 48 83 ec 38 49 89 d7 89 34 24 48 89 fb 65 48 8b 05 cc eb 66 03 48 89 44 24 30 48 8d 47 48 48 89 44 24 08 eb 02 f3 90 <9c> 8f 44 24 28 48 8b 44 24 28 fa 49 89 07 a9 00 02 00 00 74 05 e8
[   93.187927] RSP: 0000:ffffb51d9b59fc60 EFLAGS: 00000202
[   93.187928] RAX: 94f926a301ea6700 RBX: ffff9afc8231b418 RCX: 0000000000000002
[   93.187928] RDX: 0000000000000006 RSI: ffff9afc81b70b20 RDI: ffffffffa43975d7
[   93.187929] RBP: 0000000000000002 R08: 00000000000e00c8 R09: ffffffffffffffff
[   93.187930] R10: ffffffffa43974b2 R11: 0000000000000000 R12: ffffffffa66e0848
[   93.187930] R13: ffffffffa439de1d R14: ffffffffa43974b2 R15: ffffb51d9b59fcd0
[   93.187931] FS:  0000000000000000(0000) GS:ffff9b59d8812000(0000) knlGS:0000000000000000
[   93.187932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   93.187932] CR2: ffff9bba9ffff000 CR3: 0000005c0b44c001 CR4: 00000000007706f0
[   93.187933] PKRU: 55555554
[   93.187934] Call Trace:
[   93.187934]  <TASK>
[   93.187936]  ? lock_release+0x100/0x340
[   93.187939]  ? process_scheduled_works+0x26d/0x630
[   93.187941]  __cancel_work+0x29/0xf0
[   93.187945]  cancel_work_sync+0x18/0x80
[   93.187947]  mei_cancel_work+0x19/0x40
[   93.187950]  mei_me_probe+0x2bf/0x330
[   93.187952]  ? process_scheduled_works+0x26d/0x630
[   93.187954]  local_pci_probe+0x45/0x90
[   93.187957]  work_for_cpu_fn+0x1b/0x30
[   93.187959]  process_scheduled_works+0x2d3/0x630
[   93.187965]  worker_thread+0x1e8/0x2f0
[   93.187969]  kthread+0x21f/0x240
[   93.187972]  ? __pfx_worker_thread+0x10/0x10
[   93.187974]  ? lock_release+0x100/0x340
[   93.187975]  ? ret_from_fork+0x2d/0x2b0
[   93.187979]  ? __pfx_kthread+0x10/0x10
[   93.187982]  ret_from_fork+0x197/0x2b0
[   93.187984]  ? __pfx_kthread+0x10/0x10
[   93.187986]  ret_from_fork_asm+0x1a/0x30
[   93.187994]  </TASK>

---
Bisect log:

# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
# bad: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect bad 6a74422b9710e987c7d6b85a1ade7330b1e61626
# good: [b66451723c45b791fd2824d1b8f62fe498989e23] Merge tag 'platform-drivers-x86-v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect good b66451723c45b791fd2824d1b8f62fe498989e23
# good: [59697e061f6aec86d5738cd4752e16520f1d60dc] Merge tag 'staging-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 59697e061f6aec86d5738cd4752e16520f1d60dc
# good: [561285d048053fec8a3d6d1e3ddc60df11c393a0] MAINTAINERS: Support ROHM BD79112 ADC
git bisect good 561285d048053fec8a3d6d1e3ddc60df11c393a0
# bad: [eafedbc7c050c44744fbdf80bdf3315e860b7513] rust_binder: add Rust Binder driver
git bisect bad eafedbc7c050c44744fbdf80bdf3315e860b7513
# good: [0c82fd9609a1e4bf1db84b0fd56bc3b2773da179] ibmasm: Replace kzalloc() + copy_from_user() with memdup_user_nul()
git bisect good 0c82fd9609a1e4bf1db84b0fd56bc3b2773da179
# bad: [ef509269d93d9832b366005f9626b44e38cc0ca7] Merge tag 'counter-updates-for-6.18' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
git bisect bad ef509269d93d9832b366005f9626b44e38cc0ca7
# bad: [ae0de6333368fd8c4535f5dbdfe1b2660438e089] slimbus: messaging: fix "transfered"->"transferred"
git bisect bad ae0de6333368fd8c4535f5dbdfe1b2660438e089
# bad: [7704e6be4ed2835832c445807cdcb2d56d8a8430] mei: hook mei_device on class device
git bisect bad 7704e6be4ed2835832c445807cdcb2d56d8a8430
# good: [ceda408c0d1d41094ad125332c6fb1d488e61c0c] misc: remove ineffective WARN_ON() check from misc_deregister()
git bisect good ceda408c0d1d41094ad125332c6fb1d488e61c0c
# good: [76254bc489d39dae9a3427f0984fe64213d20548] cdx: Fix device node reference leak in cdx_msi_domain_init
git bisect good 76254bc489d39dae9a3427f0984fe64213d20548
# first bad commit: [7704e6be4ed2835832c445807cdcb2d56d8a8430] mei: hook mei_device on class device

