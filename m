Return-Path: <linux-kernel+bounces-772733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED1B296EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0EE202AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514B2475CD;
	Mon, 18 Aug 2025 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPA4YBtQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F6217F27
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483727; cv=none; b=bKmXABwbETkFfrpVhW/zYDGVANqbG7fRoZMvDq0dGRUsPWfVsi9pK0fvPBtYU+Nm36qeoc2Zay/59IVAHmz8CFqsiJRJnNQEk9HKlvvcu6q93xoA5UdjkWI9irfFFF6fkIQl5I4CN9n5TNSn5BHn+XW3NUdz0Sd5+VbmcoAgwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483727; c=relaxed/simple;
	bh=cqnUdXbETZ7PEW80hN447lfLycGNJFAFDB9FqftqAT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7oMmPJGsi6CQ7zhHwriNPD/MmNTu9IMa8N6Ttv1pdDQhoerShhkXP2Di1i9IAkIfO/3p1XgSHlQqWAYOuG5VCUByJFm/+faWGz+8Ca37Ljwf5/RB6IDI4On+MSFvfMGtennE0aCIEpnEUG67DLxENfuVf6RVioz8O+SKYuSERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPA4YBtQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1fc6996aso2308505e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755483723; x=1756088523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi3M8VeXGVyCI4eTImbpFjJmeHNhhaSY72ucJJ2I/Zk=;
        b=dPA4YBtQikLwqys9pNAUf8d7W1TSIc88wjj93pYSS0bQ8TcAy0K9LzWcUyLusITrI6
         EPHXbqOgE421a2cz/zAyQ828TWc/mflfPD+zhrmiThquB0Xoo5lKreIixRntt5W5ito5
         CoAvmHrBe/jrzs5Y+h/s15rx1RGO+ZWixzjJQnxyEln5n01hF9BDomECQlcqJpJayjUZ
         a+KZm9kzMR+MoUU15D59C/Q2889jX3QJ/xHoGz7l8mjs2xjs4Ek5yckm/wtTKvUUNaaL
         O0twDRxMiYx3mhgGbrMYZPkHXp2E6kIBWou/VS3vTULoT0XY7JAswQAa9aJEs6ROGtE7
         tPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755483723; x=1756088523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi3M8VeXGVyCI4eTImbpFjJmeHNhhaSY72ucJJ2I/Zk=;
        b=GwomHmQ6akHNrFnbFHIhdPmmJlozZuQtxUOCpelIe75gfjEjM2cpOKUyc6ngFaWwZJ
         +oXFq+ZAjUS8TE8gPUBg4mIxfbOtLxmmqQWo61jVYa/5XCW7A6Ev8CdGO/IkS867cVE+
         qVaLy1Zy/wOqLEnMULsfZ0+Luxiu6NKO3hpiicsAJiCtRsgaz4ZiDGT8FK95fA8vJQ1H
         aOBTWIrcN0JXtfx4vs/W1nqbVmh2wX5QhkqyXOSNOBOg7YwXm0NrKb0ObEG61fItK7EY
         n2PneQDCKcuscogWSTO1kVZMWMwrqp8+HXsVxo5LRczIjO30LH3MUMjy0yXQarwdfiNo
         dsgw==
X-Forwarded-Encrypted: i=1; AJvYcCVT6vWIznq/H9cbqcJHZp6i13IB74lrMoljfVcChsgRf66ycey/TMxnt4jr5GpEANxnKPT/ezKZcgBueFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdqxskE9KQVbxryeJlO3z/Yif8yu8J9bwDg2E5qnepA5ksmTV
	CWvCZ0gWSlqyfPW5z1NAdeK7bEY9jAx77duA+lojovk98v7ZythXM/1xNEaQ5pp8VDcRc7yhM7m
	OIjcsnhHO0/SiwzhuMd3Pf8Ll/Wbz0FA=
X-Gm-Gg: ASbGncs41h69vqY1RdP5lCVuWlb4EfP8X268mvm1Rz0PEs01jbNZLqT2JqHMeqQZ8Ec
	Xt//E277qnJ0Pt2fmRGilEnoMQxuY4gklD7s6XTWbkU9B8J3rCIt9ONjhZTw1yeq0BTZKOM9WWW
	UidPrxol8bBU6xA9PD8Muuo72DARBtnwgVP5tfWN4IaTiZG/MoT4TaiEX0UK7MvLEGmCgq5frOt
	DcxXAXy
X-Google-Smtp-Source: AGHT+IFtUHYCEDw7pG5d0jjbUPAKJRX4adVk6eWICVDFXhDru0uyQdjsCXKi/20gQif1Ea0TFF3/CyJrJWx/DwOHtcY=
X-Received: by 2002:a05:600c:46cf:b0:459:ddd6:1cbf with SMTP id
 5b1f17b1804b1-45a21781fb3mr31358285e9.0.1755483722978; Sun, 17 Aug 2025
 19:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813040455.3900073-1-wangzijie1@honor.com>
