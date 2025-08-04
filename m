Return-Path: <linux-kernel+bounces-754848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212EBB19D79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE97A3FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBD02405E8;
	Mon,  4 Aug 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNFvgItq"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE223A994
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295590; cv=none; b=ncYysvOcuvwEEIzKMnJu7E+XnNx1KgmV3K8rYzB7K+cJJLhwWxy+hZFI6R8Re64akb4/ZodjAwFIggVMFXkS4ihSJTzxw4Ah6AVAGrTeWJ4DkeSkze21FFuos88DhLfIvZoAR8AWeJeT4+VuAsu3IF5LUHinBqtdOe/QbD0JFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295590; c=relaxed/simple;
	bh=TfoaPn2+eU6ngN1FWKt7nh8JyWEypI8+ihzdZ5TWoYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESF2ySmg5aGxhX3t26vQiNRxx0OdeJM/LNx9nVdCMK4L4XDKA0VN35yQXo1vm7B4JwitQPi6m0I38Fi9WoLm3PfxdXwsM6ocRdOI5SgVD3cJvobijy3g1YgW60oWGlXwXd8gxIG5LOrOsl7Yuku4Dcp2FfNbESH5hf0sJOS5Lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNFvgItq; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-88ba6bb90d6so2954553241.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754295588; x=1754900388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QakOYCzjeUgf946LIgVNMTZzQUr0zFeiIPDv/wMCjDg=;
        b=iNFvgItq+mMeeKfuS/ShrhowWfQi/DeItpKrUU88dy4xNAJx3HaDqhmailZIe2cgb5
         va9Khd/BaoI9Chpmqs2Fim2eK7yv+aBOhdlucl2g3V++c6AIM/+xO6yj0cy8qbxZ1gfO
         H242L4C4aQwXCsn5lWpsal96btnSXPEsIXer8GX0vybMvgQYhUOA5+AXXocXzWYZLDEJ
         xhcVcwXuTkxe95/XMehfjqd0CwWWjsxZ1rpSbfHS1e08hHXxVcZno0u2jDu4lDMg25sy
         e3NH8BpYCSbft2SGNJ1SV7p689p1QanQZ2oZ55B+RTLifYQcMj5wHnJry/PqZ8X81473
         uYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295588; x=1754900388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QakOYCzjeUgf946LIgVNMTZzQUr0zFeiIPDv/wMCjDg=;
        b=SFpy58fbLtnstJbLanVYnSeBH3Y7N7eFYFjf9GEb2CRnGaVTZGYaVPyivWzTIPkZ8q
         vdlk7Q3l/DeoNAZKLo6TU7WYhDwp1PEsbEUTIXcyYZfd7aDmbjNeTawaXminsWuPc+ji
         t8OX9Rclgy4m8574U9OmpSa6SnZzm4VVRUtjrABYWAPTFIfyPD2Wy+G/xlEm5p5ZWmHm
         PQexnGZr4JbW8cAI5GhFa9EY25uEgkSieAIgH+FZASYkw2cBvNhX6ZNHr4RWdDY/1+VE
         QCjsmml/Kpabjebz94SPhPcxl4fG1tQFUtZb18MWXODqvcF95+vBU8ILPi1mMwxzLfnV
         n4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUAS88nlRAWEFeb434RRr/eg5a0IDbJxSwddGA8SS94RH6mZ7EWSBzd0sVJKaimNHgvo5O2InCSgH9Ndbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUv840xYUY3tMQMhjHLORJalj5BgCBtw4cWnu0QkwJTtrMupxr
	sNNRWez3bVcrGz53oQ3pLvc6j9yIuYb21ZdFhsJZ6AcBiVNAhbwQmjZZ7hLhLn8n9n715raIdve
	GGsp61R9co8xgGEK1E/RIOt+elVOUlbU=
X-Gm-Gg: ASbGnctJ9pZSgTrKdTx5JB3mWn83nMlo/55WEAAQFDTI4I18fu7KhIW2iueljjLebz/
	3VIaDJ2uBVTfaqkTdNye0v8Ru4p3Y5NHnBV6mWopvyK01HeUzJXZp0XbSx+D8Milo9tQGorizQ2
	X2mpOMEh1oH6ctUwD+LRJm7ltmna32gcdpAqY4M6JymIQNOUXfPOu3mFh/XXKJ0H+ehNsslGoU7
	cobFD4=
X-Google-Smtp-Source: AGHT+IFEShGMSYTemW41INtMwdf/oTeKCho1ekLh+r1ejDjZNmNvZ7x04++HhEfI2mR2LR/hSKCgAf2ysUV1MylhyPY=
X-Received: by 2002:a05:6102:6488:10b0:4fa:3547:2d38 with SMTP id
 ada2fe7eead31-4fc100d5721mr4901505137.10.1754295587845; Mon, 04 Aug 2025
 01:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607220150.2980-1-21cnbao@gmail.com> <aJAFrYfyzGpbm+0m@ly-workstation>
In-Reply-To: <aJAFrYfyzGpbm+0m@ly-workstation>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Aug 2025 20:19:36 +1200
X-Gm-Features: Ac12FXzEE9AUMv26jhr9UED1IgeO8i-lkO_9knp8t8Sgm8GYpJ8xqHeutSYDfEM
Message-ID: <CAGsJ_4zsj2c8J7XxUeW-95pYb11uSjas3FbJv1F3-x7bbtPYnA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, Qi Zheng <zhengqi.arch@bytedance.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:58=E2=80=AFPM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> Hi Barry Song,
>
> Greetings!
>
> I used Syzkaller and found that there is general protection fault in __pt=
e_offset_map_lock in linux-next next-20250801.
>
> After bisection and the first bad commit is:
> "
> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock/kconfig_origin
[...]
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>

I can boot successfully with your bzImage for the 6.2 kernel.
However, when I use your `kconfig_origin` to build a new kernel from
the 0801 Linux-next source, the system fails to boot.

Warning: unable to open an initial console.
check access for rdinit=3D/init failed: -2, ignoring
input: ImExPS/2 Generic Explorer Mouse as
/devices/platform/i8042/serio1/input/input2
List of all partitions:
No filesystem could mount root, tried:

Kernel panic - not syncing: VFS: Unable to mount root fs on "/dev/sda"
or unknown-block(0,0)
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.16.0-next-20250801-gb9ddaa95fd28 #1 PREEMPT(none)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x2a1/0x2b0
 panic+0x55/0x60
 mount_root_generic+0x2c6/0x2e0
 ? __pfx_kernel_init+0x10/0x10
 prepare_namespace+0x49/0x260
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x15/0x1a0
 ret_from_fork+0x68/0xd0
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x19/0x30
 </TASK>
Kernel Offset: 0x21600000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on
"/dev/sda" or unknown-block(0,0) ]---

Is there anything missing from the reproducer guide?
initrd/ramdisk?

Thanks
Barry

