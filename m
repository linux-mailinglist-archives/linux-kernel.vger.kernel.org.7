Return-Path: <linux-kernel+bounces-745121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7316BB11530
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9866B16951A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E8405F7;
	Fri, 25 Jul 2025 00:22:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3F29A1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402925; cv=none; b=MCYaBkOq91p+gvuxlziAuQewBQTsm9GeRD81T9X491rbyoTz6XR3o9q6DrKOs6FwE0ja3F013uXSDZH5VwQF8viMvdDhcAHBVPhdwHMZxgZBaGZO4+vy/69KwIVf3M8gpRbkcLiMkFU+wilCsd5qYKRI/tRlfDM2IgF7iL5qzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402925; c=relaxed/simple;
	bh=sjZ7esUp00DhbQJ9Uj9iS3NW9gA54X2ZTwGBwA/NNtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HZZ10OhgqYu5JjSNfUaAaOLgkg/dPUQwqacnFZSqLN8Np84GkHuJkOQSIyvN3sfjAoWw7jrRn3qqKDRWckYNxn7za9FgqSaAVkbOtm+guK/4UVbcPIwe5AVFUBAw/hDX8lpTJJBuH19vz+TUcSr2aJ/8Ey8LVDJW0iaXALH+1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86a5def8869so359528139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753402922; x=1754007722;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g72ZYWR3S6C/fOCrStPZFnFU1jjsdp4iuDnHmVzLaMU=;
        b=M0pLjHIeNW4vbvkoRVOINWiLJqXBuAnjIWf9vsMcQXn0BATUWhr50+a0EvvsMBFxTD
         5xaEHdE83lxjTYEL7m7OIivFFzsdi8j1iQQ3NR42ov2jI6LU8uCnpVzn2WDp6E/qqwqR
         0L1GJ+SxA9WXY+HOFyGIQd6MfL58v904nslw5VYQZ+v0SvvIKJLGPOrQUH13VH7DwaES
         JHle5ZiljIJH6VQzAej2oaVfMg1eokdLc/Lmayw6qxUMcsM/2JMzKu1zFpIKWhZOygSQ
         96Y/A6b00mweRdcnDjfpLEgrKKm+DtalgjujnWbkDBqsxTXgk+K2nAsQbXBawxXMRWIq
         Ir2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9DvpoKHdfOTCjyro6240Rl5blEetueBIsdZZdchQFKw/obMaRtLNt6dr99aN6s/bsBfwJbciIrzCr5Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtojZAzKN5M7Bn2Bbw1qDn0FKhbC/jCFo7jw1cvuaC56PanSl
	JxW36Qz4scMeRtKEjB6Ba2Iy7cPp7uAu1BlOROZwuLj+Cx8oBuAMR40MV22tD6Zhg3o/Z3dqwSC
	EWsXqQcBuhULCsv/YJp7bqRw+oaK0ueRoG30A+dyj1IC1e2cenYKFRVD32eI=
X-Google-Smtp-Source: AGHT+IHv7lmk9D6SL2flhW9yJ5Sgk4Osi/om7Dpr2Fai8oGQboJSzBYVQSlMuaBSluHnSuvP+MVc1lv7TixSWeow86FPIGkqEZYe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b10:b0:87c:541c:44e with SMTP id
 ca18e2360f4ac-87c6505143emr1794736439f.11.1753402922409; Thu, 24 Jul 2025
 17:22:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 17:22:02 -0700
