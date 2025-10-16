Return-Path: <linux-kernel+bounces-856681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AEBE4CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBECB19C3E56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED353346AA;
	Thu, 16 Oct 2025 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnTB0+Su"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBB3346A6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634640; cv=none; b=eeHdmVPGeRsI7wM8ZpmPZuY77qENir7407YaZ9BxGAYZbxb6MgoR9d6yOGG2bnW9xx5OhFW1s2kx5EZ1cMfztS9bHWddktvjHM2D5YsQA5JF4gCXgyUFxA4NvSqO9SWW1CFqW3gHkuMRPWcHJQ0Fz5jskaVjTLnAAMKlwWQHxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634640; c=relaxed/simple;
	bh=fqsj66w6j6EL2U/r8eBirXwutpUEhWR1UbsOWMl1WhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc9+axH0CAvMAUnQrrZLmb5iqiMpBLO6zwTerSCab17lrWaBbPacjs4vPsvWEN3sG+yEqWHvh9Il7m0Q8JZAwbybHXU8OnUulYb9vrkbbJhdwD8PPtm2N87jZUjrngPjAcYNzONvMsKGi70Di0qOcApDvkcuqGUKNRxz6XTyrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnTB0+Su; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760634637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o6zEfWYxdaBFReK6wJKiFAwCfgdlQDJcfFxqP/weE8=;
	b=fnTB0+Susc+J74yHRx3epy/sep4y+PlrP1P+dSoQBoBiCa54h6JeQezoDD5jAh3f8958yA
	VdorQARH/04iKh8SkIKum0ko/ywoVFYwi0vj4wpJlPRZJOirzCXog45Fow70JtjZxSGiDV
	zybAFbnwCU88/CnxnUDVRe8eyFBLxt0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-AON2ti4YOLWioohYoj25iw-1; Thu, 16 Oct 2025 13:10:35 -0400
X-MC-Unique: AON2ti4YOLWioohYoj25iw-1
X-Mimecast-MFC-AGG-ID: AON2ti4YOLWioohYoj25iw_1760634634
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-375da0ef7ebso8990731fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760634634; x=1761239434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o6zEfWYxdaBFReK6wJKiFAwCfgdlQDJcfFxqP/weE8=;
        b=qJdCfFfkjQTtMbx7ur9DDsY/7bDOCzvI6dXgHef3Vf+sFhW7r+Vrq9sO43RNC5L1vz
         LKjHUKaozrw874q+R6Vn+YG8RSznEG+AhakmIFa1MvW6X96GkadB0dzaIFu2Tf7xDAof
         2F1Bu12QZ6C571Vz/rNx+x2Yko/jFxS6t4Ip8i2kJ8o+lOKONAogXjAMS3yMcwH4GeA2
         FP2JZRiw4+YYS0mA4BN3j+pCw0mP/PMXLYsopwG5sucV9zCEly9nGHUL3nCDMvomtv5W
         Y/eP/Lcxt2/k7e1jy373hp0oG0J556/JiIhn+6ont9Alc2ALLwGJcg4gnD301rvVvCvx
         iBAw==
X-Gm-Message-State: AOJu0YwVhPGEEzc7EroLpd71fBbwji/skPZowo5avb1st42DqYGo/M6n
	SsoVS6J93odGZOkZVmFFQH/b5cwa38u64y+aIDqsaf+Y+b6+6OuZ42JbAt1TNBxwkGxShBQ0y9c
	JSAKuCSJVkscJDsiHgHBJo1disY25CrWAa4SMMSyUfXBY8V9uYj9QIxROJmxKTVPptUw1nRLZ5C
	kUT7JHybBR2pvTJCncPXUIZbyXYN9OY9pLE0NKl3qTfnX5AACuqUc=
X-Gm-Gg: ASbGncvxzPsCjZTA1/Ts1yJix3lTOJvRGAxOzDruolfRQcIdfOsoh7xPkg9+pIIQX3o
	o41hLRMzhHyshoUFaavK9gCvUAoYRY8uNzLvkQAOF25+bfEDA18KolXe0lPKReC7B8XqFmbirs8
	cq4ND1RQO5qtzJEeSvv72dv6/rpJ/sG8wNIi77g+pAgtM7wqnc4bjcTfA=
X-Received: by 2002:a2e:b8c1:0:b0:361:5fa3:1d57 with SMTP id 38308e7fff4ca-37797a6f29fmr2881841fa.38.1760634633713;
        Thu, 16 Oct 2025 10:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+QNizXLodVuqNFMDlgfHP+OZvnF3S4oRk0l50jCdOx9tQlY8K1Nu0nYiurLr/uteuka5SpnUDYqCXkxsTzgY=
