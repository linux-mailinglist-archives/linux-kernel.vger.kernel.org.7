Return-Path: <linux-kernel+bounces-842016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9FBB8C78
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0BE189E8E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1D26C383;
	Sat,  4 Oct 2025 10:43:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584C13774D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759574617; cv=none; b=mCk38/VX836a5+CKKL2ov8CT/cAMz5P9GzghTPBFtmL5NwKVrTnfacINjvUqG25moM0tRjXpQ8QtvPSzfoNkDugZso1CKSHiJJJZo6krxzaRMMJmK6LKT5esysWrB1mzMRAdJ8SCe4kjnSNaOnEPCng4++Ald6qhqOL+hEkDKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759574617; c=relaxed/simple;
	bh=LSc2k3JG640I+h7g5SBcDrjqgT5YyCRJVhxvq/KrV/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ua/P4Cc+HRNXhyro9xC3XguGAgjcp+BTBB7HQWyZ9qbM6CZtKmukhchvwZNxskxBwoMVgBOWquwCkCRBDBB8qTPR7jgmcR9vjxWTVZlw2jDPxchL4dcV2ItCabtH5mKjnYkNU5qlSDje+rBehMdhIglIZl1tgojxtZBgw7NR8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 594Ah8tw090063;
	Sat, 4 Oct 2025 19:43:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 594Ah1dj090035
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 4 Oct 2025 19:43:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <842b3b43-0a1c-4fe8-adff-94fdb2cee59b@I-love.SAKURA.ne.jp>
Date: Sat, 4 Oct 2025 19:43:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 ntfs_set_size
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        Edward Adam Davis <eadavis@qq.com>
Cc: syzbot <syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
 <bcd184f1-acbc-46c7-9e30-045a8f17fc5c@I-love.SAKURA.ne.jp>
 <d79cb8dd-7dc3-49da-8fb1-793fa7e2a7e0@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <d79cb8dd-7dc3-49da-8fb1-793fa7e2a7e0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/20 18:42, Tetsuo Handa wrote:
