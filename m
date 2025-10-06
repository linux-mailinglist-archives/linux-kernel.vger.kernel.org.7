Return-Path: <linux-kernel+bounces-842998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B58BBE2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BC384E97AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702902C3248;
	Mon,  6 Oct 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i7dn/dme"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF825B1CE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756786; cv=none; b=TTab1Zly0Vqw4uaR+enxCW45ARU2Rlt3sM7to+mzHaax1F+HB1aVwMc6YpP6wSI4yHnkZR0SkR9jBl++BTbJfjDfmjthcd/QQH1ClRkgP3Q5h4iqL5um4ceuJjIDF5EYoAxiUEgYgv5iiX83tBM6TYRpoMvpQxUeXA+n4vbqfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756786; c=relaxed/simple;
	bh=MZ18A4gLjl2ofNFo8pVu+q9KoC0G2BHWLpsbcUhn5RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlA4/eXJDR0XuqSLKh9y6BeVo1Zzwk7a8lC6EH8oY47iTbVHqNLvM0wtHZ8dcYVd9mCHvVKJw31PbF8lqQ8VeQDyEDPLiM6bfK/+qk665Wv8PvMZy7ApAXqCSELIybWeZvO7EXlMiZcCF9o+mWBGOgED+1v1XWX+rTxfwa+0w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i7dn/dme; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42d857dcf92so19156035ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759756783; x=1760361583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yjlfu6wP14JG2qLbK/JxxY/6QM3hGKhTMIqs+UYsEc=;
        b=i7dn/dmeT+rbWjgi+kowpqT3H6eZYZRPRznyuwDZ9NNrIWQky0W3N8mRMiaBR3Xmd8
         39Gc7GeV1CTUQ70gZabBdDaDymvkPzKPR+ACH4DyHJmzGwLs84sOz2UjtJXcuNvICRFo
         sj5K7MySvId4hvx2qGHUufRgdqCZR0fqIA+gKlyEKbtMcbPx9KdvvTauul/UeLClRW9D
         ZeIjHTx867rg1MXji+jVZx9VeGZz9J85TpvXKti1iU2kM1Q0Lp9pGfjVoYzZzCr7wKhr
         /+UmWgHHOMs09XMIqbW5NZs6BweQywcsUyhuiJPWzrh5FQEBOdMbJpJblInYW0eHBMr9
         +yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756783; x=1760361583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yjlfu6wP14JG2qLbK/JxxY/6QM3hGKhTMIqs+UYsEc=;
        b=jXaa0VDQ4tt6FczwgccvF3Mdje1D46VbAgm8tMuRIjPyNZzCQWrWKhAEkUDwRo/mxL
         mI1Cg2Sk5JhcF3mziptTGQd1Br1W/9gJkcCA7JrggK+nRRdJctxdbmkp6cPVSxzZWt8+
         TDYVqgNd8MABrN5kurZyoQDu1Ov7Glarn63fYGpgKxfnSphNLvFIq8PIKlNS+kanrjH8
         UH2ql0si4+3Zly4HpGXSquPPBgF8lg6nPiLREc/ymPmJSXXW3dBumYM6qKYONWYXcv8P
         qyCjN4aQ2nnz3QVL9xJzkmA4dAe5uzCUGJV9CnAiIRs8c43mLb+tFHqhchj/UeQSrFsk
         KoMA==
X-Forwarded-Encrypted: i=1; AJvYcCViTqBdGzNtrfND5MdL1rCQ1cmaHUczOg72AllsbKQkkMh+xqvWhu+AAquBoS/PFOcP/j7REibX4uEVnUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKlN+HA3blWnKuVlGFBiNfPPG3E2z08hYGKVADusZU43IwXQA
	EgUrlNPSgK27cYL0G9fMO6sJglLw61U+qIaKSINQZrpVWVtOmCACAnl9J3ZH3eJmvVs=
X-Gm-Gg: ASbGncvaNXBqB/Ihedodevxs0D6YpwyBnjHBmjjtKyylmYBBG4m8X8ZPwhwbaLAWa6H
	JvEjsk/coLzoBzMw22KiYZ4nknV2hGi/zv8od3gcYsnQTwheSubWfpBmZ60AA/6JRn81aevnk0/
	Fk8mJjLDN4vRdSp7aSPy1rMnBBzgdiGBVCkOnnGHpCD8PjzlmmscSyIAM1M9NP5BY6pyZSqbavq
	11HXzBdrXmKINQ8f9rTeFkTzFBF11mKLpDlvY7RDhfUEtqAHtqFDeZqh2UE67sr7QVfuaMmnH7x
	8ZYcbXS7hJRZxzJMK8jZvlVClGjQjF5vcGVyPpO+oLeQUeNisiNxeeBj1hbPdCoVQ01sC93Xow2
	2W5FwJzfGb/+26MvVw11kbA3Gu9MxYBlJGGzSZlXw2Yds