X-Received: by 2002:a2e:b8c1:0:b0:361:5fa3:1d57 with SMTP id
 38308e7fff4ca-37797a6f29fmr2881751fa.38.1760634633220; Thu, 16 Oct 2025
 10:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE4VaGDfiPvz3AzrwrwM4kWB3SCkMci25nPO8W1JmTBd=xHzZg@mail.gmail.com>
In-Reply-To: <CAE4VaGDfiPvz3AzrwrwM4kWB3SCkMci25nPO8W1JmTBd=xHzZg@mail.gmail.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Thu, 16 Oct 2025 19:10:21 +0200
X-Gm-Features: AS18NWDUvHUDK7tSlQkMDFnoYrafvAL12gk2xyDPh-op_YV3buwFZzcyRDOsSyg
Message-ID: <CAE4VaGCd-cwWsJokL+0tW8OAzJqTsk=9X2AOy=7inFaedYW9+w@mail.gmail.com>
Subject: Re: BUG: NULL pointer dereference in update_qos_requests() triggered
 by writing to /sys/devices/system/cpu/intel_pstate/min_perf_pct (6.18-rc1)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Kamil Kolakowski <kkolakow@redhat.com>, "spetrovi@redhat.com" <spetrovi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The kernel panic appears when we boot the system with the nosmt kernel
boot parameter:

grubby --update-kernel DEFAULT --args=3D"nosmt"

