Return-Path: <linux-kernel+bounces-765761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E8B23DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2281C17303A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF21A23A6;
	Wed, 13 Aug 2025 01:49:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6521A7AE3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049744; cv=none; b=swE47qMKbtzQszVHQUGfVfqQLk1K6Hzi/6rD4Hck+2nX0fT+d1ECPmWvtF9FSUd0Lbz5EoAWdLWiXQelHklkG92UwykL2uxPFS0Gq+WBAeWNARafRbhK3/J5FFqp3krD5aNt4j6T4gcsSd2LI7wCQGEdztSyuaZil5ZSsQQeBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049744; c=relaxed/simple;
	bh=Hf6hzsYfx9gO0TG5VNjgSJs1dQ7QCfi3CcfUfy+2xBo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MIVgSEgfsXYmLnlR/NxuT2j+TR6JIFQTs4UnFPAeOKzgCdoO1/OMlvbn9BElddR1Jgd46nNhI1Ne1w+UtL1af7RD4rAugP+SP4xwPf2zGN62gaRbbwGpW/AxzBFlIdnIOTojxj2kUdK8M6ohhTHXGP/DtqJ5eodQwuhspeURG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso53147239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049741; x=1755654541;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKOnXabTrbRhTxAvMhXQ0PW36N9nFtQu6HcDqAWpT4E=;
        b=jTIabKwx5PD3F0YThvDjiPDuwlcR3qYeXlTNt6UVrjjRdgfVVMM2PVXxCymqZlMMx2
         D5kGQCdDY737amXzKbDEhLv4xW/LWqDZdZMKbgBCvalfjfRfF+gpRKqUhIsXtlSJphAm
         Q239buSuGKexIMk1Sv/BPFH8d6rCqi3DPhXN0ZEdFpBYFwSBjEKkI0X3bQejnkJ/tzL0
         ZFLW6xyw+kUvdMfw1RNL72lbPjFLQNVTYmlLFIBhCBKXcwmal+Rsk/9JNVn8TJudZyKC
         8jCbHCaSY5GWeVnviRVPxVZrjTY3CSiCTrcqw7o3FF8SyeU735IrJmP2a6hMHXGB+UmE
         NXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmHDpLf7iLHQwqVf99EfdietwKnLA8BFQFbG9tDflwX5ate0c3QZ+o24Sxe5HG+DzSgeviDuu2pasi07I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEb+FKlpIk4ZuAPvhdmv4SQ7fwn2yzN2njiwEbx4vKj2Yg+EX+
	ZvunmTuaXjV1OMw6pAL3uwVKmDgWeEOnq3vaGtas5Cl4n+1/lz6N36y8v+yuxwrhHD8Z79v2gOs
	4j6YVrKR31fjffjGFpyl1t34s16w1XwaC8ai19ezuFFyD8ggoKJv3c52D9ic=
X-Google-Smtp-Source: AGHT+IEeEFh+w6xAGTnMtroH/0oHPRhBd603pPFZh5rLPcqY70xbhkw041YYGVNtMtxYP+YhPOW6zC3qFRxCGWGMHtt5cF9Ua0gP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1651:b0:881:4b5e:fa9d with SMTP id
 ca18e2360f4ac-8842a332320mr146131539f.0.1755049741659; Tue, 12 Aug 2025
 18:49:01 -0700 (PDT)
Date: Tue, 12 Aug 2025 18:49:01 -0700
In-Reply-To: <20250813012616.4382-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689bef0d.050a0220.7f033.0140.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

