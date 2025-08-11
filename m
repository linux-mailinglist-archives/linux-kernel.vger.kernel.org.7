Return-Path: <linux-kernel+bounces-761706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BDB1FD95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3787C177749
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B71E8338;
	Mon, 11 Aug 2025 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmKQoG4n"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DB3D76;
	Mon, 11 Aug 2025 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754877902; cv=none; b=LKUht1SCSaE3gZOp26JlyxOef7jiipKKLnjJovhvR/kIAv1V+gjTpZBu59cx7fMQr20rEgUi0OgD6XSL1HIexbh9C1GA0ny5/DhgXrS9zIHl0Yd17KDc+dBm9+Q5CbNgPh5LQve5DQQH121ps4HLWUvSDXYho/5D5+5RTci9jkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754877902; c=relaxed/simple;
	bh=PhaqC8NRCbyHOHCMDlkqXuH81lAXFTGjjTPohLIizI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rm8UHrZfrFRpn44LYkfT/BFMs+pkRobuxVE37vmvso3j5wViELRnrd39lKvs0vqTV60o8/vmhBEVw6Phm6MhEuquOUJLbilxvi9vJ8YL3F1rEuOHEuS5YL2DMOM5E//oa17w/DXrvK+uG+arLD6hZb3rbEzL7UZBy8VOcaeVaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmKQoG4n; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2400f746440so32030575ad.2;
        Sun, 10 Aug 2025 19:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754877900; x=1755482700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1WTy2isOE4fp7XWDsnEZonDGJ241/fId695HeJpYWE=;
        b=CmKQoG4nv4TSDvswDqdIbzGZuJfXtjq/xQI7qoIMcoFyt8M7yejWDtBiAWp8raZOPx
         WDnvCVgUnyb2sW8SzNk4fpC2bM0RZT0Q+JYKjvn9p/D+tkOCVCGcd1fFRmgp6jQEH/0L
         S3MkYg60DP7A44eegwMbv/KhhxdcpF2QxiPU7gLp0YNSuTTVl3K5o+5vjcOZa9poZanW
         t1mFthowb/petHLgBssmeDIbqoWRToD/guuae6RhYEdG36JZa8ECoTjfxO+DXSMYntcZ
         o+ziP85tcIXOHITBjH9wJnlk56RJrKl+d6v4ESGUVHLf4R5blsW+CKtwy3aHU3welzfp
         ahXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754877900; x=1755482700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1WTy2isOE4fp7XWDsnEZonDGJ241/fId695HeJpYWE=;
        b=nqs0oFqeAf9yZsQwYY8kznKEj4b/iAJ3OerO35HKAFocECVu6aNQBreAY8bOoKFTg/
         ZxRl577rMKR2pOfHlXKf1HqXtaieJRQnzZzl55L0MhL/1DhPFWvS/EqLFQNU55hvJuiL
         1+mnH/U8AyG7BehK0sGR7F9u5ZxkAya5NaixHVYZAHmrGz13uHO8cawMyaHOn6cka3Kv
         3RKsqQIc5JWf14rRNQBaPmFpMNgw94N2L071divGe2LZ40tJAObLnPmGkNk7nz2bgmWo
         9P81I7duVRoTRpBbtUMP9AZ2omMzGuQa4tm4ly3xRTDhfWzJ1d082te6lEO3XOkK2U/T
         7M8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFL3uAEunkSpPtho8SqNGfU3n69y6pQsDXnZcur3q5+wcLI1WY7/03l85eOQsfGoR9os32BfWk0Ygasuj1GVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8m9/Wevz6/VP+PqNHrp3ji1AF3lrAfxm9u7mb5+s99NwnRkP6
	NShJV3wJx2Roc4olamI4ua+pJKPzqEWRTi1EAh4AO4yo1XfEBoZTuTkBPMZaoa/C
X-Gm-Gg: ASbGncuxd9+Qq3L+KlJ0shv1yrdeXS9n3Eymxbw99tzFv8/lSGDCVXOZzbvj78WyGjj
	62SDBaHIjgi9p9ky8Eg41f4M9k//52sFKnPTTDz6tmgRENPo2POAwdWRKEJu4Zlkh+Cj2C9GerO
	dHdyM3oXdg0vlJydRthpF+19sB7tzN3EdbMwBMw2NbSN3vAvvY8OWaMQmL+wuCWDBguVJqUj/qz
	3yMR+mtOsfvD3DAG9Bn4dJqdXFs4te7M+tAac5ppi0Wu1HZLRXPlKSJwnEyPzSg9K2qtOW+QfFa
	g3cOKAEZb7aZ5LpCfqVio84LjqezQN6eflnbojdgdqFuAnZ8/qQytRAZUSYr49d0ZSAicjYZFb3
	PCFOAKAudsYskoI2y/CAryg==
X-Google-Smtp-Source: AGHT+IH1ACr36yKambSpbyYhY36pgYGnTfK1eKS5IYigIEpCH+NtxISVLUAtiXfjfbDdMG+PJtXhXA==
X-Received: by 2002:a17:903:22ce:b0:240:a8c8:5f6f with SMTP id d9443c01a7336-242c22a0c4dmr148173225ad.27.1754877900080;
        Sun, 10 Aug 2025 19:05:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67f3sm259759875ad.33.2025.08.10.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:04:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AA775423F8CF; Mon, 11 Aug 2025 09:04:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Lee Jones <lee@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Mao Zhu <zhumao001@208suo.com>
Subject: [PATCH] pcmcia: ds: Emphasize "really" epizeuxis
Date: Mon, 11 Aug 2025 09:04:37 +0700
Message-ID: <20250811020436.13486-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=bagasdotme@gmail.com; h=from:subject; bh=PhaqC8NRCbyHOHCMDlkqXuH81lAXFTGjjTPohLIizI8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkz/bKb63Y/rpx5xks03OvxFK8CP9l90eYSLqc7DBYf+ yeiHuHXUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlo1DL84V79p1C8lG9z+IcV Brcb1utm8O6PYtPMjJ7PvLCG9VPTLIbfLBf2iQtcs3W4WH9Cf89u+YcHa40Z8s+JOiqeZF8ZxXy JEwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

pcmcia_dev_present() comment writes about small timeframe where
the function returns NULL (racy condition), in epizeuxis device. In the
past, it tripped contributors who misunderstood it for "really"
duplicate ([1], [2]).

Add comma between "really" words to emphasize the epizeuxis.

Link: https://lore.kernel.org/all/YxT1As38WRZcyH0%2F@shine.dominikbrodowski.net/ [1]
Link: https://lore.kernel.org/all/20220831083623.GA25639@isilmar-4.linta.de/ [2]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/pcmcia/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index da6f66f357cc10..18f4eef28dbc5d 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1308,7 +1308,7 @@ static int pcmcia_bus_early_resume(struct pcmcia_socket *skt)
  * physically present, even if the call to this function returns
  * non-NULL. Furthermore, the device driver most likely is unbound
  * almost immediately, so the timeframe where pcmcia_dev_present
- * returns NULL is probably really really small.
+ * returns NULL is probably really, really small.
  */
 struct pcmcia_device *pcmcia_dev_present(struct pcmcia_device *_p_dev)
 {

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
An old man doll... just what I always wanted! - Clara


