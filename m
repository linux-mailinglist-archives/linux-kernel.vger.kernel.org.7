Return-Path: <linux-kernel+bounces-775838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204EB2C58E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89923A3463
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751E340DA5;
	Tue, 19 Aug 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="eBW+TyId"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12621ABDB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609751; cv=none; b=PMCOcUSfAdbIWJx6kMpcllvSvlG7hVYy69b+m/Hi6s8s0cFffT1/7Om/t9YMJU9mbZv2ufWa9hlLyXisz7s2iZSNpXZM2l99AT8olbp3l2+rgLGfRTyBRHZ5OEE/t9xoTiLUq8mXZEHabbAXBjC1dPEeuMItQUBQC/AOGuegd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609751; c=relaxed/simple;
	bh=1E4JZ8aGH3HlwPPli3jE2y5zPWjJVQipKz/fVWJFGYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN2vavvPFrKbGv9ju3G54xq76Y3Lxw04VbNr8E1yya1DiWXyCGYZU6Yc3O3DSHaO6Pm6PW6NsZ1FHHBr8rPfs16DWEbRjxAgEvRJA1o0uwuHPVPmIWDzIC7j67kEfcDsUqJlYES0pr5IxgIAPlhw97yVCbZL3efQ0CoioYWTCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=eBW+TyId; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704b7a3dso590567785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755609748; x=1756214548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P960l457x0VFSGMkHgnf1G8UKbEfSCQfpXe7/gcukQ=;
        b=eBW+TyIdBW4zX9XGkahmmdsAtrnYra0LzRa1CvYboV5FI2FnmtLZ7kx4wmFGXj1s+G
         4JwOj/9aNvlmgkkmfsfeAvdT83yIjfsxR7W2uHKtcIv5pdMwVgSUrMNVzJU2MSMd2XE5
         KfKYajrygdyb3DhiEP7igX5y1FTMpt3XlMulOmTRXV0wldbpObrBJNjGjYGTwpf6GQdq
         bMe08XRSSi60DpPFEpxWFSLU1w4eepjQnmoMV7vmFOKdrQptfP8RfGjkASB77YlFcyZD
         RnLGmjk3aW2l1kYwoIzXFk6tTGc5jHwKXmHqafW1KpKyAgaQdLZodwygfNUJlpwKVnYy
         SkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609748; x=1756214548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P960l457x0VFSGMkHgnf1G8UKbEfSCQfpXe7/gcukQ=;
        b=XyaV3BG5aSCgC0jLgarNT7uM/SMOBG0zEHWlSY1eL4yvPr/IEgBoO0r1I4rkMwcLgl
         xLi1MC4XvyYsY2uzxc/ppYuHAzBWLpEx5XYf0GQASVyW/K37FlWPbWtCJtizKgQOWpYq
         4TduS7ALE6oCyqlZCUk7wUyqLHhZh+7ZJ8xNZ65B8K+HXAY6jAK5KkGJjTMUxmcAHj7u
         koPBdwSHnlA1JbalxAiTzn78/3h6M/llkwh3Sp/T6G4z1nxf5sXVa1DDaehW7rFjCWgV
         qs2S1tIy/aO75uzXebSw4PoCh7SG+qx5XU2qH6IrzJvGZak6hkiNy1OkLPP1Gd1tisbq
         oT1A==
X-Forwarded-Encrypted: i=1; AJvYcCVbrapYSAPDiXS2YQRaA2th7PidGXYNR2+qlK0GYY9kIDPuaCnFLEwEzOdWIcf/d8StRDRV6qexj/Z+SvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3wHy2E4IbVjgV12B8A7gQOZ5ZS85oaIU2jV0DfmMVolzSf7A
	zrJOxKsZiUCbl3yYYaXX85Tv0YHQaCxhJGegwwg1tgEqMiX/ynsQTXYVVv3xX8atchGjo8QGXFi
	AYJUG
