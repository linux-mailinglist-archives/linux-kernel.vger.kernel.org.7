Return-Path: <linux-kernel+bounces-856665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B111FBE4BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3766F359C47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5DE32FF79;
	Thu, 16 Oct 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fe5ajnb/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93032FF74
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633899; cv=none; b=ZBQ/AK4baHEA0sW07M3ySTQQRyr1Y37WNMhXQzf/nvnAwzmkuu4P+2RIm1P2D1r0sgF7HPmBVmGQBXiM1BG6/X6hRJq3wTA/95ny4x98CULWifvlaDqcde5eTFliD7VKwBxFw2yaOghvFtvIopqqcf82gj1XMz+J3mz9qzTM0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633899; c=relaxed/simple;
	bh=L7O2KfBMjBbT9L93+k/7V/s6GzTe/neKt0glwdP/so0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lGE1HIIIkdfGHmRYQEcNyo6XX3qM1NqzRvoEhYNasI8nqTUUNeEfSHC7Esdbr6D6NmLQvjUvpgf56X5zSmpl38ZyLJ7AXJ7qBtjNl1Vy8babOmX3VxR9Io2xdwUk9PNW/vVBV3OQsqKhXE3HN8yRB4vl8lBBGkaQM2AEe2n1w4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fe5ajnb/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760633896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NZT2tboVN0E64vRFeB0poMqMa1JXhNV9D+gVl7IyiEo=;
	b=fe5ajnb/64gmm1P4jFJRA58uGF0AdOWrYwSv7x4qzOsWx761/AT1ZWwcBqne0MQCuTSw6/
	iMDzkoQmbsqm8pH+6oACBZQ/k4c4/TITwz7a2TvKJ8GXLgFUGh5IBZ4XkuNIgt3xuOF+Of
	9qqSXha+d8XkeRezxH1SOBZLTwHi7Vc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-66mPj_4iMDaaiuU8-jGd7A-1; Thu, 16 Oct 2025 12:58:13 -0400
X-MC-Unique: 66mPj_4iMDaaiuU8-jGd7A-1
X-Mimecast-MFC-AGG-ID: 66mPj_4iMDaaiuU8-jGd7A_1760633892
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-371ea8a8152so12094401fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760633891; x=1761238691;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZT2tboVN0E64vRFeB0poMqMa1JXhNV9D+gVl7IyiEo=;
        b=szOK+WB9X1Va6WxJRH6wHpqDTRyU5mnM2vJJurgorlEJ1joAa+ClG6zYEhUMCFVrt1
         zqguJ4IhmMWGsTBj/aDnpu3U9Kxagv0Z8ZfjFHIwzC1mIkD0lpdpnMaoLNwQ9CrwvSjo
         fH144RZRNj/ZfkosdGyokhKyyRx16LN1g9ZpVWkl/e4hPmd1N+gfFV/xzJ5I21mvcGG0
         qYaLKy/bC50cYAEaQKjyrRVwl8hi65jYnIANNk82X5jO1FmLeWV/MvnfibudSA4gEDtc
         hnGQiHVD2VRU8YWfJaWYAsRVLT3Z4l7FKDcuJbpJ3wCr42SU2Ci5fFQTFhZXYFs6oJxj
         IZSQ==
X-Gm-Message-State: AOJu0Yz3Smm9herwR6crz0CO1lkr1qbPFnoopVQ9ivOOvOxF29iscug+
	zLU7NFQRUbqEU61o+1P0ZjB8fOhLViypcgmEVSPO9xJ6M19HfhggnBeAEF+amZExRFO8ruL28Ce
	hs57WGcRfpqmjtblPIQWCyx5OgcY82Tz9jzGu7ltFGXnh749kPlEa6PCxNX5PzV0c0WKFJoJB3z
	GE0v9VBXTBDJVRfMKtn0ExcteNtFD6QxFc+TlI79293mSOLgsFt7M=
X-Gm-Gg: ASbGncuN9lOpcEqSXs7tJmUKSMkcVrOaTnSRa95xZa57MaXiy9SMwqQO3IdNlNwjJYg
	SMKlwJD8gGhhkZYuWpeQIOmtO5QJdCHXKy1fXpKTySJJVCeBoolZgUuMDKAyzpFtiX5eK+Z4PwH
	OCMKwwARs3MCT24/24YyE0El8DEJbRT0ln/YuMapb4AN1KxS4anZaISt0=