In-Reply-To: <20250813040455.3900073-1-wangzijie1@honor.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 18 Aug 2025 10:21:51 +0800
X-Gm-Features: Ac12FXx-jlC9mmfRDV0aIK2r47m0FB2g8yXRdZXrdnxtu4x6T5D_dVn7XRXZbMk
Message-ID: <CAHJ8P3L20KyE2npVnpujp0N+pwaHKp02wPFprAaLVFjuSKpPdA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: reduce nat_tree_lock hold time when
 flush nat entries
To: wangzijie <wangzijie1@honor.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org, 
	feng.han@honor.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wangzijie <wangzijie1@honor.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=89 12:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Sometimes I suffered the nat_tree_lock contention between f2fs_write_chec=
kpoint
> and f2fs_get_node_info. Commit a9419b6("f2fs: do not bother checkpoint by
> f2fs_get_node_info") also mentioned that situation.
>
> My idea is, when flush nat entries, we can use some structures to record =
nat
> pages we may read, and readahead them before hold nat_tree_lock. Before
> impletement code, I did some survey and found a submittion in community.
>
> Subject: f2fs: use bucket sort to avoid tree lookup and list sort when na=
t flushing
> Link: https://lore.kernel.org/linux-f2fs-devel/20170520122435.17574-2-hou=
pengyang@huawei.com/
> This patch aims to improve nat entry set sort by using bucket.
> I steal that structure and readahead nat pages contain nat entry set whic=
h cannot be moved
> to journal according to dirty nat entry set bucket.
>
> By doing this, I think there are two benefits to reducing nat_tree_lock h=
old time when
> when flush nat entries.
> 1. avoid nat set tree lookup and sort
> 2. readahead nat pages before holding nat_tree_lock
>
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/f2fs.h |  1 +
>  fs/f2fs/node.c | 70 ++++++++++++++++++++++++--------------------------
>  fs/f2fs/node.h |  2 +-
>  3 files changed, 35 insertions(+), 38 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 46be75605..b27cc059f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -975,6 +975,7 @@ struct f2fs_nm_info {
>         struct radix_tree_root nat_set_root;/* root of the nat set cache =
*/
>         struct f2fs_rwsem nat_tree_lock;        /* protect nat entry tree=
 */
>         struct list_head nat_entries;   /* cached nat entry list (clean) =
*/
> +       struct list_head nat_dirty_set[NAT_ENTRY_PER_BLOCK + 1];        /=
* store dirty nat set */
>         spinlock_t nat_list_lock;       /* protect clean nat entry list *=
/
>         unsigned int nat_cnt[MAX_NAT_STATE]; /* the # of cached nat entri=
es */
>         unsigned int nat_blocks;        /* # of nat blocks */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 27743b93e..87c975ee8 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -244,6 +244,12 @@ static void __del_from_nat_cache(struct f2fs_nm_info=
 *nm_i, struct nat_entry *e)
>         __free_nat_entry(e);
>  }
>
> +static void __relocate_nat_entry_set(struct f2fs_nm_info *nm_i,
> +                                                       struct nat_entry_=
set *set)
> +{
> +       list_move_tail(&set->set_list, &nm_i->nat_dirty_set[set->entry_cn=
t]);
> +}
Hi zijie,
Is there any lock protecting this list related operations in the
current process?
> +
>  static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *n=
m_i,
>                                                         struct nat_entry =
*ne)
>  {
> @@ -260,6 +266,7 @@ static struct nat_entry_set *__grab_nat_entry_set(str=
uct f2fs_nm_info *nm_i,
>                 head->set =3D set;
>                 head->entry_cnt =3D 0;
>                 f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
> +               __relocate_nat_entry_set(nm_i, head);
>         }
>         return head;
>  }
> @@ -279,8 +286,10 @@ static void __set_nat_cache_dirty(struct f2fs_nm_inf=
o *nm_i,
>          * 2. update old block address to new one;
>          */
>         if (!new_ne && (get_nat_flag(ne, IS_PREALLOC) ||
> -                               !get_nat_flag(ne, IS_DIRTY)))
> +                               !get_nat_flag(ne, IS_DIRTY))) {
>                 head->entry_cnt++;
> +               __relocate_nat_entry_set(nm_i, head);
> +       }
>
>         set_nat_flag(ne, IS_PREALLOC, new_ne);
>
> @@ -309,6 +318,7 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_in=
fo *nm_i,
>
>         set_nat_flag(ne, IS_DIRTY, false);
>         set->entry_cnt--;
> +       __relocate_nat_entry_set(nm_i, set);
>         nm_i->nat_cnt[DIRTY_NAT]--;
>         nm_i->nat_cnt[RECLAIMABLE_NAT]++;
>  }
> @@ -2976,24 +2986,6 @@ static void remove_nats_in_journal(struct f2fs_sb_=
info *sbi)
>         up_write(&curseg->journal_rwsem);
>  }
>
> -static void __adjust_nat_entry_set(struct nat_entry_set *nes,
> -                                               struct list_head *head, i=
nt max)
> -{
> -       struct nat_entry_set *cur;
> -
> -       if (nes->entry_cnt >=3D max)
> -               goto add_out;
> -
> -       list_for_each_entry(cur, head, set_list) {
> -               if (cur->entry_cnt >=3D nes->entry_cnt) {
> -                       list_add(&nes->set_list, cur->set_list.prev);
> -                       return;
> -               }
> -       }
> -add_out:
> -       list_add_tail(&nes->set_list, head);
> -}
> -
>  static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>                 const struct f2fs_nat_block *nat_blk)
>  {
> @@ -3095,6 +3087,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_inf=
o *sbi,
>
>         /* Allow dirty nats by node block allocation in write_begin */
>         if (!set->entry_cnt) {
> +               list_del(&set->set_list);
>                 radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
>                 kmem_cache_free(nat_entry_set_slab, set);
>         }
> @@ -3109,11 +3102,8 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sb=
i, struct cp_control *cpc)
>         struct f2fs_nm_info *nm_i =3D NM_I(sbi);
>         struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_HOT_DATA);
>         struct f2fs_journal *journal =3D curseg->journal;
> -       struct nat_entry_set *setvec[NAT_VEC_SIZE];
>         struct nat_entry_set *set, *tmp;
> -       unsigned int found;
> -       nid_t set_idx =3D 0;
> -       LIST_HEAD(sets);
> +       int i;
>         int err =3D 0;
>
>         /*
> @@ -3129,6 +3119,16 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sb=
i, struct cp_control *cpc)
>         if (!nm_i->nat_cnt[DIRTY_NAT])
>                 return 0;
>
> +       /* readahead sets which cannot be moved to journal */
> +       if (!__has_cursum_space(journal, nm_i->nat_cnt[DIRTY_NAT], NAT_JO=
URNAL)) {
> +               for (i =3D MAX_NAT_JENTRIES(journal); i <=3D NAT_ENTRY_PE=
R_BLOCK; i++) {
i am a little confused, why is there "i <=3D NAT_ENTRY_PER_BLOCK;"?
do we need to calculate according to the current nat block/entry number?
thanks!
> +                       list_for_each_entry_safe(set, tmp, &nm_i->nat_dir=
ty_set[i], set_list) {
> +                               f2fs_ra_meta_pages(sbi, set->set, 1,
> +                                                               META_NAT,=
 true);
> +                       }
> +               }
> +       }
> +
>         f2fs_down_write(&nm_i->nat_tree_lock);
>
>         /*
> @@ -3141,21 +3141,13 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *s=
bi, struct cp_control *cpc)
>                         nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
>                 remove_nats_in_journal(sbi);
>
> -       while ((found =3D __gang_lookup_nat_set(nm_i,
> -                                       set_idx, NAT_VEC_SIZE, setvec))) =
{
> -               unsigned idx;
> -
> -               set_idx =3D setvec[found - 1]->set + 1;
> -               for (idx =3D 0; idx < found; idx++)
> -                       __adjust_nat_entry_set(setvec[idx], &sets,
> -                                               MAX_NAT_JENTRIES(journal)=
);
> -       }
> -
>         /* flush dirty nats in nat entry set */
> -       list_for_each_entry_safe(set, tmp, &sets, set_list) {
> -               err =3D __flush_nat_entry_set(sbi, set, cpc);
> -               if (err)
> -                       break;
> +       for (i =3D 0; i <=3D NAT_ENTRY_PER_BLOCK; i++) {
> +               list_for_each_entry_safe(set, tmp, &nm_i->nat_dirty_set[i=
], set_list) {
> +                       err =3D __flush_nat_entry_set(sbi, set, cpc);
> +                       if (err)
> +                               break;
> +               }
>         }
>
>         f2fs_up_write(&nm_i->nat_tree_lock);
> @@ -3249,6 +3241,7 @@ static int init_node_manager(struct f2fs_sb_info *s=
bi)
>         struct f2fs_nm_info *nm_i =3D NM_I(sbi);
>         unsigned char *version_bitmap;
>         unsigned int nat_segs;
> +       int i;
>         int err;
>
>         nm_i->nat_blkaddr =3D le32_to_cpu(sb_raw->nat_blkaddr);
> @@ -3275,6 +3268,9 @@ static int init_node_manager(struct f2fs_sb_info *s=
bi)
>         INIT_LIST_HEAD(&nm_i->nat_entries);
>         spin_lock_init(&nm_i->nat_list_lock);
>
> +       for (i =3D 0; i <=3D NAT_ENTRY_PER_BLOCK; i++)
> +               INIT_LIST_HEAD(&nm_i->nat_dirty_set[i]);
> +
>         mutex_init(&nm_i->build_lock);
>         spin_lock_init(&nm_i->nid_list_lock);
>         init_f2fs_rwsem(&nm_i->nat_tree_lock);
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 030390543..d805d4ce7 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -158,7 +158,7 @@ enum mem_type {
>  };
>
>  struct nat_entry_set {
> -       struct list_head set_list;      /* link with other nat sets */
> +       struct list_head set_list;      /* link with nat sets which have =
same entry_cnt */
>         struct list_head entry_list;    /* link with dirty nat entries */
>         nid_t set;                      /* set number*/
>         unsigned int entry_cnt;         /* the # of nat entries in set */
> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

