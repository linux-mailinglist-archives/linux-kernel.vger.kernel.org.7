Return-Path: <linux-kernel+bounces-891427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F07C42A43
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F6BC4E2DE8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870EE2E7165;
	Sat,  8 Nov 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkgLhUin"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A52737F8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762593789; cv=none; b=fhJyBWOOMxT22bT6xmnxODZ+/nfAYcd0WjU90MZ+fXH2dHp2mQls5hwGLVkVqJvKGxBqpYBiijrUsWQ8SIe/YIr87ljgVz3RIkT/CpRSnz2Lppdr2TvkMgdf5UHyiSC+w+v6I70fXro1ksl5phmoYAstEKGu835ILz75H8dNb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762593789; c=relaxed/simple;
	bh=DnrVnvNUYlrc33ZwjycQwaKeI4DZpLUWg45F3tlSrAk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CflNuhf8SWb/nf4ptAK1KhPkU9psTPo0uRwN3MduJCHQomY64cZuQGsMh/k7H/3RYOT1pJrznL4/O5t/wpLw3/BjkvVeXqAxW4Ct+CMormCavkNUNyCjrvGBaGR3o2GXx6SZctQTv6SYuxS5ySs6K+zH6ZnTC0rSHUhbhUiXNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkgLhUin; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed6882991aso13622741cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762593785; x=1763198585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=992UVXRk48vGh2GjdmUTMTY7fLHYggaEdfuEabnaxLg=;
        b=SkgLhUin+VE/d/PvwfdW62wPXF76ziiFNZ9Ru8HNP1Xn7o8e4x7zOPmgoLAWOYxq78
         S14POEn70gP1AD1y3x/eznbo45x8YTxiDwp11ARUHz3UZllZ9xVwhWKYYcQVFhRfAHKZ
         IkF0Yqgk16tlGdOWtMWfFOe57lIosGCuG5G2gZf6vUlHa1A7BAPTAKhnQKzmkY+9XGMs
         Z/zpDxSqFcZ5Xu9pZMdtO9EdKMcHVf/nbAO6NVBgN3StZgJrOpd267G7ZZ+9KeLueHsS
         9UkcOar4sBbvcwK+ESQpyOx4Xhsg1YzFIyCgjVJp9UDM+o7jlaw0FZgzBuGrGrrKpRAp
         aU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762593785; x=1763198585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=992UVXRk48vGh2GjdmUTMTY7fLHYggaEdfuEabnaxLg=;
        b=XpsCsBGhawZL18PDIrnqTnjjQrkV63b6r+4seXfaYyhmFjNQWzKGBU7kecnlOaqALy
         nA1bQ2H9dkSNihIdVETKpoMWLzdfyUN+PujSeBkyWID3eEj2lxPn/06WlzP9Qnp4hwa5
         +7dTP8UZ8HbvgmWsHmYJv/S7/O4Ejy5PI430nRV/4B39g38rUFK+uhJoOswd4aRNGz1p
         d1jRxPMjNKpBrwOjsQVj1LB0ZZBzg3EQBMYwuYo1Dc/hJCHN6i7YmZkKWr5JN3T/zDlK
         9MTP5xaLTVIry6ZVx/k630ArkB8OGgqERAUQi7ewmzXigXur9Tp14t3nTuUOOnuKjrsC
         Q62w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9I9ryUv1K8dYvW2EAPeMMPjJXY1WyK5h+v7LGta5KoCkzORqMeBseUnbJvxYW7lQRhd6agNtm1H1LBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9gNu/JKkw9m3cdyyKtsqQYdYvjiINSCNi7QhsENwlf2678ZI
	Y1VzqAdQlDE53H8J5z3k5uT/GeSxZrurGsfOSR5P0Ava4OlS+oYWwjbaKlc1oUXDBjUv114IBjZ
	avy2LHarxHSs+2t8g5cql4A7wBPzO8ExAaPtw
X-Gm-Gg: ASbGncv+UVrAx3J+tGvVeK+LlDAvRVO4ky8atoGS+8Z6NdpMyqow5h+2vjyF9EFy2ne
	Xds3eFHTH6NcM8UeYQmU25wbfF8/S+nx8RQUvnq0YpAIWAEnOXXPgMdjNDBQ4uotsWZ5NEw8+qD
	+3jdwVICedbJHtpnG2YujB0aapLlGJsWfe2y7hoZ/yBViVHKdmV8pfq6CoBhNl8salRHoSI4TI3
	O7n8dm42eAuNphtbw6NvHW7lX8Mc68NZ/qlWwpALUyhvq9h5aW31SxJNlNk