X-Gm-Gg: ASbGncvhFw4uouSGh5C/ZRv/4OPtfDx+8KPFxR7WwmM/dJQZzXJBvUCeb3iH2KoGQVw
	DHarnYa4HqPUKrhX/eJkDWSJcN9zgNdoqpY7SqhA3Cu6SRqYG922uzkcjEpYcs7f47vUVGRI31W
	ABEk1LDmJzACyxgIvscjSnjKqbz9uO2wQw2Rbao/hZOL6nuFzRRoSYuE/YBu0s/kdEUumpfgm1X
	BHAFI7oHWnPjTSbEHnQGTuNjUlzseu6O8Q3M07nBb94o+rsbtIbNClIlcldY68MuNKaXr5UXPPY
	o2qq2721RcUickx9ilQvSM5rUYsD3+cEn5SPcqEr3ttAuZ6MNoCwZNIBCCsMJRCTaU2BEJc3lW0
	CqC+FqqYecNyfpitWbjO4EfLtRWdHd2VsmER8xA==
X-Google-Smtp-Source: AGHT+IE42zP4btS0EE9jYr75lQyNRvsoLUi4gcKtz3PbuSCKSCYm34JaPAUJgnG7DfdglSxp+ETLhQ==
X-Received: by 2002:a05:620a:319e:b0:7e8:8ec9:bef6 with SMTP id af79cd13be357-7e9f3321237mr316975885a.20.1755609748078;
        Tue, 19 Aug 2025 06:22:28 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e054246sm762137285a.21.2025.08.19.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:22:27 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org
