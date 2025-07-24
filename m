Return-Path: <linux-kernel+bounces-744200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89DB1095E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BF1AE1745
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570E28150A;
	Thu, 24 Jul 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDAV3+gs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280217F4F6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357132; cv=none; b=MaMusn17/3cAtcyWVu+EktmW2gc5PTM0cJ7Wv5rFKfqAJ4xiGPJeChae8Js4ZVKhtQJAVtXN1MwCS0rDW8SY2NE7dW5uBV033fvgrGi6FNXFiEhV50g6NZUG7vqiyqrmR8QuMNlidJgBmWHO76cJDN5QcWjCNV0vhKyxCDE9y8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357132; c=relaxed/simple;
	bh=jpNq3iEMxsfFXXJv7vhG2S9vLdrEP2ISt8fc40Dh56A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=eZ2Hxsjd1KqfchjeGfJBesGvjNdYrfrb2q45CwZbegQUjP96wAfcrKwmzBVi77wdCdv/yarhQ21GWB6FjWky97IZ6wGwKjI1Qrjp9B3uIWNHIH8IigoFEAOFPPe6e+56lEAY6D9zUI8WlLZJlPdkdx5pk0z/xnspR0QgeJKEPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDAV3+gs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753357129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oMuKDPbL9V9Vz7X9GtKUG6yS9aA+oAXEPvRlq6rVY4=;
	b=ZDAV3+gsY/Qrnvu+HurdMIwwWCZDPlrSjGwHlLbEcSVtn6++KhSPCR18+c2XDzK5g12M4B
	Ct+wRC/mf7K0wiNzmd+B9vCT+yqd6ecHZClWurSfKB2uuU4m7gVI7+f3z2jjgXRZNUXzQr
	1oGQcBdQdcpdnvmt//R1AWSKceA2Zi4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-pJHC787yMWanBZ0RZRYzPA-1; Thu, 24 Jul 2025 07:38:46 -0400
X-MC-Unique: pJHC787yMWanBZ0RZRYzPA-1
X-Mimecast-MFC-AGG-ID: pJHC787yMWanBZ0RZRYzPA_1753357125
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso336740f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357125; x=1753961925;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oMuKDPbL9V9Vz7X9GtKUG6yS9aA+oAXEPvRlq6rVY4=;
        b=odyn8PnHdUktD6jpyxEm/d5IKCjKGLEyU1v5y7ECd8JkCSoZehp2dv2FYnBqdYDGD2
         J0UWmCfSWl6kEFcPimME8J+FCBTLnBceoFkVdFALC8Pi8fGvRp7WMgwPXzaKgLydd8W+
         i6+xrJ7djSI/BIQV+6twjZYi/Bv2BhCoOlI0N5RIrhEoXJIy7kJ1mCcsJ/VRlgGfMZAq
         v8oTeQSlmD3c8NSBOIIFu+CunBbQ5K+GLAPwe6MCVZGdAGt+wpen+zEtdOBsOo8e0N7C
         7DJI16Fe7qWUji20V6BtUlkewbrS/B/TfsFSg8vMDJOb5+XG6osD4yWiRh8GVU3xMp8H
         h6+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkRo/9IM46NThjr3+65o8ovt7G2M13NtkzBwUxLfp7Ua2ChGMahKS+xR7WFX1rWouH515PTyhjH7A4Tpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qjVJk2Z1rIk6LR6XU2WgbwgGCSsdvLqoEabXZALDJfmqlUg+
	KsCh8TL2uWd6kEmXhpswwfVjHJutbY01eyMguwJAyUdnXXNsqGXPPFwSCTP0vgrh0KBnOuOYL6E
	r0AeHHJz5zdKBi/qZ8XuM0AAr52NjrFiFz6whDjBMnK861+WjtWMDnglWvb8trIiHLw==
X-Gm-Gg: ASbGncs7JP+Jf+b3MdETN/1Uih9x3uXHd66EklkkV6uAGUGZ/rw9dBAvYHoc86fuPCX
	PMEo2MoFy/WA6DNsWzkB3VfAsLVpkJiY4CVgw/5pQAkUm7m2uV2O22xeSlrgD6NSGWnOcObuAy7
	kD/aF47khVIX72l2AsPPn3Zl89BtuOlAyOhpXfgaxW104ERGhmYkDDTPqXPEaxkqCMY27H3gewr
	BV/CFgIES/kr+iKBnEWoCO8VeXY94j0kzRRxhzk2lb4AgOcmdc+uVilT/wpHmGqvBboDfVWAq7C
	ccj7fVl51UUW1Ih5j2ND0vWDU4sbf578nck4dynRWZI3M3hL/RAUeRhLfOc7owDuQglIfnuDOmk
	9Xx+T918bcNZAQys56L/k0AM=
X-Received: by 2002:a05:6000:2087:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b768f07996mr6067230f8f.46.1753357125035;
        Thu, 24 Jul 2025 04:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMBdE9Yyz83XaRlA3rC/jzy/w/bSrtT4zrF2os5nQrxY6Slq0V39o0lRHG3goh30vvXVWGFA==
X-Received: by 2002:a05:6000:2087:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b768f07996mr6067210f8f.46.1753357124584;
        Thu, 24 Jul 2025 04:38:44 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705ce781sm17036965e9.31.2025.07.24.04.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:38:43 -0700 (PDT)
Message-ID: <3d164a94-b643-411b-9f22-3bb02af4e4f0@redhat.com>
Date: Thu, 24 Jul 2025 12:38:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in
 gfs2_qd_dealloc (3)
Content-Language: en-US
To: syzbot <syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com>
References: <68814adf.a00a0220.2f88df.0002.GAE@google.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68814adf.a00a0220.2f88df.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 21:49, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    01a412d06bc5 Merge tag 'pull-ufs-fix' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=150e6fd4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
> dashboard link: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132aff22580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144380a2580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-01a412d0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8229e4edb67d/vmlinux-01a412d0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8e07d86da9da/bzImage-01a412d0.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/5c2db4a05d12/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=110e6fd4580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
> BUG: KASAN: slab-use-after-free in gfs2_qd_dealloc+0x81/0xe0 fs/gfs2/quota.c:112
> Write of size 4 at addr ffff888036404a80 by task pool_workqueue_/3
> 
> CPU: 0 UID: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.16.0-rc7-syzkaller-00018-g01a412d06bc5 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x230 mm/kasan/report.c:480
>  kasan_report+0x118/0x150 mm/kasan/report.c:593
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
>  gfs2_qd_dealloc+0x81/0xe0 fs/gfs2/quota.c:112
>  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
>  rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
>  handle_softirqs+0x286/0x870 kernel/softirq.c:579
>  __do_softirq kernel/softirq.c:613 [inline]
>  invoke_softirq kernel/softirq.c:453 [inline]
>  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
>  </IRQ>

#syz test

--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -66,6 +66,8 @@ void free_sbd(struct gfs2_sbd *sdp)
 {
        struct super_block *sb = sdp->sd_vfs;
 
+       /* Wait for rcu_call(gfs2_qd_dealloc) */
+       rcu_barrier();
        free_percpu(sdp->sd_lkstats);
        sb->s_fs_info = NULL;
        kfree(sdp);


