Return-Path: <linux-kernel+bounces-639237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D67AAF4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 09:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513F81C063CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D48C220F2A;
	Thu,  8 May 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX9G3370"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BED221717
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689822; cv=none; b=Co6yKjUu5ZhVX2PEQ0bqhOC5+dS5ZP3mPNPomLTSIT+/oDuqOVeAZp8aH/yTbPX7o/KpwUmM65Tka7Jkm6M8hpLJzo57nZmfqMwVUXFQU8aKaKagPg8zwSjysMnjs6ERFhUE/l9rfziMFVRfEroInd0/ymYpcellPWFmY2HSB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689822; c=relaxed/simple;
	bh=UyudNj8jsYij4dkc08q2Csn7AOkH4eCsxDhrrTlIpiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2BNW9SIsRWbSSWdlf/JOtmvhLPLoHeczDGpkF3APQM9m4YIjfrZ7XV7LqHdzSc0LXhyqfNIc7CNa8s2wrG+ENyq+GgPLHsriOi7a3xwzV02bljU2zLEfCahsDaltGyEd0BqS9k5sttltm0VxAIy/YTJTaFrHJD9DdtAdJ5scmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QX9G3370; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746689819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfpELmsMlIjDbBoLb7SKYzxZXv0bQCaJBscgT2aoxGA=;
	b=QX9G3370slNY81uAol7tgdiS5fTCkhEXbBn1qKbdTt6885TbymPfazEUmK12Cb0AWkrOA1
	mAf5T7CuNDN5zfccJhTIkjJecTUCJCGmGZlLPUGg0MUIWqD+5TEFqDTbRrwoV89Q5L8pnS
	W13m4Rn7/jK7K/eHtDf9eadhZSw3wc0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-gF2Td3PUNRa5yyRViRKjAw-1; Thu, 08 May 2025 03:36:58 -0400
X-MC-Unique: gF2Td3PUNRa5yyRViRKjAw-1
X-Mimecast-MFC-AGG-ID: gF2Td3PUNRa5yyRViRKjAw_1746689817
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e7343c777so6702205ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 00:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746689817; x=1747294617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfpELmsMlIjDbBoLb7SKYzxZXv0bQCaJBscgT2aoxGA=;
        b=m7iV+hfyEhCMbHb1eFk1v/p261fKNsreykVgoVSrIDf0X6E4K+RbJ6Awu0eull4v2r
         7S1+7f6V/ZReiErXish1DF/qDTxEmIHmt9H8oRSyzL2teZblNh5h+VRTFfESG9+799Ia
         jKG1ihzs1qSm51G3biHFbBswAeiZOeWN6UNlzuyJRFWBJ98Esx+9kvq5MTohW9tjJtN/
         f0apbwe68Um5cwWCtVQ0UlPZfpUwsvyoojBjcpAxLtwuji1i2bd0+gHXPqhn4B3ZYOAs
         Zs1tmPvR+Snb9MUYYvfnq662gkHrB5NhGX/YbRI5xgbzjScfxd3Li7/2Kw0Z2UXfAjqv
         K9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFI7oA2vvPJCx6QPQouzUJ+hwP4xzpnF9rxgwMyzol3/OnXhKwL65OEhsu7FyEq15AaXTwj5Aoz7bqs/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKt3q+gk1llrdy0/4k0n7B5sLovAISP0QIQvimvpqvmqchOZM
	+N9ZzJ0JnQ1rWRSJkPKx+cz9lh6kWAgfVZp9BXtnxzuxeGOwgW8dIfaiSnSCj7isU1bMtLSRgmq
	lBPHhOLsN1Beymm1ZIe0yKv7qe34A+eVMmV3U/Dj+isqqLj/7QYMYvTjicN/xgA==
