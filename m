Return-Path: <linux-kernel+bounces-756167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80AB1B0BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40A317D541
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49EA242D70;
	Tue,  5 Aug 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQbG6Nhn"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF65259C92
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384942; cv=none; b=i4l+dTUqTTNxhYlw5gxRTWzhHzAW2uvsp96tlh44/ANn5Ftqg07v/Jo6EuVJgKRlRJu8Z6Y7ikycIPp/XCdhiW59YM3ipgrIyPXMouVgemTgFzJBZvZcr4g5/ymPt9ElMOyzl4KqAjJUuIJxDaff/DQTyWOU5w2mEQQ06y9X5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384942; c=relaxed/simple;
	bh=8p6C4aYe2SKh+tq5i+Vi9J40BRHT4dPQN0Bdhbrv0GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeoI9PLY6Qt+wOyNS+6mqgM1avBTjdjsUtWl0jsxfB7Rim7TznOR4UlC0zBy507UtyfS/pZ2RRO64l9cGCHjQsPXE+kBy06Ee8UoICmqTsJ/87M92i85U9EeSWrGTwCpGQybdFr4ClHoRfIZjwregbDmRJH4insIZ75+l8EHpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NQbG6Nhn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so3121602a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754384939; x=1754989739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ig3ejo4wL4oEVtv/WkueYSUf7qCSryypCGes3HapAjU=;
        b=NQbG6NhnAa/lq2HyHhHqOGFEJi4CgEAFCr0argLKm90trPtXpWmKP1fEIscPtMPt//
         cq5COK4lRAfCjzHSefRA2lsWAuKO8SG5Nw7BnGtcbzfi/CoTZL6VB27Df0xc6gsy99mJ
         k6eSzOCQFJU8iHntSoFe/b7lb5jZDheQ3tpM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754384939; x=1754989739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig3ejo4wL4oEVtv/WkueYSUf7qCSryypCGes3HapAjU=;
        b=OcPyfiR7AN8k82rjooHj1CJeM8Y57hAFywpOyB0t+O4EdaWXJMt4SPKzvLfnX5KK+H
         Ld9KjE/b3Ir/16WaYIx8/Ext+InARUNxPuV0lbOAr6GvUlyiXcryOkBl/s3JkqkA6JlY
         OngYXg/a6c/Ff+f4Sagid9wGAUaqVO0Y2t++ijX+/tQfphwEbYtYbtV/A1pHCn3S9Fxl
         yMjU3bqR2aobyXZu+EfmnJ+DuP0NDVBGoqNRxEPpuLHeApNCCIUcXV0V5zqmpma3+pfR
         s4ijZXuBYWZaXtsvqwaiEtRiliCGk0t5dj12IaVVbuq3dDPod3HZpoS9aO2ML0V18YNo
         m21w==
X-Forwarded-Encrypted: i=1; AJvYcCXDCK5gTpi2i033AyQt1WxISijYIMS55mNlEI7KI+y+RiA+IpkaLiNUKa/jMtPpvbGGMPVAT1DjThS51R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyS/rbf4baS1LccUevHzza0/9maFdiDdt4yWEMiVPrH7gccj0+
	MCVxpdBMPeX2/RCdDJQZK9xAn4m9QCsyVdEAdWtLxmwyOUY9uYzIOOMfX6Z0GZxadsM56fcTl4L
	DkQg=
X-Gm-Gg: ASbGncubdBDDGmQJ5RPIC24O035ERSi6IqWat2Z5rfDNKFk9rJDX6OUZIE1H3qr3XYv
	pX2jUhJB8i6NycS0MGHVs9uGAWA+Q5bXN/8VMiyZYl/qlENtR3p/ueWubX/0vEslfne9F5Ec/Ob
	WKzEMh9DbAoDgoI6etNnxcRtirL5HrnyeTzvO979/PiDPmcMjXnnqKkav9FRR9QYO59r7ixRV6r
	gKu4U6y1/JsE+5vTrQz7SD0ZT/7MRueAh589KTLfVNJ8Wzd1t7jjuyo929YFA8QcCICSxlBinsJ
	hcUX3JGAGQ0dnM/rh2iJbCeDV4blAMwThi7qlWY9ubRDDgj8rYvyIz80n3kobqKjpUaw0M6ni00
	a9b8ea4Rrlx1QWgv1/un3A6I=
X-Google-Smtp-Source: AGHT+IEC0CkarFCC9tbObUgl96lF1pEq0czMe/WEVpF3KDzV5+OA8lKXxlxpIlMyZQd9QbqWO8ckzw==
X-Received: by 2002:a17:90b:3ec8:b0:31e:f3b7:49c6 with SMTP id 98e67ed59e1d1-321162143d0mr18939390a91.15.1754384938585;
        Tue, 05 Aug 2025 02:08:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1688sm16690050a91.9.2025.08.05.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:08:58 -0700 (PDT)
Date: Tue, 5 Aug 2025 18:08:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <ovw53m3yjcqrp334wcrlukcsusqkhxjbkbngpgjqn35cb2ay2t@vjopd6ksszxc>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803062519.35712-1-ImanDevel@gmail.com>

On (25/08/03 02:25), Seyediman Seyedarab wrote:
> During zram_reset_device(), comp_algs[prio] is set to NULL by
> zram_destroy_comps() before being reinitialized to the default algorithm.
> A concurrent sysfs read can occur between these operations, passing NULL
> to strcmp() and causing a crash.

zram_reset_device() is called under down_write(&zram->init_lock),
while sysfs reads are called under down_read(&zram->init_lock).
zram_reset_device() doesn't release the write ->init_lock until
default_compressor is set.

I think it may make sense to make sure that show() handlers don't
release the read ->init_lock somewhere in between. I only see one
that does so: recomp_algorithm_show().

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8acad3cc6e6e..ee3aa9cc8595 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1228,13 +1228,7 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio,
 				     char *buf, ssize_t at)
 {
-	ssize_t sz;
-
-	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[prio], buf, at);
-	up_read(&zram->init_lock);
-
-	return sz;
+	return zcomp_available_show(zram->comp_algs[prio], buf, at);
 }
 
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
@@ -1387,8 +1381,12 @@ static ssize_t comp_algorithm_show(struct device *dev,
 				   char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
+	ssize_t sz;
 
-	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
+	down_read(&zram->init_lock);
+	sz = __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
+	up_read(&zram->init_lock);
+	return sz;
 }
 
 static ssize_t comp_algorithm_store(struct device *dev,
@@ -1412,6 +1410,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	ssize_t sz = 0;
 	u32 prio;
 
+	down_read(&zram->init_lock);
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
@@ -1419,7 +1418,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
 		sz += __comp_algorithm_show(zram, prio, buf, sz);
 	}
-
+	up_read(&zram->init_lock);
 	return sz;
 }
 