X-Google-Smtp-Source: AGHT+IHKeVryFAtYSIbEs3E1K0UFPxxx3iI1l+x8ykYI9cmgWxrUy0Vw2vbSc5wuuCkxsB1Ih5am5g==
X-Received: by 2002:a05:6e02:1c0c:b0:427:70e7:ea09 with SMTP id e9e14a558f8ab-42e7ad400aemr178502065ab.14.1759756782742;
        Mon, 06 Oct 2025 06:19:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42e7bd2f139sm41896385ab.8.2025.10.06.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:19:41 -0700 (PDT)
Message-ID: <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
Date: Mon, 6 Oct 2025 07:19:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>,
 "David S . Miller" <davem@davemloft.net>,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 sparclinux@vger.kernel.org
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 7:00 AM, John Paul Adrian Glaubitz wrote:
> Hi Jens,
> 
> On Mon, 2025-10-06 at 06:48 -0600, Jens Axboe wrote:
>> When you apply this patch and things work, how many times does it
>> generally spin where it would've failed before? It's a bit unnerving to
>> have a never ending spin loop for this, with udelay spinning in between
>> as well. Looking at vio_ldc_send() as well, that spins for potentially
>> 1000 loops of 1usec each, which would be 1ms. With the current limit of
>> 10 retries, the driver would end up doing udelays of:
>>
>> 1
>> 2
>> 4
>> 8
>> 16
>> 32
>> 64
>> 128
>> 128
>> 128
>>
>> which is 511 usec on top, for 10.5ms in total spinning time before
>> giving up. That is kind of mind boggling, that's an eternity.
> 
> The problem is that giving up can lead to filesystem corruption which
> is problem that was never observed before the change from what I know.

Yes, I get that.

> We have deployed a kernel with the change reverted on several LDOMs that
> are seeing heavy use such as cfarm202.cfarm.net and we have seen any system
> lock ups or similar.

I believe you. I'm just wondering how long you generally need to spin,
as per the question above: how many times does it generally spin where
it would've failed before?

>> Not that it's _really_ that important as this is a pretty niche driver,
>> but still pretty ugly... Does it work reliably with a limit of 100
>> spins? If things get truly stuck, spinning forever in that loop is not
>> going to help. In any case, your patch should have
> 
> Isn't it possible that the call to vio_ldc_send() will eventually succeed
> which is why there is no need to abort in __vdc_tx_trigger()?

Of course. Is it also possible that some conditions will lead it to
never succeed?

The nicer approach would be to have sunvdc punt retries back up to the
block stack, which would at least avoid a busy spin for the condition.
Rather than return BLK_STS_IOERR which terminates the request and
bubbles back the -EIO as per your log. IOW, if we've already spent
10.5ms in that busy loop as per the above rough calculation, perhaps
we'd be better off restarting the queue and hence this operation after a
small sleeping delay instead. That would seem a lot saner than hammering
on it.

> And unlike the change in adddc32d6fde ("sunvnet: Do not spin in an infinite
> loop when vio_ldc_send() returns EAGAIN"), we can't just drop data as this
> driver concerns a block device while the other driver concerns a network
> device. Dropping network packages is expected, dropping bytes from a block
> device driver is not.

Right, but we can sanely retry it rather than sit in a tight loop.
Something like the entirely untested below diff.

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index db1fe9772a4d..aa49dffb1b53 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -539,6 +539,7 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct vdc_port *port = hctx->queue->queuedata;
 	struct vio_dring_state *dr;
 	unsigned long flags;
+	int ret;
 
 	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 
@@ -560,7 +561,13 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_DEV_RESOURCE;
 	}
 
-	if (__send_request(bd->rq) < 0) {
+	ret = __send_request(bd->rq);
+	if (ret == -EAGAIN) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		/* already spun for 10msec, defer 10msec and retry */
+		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
+		return BLK_STS_DEV_RESOURCE;
+	} else if (ret < 0) {
 		spin_unlock_irqrestore(&port->vio.lock, flags);
 		return BLK_STS_IOERR;
 	}

-- 
Jens Axboe

