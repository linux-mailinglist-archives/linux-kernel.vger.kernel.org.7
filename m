Return-Path: <linux-kernel+bounces-833199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DECBA1645
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027AD3B72DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2431E887;
	Thu, 25 Sep 2025 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt5DGaZX"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB22D027F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832974; cv=none; b=qq6u6b8C27purvgh7SWNBJBrrD6T6rsYYO36IKDzaheW4sfyO73wXlYRUrNXsREDQBQSE11zTvxVRuCAYn4B61F0yLlO1n9CuVT7nk7D99la4WKjP0ynKoIjObDfqe4nRLqU+iR82/gyPgzIWrEZsU06V/QD+NxkVSsNj9pcKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832974; c=relaxed/simple;
	bh=8V7qNMYmqmW763GV+RmYh7nchonJ2A54SiLgvLE3h+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2eMSOHnr5Vxv3U0SyKGVskHoWYjnyeVGbo/9fM4CJyrRXlCBDdEAZJ/Z6ABxqupE8TZ0mo6f3EyGNRC2TF9tGyLq8TwtJdOwDaY9XxU8dFw9DO/x28GCzNzHe9kQeQsAYEMrMfvkokcZbdQ7P4Wqp/TYA9FtcDs7zVDTf+Hgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt5DGaZX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1379515b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832972; x=1759437772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=Qt5DGaZX1F6BcVfbDeh2pgYWbxoiB66CixaTCMS1X0qJgFJ7sv9zF4P8YUbusrCkZn
         Thv1155lhm8WMqcY00/IfaUF7KErMHYwTifVuAz8O9tf4gH1zTuY4Tncl7SydHFU5nmb
         QjreD15UthJ+EsSSTEndTu8Zobpn+8R7n2ho37j6TjAp7Zu+Stwkdp71DX1ZKA8ZFzJM
         52d/eKyXP7MWiCg2/fcq0bS2XsD0NmQBxyE5chwrvlPLretPVq67UxFAtBnvAcaSSD9z
         8q1jcnFPhpdBP8V1JMqmbmeVGu59A1ZjM77q8njJh/tieoOI0JCotccjAIibQEv9vamm
         P1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832972; x=1759437772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=b/L1AoA1ef1unQPcxHZI8qVhvmF6KWYB+cYnA+BqcgyvPnFR2aKQlvcyp01YuNFzGr
         UkEhZMLq2Kk98GvfofmuUBBYOHjJ5hDfCT3TDgEQS/sG4kHoWrQIIb8IKNO7kQW6etVT
         phif1MopmH1TVe34c42KR23RCUY6twe61c7s4Nde35Zep3UkUJFUc4avfxmzQsxSD48f
         ETmd/LaYcln93QrGoAGcxqCNtEPMQc619oH2TUCd5DzXCSGnFQWHzD0w8c7jOIaQQ0Bt
         yWFVc+kxDVkJdwxnS8u0Z6ofQdjdV37+nSampAmlmhE5M6b4YSqg4DNyu20LgJ44Y0+x
         +GlA==
X-Forwarded-Encrypted: i=1; AJvYcCVDTCob2/afOmbpK4cWRwdqTP9RvDpy+Obd/2Gb2Vin8Ez/iTt6ZyzG10OPpmx/GWA+svkgbaFrsPeBDnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDjZfJVSFK9A+kFm7zSnBlGuZfagC+C7jhnNeSleAg+G3FMzPu
	QflYABlJ/8QNaAB09fRsBWnt26R4zILsYbnbY7BE1bj1z+6Ks+58nLz6
X-Gm-Gg: ASbGncsnsNQDMlFObI94v7D9kLyG4bnBSrVQfZXA9GOmGUjGUtVvQnY25YLyoRYh6FC
	B4iC+q9aynXYJJ0zw/aySLoZ1jLMs7jwXWJM4stD0eJSnVj2vc/NDU7mpOB7C0HItr/nbIqmy8a
	EE7kmQq4nPc1k/C0y5nRx+QQUPQEtr3K2IAhz5bxFwvTAdiXwYv//CqJD0xmaml0wmbXjA3EMh7
	2UVG3hDDKhIDTV1NymX9PIzSQbSD9W5DH6+4KTt+HiBNLQdfXRtRWw93dUpyENxfR7re3ApMDoz
	Q5Iosf8MGoxGOIEgrHfCaJ3q+bceTyBfkE+SFQV6G35HULXwZD78yScGQrREVre2UD4uVFVVou+
	SwBmswv4Q5KDpzNhKDobSv0tkyzTBB2MrBQsmiv/vGtvgPQzvbw==
X-Google-Smtp-Source: AGHT+IHo+8YH1s6Kn9VIM6VMYyZ/zlt5SgSlU/3nbxh+7PNrXmK56rGw/QyVJYd5VmMl+Z4GFCp5WA==
X-Received: by 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr3840217b3a.10.1758832971587;
        Thu, 25 Sep 2025 13:42:51 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06b0dsm2618843b3a.82.2025.09.25.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:42:51 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pwn9uin@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: [PATCH] Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
Date: Fri, 26 Sep 2025 02:10:28 +0530
Message-ID: <20250925204028.232320-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a warning at `add_timer`, which is called from the
`atm_mpoa_mpoad_attach` function

The reason for this warning is that in the allocation failure by `alloc_mpc`,
there is lack of proper cleanup. And in the event that ATMMPC_CTRL ioctl is
called on to again, it will lead to the attempt of starting an already 
started timer from the previous ioctl call

Do a `timer_delete` before returning from the `alloc_mpc` failure

Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 net/atm/mpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..cd3295c3c480 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -814,7 +814,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		dprintk("allocating new mpc for itf %d\n", arg);
 		mpc = alloc_mpc();
 		if (mpc == NULL)
+		{
+			timer_delete(&mpc_timer);
 			return -ENOMEM;
+		}
 		mpc->dev_num = arg;
 		mpc->dev = find_lec_by_itfnum(arg);
 					/* NULL if there was no lec */
-- 
2.51.0