f888026ed8000
[    8.273850][    T1] RDX: 1ffff11004ddb14f RSI: ffffffff8de29d08 RDI: fff=
fffff8c162500
[    8.273857][    T1] RBP: ffff888026ed8a78 R08: 0000000000000000 R09: fff=
fed1020aa000d
[    8.273863][    T1] R10: ffff88810550006f R11: 0000000000000000 R12: fff=
fc90004edfa30
[    8.273870][    T1] R13: 0000000000000001 R14: 0000000000000007 R15: fff=
fc90000046f50
[    8.273876][    T1] FS:  0000000000000000(0000) GS:ffff8880d67bc000(0000=
) knlGS:0000000000000000
[    8.273903][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.273912][    T1] CR2: 0000000000000000 CR3: 000000000e380000 CR4: 000=
0000000352ef0
[    8.273918][    T1] Call Trace:
[    8.273957][    T1]  <TASK>
[    8.273968][    T1]  __ww_mutex_lock.constprop.0+0x1a69/0x32c0
[    8.274047][    T1]  ? virtio_gpu_plane_duplicate_state+0x6c/0xc0
[    8.274092][    T1]  ? drm_atomic_get_plane_state+0x20e/0x590
[    8.274108][    T1]  ? drm_client_modeset_commit_atomic+0x237/0x7e0
[    8.274125][    T1]  ? drm_client_modeset_commit_locked+0x14d/0x580
[    8.274141][    T1]  ? drm_fb_helper_pan_display+0x32d/0xa40
[    8.274155][    T1]  ? fb_pan_display+0x47c/0x7d0
[    8.274166][    T1]  ? rotate_all_store+0x250/0x400
[    8.274183][    T1]  ? redraw_screen+0x2c1/0x760
[    8.274201][    T1]  ? fbcon_fb_registered+0x21d/0x6a0
[    8.274213][    T1]  ? modeset_lock+0x4a0/0x6e0
[    8.274227][    T1]  ? __pfx___ww_mutex_lock.constprop.0+0x10/0x10
[    8.274239][    T1]  ? virtio_gpu_probe+0x29e/0x500
[    8.274251][    T1]  ? virtio_dev_probe+0x6a0/0xbe0
[    8.274265][    T1]  ? look_up_lock_class+0x59/0x150
[    8.274283][    T1]  ? __pfx___might_resched+0x10/0x10
[    8.274300][    T1]  ? ww_mutex_lock+0x37/0x160
[    8.274358][    T1]  ww_mutex_lock+0x37/0x160
[    8.274371][    T1]  modeset_lock+0x4a0/0x6e0
[    8.274385][    T1]  drm_modeset_lock+0x59/0x90
[    8.274399][    T1]  drm_atomic_get_crtc_state+0x100/0x450
[    8.274415][    T1]  drm_atomic_get_plane_state+0x436/0x590
[    8.274432][    T1]  drm_client_modeset_commit_atomic+0x237/0x7e0
[    8.274450][    T1]  ? rcu_is_watching+0x12/0xc0
[    8.274465][    T1]  ? trace_contention_end+0xdd/0x130
[    8.274476][    T1]  ? __pfx_drm_client_modeset_commit_atomic+0x10/0x10
[    8.274493][    T1]  ? __mutex_lock+0x1c4/0x10b0
[    8.274513][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[    8.274532][    T1]  drm_client_modeset_commit_locked+0x14d/0x580
[    8.274551][    T1]  drm_fb_helper_pan_display+0x32d/0xa40
[    8.274571][    T1]  fb_pan_display+0x47c/0x7d0
[    8.274580][    T1]  ? __pfx_drm_fb_helper_pan_display+0x10/0x10
[    8.274595][    T1]  bit_update_start+0x49/0x1f0
[    8.274607][    T1]  fbcon_switch+0xbf8/0x14c0
[    8.274621][    T1]  ? __pfx_fbcon_switch+0x10/0x10
[    8.274638][    T1]  ? __pfx_bit_cursor+0x10/0x10
[    8.274649][    T1]  ? fbcon_cursor+0x40c/0x5f0
[    8.274658][    T1]  ? vc_init+0x441/0x490
[    8.274674][    T1]  ? is_console_locked+0x9/0x20
[    8.274689][    T1]  ? con_is_visible+0x65/0x150
[    8.274705][    T1]  redraw_screen+0x2c1/0x760
[    8.274721][    T1]  ? fbcon_prepare_logo+0x8ed/0xc70
[    8.274732][    T1]  ? __pfx_redraw_screen+0x10/0x10
[    8.274753][    T1]  set_con2fb_map+0x7aa/0x1080
[    8.274773][    T1]  fbcon_fb_registered+0x21d/0x6a0
[    8.274786][    T1]  do_register_framebuffer+0x512/0x8a0
[    8.274796][    T1]  ? __pfx_do_register_framebuffer+0x10/0x10
[    8.274810][    T1]  ? find_held_lock+0x2b/0x80
[    8.274826][    T1]  register_framebuffer+0x23/0x40
[    8.274836][    T1]  __drm_fb_helper_initial_config_and_unlock+0xdb7/0x1=
7b0
[    8.274856][    T1]  ? __mutex_unlock_slowpath+0x163/0x800
[    8.274868][    T1]  ? __pfx___drm_fb_helper_initial_config_and_unlock+0=
x10/0x10
[    8.274889][    T1]  drm_fb_helper_initial_config+0x44/0x60
[    8.274904][    T1]  drm_fbdev_client_hotplug+0x1a6/0x280
[    8.274917][    T1]  ? __pfx_drm_fbdev_client_hotplug+0x10/0x10
[    8.274928][    T1]  drm_client_register+0x197/0x280
[    8.274943][    T1]  drm_fbdev_client_setup+0x1bd/0x480
[    8.274956][    T1]  drm_client_setup+0x19f/0x240
[    8.274967][    T1]  virtio_gpu_probe+0x29e/0x500
[    8.274980][    T1]  virtio_dev_probe+0x6a0/0xbe0
[    8.274996][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.275009][    T1]  ? kernfs_create_link+0x1bd/0x240
[    8.275021][    T1]  ? kernfs_put+0x35/0x60
[    8.275037][    T1]  ? sysfs_do_create_link_sd+0xbb/0x140
[    8.275052][    T1]  ? sysfs_create_link+0x68/0xc0
[    8.275067][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.275082][    T1]  really_probe+0x241/0xa90
[    8.275163][    T1]  __driver_probe_device+0x1de/0x440
[    8.275175][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    8.275194][    T1]  driver_probe_device+0x4c/0x1b0
[    8.275206][    T1]  __driver_attach+0x283/0x580
[    8.275218][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.275229][    T1]  bus_for_each_dev+0x13b/0x1d0
[    8.275244][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.275260][    T1]  ? bus_add_driver+0x299/0x690
[    8.275280][    T1]  bus_add_driver+0x2e9/0x690
[    8.275297][    T1]  ? __pfx_virtio_gpu_driver_init+0x10/0x10
[    8.275314][    T1]  driver_register+0x15c/0x4b0
[    8.275326][    T1]  ? __register_virtio_driver+0x56/0x100
[    8.275340][    T1]  virtio_gpu_driver_init+0xa8/0x1b0
[    8.275368][    T1]  do_one_initcall+0x120/0x6e0
[    8.275382][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.275398][    T1]  ? __kmalloc_noprof+0x242/0x510
[    8.275409][    T1]  ? kasan_poison+0x12/0x50
[    8.275428][    T1]  kernel_init_freeable+0x5c2/0x910
[    8.275446][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.275464][    T1]  kernel_init+0x1c/0x2b0
[    8.275477][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.275490][    T1]  ret_from_fork+0x5d7/0x6f0
[    8.275500][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.275514][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.275534][    T1]  </TASK>
[    8.275541][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.275549][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
7.0-rc1-syzkaller-g8742b2d8935f-dirty #0 PREEMPT(full)=20
[    8.275562][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[    8.275568][    T1] Call Trace:
[    8.275572][    T1]  <TASK>
[    8.275576][    T1]  dump_stack_lvl+0x3d/0x1f0
[    8.275588][    T1]  vpanic+0x6e8/0x7a0
[    8.275605][    T1]  ? __pfx_vpanic+0x10/0x10
[    8.275625][    T1]  ? __ww_mutex_wound+0x23b/0x3e0
[    8.275635][    T1]  panic+0xca/0xd0
[    8.275651][    T1]  ? __pfx_panic+0x10/0x10
[    8.275671][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    8.275681][    T1]  check_panic_on_warn+0xab/0xb0
[    8.275691][    T1]  __warn+0xf6/0x3c0
[    8.275701][    T1]  ? __ww_mutex_wound+0x23b/0x3e0
[    8.275711][    T1]  report_bug+0x3c3/0x580
[    8.275728][    T1]  ? __ww_mutex_wound+0x23b/0x3e0
[    8.275738][    T1]  handle_bug+0x184/0x210
[    8.275756][    T1]  exc_invalid_op+0x17/0x50
[    8.275769][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.275780][    T1] RIP: 0010:__ww_mutex_wound+0x23b/0x3e0
[    8.275790][    T1] Code: 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3=
c 02 00 0f 85 85 01 00 00 48 8b 81 78 0a 00 00 48 85 c0 74 09 48 39 c3 74 0=
4 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c
[    8.275800][    T1] RSP: 0000:ffffc90000046e58 EFLAGS: 00010002
[    8.275809][    T1] RAX: ffff8881054cd048 RBX: ffff888105500068 RCX: fff=
f888026ed8000
[    8.275816][    T1] RDX: 1ffff11004ddb14f RSI: ffffffff8de29d08 RDI: fff=
fffff8c162500
[    8.275823][    T1] RBP: ffff888026ed8a78 R08: 0000000000000000 R09: fff=
fed1020aa000d
[    8.275829][    T1] R10: ffff88810550006f R11: 0000000000000000 R12: fff=
fc90004edfa30
[    8.275835][    T1] R13: 0000000000000001 R14: 0000000000000007 R15: fff=
fc90000046f50
[    8.275849][    T1]  ? __ww_mutex_wound+0x2ed/0x3e0
[    8.275861][    T1]  __ww_mutex_lock.constprop.0+0x1a69/0x32c0
[    8.275873][    T1]  ? virtio_gpu_plane_duplicate_state+0x6c/0xc0
[    8.275886][    T1]  ? drm_atomic_get_plane_state+0x20e/0x590
[    8.275900][    T1]  ? drm_client_modeset_commit_atomic+0x237/0x7e0
[    8.275915][    T1]  ? drm_client_modeset_commit_locked+0x14d/0x580
[    8.275930][    T1]  ? drm_fb_helper_pan_display+0x32d/0xa40
[    8.275943][    T1]  ? fb_pan_display+0x47c/0x7d0
[    8.275951][    T1]  ? rotate_all_store+0x250/0x400
[    8.275968][    T1]  ? redraw_screen+0x2c1/0x760
[    8.275984][    T1]  ? fbcon_fb_registered+0x21d/0x6a0
[    8.275995][    T1]  ? modeset_lock+0x4a0/0x6e0
[    8.276008][    T1]  ? __pfx___ww_mutex_lock.constprop.0+0x10/0x10
[    8.276019][    T1]  ? virtio_gpu_probe+0x29e/0x500
[    8.276030][    T1]  ? virtio_dev_probe+0x6a0/0xbe0
[    8.276042][    T1]  ? look_up_lock_class+0x59/0x150
[    8.276058][    T1]  ? __pfx___might_resched+0x10/0x10
[    8.276131][    T1]  ? ww_mutex_lock+0x37/0x160
[    8.276157][    T1]  ww_mutex_lock+0x37/0x160
[    8.276169][    T1]  modeset_lock+0x4a0/0x6e0
[    8.276185][    T1]  drm_modeset_lock+0x59/0x90
[    8.276198][    T1]  drm_atomic_get_crtc_state+0x100/0x450
[    8.276214][    T1]  drm_atomic_get_plane_state+0x436/0x590
[    8.276230][    T1]  drm_client_modeset_commit_atomic+0x237/0x7e0
[    8.276249][    T1]  ? rcu_is_watching+0x12/0xc0
[    8.276264][    T1]  ? trace_contention_end+0xdd/0x130
[    8.276275][    T1]  ? __pfx_drm_client_modeset_commit_atomic+0x10/0x10
[    8.276290][    T1]  ? __mutex_lock+0x1c4/0x10b0
[    8.276309][    T1]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[    8.276326][    T1]  drm_client_modeset_commit_locked+0x14d/0x580
[    8.276344][    T1]  drm_fb_helper_pan_display+0x32d/0xa40
[    8.276364][    T1]  fb_pan_display+0x47c/0x7d0
[    8.276423][    T1]  ? __pfx_drm_fb_helper_pan_display+0x10/0x10
[    8.276444][    T1]  bit_update_start+0x49/0x1f0
[    8.276458][    T1]  fbcon_switch+0xbf8/0x14c0
[    8.276475][    T1]  ? __pfx_fbcon_switch+0x10/0x10
[    8.276492][    T1]  ? __pfx_bit_cursor+0x10/0x10
[    8.276509][    T1]  ? fbcon_cursor+0x40c/0x5f0
[    8.276519][    T1]  ? vc_init+0x441/0x490
[    8.276535][    T1]  ? is_console_locked+0x9/0x20
[    8.276551][    T1]  ? con_is_visible+0x65/0x150
[    8.276567][    T1]  redraw_screen+0x2c1/0x760
[    8.276584][    T1]  ? fbcon_prepare_logo+0x8ed/0xc70
[    8.276594][    T1]  ? __pfx_redraw_screen+0x10/0x10
[    8.276615][    T1]  set_con2fb_map+0x7aa/0x1080
[    8.276629][    T1]  fbcon_fb_registered+0x21d/0x6a0
[    8.276642][    T1]  do_register_framebuffer+0x512/0x8a0
[    8.276652][    T1]  ? __pfx_do_register_framebuffer+0x10/0x10
[    8.276666][    T1]  ? find_held_lock+0x2b/0x80
[    8.276682][    T1]  register_framebuffer+0x23/0x40
[    8.276691][    T1]  __drm_fb_helper_initial_config_and_unlock+0xdb7/0x1=
7b0
[    8.276712][    T1]  ? __mutex_unlock_slowpath+0x163/0x800
[    8.276725][    T1]  ? __pfx___drm_fb_helper_initial_config_and_unlock+0=
x10/0x10
[    8.276750][    T1]  drm_fb_helper_initial_config+0x44/0x60
[    8.276764][    T1]  drm_fbdev_client_hotplug+0x1a6/0x280
[    8.276777][    T1]  ? __pfx_drm_fbdev_client_hotplug+0x10/0x10
[    8.276788][    T1]  drm_client_register+0x197/0x280
[    8.276804][    T1]  drm_fbdev_client_setup+0x1bd/0x480
[    8.276816][    T1]  drm_client_setup+0x19f/0x240
[    8.276828][    T1]  virtio_gpu_probe+0x29e/0x500
[    8.276843][    T1]  virtio_dev_probe+0x6a0/0xbe0
[    8.276861][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.276873][    T1]  ? kernfs_create_link+0x1bd/0x240
[    8.276886][    T1]  ? kernfs_put+0x35/0x60
[    8.276901][    T1]  ? sysfs_do_create_link_sd+0xbb/0x140
[    8.276916][    T1]  ? sysfs_create_link+0x68/0xc0
[    8.276930][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.276944][    T1]  really_probe+0x241/0xa90
[    8.276958][    T1]  __driver_probe_device+0x1de/0x440
[    8.276970][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    8.276989][    T1]  driver_probe_device+0x4c/0x1b0
[    8.277001][    T1]  __driver_attach+0x283/0x580
[    8.277014][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.277025][    T1]  bus_for_each_dev+0x13b/0x1d0
[    8.277041][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.277057][    T1]  ? bus_add_driver+0x299/0x690
[    8.277076][    T1]  bus_add_driver+0x2e9/0x690
[    8.277094][    T1]  ? __pfx_virtio_gpu_driver_init+0x10/0x10
[    8.277109][    T1]  driver_register+0x15c/0x4b0
[    8.277121][    T1]  ? __register_virtio_driver+0x56/0x100
[    8.277135][    T1]  virtio_gpu_driver_init+0xa8/0x1b0
[    8.277150][    T1]  do_one_initcall+0x120/0x6e0
[    8.277164][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.277179][    T1]  ? __kmalloc_noprof+0x242/0x510
[    8.277189][    T1]  ? kasan_poison+0x12/0x50
[    8.277208][    T1]  kernel_init_freeable+0x5c2/0x910
[    8.277226][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.277241][    T1]  kernel_init+0x1c/0x2b0
[    8.277254][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.277267][    T1]  ret_from_fork+0x5d7/0x6f0
[    8.277277][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.277291][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.277310][    T1]  </TASK>
[    8.278140][    T1] Kernel Offset: disabled


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2874749031=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-=
go1.24.4.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0=
.1-go1.24.4.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at c06e8995d7
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc06e8995d711b5a8d8fbd771826fcbfdac6f110f -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250811-165554"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c06e8995d711b5a8d8fbd771826fcbfdac=
6f110f\"
/usr/bin/ld: /tmp/ccMJYSuh.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D109025a2580000


Tested on:

commit:         8742b2d8 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df9319a42cfb3bf5=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4d9a13f0797c46a29=
e42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D127fa8425800=
00