X-Received: by 2002:a2e:b893:0:b0:335:352a:3c3 with SMTP id 38308e7fff4ca-37797785e43mr2700511fa.8.1760633890969;
        Thu, 16 Oct 2025 09:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzaFrED8lLs19fYxkrH256an+nOGcgznrqA/81ek+YxZeyHFf5z2HINnAYH7R/lAvfGoakAqMukueS9NKC/Ww=
X-Received: by 2002:a2e:b893:0:b0:335:352a:3c3 with SMTP id
 38308e7fff4ca-37797785e43mr2700391fa.8.1760633890475; Thu, 16 Oct 2025
 09:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jirka Hladky <jhladky@redhat.com>
Date: Thu, 16 Oct 2025 18:57:57 +0200
X-Gm-Features: AS18NWDubeBKj-YHErSX8lC4k2YMlnP0Pqq_xvHXGEtiMYL-_9TlFh-rpaxbp6M
Message-ID: <CAE4VaGDfiPvz3AzrwrwM4kWB3SCkMci25nPO8W1JmTBd=xHzZg@mail.gmail.com>
Subject: BUG: NULL pointer dereference in update_qos_requests() triggered by
 writing to /sys/devices/system/cpu/intel_pstate/min_perf_pct (6.18-rc1)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Kamil Kolakowski <kkolakow@redhat.com>, "spetrovi@redhat.com" <spetrovi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are observing a kernel panic on various Intel servers (Skylake, Ice
Lake) running kernel 6.18.0-0.rc1. The crash is caused by a NULL
pointer dereference in update_qos_requests() when the tuned daemon
writes CPU QoS settings from the default tuned-performance profile.

Triggering setting:
======================================================
/usr/lib/tuned/tuned-performance/tuned.conf
[cpu]
min_perf_pct=100
governor=performance
energy_perf_bias=performance
energy_performance_preference=performance
======================================================

This tuned profile causes the kernel panic when tuned starts, likely via:

echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct

Example log:

BUG: kernel NULL pointer dereference, address: 0x38
RIP: 0010:update_qos_requests+0x7c/0xf0
PID: 1794 Comm: tuned
Call Trace:
store_min_perf_pct+0xb7/0x120
kernfs_fop_write_iter+0x14d/0x200
vfs_write+0x25d/0x480
ksys_write+0x73/0xf0
do_syscall_64+0x7c/0x800

Thank you!
Jirka

