Return-Path: <linux-kernel+bounces-752432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB3B17586
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707A21AA7AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21023F27B;
	Thu, 31 Jul 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgAyfqyv"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AB78C91
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982287; cv=none; b=QPyPdY4a5ewpxHE6sV+bAfNh0ISnYrK5LdhH6nnZ8Jo2LRvFqiQZR5yU9AxnH8Bs9cVs1Z1HFtyp1OvO9T40me3LtZitfTgC9Qe4AUMyZjU7rH6z/bp0SvTZwUAWMWQUTaYLGmEF+ujef+tezrc6I5S3xkiBubv/VFZg3LAOQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982287; c=relaxed/simple;
	bh=c7+KTXSLsIjn3LukR2oeNJJeD7AqwXW7nf38mkb3ADY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVhtDAZHzeA/6jzuwXUO4f5a2YZxapRWhmFs84Kc16yYx+umku/9NiMH+1UjuHglHk9EMnqp6LVBQgTfjnWVwgVzTtcNzg/V3yfsBjeOGpsNXTyKWc84jR4wuXim2Q8jMbf2NnElzU8zWkzJaYs7ZJtvr53kXEyON0PAlTnNqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgAyfqyv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2403ceef461so12237925ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753982286; x=1754587086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGiKekAlWbPYZ8fEOwzRaM2Ec4ek+GjAPRM2QTv42u0=;
        b=NgAyfqyvrV9DeTyZWLkONRi2QX1dxwF0giDaVDidoKfH/AYqlf9LnTLDEAcpKZOb2F
         V8m7DR1DDOT3+nT4snPjMtSVCFzohBiJYT4w25LHe+MLKfd4OTC8v4cweps79YiN1Ozr
         SoiYD3JQ5cChV0TlPJE5VciOoKJ9x34o2B1upPinH+LD5Vt/ee7+FVw/njakMdfWivDM
         CXI1y+gcI63mp+vnoq32j9P5j5mzaITMDaITJ4XwYlJotNx9+ihDMubKUXe8bE/QY7xJ
         EkXXIP47DenJ9uGehMGXdNhmRirdnDPaXtYlSO2jVZWCUzPEv4/+Ga8I7Mrdsevj/yg7
         2nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982286; x=1754587086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGiKekAlWbPYZ8fEOwzRaM2Ec4ek+GjAPRM2QTv42u0=;
        b=ZasZuyPf7EmxQXbFA8qzzW0mgkweIA97hkUXpGZrOtuA4we2ULzLSIyFfnYFB4M6RL
         i6WOJYA/91Bvu2NIL2pqGj2nGDmIeJs88EGHjPe0AUuZ4tzOVYRR8r9OMdygr+S2A/vj
         0Utq5ZnnAo1b/J5+1KwiGnr1WPI3fj2Lf1wY2aCXaykRqLJKxXYymL1l0uHrp38UNg8C
         /9G2I5hUD7RvX+At4dPC+DWEOtABXhG4CCYubejkuoJXbfLoic2VDwxgFCy56ENzLL1x
         8udTMJVsjwFkTRc7mSYfePE62vpBmEaKmAvZNsDnTjw3vO/LdK7Se6JEjptpWKCaAd4W
         TBWg==
X-Gm-Message-State: AOJu0YztIO6RTo4E5rwtvobU+NM0wtCU5QOu5LqvaNRdtGR+aQ28qCOz
	LcOvP7RuuJtNtKWSXz0vcIrhV4fppEP3licRywArGKn1ydMWzNKVRmh/
X-Gm-Gg: ASbGncuSwTDWMj0MWPlEdClnpfGN0sIOk69zQTMqf4Xyc2dOTIKSGiJxjlKgy+bUu3v
	5myN/0tF+6hpPlOWZaoVvWtBA9wEXMmg9WKF1cjUGso4/SerBEHHwcO+Ly9+au9ayjZkPWpfW8z
	tVcj2f0QbykDPe10oNpDEAO5Mt/obdSzR3ejojUYjrGCn6IQJhXSYWGvkPGqyMaDM5VKWPtTBBJ
	RnteoC0JIi8ejGKF+Shal7MPzo4V1SS8nq3P3+u4oHGu91K1p4bbDfd5pnIg5l6SLzD2sqajDDD
	W4tmEVuUj+uq/6vUQGct4b9WGwhj6RSUum/Ft+MYJxbdIgEJxBipTwXwlB29Cg8Wk0E+/lza5bg
	SwkTSXhCelEtQbCqLAsdwZuRnbLFmPdahNJg2hzZI4w0cDqkZlewclKDr2ETm3Tedtu4yzKICaf
	iU/SGx
X-Google-Smtp-Source: AGHT+IHhOXlvAvvbVX9q5wSb6L5hsOPGSp0od6M0SzyoYxXXzzIav5sVToXumLBhIng1OhXUMtt0BQ==
X-Received: by 2002:a17:902:fc4f:b0:240:2610:a057 with SMTP id d9443c01a7336-240969b9926mr113294225ad.0.1753982285636;
        Thu, 31 Jul 2025 10:18:05 -0700 (PDT)
Received: from p920.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm22667275ad.60.2025.07.31.10.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:18:05 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk,
	hdanton@sina.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
Date: Thu, 31 Jul 2025 10:17:29 -0700
Message-ID: <20250731171729.46432-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main


Thanks for the review and valuable feedback.

Upon investigation, I found the crash occurs when the netdev's debugfs
directory is removed while a station still holds a pointer
(sta->debugfs_dir) to a dentry within it. A subsequent call to
ieee80211_sta_debugfs_remove() may then dereference a freed dentry,
triggering a use-after-free.

To address this, I’m preparing a patch that clears sta->debugfs_dir for
all stations associated with the interface before calling
debugfs_remove_recursive(). This ensures any later station removal
becomes a no-op and avoids referencing a stale pointer.

This reply is intended for syz testing and to provide context for
review. A formal patch will follow.

Many thanks to Hillf Danton and Al Viro for their insights.

---
 net/mac80211/debugfs_netdev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 1dac78271045..4d45bb4fe380 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -1015,9 +1015,24 @@ static void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 {
+	struct sta_info *sta;
+
 	if (!sdata->vif.debugfs_dir)
 		return;
 
+	/*
+	 * Before we delete the netdev’s debugfs tree, clear sta->debugfs_dir
+	 * for every station on this interface.  This ensures any later call to
+	 * ieee80211_sta_debugfs_remove() sees NULL and avoids touching a dentry
+	 * that we are about to free.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
+		if (sta->sdata == sdata)
+			sta->debugfs_dir = NULL;
+	}
+	rcu_read_unlock();
+
 	debugfs_remove_recursive(sdata->vif.debugfs_dir);
 	sdata->vif.debugfs_dir = NULL;
 	sdata->debugfs.subdir_stations = NULL;
-- 
2.43.0


