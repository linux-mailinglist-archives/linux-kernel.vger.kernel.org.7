Return-Path: <linux-kernel+bounces-811386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70982B52860
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69944682353
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198E256C61;
	Thu, 11 Sep 2025 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PW/DlNcP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F22517AC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570128; cv=none; b=cJ9A+yiqTMO8gTJ8vIOMBBFMfr6AcTdcthNwB/1gKpBEVu84zHWApoN+Ss/VEcj3SaFB+e8uIC1Ncx8RKt22ktt7wkrFHfQMuYQOeJVR0w3HaV0iA8ImpD9h7Mv/5uoeGkKSnzp11H4bb1zeq6n0sS8g2rcoSAtgt9MVfVbiUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570128; c=relaxed/simple;
	bh=mNHP6MXt9vN9o9ikHq5g/ltKh1nvHlZyPrTcLGsaxxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9uRr7FCQdAuRwZd6OPVUc8tKrHI/xA5RRIlJ/S7jCYnSbzCBycziFpZyP6r/rt8C6bol3fO+31xi/s+BY/NbdcuCNddRfHDV46qIEDymb16TVsFIwBSmukuGtJQ/9vLX8aLnwJ2EOqcLEb9PxJoi5TBlg5CpalRn8AwXeeKvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PW/DlNcP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757570125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUb1wP8Iv2Mt/bu6aB3BX3ZLO+y4xLVnPTi/IdbBWMU=;
	b=PW/DlNcPQzb2IA2kFE0cpMvtiytf5quJrh19359rwHhW1BOiNzEm5Id9gouXRGm35a4Zlq
	5LUUtNCdLtyPQ7cgX+7jHL0kswhLqO4UAGi+diOP3pulsldDjBIgLcCAR9/3Pv8+vOb3tp
	c+uh3xzcKRwrLkaATdcZ45drYa7bsh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-J7z-t3meMESkeFOuL054JQ-1; Thu, 11 Sep 2025 01:55:24 -0400
X-MC-Unique: J7z-t3meMESkeFOuL054JQ-1
X-Mimecast-MFC-AGG-ID: J7z-t3meMESkeFOuL054JQ_1757570123
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e5190bcba1so258588f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757570123; x=1758174923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUb1wP8Iv2Mt/bu6aB3BX3ZLO+y4xLVnPTi/IdbBWMU=;
        b=ndbEuC2mdtWHWZVPOxeYXWtG3RAwEKa7lswx5hAVRDzglsluDitBDqKnB3DO63csKk
         F07iKRhfL//l46J2UGgOUffYmxwVbdRNaya1q3BqbwrJRRCAEwAAuJol/bVZxdIyY/rr
         S2sT2rC26bkP6YRTpcHXpjoMPliNGl+IuEhpcPNADBwQciS/6zUPT5yIi4mRPljHbmRV
         tUWgZ0ehmw1LDgKGrRpbr6ZvBra37JkUq0D9prGl8AZonC7vgz6HtvoVaY6jPd36HZPP
         b2/LM0FRE9M30vYqrdz6EUyTJwjN7d3gaJE4kzRLrcUZXuUbc71k+pyt2m6Ws7yHvHBI
         pvzw==
X-Forwarded-Encrypted: i=1; AJvYcCUnFpMC0JWOXD757WMuQm8aG3w5Mgn7+u3Lwnxku3om2gN9n5hglizH1h7wB+MdWEqXoaDAqIBR8dvwBB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PAQSJAy2avEUCGN1vg+1RvT1jdh3d1tsmbwwDDGn8CSDmGQn
	z5bHtBLbOf6gN8o/bUzPPk91ZlfI5CVvGtv2W+0hjuwHcheTrKtj1tJkvmjnHrLwaTOUQEYKreT
	Msdmla1zuo3EDLWBf+uOApnVEiPkCOTNddWHW8ov1fQnTmKB2b6EmkmEudCzNzSUdsA==
