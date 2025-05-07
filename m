Return-Path: <linux-kernel+bounces-637010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96694AAD320
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31965014DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6051684B0;
	Wed,  7 May 2025 02:13:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953C18C03F
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584002; cv=none; b=EK2W6A0wM8wMhZEIMRiR4HyS/hqIr1ysnTAvLIzQfmGTMTmYWIWFIa9Z+0gNnq5fypi7X8r2PjxpHZKs8872dRymvB6OkzBKnCaC98vVOK8UedOABlkKEWZ0BQYyFaDET4eJkjeOKdv9ykWpCUWikiPGlYiYupdT4+wYq9QiPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584002; c=relaxed/simple;
	bh=8MmtaHjE1m9L6Pi0UOXnqnz6Er30JaPgtpmX4plA46o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BHTrmGugsJ42p05SowcqNuyZCh6ANMJWtPlqaEZxbaxnebepXofS04Fe61B6/C80LJlimAhkCl4YSZVpUlBt5C17tivZU4szwSAFVWvIIPg3N4Qx4kIHERz9NWCV5vunfP0lz2R5bXyFuuHz/p9I5v6kzcXBXQV5llt+fGkNa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZsdYM0z0xz13KbK;
	Wed,  7 May 2025 09:52:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D1DFD180B5A;
	Wed,  7 May 2025 09:53:23 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 09:53:23 +0800
Message-ID: <3e068311-9223-4c1b-9091-15eb2d867ede@huawei.com>
Date: Wed, 7 May 2025 09:53:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix file handle encoding for 64-bit NIDs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>
CC: <dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20250429134257.690176-1-lihongbo22@huawei.com>
 <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/5/6 23:10, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/4/29 21:42, Hongbo Li wrote:
>> In erofs, the inode number has the location information of
>> files. The default encode_fh uses the ino32, this will lack
>> of some information when the file is too big. So we need
>> the internal helpers to encode filehandle.
> 
> EROFS uses NID to indicate the on-disk inode offset, which can
> exceed 32 bits. However, the default encode_fh uses the ino32,
> thus it doesn't work if the image is large than 128GiB.
> 
Thanks for helping me correct my description.

Here, an image larger than 128GiB won't trigger NID reversal. It 
requires a 128GiB file inside, and the NID of the second file may exceed 
U32 during formatting. So here can we change it to "However, the default 
encode_fh uses the ino32, thus it may not work if there exist a file 
which is large than 128GiB." ?

Thanks,
Hongbo

> Let's introduce our own helpers to encode file handles.
> 
>>
>> It is easy to reproduce test:
> 
> It's easy to reproduce:
> 
>>    1. prepare an erofs image with nid bigger than UINT_MAX
> 
>       1. Prepare an EROFS image with NIDs larger than U32_MAX
> 
>>    2. mount -t erofs foo.img /mnt/erofs
>>    3. set exportfs with configuration: /mnt/erofs *(rw,sync,
>>       no_root_squash)
>>    4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
>>    5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
>>       than UINT_MAX.
>> For overlayfs case, the under filesystem's file handle is
>> encoded in ovl_fb.fid, it is same as NFS's case.
>>
>> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>> v2: 
>> https://lore.kernel.org/all/20250429074109.689075-1-lihongbo22@huawei.com/
>>    - Assign parent nid with correct value.
>>
>> v1: 
>> https://lore.kernel.org/all/20250429011139.686847-1-lihongbo22@huawei.com/
>>     - Encode generation into file handle and minor clean code.
>>     - Update the commiti's title.
>> ---
>>   fs/erofs/super.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index cadec6b1b554..28b3701165cc 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -511,24 +511,62 @@ static int erofs_fc_parse_param(struct 
>> fs_context *fc,
>>       return 0;
>>   }
>> -static struct inode *erofs_nfs_get_inode(struct super_block *sb,
>> -                     u64 ino, u32 generation)
>> +static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>> +               struct inode *parent)
>>   {
>> -    return erofs_iget(sb, ino);
>> +    int len = parent ? 6 : 3;
>> +    erofs_nid_t nid;
> 
> Just `erofs_nid_t nid = EROFS_I(inode)->nid;`?
> 
> I think the compiler will optimize out `if (*max_len < len)`.
> 
>> +    u32 generation;
> 
> It seems it's unnecessary to introduce `generation` variable here?
> 
>> +
>> +    if (*max_len < len) {
>> +        *max_len = len;
>> +        return FILEID_INVALID;
>> +    }
>> +
>> +    nid = EROFS_I(inode)->nid;
>> +    generation = inode->i_generation;
> 
> So drop these two lines.
> 
>> +    fh[0] = (u32)(nid >> 32);
>> +    fh[1] = (u32)(nid & 0xffffffff);
>> +    fh[2] = generation;
>> +
>> +    if (parent) {
>> +        nid = EROFS_I(parent)->nid;
>> +        generation = parent->i_generation;
>> +
>> +        fh[3] = (u32)(nid >> 32);
>> +        fh[4] = (u32)(nid & 0xffffffff);
>> +        fh[5] = generation;
> 
>          fh[5] = parent->i_generation;
> 
>> +    }
>> +
>> +    *max_len = len;
>> +    return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>>   }
>>   static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
>>           struct fid *fid, int fh_len, int fh_type)
>>   {
>> -    return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
>> -                    erofs_nfs_get_inode);
>> +    erofs_nid_t nid;
>> +
>> +    if ((fh_type != FILEID_INO64_GEN &&
>> +         fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
>> +        return NULL;
>> +
>> +    nid = (u64) fid->raw[0] << 32;
>> +    nid |= (u64) fid->raw[1];
> 
> Unnecessary nid variable.
> 
>> +    return d_obtain_alias(erofs_iget(sb, nid));
> 
>      return d_obtain_alias(erofs_iget(sb,
>              ((u64)fid->raw[0] << 32) | fid->raw[1]));
> 
>>   }
>>   static struct dentry *erofs_fh_to_parent(struct super_block *sb,
>>           struct fid *fid, int fh_len, int fh_type)
>>   {
>> -    return generic_fh_to_parent(sb, fid, fh_len, fh_type,
>> -                    erofs_nfs_get_inode);
>> +    erofs_nid_t nid;
>> +
>> +    if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
>> +        return NULL;
>> +
>> +    nid = (u64) fid->raw[3] << 32;
>> +    nid |= (u64) fid->raw[4];
> 
> Same here.
> 
> Thanks,
> Gao Xiang

