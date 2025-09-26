Return-Path: <linux-kernel+bounces-834008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9033BA396F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31407AEBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ADB2EB866;
	Fri, 26 Sep 2025 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0WekZMX"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AA2DD60F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889211; cv=none; b=u//FauBSGJEIykPDNiIipm/mtxiQcymH65tqMZherbLBekvXclF2vtWOSCMzCFsxX9lu9hhrcVeCpoLLJdgCmoh08q6TE1fHijwSn5TR7TocOdc2BgZHNt9V/1XFIll0g5QogORmOGWuVHFbghz1QpqTFLH+4HbMJV5/72zPaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889211; c=relaxed/simple;
	bh=gz7PYCx8C7VbuVpe1N5ETR7y/DgnTEF5RUfAmzZzGyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlmTmESbL6YVWNCFu8gBFWEnl4+a7Le4cQnYDyIqCpq57mTkxoJIUXD8WrJKXEUckkdzzq7KcINspxtg6Nim0UX1hGvcBGvu2U2hjuMWI9aq71Z2ZEGe0GoPPRqxeuVGmYIl8JURTHNM8NJyjMx+RtneoKCfbnfEQ6wB7x2Stsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0WekZMX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b4739538so2253045a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758889209; x=1759494009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63XaMfzK8yhyDQm37+O5+ql9FVzf01Td2YS2+vRTpGE=;
        b=A0WekZMXskQ8asHR+NvPPTCvkV/MGqiolViKUbqETa6Q3DaTqDNbZ+NJDJ2v1m9WGW
         KXvRG3tvjvV3MPU2F1eKlgsw2N//+SHli3TS6/iL7braXWinR1dBZVD8wKeIVkS+2afF
         ZXrk2VQobOjahe/t/Kkp4EdxdEKlEora0kjfpQCE0wlYMucsqTIAtGICRTBrLfm8eJns
         KYX6EK8K0+5ZsU7FAyRM38Da12G1F1lrg4vE1YfZ9WGC6tFZ2HxpeehMYAwjDfsrgEvd
         A4exwHevFURnOgSxOZ8qhdPUbbdWo3vFPVrTWRrRA1aftxkm0xuPKlnOCCC0GGWtgEiI
         8wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758889209; x=1759494009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63XaMfzK8yhyDQm37+O5+ql9FVzf01Td2YS2+vRTpGE=;
        b=hrDLTsZWxCkZA4uklhvNcDOaeo0eav1XbvmgskqgAOhfz+BhcIWApflm5GzONYyNyL
         DAX+lCIFn1BBCnuXuGN2qpfIECZ9cDb3AexEBOiBBQPt9ApzZSYdoozldKamoMYh4QI9
         n/oQcbrxeiJ3GXOsvsfPkO9/gPmLGWzHaDWSkQ9cdcL2D03dvnzDuJOFZrd4pG0bAGT4
         xVyv+Z5ongLd+lTPzqpMyzwh2dsV2OAqyZ6Msr5C0+aaEfxvHVpV/AyN9HE/qfvfl/0M
         vpJLt8sddMl/qmZYnyVySMwJY+R0ShrdhyiyXQYA8XNWDJBiDul+cYL0TQUNP6wBWUUw
         PruQ==
X-Forwarded-Encrypted: i=1; AJvYcCW50NIuOSYX62HadVSJVAXyLIxLqT2qnm35/lCFXYjPz4LXiupuyjU3pFZUplIe35ivd+6LFL81LOqSHLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uAV8Lf67Cn6Ud/bESArb1yvGGtcNYS+vHjtmfgq9jhybCko4
	943YcNu+dI1opkFLo9pbwiV5GgUPRp6XgBqju3UnwJavtj2n+VdoukRQL3YgWFbSgAfSWfzrhbV
	uFxf8EaXigm4doSes/FTAfyiui5iB9TjaLw==
X-Gm-Gg: ASbGncsClSsXkI6M1ZF5fPlNUmTxKSkew68eillC69EVLq7I2ZYW/HZ16fmGhKec0Hf
	nFv8HuTYOapGBnAPNFzZ9KMBG7il99ukmT48N+jScDsaTav1X3WY8HtdwmJlopeUshyTTgJGjAj
	+MCuhRAnAvwfi3ctMWbQXd3vfN263YOS17+AInkJeRy7IXdhJHme/gcxY2iqbXMeSIzxaY28+3o
	nTh3EdvSpTRzGeoTA==
X-Google-Smtp-Source: AGHT+IHn4YvUUyQ9XHaEV3KsqG3nnEUzQaGT6MR+TmYhn7OE0sZfzN9PxJemdpIt5vsKrD9BY0LIiVWU6RtLhkFtlmw=
X-Received: by 2002:a17:90b:4c06:b0:335:28e3:81cd with SMTP id
 98e67ed59e1d1-33528e38f06mr3327973a91.18.1758889208664; Fri, 26 Sep 2025
 05:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758859391.git.zhanghongru@xiaomi.com> <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
