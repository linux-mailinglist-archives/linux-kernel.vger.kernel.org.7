Return-Path: <linux-kernel+bounces-880154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B5C24FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF4704F4606
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75433FE39;
	Fri, 31 Oct 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pNpAfdzW"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EA305E02;
	Fri, 31 Oct 2025 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913560; cv=none; b=tZRt+TOnaWM7hVKtK0VrE9cAwoIWdDECrTDB+ElDlj0zPpzJQfNnbFQVbnW5A7F/cQJPqSS577H1xY3Q266kkU3KNgnqdIS66hS28bWyKnw46VnsETOQDrgTZq+3X8StetjA1iQGJGJiqqknfJFbnaIv7ce+w+eGXKKKXNYzX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913560; c=relaxed/simple;
	bh=+2UonHQLD58Zbc0/s/PV+vfI+D6frN46kJ6879B+8Hc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RYNJCVeVkuftRyz8wUK4/34aYOUkjs15tef9uvGnefkpXMCf0JHwD8baV6hXXUp3K4m5KM5ttthWKdXJI+RoZ9Da0EJf90zQfwLQnTWF4Tx2+iGnuqiOuPCs/6zhVWT/+govyrTFjjMoS+AJ9M3XxiRbCOBmd9TsZFf4bNg5IUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pNpAfdzW; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761913549; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=0iJJ56HyHlVHUe0K6WSYqY6o/tgEUh7N0oHbwmxxNLs=;
	b=pNpAfdzWWlNwo0D6DWBBB/mh+l9mks7UeNK5IcWLkGbtSjX5qWC5RdgfbIinfcjxOYVJqFQtYJ1XMGb6PboH7CxcSAVnIMFvD+l4JjLixDQhtMJ3w20H3IuAUQJKZIfMA4ILLTWgHuLD41SNSRR0eJSMeeQhtDvaiz98NYhe8nk=
Received: from 30.180.79.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrOw1AG_1761913547 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 20:25:48 +0800
Message-ID: <bc738580-4e1f-411f-af7b-f76a4ce7b7ea@linux.alibaba.com>
Date: Fri, 31 Oct 2025 20:25:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, guanghuifeng@linux.alibaba.com,
 zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
 <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
 <2025103155-definite-stays-ebfe@gregkh>
 <2a9ab583-07fc-4147-949e-7c68feda82f2@linux.alibaba.com>
 <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>