In-Reply-To: <20250724232226.3104-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6882ce2a.a00a0220.2f88df.0038.GAE@google.com>
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_new_lci
From: syzbot <syzbot+0fc08dad8f34563208d5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ed kernel key: 9ece6e4dbdc04b5c1cbbfaba00b7dca934806a52'
[   32.312810][    T1] zswap: loaded using pool 842/zsmalloc
[   32.324717][    T1] Demotion targets for Node 0: null
[   32.330575][    T1] Demotion targets for Node 1: null
[   32.335881][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   35.693466][    T1] Key type .fscrypt registered
[   35.699267][    T1] Key type fscrypt-provisioning registered
[   35.711339][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   35.748666][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   35.758902][    T1] Key type big_key registered
[   35.764107][    T1] Key type encrypted registered
[   35.769924][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   35.777609][    T1] ima: No TPM chip found, activating TPM-bypass!
[   35.784293][    T1] Loading compiled-in module X.509 certificates
[   35.824583][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 9ece6e4dbdc04b5c1cbbfaba00b7dca934806a52'
[   35.836683][    T1] ima: Allocated hash algorithm: sha256
[   35.843653][    T1] ima: No architecture policies found
[   35.850844][    T1] evm: Initialising EVM extended attributes:
[   35.857287][    T1] evm: security.selinux (disabled)
[   35.862772][    T1] evm: security.SMACK64 (disabled)
[   35.868535][    T1] evm: security.SMACK64EXEC (disabled)
[   35.874405][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   35.880994][    T1] evm: security.SMACK64MMAP (disabled)
[   35.887534][    T1] evm: security.apparmor
[   35.892048][    T1] evm: security.ima
[   35.896126][    T1] evm: security.capability
[   35.901126][    T1] evm: HMAC attrs: 0x1
[   35.908402][    T1] PM:   Magic number: 1:51:204
[   35.914541][    T1] video4linux video84: hash matches
[   35.920228][    T1] usb usb53-port3: hash matches
[   35.925732][    T1] tty ttyt2: hash matches
[   35.931143][    T1] netconsole: network logging started
[   35.940096][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   35.955263][    T1] rdma_rxe: loaded
[   35.961839][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   35.976051][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   35.985947][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   35.996554][    T1] clk: Disabling unused clocks
[   35.998201][   T43] faux_driver regulatory: Direct firmware load for reg=
ulatory.db failed with error -2
[   36.002101][    T1] ALSA device list:
[   36.016187][   T43] faux_driver regulatory: Falling back to sysfs fallba=
ck for: regulatory.db
[   36.016507][    T1]   #0: Dummy 1
[   36.029888][    T1]   #1: Loopback 1
[   36.033903][    T1]   #2: Virtual MIDI Card 1
[   36.043176][    T1] check access for rdinit=3D/init failed: -2, ignoring
[   36.050421][    T1] md: Waiting for all devices to be available before a=
utodetect
[   36.059471][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   36.066354][    T1] md: Autodetecting RAID arrays.
[   36.071715][    T1] md: autorun ...
[   36.075839][    T1] md: ... autorun DONE.
[   36.248389][    T1] EXT4-fs (sda1): orphan cleanup on readonly fs
[   36.258318][    T1] EXT4-fs (sda1): mounted filesystem 4f91c6db-4997-4bb=
4-91b8-7e83a20c1bf1 ro with ordered data mode. Quota mode: none.
[   36.271871][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   36.301101][    T1] devtmpfs: mounted
[   36.394643][    T1] Freeing unused kernel image (initmem) memory: 26452K
[   36.408071][    T1] Write protecting the kernel read-only data: 215040k
[   36.433709][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1720K
[   36.448517][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1368K
[   36.661640][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   36.670344][    T1] x86/mm: Checking user space page tables
[   36.853655][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   36.868256][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   36.879031][    T1] Run /sbin/init as init process
[   37.400517][ T5182] mount (5182) used greatest stack depth: 24104 bytes =
left
[   37.482883][ T5183] EXT4-fs (sda1): re-mounted 4f91c6db-4997-4bb4-91b8-7=
e83a20c1bf1 r/w.
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   37.672016][ T5188] modprobe (5188) used greatest stack depth: 22264 byt=
es left
[   37.685646][ T5187] mount (5187) used greatest stack depth: 21768 bytes =
left
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: [   38.681051][ T5213] logger (5213) used greatest stack de=
pth: 21704 bytes left
OK
Populating /dev using udev: [   39.012692][ T5217] udevd[5217]: starting ve=
rsion 3.2.14
[   39.312287][ T5218] udevd[5218]: starting eudev-3.2.14
[   39.322002][ T5217] udevd (5217) used greatest stack depth: 18824 bytes =
left
[   49.239305][ T5307] ------------[ cut here ]------------
[   49.246128][ T5307] AppArmor WARN apparmor_unix_stream_connect: ((({ typ=
eof(*(new_ctx->label)) *__UNIQUE_ID_rcu2213 =3D (typeof(*(new_ctx->label)) =
*)({ do { __attribute__((__noreturn__)) extern void __compiletime_assert_22=
14(void) __attribute__((__error__("Unsupported access size for {READ,WRITE}=
_ONCE()."))); if (!((sizeof((new_ctx->label)) =3D=3D sizeof(char) || sizeof=
((new_ctx->label)) =3D=3D sizeof(short) || sizeof((new_ctx->label)) =3D=3D =
sizeof(int) || sizeof((new_ctx->label)) =3D=3D sizeof(long)) || sizeof((new=
_ctx->label)) =3D=3D sizeof(long long))) __compiletime_assert_2214(); } whi=
le (0); (*(const volatile typeof( _Generic(((new_ctx->label)), char: (char)=
0, unsigned char: (unsigned char)0, signed char: (signed char)0, unsigned s=
hort: (unsigned short)0, signed short: (signed short)0, unsigned int: (unsi=
gned int)0, signed int: (signed int)0, unsigned long: (unsigned long)0, sig=
ned long: (signed long)0, unsigned long long: (unsigned long long)0, signed=
 long long: (signed long long)0, default: ((new_ctx->label)))) *)&((new_ctx=
->label))); }); ;=20
[   49.247187][ T5307] WARNING: security/apparmor/lsm.c:1211 at apparmor_un=
ix_stream_connect+0x5fa/0x650, CPU#1: udevadm/5307
[   49.364397][ T5307] Modules linked in:
[   49.369110][ T5307] CPU: 1 UID: 0 PID: 5307 Comm: udevadm Not tainted 6.=
16.0-rc7-next-20250724-syzkaller-g9ee814bd78e3-dirty #0 PREEMPT(full)=20
[   49.383192][ T5307] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 07/12/2025
[   49.393762][ T5307] RIP: 0010:apparmor_unix_stream_connect+0x5fa/0x650
[   49.400918][ T5307] Code: 00 3b fd 48 89 ef e8 35 4d 00 00 e9 09 fe ff f=
f e8 bb 00 3b fd 90 48 c7 c7 80 33 fd 8b 48 c7 c6 31 52 c7 8d e8 f7 7f fe f=
c 90 <0f> 0b 90 90 e9 27 fe ff ff e8 98 00 3b fd be 02 00 00 00 eb 0a e8
[   49.421322][ T5307] RSP: 0018:ffffc90002ea7c38 EFLAGS: 00010246
[   49.428021][ T5307] RAX: e44b99ab8cef2000 RBX: 1ffff11006365f58 RCX: fff=
f888025c38000
[   49.436750][ T5307] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000002
[   49.445413][ T5307] RBP: ffff88801ba8f8f8 R08: ffff8880b8724253 R09: 1ff=
ff110170e484a
[   49.453784][ T5307] R10: dffffc0000000000 R11: ffffed10170e484b R12: fff=
f888031b2fac0
[   49.462663][ T5307] R13: 1ffff1100bcfff70 R14: 0000000000000000 R15: 000=
000000000002f
[   49.471487][ T5307] FS:  00007f12d413d880(0000) GS:ffff8881258a2000(0000=
) knlGS:0000000000000000
[   49.480684][ T5307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.487634][ T5307] CR2: 00007f12d3a7ae00 CR3: 000000005dcd8000 CR4: 000=
00000003526f0
[   49.496204][ T5307] Call Trace:
[   49.499687][ T5307]  <TASK>
[   49.502867][ T5307]  security_unix_stream_connect+0xcb/0x2c0
[   49.509574][ T5307]  unix_stream_connect+0xc57/0x1030
[   49.515768][ T5307]  __sys_connect+0x316/0x440
[   49.521045][ T5307]  ? count_memcg_event_mm+0x21/0x260
[   49.527164][ T5307]  ? __pfx___sys_connect+0x10/0x10
[   49.534369][ T5307]  __x64_sys_connect+0x7a/0x90
[   49.539881][ T5307]  do_syscall_64+0xfa/0x3b0
[   49.544628][ T5307]  ? lockdep_hardirqs_on+0x9c/0x150
[   49.550014][ T5307]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   49.556349][ T5307]  ? clear_bhb_loop+0x60/0xb0
[   49.561387][ T5307]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   49.568532][ T5307] RIP: 0033:0x7f12d3aa7407
[   49.573201][ T5307] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 0=
0 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0=
f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   49.594955][ T5307] RSP: 002b:00007ffe1593fa80 EFLAGS: 00000202 ORIG_RAX=
: 000000000000002a
[   49.603833][ T5307] RAX: ffffffffffffffda RBX: 00007f12d413d880 RCX: 000=
07f12d3aa7407
[   49.612506][ T5307] RDX: 0000000000000013 RSI: 000055ce2bac2948 RDI: 000=
0000000000003
[   49.621046][ T5307] RBP: 000000000000001e R08: 0000000000000000 R09: 000=
0000000000000
[   49.629405][ T5307] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
07ffe1593fae0
[   49.638437][ T5307] R13: 0000000000000000 R14: 0000000000000007 R15: 000=
0000000000000
[   49.647498][ T5307]  </TASK>
[   49.650564][ T5307] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   49.657982][ T5307] CPU: 1 UID: 0 PID: 5307 Comm: udevadm Not tainted 6.=
16.0-rc7-next-20250724-syzkaller-g9ee814bd78e3-dirty #0 PREEMPT(full)=20
[   49.670964][ T5307] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 07/12/2025
[   49.681493][ T5307] Call Trace:
[   49.685026][ T5307]  <TASK>
[   49.688100][ T5307]  dump_stack_lvl+0x99/0x250
[   49.692927][ T5307]  ? __asan_memcpy+0x40/0x70
[   49.697931][ T5307]  ? __pfx_dump_stack_lvl+0x10/0x10
[   49.703453][ T5307]  ? __pfx__printk+0x10/0x10
[   49.708160][ T5307]  vpanic+0x281/0x750
[   49.712205][ T5307]  ? __pfx__printk+0x10/0x10
[   49.717124][ T5307]  ? __pfx_vpanic+0x10/0x10
[   49.721690][ T5307]  ? is_bpf_text_address+0x292/0x2b0
[   49.727130][ T5307]  ? is_bpf_text_address+0x26/0x2b0
[   49.732566][ T5307]  panic+0xb9/0xc0
[   49.736352][ T5307]  ? __pfx_panic+0x10/0x10
[   49.740901][ T5307]  __warn+0x334/0x4c0
[   49.745033][ T5307]  ? apparmor_unix_stream_connect+0x5fa/0x650
[   49.751314][ T5307]  ? apparmor_unix_stream_connect+0x5fa/0x650
[   49.757676][ T5307]  report_bug+0x2be/0x4f0
[   49.762126][ T5307]  ? apparmor_unix_stream_connect+0x5fa/0x650
[   49.768310][ T5307]  ? apparmor_unix_stream_connect+0x5fa/0x650
[   49.774745][ T5307]  ? apparmor_unix_stream_connect+0x5fc/0x650
[   49.781261][ T5307]  handle_bug+0x84/0x160
[   49.785905][ T5307]  exc_invalid_op+0x1a/0x50
[   49.790709][ T5307]  asm_exc_invalid_op+0x1a/0x20
[   49.796020][ T5307] RIP: 0010:apparmor_unix_stream_connect+0x5fa/0x650
[   49.803687][ T5307] Code: 00 3b fd 48 89 ef e8 35 4d 00 00 e9 09 fe ff f=
f e8 bb 00 3b fd 90 48 c7 c7 80 33 fd 8b 48 c7 c6 31 52 c7 8d e8 f7 7f fe f=
c 90 <0f> 0b 90 90 e9 27 fe ff ff e8 98 00 3b fd be 02 00 00 00 eb 0a e8
[   49.824919][ T5307] RSP: 0018:ffffc90002ea7c38 EFLAGS: 00010246
[   49.831283][ T5307] RAX: e44b99ab8cef2000 RBX: 1ffff11006365f58 RCX: fff=
f888025c38000
[   49.839564][ T5307] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000002
[   49.848147][ T5307] RBP: ffff88801ba8f8f8 R08: ffff8880b8724253 R09: 1ff=
ff110170e484a
[   49.856684][ T5307] R10: dffffc0000000000 R11: ffffed10170e484b R12: fff=
f888031b2fac0
[   49.865820][ T5307] R13: 1ffff1100bcfff70 R14: 0000000000000000 R15: 000=
000000000002f
[   49.875259][ T5307]  ? apparmor_unix_stream_connect+0x5f9/0x650
[   49.881502][ T5307]  security_unix_stream_connect+0xcb/0x2c0
[   49.887795][ T5307]  unix_stream_connect+0xc57/0x1030
[   49.893751][ T5307]  __sys_connect+0x316/0x440
[   49.898486][ T5307]  ? count_memcg_event_mm+0x21/0x260
[   49.904618][ T5307]  ? __pfx___sys_connect+0x10/0x10
[   49.909963][ T5307]  __x64_sys_connect+0x7a/0x90
[   49.915011][ T5307]  do_syscall_64+0xfa/0x3b0
[   49.919636][ T5307]  ? lockdep_hardirqs_on+0x9c/0x150
[   49.924973][ T5307]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   49.931380][ T5307]  ? clear_bhb_loop+0x60/0xb0
[   49.936332][ T5307]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   49.942236][ T5307] RIP: 0033:0x7f12d3aa7407
[   49.946844][ T5307] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 0=
0 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0=
f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   49.967773][ T5307] RSP: 002b:00007ffe1593fa80 EFLAGS: 00000202 ORIG_RAX=
: 000000000000002a
[   49.976926][ T5307] RAX: ffffffffffffffda RBX: 00007f12d413d880 RCX: 000=
07f12d3aa7407
[   49.985528][ T5307] RDX: 0000000000000013 RSI: 000055ce2bac2948 RDI: 000=
0000000000003
[   49.993550][ T5307] RBP: 000000000000001e R08: 0000000000000000 R09: 000=
0000000000000
[   50.001699][ T5307] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
07ffe1593fae0
[   50.011078][ T5307] R13: 0000000000000000 R14: 0000000000000007 R15: 000=
0000000000000
[   50.019984][ T5307]  </TASK>
[   50.023826][ T5307] Kernel Offset: disabled
[   50.028304][ T5307] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2871270070=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 85deaf45cc
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
/syzkaller/prog.GitRevision=3D85deaf45cc57320362fabb5ef83eb8cf413f4274 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250722-150712"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"85deaf45cc57320362fabb5ef83eb8cf41=
3f4274\"
/usr/bin/ld: /tmp/ccMQNojd.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11d894f0580000


Tested on:

commit:         9ee814bd Add linux-next specific files for 20250724
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D83210eaba5794b8=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0fc08dad8f3456320=
8d5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11c610a25800=
00