In-Reply-To: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Sep 2025 08:19:57 -0400
X-Gm-Features: AS18NWBN3eoEVqsdRCWCmL4ealbBjbXKw5Z6Vj5YkoXeOcJtpUoVAunuQWhxb3A
Message-ID: <CAEjxPJ6K3QfXz+kw9hxLtkyC-4kuNsXq_7wz+g8SB9ObAJQhBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable
 during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:23=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> From: Hongru Zhang <zhanghongru@xiaomi.com>
>
> On mobile device high-load situations, permission check can happen
> more than 90,000/s (8 core system). With default 512 cache nodes
> configuration, avc cache miss happens more often and occasionally
> leads to long time (>2ms) irqs off on both big and little cores,
> which decreases system real-time capability.
>
> An actual call stack is as follows:
>  =3D> avc_compute_av
>  =3D> avc_perm_nonode
>  =3D> avc_has_perm_noaudit
>  =3D> selinux_capable
>  =3D> security_capable
>  =3D> capable
>  =3D> __sched_setscheduler
>  =3D> do_sched_setscheduler
>  =3D> __arm64_sys_sched_setscheduler
>  =3D> invoke_syscall
>  =3D> el0_svc_common
>  =3D> do_el0_svc
>  =3D> el0_svc
>  =3D> el0t_64_sync_handler
>  =3D> el0t_64_sync
>
> Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
> to mitigate long time irqs off, hash conflicts make the bucket average
> length longer because of the fixed size of cache slots, leading to
> avc_search_node latency increase.
>
> Make avc cache slot size also configurable, and with fine tuning, we can
> mitigate long time irqs off with slightly avc_search_node performance
> regression.
>
> Theoretically, the main overhead is memory consumption.
>
> avc_search_node avg latency test results (about 100,000,000 times) on
> Qcom SM8750, 6.6.30-android15-8:
>
> Case 1:
> +---------+---------------------+------------------------+
> |         | no-patch (512/512)  | with-patch (512/512)   |
> +---------+---------------------+------------------------+
> | latency |        85 ns        |         87 ns          |
> +---------+---------------------+------------------------+
>
> Case 2:
> +---------+---------------------+------------------------+
> |         | no-patch (8192/512) | with-patch (8192/8192) |
> +---------+---------------------+------------------------+
> | latency |        277 ns       |         106 ns         |
> +---------+---------------------+------------------------+
>
> Case 1 shows 512 nodes configuration has ~2% performance regression
> with patch.
> Case 2 shows 8192 nodes configuration has ~61% latency benifit with
> patch.
>
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  security/selinux/avc.c                        | 68 +++++++++++++------
>  2 files changed, 50 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 747a55abf494..70dc6d659117 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6620,6 +6620,10 @@
>                         1 -- enable.
>                         Default value is 1.
>
> +       selinux_avc_cache_slots=3D [SELINUX] Set the avc cache slot size.
> +                       Format: <int> (must be >0, power of 2)
> +                       Default: 512
> +
>         serialnumber    [BUGS=3DX86-32]
>
>         sev=3Doption[,option...] [X86-64]
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 430b0e23ee00..7a7f88012865 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -34,7 +34,7 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/avc.h>
>
> -#define AVC_CACHE_SLOTS                        512
> +static int avc_cache_slots __ro_after_init =3D 512;
>  #define AVC_DEF_CACHE_THRESHOLD                512
>  #define AVC_CACHE_RECLAIM              16
>
> @@ -68,9 +68,13 @@ struct avc_xperms_node {
>         struct list_head xpd_head; /* list head of extended_perms_decisio=
n */
>  };
>
> +struct avc_slot {
> +       struct hlist_head       slot;           /* head for avc_node->lis=
t */
> +       spinlock_t              slot_lock;      /* lock for writes */
> +};
> +
>  struct avc_cache {
> -       struct hlist_head       slots[AVC_CACHE_SLOTS]; /* head for avc_n=
ode->list */
> -       spinlock_t              slots_lock[AVC_CACHE_SLOTS]; /* lock for =
writes */
> +       struct avc_slot         *slots;
>         atomic_t                lru_hint;       /* LRU hint for reclaim s=
can */
>         atomic_t                active_nodes;
>         u32                     latest_notif;   /* latest revocation noti=
fication */
> @@ -93,14 +97,34 @@ struct selinux_avc {
>
>  static struct selinux_avc selinux_avc;
>
> +static int __init set_selinux_avc_cache_slots(char *str)
> +{
> +       int val;
> +
> +       if ((kstrtoint(str, 0, &val)) || !is_power_of_2(val)) {
> +               pr_warn("Unable to set selinux_avc_cache_slots, use defau=
lt value\n");
> +               return 1;
> +       }
> +
> +       avc_cache_slots =3D val;
> +
> +       return 1;
> +}
> +__setup("selinux_avc_cache_slots=3D", set_selinux_avc_cache_slots);
> +
>  void selinux_avc_init(void)
>  {
>         int i;
>
> +       selinux_avc.avc_cache.slots =3D
> +               kmalloc_array(avc_cache_slots, sizeof(struct avc_slot), G=
FP_KERNEL);
> +       if (!selinux_avc.avc_cache.slots)
> +               panic("SELinux: No memory to alloc avc cache slots\n");
> +
>         selinux_avc.avc_cache_threshold =3D AVC_DEF_CACHE_THRESHOLD;
> -       for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {
> -               INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
> -               spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
> +       for (i =3D 0; i < avc_cache_slots; i++) {
> +               INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i].slot);
> +               spin_lock_init(&selinux_avc.avc_cache.slots[i].slot_lock)=
;
>         }
>         atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
>         atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
> @@ -124,7 +148,7 @@ static struct kmem_cache *avc_xperms_cachep __ro_afte=
r_init;
>
>  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
>  {
> -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
> +       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
>  }
>
>  /**
> @@ -150,8 +174,8 @@ int avc_get_hash_stats(char *page)
>
>         slots_used =3D 0;
>         max_chain_len =3D 0;
> -       for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {
> -               head =3D &selinux_avc.avc_cache.slots[i];
> +       for (i =3D 0; i < avc_cache_slots; i++) {
> +               head =3D &selinux_avc.avc_cache.slots[i].slot;
>                 if (!hlist_empty(head)) {
>                         slots_used++;
>                         chain_len =3D 0;
> @@ -167,7 +191,7 @@ int avc_get_hash_stats(char *page)
>         return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/=
%d\n"
>                          "longest chain: %d\n",
>                          atomic_read(&selinux_avc.avc_cache.active_nodes)=
,
> -                        slots_used, AVC_CACHE_SLOTS, max_chain_len);
> +                        slots_used, avc_cache_slots, max_chain_len);
>  }
>
>  /*
> @@ -463,11 +487,11 @@ static inline int avc_reclaim_node(void)
>         struct hlist_head *head;
>         spinlock_t *lock;
>
> -       for (try =3D 0, ecx =3D 0; try < AVC_CACHE_SLOTS; try++) {
> +       for (try =3D 0, ecx =3D 0; try < avc_cache_slots; try++) {
>                 hvalue =3D atomic_inc_return(&selinux_avc.avc_cache.lru_h=
int) &
> -                       (AVC_CACHE_SLOTS - 1);
> -               head =3D &selinux_avc.avc_cache.slots[hvalue];
> -               lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
> +                       (avc_cache_slots - 1);
> +               head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
> +               lock =3D &selinux_avc.avc_cache.slots[hvalue].slot_lock;
>
>                 if (!spin_trylock_irqsave(lock, flags))
>                         continue;
> @@ -524,7 +548,7 @@ static inline struct avc_node *avc_search_node(u32 ss=
id, u32 tsid, u16 tclass)
>         struct hlist_head *head;
>
>         hvalue =3D avc_hash(ssid, tsid, tclass);
> -       head =3D &selinux_avc.avc_cache.slots[hvalue];
> +       head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
>         hlist_for_each_entry_rcu(node, head, list) {
>                 if (ssid =3D=3D node->ae.ssid &&
>                     tclass =3D=3D node->ae.tclass &&
> @@ -625,8 +649,8 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass=
,
>         }
>
>         hvalue =3D avc_hash(ssid, tsid, tclass);
> -       head =3D &selinux_avc.avc_cache.slots[hvalue];
> -       lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
> +       head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
> +       lock =3D &selinux_avc.avc_cache.slots[hvalue].slot_lock;
>         spin_lock_irqsave(lock, flag);
>         hlist_for_each_entry(pos, head, list) {
>                 if (pos->ae.ssid =3D=3D ssid &&
> @@ -846,8 +870,8 @@ static int avc_update_node(u32 event, u32 perms, u8 d=
river, u8 base_perm,
>         /* Lock the target slot */
>         hvalue =3D avc_hash(ssid, tsid, tclass);
>
> -       head =3D &selinux_avc.avc_cache.slots[hvalue];
> -       lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
> +       head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
> +       lock =3D &selinux_avc.avc_cache.slots[hvalue].slot_lock;
>
>         spin_lock_irqsave(lock, flag);
>
> @@ -929,9 +953,9 @@ static void avc_flush(void)
>         unsigned long flag;
>         int i;
>
> -       for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {
> -               head =3D &selinux_avc.avc_cache.slots[i];
> -               lock =3D &selinux_avc.avc_cache.slots_lock[i];
> +       for (i =3D 0; i < avc_cache_slots; i++) {
> +               head =3D &selinux_avc.avc_cache.slots[i].slot;
> +               lock =3D &selinux_avc.avc_cache.slots[i].slot_lock;
>
>                 spin_lock_irqsave(lock, flag);
>                 /*
> --
> 2.43.0
>