In-Reply-To: <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/31 20:23, Gao Xiang wrote:
> 
> 
> On 2025/10/31 18:12, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2025/10/31 17:58, Greg Kroah-Hartman wrote:
>>> On Fri, Oct 31, 2025 at 05:54:10PM +0800, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/10/31 17:45, Christoph Hellwig wrote:
> 
> ...
> 
>>>>> But why does the device node
>>>>> get created earlier?  My assumption was that it would only be
>>>>> created by the KOBJ_ADD uevent.  Adding the device model maintainers
>>>>> as my little dig through the core drivers/base/ code doesn't find
>>>>> anything to the contrary, but maybe I don't fully understand it.
>>>>
>>>> AFAIK, device_add() is used to trigger devtmpfs file
>>>> creation, and it can be observed if frequently
>>>> hotpluging device in the VM and mount.  Currently
>>>> I don't have time slot to build an easy reproducer,
>>>> but I think it's a real issue anyway.
>>>
>>> As I say above, that's not normal, and you have to be root to do this,
> I just spent time to reproduce with dynamic loop devices and
> actually it's easy if msleep() is located artificiallly,
> the diff as below:
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..a4273b5ad456 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -821,7 +821,7 @@ struct block_device *blkdev_get_no_open(dev_t dev, bool autoload)
>       struct inode *inode;
> 
>       inode = ilookup(blockdev_superblock, dev);
> -    if (!inode && autoload && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
> +    if (0) {
>           blk_request_module(dev);
>           inode = ilookup(blockdev_superblock, dev);
>           if (inode)
> diff --git a/block/genhd.c b/block/genhd.c
> index 9bbc38d12792..3c9116fdc1ce 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -428,6 +428,8 @@ static void add_disk_final(struct gendisk *disk)
>       set_bit(GD_ADDED, &disk->state);
>   }
> 
> +#include <linux/delay.h>
> +
>   static int __add_disk(struct device *parent, struct gendisk *disk,
>                 const struct attribute_group **groups,
>                 struct fwnode_handle *fwnode)
> @@ -497,6 +499,9 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
>       if (ret)
>           goto out_free_ext_minor;
> 
> +    if (disk->major == LOOP_MAJOR)
> +        msleep(2500);           // delay 2.5s for all loops
> +
>       ret = disk_alloc_events(disk);
>       if (ret)
>           goto out_device_del;
> 
> 
> (Note that I masked off CONFIG_BLOCK_LEGACY_AUTOLOAD
>   for cleaner ftrace below.)
> 
> and then
> 
> # uname -a  (patched 6.18-rc1 kernel)
> 
> ```
> Linux 7e5b4b5f5181 6.18.0-rc1-dirty #25 SMP PREEMPT_DYNAMIC Fri Oct 31 19:52:10 CST 2025 x86_64 GNU/Linux
> ```
> 
> # truncate -s 1g test.img; mkfs.ext4 -F test.img;
> # losetup /dev/loop999 test.img & sleep 1; ls -l /dev/loop999; strace mount -t ext4 /dev/loop999 mnt 2>&1 | grep fsconfig
> 
> It shows
> 
> ```
> brw------- 1 root root 7, 999 Oct 31 20:06 /dev/loop999
> fsconfig(3, FSCONFIG_SET_STRING, "source", "/dev/loop999", 0) = 0
> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = -1 ENXIO (No such device or address)  // unexpected
> ```
> 
> then
> 
> # losetup /dev/loop996 test.img & sleep 1; stat /dev/loop996; trace-cmd record -p function_graph mount -t ext4 /dev/loop996 mnt &> /dev/null
> 
> It shows
> ```
>    File: /dev/loop996
>    Size: 0               Blocks: 0          IO Block: 4096   block special file
> Device: 0,6     Inode: 429         Links: 1     Device type: 7,996
> Access: (0600/brw-------)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2025-10-31 20:07:54.938474868 +0800
> Modify: 2025-10-31 20:07:54.938474868 +0800
> Change: 2025-10-31 20:07:54.938474868 +0800
>   Birth: 2025-10-31 20:07:54.938474868 +0800
> ```
> 
> but
> 
> # trace-cmd report | grep mount | less
>             mount-561   [007] ...1.   240.180513: funcgraph_entry:                   |                bdev_file_open_by_dev() {
>             mount-561   [007] ...1.   240.180513: funcgraph_entry:                   |                  bdev_permission() {
>             mount-561   [007] ...1.   240.180513: funcgraph_entry:                   |                    devcgroup_check_permission() {
>             mount-561   [007] ...1.   240.180513: funcgraph_entry:                   |                      __rcu_read_lock() {
>             mount-561   [007] ...1.   240.180514: funcgraph_exit:         0.193 us   |                      } (ret=0x1)
>             mount-561   [007] ...1.   240.180514: funcgraph_entry:                   |                      match_exception_partial() {
>             mount-561   [007] ...1.   240.180514: funcgraph_exit:         0.199 us   |                      } (ret=0x0)
>             mount-561   [007] ...1.   240.180514: funcgraph_entry:                   |                      __rcu_read_unlock() {
>             mount-561   [007] ...1.   240.180515: funcgraph_exit:         0.202 us   |                      } (ret=0x0)
>             mount-561   [007] ...1.   240.180515: funcgraph_exit:         1.602 us   |                    } (ret=0x0)
>             mount-561   [007] ...1.   240.180515: funcgraph_exit:         2.100 us   |                  } (ret=0x0)
>             mount-561   [007] ...1.   240.180515: funcgraph_entry:                   |                  ilookup() {
>             mount-561   [007] ...1.   240.180516: funcgraph_entry:                   |                    __cond_resched() {
>             mount-561   [007] ...1.   240.180516: funcgraph_exit:         0.194 us   |                    } (ret=0x0)
>             mount-561   [007] ...1.   240.180516: funcgraph_entry:                   |                    find_inode_fast() {
>             mount-561   [007] ...1.   240.180516: funcgraph_entry:                   |                      __rcu_read_lock() {
>             mount-561   [007] ...1.   240.180516: funcgraph_exit:         0.195 us   |                      } (ret=0x1)
>             mount-561   [007] ...1.   240.180517: funcgraph_entry:                   |                      __rcu_read_unlock() {
>             mount-561   [007] ...1.   240.180517: funcgraph_exit:         0.193 us   |                      } (ret=0x0)
>             mount-561   [007] ...1.   240.180517: funcgraph_exit:         1.060 us   |                    } (ret=0x0)
>             mount-561   [007] ...1.   240.180517: funcgraph_exit:         1.970 us   |                  } (ret=0x0)
>             mount-561   [007] ...1.   240.180518: funcgraph_exit:         4.818 us   |                } (ret=-6)
> 
> here -6 (-ENXIO) is unexpected.
> 
> Actually the problematic code path I've said is device_add():
> 
> upstream code:
> 
> loop_control_ioctl
>   loop_add
>     add_disk_fwnode
>       __add_disk
>         devtmpfs_create_node   // here create devtmpfs blkdev file, but racy
>       add_disk_final
>         bdev_add
>           insert_inode_hash    // just seen by bdev_file_open_by_dev()
>         disk_uevent(disk, KOBJ_ADD)

minor revision:

  loop_control_ioctl
    loop_add
      add_disk_fwnode
        __add_disk
          device_add
            devtmpfs_create_node   // here create devtmpfs blkdev file, but racy
        add_disk_final
          bdev_add
            insert_inode_hash    // just seen by bdev_file_open_by_dev()
          disk_uevent(disk, KOBJ_ADD)

> 
> I actually think it's enough to explain the root.
> 
> Thanks,
> Gao Xiang


