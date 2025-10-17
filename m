Return-Path: <linux-kernel+bounces-858351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE339BEA60C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98188188EECF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703832E151;
	Fri, 17 Oct 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z290NZR0"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB57330B0F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716532; cv=none; b=DXOp/Fw/VO7VS3Z7ZAgr480oBynFzV5+2xfyWWvp4SwD5LezTFuX9nAWX7othTs5ouT1MdLhOhrXCBFsezd4WGF4T9cnog1Bqz7/EmCXAwdjnTwsAy7XGgC1zb/Ih/VI6GTzLa3rGyHu+jLt5dMIhy59ymV1lbGjMv6r5gn8rR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716532; c=relaxed/simple;
	bh=1tvSfTHGurP+YgnYoYArqQ4i1F37sHNvWcmfmhmMExM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2m6atu+aTezHFFYL2coF8G07xA3pgd6NQNR6bw/c3Tk8SElWJvriZPseesCwDWxIYOSdpdx6CY3qS6tXeAoM/0BOFy4+T8QUp4qjlWnrM6I7IR0vHh3yqqPFRY0C7W1N9+qI/1WgCNMHamJcIgaVzNIpQcRDSgwrUHICjO142M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z290NZR0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-371e4858f74so24457381fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760716528; x=1761321328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RajXSrmZKy8qXDxaoJ6uPaA9OuJZXMNzYpFQjJFfOz0=;
        b=Z290NZR0kz40wl/OFByDZgBln1eWwbxboKLPtccNe5PlUXzgXbkMZZ+HmolG8KpdKG
         PpLn2kPZfElNFWUwC8EOolm0NUimweufrhIHaEOVMW7Y+kWNUJD7gZufwQ/YiEYDQZ7U
         K5wX9n5sEhVhSif1nvELy2F8t5UkDA0VEObVPh3H9zxFMa/CVoAig7p1iVFAGdSjrsMv
         55hXrqkk4KyvqE5vG6RJs+xoBjy8neJcWAYoriL2LVf8gstt9Q8BT8dwB3G3Acbnm+vL
         A6/EdWcCYozvK8X1/ATxypJzqONqQRHviL78nhvrMmzoUnzWuIFuokPamD8PUrHtdMrX
         BlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716528; x=1761321328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RajXSrmZKy8qXDxaoJ6uPaA9OuJZXMNzYpFQjJFfOz0=;
        b=QYBEfV8ySw/4gURbqy0JGHQX60QAR+a921p7j2CmefQ3euXyDFajS6IOu2xYM6TV7m
         ge1UE3pN3SpK9L3BvnmV9qjJXq7n5JKe7R25Yj7qhmOX6ZevEirO+Kz9H354m2c8vxs1
         3ZHhIgnxHT33seayovbMWUCp+7pBRcOHsqKltTUjrBg+pc+Lv6ok5uT7W53gg+rzfy1r
         R+wWAM3ORr8tvYW5kRLOES9ZXD3m05jzNDPw+/5vocU30da6dW+sUdLPFl+quM8EMvph
         LgPY/tv/NdhlEAy3luhzfktmAi+VP+BLfQxlzbV6+avdQlvGk60boppmgjDgp9zVkfY0
         spNw==
X-Forwarded-Encrypted: i=1; AJvYcCXG/1SMSjuGPW3mS4ZW01EDTlR5as5od9lnIjQCL64+1G0iy+IVJIMEOOGfzj0igRBEbYJ6QnEANoJufTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9i7rUvBkSQIitU0Hub/OilXyIopcPqaKiILfTmK+0mesXzTy
	o4tAQ+UZ0cE4AoBNIO5Q+Tw1eib8qg8LzI7SjWZLxVe28qPYwnJidQrG
X-Gm-Gg: ASbGnctd+DldC9dYY7Jo0UbWru2pAYLM3WmL6bs2DINuI6jcVfEL4mms4BsE2Rkc6vE
	/XG3RAEynCKHInYELY+mH0sa9y2irCYySbgm3BEAAAeUYhxp17xdoagsT7v3r1uSp4DPVI+bcDa
	gnTwRa+4Y2VIKIbA65UKbm9eAdUJurajyCsALbOL2mMxq30b5cxmfa8myxlZOkhXP2SnebSVACN
	Gn3IlIXeD36Ityj8U9vlDFKO5Zib6KhBh9L/0bJhcP3EfJUsHGaEQd4oW+j8DGcl7frtMbl7lVc
	+ZKbvcN6sgDHD5GxpxitCYovbauhrySZxFaZuoYZM2o+4oO9AA0K9PCPMH+PoX/sp+xd2ES+Uvq
	2DU+9pMdH8MWerjbmllvJji0JQX3bXtQu1CxmLXQzpyILCdkzIlBbQw==
X-Google-Smtp-Source: AGHT+IFTA12aXzaOiABKMYAu9IJovlveJhjnsuF7ZTZcu0BvXPxLXKDrAfPiJQtLGl23ibsv7H9gsg==
X-Received: by 2002:a2e:bc05:0:b0:352:91ce:b759 with SMTP id 38308e7fff4ca-377821386e4mr19184011fa.1.1760716528129;
        Fri, 17 Oct 2025 08:55:28 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9586b2dsm331251fa.46.2025.10.17.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:55:27 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 17 Oct 2025 17:55:25 +0200
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>,
	DMML <dm-devel@lists.linux.dev>
Subject: Re: [RESEND PATCH] dm-ebs: Mark full buffer dirty even on partial
 write
Message-ID: <aPJm7Y-O9IxiSBWQ@milan>
References: <20251014144731.164120-1-urezki@gmail.com>
 <20251016125951.27bb194ab31fe5c61f657a71@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016125951.27bb194ab31fe5c61f657a71@linux-foundation.org>