[      OK    ] Started polkit.service  Authorization Manager.
[   14.936180] BUG: kernel NULL pointer dereference, address: 0000000000000038
[   14.943996] #PF: supervisor read access in kernel mode
[   14.949763] #PF: error_code(0x0000) - not-present page
[   14.955531] PGD 178c1a067 P4D 0
[   14.959154] Oops: Oops: 0000 [#1] SMP NOPTI
[   14.963841] CPU: 14 UID: 0 PID: 1991 Comm: tuned Tainted: G S
          ------  ---  6.18.0-0.rc1.16.eln152.x86_64 #1 PREEMPT(lazy)
[   14.977798] Tainted: [S]=CPU_OUT_OF_SPEC
[   14.982200] Hardware name: Abacus electric, s.r.o. -
servis@abacus.cz Super Server/X12SPW-F, BIOS 1.2 02/14/2022
[   14.993621] RIP: 0010:update_qos_requests+0x7c/0xf0
[   14.999101] Code: 48 63 d2 48 c7 c7 80 77 29 97 e8 1f 39 bc ff 3b
05 39 c3 9c 01 48 89 c3 73 66 48 8b 15 7d b5 68 02 48 63 c3 89 df 4c
8b 24 c2 <41> 8b 6c 24 38 e8 fa 2d ff ff 49 89 c6 48 85 c0 74 bb 4c 8b
b8 40
[   15.020167] RSP: 0018:ff71393407197c50 EFLAGS: 00010293
[   15.026031] RAX: 0000000000000024 RBX: 0000000000000024 RCX: 0000000000000024
[   15.034040] RDX: ff713934001bd000 RSI: 0000000000000000 RDI: 0000000000000024
[   15.042048] RBP: 0000000014dc9380 R08: ffffffff97297780 R09: 0000000000000087
[   15.050057] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   15.058065] R13: fffffffffffffff2 R14: ff29dd01cbeca800 R15: ff29dd01c2ff8580
[   15.066074] FS:  00007f472984f6c0(0000) GS:ff29dd40a6828000(0000)
knlGS:0000000000000000
[   15.075156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.081603] CR2: 0000000000000038 CR3: 00000001124e0001 CR4: 0000000000773ef0
[   15.089612] PKRU: 55555554
[   15.092646] Call Trace:
[   15.095390]  <TASK>
[   15.097746]  store_min_perf_pct+0xb7/0x120
[   15.102345]  kernfs_fop_write_iter+0x14d/0x200
[   15.107334]  vfs_write+0x25d/0x480
[   15.111152]  ksys_write+0x73/0xf0
[   15.114871]  do_syscall_64+0x7c/0x800
[   15.118980]  ? __do_sys_newfstat+0x44/0x70
[   15.123570]  ? syscall_exit_work+0x143/0x1b0
[   15.128363]  ? clear_bhb_loop+0x30/0x80
[   15.132660]  ? clear_bhb_loop+0x30/0x80
[   15.136965]  ? clear_bhb_loop+0x30/0x80
[   15.141260]  ? clear_bhb_loop+0x30/0x80
[   15.145566]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   15.151236] RIP: 0033:0x7f472b534e4f
[   15.155257] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 59 74
f9 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 ac 74 f9
ff 48
[   15.176328] RSP: 002b:00007f472984e130 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[   15.184824] RAX: ffffffffffffffda RBX: 00007f472984f638 RCX: 00007f472b534e4f
[   15.192832] RDX: 0000000000000003 RSI: 00007f472401b670 RDI: 000000000000000a
[   15.200840] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000002
[   15.208849] R10: 00007f47299116c0 R11: 0000000000000293 R12: 00007f472401b670
[   15.216857] R13: 000000000000000a R14: 000055f431e37b00 R15: 000055f431bbbba2
[   15.224866]  </TASK>
[   15.227318] Modules linked in: rfkill sunrpc vfat fat ext4 crc16
mbcache jbd2 intel_rapl_msr iTCO_wdt iTCO_vendor_support
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm dax_hmem cxl_acpi ipmi_ssif
rndis_host cxl_port irqbypass rapl intel_cstate cxl_core intel_th_gth
mei_me cdc_ether isst_if_mbox_pci isst_if_mmio igb i2c_i801 ioatdma
intel_th_pci ast intel_uncore usbnet einj isst_if_common pcspkr
i2c_smbus intel_pch_thermal mei acpi_power_meter intel_th intel_vsec
dca i2c_algo_bit mii ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler
joydev acpi_pad loop fuse dm_mod nfnetlink xfs ahci nvme libahci
nvme_core libata nvme_keyring ghash_clmulni_intel nvme_auth hkdf
[   15.305080] CR2: 0000000000000038
[   15.308798] ---[ end trace 0000000000000000 ]---
[   15.375282] RIP: 0010:update_qos_requests+0x7c/0xf0
[   15.380761] Code: 48 63 d2 48 c7 c7 80 77 29 97 e8 1f 39 bc ff 3b
05 39 c3 9c 01 48 89 c3 73 66 48 8b 15 7d b5 68 02 48 63 c3 89 df 4c
8b 24 c2 <41> 8b 6c 24 38 e8 fa 2d ff ff 49 89 c6 48 85 c0 74 bb 4c 8b
b8 40
[   15.401834] RSP: 0018:ff71393407197c50 EFLAGS: 00010293
[   15.407698] RAX: 0000000000000024 RBX: 0000000000000024 RCX: 0000000000000024
[   15.415707] RDX: ff713934001bd000 RSI: 0000000000000000 RDI: 0000000000000024
[   15.423714] RBP: 0000000014dc9380 R08: ffffffff97297780 R09: 0000000000000087
[   15.431722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   15.439731] R13: fffffffffffffff2 R14: ff29dd01cbeca800 R15: ff29dd01c2ff8580
[   15.447739] FS:  00007f472984f6c0(0000) GS:ff29dd40a6828000(0000)
knlGS:0000000000000000
[   15.456821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.463268] CR2: 000000000000003





-- 
-Jirka


