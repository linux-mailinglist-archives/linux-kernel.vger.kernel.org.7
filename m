Return-Path: <linux-kernel+bounces-815758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1DB56AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6006D1892F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B142DCF4C;
	Sun, 14 Sep 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrZoEXpM"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42D2765E3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870930; cv=none; b=B1EKAOUAck7EQVHoGZcR1g5If727VqBeqhuUZaJVsfpJkTG6Pgv42MoKxdpqPguQ83NnAsHW6VLkG9q1LpdAk/hmaqON31jXXhqn3jVIix6FVqj5iVXL0SgHnBUb+zpAS+SYx2TFCKnI7rPa9m397LxeGj6NpXaqMeq4zgR4q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870930; c=relaxed/simple;
	bh=6M/8CsIJt8n3YZOT01yCt3RpDok+wegq2C1jyZg9jDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ip0gjtzNqxtUdNfxxV0lJgli/yGSXGOJ30JqxxGupiN6WBJgxFjzacnl6N3aIQDt2FnhRXz9oVhRDxYoc6Y5WtUeukWTBUJgK9zuVyVleFte76fU7/YuHoSaRL0zLp7/RmDOYPHs2MQv+L3KMLbjhkxBd/EwiKF9UHKvlbXAJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrZoEXpM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b523af71683so2900044a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757870928; x=1758475728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YhS9QI6FnDZaRezjVPI0bR6iFrrG377wCEQNiJUTax8=;
        b=VrZoEXpMD7TNie073IEtl3fdo6W4gT3PtYoOSQa8+5qvP434ubIIKxJQZsdYcG0CC4
         TbVmOIDLyUr+kCg0L/XPmbopiBowS3wVy3ABCSbhVvSvKdNtDlBomAEGtLjeoabCHJBc
         fAMFx/UqS/0LFTwSLWYKpSvPKMon9JszI9p1KuAcdk8kcIirdazeuJA5sMHmPqDmOQ74
         Lwt9kG9CXYxws4VgINKJVK2mp3sI9C/OS2oAwucZwvgtDtIUAHntA7iGYp9UBKiB+8RC
         ccE9TMEyQTaZsqtuty4R0UZP0LBtHpMumu9wbvCPLiZGDeEhHm58N8uq5aoFTM2I26PD
         9Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870928; x=1758475728;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhS9QI6FnDZaRezjVPI0bR6iFrrG377wCEQNiJUTax8=;
        b=cjD/UXaS/T0FrnPPGRDL3irCthyCA0QCDN8+vRiYDoqvpWzVAuH7Mfwsyu5TcPiJE0
         ECic1Bo1FzFiWE+fJVDL4Dhhu1wGzuU7yU8KzYTvlmL+ows37EnHEd3LcorebmzLDjFs
         sM8+kRm2X7edeNvll7xBOfl/2rTtcoKEBGQwBbkclbZIeiMhaZa5oWILePFknQms96+O
         9FvZEe9DTtrNp4JT2ETJ7Ekjg0ZOrvkxGU6POcZNmlDSIvInC/cXzem8lYAYqCt1fHkH
         sqfYCDoFuw+Li1qbyfBGPiXBDA6VGPirGuZd0jQ5c2utY8kWzTF3yHatfSkgtJrD+rvQ
         E8DA==
X-Gm-Message-State: AOJu0YxalX9K77ytIX89iqjNqPsVDBAdAw/lYN4bJQNjo353CPRxTiM2
	DhKO66QkKi+hq9qyZWT30S7XbloKO3YsPIdh74WQcPJB+3+O5Lpyk3HGVlCNAax7BbOkiiqvsUj
	o44sTEDVZXzjBiXrU6PmzlZFX+HlcKl0t/tSC
X-Gm-Gg: ASbGncviOPDQQXgJgnMvJoCg07/LM9FAdgQqDCvLDU9QXJHnOA1iZS2sg1d8iiOvzZf
	XlX6elad+UV/EVUzqkDVreZIX3gtTAx1I3IQ0Afg8EtAej2gfRz2Oi+Fm1rgQ/ttlc+h6ou2cZJ
	udj9+ghy2NJvYJZX8Fhool+ZeurOneo+SAAL6X9zCIjMbvPTVM2Ii3px6AnSvEfqqTFS6L6VU0V
	1GfRNFoZbEsuLx1
X-Google-Smtp-Source: AGHT+IFm69+qDqjrkEgGY3p3av0khI1Dthw64vZkdbwDRvO0bV8jdvyK2qZLuQCy8/KhqVma8o6nxTFSH8sUXEv5hqA=
X-Received: by 2002:a17:902:d490:b0:25c:18d:893 with SMTP id
 d9443c01a7336-25d24bb33f9mr105693135ad.22.1757870927491; Sun, 14 Sep 2025
 10:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Sun, 14 Sep 2025 19:28:11 +0200