X-Gm-Gg: ASbGncsYx07C+2en3eF38POg/r8lS3kpW48RKUALxTtsfeeT1nQvO6fveBq8GtGWqtW
	mhYDTmxpidseU71iTuu8D5UShIiHzQdLI2WSsQEeLV9VrzxdfI7M+OP2fDA62X3gRhQCfSzn24v
	YcNDsAy4Td7zD7sEP1gJvBGHVPTbTSsUsUS4c+KMSy8k2gouh+sqvPhK3NyZ8o3z/YvYGa6lmAU
	cVxsJmdkrCa2Lw70D9HqEK4dBJTmwCcNqvte4afYHXm2crQ+WBiWlMxVNP5g8Hm3/GWU3WLcetz
	+LS1pa/ZYtMvFLiKwg==
X-Received: by 2002:a17:902:f552:b0:220:e156:63e0 with SMTP id d9443c01a7336-22e5ea1919bmr81060965ad.8.1746689817372;
        Thu, 08 May 2025 00:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIp9mU4ALROa7MseJf7VbJ3xMqjgH+d2m1FTA51FX0ZMyejG1Jqn1rF0RHRIm4Vvn3E5OXEQ==
X-Received: by 2002:a17:902:f552:b0:220:e156:63e0 with SMTP id d9443c01a7336-22e5ea1919bmr81060765ad.8.1746689816987;
        Thu, 08 May 2025 00:36:56 -0700 (PDT)
Received: from [10.72.120.7] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e998bsm106310115ad.67.2025.05.08.00.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 00:36:55 -0700 (PDT)
Message-ID: <4c1b573b-7258-4086-af15-b220a91a5017@redhat.com>
Date: Thu, 8 May 2025 15:36:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] md: fix is_mddev_idle()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, agk@redhat.com,
 song@kernel.org, hch@lst.de, john.g.garry@oracle.com, hare@suse.de,
 pmenzel@molgen.mpg.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250506124658.2537886-1-yukuai1@huaweicloud.com>
 <20250506124903.2540268-1-yukuai1@huaweicloud.com>
 <20250506124903.2540268-9-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