On Thu, Oct 16, 2025 at 12:59:51PM -0700, Andrew Morton wrote:
> On Tue, 14 Oct 2025 16:47:31 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > When performing a read-modify-write(RMW) operation, any modification
> > to a buffered block must cause the entire buffer to be marked dirty.
> > 
> > Marking only a subrange as dirty is incorrect because the underlying
> > device block size(ubs) defines the minimum read/write granularity. A
> > lower device can perform I/O only on regions which are fully aligned
> > and sized to ubs.
> > 
> > This change ensures that write-back operations always occur in full
> > ubs-sized chunks, matching the intended emulation semantics of the
> > EBS target.
> 
> It sounds like this can result in corruption under some circumstances?
> 
> It would be helpful if you could spell this out clearly, please.  What
> are the userspace-visible effects of this bug and how are those effects
> demonstrated?

See below:

<snip>
commit 333b5e9ff2ccb35c3040fa8b0fd7011dfd42aae2
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Oct 8 19:49:50 2025 +0200

    dm-ebs: Mark full buffer dirty even on partial write
    
    When performing a read-modify-write(RMW) operation, any modification
    to a buffered block must cause the entire buffer to be marked dirty.
    
    Marking only a subrange as dirty is incorrect because the underlying
    device block size(ubs) defines the minimum read/write granularity. A
    lower device can perform I/O only on regions which are fully aligned
    and sized to ubs.
    
    This change ensures that write-back operations always occur in full
    ubs-sized chunks, matching the intended emulation semantics of the
    EBS target.
    
    As for user space visible impact, submitting sub-ubs and misaligned
    I/O for devices which are tuned to ubs sizes only, will reject such
    requests, therefore it can lead to losing data. Example:
    
    1) Create a 8K nvme device in qemu by adding
    
    -device nvme,drive=drv0,serial=foo,logical_block_size=8192,physical_block_size=8192
    
    2) Setup dm-ebs to emulate 512B to 8K mapping.
    
    urezki@pc638:~/bin$ cat dmsetup.sh
    
    lower=/dev/nvme0n1
    len=$(blockdev --getsz "$lower")
    
    echo "0 $len ebs $lower 0 1 16" | dmsetup create nvme-8k
    urezki@pc638:~/bin$
    
    offset 0, ebs=1 and ubs=16(in sectors).
    
    3) Create an ext4 filesystem(default 4K block size)
    
    urezki@pc638:~/bin$ sudo mkfs.ext4 -F /dev/dm-0
    mke2fs 1.47.0 (5-Feb-2023)
    Discarding device blocks: done
    Creating filesystem with 2072576 4k blocks and 518144 inodes
    Filesystem UUID: bd0b6ca6-0506-4e31-86da-8d22c9d50b63
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
    
    Allocating group tables: done
    Writing inode tables: done
    Creating journal (16384 blocks): done
    Writing superblocks and filesystem accounting information: mkfs.ext4: Input/output error while writing out and closing file system
    urezki@pc638:~/bin$ dmesg
    
    <snip>
    [ 1618.875449] buffer_io_error: 1028 callbacks suppressed
    [ 1618.875456] Buffer I/O error on dev dm-0, logical block 0, lost async page write
    [ 1618.875527] Buffer I/O error on dev dm-0, logical block 1, lost async page write
    [ 1618.875602] Buffer I/O error on dev dm-0, logical block 2, lost async page write
    [ 1618.875620] Buffer I/O error on dev dm-0, logical block 3, lost async page write
    [ 1618.875639] Buffer I/O error on dev dm-0, logical block 4, lost async page write
    [ 1618.894316] Buffer I/O error on dev dm-0, logical block 5, lost async page write
    [ 1618.894358] Buffer I/O error on dev dm-0, logical block 6, lost async page write
    [ 1618.894380] Buffer I/O error on dev dm-0, logical block 7, lost async page write
    [ 1618.894405] Buffer I/O error on dev dm-0, logical block 8, lost async page write
    [ 1618.894427] Buffer I/O error on dev dm-0, logical block 9, lost async page write
    <snip>
    
    Many I/O errors because the lower 8K device rejects sub-ubs/misaligned
    requests.
    
    with a patch:
    
    urezki@pc638:~/bin$ sudo mkfs.ext4 -F /dev/dm-0
    mke2fs 1.47.0 (5-Feb-2023)
    Discarding device blocks: done
    Creating filesystem with 2072576 4k blocks and 518144 inodes
    Filesystem UUID: 9b54f44f-ef55-4bd4-9e40-c8b775a616ac
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
    
    Allocating group tables: done
    Writing inode tables: done
    Creating journal (16384 blocks): done
    Writing superblocks and filesystem accounting information: done
    
    urezki@pc638:~/bin$ sudo mount /dev/dm-0 /mnt/
    urezki@pc638:~/bin$ ls -al /mnt/
    total 24
    drwxr-xr-x  3 root root  4096 Oct 17 15:13 .
    drwxr-xr-x 19 root root  4096 Jul 10 19:42 ..
    drwx------  2 root root 16384 Oct 17 15:13 lost+found
    urezki@pc638:~/bin$
    
    After this change: mkfs completes; mount succeeds.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 6abb31ca9662..b354e74a670e 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -103,7 +103,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
 			} else {
 				flush_dcache_page(bv->bv_page);
 				memcpy(ba, pa, cur_len);
-				dm_bufio_mark_partial_buffer_dirty(b, buf_off, buf_off + cur_len);
+				dm_bufio_mark_buffer_dirty(b);
 			}
 
 			dm_bufio_release(b);
<snip>

--
Uladzislau Rezki