Cc: ethan.ferguson@zetier.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: [PATCH] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Tue, 19 Aug 2025 09:22:13 -0400
Message-Id: <20250819132213.544920-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd-o3TpAaBS65cZFzchCfPdJ8YrN9HHEn_ttr69QB+BFew@mail.gmail.com>
References: <CAKYAXd-o3TpAaBS65cZFzchCfPdJ8YrN9HHEn_ttr69QB+BFew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 21:45, Namjae Jeon wrote:
> On Sun, Aug 17, 2025 at 9:31 AM Ethan Ferguson
> <ethan.ferguson@zetier.com> wrote:
>>
>> Add support for reading / writing to the exfat volume label from the
>> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
>>
>> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
>>
>> ---
>>  fs/exfat/exfat_fs.h  |  2 +
>>  fs/exfat/exfat_raw.h |  6 +++
>>  fs/exfat/file.c      | 56 +++++++++++++++++++++++++
>>  fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 163 insertions(+)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index f8ead4d47ef0..a764e6362172 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -267,6 +267,7 @@ struct exfat_sb_info {
>>         struct buffer_head **vol_amap; /* allocation bitmap */
>>
>>         unsigned short *vol_utbl; /* upcase table */
>> +       unsigned short volume_label[EXFAT_VOLUME_LABEL_LEN]; /* volume name */
> There's no reason to have this in sbi. I think it's better to read the
> volume name in ioctl fslabel and return it.
>
That's fair. I wrote it this way because the volume label is stored in
the sbi in btrfs, but there it's (as far as I understand) part of the
fs header on disk, and not (as is the case in exfat) a directory entry
that could be arbitrarily far from the start of the disk. Maybe we could
cache it in the sbi after the first read? I'm open to either.

>>
>>         unsigned int clu_srch_ptr; /* cluster search pointer */
>>         unsigned int used_clusters; /* number of used clusters */
>> @@ -431,6 +432,7 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
>>  /* super.c */
>>  int exfat_set_volume_dirty(struct super_block *sb);
>>  int exfat_clear_volume_dirty(struct super_block *sb);
>> +int exfat_write_volume_label(struct super_block *sb);
>>
>>  /* fatent.c */
>>  #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
>> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
>> index 971a1ccd0e89..af04cef81c0c 100644
>> --- a/fs/exfat/exfat_raw.h
>> +++ b/fs/exfat/exfat_raw.h
>> @@ -80,6 +80,7 @@
>>  #define BOOTSEC_OLDBPB_LEN             53
>>
>>  #define EXFAT_FILE_NAME_LEN            15
>> +#define EXFAT_VOLUME_LABEL_LEN         11
>>
>>  #define EXFAT_MIN_SECT_SIZE_BITS               9
>>  #define EXFAT_MAX_SECT_SIZE_BITS               12
>> @@ -159,6 +160,11 @@ struct exfat_dentry {
>>                         __le32 start_clu;
>>                         __le64 size;
>>                 } __packed upcase; /* up-case table directory entry */
>> +               struct {
>> +                       __u8 char_count;
>> +                       __le16 volume_label[EXFAT_VOLUME_LABEL_LEN];
>> +                       __u8 reserved[8];
>> +               } __packed volume_label;
>>                 struct {
>>                         __u8 flags;
>>                         __u8 vendor_guid[16];
>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
>> index 538d2b6ac2ec..c57d266aae3d 100644
>> --- a/fs/exfat/file.c
>> +++ b/fs/exfat/file.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/security.h>
>>  #include <linux/msdos_fs.h>
>>  #include <linux/writeback.h>
>> +#include "../nls/nls_ucs2_utils.h"
>>
>>  #include "exfat_raw.h"
>>  #include "exfat_fs.h"
>> @@ -486,6 +487,57 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
>>         return exfat_force_shutdown(sb, flags);
>>  }
>>
>> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long arg)
>> +{
>> +       int ret;
>> +       char utf8[FSLABEL_MAX] = {0};
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +       size_t len = UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
>> +
>> +       mutex_lock(&sbi->s_lock);
>> +       ret = utf16s_to_utf8s(sbi->volume_label, len,
>> +                               UTF16_HOST_ENDIAN, utf8, FSLABEL_MAX);
>> +       mutex_unlock(&sbi->s_lock);
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX))
>> +               return -EFAULT;
>> +
>> +       return 0;
>> +}
>> +
>> +static int exfat_ioctl_set_volume_label(struct super_block *sb, unsigned long arg)
>> +{
>> +       int ret = 0;
>> +       char utf8[FSLABEL_MAX];
>> +       size_t len;
>> +       unsigned short utf16[EXFAT_VOLUME_LABEL_LEN] = {0};
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +
>> +       if (!capable(CAP_SYS_ADMIN))
>> +               return -EPERM;
>> +
>> +       if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX))
>> +               return -EFAULT;
>> +
>> +       len = strnlen(utf8, FSLABEL_MAX);
>> +       if (len > EXFAT_VOLUME_LABEL_LEN)
> Is FSLABEL_MAX in bytes or the number of characters ?
>
the definition mentions chars, and everywhere else it's used it's in
terms of chars, so I'd say it's in terms of bytes. The
FS_IOC_{GET,SET}FSLABEL ioctls are in terms of char[FSLABEL_MAX], so
I think it's reasonable to use it as a number of bytes.