X-Gm-Gg: ASbGnctHe5JsyJeQ3kx0NVRVu5t5juMD5WOsOC9i42K1k+JgNy/HoWVEXQhgaRa9r8M
	ecvyukl5+N+tSDYZ2gneaNMUq56Ui+rzV2ZgoP9LIS8ooz9Zaj/diIHiKc7jOf3ZGxSs5rvHzVq
	XqlZSqKVyrLg2SwMkrcnHjIG3PMAzWEsefFYZ5+s9rjj053e4RGWguRXbFPdWOelgpqatlOYoC/
	A1ve5R3RDsWZFZh/XIw+0GLoE/M0kpO8FBjg2seUc/NSQOjnQ1MwVsOIOMorpoSyYUuOugqHjNi
	km+ah3M6Yu9044J/EoLdblbujL0tr4Pf
X-Received: by 2002:a05:6000:40cb:b0:3d3:8711:d94a with SMTP id ffacd0b85a97d-3e643180428mr17207973f8f.25.1757570122762;
        Wed, 10 Sep 2025 22:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz1OkB6rD5+wTQzJJvUMeB+/O8jVdfVC+aUmnmqhoqHG3cXBouNg/JKCu5m83YlZK3qiFckg==
X-Received: by 2002:a05:6000:40cb:b0:3d3:8711:d94a with SMTP id ffacd0b85a97d-3e643180428mr17207960f8f.25.1757570122315;
        Wed, 10 Sep 2025 22:55:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775842sm1070530f8f.7.2025.09.10.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 22:55:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 01:55:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>,
	"patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: vhost_iotlb_miss tight loop lockup - RE vhost/net: Defer TX
 queue re-enable until after sendmsg
Message-ID: <20250911015109-mutt-send-email-mst@kernel.org>
References: <20250501020428.1889162-1-jon@nutanix.com>
 <174649563599.1007977.10317536057166889809.git-patchwork-notify@kernel.org>
 <154EA998-3FBB-41E9-B07E-4841B027B1B5@nutanix.com>
 <20250910155110-mutt-send-email-mst@kernel.org>
 <CACGkMEvggRncZegemhR9fnkRDGJh1G3jgjycDG0ZX8RKg2-X-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvggRncZegemhR9fnkRDGJh1G3jgjycDG0ZX8RKg2-X-Q@mail.gmail.com>