> On 2025/09/16 12:48, Tetsuo Handa wrote:
>> Well, we need to also initialize ni->file.run_lock, for vfs_truncate() now
>> passes the
>>
>> 	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
>> 	if (S_ISDIR(inode->i_mode))
>> 		return -EISDIR;
>> 	if (!S_ISREG(inode->i_mode))
>> 		return -EINVAL;
>>
>> check. But do we really want to pretend as if S_IFREG ?
>>
>> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
>> index 37cbbee7fa58..ea2193ebf8fc 100644
>> --- a/fs/ntfs3/inode.c
>> +++ b/fs/ntfs3/inode.c
>> @@ -471,6 +471,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>>                    fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
>>                 /* Records in $Extend are not a files or general directories. */
>>                 inode->i_op = &ntfs_file_inode_operations;
>> +               mode = S_IFREG;
>> +               init_rwsem(&ni->file.run_lock);
>>         } else {
>>                 err = -EINVAL;
>>                 goto out;
>>
>> Are records in $Extend expected to be truncated to arbitrary size? Should we
>> prepend something other than S_IFREG (at least S_IFREG so that truncate()
> 
> pretend something other than S_IFREG (at least S_IFDIR so that truncate()
> 
>> will fail, or possibly S_IFSOCK so that open() will fail) ?

I tested using a legitimate filesystem image, and I came to a conclusion that
pretending as if S_IFREG seems to be OK because normal operations (e.g. read,
truncate) fail with "No such device or address" despite S_IFREG.

Therefore, please apply
https://lkml.kernel.org/r/tencent_F24B651BC22523BA92BB5A337D9E2A1B5F08@qq.com
and send to linux.git .

------------------------------------------------------------
[root@localhost ~]# truncate -s 100M testfile.img
[root@localhost ~]# mkfs.ntfs -F testfile.img
testfile.img is not a block device.
mkntfs forced anyway.
The sector size was not specified for testfile.img and it could not be obtained automatically.  It has been set to 512 bytes.
The partition start sector was not specified for testfile.img and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for testfile.img and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for testfile.img and it could not be obtained automatically.  It has been set to 0.
Cluster size has been automatically set to 4096 bytes.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
Initializing device with zeroes: 100% - Done.
Creating NTFS volume structures.
mkntfs completed successfully. Have a nice day.
[root@localhost ~]# mount -t ntfs3 -o loop testfile.img /mnt/
for i in '$ObjId' '$Quota' '$Reparse'
do
  stat /mnt/\$Extend/$i
  truncate -s 1024 /mnt/\$Extend/$i
  chmod 7777 /mnt/\$Extend/$i
  chown 1 /mnt/\$Extend/$i
  cat /mnt/\$Extend/\$Reparse
  stat /mnt/\$Extend/$i
  rm -f /mnt/\$Extend/$i
done
  File: /mnt/$Extend/$ObjId
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 7,0     Inode: 25          Links: 1
Access: (0000/----------)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2025-10-04 19:26:28.077612000 +0900
Modify: 2025-10-04 19:26:28.077612000 +0900
Change: 2025-10-04 19:26:28.077612000 +0900
 Birth: 2025-10-04 19:26:28.077612000 +0900
truncate: cannot open '/mnt/$Extend/$ObjId' for writing: No such device or address
cat: '/mnt/$Extend/$Reparse': No such device or address
  File: /mnt/$Extend/$ObjId
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 7,0     Inode: 25          Links: 1
Access: (1777/-rwxrwxrwt)  Uid: (    1/     bin)   Gid: (    0/    root)
Access: 2025-10-04 19:26:28.077612000 +0900
Modify: 2025-10-04 19:26:28.077612000 +0900
Change: 2025-10-04 19:28:18.811900400 +0900
 Birth: 2025-10-04 19:26:28.077612000 +0900
  File: /mnt/$Extend/$Quota
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 7,0     Inode: 24          Links: 1
Access: (0000/----------)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2025-10-04 19:26:28.077612000 +0900
Modify: 2025-10-04 19:26:28.077612000 +0900
Change: 2025-10-04 19:26:28.077612000 +0900
 Birth: 2025-10-04 19:26:28.077612000 +0900
truncate: cannot open '/mnt/$Extend/$Quota' for writing: No such device or address
cat: '/mnt/$Extend/$Reparse': No such device or address
  File: /mnt/$Extend/$Quota
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 7,0     Inode: 24          Links: 1
Access: (1777/-rwxrwxrwt)  Uid: (    1/     bin)   Gid: (    0/    root)
Access: 2025-10-04 19:26:28.077612000 +0900
Modify: 2025-10-04 19:26:28.077612000 +0900
Change: 2025-10-04 19:28:18.901901800 +0900
 Birth: 2025-10-04 19:26:28.077612000 +0900
  File: /mnt/$Extend/$Reparse
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 7,0     Inode: 26          Links: 1
Access: (0000/----------)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2025-10-04 19:26:28.077612000 +0900
Modify: 2025-10-04 19:26:28.077612000 +0900
Change: 2025-10-04 19:26:28.077612000 +0900
 Birth: 2025-10-04 19:26:28.077612000 +0900
truncate: cannot open '/mnt/$Extend/$Reparse' for writing: No such device or address
cat: '/mnt/$Extend/$Reparse': No such device or address
  File: /mnt/$Extend/$Reparse
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 7,0     Inode: 26          Links: 1
Access: (1777/-rwxrwxrwt)  Uid: (    1/     bin)   Gid: (    0/    root)
Access: 2025-10-04 19:26:28.077612000 +0900
Modify: 2025-10-04 19:26:28.077612000 +0900
Change: 2025-10-04 19:28:18.983903100 +0900
 Birth: 2025-10-04 19:26:28.077612000 +0900
------------------------------------------------------------