>> +               exfat_info(sb, "Volume label length too long, truncating");
>> +
>> +       mutex_lock(&sbi->s_lock);
>> +       ret = utf8s_to_utf16s(utf8, len, UTF16_HOST_ENDIAN, utf16, EXFAT_VOLUME_LABEL_LEN);
>> +       mutex_unlock(&sbi->s_lock);
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       memcpy(sbi->volume_label, utf16, sizeof(sbi->volume_label));
>> +
>> +       return exfat_write_volume_label(sb);
>> +}
>> +
>>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  {
>>         struct inode *inode = file_inode(filp);
>> @@ -500,6 +552,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>                 return exfat_ioctl_shutdown(inode->i_sb, arg);
>>         case FITRIM:
>>                 return exfat_ioctl_fitrim(inode, arg);
>> +       case FS_IOC_GETFSLABEL:
>> +               return exfat_ioctl_get_volume_label(inode->i_sb, arg);
>> +       case FS_IOC_SETFSLABEL:
>> +               return exfat_ioctl_set_volume_label(inode->i_sb, arg);
>>         default:
>>                 return -ENOTTY;
>>         }
>> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
>> index 8926e63f5bb7..96cd4bb7cb19 100644
>> --- a/fs/exfat/super.c
>> +++ b/fs/exfat/super.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/nls.h>
>>  #include <linux/buffer_head.h>
>>  #include <linux/magic.h>
>> +#include "../nls/nls_ucs2_utils.h"
>>
>>  #include "exfat_raw.h"
>>  #include "exfat_fs.h"
>> @@ -573,6 +574,98 @@ static int exfat_verify_boot_region(struct super_block *sb)
>>         return 0;
>>  }
>>
>> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
>> +                                      struct buffer_head **out_bh,
>> +                                      struct exfat_dentry **out_dentry)
>> +{
>> +       int i;
>> +       unsigned int type;
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +       struct exfat_chain clu;
>> +       struct exfat_dentry *ep;
>> +       struct buffer_head *bh;
>> +
>> +       clu.dir = sbi->root_dir;
>> +       clu.flags = ALLOC_FAT_CHAIN;
>> +
>> +       while (clu.dir != EXFAT_EOF_CLUSTER) {
>> +               for (i = 0; i < sbi->dentries_per_clu; i++) {
>> +                       ep = exfat_get_dentry(sb, &clu, i, &bh);
>> +
>> +                       if (!ep)
>> +                               return -EIO;
>> +
>> +                       type = exfat_get_entry_type(ep);
>> +                       if (type == TYPE_UNUSED) {
>> +                               brelse(bh);
>> +                               return -EIO;
>> +                       }
>> +
>> +                       if (type == TYPE_VOLUME) {
>> +                               *out_bh = bh;
>> +                               *out_dentry = ep;
>> +                               return 0;
>> +                       }
>> +
>> +                       brelse(bh);
>> +               }
>> +
>> +               if (exfat_get_next_cluster(sb, &(clu.dir)))
>> +                       return -EIO;
>> +       }
>> +
>> +       return -EIO;
>> +}
>> +
>> +static int exfat_read_volume_label(struct super_block *sb)
>> +{
>> +       int ret, i;
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +       struct buffer_head *bh;
>> +       struct exfat_dentry *ep;
>> +
>> +       ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
>> +       if (ret < 0)
>> +               goto cleanup;
>> +
>> +       for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
>> +               sbi->volume_label[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
>> +
>> +cleanup:
>> +       if (bh)
>> +               brelse(bh);
>> +
>> +       return ret;
>> +}
>> +
>> +int exfat_write_volume_label(struct super_block *sb)
>> +{
>> +       int ret, i;
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +       struct buffer_head *bh;
>> +       struct exfat_dentry *ep;
>> +
>> +       ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
>> +       if (ret < 0)
>> +               goto cleanup;
>> +
>> +       mutex_lock(&sbi->s_lock);
>> +       for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
>> +               ep->dentry.volume_label.volume_label[i] = cpu_to_le16(sbi->volume_label[i]);
>> +
>> +       ep->dentry.volume_label.char_count =
>> +               UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
>> +       mutex_unlock(&sbi->s_lock);
>> +
>> +cleanup:
>> +       if (bh) {
>> +               exfat_update_bh(bh, true);
>> +               brelse(bh);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  /* mount the file system volume */
>>  static int __exfat_fill_super(struct super_block *sb,
>>                 struct exfat_chain *root_clu)
>> @@ -616,6 +709,12 @@ static int __exfat_fill_super(struct super_block *sb,
>>                 goto free_bh;
>>         }
>>
>> +       ret = exfat_read_volume_label(sb);
> It will affect mount time if volume label entry is located at the end.
> So, we can read it in ioctl fslabel as I said above.
Sounds good. I'll incorporate your changes, and those of
yuezhang.mo@sony.com, and submit version 3 of the patch soon.

>> +       if (ret) {
>> +               exfat_err(sb, "failed to read volume label");
>> +               goto free_bh;
>> +       }
>> +
>>         ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
>>         if (ret) {
>>                 exfat_err(sb, "failed to scan clusters");
>> --
>> 2.50.1
>>