X-Gm-Features: Ac12FXxRYEj9Rsv_CR1CWIxp0Z05BT53JvlXLPEDk7-H2b2DFeeT-ELH1HbrorE
Message-ID: <CAHaCkmcZm43Di=AUx0_UTUjqNKjhDZsCMehW+HWRuy2wzoHzkg@mail.gmail.com>
Subject: amdgpu ERROR flip_done timed out
To: linux-kernel@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"

Hi guys

I'm writing in the hope that I can provide some helpful information in
order to get this issue resolved.

This has plagued me personally for the past year and a half, but I can
see online when searching for "flip_done timed out" that this has been
an issue for many more people for much longer (both when using distro
kernels and kernel.org kernels).

I experience this issue sometimes months apart and sometimes hours
apart and I really don't know how to trigger it. Sometimes it happens
while I'm watching a youtube video, sometimes while I'm playing a
steam/proton game and sometimes I'm just editing a file in LibreOffice
or my computer is just idle at the KDE desktop.

In every case the kernel `dmesg` report looks the same - here's the
latest one I've captured:

...
[   10.142827] r8152 2-1:1.0 enp16s0u1: carrier on
[   10.178864] r8152 2-1:1.0 enp16s0u1: carrier off
[   13.056370] nvme nvme0: using unchecked data buffer
[   13.373622] usbcore: registered new interface driver snd-usb-audio
[   13.406920] r8152 2-1:1.0 enp16s0u1: carrier on
[   14.402737] r8152 2-1:1.0 enp16s0u1: carrier off
[   15.223671] warning: `kdeconnectd' uses wireless extensions which
will stop working for Wi-Fi 7 hardware; use nl80211
[   16.910901] r8152 2-1:1.0 enp16s0u1: carrier on
[19381.259879] usb 3-2: new high-speed USB device number 7 using xhci_hcd
[19381.483014] usb 3-2: New USB device found, idVendor=18d1,
idProduct=4ee1, bcdDevice= 6.01
[19381.483017] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[19381.483018] usb 3-2: Product: Pixel 9a
[19381.483020] usb 3-2: Manufacturer: Google
[19381.483021] usb 3-2: SerialNumber: 4A101JEBF08492
[19741.639725] usb 3-2: USB disconnect, device number 7
[20238.021390] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0]
flip_done timed out
[20251.333468] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
[20251.333473] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0]
commit wait timed out
[20261.572992] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
[20261.572995] amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:77:plane-6]
commit wait timed out
[20261.798769] ------------[ cut here ]------------
[20261.798771] WARNING: CPU: 18 PID: 1326 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8905
amdgpu_dm_atomic_commit_tail+0x37d8/0x3840 [amdgpu]
[20261.798947] Modules linked in: r8153_ecm cdc_ether usbnet btusb
snd_usb_audio btrtl btintel snd_usbmidi_lib snd_ump btbcm r8152
snd_rawmidi btmtk mii snd_seq_device libphy mc bluetooth mdio_bus
mousedev joydev vfat fat amd_atl intel_rapl_msr intel_rapl_common
iwlmvm kvm_amd snd_hda_c
odec_hdmi mac80211 kvm snd_hda_intel snd_intel_dspcfg
snd_intel_sdw_acpi libarc4 irqbypass snd_hda_codec spd5118
polyval_clmulni asus_nb_wmi ghash_clmulni_intel iwlwifi sp5100_tco
snd_hda_core sha512_ssse3 asus_wmi snd_hwdep sha1_ssse3
platform_profile aesni_intel snd_pcm igc i2c_piix4
wmi_bmof sparse_keymap rapl cfg80211 ptp snd_timer pcspkr ccp k10temp
i2c_smbus pps_core snd rfkill soundcore gpio_amdpt gpio_generic
mac_hid i2c_dev crypto_user loop dm_mod nfnetlink ip_tables x_tables
amdgpu amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched
drm_suballoc_helper
drm_panel_backlight_quirks nvme drm_buddy nvme_core drm_display_helper
nvme_keyring cec video nvme_auth wmi
[20261.798985] CPU: 18 UID: 0 PID: 1326 Comm: systemd-logind Not
tainted 6.16.7-arch1-1 #1 PREEMPT(full)
ca97e8d991f25900a7e86eaefaa601b827fdc90b
[20261.798987] Hardware name: ASUS System Product Name/ROG STRIX
X670E-E GAMING WIFI, BIOS 3205 07/15/2025
[20261.798988] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x37d8/0x3840 [amdgpu]
[20261.799120] Code: 0b e9 f6 f8 ff ff 0f 0b 49 8d 84 24 a8 4f 04 00
c6 85 28 fe ff ff 00 48 89 85 30 fe ff ff e9 83 ce ff ff 0f 0b e9 ce
ce ff ff <0f> 0b e9 ea f8 ff ff 48 c7 85 20 fe ff ff 00 00 00 00 48 c7
85 f8
[20261.799121] RSP: 0018:ffffd43ac5b7f630 EFLAGS: 00010086
[20261.799122] RAX: 0000000000000001 RBX: 0000000000000282 RCX: ffff8ec601e6a118
[20261.799123] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff8ec616700180
[20261.799123] RBP: ffffd43ac5b7f888 R08: ffffd43ac5b7f524 R09: 0000000000000000
[20261.799124] R10: 0000000000000000 R11: ffffd43ac5b7f594 R12: ffff8ec601e6a118
[20261.799124] R13: ffff8ec616700010 R14: ffff8ec601e6a000 R15: ffff8ec764044000
[20261.799125] FS:  00007f0c45a3d900(0000) GS:ffff8ed59859b000(0000)
knlGS:0000000000000000
[20261.799126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[20261.799127] CR2: 00007f0171413be0 CR3: 000000014332d000 CR4: 0000000000f50ef0
[20261.799128] PKRU: 55555554
[20261.799128] Call Trace:
[20261.799130]  <TASK>
[20261.799139]  commit_tail+0x9e/0x130
[20261.799143]  drm_atomic_helper_commit+0x13c/0x180
[20261.799144]  drm_atomic_commit+0xae/0xe0
[20261.799147]  ? __pfx___drm_printfn_info+0x10/0x10
[20261.799151]  drm_client_modeset_commit_atomic+0x1ec/0x230
[20261.799154]  drm_client_modeset_commit_locked+0x58/0x160
[20261.799156]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x55/0xd0
[20261.799159]  drm_fb_helper_set_par+0x2d/0x40
[20261.799160]  fb_set_var+0x239/0x430
[20261.799164]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799166]  ? update_load_avg+0x7c/0x740
[20261.799168]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799169]  ? psi_group_change+0x10c/0x2c0
[20261.799174]  fbcon_blank+0x272/0x330
[20261.799178]  do_unblank_screen+0xc5/0x1b0
[20261.799181]  complete_change_console+0x54/0x120
[20261.799183]  vt_ioctl+0xd34/0x1450
[20261.799185]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799186]  ? tty_ioctl+0x156/0x980
[20261.799188]  ? __seccomp_filter+0x41/0x4e0
[20261.799191]  tty_ioctl+0xe1/0x980
[20261.799192]  ? __seccomp_filter+0x41/0x4e0
[20261.799195]  __x64_sys_ioctl+0x94/0xe0
[20261.799197]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799199]  do_syscall_64+0x81/0x970
[20261.799202]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799203]  ? do_syscall_64+0x81/0x970
[20261.799204]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799205]  ? do_syscall_64+0x81/0x970
[20261.799206]  ? srso_alias_return_thunk+0x5/0xfbef5
[20261.799208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[20261.799209] RIP: 0033:0x7f0c4591674d
[20261.799221] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00
00 00
[20261.799222] RSP: 002b:00007ffe1bb81820 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[20261.799223] RAX: ffffffffffffffda RBX: 000000000000001a RCX: 00007f0c4591674d
[20261.799224] RDX: 0000000000000001 RSI: 0000000000005605 RDI: 000000000000001a
[20261.799224] RBP: 00007ffe1bb81870 R08: 00000000ffffffff R09: 00007ffe1bb81850
[20261.799225] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000558921a1ef60
[20261.799225] R13: 0000558921a1ef60 R14: 0000000000000000 R15: 0000558921a200b0
[20261.799228]  </TASK>
[20261.799229] ---[ end trace 0000000000000000 ]---

I have many similar traces from older kernel versions (this one is "
Linux smurf 6.16.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 11 Sep 2025
17:42:36 +0000 x86_64 GNU/Linux").

As for my hardware, I'm using a ASUS motherboard " ROG STRIX X670E-E
GAMING WIFI (BIOS version 3205"). The CPU is a AMD 7950X and there are
64GB of memory installed. The GPU is a AsRock 7900XTX Tichi OC - "
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Navi 31 [Radeon RX 7900 XT/7900 XTX/7900 GRE/7900M] (rev c8)
(prog-if 00 [VGA controller])".

I can provide more hardware details if needed.

The fact is that this bites regularly and has for ages. It has also
bitten my wife who uses a 7800XT in her machine. It's a pain and it
has been happening for ages with a ton of different hardware. Please
tell me what I can try/test/do to help resolve this.

PPS. My linux firmware version at the time of writing this is 20250808-1

Please let me know how I can help resolve this - it's really annoying
and obviously impacting a *lot* of people.

-- 
Kind regards,
 Jesper Juhl