On Thu, Sep 11, 2025 at 01:49:05PM +0800, Jason Wang wrote:
> On Thu, Sep 11, 2025 at 4:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 06:58:18PM +0000, Jon Kohler wrote:
> > >
> > >
> > > > On May 5, 2025, at 9:40 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> > > >
> > > > Hello:
> > > >
> > > > This patch was applied to netdev/net-next.git (main)
> > > > by Jakub Kicinski <kuba@kernel.org>:
> > >
> > > Hey all,
> > > Writing to fire up a flare and point out a problem that we’re seeing
> > > with this patch internally, specifically when we enable iommu on the
> > > virtio-net device.
> > >
> > > With this patch applied on 6.12.y-based bare metal instance and then
> > > starting a 6.12.y based guest with iommu enabled, we see lockups
> > > within the guest in short order, as well as vmm (qemu) stuck in a tight
> > > loop responding to iommu misses from vhost net loop.
> > >
> > > We've bisected this in our internal tree, and for sure it is this
> > > patch that is alledgedly causing the problem, so I wanted to point out
> > > there is some sort of issue here.
> > >
> > > Working on trying to figure this out, but if jumps off the page to
> > > anyone, happy to take advice!
> > >
> > > Flamegraph:
> > > https://gist.github.com/JonKohler/0e83c014230ab59ddc950f10441335f1#file-iotlb-lockup-svg
> > >
> > > Guest dmesg errors like so:
> > > [   66.081694] virtio_net virtio0 eth0: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5500 ms
> > > [   68.145155] virtio_net virtio0 eth0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 7560000 usecs ago
> > > [  112.907012] virtio_net virtio0 eth0: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5568 ms
> > > [  124.117540] virtio_net virtio0 eth0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 16776000 usecs ago
> > > [  124.118050] virtio_net virtio0 eth0: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 16776 ms
> > > [  124.118447] virtio_net virtio0 eth0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 16776000 usecs ago
> > >
> > > Host level top output
> > > 3992758 qemu      20   0   16.6g  52168  26704 R  99.9   0.0  21:23.72 qemu-kvm       <<< this is the qemu main thread
> > > 3992769 qemu      20   0   16.6g  52168  26704 R  58.8   0.0  13:33.44 vhost-3992758 <<< this is the vhost-net kthread
> > >
> > > For qemu-kvm main thread:
> > > Samples: 13K of event 'cycles:P', 4000 Hz, Event count (approx.): 5131922583 lost: 0/0 drop: 0/0
> > >   Children      Self  Shared Object     Symbol
> > > -   87.41%     0.30%  [kernel]          [k] entry_SYSCALL_64_after_hwframe
> > >    - 87.11% entry_SYSCALL_64_after_hwframe
> > >       - do_syscall_64
> > >          - 44.79% ksys_write
> > >             - 43.74% vfs_write
> > >                - 40.96% vhost_chr_write_iter
> > >                   - 38.22% vhost_process_iotlb_msg
> > >                      - 13.72% vhost_iotlb_add_range_ctx
> > >                         - 7.43% vhost_iotlb_map_free
> > >                            - 4.37% vhost_iotlb_itree_remove
> > >                                 rb_next
> > >                              1.78% __rb_erase_color
> > >                              0.73% kfree
> > >                           1.15% __rb_insert_augmented
> > >                           0.68% __kmalloc_cache_noprof
> > >                      - 10.73% vhost_vq_work_queue
> > >                         - 7.65% try_to_wake_up
> > >                            - 2.55% ttwu_queue_wakelist
> > >                               - 1.72% __smp_call_single_queue
> > >                                    1.36% call_function_single_prep_ipi
> > >                            - 1.32% __task_rq_lock
> > >                               - _raw_spin_lock
> > >                                    native_queued_spin_lock_slowpath
> > >                            - 1.30% select_task_rq
> > >                               - select_task_rq_fair
> > >                                  - 0.88% wake_affine
> > >                                       available_idle_cpu
> > >                           2.06% llist_add_batch
> > >                      - 4.05% __mutex_lock.constprop.0
> > >                           2.14% mutex_spin_on_owner
> > >                           0.72% osq_lock
> > >                        3.00% mutex_lock
> > >                      - 1.72% kfree
> > >                         - 1.16% __slab_free
> > >                              slab_update_freelist.constprop.0.isra.0
> > >                        1.37% _raw_spin_lock
> > >                        1.08% mutex_unlock
> > >                     1.98% _copy_from_iter
> > >                - 1.86% rw_verify_area
> > >                   - security_file_permission
> > >                      - 1.13% file_has_perm
> > >                           0.69% avc_has_perm
> > >               0.63% fdget_pos
> > >          - 27.86% syscall_exit_to_user_mode
> > >             - syscall_exit_to_user_mode_prepare
> > >                - 25.96% __audit_syscall_exit
> > >                   - 25.03% __audit_filter_op
> > >                        6.66% audit_filter_rules.constprop.0
> > >                  1.27% audit_reset_context.part.0.constprop.0
> > >          - 10.86% ksys_read
> > >             - 9.37% vfs_read
> > >                - 6.67% vhost_chr_read_iter
> > >                     1.48% _copy_to_iter
> > >                     1.36% _raw_spin_lock
> > >                   - 1.30% __wake_up
> > >                        0.81% _raw_spin_lock_irqsave
> > >                   - 1.25% vhost_enqueue_msg
> > >                        _raw_spin_lock
> > >                - 1.83% rw_verify_area
> > >                   - security_file_permission
> > >                      - 1.03% file_has_perm
> > >                           0.64% avc_has_perm
> > >               0.65% fdget_pos
> > >               0.57% fput
> > >          - 2.56% syscall_trace_enter
> > >             - 1.25% __seccomp_filter
> > >                  seccomp_run_filters
> > >               0.54% __audit_syscall_entry
> > >
> > > vhost-net thread
> > > Samples: 20K of event 'cycles:P', 4000 Hz, Event count (approx.): 7796456297 lost: 0/0 drop: 0/0
> > >   Children      Self  Shared Object     Symbol
> > > -  100.00%     3.38%  [kernel]          [k] vhost_task_fn
> > >      38.26% 0xffffffff930bb8c0
> > >    - 3.36% 0
> > >         ret_from_fork_asm
> > >         ret_from_fork
> > >    - 1.16% vhost_task_fn
> > >       - 2.35% vhost_run_work_list
> > >          - 1.67% handle_tx
> > >             - 7.09% __mutex_lock.constprop.0
> > >                  6.64% mutex_spin_on_owner
> > >             - 0.84% vq_meta_prefetch
> > >                - 3.22% iotlb_access_ok
> > >                     2.50% vhost_iotlb_itree_first
> > >               0.80% mutex_lock
> > >             - 0.75% handle_tx_copy
> > >            0.86% llist_reverse_order
> > >
> > > >
> > > > On Wed, 30 Apr 2025 19:04:28 -0700 you wrote:
> > > >> In handle_tx_copy, TX batching processes packets below ~PAGE_SIZE and
> > > >> batches up to 64 messages before calling sock->sendmsg.
> > > >>
> > > >> Currently, when there are no more messages on the ring to dequeue,
> > > >> handle_tx_copy re-enables kicks on the ring *before* firing off the
> > > >> batch sendmsg. However, sock->sendmsg incurs a non-zero delay,
> > > >> especially if it needs to wake up a thread (e.g., another vhost worker).
> > > >>
> > > >> [...]
> > > >
> > > > Here is the summary with links:
> > > >  - [net-next,v3] vhost/net: Defer TX queue re-enable until after sendmsg
> > > >    https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_netdev_net-2Dnext_c_8c2e6b26ffe2&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=NGPRGGo37mQiSXgHKm5rCQ&m=0XoR6N9VbkaJ_wBENy8Z28uDdqjCe4HRNCyV-8o4etqXeEJOqoFFGjeGGP5sQcmt&s=-X8si_rU8pXKNyWNNzBqx5Fmv-ut9w2gS5E6coMDApM&e=
> > > >
> > > > You are awesome, thank you!
> > > > --
> > > > Deet-doot-dot, I am a bot.
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__korg.docs.kernel.org_patchwork_pwbot.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=NGPRGGo37mQiSXgHKm5rCQ&m=0XoR6N9VbkaJ_wBENy8Z28uDdqjCe4HRNCyV-8o4etqXeEJOqoFFGjeGGP5sQcmt&s=sydedZsBCMSJM9_Ldw6Al-BplvM7FokLwV_80bJpGnM&e=
> > > >
> > > >
> > >
> >
> >
> > Well it seems that if  get_tx_bufs failed with -EAGAIN then we
> > previously bailed out, but now we will redo poll and so on, forever.
> 
> Something like this, the vhost_vq_avail_empty() will cause the
> vhost_poll_queue() to be queued in this case.
> 
> Let me post a patch to fix that.
> 
> Thanks


To add to that, busyloop_intr getting set is now ignored except in
the last loop, which also doesn't look nice but not a bug, strickly
speaking.

> >
> >
> > No?
> >
> >
> > --
> > MST
> >