X-Google-Smtp-Source: AGHT+IGeiFArIaInxBu6khMp4trozl6Eo8Mm2BEsC35MNVgAmsS9doJJvYKD9jq2drV0xkuswj8G0BFHfTEgUKQXcoM=
X-Received: by 2002:ac8:5a50:0:b0:4ec:8914:c373 with SMTP id
 d75a77b69052e-4ed997c9820mr45335751cf.20.1762593784759; Sat, 08 Nov 2025
 01:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: liequan che <liequanche@gmail.com>
Date: Sat, 8 Nov 2025 17:22:51 +0800
X-Gm-Features: AWmQ_bl_uq1sGRu1PC8zSIEIFluxENwIvzI6Z-n6Jz0hLhQUcqyt9hUYSx6KI7I
Message-ID: <CAAsfc_ry+u771V_dTQMiXpaz2iGbQOPmZfhwnyF56pM+FjXdsw@mail.gmail.com>
Subject: [PATCH v1 bcache] bcache: fix UAF in cached_dev_free and safely
To: Coly Li <colyli@fnnas.com>, Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-bcache <linux-bcache@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 We hit a use-after-free when cached_dev_free() is called while the
writeback workqueue/thread may still be running or holding references.
In addition, writeback_wq was flushed/destroyed in more than one place,
which could lead to double flush/destroy and racy teardown=E3=80=82This iss=
ue
exists in kernels 5.10, 6.6, etc.
 The error message is as follows.