On Thu, Oct 16, 2025 at 6:57=E2=80=AFPM Jirka Hladky <jhladky@redhat.com> w=
rote:
>
> Hello,
>
> We are observing a kernel panic on various Intel servers (Skylake, Ice
> Lake) running kernel 6.18.0-0.rc1. The crash is caused by a NULL
> pointer dereference in update_qos_requests() when the tuned daemon
> writes CPU QoS settings from the default tuned-performance profile.
>
> Triggering setting:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> /usr/lib/tuned/tuned-performance/tuned.conf
> [cpu]
> min_perf_pct=3D100
> governor=3Dperformance
> energy_perf_bias=3Dperformance
> energy_performance_preference=3Dperformance
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> This tuned profile causes the kernel panic when tuned starts, likely via:
>
> echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
>
> Example log:
>
> BUG: kernel NULL pointer dereference, address: 0x38
> RIP: 0010:update_qos_requests+0x7c/0xf0
> PID: 1794 Comm: tuned
> Call Trace:
> store_min_perf_pct+0xb7/0x120
> kernfs_fop_write_iter+0x14d/0x200
> vfs_write+0x25d/0x480
> ksys_write+0x73/0xf0
> do_syscall_64+0x7c/0x800
>
> Thank you!
> Jirka
>
> [      OK    ] Started polkit.service  Authorization Manager.
> [   14.936180] BUG: kernel NULL pointer dereference, address: 00000000000=
00038
> [   14.943996] #PF: supervisor read access in kernel mode
> [   14.949763] #PF: error_code(0x0000) - not-present page
> [   14.955531] PGD 178c1a067 P4D 0
> [   14.959154] Oops: Oops: 0000 [#1] SMP NOPTI
> [   14.963841] CPU: 14 UID: 0 PID: 1991 Comm: tuned Tainted: G S
>           ------  ---  6.18.0-0.rc1.16.eln152.x86_64 #1 PREEMPT(lazy)
> [   14.977798] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [   14.982200] Hardware name: Abacus electric, s.r.o. -
> servis@abacus.cz Super Server/X12SPW-F, BIOS 1.2 02/14/2022
> [   14.993621] RIP: 0010:update_qos_requests+0x7c/0xf0
> [   14.999101] Code: 48 63 d2 48 c7 c7 80 77 29 97 e8 1f 39 bc ff 3b
> 05 39 c3 9c 01 48 89 c3 73 66 48 8b 15 7d b5 68 02 48 63 c3 89 df 4c
> 8b 24 c2 <41> 8b 6c 24 38 e8 fa 2d ff ff 49 89 c6 48 85 c0 74 bb 4c 8b
> b8 40
> [   15.020167] RSP: 0018:ff71393407197c50 EFLAGS: 00010293
> [   15.026031] RAX: 0000000000000024 RBX: 0000000000000024 RCX: 000000000=
0000024
> [   15.034040] RDX: ff713934001bd000 RSI: 0000000000000000 RDI: 000000000=
0000024
> [   15.042048] RBP: 0000000014dc9380 R08: ffffffff97297780 R09: 000000000=
0000087
> [   15.050057] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [   15.058065] R13: fffffffffffffff2 R14: ff29dd01cbeca800 R15: ff29dd01c=
2ff8580
> [   15.066074] FS:  00007f472984f6c0(0000) GS:ff29dd40a6828000(0000)
> knlGS:0000000000000000
> [   15.075156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.081603] CR2: 0000000000000038 CR3: 00000001124e0001 CR4: 000000000=
0773ef0
> [   15.089612] PKRU: 55555554
> [   15.092646] Call Trace:
> [   15.095390]  <TASK>
> [   15.097746]  store_min_perf_pct+0xb7/0x120
> [   15.102345]  kernfs_fop_write_iter+0x14d/0x200
> [   15.107334]  vfs_write+0x25d/0x480
> [   15.111152]  ksys_write+0x73/0xf0
> [   15.114871]  do_syscall_64+0x7c/0x800
> [   15.118980]  ? __do_sys_newfstat+0x44/0x70
> [   15.123570]  ? syscall_exit_work+0x143/0x1b0
> [   15.128363]  ? clear_bhb_loop+0x30/0x80
> [   15.132660]  ? clear_bhb_loop+0x30/0x80
> [   15.136965]  ? clear_bhb_loop+0x30/0x80
> [   15.141260]  ? clear_bhb_loop+0x30/0x80
> [   15.145566]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   15.151236] RIP: 0033:0x7f472b534e4f
> [   15.155257] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 59 74
> f9 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 ac 74 f9
> ff 48
> [   15.176328] RSP: 002b:00007f472984e130 EFLAGS: 00000293 ORIG_RAX:
> 0000000000000001
> [   15.184824] RAX: ffffffffffffffda RBX: 00007f472984f638 RCX: 00007f472=
b534e4f
> [   15.192832] RDX: 0000000000000003 RSI: 00007f472401b670 RDI: 000000000=
000000a
> [   15.200840] RBP: 0000000000000003 R08: 0000000000000000 R09: 000000000=
0000002
> [   15.208849] R10: 00007f47299116c0 R11: 0000000000000293 R12: 00007f472=
401b670
> [   15.216857] R13: 000000000000000a R14: 000055f431e37b00 R15: 000055f43=
1bbbba2
> [   15.224866]  </TASK>
> [   15.227318] Modules linked in: rfkill sunrpc vfat fat ext4 crc16
> mbcache jbd2 intel_rapl_msr iTCO_wdt iTCO_vendor_support
> intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
> i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm dax_hmem cxl_acpi ipmi_ssif
> rndis_host cxl_port irqbypass rapl intel_cstate cxl_core intel_th_gth
> mei_me cdc_ether isst_if_mbox_pci isst_if_mmio igb i2c_i801 ioatdma
> intel_th_pci ast intel_uncore usbnet einj isst_if_common pcspkr
> i2c_smbus intel_pch_thermal mei acpi_power_meter intel_th intel_vsec
> dca i2c_algo_bit mii ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler
> joydev acpi_pad loop fuse dm_mod nfnetlink xfs ahci nvme libahci
> nvme_core libata nvme_keyring ghash_clmulni_intel nvme_auth hkdf
> [   15.305080] CR2: 0000000000000038
> [   15.308798] ---[ end trace 0000000000000000 ]---
> [   15.375282] RIP: 0010:update_qos_requests+0x7c/0xf0
> [   15.380761] Code: 48 63 d2 48 c7 c7 80 77 29 97 e8 1f 39 bc ff 3b
> 05 39 c3 9c 01 48 89 c3 73 66 48 8b 15 7d b5 68 02 48 63 c3 89 df 4c
> 8b 24 c2 <41> 8b 6c 24 38 e8 fa 2d ff ff 49 89 c6 48 85 c0 74 bb 4c 8b
> b8 40
> [   15.401834] RSP: 0018:ff71393407197c50 EFLAGS: 00010293
> [   15.407698] RAX: 0000000000000024 RBX: 0000000000000024 RCX: 000000000=
0000024
> [   15.415707] RDX: ff713934001bd000 RSI: 0000000000000000 RDI: 000000000=
0000024
> [   15.423714] RBP: 0000000014dc9380 R08: ffffffff97297780 R09: 000000000=
0000087
> [   15.431722] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [   15.439731] R13: fffffffffffffff2 R14: ff29dd01cbeca800 R15: ff29dd01c=
2ff8580
> [   15.447739] FS:  00007f472984f6c0(0000) GS:ff29dd40a6828000(0000)
> knlGS:0000000000000000
> [   15.456821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.463268] CR2: 000000000000003
>
>
>
>
>
> --
> -Jirka



--=20
-Jirka


