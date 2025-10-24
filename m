Return-Path: <linux-kernel+bounces-869426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D2C07DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07C1400E66
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADE357A43;
	Fri, 24 Oct 2025 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyvaR0KI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34E2FDC5A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333282; cv=none; b=maJe0aoQJMI0G3Yah+TFqSG+LRFcf8cWdckGBev9ajID0/jG2KVN6GVL/vJf2AtvFblOmMYlJil5n/dx9sbpUJJVo0qvqzxh64ZwofZ3TNBjyQJ/xs3j0NZKcEMYtDKqrsfizbxgc7iqcvUW8+2OCY9iqpL6kI9YsJTEsDAMsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333282; c=relaxed/simple;
	bh=r01d6ZHjzcSVwVCjU7ETbJdfwKw99RUgoFktr0GxX9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ckVu8rzZ7tiVVFkwXEOi5aaTtDYf//dcpl+nt2tTQ2unhUVys/zveX/54Hkk6e2qyyMSzt3ohP4T2s9Shn+PSes9qil2a1zGOCFuQMj7+sDFWNcjTo6JVr/Efj5i16D+0m96I44lyLa3XShQrul8aDNpS5h2YjAUW7tt2FQHJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyvaR0KI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33d75897745so4942204a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761333280; x=1761938080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ7VKxqgcYGkrDkh0ZdG/Ic/hnfsPssf2nnP96CS4RQ=;
        b=GyvaR0KIidZvNaIMlN57LT+Ror1WIyVEoleP+b39VCAPJd88Xmd1d2nDzg4xBRwiYG
         7EApfCkjPnllQaHD3tsf5kMLOq7RjTapp+WM2IJ2QZijdh5HT+hoV4V98Cnl3D3UnayH
         HZzDqpbdURr2OyJ5oIdBMnXrIS7OsgO+eIwSVMqDY4AMINs5H3/GPfbaZE053lRS4odk
         JPhh/NBPCqeYKNZLON0A+WrOYVnK0CXEj0o9nq7G3yc38Isy7JWDV7RxHMBKMXRrKNv6
         VUPe4u0Eyy6JIuZqcG/cdcTNXqmkaX6isbgfXtBgU/abwag1yDxuPR/wNO9/eDEprhhy
         rdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333280; x=1761938080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ7VKxqgcYGkrDkh0ZdG/Ic/hnfsPssf2nnP96CS4RQ=;
        b=XkNUC8wt42So8SDvNgaWwcg0+6bg165NsaWv/JYE3CMSidJLVgvKxUsn/zxmE2/GyW
         CZiKzDFMOEJLqw7445dqy4xlkPFw9KHfMeFEkZrLoQSMsxRqCbiivBe09AhZPu12bMY/
         h/Ap0us2taP+hOpagiTjIF7LWrPaofauJ9CTdy1gaJS2E/qEKRSfCPNSFQ6Cg9Gr9Yp4
         WSVkvJHzdTNLedNp8dGhqry3rQuZwFCuQBLFPfpgMFnLJGgriB8tXK/zpSXQBNeOOQco
         jPElqBbHFtzlGaR5GfUdpNKkXhAcjLDS3pRzLBJueWhzMXswqSKO5ywYy69WhAT5WCt+
         XP6w==
X-Forwarded-Encrypted: i=1; AJvYcCU+GQw6IacUM29N5kj0+5n/f2NoD4/LVOHvXMzSUwZ1suS25c5gA3qco2CzHVV/hSamIpcL0aa7Try2Gus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5NMAVAmpD7f1DO6pIDCD7XAE091Q/dMe8OWiXSeLnTkSIuzJ
	DA8m5lk9kAzaWByqr3chJw29pBuMUyjVaCK+pqxGXtGTLy6MxqMqd55kw7mgsB3mGsBaOvktpk6
	E+zHQGw==
X-Google-Smtp-Source: AGHT+IGQUcXhaUyYtcYPYco6iLoOhEvWu/QxGfnz2Mts5MYJwUkgpZCBax7BqxbvW/Sv+kRqMnztb80M51U=
X-Received: from pjtf6.prod.google.com ([2002:a17:90a:c286:b0:33d:61e3:893])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e43:b0:32e:7270:9499
 with SMTP id 98e67ed59e1d1-33bcec297c9mr35662928a91.0.1761333280563; Fri, 24
 Oct 2025 12:14:40 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:14:39 -0700
In-Reply-To: <68fb1966.050a0220.346f24.0093.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <68fa7a22.a70a0220.3bf6c6.008b.GAE@google.com> <68fb1966.050a0220.346f24.0093.GAE@google.com>
Message-ID: <aPvQHxLIVpMykkG5@google.com>
Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>
Cc: david@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tabba@google.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 23, 2025, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit d1e54dd08f163a9021433020d16a8f8f70ddc41c
> Author: Fuad Tabba <tabba@google.com>
> Date:   Tue Jul 29 22:54:40 2025 +0000
> 
>     KVM: x86: Enable KVM_GUEST_MEMFD for all 64-bit builds
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a663cd980000
> start commit:   43e9ad0c55a3 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11a663cd980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a663cd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
> dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173ecd2f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bc2be2580000
> 
> Reported-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com
> Fixes: d1e54dd08f16 ("KVM: x86: Enable KVM_GUEST_MEMFD for all 64-bit builds")

LOL, I was about to say that I suspected that this bug existed since guest_memfd
was first added, but that syzbot only now found the issue due to us enabling
KVM_GUEST_MEMFD broadly.  syzbot beat me to the punch.

#syz test

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 427c0acee9d7..3741ea23e330 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -708,23 +708,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
        return r;
 }
 
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
 {
        unsigned long start = slot->gmem.pgoff;
        unsigned long end = start + slot->npages;
-       struct gmem_file *f;
 
-       /*
-        * Nothing to do if the underlying file was already closed (or is being
-        * closed right now), kvm_gmem_release() invalidates all bindings.
-        */
-       CLASS(gmem_get_file, file)(slot);
-       if (!file)
-               return;
-
-       f = file->private_data;
-
-       filemap_invalidate_lock(file->f_mapping);
        xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
 
        /*
@@ -732,6 +720,35 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
         * cannot see this memslot.
         */
        WRITE_ONCE(slot->gmem.file, NULL);
+}
+
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+{
+       /*
+        * Nothing to do if the underlying file was _already_ closed, as
+        * kvm_gmem_release() invalidates and nullifies all bindings.
+        */
+       if (!slot->gmem.file)
+               return;
+
+       CLASS(gmem_get_file, file)(slot);
+
+       /*
+        * However, if the file is _being_ closed, then the bindings need to be
+        * removed as kvm_gmem_release() might not run until after the memslot
+        * is freed.  Note, modifying the bindings is safe even though the file
+        * is dying as kvm_gmem_release() nullifies slot->gmem.file under
+        * slots_lock, and only puts its reference to KVM after destroying all
+        * bindings.  I.e. reaching this point means kvm_gmem_release() can't
+        * concurrently destroy the bindings or free the gmem_file.
+        */
+       if (!file) {
+               __kvm_gmem_unbind(slot, slot->gmem.file->private_data);
+               return;
+       }
+
+       filemap_invalidate_lock(file->f_mapping);
+       __kvm_gmem_unbind(slot, file->private_data);
        filemap_invalidate_unlock(file->f_mapping);
 }