[18627.310402] ------------[ cut here ]------------
[18627.316446] WARNING: CPU: 83 PID: 238405 at kernel/kthread.c:83
kthread_stop+0x12c/0x160
[18627.326367] Modules linked in: ceph libceph dns_resolver
openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c vfat fat dm_multipath dm_mod amd64_edac_mod
edac_mce_amd kvm_amd kvm bcache crc64 i40iw irqbypass ses enclosure
ipmi_si ib_uverbs ipmi_devintf joydev rapl ipmi_msghandler pcspkr
ib_core sg i2c_piix4 k10temp fuse ext4 mbcache jbd2 ast
drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
sd_mod fb_sys_fops cec drm_ttm_helper ttm ahci crct10dif_pclmul igb
crc32_pclmul libahci nvme crc32c_intel ghash_clmulni_intel nvme_core
dca smartpqi i40e t10_pi drm i2c_algo_bit libata ngbe
scsi_transport_sas ccp pinctrl_amd
[18627.392415] CPU: 83 PID: 238405 Comm: kworker/83:4 Kdump: loaded
Tainted: G        W         5.10.0-272.0.0.174.ile2312sp1.x86_64 #1
[18627.406601] Hardware name: Inspur CS5280H2/CS5280H2, BIOS 3.03.62 09/15/=
2025
[18627.415362] Workqueue: events cached_dev_free [bcache]
[18627.421985] RIP: 0010:kthread_stop+0x12c/0x160
[18627.427836] Code: 00 e9 0b ff ff ff 48 89 ef e8 50 69 fd ff e9 73
ff ff ff be 01 00 00 00 4c 89 e7 e8 2e 6a 46 00 f6 45 36 20 0f 85 16
ff ff ff <0f> 0b e9 0f ff ff ff be 03 00 00 00 4c 89 e7 e8 10 6a 46 00
e9 43
[18627.449681] RSP: 0018:ffffb5f9cdd0fe60 EFLAGS: 00010246
[18627.456406] RAX: 0000000000000000 RBX: ffff94f51e700010 RCX: 00000000000=
00000
[18627.465254] RDX: ffff94d71fbb1320 RSI: ffff94d71fba0710 RDI: ffff94d71fb=
a0710
[18627.474094] RBP: ffff94cf4d518000 R08: 0000000000000000 R09: ffffb5f9cdd=
0fc90
[18627.482942] R10: ffffb5f9cdd0fc88 R11: ffffffffb69e13a8 R12: ffff94cf4d5=
18030
[18627.491792] R13: 0000000000000000 R14: ffff94d71fbbb700 R15: ffff94d71fb=
bb705
[18627.500643] FS:  0000000000000000(0000) GS:ffff94d71fb80000(0000)
knlGS:0000000000000000
[18627.510564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18627.517861] CR2: 000055d6288098d0 CR3: 0000000594856000 CR4: 00000000003=
506e0
[18627.526715] Call Trace:
[18627.530338]  cached_dev_free+0x30/0xd0 [bcache]
[18627.536283]  process_one_work+0x1b5/0x350
[18627.541643]  worker_thread+0x49/0x310
[18627.546618]  ? rescuer_thread+0x380/0x380
[18627.551977]  kthread+0xfe/0x140
[18627.556372]  ? kthread_park+0x90/0x90
[18627.561345]  ret_from_fork+0x22/0x30
[18627.566226] ---[ end trace 461f27b6101e7b4f ]---
[18627.572269] BUG: unable to handle page fault for address: 00007fd3f5b21e=
10
[18627.580823] #PF: supervisor write access in kernel mode
[18627.587529] #PF: error_code(0x0002) - not-present page
[18627.594131] PGD 6a710f067 P4D 6a710f067 PUD 0
[18627.599968] Oops: 0002 [#1] SMP NOPTI
[18627.604930] CPU: 83 PID: 238405 Comm: kworker/83:4 Kdump: loaded
Tainted: G        W         5.10.0-272.0.0.174.ile2312sp1.x86_64 #1
[18627.619101] Hardware name: Inspur CS5280H2/CS5280H2, BIOS 3.03.62 09/15/=
2025
[18627.627851] Workqueue: events cached_dev_free [bcache]
[18627.634463] RIP: 0010:kthread_stop+0x49/0x160
[18627.640199] Code: 45 30 85 c0 0f 84 1c 01 00 00 0f 88 e6 00 00 00
83 c0 01 0f 88 dd 00 00 00 f6 45 36 20 0f 84 ea 00 00 00 48 8b 9d e8
0a 00 00 <f0> 80 0b 02 48 89 ef e8 3b ff ff ff 48 89 ef e8 43 31 01 00
48 8d
[18627.662022] RSP: 0018:ffffb5f9cdd0fe60 EFLAGS: 00010246
[18627.668728] RAX: 0000000000000000 RBX: 00007fd3f5b21e10 RCX: 00000000000=
00000
[18627.677565] RDX: ffff94d71fbb1320 RSI: ffff94d71fba0710 RDI: ffff94d71fb=
a0710
[18627.686404] RBP: ffff94cf4d518000 R08: 0000000000000000 R09: ffffb5f9cdd=
0fc90
[18627.695232] R10: ffffb5f9cdd0fc88 R11: ffffffffb69e13a8 R12: ffff94cf4d5=
18030
[18627.704070] R13: 0000000000000000 R14: ffff94d71fbbb700 R15: ffff94d71fb=
bb705
[18627.712910] FS:  0000000000000000(0000) GS:ffff94d71fb80000(0000)
knlGS:0000000000000000
[18627.722816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18627.730103] CR2: 00007fd3f5b21e10 CR3: 0000000594856000 CR4: 00000000003=
506e0
[18627.738941] Call Trace:
[18627.742553]  cached_dev_free+0x30/0xd0 [bcache]
[18627.748483]  process_one_work+0x1b5/0x350
[18627.753824]  worker_thread+0x49/0x310
[18627.758785]  ? rescuer_thread+0x380/0x380
[18627.764134]  kthread+0xfe/0x140
[18627.768514]  ? kthread_park+0x90/0x90
[18627.773477]  ret_from_fork+0x22/0x30
[18627.778344] Modules linked in: ceph libceph dns_resolver
openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c vfat fat dm_multipath dm_mod amd64_edac_mod
edac_mce_amd kvm_amd kvm bcache crc64 i40iw irqbypass ses enclosure
ipmi_si ib_uverbs ipmi_devintf joydev rapl ipmi_msghandler pcspkr
ib_core sg i2c_piix4 k10temp fuse ext4 mbcache jbd2 ast
drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
sd_mod fb_sys_fops cec drm_ttm_helper ttm ahci crct10dif_pclmul igb
crc32_pclmul libahci nvme crc32c_intel ghash_clmulni_intel nvme_core
dca smartpqi i40e t10_pi drm i2c_algo_bit libata ngbe
scsi_transport_sas ccp pinctrl_amd
[18627.844370] CR2: 00007fd3f5b21e10
[18627.851414] kexec: Bye!
 The kernel error call stack is as follows:The kernel error call stack
is as follows.
crash> bt
PID: 238405   TASK: ffff94d71fae9c00  CPU: 83   COMMAND: "kworker/83:4"
#0 [ffffb5f9cdd0fca8] crash_kexec at ffffffffb4db67e9
#1 [ffffb5f9cdd0fcb8] oops_end at ffffffffb4c2b1c5
#2 [ffffb5f9cdd0fcd8] no_context at ffffffffb4c7d86c
#3 [ffffb5f9cdd0fd10] __bad_area_nosemaphore at ffffffffb4c7d972
#4 [ffffb5f9cdd0fd58] exc_page_fault at ffffffffb56f7e1c
#5 [ffffb5f9cdd0fdb0] asm_exc_page_fault at ffffffffb5800b4e
   [exception RIP: kthread_stop+73]
   RIP: ffffffffb4d0fee9  RSP: ffffb5f9cdd0fe60  RFLAGS: 00010246
   RAX: 0000000000000000  RBX: 00007fd3f5b21e10  RCX: 0000000000000000
   RDX: ffff94d71fbb1320  RSI: ffff94d71fba0710  RDI: ffff94d71fba0710
   RBP: ffff94cf4d518000   R8: 0000000000000000   R9: ffffb5f9cdd0fc90
   R10: ffffb5f9cdd0fc88  R11: ffffffffb69e13a8  R12: ffff94cf4d518030
   R13: 0000000000000000  R14: ffff94d71fbbb700  R15: ffff94d71fbbb705
   ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#6 [ffffb5f9cdd0fe80] cached_dev_free at ffffffffc0b88470 [bcache]
#7 [ffffb5f9cdd0fe98] process_one_work at ffffffffb4d099c5
#8 [ffffb5f9cdd0fed8] worker_thread at ffffffffb4d09f29
#9 [ffffb5f9cdd0ff10] kthread at ffffffffb4d0f2be
#10 [ffffb5f9cdd0ff50] ret_from_fork at ffffffffb4c035b2
Signed-off-by: cheliequan <cheliequan@inspur.com>
---
drivers/md/bcache/bcache.h    |  7 +++++++
drivers/md/bcache/super.c     | 13 +++++++++----
drivers/md/bcache/writeback.c |  9 ++++++---
3 files changed, 22 insertions(+), 7 deletions(-)
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 832fb3d80eb0..5eba5c068c9c 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -963,6 +963,13 @@ static inline void wait_for_kthread_stop(void)
       }
}
+#define STOP_THREAD_ONCE(dc, member)                           \
+       do {                                                           \
+                       struct task_struct *t__ =3D xchg(&(dc)->member, NUL=
L);   \
+                       if (t__ && !IS_ERR(t__))                           =
    \
+                               kthread_stop(t__);                         =
    \
+       } while (0)
+
/* Forward declarations */
void bch_count_backing_io_errors(struct cached_dev *dc, struct bio *bio);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6afc718ef202..22a002cca6ab 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1368,15 +1368,20 @@ void bch_cached_dev_release(struct kobject *kobj)
static void cached_dev_free(struct closure *cl)
{
+       struct workqueue_struct *wq =3D NULL;
       struct cached_dev *dc =3D container_of(cl, struct cached_dev, disk.c=
l);
       if (test_and_clear_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
               cancel_writeback_rate_update_dwork(dc);
-       if (!IS_ERR_OR_NULL(dc->writeback_thread))
-               kthread_stop(dc->writeback_thread);
-       if (!IS_ERR_OR_NULL(dc->status_update_thread))
-               kthread_stop(dc->status_update_thread);
+       STOP_THREAD_ONCE(dc, writeback_thread);
+       STOP_THREAD_ONCE(dc, status_update_thread);
+
+       wq =3D xchg(&dc->writeback_write_wq, NULL);
+       if (wq) {
+           flush_workqueue(wq);
+           destroy_workqueue(wq);
+       }
       mutex_lock(&bch_register_lock);
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 854cdaa84462..3cac64b9d606 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -741,6 +741,7 @@ static int bch_writeback_thread(void *arg)
       struct cached_dev *dc =3D arg;
       struct cache_set *c =3D dc->disk.c;
       bool searched_full_index;
+       struct workqueue_struct *wq =3D NULL;
       bch_ratelimit_reset(&dc->writeback_rate);
@@ -832,10 +833,12 @@ static int bch_writeback_thread(void *arg)
               }
       }
-       if (dc->writeback_write_wq) {
-               flush_workqueue(dc->writeback_write_wq);
-               destroy_workqueue(dc->writeback_write_wq);
+       wq =3D xchg(&dc->writeback_write_wq, NULL);
+       if (wq) {
+           flush_workqueue(wq);
+           destroy_workqueue(wq);
       }
+
       cached_dev_put(dc);
       wait_for_kthread_stop();
--
2.43.0