In-Reply-To: <20250506124903.2540268-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/5/6 下午8:49, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> If sync_speed is above speed_min, then is_mddev_idle() will be called
> for each sync IO to check if the array is idle, and inflight sync_io
> will be limited if the array is not idle.
>
> However, while mkfs.ext4 for a large raid5 array while recovery is in
> progress, it's found that sync_speed is already above speed_min while
> lots of stripes are used for sync IO, causing long delay for mkfs.ext4.
>
> Root cause is the following checking from is_mddev_idle():
>
> t1: submit sync IO: events1 = completed IO - issued sync IO
> t2: submit next sync IO: events2  = completed IO - issued sync IO
> if (events2 - events1 > 64)
>
> For consequence, the more sync IO issued, the less likely checking will
> pass. And when completed normal IO is more than issued sync IO, the
> condition will finally pass and is_mddev_idle() will return false,
> however, last_events will be updated hence is_mddev_idle() can only
> return false once in a while.
>
> Fix this problem by changing the checking as following:
>
> 1) mddev doesn't have normal IO completed;
> 2) mddev doesn't have normal IO inflight;
> 3) if any member disks is partition, and all other partitions doesn't
>     have IO completed.
>
> Also change rdev->last_events to unsigned long to cleanup type casting.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 81 ++++++++++++++++++++++++++-----------------------
>   drivers/md/md.h |  3 +-
>   2 files changed, 45 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 541151bcfe81..0fde115e921f 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8625,50 +8625,55 @@ void md_cluster_stop(struct mddev *mddev)
>   	put_cluster_ops(mddev);
>   }
>   
> -static int is_mddev_idle(struct mddev *mddev, int init)
> +static bool is_rdev_holder_idle(struct md_rdev *rdev, bool init)
>   {
> +	unsigned long last_events = rdev->last_events;
> +
> +	if (!bdev_is_partition(rdev->bdev))
> +		return true;
> +
> +	/*
> +	 * If rdev is partition, and user doesn't issue IO to the array, the
> +	 * array is still not idle if user issues IO to other partitions.
> +	 */
> +	rdev->last_events = part_stat_read_accum(rdev->bdev->bd_disk->part0,
> +						 sectors) -
> +			    part_stat_read_accum(rdev->bdev, sectors);
> +
> +	return init || rdev->last_events <= last_events;
> +}
> +
> +/*
> + * mddev is idle if following conditions are matched since last check:
> + * 1) mddev doesn't have normal IO completed;
> + * 2) mddev doesn't have inflight normal IO;
> + * 3) if any member disk is partition, and other partitions don't have IO
> + *    completed;
> + *
> + * Noted this checking rely on IO accounting is enabled.
> + */
> +static bool is_mddev_idle(struct mddev *mddev, int init)
> +{
> +	unsigned long last_events = mddev->normal_io_events;
> +	struct gendisk *disk;
>   	struct md_rdev *rdev;
> -	int idle;
> -	int curr_events;
> +	bool idle = true;
>   
> -	idle = 1;
> -	rcu_read_lock();
> -	rdev_for_each_rcu(rdev, mddev) {
> -		struct gendisk *disk = rdev->bdev->bd_disk;
> +	disk = mddev_is_dm(mddev) ? mddev->dm_gendisk : mddev->gendisk;
> +	if (!disk)
> +		return true;
>   
> -		if (!init && !blk_queue_io_stat(disk->queue))
> -			continue;
> +	mddev->normal_io_events = part_stat_read_accum(disk->part0, sectors);
> +	if (!init && (mddev->normal_io_events > last_events ||
> +		      bdev_count_inflight(disk->part0)))
> +		idle = false;
>   
> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -			      atomic_read(&disk->sync_io);
> -		/* sync IO will cause sync_io to increase before the disk_stats
> -		 * as sync_io is counted when a request starts, and
> -		 * disk_stats is counted when it completes.
> -		 * So resync activity will cause curr_events to be smaller than
> -		 * when there was no such activity.
> -		 * non-sync IO will cause disk_stat to increase without
> -		 * increasing sync_io so curr_events will (eventually)
> -		 * be larger than it was before.  Once it becomes
> -		 * substantially larger, the test below will cause
> -		 * the array to appear non-idle, and resync will slow
> -		 * down.
> -		 * If there is a lot of outstanding resync activity when
> -		 * we set last_event to curr_events, then all that activity
> -		 * completing might cause the array to appear non-idle
> -		 * and resync will be slowed down even though there might
> -		 * not have been non-resync activity.  This will only
> -		 * happen once though.  'last_events' will soon reflect
> -		 * the state where there is little or no outstanding
> -		 * resync requests, and further resync activity will
> -		 * always make curr_events less than last_events.
> -		 *
> -		 */
> -		if (init || curr_events - rdev->last_events > 64) {
> -			rdev->last_events = curr_events;
> -			idle = 0;
> -		}
> -	}
> +	rcu_read_lock();
> +	rdev_for_each_rcu(rdev, mddev)
> +		if (!is_rdev_holder_idle(rdev, init))
> +			idle = false;
>   	rcu_read_unlock();
> +
>   	return idle;
>   }
>   
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index b57842188f18..1982f1f18627 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -132,7 +132,7 @@ struct md_rdev {
>   
>   	sector_t sectors;		/* Device size (in 512bytes sectors) */
>   	struct mddev *mddev;		/* RAID array if running */
> -	int last_events;		/* IO event timestamp */
> +	unsigned long last_events;	/* IO event timestamp */
>   
>   	/*
>   	 * If meta_bdev is non-NULL, it means that a separate device is
> @@ -520,6 +520,7 @@ struct mddev {
>   							 * adding a spare
>   							 */
>   
> +	unsigned long			normal_io_events; /* IO event timestamp */
>   	atomic_t			recovery_active; /* blocks scheduled, but not written */
>   	wait_queue_head_t		recovery_wait;
>   	sector_t			recovery_cp;


Looks good to me

Reviewed-by: Xiao Ni <xni@redhat.com>


